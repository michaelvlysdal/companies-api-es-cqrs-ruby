require_relative '../companies_app'

Sequent::Support::ViewSchema.define(view_projection: CompaniesApp::VIEW_PROJECTION) do
  create_table :company_records, :force => true do |t|
    t.string :aggregate_id, :null => false
    t.string :name, :null => false
    t.string :cvr
    t.string :address
    t.string :city
    t.string :country
    t.string :phone
  end

  add_index :company_records, ["aggregate_id"], :name => "unique_aggregate_id_for_company", :unique => true

  create_table :company_list_records, :force => true do |t|
    t.string :aggregate_id, :null => false
    t.string :name
  end

  add_index :company_list_records, ["aggregate_id"], :name => "unique_aggregate_id_for_company_list", :unique => true
  
end