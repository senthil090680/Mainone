
	
// 	GOOGLE MAP SHOW DETAILS    
	function initialize(){
	
// 	    	var lat = 9.752370, lng = 7.996330;

       var center= new google.maps.LatLng(9.752370,7.996330);
       var myOptions = {
                zoom: 7,
                center: center,
                mapTypeControl: true,
                mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
                navigationControl: true
                
       }     
       map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);  
      
}




function show_pin1(lat,lng)
	{
		try{
				var actual_latlong = new google.maps.LatLng(lat,lng);
				var bounds = new google.maps.LatLngBounds(actual_latlong);


  		var center= new google.maps.LatLng(lat,lng);
       var myOptions = {
                zoom: 11,
                center: center,
                mapTypeControl: true,
                mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
                navigationControl: true
                
       }     
       map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);  


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
				map.panToBounds(bounds); 
				
			}
		     catch(e){}
	  
	}	

function show_map_details()
{
	
					$("#show_p_details").remove();

					$(".info").append("<p id=show_p_details>Image by : "+image_uploader_name+"<br />"+image_uploader_date+"<br />"+image_uploader_address+"<br /></p>");

	
}


// 	show address details using latitude & longitude
	function get_address_details(lat,lng)
	{
		var address;
		 var geocoder = new google.maps.Geocoder();
		  var latlng = new google.maps.LatLng(parseFloat(lat), parseFloat(lng));
		  // var latlng = new google.maps.LatLng("", "");

			try{
			geocoder.geocode({'latLng': latlng}, function(results, status) {
				
				if (status == google.maps.GeocoderStatus.OK) {
				    	
				      if (results[1]) {
				        // alert(results[1].formatted_address);
						image_uploader_address = results[1].formatted_address;
						show_map_details();
				      // return results[1].formatted_address;
				      } else {
				        // alert(status);

						image_uploader_address = "lat : "+lat+"     lng : "+lng;
						show_map_details();
				      }
				    } else {
				        // alert(status);

						image_uploader_address = "lat : "+lat+"     lng : "+lng;
						show_map_details();
				    }
			});
				  
				   
			}
			catch(e)
			{
				alert(e);
			}
		
	}

