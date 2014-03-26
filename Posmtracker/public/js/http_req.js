var brand_name_res = [];
var brand_type_arr = [];
var brand_arr = [];
var principal_arr = [];
var principal_id_res = [];
var tag_employee_code =[];
var tag_id = [];
var brand_change_principal_id = "";

function get_filter_image(type_id,brand_id,principal_id,sr,rate,created_at)
	{
		// params ={ 'brand_type_id' : type_id,'brand_id' : brand_id,'year' : year, 'code' : sr, 'rating' : rate,'created_at' : created_at}
		params ={ 'brand_type_id' : type_id,'brand_id' : brand_id,'principal_id' : principal_id, 'code' : sr, 'rating' : rate,'created_at' : created_at ,"user_code" : sessionStorage['user_code']}
		// alert(JSON.stringify(params));
		$.ajax({
			url : "employees/set_filter",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				// alert(JSON.stringify(data['message']));
				// var div = document.getElementById('my-folio-of-works2');
				// while(div.firstChild){
				// div.removeChild(div.firstChild);
				// }
				if(success == "1")
				{
					putImages_gal(data['message']);

				}
							
			}
		});
	
	}
	
	function get_image()
	{
		var isactive = 1;
		if(sessionStorage['user_role'] == "ADMIN")
		{
			isactive = 0;
		}
		
		// alert(sessionStorage['user_code']);
				
		params ={ 'no' : n, 'is_active' : isactive,"user_code" : sessionStorage['user_code']}
		// alert(JSON.stringify(params));
		$.ajax({
			url : "employees/get_images",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					if (n == 1)
					{
						$('#1n11').trigger('click');
					}
					putImages(data['message']);
					// alert(JSON.stringify(data['message']));
					contentHeight1 += contentHeight;
					n += 1;
				
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
	}
	
	// USER TAG PARTICULAR IMAGE 	
	function get_brand_details(brand_id,brand_type_id,id1,principal,req)
	{

		var brand_url = "employees/get_tag_details"
		
		if (brand_id != "" && brand_type_id != "")
		{
				params ={ 'brand_id' : brand_id,"brand_type_id" : brand_type_id , "req" : req};
		}
		else if (req == 2)
		{
				params ={ 'brand_id' : brand_id , "req" : req};
		}
		else if (req == 3)
		{
				params ={ 'principal' : principal , "req" : req};
		}
		else if (req == 4)
		{
				params ={ 'principal' : principal , "req" : req};
		}
		else
		{
			params ={"req" : req};
		}
			// alert(JSON.stringify(params));
			$.ajax({
				url : brand_url,
				data : params,
				type : "post",
				error : function(error) {
// 					alert(JSON.stringify(error))
				},
				success : function(data) {
					var success = data['success'];
					
					if(success == "1")
					{
						// brand_name_res = data['brand_type_name']
						// brand_type = data['brand_name']
						brand_name_res =  data['message'];
						// alert(brand_name_res+"    "+brand_type);
					}
					else if (success == "2")
					{
						brand_type_arr = data['message'];
						brand_change_principal_id = data['pricipal_id'];

						create_select_option_type(id1);

						// alert(JSON.stringify(brand_type_arr));
					}
					else if (success == "3")
					{
						brand_arr = data['message'];
						// alert(JSON.stringify(brand_arr));
						create_select_name(id1);
					}
					else if (success == "4")
					{
						principal_arr = data['message'];
						create_select_principal(id1);
					}
					else if (success == "5")
					{
						brand_arr = data['message'];
						create_select_name(id1);
					}
					
					
				}
			});
	}
	
	
	function get_brand_id(id)
	{
		if (id !="")
			{
				params ={ 'id' : id};
			}				
			else
			{
				params ={};
			}
		$.ajax({
			url : "employees/get_brand_id",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					 brand_name_id_res = data['message']['brand_id'];
					 brand_type_id_res = data['message']['brand_type_id'];
					 principal_id_res = data['message']['principal'];
					 tag_employee_code = data['message']['employee_code'];
					 tag_id = data['message']['tag_id'];
					 
					 // alert(brand_name_id_res+" 1 "+brand_type_id_res+"  2 "+principal_id_res+"  3 "+tag_employee_code+"  4 "+tag_id);
					 			custom_create_tag(4);

					 // alert(brand_name_id_res.replace(/ /g,'')+"     "+brand_type_id_res.replace(/ /g,''));
				}
				else if (success == "2")
				{
					var brand_dropdown = [];
					brand_dropdown = data['message'];
					show_brand_picker(brand_dropdown,'brand_picker');
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
		
		
	}


function set_brand_id(id,brand_id__,brand_type_id__,principal_id__,tag_id__,emp_code__)
	{
		var params;
		
		if(sessionStorage['user_role'] == "ADMIN")
		{
			params ={ 'id' : id,'brand_id' : brand_id__ ,'principal_id' : principal_id__,'employee_code': emp_code__,'tag_id' :tag_id__}
		}
		else
		{
			params ={ 'id' : id,'brand_id' : brand_id__ ,'brand_type_id' : brand_type_id__,'principal_id' : principal_id__,'employee_code': emp_code__,'tag_id' :tag_id__}
		}
		
		// alert(JSON.stringify(params));
		$.ajax({
			url : "employees/set_brand_id",
			data : params,
			type : "post",
			error : function(error) {
				// alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					$('.add-info').hide();
					// alert("Success");
					 // alert(brand_name_id_res.replace(/ /g,'')+"     "+brand_type_id_res.replace(/ /g,''));
					 
					if(sessionStorage['user_role'] == "ADMIN")
					{
							location.reload();
					}
					
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
		
		
	}
	
	
	function get_dropdown_details(id)
	{
		
				params ={ 'id' : id};
			
		$.ajax({
			url : "employees/get_dropdown_details",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					var employee_dropdown = [];
					employee_dropdown = data['message'];
					show_brand_picker(employee_dropdown,'sr_picker');

					 // alert(brand_name_id_res.replace(/ /g,'')+"     "+brand_type_id_res.replace(/ /g,''));
				}
				else if (success == "2")
				{
					var type_dropdown = [];
					type_dropdown = data['message'];
					show_brand_picker(type_dropdown,'posm_type_picker');
				}
				
				else if (success == "3")
				{
					var year_dropdown = [];
					year_dropdown = data['message'];
					show_brand_picker(year_dropdown,'year_picker');
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
		
	}

 // get particular image details
	function get_image_details(id)
	{
		
				params ={ 'id' : id};
			
		$.ajax({
			url : "uploaded_images/get_image_details",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
										// alert(JSON.stringify(data["message"]["name"]));

					image_uploader_name = data["message"]["name"];
					image_uploader_date = data["message"]["date"];
					image_uploader_address = data["message"]["address"];
					var lat_ = data["message"]["lat"];
					var lng_ = data["message"]["lng"];
					show_map_details();
					// get_address_details(lat_,lng_);
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
		
		
	}

	
	
	// get and set review
	function review_reting_http(image_id,emp_id,review,rating,req)
	{
		var get_url;
		var params ={};
		
		if (req == "1")
		{
			get_url = "image_emp_rating_reviews/get_rating"
			params ={ 'image_id' : image_id, 'emp_id' : emp_id};
		}
		else
		{
			get_url = "image_emp_rating_reviews/set_rating"
			params ={ 'image_id' : image_id, 'emp_id' : emp_id,'review' : review,'rating' :rating };
		}
			
		$.ajax({
			url : get_url,
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					if(req == "1")
					{
						show_review_details(data['message']['rating'],data['message']['review']);
						// alert(data['message']['rating']);
					}
					else
					{
								$('.review').hide();
					}
					
				}
				else
				{
					alert(JSON.stringify(data));
				}
			}
		});
		
		
	}


//  filter save and open
	function filter_save_get_http(emp_id,type_id,brand_id,search_emp_id,principal_id,filter_name,rate_filter,req)
	{
		var get_url;
		var params ={};
		
		if (req == "1")
		{
			get_url = "save_filters/get_filter_details"
			params ={ 'emp_id' : emp_id};
		}
		else
		{
			get_url = "save_filters/save_filters"
			params ={  'emp_id' : emp_id,'type_id' : type_id,'brand_id' :brand_id ,'search_emp_id' : search_emp_id,'principal_id' : principal_id,'rating' : rate_filter,'filter_name' : filter_name};
		}
			// alert(JSON.stringify(params)+"  "+get_url);
		$.ajax({
			url : get_url,
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					if(req == "1")
					{
						// alert(JSON.stringify(data['message']));
						
						show_saved_filters(data['message']);
						
					}
					else
					{			
									$('.save_pop').hide();
						// alert(JSON.stringify(data['message']));
					}
					
				}
				else
				{
					alert(data['message']);
				}
			}
		});
		
		
	}

// 			GET CUSTOMER DETAILS & STORE IMAGES
	function post_images_and_customer_details(encode_date,customer_code,get_about_text,req)
	{
			var params = {};
			var post_image_customer_url ="";	
				if (req == 1)
				{					
					var curren= $("#date").val()+" "+$("#time").val();
					 params ={'data' : encode_date,'customer_code' : customer_code,'code' : sessionStorage['user_code'],'image_date' : curren, 'about_text' : get_about_text};
					 post_image_customer_url = "uploaded_images/store_image";
				}
				else
				{
					 post_image_customer_url = "uploaded_images/show_customer_details";
				}
		
			// alert(JSON.stringify(params)+"  "+get_url);
		$.ajax({
			url : post_image_customer_url,
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					if (req == 1)
					{	
						// alert(JSON.stringify(data['message']));
									$('.upload_image').hide();

					}
					else
					{
						customer_details =	data['message'];
						show_customer_drop_down(customer_details);
						// alert(JSON.stringify(data['message']));
					}
				}
				else
				{
					alert(data['message']);
				}
			}
		});
		
	}

	
// 			LOGIN AUTHENTICATION
	function login_authentication(username,password)
	{
		
			var params ={'user_code' : username,'password' : password};
		
			// alert(JSON.stringify(params)+"  "+get_url);
		$.ajax({
			url : "employee_authentications/login_user",
			data : params,
			type : "post",
			error : function(error) {
				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					var session_check = "1";
						sessionStorage['user_name'] = data['message']['user_name'];
						sessionStorage['user_code'] = data['message']['user_code'];
						sessionStorage['user_role'] = data['message']['user_role'];
						sessionStorage['session_check'] = session_check;
						
						$('#usr_name').val("");
 						$('#password').val("");
						$('#viewer').text(""+sessionStorage['user_name']);
						user_authentication();
									$('.login').hide();
						var div = document.getElementById('container');
						while(div.firstChild){
						div.removeChild(div.firstChild);
						}
						location.reload();
						get_image();

						// alert(JSON.stringify(data['message']));
				}
				else
				{
					alert(data['message']);
				}
			}
		});
		
	}

	
// 	 Adminn create new User 

	function admin_create_new_employee(employee_code,employee_name,employee_password,employee_role,req)
	{
		var params;
		
		if (req == 1)
		{
			 params ={'user_code' : employee_code};
		}
		else if (req == 2)
		{
			 params ={'user_code' : employee_code,'password' : employee_password,'role' : employee_role,'name' : employee_name};
		}
		
			// alert(JSON.stringify(params));
		$.ajax({
			url : "employee_authentications/create_new_user",
			data : params,
			type : "post",
			error : function(error) {
// 				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					 $('#employee_name').val(data['message']['name']);
					$('.employee_role').val(data['message']['role']);
				}
				else if (success == "2")
				{
					alert(data['message']);
					$('.create_new_user').hide();
				}
				else
				{
					alert(data['message']);
				}
			}
		});
	}


	
