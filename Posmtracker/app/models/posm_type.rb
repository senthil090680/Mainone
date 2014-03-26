class PosmType < ActiveRecord::Base

set_table_name "PRODUCT_MASTER"
 
  attr_accessible :product_code, :product_name , :brand , :type , :portal_flag
 
 
 
  def self.posm_all_types()
    
    sql = "select seq_num,product_name as name from PRODUCT_MASTER where type = 'POSM' and product_name is not null and seq_num is not null order by product_name"
    s = PosmType.find_by_sql(sql) 
   return s
  end
  
  
 def self.get_particular_brand_posm(id)
   
   s = ""

   brand_code = BrandDetail.find(:first,:conditions => {:seq_num => id})
   
   if (brand_code)
    	s1 = Array.new
      sql = "select seq_num as id1,product_name as name from PRODUCT_MASTER where type = 'POSM' and brand ='"+brand_code.brand_name+"' order by brand"
      s = PosmType.find_by_sql(sql) 
       s.each do |val|
      		hash =  Hash.new
      
      		hash["id"] = val["id1"]
      		hash["name"] = val["name"]
      
      		s1 << hash        
      end
      
    end  
  return s1
  
  
  
  
   
 end
  

end
