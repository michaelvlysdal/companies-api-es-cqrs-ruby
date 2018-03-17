ENV["RACK_ENV"] ||= "development"
require "bundler"
Bundler.setup

require 'sequent/support'
require_relative 'companies_app'
require_relative 'sequent_config'

Sequent::Support::Database.establish_connection(CompaniesApp::DB_CONFIG[ENV["RACK_ENV"]])