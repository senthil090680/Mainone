class SaveFilter < ActiveRecord::Base
  attr_accessible :employee_code,:filter_name, :type_id , :brand_id , :search_emp_id , :principal_id ,:rating
  before_create :set_created_at
  before_save :set_updated_at
  
  
  
   # ************************ get rating details **************************************       
  def self.get_filter_details(emp_id)
    
    details = SaveFilter.find(:all ,:conditions => {:employee_code =>  emp_id})
    return details
  end
  
   # ************************ Add new rating **************************************       
  def self.add_filter_details(emp_id,type_id,brand_id,search_emp_id,principal_id,filter_name,rating)
    
    details = SaveFilter.new(:employee_code => emp_id, :filter_name=> filter_name, :type_id => type_id, :brand_id => brand_id, :search_emp_id => search_emp_id, :principal_id =>principal_id,:rating => rating)
    details.save
    return details
  end
  
   # # ************************ update old rating **************************************       
  # def self.updating_filter_details(image_id,emp_id,rating,review)
       # where(:image_id => image_id,:employee_id => emp_id).update_all({:rating => rating,:review => review, :updated_at => ProjectBase.to_local_time(1,ProjectBase.get_gmt(),nil)})   
  # end
#   
  
   # ************************    **************************************       
   def self.validates_uniqueness(emp_id,type_id,brand_id,search_emp_id,principal_id,rating)
     filter_count =SaveFilter.count(:conditions => {:employee_code => emp_id,:type_id => type_id, :brand_id => brand_id, :search_emp_id => search_emp_id, :principal_id =>principal_id,:rating => rating})
     if (filter_count.to_i > 0) 
        return false
     else
        return true
     end
    end
  
  # ************************  name validate  **************************************       
   def self.validates_filter_name(emp_id,name)
     filter_count =SaveFilter.count(:conditions => {:employee_code => emp_id, :filter_name =>name})
     if (filter_count.to_i > 0) 
        return false
     else
        return true
     end
    end
  
  
  
  # set created date
    def set_created_at
      created_at = ProjectBase.get_gmt
    end
    
    # set updated at
    def set_updated_at
      uodated_at = ProjectBase.get_gmt
    end
end
