require "bundler"
Bundler.setup

def current_env
  ENV["RACK_ENV"] ||= "development"
end

begin
  require 'sequent/rake/tasks'
  require_relative 'companies_app'
  Sequent::Rake::Tasks.new({
    db_config_supplier: CompaniesApp::DB_CONFIG,
    view_projection: CompaniesApp::VIEW_PROJECTION,
    event_store_schema: 'event_store',
    environment: ENV['RACK_ENV'] || 'development'
  }).register!
rescue LoadError
  puts 'Sequent tasks are not available'
end