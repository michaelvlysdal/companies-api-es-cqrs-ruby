require 'json'

class CompanyListResponse
  attr_accessor :id, :name
  
  def initialize(id, name)
    @id = id
    @name = name
  end

  def as_json(options={})
    {
      id: @id,
      name: @name
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end