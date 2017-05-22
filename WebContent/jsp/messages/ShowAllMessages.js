function showAllMessages(friendId)
{
	//alert(friendId);
	$('#AllMessages').load('./RightDiv.jsp');
	$('.LeftDivList').filter(function() {
	    var match = '#6D84B4'; // match background-color: black
	    /*
	        true = keep this element in our wrapped set
	        false = remove this element from our wrapped set
	                                                         */
	    return ( $(this).css('background-color') != match );

	}).css('background-color', ''); // change background color of all black spans
	document.getElementById(friendId).style.backgroundColor = "#6D84B4";
	var friend = friendId.split(",");
	//alert(friend[1]);
	//$('#action-buttons-div').remove();
	$("#recipientId").val(friend[0]);
	$("#dummyRecipientName").val(friend[1]);
	
	//alert(friend[0]+friend[1]);
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
		    document.getElementById("conversations-row").innerHTML=xmlhttp.responseText;
		    //event.preventDefault();
		   
	    }
	  }
	
	xmlhttp.open("POST","getAllMessages?friendId="+friend[0]+"&friendName="+friend[1],true);
	xmlhttp.send();
	ChangeOtherPartDiv(friend[1]);
}
function ChangeOtherPartDiv(friend)
{
	$("#other-participants-div").html("<b>"+friend+"</b>");

}