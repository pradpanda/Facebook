function search()
{
	var name=document.getElementById('recipients-text').value;
	if(name)
		searchFriends(name);
}
function searchFriends(name)
{
	//alert("im here");
	//alert("I,m here 1");
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			 console.log(xmlhttp.responseText);
		    document.getElementById("friendList").innerHTML=xmlhttp.responseText;
		    //event.preventDefault();
		   
	    }
	  }
	
	xmlhttp.open("POST","listFriends?name="+name,true);
	xmlhttp.send();
	// event.preventDefault();
	//event.preventDefault();
}
function selectedFriend(id)
{
	//alert(id);
	//alert(document.getElementById(id).innerHTML);	
	document.getElementById("recipients-text").value = document.getElementById(id).innerHTML;
	$("#dummyRecipientName").val(document.getElementById("recipients-text").value);
	document.getElementById("friendList").innerHTML="";
	$("#recipientId").val(id);
}