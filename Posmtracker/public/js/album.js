function putImages2(message){

// if (xmlhttp.readyState==4) 
// {
// if(xmlhttp.responseText){
// var resp = xmlhttp.responseText.replace("\r\n", ""); 
// var files = resp.split(";");
var j = 0;
for(i=0; i<message.length; i++){
if(message[i] != ""){
document.getElementById("album_list").innerHTML += '<li><div id="1" class="alb-img"><img src='+message[i]['image']+' /></div></li>';


if(j != 6){
	j++;
}
else if(j == 6){
// document.getElementById("container").innerHTML += '<p>'+(n-1)+" Images Displayed | <a href='#header'>top</a></p><br /><hr />";
j = 0;
}
}
}
// }
// }
}




function get_image2()
{
params ={ 'no' : n}
// alert(JSON.stringify(params));
$.ajax({
url : "employees/get_images",
data : params,
type : "post",
error : function(error) {
alert(JSON.stringify(error))
},
success : function(data) {
var success = data['success'];

if(success == "1")
{
putImages2(data['message']);
// alert(JSON.stringify(data['message']));
// contentHeight1 += contentHeight;
n += 1;

}
else
{
alert(JSON.stringify(data));
}
}
});

}