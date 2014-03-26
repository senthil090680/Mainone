class ImageEmpRatingReview < ActiveRecord::Base
  attr_accessible :image_id , :employee_code , :rating , :review, :branch_code ,:company_code
  before_create :set_created_at
  before_save :set_updated_at
  
  
   # ************************ get rating details **************************************       
  def self.get_rating_details(image_id,emp_id)
    
    details = ImageEmpRatingReview.find(:first ,:conditions => {:image_id => image_id,:employee_code =>  emp_id})
    return details
  end
  
   # ************************ Add new rating **************************************       
  def self.add_rating_details(image_id,emp_id,rating,review)
   
    
    details = ImageEmpRatingReview.new(:image_id => image_id,:employee_code => emp_id,:rating => rating, :review => review)
    details.save
    
    average_rating(image_id)      
    
    return details
  end
  
   # ************************ update old rating **************************************       
  def self.updating_rating_details(image_id,emp_id,rating,review)
    
       where(:image_id => image_id,:employee_code => emp_id).update_all({:rating => rating,:review => review, :updated_at => ProjectBase.to_local_time(1,ProjectBase.get_gmt(),nil)})   
     
      average_rating(image_id)      
  end
  
   # ************************  Average Image Rating  **************************************       
  def self.average_rating(image_id)
    
     sql =""
      s = ""
      
    sql << "select ROUND(AVG(rating)) as rating from image_emp_rating_reviews where image_id = '"+image_id.to_s+"'"
      s = ImageEmpRatingReview.find_by_sql(sql)
      UploadedImage.updating_rating_details1(image_id,s[0].rating);
    
  end
  
   # ************************    **************************************       
   def self.validates_uniqueness(image_id,emp_id)
     rating_count =ImageEmpRatingReview.count(:conditions => {:image_id => image_id,:employee_code => emp_id})
     if (rating_count.to_i > 0) 
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
