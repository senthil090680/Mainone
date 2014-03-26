function user_authentication()
{
	if(sessionStorage['user_role'] == "ADMIN")
	{
		var $window = $(window);
		var wWidth  = $window.width();
		var wHeight = $window.height();
		
		$(".left_div").css("width", (wWidth*100/100) + "px");
		$("#container").css("width", (wWidth*100/100) + "px");		    
		$(".right_div").hide();
		$(".view_set").hide();
	}
	
	
}


function admin_events()
{
	$('#create_new_employee').click(function(){
		
		$('#employee_name').val("");
		$('#employee_code').val("");
		$('#employee_password').val("");
		$('#employee_confirm_pwd').val("");
		$('.employee_role').val("");
		$('.create_new_user').show();
		
		
	});
	
// 	Save new User
	$('.save_new_user').click(function(){
		
		var employee_name,employee_code,new_password,confirm_password,employee_role;
		employee_name = $('#employee_name').val();
		employee_code = $('#employee_code').val();
		new_password = $('#employee_password').val();
		confirm_password = $('#employee_confirm_pwd').val();
		employee_role = $('.employee_role').val();
		
		
		if (employee_name != "" && employee_code != "" && new_password != "" && confirm_password != "" && employee_role != "")
		{
			if( new_password == confirm_password)
			{
				admin_create_new_employee(employee_code,employee_name,new_password,employee_role,2);
			}
			else
			{
				alert("Please Enter currect password");
			}
		}
		else{
			alert("Please fill this form")
		}
		
	});
	
	
	$('#employee_code').focusout(function() {
		admin_create_new_employee($(this).val(),"","","",1);
	});
}
