class ImageEmpRatingReviewsController < ApplicationController
 
 # ************************************    SET RATING    ************************************
 def set_rating
   image_id = params['image_id']
   emp_id = params['emp_id']
   review = params['review']
   rating = params['rating']
   
     if image_id.present? && emp_id.present?
       
        emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => emp_id })
        
        if emolpyee_code.present?
                
            emp_id = emolpyee_code.employee_code
            details = ImageEmpRatingReview.validates_uniqueness(image_id,emp_id)
              
              if(details)
                ImageEmpRatingReview.add_rating_details(image_id,emp_id,rating,review)
                  json = {"success" => 1, "message" => "added successfully"}
              else
                ImageEmpRatingReview.updating_rating_details(image_id,emp_id,rating,review)
                  json = {"success" => 1, "message" => "updated successfully"}
              end
       else
           json = {"success" => 2, "message" => "logout"}
      end
     else
               json = {"success" => 0, "message" => "Please refresh this page"}
     end
 
         render :json => json
   
 end
 
 
 # ************************************    GET RATING   ************************************
 def get_rating
   image_id = params['image_id']
   emp_id = params['emp_id']
   
     if image_id.present? && emp_id.present?
       
        emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => emp_id })
        
        if emolpyee_code.present?

           emp_id = emolpyee_code.employee_code
        
          details = ImageEmpRatingReview.validates_uniqueness(image_id,emp_id)
            
            if(!details)
              
         
                 details1 = ImageEmpRatingReview.get_rating_details(image_id,emp_id)
             
                hash = Hash.new
                hash["rating"] = details1.rating
                hash["review"] = details1.review
               
                 json = {"success" => 1, "message" => hash}
           else
                  hash = Hash.new
                hash["rating"] = 0
                hash["review"] = ""
                 json = {"success" => 1, "message" => hash}
           end 
       else
           json = {"success" => 2, "message" => "logout"}
       end     
     else
               json = {"success" => 0, "message" => "Please refresh this page"}
     end
 
         render :json => json
 end
 
 
end
