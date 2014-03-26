class BrandDetail < ActiveRecord::Base
 
  set_table_name "BRAND_MASTER"
 
  alias_attribute :name , :brand_name
  alias_attribute :id , :SEQ_NUM
  
  attr_accessible :name ,:description ,:brand_code ,:principal
  
  def self.get_details()
     details = Array.new
     sql= ""
 		branch_name = BrandDetail.find(:all,:order => "brand_name ASC")
           # sql = "select DISTINCT(brand_name) as name,principal,SEQ_NUM as id from BRAND_MASTER ORDER BY brand_name ASC"
#         	branch_name = UploadedImage.find_by_sql(sql) 

          branch_name.each do |val|
              hash = Hash.new
              hash["name"] = val.name
              hash["principal_id"] = val.principal
              hash["id"] = val.id
              
              details << hash
            
          end 
      return details
  end
end
