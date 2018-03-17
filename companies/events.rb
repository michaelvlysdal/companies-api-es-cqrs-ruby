require 'sequent'

class CompanyCreatedEvent < Sequent::Core::Event
  attrs name: String, cvr: String, address: String, city: String, country: String, phone: String
end