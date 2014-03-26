var brand_name_id_res ="";
var brand_type_id_res = "";
var albam_show_call = 0;
var marker;
var map;
var image_uploader_name,image_uploader_address,image_uploader_date;
var customer_name_details = [],customer_code_details = [];
var image_datetime,get_upload_img_customer_code;

$(document).ready(function(){
	
	var session_check = sessionStorage['session_check'];
	
	post_images_and_customer_details("encode_data","","",0);

	
	if (session_check == "1")
	{
		$('.login').hide();
		    get_image();

		// alert(""+sessionStorage['user_name']);
		$('#viewer').text(""+sessionStorage['user_name']);
	}
	
// 	Show date time
	$('#date').datepicker({ dateFormat: 'dd M, yy' });
  	$('#time').timepicker();
  	$('#time').timepicker('setTime', new Date());
	$('#date').datepicker('setDate',new Date());
	
	$("#grid_view").show();
	$("#album_view").hide();
	$(".review").hide();
	$(".add-info").hide();
	

	// $(".tag-close").click(function(e)
	// {
		// $(this).toggleClass("filter_tbg");
	// })
	
	
   resizeContainers();
   initialize();
    on_click_event();
    admin_events();
    
    get_brand_id("");
	get_dropdown_details("1");
	get_dropdown_details("2");
	get_dropdown_details("3");
    contentHeight1 = contentHeight;
   
    $(window).resize(function(){
            resizeContainers();

    });
    
    self.setInterval(function(){onscroll()},250);
	
 	
 	// 		GET UPLOAD IMAGE DATETIME
		get_upload_image_date();
		
	// $('.maxrating').raty({ score: 0,number: 5 , 
			// click : function(score, evt) {
						// var posm_val,brand_val,year_val,sr_val;
// 
					// posm_val = $("#posm_type_picker").val();
					// brand_val = $("#brand_picker").val();
					// year_val = $("#year_picker option:selected").text();
					// sr_val = $("#sr_picker").val();
// 
				// // alert(""+posm_val+"    "+brand_val+"   "+year_val+"  "+sr_val);
				// get_filter_image(posm_val,brand_val,year_val,sr_val,score); 		},
			// starOff: '../img/star-off.png',
			// starOn : '../img/star-on.png',
			// size : 25
			// });
	

	}); 
	
	
// 	ON click event jquery
	function on_click_event()
	{
		
      $("#grid").click(function(e)
		{
			$('#grid').attr('src',"img/grid.png");
			$('#album').attr('src',"img/album.png");
			
			$(".clear_all_img").trigger("click");
	
			$("#grid_view").show();
			$("#album_view").hide();
		})
	
		
		
		
		$(".close").click(function(e)
		{
			$(".pop").hide();
		})
		
		
		
		$(".grey-scale").click(function(e)
		{
			$(".pop").hide();
		})
		
		
		
		$("#album").click(function(e)
		{
	
				$('#grid').attr('src',"img/grid1.png");
			$('#album').attr('src',"img/album1.png");
			
			albam_show_call++;
			if (albam_show_call == 1)get_filter_image("","","","","","");
			
			$("#grid_view").hide();
			$("#album_view").show();
	
		})
		
		
		
		$('.clear_all_img').click(function(){
			
			// alert("hai");
			$("#posm_type_picker").val("0");
			$("#brand_picker").val("0");
			$("#year_picker").val("0");
			$("#sr_picker").val("0");
			$('#rate_picker').val("0");
			$(".filter_t12").hide();
			// $('.maxrating').raty('reload');
			// $("#grid").trigger("click");
	
			// get_filter_image("","","","");	
		});
		
			
			
			$('#save_button').click(function(){
					if($('#Saving_name').val() != "")
					{
						// alert("hai1");
						save_filter_onclick(sessionStorage['user_code'],$('#Saving_name').val());
					}
					else
					{
						alert("Please enter filter name");
					}
				});
				
				
				
	 	
	// 	LOGIN ONCLICK EVENT 
	 	$('#login_button').click(function(){
	 		
	 		var user_name = $('#usr_name').val();
	 		var password = $('#password').val();
	 		
	 		if(user_name != "" && password != "")
	 		{
	 			login_authentication(user_name,password);
	 			
	 		}
			else
			{
				 	alert("Pleas Enter User name & Password");
			}
	 	});
		
		
		
		 $("#log_out").click(function()
			{
				sessionStorage['user_name'] = "";
				sessionStorage['user_code'] = "";
				sessionStorage['user_role'] = "";
				sessionStorage['session_check'] = "0";
				$('#viewer').text("");
				$("#grid").trigger("click");
				
  				$(".right_div").show();
				$(".view_set").show();				
				$('.login').show();
				$('#create_new_employee').hide();
				resizeContainers();
				
			});
			
			
			
			
			$(".upload_button").click(function()
			{
				// var get_selected_value = $('#customer_select_option option:selected').val();
				var get_about_value = $('#upload_textarea').val();
				// alert(get_about_value);
				if(get_upload_img_customer_code != "" && get_about_value != "")
				{
	
					upload_images($('#blah').prop('src'),get_upload_img_customer_code,get_about_value);
									$('.ajax_loader').show();

				}
				else
				{
					alert('Please enter about image & select customer name');
				}
			});
			
			
	}


