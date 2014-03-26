
// GET CURRENT DATE TIME
function current_date()
{
	var currentTime = new Date();
	var month1 = currentTime.getMonth() + 1;
	var day1 = currentTime.getDate();
	var year1 = currentTime.getFullYear();
	var hours1 = currentTime.getHours();
	var minutes1 = currentTime.getMinutes();
	var seconds1 = currentTime.getSeconds();
	return year1 + ":" + month1 + ":" + day1 +" "+hours1+":"+minutes1+":"+seconds1;
}


