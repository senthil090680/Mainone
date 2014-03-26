var $window = $(window);
var wWidth = $window.height();
var contentHeight = (wWidth*75/100);
var auto_load_position = (wWidth*80/100);
var contentHeight1;
var pageHeight = document.documentElement.clientHeight;
var scrollPosition;
var n = 0;
	
	function putImages(message){
	
	
		var j = 0;
		for(i=0; i<message.length; i++){
			if(message[i] != ""){
				var content_text = message[i]['content'].split(' ').join('&nbsp;');
				var container_inner = "<div class=single_pic onclick=show_image_click("+message[i]['id']+","+message[i]['lat']+","+message[i]['lng']+",'1n1"+message[i]['id']+"')>"
																	+"<div id='1n1"+message[i]['id']+"' class=single_pic1>"
																		+"<img class=picture src="+message[i]['image']+" />"
																		+"<div class=star>";
																			
				
				if(sessionStorage['user_role'] != "ADMIN" && sessionStorage['user_role'] != "READ ONLY")
				{
					container_inner +="<a href=# class=reviewer tag_gallery onclick=show_review("+message[i]['id']+",'1n1"+message[i]['id']+"') id="+message[i]['id']+"><img src=img/reviewer.png /></a>";
																			
				}
				
				if(sessionStorage['user_role'] != "READ ONLY")
				{
					container_inner +="<a href=# class=tagger tag_gallery onclick=show_tag("+message[i]['id']+") id="+message[i]['id']+"><img src=img/tagger.png /></a>";
				}							
												container_inner +="<a href=# class=about_ic tag_gallery onclick=show_about('"+content_text+"','1n1"+message[i]['id']+"')><img src=img/about.png /></a>"
																		+"</div>"
																	+"</div>"
																+"</div>";
				
				
				document.getElementById("container").innerHTML += container_inner;
				j++;
				
				// ,"+message[i]['rating']+","+message[i]['review']+"
				
				if(j == 3 || j == 6){
					// document.getElementById("container").innerHTML += '<br />';
				}		
				else if(j == 9){
					// document.getElementById("container").innerHTML += '<p>'+(n-1)+" Images Displayed | <a href='#header'>top</a></p><br /><hr />";
					j = 0;
				}
			}
		}

		resizeContainers();
	}

	function onscroll(){
		// alert('hai');
		if(navigator.appName == "Microsoft Internet Explorer")
			scrollPosition = document.documentElement.scrollTop;
		else
			scrollPosition = document.getElementById("container").scrollTop; 
			// alert((contentHeight1 - pageHeight - scrollPosition));
			var height123 = document.getElementById("container").style.pixelHeight;
			// alert(contentHeight1);
			// alert(pageHeight);
			// alert(scrollPosition);
			// alert(contentHeight1 - pageHeight - scrollPosition);
			if((contentHeight1 - pageHeight - scrollPosition) < auto_load_position){
				
				var session_check = sessionStorage['session_check'];
				if (session_check == "1")
				{
						if (n!=0)
						{
						get_image();
						}
				}		
				// get_filter_image();
				// alert(contentHeight1 - pageHeight - scrollPosition);
				 n += 1;
			}
	}
	
	
// 	 About onclick method
	function show_about(text_val,id)
	{
		var content_text = text_val.split('&nbsp;').join(' ');
		$(".about").show();
		$("#about_content").text(content_text);
		
		
		$("#about_img").attr("src",$('#'+id+' img').prop('src'));
		
	}
	
	
