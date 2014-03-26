// 	FILTER SAVE PAGE ON CLICK EVENT 
		function open_save_dialog()
		{
			$('.save_pop').show();
			$('#Saving_name').val("");

			
	
		}
		
// 	FILTER SAVED PAGES SHOW ON CLICK EVENT 
		function open_Savedfilter()
		{
			filter_save_get_http(sessionStorage['user_code'],"","","","","","",1);

			$('.saved_filter_pop').show();

		}
		
		function show_saved_details_onclick(type_id,brand_id,principal_id,search_emp_id,rating_score,created_at)
		{
			
			created_at = decodeURIComponent(created_at);
			$('.saved_filter_pop').hide();
			$("#posm_type_picker").val(type_id);
			$("#brand_picker").val(brand_id);
			$("#rate_picker").val(rating_score);
			// get_rate = $('.maxrating').raty('score');
			$("#year_picker").val(principal_id);
			$(".filter_t12").show();
			$("#savefilters_created_at").text(created_at);
			
			var posm_val1,brand_val1,year_val1,sr_val1,rate_val1;
			posm_val1 = $("#posm_type_picker").val();
			brand_val1 = $("#brand_picker").val();
			year_val1 = $("#year_picker").val();
			sr_val1 = $("#sr_picker").val();
			rate_val1 = $("#rate_picker").val();
			// if (year != null){
				// $("#year_picker option:selected").text(year);
			// }
			// else
			// {
				// $("#year_picker option:selected").text("");
// 
			// }
			$("#sr_picker").val(search_emp_id);
			// $("#album").trigger("click");
						
			
				 created_at = created_at.replace("| ","");
				get_filter_image(posm_val1,brand_val1,year_val1,sr_val1,rate_val1,created_at);



		}
		
		
		


function save_filter_onclick(emp_id,filter_name)
{
		var posm_val,brand_val,year_val,sr_val,rate_val;
		posm_val = $("#posm_type_picker").val();
		brand_val = $("#brand_picker").val();
		year_val = $("#year_picker").val();
		sr_val = $("#sr_picker").val();
		rate_val = $("#rate_picker").val();
		
						// alert(""+posm_val+""+brand_val+""+year_val+""+sr_val);

		filter_save_get_http(emp_id,posm_val,brand_val,sr_val,year_val,filter_name,rate_val,0);
		
}



// <ul>
		             		// <li><a href="#">stand pics</a></li>
		             		// <li><a href="#">Samson banner pics</a></li>
		             		// <li><a href="#">Samuel coupon pics</a></li>
		             		// <li><a href="#">Sameer poster pics</a></li>
		             	// </ul>

function show_saved_filters(details)
{
			$("#ul_list").remove();

			$("#saved_filter_list").append("<ul id=ul_list></ul>");
			for(var i in details) 
			{
			  // alert(""+details[i]['created_at1']);
			      var li = "<li onclick=(show_saved_details_onclick("+details[i]['type_id']+","+details[i]['brand_id']+",'"+details[i]['principal_id']+"','"+details[i]['search_emp_id']+"','"+details[i]['rating']+"','"+encodeURIComponent(details[i]['created_at1'])+"'))><a href=#>"+details[i]['filter_name']+"</a></li>";			
			      $("#saved_filter_list ul").append(li);
			}

}

