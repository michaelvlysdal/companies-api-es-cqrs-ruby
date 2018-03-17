require 'sinatra'
require 'sinatra/namespace'
require 'sequent'
require 'pg'
require 'uri'
require_relative 'companies_app'
require_relative 'dtos/companyListResponse'
require_relative 'dtos/companyResponse'
require_relative 'companies/commands'
require_relative 'companies/event_handlers'
require_relative 'companies/command_handlers'

after do
  ActiveRecord::Base.clear_active_connections!
end

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
  also_reload File.expand_path("**/*.rb", __FILE__)
  dont_reload File.expand_path("db/**/*.rb", __FILE__)
end

before do
  content_type 'application/json'
end

namespace '/api/v1' do

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end
  end

  get '/companies' do
    companies = Array.new
    uri = URI.parse(ENV['DATABASE_URL'])
    conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    res = conn.exec('select * from view_1.company_list_records;')
    res.each do |row|
      companies.push CompanyListResponse.new(row['aggregate_id'], row['name'])
    end
    companies.to_json
  end

  get '/companies/:id' do |id|
    companies = Array.new
    uri = URI.parse(ENV['DATABASE_URL'])
    conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

    res = conn.exec('select * from view_1.company_records where aggregate_id=$1;', [id])
    firstRow = res.values[0]
    halt 404, { message: 'Company not found' }.to_json unless firstRow
    # There must be a better way :/
    CompanyResponse.new(firstRow[1], firstRow[2], firstRow[3], firstRow[4], firstRow[5], firstRow[6], firstRow[7]).to_json
  end

  post '/companies' do
    input = json_params
    @command = CreateCompanyCommand.new(
      aggregate_id: Sequent.new_uuid,
      name: input['name'],
      cvr: input['cvr'],
      address: input['address'],
      city: input['city'],
      country: input['country'],
      phone: input['phone'])

    begin
      Sequent.command_service.execute_commands @command
      response.headers['Location'] = "#{base_url}/api/v1/companies/#{@command.aggregate_id}"
      status 201
    rescue Sequent::Core::CommandNotValid
      halt 400, { message: 'Command not valid' }.to_json
    end

  end
end
