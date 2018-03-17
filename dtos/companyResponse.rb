require 'json'

class CompanyResponse
  attr_accessor :id, :name, :cvr, :address, :city, :country, :phone
  
  def initialize(id, name, cvr, address, city, country, phone)
    @id = id
    @name = name
    @cvr = cvr
    @address = address
    @city = city
    @country = country
    @phone = phone
  end

  def as_json(options={})
    {
      id: @id,
      name: @name,
      cvr: @cvr,
      address: @address,
      city: @city,
      country: @country,
      phone: @phone
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end