require_relative 'companyAggregate'
require_relative 'commands'
require_relative 'events'

class CompanyCommandHandler < Sequent::Core::BaseCommandHandler
  def handles_message?(command)
    command.is_a? CreateCompanyCommand
  end

  on CreateCompanyCommand do |command|
    repository.add_aggregate CompanyAggregate.new(
      command.aggregate_id,
      command.name,
      command.cvr,
      command.address,
      command.city,
      command.country,
      command.phone
    )
  end

end