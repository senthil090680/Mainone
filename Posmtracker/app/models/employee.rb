class Employee < ActiveRecord::Base
  
  
  set_table_name "SALES_PERSONNEL"
 
  alias_attribute :name, :branch_name
  alias_attribute :branch_id, :branch_code
  alias_attribute :employee_code , :sales_person_code
  alias_attribute :name , :sales_person_name
  alias_attribute :supervisor_code , :supervisor
  alias_attribute :kd_id , :KD_code
  
  
  
  
  attr_accessible :role , :company_code , :branch_id , :employee_code , :name , :phone , :supervisor_code ,:kd_id
  
  
  # attr_accessible :role_id , :company_code , :branch_id , :sales_person_code , :name , :phone , :supervisor_code, :is_active 
  # before_create :set_created_at
  # before_save :set_replaced_at
  
      
  
      # GET PURTICULAR SALES REP CODE CHECK 
    def self.code_check(code)
        employee =Employee.count(:conditions => {:sales_person_code => code })
         if (employee.to_i > 0) 
            return false
         else
            return true
         end
    end
  
  
  
  
  def self.get_brand_type_id(brand_id)
    
      sql=""
      
      details = Array.new
        sql << "select * from images_multi_brands where brand_id ="+brand_id+" group by brand_type_id"
         s = ImagesMultiBrand.find_by_sql(sql) 
            
         s.each do |val|
            
              details << get_brand_type_details(val.brand_type_id)
         end     
          
       return details  
    
  end
  
  
      # **************************** brand type details *********************************************
  def self.get_brand_type_details(brand_type_id)
      details = Array.new
                    name = Hash.new

      # return brand_type_id
      if !brand_type_id.nil?
          get_type = PosmType.find(brand_type_id)
      
              if get_type.present?
                      name["name"] = get_type.product_name
                      name["id"] = get_type.SEQ_NUM                   
             end  
                     return name
      else
                      name["name"] = ""
                      name["id"] = ""                 
             # end  
                     return name
      end
    
                                   
    
  end
  
  
      # ****************************  type of search *********************************************
  def self.type_of_search(params)
    
     # brand_id = params['brand_id']
    # brand_type_id = params['brand_type_id']
    # year = params['year']
    # emplo = params['code']
    arr =Array.new
    req_fields = ["principal_id","brand_id", "brand_type_id","year","code","rating","created_at","user_code"]
    begin
    req_fields.each do |r,i|
      
      if params["#{r}"].present?
        
        arr << "#{r}"
        
      end
     
    end
     return arr
     rescue
            return false
     end
      
  end
  
  
  
      # ****************************  filter details *********************************************
  def self.get_filter(params)
    
    sql=""
             n = 0
             n1 = 0
             sql << "select * from POSM_PIC_DATA"
             
             arr = Employee.type_of_search(params)
             
             arr.each do |val|
               
               if(n == 0)
                  sql << " where " 
               else
                  sql << " AND "
               end
               
               case val
                when "principal_id"
                      if (n1 == 0)
                        sql << "SEQ_NUM in (select images_id from images_multi_brands where principal_id = '"+params['principal_id']+"')"
                        n1 = n1 + 1
                       end
                
                when "brand_id"
               
                      if (n1 == 0)
                          sql << "SEQ_NUM in (select images_id from images_multi_brands where brand_id = '"+params['brand_id']+"')"
                      elsif(n1 == 1)
                            sql = sql[0,(sql.length()-6)]
                          sql << " AND brand_id = "+params['brand_id']+")"
                      end    
                          n1 = n1 + 1               
               
                when "brand_type_id"
              
                      if (n1 == 0)
                          sql << "SEQ_NUM in (select images_id from images_multi_brands where brand_type_id = '"+params['brand_type_id']+"')"
                         
                      elsif(n1 == 1 || n1 == 2)
                            sql = sql[0,(sql.length()-6)]
                          sql << " AND brand_type_id = "+params['brand_type_id']+")"
                      
                      end
                       n1 = n1 + 1

              
                when "year"
              
                       sql << "(select YEAR(created_at)) = "+params['year']
              
              
                when "code"
              
                     sql << "salesperson_code = '"+params['code']+"'"
              
              
                when "created_at"
               
#                       sql << "Picture_Date <= ''"
						sql << "DATE(Picture_Date) <= '"+date_formate(params['created_at'])+"'"
               
                when "rating"
               
