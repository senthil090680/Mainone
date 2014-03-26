// FILTER ONCHANGE EVENT
function filter_change(name)
{
	
	
	// alert($("#"+name+"_picker").val());
	
	var val = $("#"+name+"_picker").val();
	
	if (val != 0)
	{		
		if (name != "company")
		{
			get_employee_details_tree_view(val,1);
		}
	}
	else
	{
		split_tree_details();
	}

				
}


function split_tree_details_onchange()
{
		// var arr = ['gm_picker','nsm_picker','rsm_picker','asm_picker','sr_picker']
		
// 		Company details
		
	   show_brand(Show_company_emp_details1);
	   		
		for (var j=0; j< Show_higher_emp_details1.length;j++)
	   	{
	   		show_brand(Show_higher_emp_details1[j]);
	   	}	
	   		
		// alert(JSON.stringify(Show_all_emp_details1.length)+" hfidhjg  "+JSON.stringify(Show_higher_emp_details1)+" kjhdfjhg  "+JSON.stringify(Show_company_emp_details1));
	
		for (var i=1;i<Show_all_emp_details1.length;i++)
	   		{
	   			// for (var j=0;j<Show_all_emp_details[i].length;j++)
			   		// {
			   			show_brand_picker(Show_all_emp_details1[i],1,0);
			   		// }
	   		}
	   		
	   		var sr_details = $("#sr_picker").val();
	   		
	   		if (sr_details != 0)
	   		{
	   			get_sales_rep_details(sr_details,0);
	   		}
	   		
	   		
	   		
}


function split_tree_details()
{
		// var arr = ['gm_picker','nsm_picker','rsm_picker','asm_picker','sr_picker']
		
// 		Company details

		// alert(Show_company_emp_details.length);
		if (Show_company_emp_details.length == 1)
		{
	   		show_brand_picker(Show_company_emp_details,0,1);
		}
		else if(Show_company_emp_details.length > 1)
		{
	   		show_brand_picker(Show_company_emp_details,1,1);
		}
	   
	   
	   for (var i=0;i<Show_all_emp_details.length;i++)
	   		{
	   			// for (var j=0;j<Show_all_emp_details[i].length;j++)
			   		// {
			   			show_brand_picker(Show_all_emp_details[i],i,1);
			   		// }
	   		}
	   		
	   
		for (var j=0; j< Show_higher_emp_details.length;j++)
	   	{
	   		show_brand_picker(Show_higher_emp_details[j],0,1);
	   	}		
		
		
}




function show_brand_picker(brand_dropdown,i,req){
	
		// alert(brand_dropdown);
		var store_id;
		var select_disable = true;

			var selectHTML ="";
					for(kl=0;kl<brand_dropdown.length;kl++)
					{
						if (kl == 0 && (i != 0 || brand_dropdown.length > 1))
						{
							
							selectHTML+= "<option value='0'>All</option>";
							select_disable = false;
							

						}
						
						        selectHTML+= "<option value='"+brand_dropdown[kl]["employee_code"]+"'>"+brand_dropdown[kl]["employee_name"]+"</option>";
								store_id = brand_dropdown[kl]["role"];
					}	
					
					
					jQuery.fn.exists = function(){return this.length>0;}

						if ($("#"+store_id.toLowerCase()+"_picker").exists()) {
						    // Do something
						
							    var div = document.getElementById(store_id.toLowerCase()+"_picker");
								while(div.firstChild){
		    					div.removeChild(div.firstChild);
								}
					        	document.getElementById(store_id.toLowerCase()+"_picker").innerHTML= selectHTML;
								// alert(selectHTML);						        
						        
						    } else {
						        // alert('false');
						    }
					 
					        
					        if (i == 0 && select_disable && req == 1)
					        {
					        	if (brand_dropdown.length >= 1)
					        	{
					        			
					        	$("#"+store_id.toLowerCase()+"_picker").prop("disabled", true);
								$("."+store_id.toLowerCase()+"_").addClass('filter_t12');
								$("."+store_id.toLowerCase()+"_ div").addClass('filter_type1');
					        	}
					        	
					        
					        }
					        else{
					        	$("."+store_id.toLowerCase()+"_").removeClass('filter_t12');
								$("."+store_id.toLowerCase()+"_ div").removeClass('filter_type1');
					        	}			
		}
		
		
		function show_brand(brand_dropdown){
	
		// alert(brand_dropdown);
		var store_id;

						// alert(brand_dropdown);

					for(kl=0;kl<brand_dropdown.length;kl++)
					{				
						store_id = brand_dropdown[kl]["role"];
			
						// alert("jjbb  "+brand_dropdown[kl]["employee_code"]);
						// alert(brand_dropdown[kl]["employee_code"]+"    &&     "+brand_dropdown[kl]["role"]);
							$("#"+store_id.toLowerCase()+"_picker").val(brand_dropdown[kl]["employee_code"]);
					}	
		}
		
	
	// When logout window to call this method	
	function clear_dropdown()
		{
				var arr = ['company_','gm_','nsm_','rsm_','asm_','sr_']
				for (var i=0;i<arr.length;i++)
	   			{
	   					$("#"+arr[i]+"picker").prop("disabled", false);
						$(".filter_t").addClass('filter_t12');
						$(".filter_t div").addClass('filter_type1');				   		
						var div = document.getElementById(arr[i]+"picker");
							while(div.firstChild){
	    					div.removeChild(div.firstChild);
							}
	   			}
	   		
		}
		
		
		function employee_filter_kd()
		{
			var employee_role = sessionStorage['emp_role'];
			var arr = ['company_','gm_','nsm_','rsm_','asm_']
				
			
			if (sessionStorage['emp_role'] == "KD")
			{
				for (var i=0;i<arr.length;i++)
	   			{
	   					$("."+arr[i]).hide();
	   					$(".kd_").show();
						
	   			}
			}
			else
			{
				for (var i=0;i<arr.length;i++)
	   			{
	   					$("."+arr[i]).show();
	   					$(".kd_").hide();
						
	   			}
			}
		}
		
		
		
		function admin_check()
		{
			// alert(sessionStorage['emp_role']);
			if (sessionStorage['emp_role'] == "ADMIN")
			{
				$('.admin').show();						
			}
			else{
				$('.admin').hide();						
			}
		}