// 	RESIZE WINDOW CALL THIS FUNCTION    
	function resizeContainers() {
		var $window = $(window);
		var wWidth  = $window.width();
		var wHeight = $window.height();
		
		if(sessionStorage['user_role'] == "ADMIN")
		{
			$(".left_div").css("width", (wWidth*100/100) + "px");
			$("#container").css("width", (wWidth*100/100) + "px");	
			$(".right_div").hide();
			$(".view_set").hide();
			$('#create_new_employee').show();

		}
		else
		{
			 $(".left_div").css("width", (wWidth*75/100) + "px");
		    $("#container").css("width", (wWidth*75/100) + "px");
		    $(".right_div").show();
			$(".view_set").show();
			$('#create_new_employee').hide();

		}			
		
		if(sessionStorage['user_role'] == "READ ONLY")
		{
			$("#add-pic").hide();
			$("#save").hide();
			$("#saved_filter").hide();
			
		}
		else if(sessionStorage['user_role'] == "EDITABLE")
		{
			$("#add-pic").hide();
			$("#save").show();
			$("#saved_filter").show();
		}
		else{
			$("#add-pic").show();
			$("#save").show();
			$("#saved_filter").show();
		}
		
		    $(".container").css("width", (wWidth*100/100) + "px");
		    $(".container").css("height", (wHeight*100/100) + "px");
		   		    $(".left_div").css("height", (wHeight*92/100) + "px");
		    $("#container").css("height", (wHeight*92/100) + "px");
		    $("#map_canvas").css("width", (wWidth*23/100) + "px");
		    $(".info").css("width", (wWidth*23.125/100) + "px");
		    $(".user_area").css("width", (wWidth*20/100) + "px");
		    $("#map_canvas").css("height", (wHeight*20/100) + "px");
		    $(".user_area").css("height", (wHeight*25/100) + "px");
		    $(".employee_list").css("width", (wWidth*20/100) + "px");
		    $(".employee_list").css("height", (wHeight*70/100) + "px");
		    $(".right_div").css("height", (wHeight*92/100) + "px");
		    $(".right_div").css("width", (wWidth*25/100) + "px");
		    $(".top_div").css("height", (wHeight*8/100) + "px");
		    $(".top_div").css("width", (wWidth*100/100) + "px");
		    $("#timeline").css("width", (wWidth*80/100) + "px");
		    $(".emp_search").css("height", (wHeight*5/100) + "px");
		    $(".emp_search").css("width", (wWidth*17.65/100) + "px");
		    $(".grey-scale").css("width", (wWidth*100/100) + "px");
		    $(".grey-scale").css("height", (wHeight*100/100) + "px");
		    $(".single_pic").css("width", (wWidth*21.5/100) + "px");
		    $(".single_pic").css("height", (wWidth*18/100) + "px");
		    $("#my-folio-of-works2").css("height", (wHeight*92/100) + "px");
	}


	
