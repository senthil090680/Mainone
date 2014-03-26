class EmployeesController < ApplicationController
  # GET /employees
  # GET /employees.json
    # ************************************    get_images   ************************************
  def get_images
    
     count = params['no'].to_i
     is_active = params['is_active'].to_i
     user_code = params['user_code']
      arr = Array.new
      
         details = EmployeeAuthentication.find(:first , :conditions => {:code => user_code}) 
            
      s= UploadedImage.images(count,is_active,details.employee_code)
           
               
      s.each do |val|
        hash =Hash.new
        # url = "http://#{request.env['HTTP_HOST']}/"+val.image
        url = val.image
        lat = val.lat
         lng = val.lng
         id = val.id
        
        hash['image'] = url
        hash['lat'] = lat
        hash['lng'] = lng
        hash['id'] = id
        hash['content'] = val.about
       
        arr << hash
      end
      json = {"success" => 1, "message" => arr}
    render :json => json
    
  end
  
    # ************************************    GET ALL IMAGES   ************************************
  def get_all_images

      count = params['no'].to_i
      arr = Array.new
      
      s= UploadedImage.all_images(count)
      s.each do |val|
        hash =Hash.new
        # url = "http://#{request.env['HTTP_HOST']}/"+val.image
        url = val.image
        lat = val.lat
        lng = val.lng
        id = val.id
        
        hash['image'] = url
        hash['lat'] = lat
        hash['lng'] = lng
        hash['id'] = id
        arr << hash
      end
      json = {"success" => 1, "message" => arr}
      render :json => json

  end
  
  
  # ************************************    validate request params   ************************************
   def validate_required_fields(params)
   req_fields = ["brand", "type","password"]
    begin
    req_fields.each do |r|
      if !params["#{r}"].present?
        
      end
     
    end
     return true
     rescue
            return false
     end
  end
  
    # ************************************    GET BRAND DETAILS   ************************************
  def get_tag_details
    
    brand_id = params['brand_id']
    brand_type_id = params['brand_type_id']
    principal_company = params['principal']
    req = params['req']
    
    if brand_id.present? && brand_type_id.present?
            hash =Hash.new
            arr = Array.new
            brand_type = PosmType.find(brand_type_id)
            brand_name = BrandDetail.find(:first , :conditions => {:brand_code => brand_id})
            hash["brand_type_name"] =brand_type.product_name
            hash["brand_name"] = brand_name.name
            arr << hash
            
            json = {"success" => 1, "message" => arr }
    
    elsif req == '2'
            	details = PosmType.get_particular_brand_posm(brand_id)
#             details = Employee.get_brand_type_id(brand_id) 
            principal_name = PrincipalDetail.get_principal_id_using_brand(brand_id)
            json = {"success" => 2, "message" => details ,"pricipal_id" => principal_name}
      
    elsif req == '3'
           
            details = PrincipalDetail.get_brand_using_principal(principal_company)
            json = {"success" => 3, "message" => details }
      
    elsif req == '4'
      
            json = {"success" => 4, "message" => PrincipalDetail.get_details}
    else
      
            json = {"success" => 5, "message" => BrandDetail.get_details}
    end
    
    render :json => json
  end
  
  
    # ************************************    GET BRAND ID   ************************************
  def get_brand_id
     id = params['id']
      arr = Array.new
      brand_id_arr = Array.new
      brand_type_id = Array.new
      principal_id = Array.new
      emp_auth_code = Array.new
      tag_id = Array.new
              hash =Hash.new

      if (id != "" && !id.nil?)
        
             
              s= ImagesMultiBrand.find(:all, :conditions =>{:images_id => id})
              s.each do |val|
                # url = "http://#{request.env['HTTP_HOST']}/"+val.image
                brand_id_arr << val.brand_id
                brand_type_id << val.brand_type_id
                principal_id << val.principal_id
                emp_auth_code << val.employee_auth_code
                tag_id << val.id
                
                end
                hash['brand_id'] = brand_id_arr
                hash['brand_type_id'] = brand_type_id
                hash['principal'] = principal_id
                hash['employee_code'] = emp_auth_code
                hash['tag_id'] = tag_id
              
              json = {"success" => 1, "message" => hash}
              
      else
        
              s= BrandDetail.get_details()
              
            
            json = {"success" => 2, "message" => s}

        
       end
      render :json => json
    
  end
  
  # ************************************    Set BRAND ID   ************************************
  def set_brand_id
     id = params['id']
      employee_code = params['employee_code']
      brand_id = params['brand_id']
      principal_id = params['principal_id']
      brand_type_id = params['brand_type_id']
      tag_id = params['tag_id']
      i=0
      a=Array.new
    
    
      brand_id.each do |val|
        if (val != 0 && !brand_type_id.present? && principal_id[i].present?)
          img = ""
           img = ImagesMultiBrand.new(:employee_auth_code => employee_code[i], :images_id => id,:brand_id => val,:principal_id => principal_id[i])
           img.save
              
              UploadedImage.updating_is_active(id)
        
        elsif (val != 0 && brand_type_id[i].present? && principal_id[i].present?)
         
          count = ImagesMultiBrand.count(:conditions =>{:images_id => id,:brand_id => val,:brand_type_id => brand_type_id[i],:principal_id => principal_id[i]})
        
          if (count.to_i <= 0)
           if (tag_id.blank? || !tag_id[i].present?)
              img = ImagesMultiBrand.new(:employee_auth_code => employee_code[i], :images_id => id,:brand_id => val,:brand_type_id => brand_type_id[i],:principal_id => principal_id[i])
              img.save
              
              UploadedImage.updating_is_active(id)
            else
                ImagesMultiBrand.updating_tag_details(tag_id[i],employee_code[i],val,brand_type_id[i],principal_id[i])
            end
          end 
        end
        i = i+1
        
      end
   
   
     # s= ImagesMultiBrand.find(:all, :conditions =>{:images_id => id})
           json = {"success" => 1, "message" => "success"}
      render :json => json
     
  end
  
  
  # ************************************    GET DROP DOWN DETAILS   ************************************
  def get_dropdown_details
        id = params['id']
                 
       json = Employee.drop_down_details(id)
        render :json => json

  end
  
  # ************************************    FILTERS  ************************************
  def set_filter
     
      arr = Array.new
      
      s= Employee.get_filter(params)
      s.each do |val|
        hash =Hash.new
        # url = "http://#{request.env['HTTP_HOST']}/"+val.image
        url = val.image
        lat = val.lat
        lng = val.lng
        id = val.id
        
        hash['image'] = url
        hash['lat'] = lat
        hash['lng'] = lng
        hash['id'] = id
        arr << hash
      end
        
                  
      json = {"success" => 1, "message" => arr}
      render :json => json

                        
  end
  
  
  def average_rating
  i = 1
  arr = Array.new
  
    while i <= 150  do
        s = ""
          sql = ""
          
          sql << "select ROUND(AVG(rating)) as rating from image_emp_rating_reviews where image_id = '"+i.to_s+"'"
          s = ImageEmpRatingReview.find_by_sql(sql)
          arr << s[0].rating
          UploadedImage.updating_rating_details1(i,s[0].rating);

        
      i = i + 1
    end
    
    j=1
    arr.each do |val|
                

        # sql1 << "update uploaded_images set average_rating_score = '"+val.to_s+"' where id = '"+j.to_s+"'"
            # s1 = UploadedImage.find_by_sql(sql1) 
            j = j+1
    end
    render :json => arr
    
  end
  
  def index
     render :layout => false
 end  

  
end
