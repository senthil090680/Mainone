	function custom_create_tag(n)
	{
		var k;
					$("#show_tag_list").remove();
					$(".box").append("<div id='show_tag_list'></div>");
	
					for(k=0;k<4;k++)
					{
						var kl,opt;
								var filter="<div class='show_filters'>"
										+"<div class='principal tag_dropdown' id='o"+k+"' ></div>"
										+"<div class='material tag_dropdown' id='m"+k+"'></div>";
														
						if(sessionStorage['user_role'] != "ADMIN")
							{
									$('#dialog-form').removeClass('box1');
									$('#dialog-form').addClass('box2');
									filter += "<div class='select_brand tag_dropdown' id='n"+k+"' ></div>";
													
							}
							else
							{
								$('#dialog-form').removeClass('box2');
								$('#dialog-form').addClass('box1');
							}						
							
							
							filter +="</div>";
					
					$("#show_tag_list").append(filter);
					
										get_brand_details("","",k,"",5);
										get_brand_details("","",k,"2",4);
					}
				
			resizeContainers();
	
	}
	

	
	//  PRINCIPAL DROPDOWN DETAILS 
	function create_select_principal(k){
		
				var selectHTML = "",kl;
	
					selectHTML = "<select onchange=principal_dropdown_onchange('o"+k+"s','m"+k+"s','n"+k+"') id='o"+k+"s' name=select_drop>";
						for(kl=0;kl<principal_arr.length;kl++)
						{
							if (kl == 0)
							{
								selectHTML+= "<option value='0'>Principal</option>";
	
							}
							        selectHTML+= "<option value='"+principal_arr[kl]["id"]+"'>"+principal_arr[kl]["name"]+"</option>";
	
						}	
			        selectHTML += "</select>";
			        // $('s'+k).appand(selectHTML);
			        document.getElementById('o'+k).innerHTML= selectHTML;

	}
	
	
	//  BRAND NAME DROPDOWN DETAILS 
	function create_select_name(k){
		
					var selectHTML = "",kl;
	
					 selectHTML = "<select onchange=change_dropdown('m"+k+"s','o"+k+"s','n"+k+"') id='m"+k+"s' name=select_drop>";
						for(kl=0;kl<brand_arr.length;kl++)
						{
							if (kl == 0)
							{
								selectHTML+= "<option value='0'>Brand Name</option>";
	
							}
							        selectHTML+= "<option value='"+brand_arr[kl]["id"]+"'>"+brand_arr[kl]["name"]+"</option>";
	
						}	
			        selectHTML += "</select>";
			       // $('s'+k).appand(selectHTML);
			        document.getElementById('m'+k).innerHTML= selectHTML;
			        show_server_details();
		
	}
	
	
	//   POSM TYPE DROPDOWN DETAILS 
	function create_select_option_type(id1)
	{
		var selectHTML = "",kl;
		
			$("#o"+id1.substring(1)+"s").val(brand_change_principal_id);
			
			selectHTML = "<select id='"+id1+"s' name=select_drop>";
						for(kl=0;kl<brand_type_arr.length;kl++)
						{
							if (kl == 0)
							{
								selectHTML+= "<option value='0'>POSm items</option>";
	
							}
							if(brand_type_arr[kl]["name"] != "")
							{
							        selectHTML+= "<option value='"+brand_type_arr[kl]["id"]+"'>"+brand_type_arr[kl]["name"]+"</option>";
							}
						}	
						        selectHTML += "</select>";
						        document.getElementById(id1).innerHTML= selectHTML;
						        	
		
						var n1=brand_type_id_res;
						// alert(brand_type_id_res);
						for(var i=0;i<n1.length;i++)
						{
							$("#n"+i+"s").val(""+n1[i]);
							
							if (tag_employee_code[i] != sessionStorage['user_code'])
								{
									
									$("#m"+i+"s").addClass("tag_dropdown1");
									$("#m"+i+"s").prop("disabled", true);
									$("#o"+i+"s").addClass("tag_dropdown1");
									$("#o"+i+"s").prop("disabled", true);
									
									// alert(n1[i]);
									if(n1[i] != null)
									{
										$("#n"+i+"s").addClass("tag_dropdown1");
										$("#n"+i+"s").prop("disabled", true);
									}
									

								}

						}
						        
	}
	
		//   BRAND NAME DROPDOWN ITEM ON CHANGE 
	function change_dropdown(this_id,principal_dropdown_id,posm_type_dropdown_id)
	{	
		var brand_id = $("#"+this_id).val();
		// $("#"+principal_dropdown_id).val(""+brand_id);
		// alert("1");
		get_brand_details(brand_id,"",posm_type_dropdown_id,"",2);	
		// $("#"+id).prop("disabled", true);
			
	}
	
		//   principal NAME DROPDOWN ITEM ON CHANGE 
	function principal_dropdown_onchange(this_id,brand_name_dropdown_id,posm_type_dropdown_id)
	{	
		var principal_id = $("#"+this_id).val();
		// $("#"+brand_name_dropdown_id).val(""+principal_id);
				var brand_drop_id = posm_type_dropdown_id.substring(1);

		// alert(brand_drop_id);
		
		if (principal_id == 0)
		{
			get_brand_details("","",brand_drop_id,"",5);
		}
		else 
		{
			get_brand_details("","",brand_drop_id,principal_id,3);
					// hide_loop = false;	

		}
		
		
			
	}
	
	function show_server_details()
	{
		// document.getElementsByName("select_drop")[0].value="1";
		// document.getElementsByName("select_drop")[].value="1";
		var n=brand_name_id_res;
		var n1=principal_id_res;
		for(var i=0;i<n.length;i++)
		{
			$("#m"+i+"s").val(""+n[i]);
			$("#o"+i+"s").val(""+n1[i]);
			
		if(sessionStorage['user_role'] != "ADMIN")
		{
			$("#m"+i+"s").trigger("change");
			// $("#o"+i+"s").trigger("change");
		}
		else
		{
			// $("#o"+i+"s").trigger("change");
		}	
			
			// $("#m"+i+"s").prop("disabled", true);
			// alert("hi");
				
			// alert(n[i]);
		}
	
		
	
	}
	
	
	
	
	
	