// 	REVIEW AND RATING ONCLICK EVENT
		function show_review(id,image_id)
		{
			var i = 0;
			// show_map_details();
			review_reting_http(id,sessionStorage['user_code'],"","",1)
			$("#review_img").attr("src",$('#'+image_id+' img').prop('src'));
			
			$('#rating_review_done').click(function(){
				if(i == 0)
				{
					var score = $('#rating_star').raty('score');
					var review_text = $('#text_block').val();
					// alert(""+review_text+"    "+score);
					review_reting_http(id,sessionStorage['user_code'],review_text,score,0)
						// alert($('#rating_star').raty('score'));
				i++;
				}
			});
			
		}
		
		
		
		function show_review_details(score_,review){
			$('.review').show();
			
			// alert(score_);
			if(score_ != 0 || score_ != "")
			{
				$('#rating_star').raty({ score: score_,number: 5 ,readOnly: true,
				starOff: '../img/star-off1.png',
				starOn : '../img/star-on1.png',
				size : 25
				});
			}
			else
			{
				$('#rating_star').raty({ score: score_,number: 5 ,
				starOff: '../img/star-off.png',
				starOn : '../img/star-on.png',
				size : 25
				});
			}
			
			$('#text_block').val(review);

		}
		
	function show_image_click(id,lat,lng,on_click_id)
		{
			// alert(id);
			get_image_details(id);
			show_pin1(lat,lng);
			
			$('.single_pic1').removeClass('single_pic_click');

			$("#"+on_click_id).addClass('single_pic_click');
		}
		
		
		function upload()
		{
			$('.upload_image').show();
			$('#blah').attr('src', '#');
			$('#blah').hide();
			$("#text_upload").show();
			$("#upload_textarea").val("");
			$('#customer_select_option1').val('');
			$('#time').timepicker('setTime', new Date());
			$('#date').datepicker('setDate',new Date());	
			$('.ajax_loader').hide();
	
			get_upload_img_customer_code = "";
				
			upload_img();

		}
		
// 	 TAG CLICK EVENT
	function show_tag(id)
	{
		
		
		$('.add-info').show(function(){
			// alert(id);
			
				$("#show_tag_list").remove();
				
				get_brand_id(id);
							
		});
		
		$('.done').unbind("click").click(function(){
		 		var nn = [],mm=[],oo =[],emp_code_ = [];
		 		var inc_ = 0;
		 		for (var i=0;i<4;i++){
		 			
		 			
		 			var n = $("#m"+i+"s").val();
		 			var m = $("#n"+i+"s").val();
		 			var o = $("#o"+i+"s").val();
		 			
		 			if(n != 0 && m != 0 && o!= 0)
		 			{
		 				nn[inc_] = n;
		 				mm[inc_] = m;
		 				oo[inc_] = o;
		 				
		 				
		 				if (tag_employee_code.length >= inc_+1)
		 				{
		 					emp_code_[inc_] =tag_employee_code[inc_];
		 				}
		 				else
		 				{
		 					emp_code_[inc_] = sessionStorage['user_code'];
		 				}
		 				
		 				inc_ += 1;
		 			}
		 			
		 			if($("#m"+i+"s").is(':disabled') == true && $("#n"+i+"s").is(':disabled') == false)
					{
						// alert(i)
						// alert(emp_code_);
						emp_code_[i] = sessionStorage['user_code'];
						// alert(emp_code_);

					}
		 		}
					
		 			
		 			set_brand_id(id,nn,mm,oo,tag_id,emp_code_);

		 		// alert(nn+"    "+mm);
		 	
		 });
		
	}

