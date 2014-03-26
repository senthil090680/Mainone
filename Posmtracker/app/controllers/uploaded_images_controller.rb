class UploadedImagesController < ApplicationController
 
 def get_image_details
    id = params['id']

    if id.present?
         if (UploadedImage.count_checking(id) > 0) 
            image_details = UploadedImage.find(id)
            user_name = Employee.find(:first ,:conditions => {:sales_person_code => image_details.employee_code})
            image_address = UploadedImage.get_addtrss(image_details.customer_code)
            
            hash = Hash.new
            hash["name"] = user_name.name
            hash["date"] = UploadedImage.date_format((image_details.uploaded_time).to_s)
            hash["lat"] = image_details.lat
            hash["lng"] = image_details.lng
            hash["address"] = image_address
            
            json = {"success" => 1, "message" => hash}
          else
            json = {"success" => 0, "message" => "Please refresh this page"}
          end
    else
      json = {"success" => 0, "message" => "Please refresh this page"}
    end
  render :json => json
 end
  
 
 # Show customer details 
 def show_customer_details
   begin
       arr = Array.new
       customer = CustomerDetail.find(:all)
       
        customer.each do |val|
            hash = Hash.new
            
            hash['name'] = "#{val.customer_name}#{','}#{val.city}"
            hash['code'] = val.customer_code
            
            arr << hash
    
        end    
        json = {"success" => 1, "message" => arr}
    rescue 
        json = {"success" => 0, "message" => "logout"}
    end
        
      render :json => json
   
 end
 
 
#  Store uploaded images
 def store_image
     require "base64"
	require 'RMagick'
      image_64 = params['data']
      emp_id = params['code']
      customer_code = params['customer_code']
      image_date = params['image_date']
      about_text = params['about_text']
      
          image_date = UploadedImage.date_format12(image_date.to_s)

           # json = {"success" => 0, "message" => image_time11}
           # render :json => json
           # return
           
                 
       if image_64.present? && emp_id.present? && customer_code.present? && image_date.present? && about_text.present? 

          emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => emp_id })
        
        if emolpyee_code.present?
                
            emp_id = emolpyee_code.employee_code
      # image_data = Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAABkAAAAVCAYAAACzK0UYAAAA+ElEQVRIS+1W0Q2CMBRsR3AFHUFH0BF0BB1BRpARZAQ7gh3BjiAjyAj1rilJf+x7iQkxkZcQIL3jHs27AxtjXBpjjjjWOD5VjwVnrfUjALwzrrcVzoC1AE5rAX4IAuVzViD1WeBSESiXGopEJZiwHd8GlLvwFuUj/Szyx9v1xCjQK5raYLoCpuuavaXhpBGmCWmshcDoIOCIAYdY+kRqLgDTWk0r32KSCDrbC10xIhgrPKfKO1CLFcI8t5fbdcMNRaSiAGNlyE2Rp6nDFI53U4jM2fWjUf9SuH0c1fGjpR178jpOF7/vjAgpVlp4pCmMSCEpVvhPcHoDM0LGomRsZ4oAAAAASUVORK5CYII=")
              image_data = Base64.decode64(""+image_64)    
              name = "random_name1.png"
              directory = "app/assets/images"
              directory1 = "assets/images/posm_images/img"
              directory2 = "assets/posm_images/img"
              image_name = ProjectBase.random_code(15)
              path = File.join(directory, name)
              path1 = File.join(directory1, image_name+".jpg")
              path2 = File.join(directory2, image_name+".jpg")
      
      
              File.open(path, "wb") { |f| f.write(image_data) }
              # thumb = Magick::Image.from_blob(image_64.to_blob)
              
#               Image magic using convert image format
              
              thumb = Magick::Image.read(path).first
              thumb.format = "jpg"
              thumb.write("app/"+path1)
              File.delete(path)
              
              detail = CustomerDetail.find(:first, :conditions =>{:SEQ_NUM => customer_code})
              
              if detail.present?
                   

                    UploadedImage.create_table(emp_id,customer_code,detail.lat,detail.lng,path2,image_date,about_text)
              else
                    UploadedImage.create_table(emp_id,customer_code,0,0,path2,image_date,about_text)
              end  
                

              
            json = {"success" => 1, "message" => "added successfully"}
        else
            json = {"success" => 0, "message" => "Please logout"}
        end
        else
           json = {"success" => 0, "message" => "Sorry"}
        end
          # File.open(path1, "wb") { |f| f.write(thumb) }

          
      # flash[:notice] = "File uploaded"
      # redirect_to "/upload/new"
      render :json => json
   
 end
 
 def ss
   detail = CustomerDetail.find(:first, :conditions =>{:SEQ_NUM => "10019"})
              
         render :json => detail
 end
 
 
#  
#  
 # def store_image1
    # require "base64"
      # image_64 = params[:data]
      # image_format = params['format']
      # store_path = "assets/images"
#       
       # if image_64.present? && image_format.present?
#           
          # image_data = Base64.decode64(""+image_64)
#           
          # # thumb = Magick::Image.read(image_data).first
          # # thumb.format = "jpg"
          # image_name = ProjectBase.random_code(15)
# 
          # # thumb.write(image_name+".jpg")
#           
          # # image_name = "guru.png"
          # directory = File.join("app", store_path)
           # path = File.join(directory, thumb)
           # # File.open(path, "wb") { |f| f.write(image_data) }
#            
           # json = {"success" => 1, "message" => "added successfully"}
# 
       # else
           # json = {"success" => 0, "message" => "Sorry"}
       # end
         # render :json => json
#     
  # end 
 
 
 
 
 
 
end
