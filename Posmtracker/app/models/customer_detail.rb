class CustomerDetail < ActiveRecord::Base

set_table_name "CUSTOMER_MASTER"
  
    alias_attribute :address_line1, :Address_line1
  alias_attribute :address_line2, :Address_line2
  alias_attribute :address_line3, :Address_line3
  alias_attribute :lat, :GPS_latitude
  alias_attribute :lng, :GPS_longitude
  
    attr_accessible :address_line1, :address_line2 ,:address_line3 , :lat , :lng, :customer_name , :company_code , :customer_code





end
