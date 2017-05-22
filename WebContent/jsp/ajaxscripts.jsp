<script>
// ---------------------------------------PROFILE----------------------------------------------------------
// ---------------------------------------PROFILE----------------------------------------------------------

function deleteorg(id)
{
 alert(id);
 
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?udob="+udob+"&ugender="+ugender,true);
	xmlhttp.send();
	}
function addbasic()
{
 var udob=document.getElementById('udob').value;
 var ugender=document.getElementById('ugender').value;
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?udob="+udob+"&ugender="+ugender,true);
	xmlhttp.send();
	}

function addlocation()
{
 var homeplace=document.getElementById('homeplace').value;
 var currentplace=document.getElementById('currentplace').value;
 
 //alert(homeplace);
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?currentplace="+currentplace+"&homeplace="+homeplace,true);
	xmlhttp.send();
	}
function addmartialstatus()
{
 var martialstatus=document.getElementById('martialstatus').value;
 
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?martialstatus="+martialstatus,true);
	xmlhttp.send();
	}

function addinstitute()
{
 var institutename=document.getElementById('institutename').value;
 var degree=document.getElementById('degree').value;
 var studiedfrom=document.getElementById('studiedfrom').value;
 var studiedto=document.getElementById('studiedto').value;
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?institutename="+institutename+"&degree="+degree+"&studiedfrom="+studiedfrom+"&studiedto="+studiedto,true);
	xmlhttp.send();
	}

function addorg()
{
 var orgname=document.getElementById('orgname').value;
 var designation=document.getElementById('designation').value;
 var wf=document.getElementById('workingfrom').value;
 var wt=document.getElementById('workingto').value;
 
 var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./submitabout?organizationname="+orgname+"&designation="+designation+"&workingfrom="+wf+"&workingto="+wt,true);
	xmlhttp.send();
	}
function viewwork()
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("aboutcenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./editaboutwork",true);
	xmlhttp.send();
}

function getprofile(userid)
{
	
	//alert(userid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./getprofile?userid="+userid,true);
	xmlhttp.send();
}
function getfriendprofile(friendid)
{   
	//alert(friendid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("facebookmaincenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./friendprofile?userid="+friendid,true);
	xmlhttp.send();
}

function getfriends(userid)
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./getfriends?userid="+userid,true);
	xmlhttp.send();
	}



