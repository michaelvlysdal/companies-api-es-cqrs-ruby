require 'sequent'

class CreateCompanyCommand < Sequent::Core::Command
  attrs name: String, cvr: String, address: String, city: String, country: String, phone: String
  validates_presence_of :name
end