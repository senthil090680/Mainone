class ImagesMultiBrand < ActiveRecord::Base
  attr_accessible :images_id, :brand_id ,:brand_type_id,:principal_id,:employee_auth_code
   before_create :set_created_at
  before_save :set_updated_at
  
  
  
    # ************************ update old rating **************************************       
  def self.updating_tag_details(tag_id,emp_id,brand_id,brand_type_id,principal_id)
    
       where(:id => tag_id).update_all({:employee_auth_code => emp_id,:brand_id => brand_id,:brand_type_id => brand_type_id,:principal_id => principal_id, :updated_at => ProjectBase.to_local_time(1,ProjectBase.get_gmt(),nil)})   
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
