function SendMessage()
{
	var text=document.getElementById("new-message-textarea").value;
	if(text!="")
	{
		var recipient_name;
		if($("#remove-this-after1").html()!=null && $("#remove-this-after2").html()!=null)
		{
			recipient_name=document.getElementById("recipients-text").value;
			$("#other-participants-div").html("<b>"+recipient_name+"</b>");
			$("#remove-this-after1").remove();
			$("#remove-this-after2").remove();
		}
		var currentdate = new Date(); 
	    var datetime = currentdate.getDate() + "/" + (currentdate.getMonth()+1)  + "/" + currentdate.getFullYear()
	    			+ " " +  
	                + currentdate.getHours() + ":"  
	                + currentdate.getMinutes() + ":" 
	                + currentdate.getSeconds();
	    
	    var datetimeFormatted = currentdate.getFullYear() + "-" + (currentdate.getMonth()+1) + "-" + currentdate.getDate()
		+ " " +  
        + currentdate.getHours() + ":"  
        + currentdate.getMinutes() + ":" 
        + currentdate.getSeconds();

	    $("#conversations-row").html("<br>"+$("#conversations-row").html().trim()+"<div class='sender alert alert-success' align='right'>"+text.trim()+"<br><span class='badge'>  "+datetimeFormatted+"</span>"+"</div>");
		$("#new-message-textarea").val("");
		var elem = document.getElementById('conversations-row');
		elem.scrollTop = elem.scrollHeight;
		ajaxSendMessage(text.trim(),datetime);
	}
	else
		alert("Please enter some text!");
}
function ajaxSendMessage(text,datetime)
{
	var recipientId=document.getElementById("recipientId").value;
	var dummyRecipientName=document.getElementById("dummyRecipientName").value;
	
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
			 	document.getElementById("conversations-div").innerHTML=xmlhttp.responseText;
		    //event.preventDefault();
	    }
	  }
	
	xmlhttp.open("POST","sendMessage?recipientId="+recipientId+"&text="+text+"&datetime="+datetime,true);
	xmlhttp.send();
}