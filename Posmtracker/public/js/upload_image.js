// 	GET UPLOAD IMAGE DATE 
function get_upload_image_date()
{
	$( "#upload_button" ).change(function(e) {
// 			GET Date Time
			EXIF.getData(e.target.files[0], function() {
				
				 var make = EXIF.getTag(this, "DateTimeOriginal");
				 var make1 = EXIF.getTag(this, "DateTime");

				if (make != null)
				{
					// alert("1");
					image_datetime = make;
				}else if(make1 != null)
				{
					// alert("2");
					image_datetime = make1;
				}else
				{
					// alert("3");
					var currentdate12 = current_date();
					// alert(""+currentdate12);

					image_datetime = currentdate12;
				}
				
								 // alert(image_datetime);
				// alert(image_datetime);
				var image_datetime1 = image_datetime.split(" ");
					var date_only = image_datetime1[0].replace(/:/g,"-");
					image_datetime = date_only+" "+image_datetime1[1];
					
					
					show_datetime_cal(image_datetime);
					// ('#time').timepicker('setTime', new Date());


				// alert(""+JSON.stringify(e.target.files[0]));
        	// alert(EXIF.pretty(this));
        	
    	});
		});
	
}



function upload_img()
{
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
                
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#upload_button").change(function(){
        readURL(this);
        $('#blah').show();
        $("#text_upload").hide();

    });
 }
 
 
 
//  UPLOADED IMAGE TO SERVER
	function upload_images(img_path,customer_code,get_about_value)
	{
	    	var encode_date = getBase64Image(img_path,customer_code,get_about_value);
	    		    	// var encode_date = getBase64Image($('#tag-close1').prop('src'));

			// post_images(encode_date,"png");		
	}
	
	
	function getBase64Image(URL,customer_code,get_about_value) {

	
			var img = new Image();
		    img.src = URL;
		    img.onload = function () {
		
		
		    var canvas = document.createElement("canvas");
		    canvas.width =this.width;
		    canvas.height =this.height;
		
		    var ctx = canvas.getContext("2d");
		    ctx.drawImage(this, 0, 0);
		
		
		    var dataURL = canvas.toDataURL("image/png");
			var encode_data = dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
		    // alert(encode_data);
		    
		    post_images_and_customer_details(encode_data,customer_code,get_about_value,1);
		// alert(encode_data);
		        return encode_data;
    }
	
	
}


function show_datetime_cal(image_datetime)
{
	var queryDate = image_datetime,
    					dateParts = queryDate.match(/(\d+)/g)
    					realDate = new Date(dateParts[0], dateParts[1] - 1, dateParts[2],dateParts[3],dateParts[4]),  
						realtime = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
					var time_cal;
						
					$('#date').datepicker('setDate',realDate);
					// ('#time').timepicker('setTime', realDate);
					
					if (dateParts[3] <12)
					{
						time_cal = dateParts[3]+":"+dateParts[4]+"am"
					}
					else
					{
						if (dateParts[3] == 12)
						{
							time_cal = dateParts[3]+":"+dateParts[4]+"pm"
						}
						else{
							time_cal = parseInt(dateParts[3]-12)+":"+dateParts[4]+"pm"
						}
					}
					document.getElementById('time').value = time_cal;
}


//  UPLOADED PHOTO SHOW CUSTOMER DROPDOWN DETAILS
		function show_customer_drop_down(customer_code){
		
				// var selectHTML = "",kl;
// 	
				// for(kl=0;kl<customer_code.length;kl++)
				// {
					// if (kl == 0)
					// {
						// selectHTML+= "<option value='0'>Customer Name</option>";
// 	
					// }
					        // selectHTML+= "<option value='"+customer_code[kl]["code"]+"'>"+customer_code[kl]["name"]+"</option>";
				// }	
				        // // $('s'+k).appand(selectHTML);
				        // document.getElementById('customer_select_option').innerHTML= selectHTML;
				     // var selected_value;
				     // $("#customer_select_option").autocomplete({
       						 // select: function(event, ui) {
        					 // selected_value = $(ui).val();
        					 // }
    					// });
    				 $("#customer_select_option1").autocomplete({
       						source: function( request, response ) {
       							var params = {search : ""+$("#customer_select_option1").val() };
       							
					        $.ajax({
					          url: "customer_details/auto_suggest",
					          data: params,
							  type : "post",
					          success: function( data ) {
					          	
					            response( $.map( data, function( item ) {
					              return {
					                label: item.customer_name,
					                value: item.customer_code
					              }
					            }));
					          }
					        });
					      },
					      minLength: 1,
					      select: function( event, ui ) {
					      	
							$("#customer_select_option1").val(ui.item.label);
							get_upload_img_customer_code = ui.item.value;
					        log( ui.item ?
					          "Selected: " + ui.item.label :
					          "Nothing selected, input was " + this.value);
					      },
					      open: function() {
					        $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
					      },
					      close: function() {
					        $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
					      }
						})
								 		    // var value = $("#customer_select_option").val();			  
								 		      // alert(value);

		}
	
	
		
 