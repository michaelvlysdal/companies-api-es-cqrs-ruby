require_relative 'events'
require_relative 'records'

class CompanyRecordEventHandler < Sequent::Core::BaseEventHandler

  on CompanyCreatedEvent do |event|
    create_record(
      CompanyRecord,
      aggregate_id: event.aggregate_id,
      name: event.name,
      cvr: event.cvr,
      address: event.address,
      city: event.city,
      country: event.country,
      phone: event.phone
    )
  end
end

class CompanyListRecordEventHandler < Sequent::Core::BaseEventHandler

  on CompanyCreatedEvent do |event|
    create_record(
      CompanyListRecord,
      aggregate_id: event.aggregate_id,
      name: event.name
    )
  end
end