class CompanyDetail < ActiveRecord::Base
  
   set_table_name "COMPANY_MASTER"
  
  alias_attribute :name, :company_name
  
  
  attr_accessible :company_code, :name 
end