// 	 IMAGE GALLERY
	function putImages_gal(message){
			// alert("hai");
			$('#my-folio-of-works2').remove();
			
			$("#album").trigger("click");
			
			$("#my-folio-of-works").append("<div id='my-folio-of-works2'></div>")
			resizeContainers();
			// $("div#my-folio-of-works").append("<ul></ul>");
			for(var i in message) {
				// alert("dd");
				// alert(message[i]['id']);
				// var hash ={};
				// hash = {image: message[i]['image'],thumb: message[i]['image'],big: message[i]['image']};
				
				// alert(hash);
				
				// document.getElementById("my-folio-of-works").innerHTML += "<div id="+message[i]['id']+" class=alb-img><img src="+message[i]['image']+" /></div>";
				
				
				
				document.getElementById("my-folio-of-works2").innerHTML += "<a href="+message[i]['image']+" id="+message[i]['id']+"><img src="+message[i]['image']+" /></a>";
				// image_list[i] = hash;
				
				// $("div#my-folio-of-works ul").append(li);
			}
			Galleria.loadTheme('../js/galleria.classic.min.js');
			Galleria.run('#my-folio-of-works2');
	}
	
	
	
		function show_brand_picker(brand_dropdown,id11){
			
			var selectHTML ="";
					for(kl=0;kl<brand_dropdown.length;kl++)
					{
						if (kl == 0)
						{
							selectHTML+= "<option value=''></option>";

						}
						        selectHTML+= "<option value='"+brand_dropdown[kl]["id"]+"'>"+brand_dropdown[kl]["name"]+"</option>";

					}	
					        document.getElementById(id11).innerHTML= selectHTML;			
		}
		
		
	function filter_change()
	{
					albam_show_call++;

		var posm_val,brand_val,year_val,sr_val,get_rate;
		posm_val = $("#posm_type_picker").val();
		brand_val = $("#brand_picker").val();
		year_val = $("#year_picker").val();
		sr_val = $("#sr_picker").val();
		get_rate = $('#rate_picker').val();
		$(".filter_t12").hide();

		// get_rate = $('.maxrating').raty('score');

				// alert(""+posm_val+"    "+brand_val+"   "+year_val+"  "+sr_val);

		get_filter_image(posm_val,brand_val,year_val,sr_val,get_rate,"");
	}	

// Toggle close event 
	function toggle_close(id)
	{
		
		var nn = ["posm_type_picker","brand_picker","year_picker","sr_picker"]
		var posm_val,brand_val,year_val,sr_val,get_rate;
		
		$("#"+nn[id-1]).val("0");
		$('#rate_picker').val("0");


		posm_val = $("#posm_type_picker").val();
		brand_val = $("#brand_picker").val();
		year_val = $("#year_picker").val();
		sr_val = $("#sr_picker").val();
		get_rate = $('#rate_picker').val();
		$(".filter_t12").hide();
		// get_rate = $('.maxrating').raty('score');

		
		get_filter_image(posm_val,brand_val,year_val,sr_val,get_rate,"");
		
				
		// $(".filter_t"+id).toggleClass("filter_tbg");

		// alert(id);
		
	}


	function show_pin1(lat,lng)
	{
		try{
				 var actual_latlong = new google.maps.LatLng(lat,lng);
				 	   	var bounds = new google.maps.LatLngBounds(actual_latlong);


				if (marker !=null)
				{
					marker.setMap(null);   
				}

			   marker = new google.maps.Marker({
			    position: actual_latlong,
			    title:"Hello World!",
			    draggable:true,
			    animation: google.maps.Animation.DROP
			    
				});
				
				marker.setMap(map);
				map.fitBounds(bounds);
				map.panToBounds(bounds); 
				
			}
		     catch(e){}
	  
	}
	
	

	
	
	 // function putImages_gal(message){
			// // alert("hai");
			// $('#my-folio-of-works2').remove();
// 			
			// $("#my-folio-of-works").append("<div id='my-folio-of-works2'></div>")
			// resizeContainers();
			// $("div#my-folio-of-works2").append("<ul id=add_img></ul>");
			// for(var i in message) {
// 			
// 				
				// document.getElementById("add_img").innerHTML += "<li><img src="+message[i]['image']+"></li>";
				// // image_list[i] = hash;
// 				
				// // $("div#my-folio-of-works ul").append(li);
			// }
// 			
			 // $("div#my-folio-of-works2").slideViewerPro({
	        // thumbs: 7, 
	        // autoslide: true, 
	        // asTimer: 3500, 
	        // typo: true,
	        // galBorderWidth: 0,
	        // thumbsBorderOpacity: 0, 
	        // buttonsTextColor: "#707070",
	        // buttonsWidth: 40,
	        // thumbsActiveBorderOpacity: 0.8,
	        // thumbsActiveBorderColor: "aqua",
	        // shuffle: true
	    // });
			// // Galleria.loadTheme('../js/galleria.classic.min.js');
			// // Galleria.run('#my-folio-of-works2');
	// }
	
	