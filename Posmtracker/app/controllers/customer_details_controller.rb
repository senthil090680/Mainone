class CustomerDetailsController < ApplicationController
  
  def auto_suggest
  
  arr =Array.new
    search_text = params['search']
    
    if search_text.present?
      
      customer = CustomerDetail.where("customer_name like ?","#{search_text}#{'%'}")
      
      customer.each do |every_customer|
        
        hash = Hash.new
        
        hash['customer_name'] = every_customer.customer_name
        hash['customer_code'] = every_customer.customer_code
        arr << hash
      end
      render :json =>arr
      
    end
  
  end 
  
end
