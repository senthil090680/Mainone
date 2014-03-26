class UploadedImage < ActiveRecord::Base
  
  set_table_name "POSM_PIC_DATA"
 
  alias_attribute :employee_code , :salesperson_code
  alias_attribute :image , :Picture_file_name
  alias_attribute :lat , :GPS_latitude
  alias_attribute :lng , :GPS_longitude
  alias_attribute :about , :Comments
  alias_attribute :is_active , :portal_flag
  alias_attribute :uploaded_time , :Picture_Date
  alias_attribute :uploaded_time_ , :Picture_Time
  
  
   
attr_accessible :employee_code, :company_code ,:branch_code, :customer_code , :image , :lat , :lng ,:average_rating_score ,:uploaded_time,:about ,:Picture_Date , :Picture_Time,:is_active
  # before_create :set_created_at
  # before_save :set_updated_at
  # attr_accessor :set_image_name
  # has_attached_file :image, styles: {thumb: :jpg}
#   
#   
  # def set_image_name()
   # image_file_name = ProjectBase.random_code(15)
  # end
#   
  def self.create_table(emp_code,cus_code,lat,lng,image,image_time,about_text)
    image_time1 = date_format12(image_time); 
    image_time2 = date_format13(image_time); 
    user = UploadedImage.new(:employee_code => emp_code,:customer_code =>cus_code , :image => image, :lat => lat, :lng => lng,:Picture_Date =>image_time1 , :Picture_Time => image_time2,:about => about_text, :is_active => '0')
    user.save
  end
  
  
#   
#   LAZY LOADING IMAGES
    def self.images(count,is_active1,user_code)
        sql=""
        arr = Array.new
        _start = (count)*9
        
         emp_details = Employee.find(:first , :conditions => {:sales_person_code => user_code})     
         
         
      sql << "select * from POSM_PIC_DATA where portal_flag = "+is_active1.to_s

         if emp_details.blank?

            principal_details = PrincipalDetail.find(:first , :conditions => {:principal_code => user_code})       
           
            if !principal_details.blank?
            
                principal_brand = BrandDetail.find(:first , :conditions => {:principal => principal_details.id})       
                sql << " AND SEQ_NUM in (select images_id from images_multi_brands where brand_id = '"+principal_brand.id.to_s+"')"
            else
                kd_details = KdDetail.find(:first , :conditions => {:KD_code => user_code})
                
                if (!kd_details.blank?)
                    kd_sr = Employee.find(:first , :conditions => {:KD_code => kd_details.id})   
                    sql << " AND salesperson_code in (select sales_person_code from SALES_PERSONNEL where KD_code = '"+kd_details.id.to_s+"')"
                end
            end
         
         end
              
      sql << " order by SEQ_NUM asc limit "+_start.to_s+",9"       
      
         # s = UploadedImage.find(:all ,:conditions => {:is_act==ive => is_active.to_i}, :order => 'id asc', :limit => (_start.to_i,10))
        
        # sql << " AND id in (select images_id from images_multi_brands where principal_id = '"+params['principal_id']+"')"

            # sql << "select * from uploaded_images where is_active= 1 order by employee_id desc limit 9,9"          
            s = UploadedImage.find_by_sql(sql) 
       return s    
    end
  
  
#   GET ALL IMAGES 
  def self.all_images(count)
      sql=""
      _start = (count)*50
      
      sql << "select * from POSM_PIC_DATA order by SEQ_NUM desc limit "+_start.to_s+",50"
      # sql << "select * from uploaded_images where employee_id= 28 order by employee_id desc limit 9,9"
      s = UploadedImage.find_by_sql(sql) 
      return s 
  end
  
  
  def self.count_checking(id)
            count = UploadedImage.count(:conditions =>{:SEQ_NUM => id.to_i})
     return count.to_i  
  end
  
  
     # ************************ update is active **************************************       
  def self.updating_is_active(image_id)
       where(:SEQ_NUM => image_id).update_all({:portal_flag => 1})   
  end
  
     # ************************ update old rating **************************************       
  def self.updating_rating_details1(image_id,rating)
       where(:SEQ_NUM => image_id).update_all({:average_rating_score => rating})   
  end
  
  # GET IMAGE ADDRESS
  def self.get_addtrss(customer_code)
    
      sql=""
      s =""
      arr = Array.new
      address = ""
        sql << "select Address_line1,Address_line2,Address_line2,city from CUSTOMER_MASTER where customer_code = "+customer_code
            # sql << "select * from uploaded_images where employee_id= 28 order by employee_id desc limit 9,9"
            s = CustomerDetail.find(:first,:conditions =>{:customer_code => customer_code}) 
           
           arr = [s.address_line1,s.address_line2,s.address_line3,s.city]
            arr.each do |val|
              if address.present?
                 address = "#{address}#{','}"
              end
              if val.present?
                 address = "#{address}#{val}"
             
              end
              
            end
       return address   
  end
  
#   Store Image date only
  def self.date_format12(date)
   return "#{DateTime.parse(date).strftime("%Y-%m-%d")}" 
  end

#   Store Image time only
  def self.date_format13(date)
   return "#{DateTime.parse(date).strftime("%H:%M")}" 
  end

#   
  def self.date_format1(date)
   return "#{DateTime.parse(date).strftime("%d %b, %y | %I.%M%p")}" 
  end
  

  def self.date_format(date)
    
   return "#{DateTime.parse(date).strftime("%d %B, %Y | %I.%M%p")}" 
  end
  
   # # set created date
    # def set_created_at
      # created_at = ProjectBase.get_gmt
    # end
#     
    # # set updated at
    # def set_updated_at
      # uodated_at = ProjectBase.get_gmt
    # end
  
  
  end
