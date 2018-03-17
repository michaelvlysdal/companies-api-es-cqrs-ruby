require 'sequent'
require 'sequent/support'
require 'erb'
require_relative 'companies/event_handlers'

module CompaniesApp
  VERSION = 1

  VIEW_PROJECTION = Sequent::Support::ViewProjection.new(
    name: "view",
    version: VERSION,
    definition: "db/view_schema.rb",
    event_handlers: [
      CompanyRecordEventHandler.new,
      CompanyListRecordEventHandler.new
    ]
  )
  DB_CONFIG = YAML.load(ERB.new(File.read('db/database.yml')).result)
end