#                       sql << "average_rating_score >=0  AND average_rating_score >= "+ params['rating'].to_s
                      sql << "average_rating_score >= "+ params['rating'].to_s
                when "user_code"
                      
                        details = EmployeeAuthentication.find(:first , :conditions => {:code => params['user_code']})   
                        emp_details = Employee.find(:first , :conditions => {:sales_person_code => details.employee_code})     
                         
                         if emp_details.blank?
                
                            principal_details = PrincipalDetail.find(:first , :conditions => {:principal_code => details.employee_code})       
                           
                            if !principal_details.blank?
                            
                                principal_brand = BrandDetail.find(:first , :conditions => {:principal => principal_details.id})       
                                sql << "SEQ_NUM in (select images_id from images_multi_brands where brand_id = '"+principal_brand.id.to_s+"')"
                            else
                                kd_details = KdDetail.find(:first , :conditions => {:KD_code => details.employee_code})
                                
                                if (!kd_details.blank?)
                                    kd_sr = Employee.find(:first , :conditions => {:KD_code => kd_details.id})   
                                    sql << "salesperson_code in (select sales_person_code from employees where KD_code = '"+kd_details.id.to_s+"')"
                                else
                                     sql = sql[0,(sql.length()-5)]
                                end
                            end
                          else
                              sql = sql[0,(sql.length()-5)]
                          end
                      
                end
               
               
               
               
             
                n= n+1;    
             end
             
              if (n == 1)
                 sql << " where portal_flag = 1 "
             else
                 sql << " and portal_flag = 1 "
             end
             
             sql << " order by SEQ_NUM desc limit 0,50"
             
            s = UploadedImage.find_by_sql(sql) 
            
  end
    
    # ****************************  dropdown details details *********************************************
    def self.drop_down_details(id)
      
      a=Array.new
         json = {}

      
       if (id == "1")
          
          emp = Employee.find(:all , :conditions =>{:role => "SR"},:order => "sales_person_name ASC")
          
          emp.each do |val|
            hash = Hash.new
             
             branch = BranchDetail.find(:first , :conditions => { :branch_code => val.branch_code})
            
            hash['name'] = "#{val.name}#{'('}#{branch.branch_name}#{')'}"
            hash['id'] = val.employee_code

            
            a << hash
            
          end
          
              json = {"success" => 1, "message" => a}
              
        
        elsif (id == "2")
        
          emp = PosmType.posm_all_types()
          
          emp.each do |val|
            hash = Hash.new
            
            hash['name'] = val.name
            hash['id'] = val.seq_num
            
            a << hash
            
          end
          
              json = {"success" => 2, "message" => a}
          
        elsif (id == "3")
          
            
             sql=""
             s= ""
             n = 1
             # sql << "select (select YEAR(created_at)) as year from `uploaded_images`  GROUP BY (select YEAR(created_at) as year)"
            # s = UploadedImage.find_by_sql(sql) 
            # s = UploadedImage.find(:all) 
            s = PrincipalDetail.find(:all,:order => "principal_name ASC")
            
            s.each do |val|
              hash = Hash.new
            
               hash['name'] = val.principal_name
               hash['id'] = val.id
               
                    a << hash

              n = n+1
            end
          
          
              json = {"success" => 3, "message" => a}
          
        end
        
        return json
      
      
    end
    
  

    
    # **************************** SET DATE FORMATE *********************************************
    def self.date_formate(date)
       return "#{DateTime.parse(date).strftime("%Y-%m-%d %H:%M")}"
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





# filter condition



               # if (val == "principal_id")
                # if (n1 == 0)
                    # sql << "id in (select images_id from images_multi_brands where principal_id = '"+params['principal_id']+"')"
                    # n1 = n1 + 1
                # end
               # end
#                             
              # if (val == "brand_id")
                # if (n1 == 0)
                    # sql << "id in (select images_id from images_multi_brands where brand_id = '"+params['brand_id']+"')"
                # elsif(n1 == 1)
                      # sql = sql[0,(sql.length()-6)]
                    # sql << " AND brand_id = "+params['brand_id']+")"
                # end    
                    # n1 = n1 + 1
               # end
#                
               # if(val == "brand_type_id")
                   # if (n1 == 0)
                    # sql << "id in (select images_id from images_multi_brands where brand_type_id = '"+params['brand_type_id']+"')"
#                    
                # elsif(n1 == 1 || n1 == 2)
                      # sql = sql[0,(sql.length()-6)]
                    # sql << " AND brand_type_id = "+params['brand_type_id']+")"
#                 
                # end
                 # n1 = n1 + 1
#                   
               # end  
#                
               # if (val == "year")
                  # sql << "(select YEAR(created_at)) = "+params['year']
               # end
#                
               # if (val == "code")
                  # sql << "employee_code = '"+params['code']+"'"
               # end
              # if (val == "created_at")
                  # sql << "created_at <= '"+date_formate(params['created_at'])+"'"
               # end
#               
               # if (val == "rating")
                    # # rat1= params['rating'].to_s.split(',')[0]
                    # # rat2= params['rating'].to_s.split(',')[1]
                    # # sql << "average_rating_score >= "+rat1+" AND average_rating_score <= "+rat2
                    # sql << "average_rating_score >=0  AND average_rating_score <= "+ params['rating'].to_s
               # end
