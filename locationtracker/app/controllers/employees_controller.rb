class EmployeesController < ApplicationController

  
# ************************************  GET ALL SALES REP DETAILS   ************************************
  def get_all_sales_rep
    # role_id = params['role']
    date = params['date']
    
    if date.present?
      employee = Employee.get_all_sales_rep_details(date)
      # employee = Employee.get_all_sales_rep_count(date)
      if (employee == 1)
          response = {'success' => '1','message' => "#{'No Data Found '}#{Employee.date_formate1(date).upcase}"}
      else
          response = {'success' => '0','message' => "#{'No Data Found '}#{Employee.date_formate1(date).upcase}"}
      end
    else
      response = {'success' => '0','message' => 'Required field missing'}
    end
    render :json => response
    
  end
  
  
  
  # ************************************  GET PARTICULAR SALES REP DETAILS   ************************************
  def get_sales_rep_details
    code = params['id']
    date1 = params['date']

    
    if code.present? && date1.present?
      if(!Employee.code_check(code))
        # employee = Employee.get_sales_rep_details(code,date1)
        
         sales_rep_routes_array = Hash.new
        emp = Employee.find(:first, :conditions =>{:sales_person_code => code})
            date_check = PlannedRoute.validates_date(code,date1)
            date_check1 = ActualRoute.validates_date(code,date1)
      if !date_check || !date_check1
        
        # check last date
         details = ActualRoute.find(:all ,:conditions =>{:salesperson_code => emp.employee_code}, :limit => 1)
         # date2 = ActualRoute.date_formate1(details[0].gps_date.to_s)


         planned_routes = PlannedRoute.planned_routes_details(emp.employee_code,date1)
         actual_routes = ActualRoute.actual_routes_details(emp.employee_code,date1)
      
        sales_rep_routes_array['date'] = date1
        sales_rep_routes_array['name'] = emp.name
        # sales_rep_routes_array['phone_number'] = emp.phone
        sales_rep_routes_array['planned_path'] = planned_routes
        sales_rep_routes_array['actual_path'] = actual_routes  
        
        if date1.to_date == (details[0].gps_date).to_date
                    sales_rep_routes_array['last_record'] = 1
        else
                    sales_rep_routes_array['last_record'] = 0
        end
        
        response = {'success' => '1','message' => sales_rep_routes_array}       
        else
          sales_rep_routes_array['name'] = emp.name
          # sales_rep_routes_array['phone_number'] = emp.phone

        response = {'success' => '0','message' => date1}

          response = {'success' => '0','message' => "#{'No Data Found '}#{Employee.date_formate1(date1).upcase}",'details' => sales_rep_routes_array}
        end
      else
        response = {'success' => '0','message' => 'Please Select SR'}

      end
      
    else
      response = {'success' => '0','message' => 'Required field missing'}
    end
    render :json => response
    
  end
  
  # ************************************  SALES REP DETAILS USER LOGIN   ************************************
  def get_employee_details
    code = params['code']
    date = params['date']
       
      if code.present? && date.present?         
            emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => code })
            if emolpyee_code.present?
              code = emolpyee_code.employee_code
                if(!Employee.code_check(code))
                    
                     employee = Employee.get_all_sales_rep_details_new(code,date)
                     response = {'success' => '1','message' => employee}
                   
                else
                      response = {'success' => '0','message' => 'Please Select SR'}
                end  
          else
             response = {"success" => 2, "message" => "logout"}
          end     
      else
        response = {'success' => '0','message' => 'Required field missing'}
      end  
        render :json => response
    
  end
  
   
   
    # ************************************  SALES REP DETAILS   ************************************
  def get_all_employee_details
       
     sales_rep_routes_array = Array.new  

     employee = Employee.find(:all)
     
     employee.each do |val|
       
         sales_rep_routes_hash = Hash.new  

        sales_rep_routes_hash['employee_code'] = val.employee_code
        sales_rep_routes_hash['employee_name'] = val.name
        sales_rep_routes_hash['s_code'] = val.supervisor_code
        sales_rep_routes_hash['company_code'] = val.company_code
       
        employee_role = EmployeeRole.find(val.role_id)
        sales_rep_routes_hash['role'] = employee_role.role
        

       
       sales_rep_routes_array << sales_rep_routes_hash
     end
      
     
        render :json => sales_rep_routes_array
             

  end
  
def index
     render :layout => false
 end  
  
  
end
