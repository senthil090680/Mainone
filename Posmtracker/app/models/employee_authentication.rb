  class EmployeeAuthentication < ActiveRecord::Base

  attr_accessible  :employee_code, :crypted_password , :code , :is_active ,:password ,:role,:app
  attr_accessor :password
  before_create :encrypt_password, :set_created_at
  before_save :set_updated_at
  
  
  
     # create a new user
    def self.create_employee(employee_code,password,name,role)
       
          user = EmployeeAuthentication.new(:employee_code => employee_code, :password => password , :role => role, :app => 'POSM', :code =>ProjectBase.random_code(15))
          user.save
          
          return user            
    end
    
     # create a new user
    def self.update_employee(employee_code,password,name,role)
       
       where(:employee_code => employee_code, :app => 'POSM').update_all({:role => role, :updated_at => ProjectBase.to_local_time(1,ProjectBase.get_gmt(),nil)}) 
       update_password(employee_code,password)
    end
    
    # updating user password
  def self.update_password(employee_code, password)
    user = EmployeeAuthentication.find(:first,:conditions => {:employee_code => employee_code , :app => 'POSM'})
    if user.update_attributes({:crypted_password => EmployeeAuthentication.encrypt(password, user.salt)})
    # successsfully update
    return true
    else
    # failed update
    return false
    end
  end
    
     # create a new user
    def self.get_employee_details(employee_code)
       hash = Hash.new
       user1 = ""
          user_name = Employee.find(:first , :conditions => { :sales_person_code => employee_code })
          user_role_psw = get_employee_password(employee_code)              
          
          if (user_name.blank?)
            user1 = PrincipalDetail.find(:first , :conditions => { :principal_code => employee_code })
            if (!user1.blank?)
                hash['name'] = user1.principal_name                
            else
                kd_details = KdDetail.find(:first , :conditions => {:KD_code => employee_code})
                
                if (!kd_details.blank?)
                   hash['name'] = kd_details.kd_name           
                else
                   hash['name'] = ""              
                end    
  
              
            end
          else
            user_role_psw = get_employee_password(employee_code)
            hash['name'] = user_name.name
          end
            
          hash['role'] = user_role_psw['role']                

          return hash             
    end
    
    
#     get employee auth_details
    def self.get_employee_password(employee_code)
      hash =Hash.new
           user = EmployeeAuthentication.find(:first , :conditions => { :employee_code => employee_code , :app => "POSM"})
           
           if(!user.blank?)
                 hash['role'] = user.role                
            end
                
      return hash
    end
    
    
    
        # # check user email validate 
    def self.validates_uniqueness(employee_code)
    
      user_count =EmployeeAuthentication.count(:conditions => {:employee_code => employee_code, :app => 'POSM'})
       if (user_count.to_i > 0) 
          return false
       else
          return true
       end
  
    end 

     # # check user email validate 
    def self.validates_uniqueness1(employee_code)
    
      user_count =Employee.count(:conditions => {:sales_person_code => employee_code})
       if (user_count.to_i > 0) 
          return true
       else
          user_count1 =PrincipalDetail.count(:conditions => {:principal_code => employee_code})
          
          if (user_count1.to_i > 0) 
              return true
          else
             kd_count1 =KdDetail.count(:conditions => {:KD_code => employee_code})
              if (kd_count1.to_i > 0) 
                  return true
              else
                  return false
              end    
          end 
       end
  
    end 

#   LOGIN RESPONSE 
    def self.login_response(user)
      
        hash = Hash.new

        employee_details =Employee.find(:first ,:conditions => {:sales_person_code => user.employee_code})
        
         if (employee_details.blank?)
            user1 = PrincipalDetail.find(:first , :conditions => { :principal_code => user.employee_code })
            if (!user1.blank?)
                hash['user_name'] = user1.principal_name
            else
                kd_details = KdDetail.find(:first , :conditions => {:KD_code => user.employee_code})
                
                if (!kd_details.blank?)
                    hash['user_name'] = kd_details.kd_name
                  else
                    hash['user_name'] = ""
                end    
  
            end 
          else
                hash['user_name'] = employee_details.name
          end    
          
                hash['user_code'] = user.code
                hash['user_role'] = user.role
        
     return hash   

    end



    def self.authenticate(login, password)
      #u = find_by_login(login) # need to get the salt
      u = EmployeeAuthentication.find(:first, :conditions => {:employee_code => login, :is_active => 1, :app => 'POSM'}) 
      u && u.authenticated?(password) ? u : "1"
    end
    
    def authenticated?(password)
      crypted_password == encrypt(password)
    end
    
    
      # Encrypts some data with the salt.
    def self.encrypt(password, salt)
      Digest::SHA1.hexdigest("--#{salt}--#{password}--")
    end
    
      # Encrypts the password with the Merchant salt
    def encrypt(password)
      self.class.encrypt(password, salt)
    end
    
    
    
   protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{employee_code}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    # set created date
    def set_created_at
      created_at = ProjectBase.get_gmt
    end
    
    # set updated at
    def set_updated_at
      updated_at = ProjectBase.get_gmt
    end
    
end
