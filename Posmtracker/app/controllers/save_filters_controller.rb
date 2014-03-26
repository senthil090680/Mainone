class SaveFiltersController < ApplicationController
  
   # ************************************    GET FILTERS    ************************************
  def get_filter_details
    arr= Array.new
   emp_id = params['emp_id']
   
     if emp_id.present?
        emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => emp_id })
        
       if emolpyee_code.present?

        emp_id = emolpyee_code.employee_code
       
        details = SaveFilter.get_filter_details(emp_id)
       
        details.each do |val|
         
          hash = Hash.new
              hash["id"] = val.id
              hash["type_id"] = val.type_id
              hash["brand_id"] = val.brand_id
              hash["search_emp_id"] = val.search_emp_id
              hash["principal_id"] = val.principal_id
              hash["filter_name"] = val.filter_name
              hash["rating"] = val.rating
              hash["created_at1"] = UploadedImage.date_format1((val.created_at).to_s)
         
         arr << hash
       end
        
             
         json = {"success" => 1, "message" => arr}
       else
           json = {"success" => 2, "message" => "logout"}
       end          
     else
               json = {"success" => 0, "message" => "Please refresh this page"}
     end
 
         render :json => json
    
  end
  
  
  
   # ************************************    SAVE FILTERS    ************************************
 def save_filters
   emp_id = params['emp_id']
   type_id = params['type_id']
   brand_id = params['brand_id']
   search_emp_id = params['search_emp_id']
   principal_id = params['principal_id']
   rating = params['rating']
   filter_name = params['filter_name']
   
     if emp_id.present?
          emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => emp_id })
        if emolpyee_code.present?

            emp_id = emolpyee_code.employee_code         
            details = SaveFilter.validates_uniqueness(emp_id,type_id,brand_id,search_emp_id,principal_id,rating)
            
            if(details)
              name_check = SaveFilter.validates_filter_name(emp_id,filter_name)
              if(name_check)
                SaveFilter.add_filter_details(emp_id,type_id,brand_id,search_emp_id,principal_id,filter_name,rating)
                json = {"success" => 1, "message" => "added successfully"}
              else
                json = {"success" => 0, "message" => "Filter Name Already Exists. Please Choose A Different Name"}
              end  
            else
              # ImageEmpRatingReview.updating_rating_details(image_id,emp_id,rating,review)
                json = {"success" => 0, "message" => "Filter Name Already Exists. Please Choose A Different Name"}
            end
       else
           json = {"success" => 2, "message" => emp_id}
       end        
      
     else
               json = {"success" => 0, "message" => "Please refresh this page"}
     end
 
         render :json => json
   
 end
 
 
 
#    Rough works



  def store_image
    require "base64"
      image_64 = params['data']
      image_format = params['format']
      store_path = "assets/images"
      
       if image_64.present? && image_format.present?
          
          image_data = Base64.decode64(""+image_64)
          image_name = ProjectBase.random_code(15)+"."+image_format
          # image_name = "guru.png"
          directory = File.join("app", store_path)
           path = File.join(directory, image_name)
           File.open(path, "wb") { |f| f.write(image_data) }
           
           json = {"success" => 1, "message" => "added successfully"}

       else
           json = {"success" => 0, "message" => "Sorry"}
       end
         render :json => json
    
  end 
 
 
  def create
      require "base64"
     

      image_data = Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAABkAAAAVCAYAAACzK0UYAAAA+ElEQVRIS+1W0Q2CMBRsR3AFHUFH0BF0BB1BRpARZAQ7gh3BjiAjyAj1rilJf+x7iQkxkZcQIL3jHs27AxtjXBpjjjjWOD5VjwVnrfUjALwzrrcVzoC1AE5rAX4IAuVzViD1WeBSESiXGopEJZiwHd8GlLvwFuUj/Szyx9v1xCjQK5raYLoCpuuavaXhpBGmCWmshcDoIOCIAYdY+kRqLgDTWk0r32KSCDrbC10xIhgrPKfKO1CLFcI8t5fbdcMNRaSiAGNlyE2Rp6nDFI53U4jM2fWjUf9SuH0c1fGjpR178jpOF7/vjAgpVlp4pCmMSCEpVvhPcHoDM0LGomRsZ4oAAAAASUVORK5CYII=")
    
    
      name = "random_name1.png"
      directory = "app/assets/images"
      path = File.join(directory, name)
      
      # UploadedImage.create_table(image_data)
      
      File.open(path, "wb") { |f| f.write(image_data) }
      
       thumb = Magick::Image.read(path).first
          thumb.format = "jpg"
          image_name = ProjectBase.random_code(15)

          thumb.write(directory+"/"+image_name+".jpg")
          
          File.delete(path)

          # File.open(path1, "wb") { |f| f.write(thumb) }

          
      # flash[:notice] = "File uploaded"
      # redirect_to "/upload/new"
      render :text => Rails.root + '/foo.jpg'

  end
  
  
  
  
  
end
