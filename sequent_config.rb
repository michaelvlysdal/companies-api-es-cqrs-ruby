require_relative 'companies/records'
require_relative 'companies/event_handlers'
require_relative 'companies/command_handlers'
require 'sequent'

Sequent.configure do |config|
  ### App configurations

  # Command handler classes
  config.command_handlers = [CompanyCommandHandler.new]

  # Optional filters, can be used to do for instance security checks.
  config.command_filters = []

  # Event handler classes
  config.event_handlers = [CompanyRecordEventHandler.new, CompanyListRecordEventHandler.new]


  #### Configured by default but can be overridden:

  # config.event_store
  # config.command_service
  # config.record_class

  # How to handle transactions
  config.transaction_provider = Sequent::Core::Transactions::ActiveRecordTransactionProvider.new
end