class PrincipalDetail < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name "PRINCIPAL_MASTER"
 
 
   alias_attribute :id , :SEQ_NUM

  attr_accessible :principal_name ,:principal_code , :id

  def self.get_details()
     details = Array.new
          branch_name = PrincipalDetail.find(:all,:order => "principal_name ASC")
          branch_name.each do |val|
              hash = Hash.new
              hash["name"] = val.principal_name
              hash["id"] = val.id
              
              details << hash
            
          end 
      return details
  end
  
  
  def self.get_principal_id_using_brand(brand_id)
      
      brand_details = BrandDetail.find(:first ,:conditions => {:SEQ_NUM => brand_id})
      if (brand_details)
          principal_code = brand_details.principal
          principal_name = PrincipalDetail.find(:first, :conditions => {:principal_code => principal_code})
          return principal_name.id

      end          
      return ""
  end
  
  
   def self.get_brand_using_principal(principal_id)
           details = Array.new

       principal_details = PrincipalDetail.find(:first, :conditions => {:SEQ_NUM => principal_id})

      if (principal_details)
          principal_code = principal_details.principal_code
           brand_details = BrandDetail.find(:all ,:conditions => {:principal => principal_code})
           
             brand_details.each do |val|
              hash = Hash.new
              hash["name"] = val.name
              hash["principal_id"] = val.principal
              hash["id"] = val.id
              
              details << hash
            
          end 
          return details

      end          
      return []
  end
  
end