function getmutualfriends(userid,frid)
{   alert(userid);
    alert(frid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("facebookmaincenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./mutualfriends?userId="+userid +"&friendId=" +frid,true);
	xmlhttp.send();
}


function addtofriends(loggedinid,frid)
{   
	
	$(this).val("changed");
    alert(loggedinid);
    alert(frid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("facebookmaincenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./addSuggestedFriend123?userId="+loggedinid +"&friendId=" +frid,true);
	xmlhttp.send();
	
	
	
}


function getmutualfriends(userid,frid)
{   alert(userid);
    alert(frid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("facebookmaincenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./mutualfriends?userId="+userid +"&friendId=" +frid,true);
	xmlhttp.send();
}



function loadallfriends()
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  alert("i");
	xmlhttp.open("POST","./editabout",true);
	xmlhttp.send();
	}
function getabout(userid)
{
    alert(userid);
	
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./editabout?userid="+userid,true);
	xmlhttp.send();
}

function gettimeline(userid)
{
	//alert("i m here");
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("timelinecenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./gettimeline?userid="+userid,true);
	xmlhttp.send();
}
function getmyprofile(userid)
{
	//alert(userid);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  xmlhttp=new XMLHttpRequest();
	else
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    document.getElementById("facebookmaincenter").innerHTML=xmlhttp.responseText;
	  };
	  //alert("i");
	xmlhttp.open("POST","./profile?userid="+userid+"&mainuserid="+userid,true);
	xmlhttp.send();
}
function gotoMessages()
{
	$("#facebookmaincenter").load("jsp/messages/inbox.jsp");
	$(document).ready(function(){
	    $.ajax({url: "getMessageLeftDiv", success: function(result){
	        $("#conversations-div").html(result);
	    }});
	}); 
}
function createNewMessage()
{
	$('#right-div').load('jsp/messages/CreateNewMessage.jsp');
}
function displayevents()
{   alert("hi");
	$('#facebookmaincenter').load('jsp/event/eventpage.jsp');
}
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

window.setInterval(function(){
	  /// call your function here
		//alert("Hi");
		
		if($("#other-participants-div").text()==$("#dummyRecipientName").text())
		{
			//alert($("#other-participants-div").text()+" "+$("#dummyRecipientName").text());
			var received = $.post("RecipientMessage",{
				id: document.getElementById("recipientId").value,
				lastTimestamp: $('#conversations-row span.badge:last').text()
		    });
			received.done(function(response){
				
				//var receivedMessage = [];
				/*$.each(response, function(key, value){
					$("#conversations-row").append("<br><div class='receiver alert alert-info' align='left'>"+key + ":" + value + "</div>");
					var elem = document.getElementById('conversations-row');
					elem.scrollTop = elem.scrollHeight;
		        });*/
					$.each(response.RecipientMessages, function(index, recipient){
						//receivedMessage.push({ timestamp : recipient.timestampMessage, message : recipient.messagedetails });
						if(recipient.messagedetails!=null)
						{
							$("#conversations-row").append("<br>"+$("#conversations-row").html().trim()+"<div class='receiver alert alert-info' align='left'>"+recipient.messagedetails.trim()+"<br><span class='badge'>  "+recipient.timestampMessage+"</span>"+"</div>");
							//alert("Hi"+recipient.messagedetails.trim());
							var elem = document.getElementById('conversations-row');
							elem.scrollTop = elem.scrollHeight;
						}
					});
				
			});
		}
	}, 10000);
	window.setInterval(function(){
		var recipientIdNew=document.getElementById("recipientId").value;
		var dummyRecipientNameNew=document.getElementById("dummyRecipientName").value;
		if(dummyRecipientNameNew==$("#other-participants-div").text())
			document.getElementById(recipientIdNew+","+dummyRecipientNameNew).style.backgroundColor = "#6D84B4";
	}, 500);
	function showAllMessages(friendId)
	{
		//alert(friendId);
		$('#AllMessages').load('jsp/messages/RightDiv.jsp');
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
	
	function eventsubmit(form)
	{   
		alert("sxdcfvhjkl");
		var xmlhttp;
		if (window.XMLHttpRequest)
		  xmlhttp=new XMLHttpRequest();
		else
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    document.getElementById("middleandright").innerHTML=xmlhttp.responseText;
		  };
		xmlhttp.open("POST","./createnewevent",true);
	   var formData = new FormData(form);
		xmlhttp.send(formData);
	}
	
	function addtofriends()
	{   
		/* $(document).ready(function(){
			$('#addfrnd').click(function() 
					{ */ 
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				      $.post('addSuggestedFriend123', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { $("#addfrnd").hide();
					      $("#sent").show();
					    }
					  ); 
			/* 		});  
		});  */
	}
	
	
	function Withdrawfrndreq()
	{   
		
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				      $.post('withdrawfriendrequest', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { 
				    	  $("#sent").hide();
				    	  $("#addfrnd").show();
					    }
					  ); 
		
	}
	
	function removefriends()
	{   
		
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				      $.post('removefiends', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { 
				    	  $("#purefrnd").hide();
				    	  $("#addfrnd").show();
					    }
					  ); 
		
	}
	
	function blockfriends()
	{   
		
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				      $.post('blockedfriends', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { 
				    	  $("#sent").hide();
				    	  $("#addfrnd").show();
					    }
					  ); 
		
	}
	
	function acceptfriends()
	{   
		
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				       alert("hello");
				       $.post('acceptfriends', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { $("#purefrnd").show();
				    	  $("#respond").hide();
				    	  
					    }
					  ); 
		
	}
	
	function rejectfriends()
	{   
		
				     console.log("working");
				
				       var loggedinuser = document.getElementById('logedinuser').value;
				       var frid = document.getElementById('frid').value;
				      $.post('rejectfriends', { userId : loggedinuser,friendId : frid },
					  function(Response)
					    { 
				    	  $("#respond").hide();
				    	  $("#addfrnd").show();
					    }
					  ); 
		
	}
	
</script>