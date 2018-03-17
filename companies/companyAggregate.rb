require 'sequent'
require_relative 'events'

class CompanyAggregate < Sequent::Core::AggregateRoot
  attr_reader :name, :cvr, :address, :city, :country, :phone
  
  def initialize(id, name, cvr, address, city, country, phone)
    super(id)
    raise ArgumentError.new('name can not be nil') unless name
    @name = name
    @cvr = cvr
    @address = address
    @city = city
    @country = country
    @phone = phone

    apply CompanyCreatedEvent
  end

  def load_from_history(stream, events)
    raise "Empty history" if events.empty?
    @name = events.first.name
    @cvr = events.first.cvr
    @address = events.first.address
    @city = events.first.city
    @country = events.first.country
    @phone = events.first.phone
    super
  end

  protected
  def build_event(event, params = {})
    super(event, params.merge({
      name: @name,
      cvr: @cvr,
      address: @address,
      city: @city,
      country: @country,
      phone: @phone
      }))
  end
end
