<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%> 

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Timeline</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css" media="screen">
table {
	border: none;
	border-collapse: collapse;
}

td {
	border: none;
}

th {
	border: none;
}

p {
	background-color: #eeeff4;
}

p.padding {
	padding-top: 25px;
	padding-bottom: 25px;
	padding-right: 50px;
	padding-left: 40px;
	border-color: #eeeff4;
}

button.padding {
	float: right;
}

div.padding {
	padding-top: 15px;
	padding-bottom: 35px;
	padding-right: 50px;
	padding-left: 40px;
	border-color: #eeeff4;
	border-style: solid;
	background-color: #eeeff4;
	border-width: 3px
}

b.q {
	font-size: 25px;
	padding-right: 800px;
}

div.box1 {
	padding-top: 30px;
	padding-left: 40px;
}

td.a {
	color: blue;
	font-size: 14px;
}

td.b {
	color: grey;
	padding-left: 0px;
	text-align: left;
	font-size: 12px;
}

b.a {
	color: #3b5999;
	font-size: 16px;
	padding-left: 55px;
}

b.b {
	color: grey;
	padding-left: 55px;
	text-align: left;
	font-size: 14px;
}
g.g {
	color: grey;
	padding-left: 0;
	text-align: left;
	font-size: 14px;
}

b.c {
	color: black;
	padding-left: 0px;
	text-align: left;
	font-size: 15px;
}
h.h {
	color: grey;
	padding-left: 0px;
	text-align: left;
	font-size: 15px;
}
i.i {
	color: grey;
	padding-left: 0px;
	text-align: left;
	font-size: 20px;
}

td.c {
	color: black;
	padding-left: 0px;
	text-align: left;
	font-size: 12px;
}

th.p {
	padding-bottom: 18px;
	font-size: 20px;
}

td.n {
	padding-left: 4px;
	text-align: left;
}

img.loc {
	height: 80px;
	width: 80px;
}

img.wne {
	height: 70px;
	width: 70px;
}
.container {
width: 1170px;
}

.coverpic {
width: 1170px;
height: 567px;
}
.cover_pic {
margin: 20px;
width: 100%;
z-index: -1;
}
.profile_pic {
position: relative;
width: 168px;
height: 168px;
margin: 10px;
top: -160px;
left: 40px;
}
.nav {
position: relative;
height: 100px;
width: 100px;
margin: 2px;
top: -230px;
left: 250px;

}
.info {
position: relative;
height: 100px;
width: 100px;
margin: 2px;
top: -280px;
left: 800px;

}

.log {

position: relative;
height: 100px;
width: 100px;
margin: 2px;
top: -382px;
left: 900px;

}
.pj{
background-color: #f5f5f5;
}
.pi
{
font-size: x-small;
}
div.item {
    vertical-align: top;
    display: inline-block;
    text-align: center;
    width: 100px;
    
}

.caption {
    display: block;
    position: relative;
    top:-25px;
    color: white;
}
.addfriend
{
position: relative;
height: 30px;
width: 200px;
margin: 2px;
top: -300px;
left: 800px;
}
.blockfriend
{
position: relative;
height: 30px;
width: 200px;
margin: 2px;
top: -332px;
left: 900px;
}

.name {
position: relative;
height: 30px;
width: 200px;
margin: 2px;
top: -250px;
left: 250px;
color: white;
font-size: x-large;
}
.breadcrumb{
position: relative;
height: 40px;
width: 900px;
margin: 2px;
top: -240px;
left: 300px;
}
</style>
</head>
<%@include file="/jsp/ajaxscripts.jsp" %>
<body>

    <div id="main" class="container" >

		
    	<div class="coverpic">
    	
    		<img class="cover_pic" src="./getcoverimage?userid=${userid }" width="1200" height=400/>
    		<img class="profile_pic" src="./getprofileimage?profilepicid=${userid}" width="200" height=200/>
    		<div class="name">${ufirstname}&nbsp;&nbsp;${ulastname}</div>	
    		<!-- start -->
    		<div class="addfriend">

				<input type="hidden" class="button button-primary" id="logedinuser"
					value="<s:property value="#session['user'].userId" />" /> <input
					type="hidden" class="button button-primary" id="frid"
					value="${userid}" />
				<s:if test="getIsfriend()=='no'">
					<input type="button" class="btn btn-default" id="addfrnd"
						style="color: whitesmoke; background-color: darkgreen;"
						value="<s:text name="global.addfriend"/>" onclick="addtofriends()" <%-- onclick="addtofriends(<s:property value="#session['user'].userId" />,${userid})" --%>/>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="sent"
							style="color: whitesmoke; background-color: darkgreen; display: none;">
							FriendRequestSent <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="Withdrawfrndreq()">With draw the request</a></li>
						</ul>
					</div>
				</s:if>
				<s:elseif test="getIsfriendRequestsent()=='yes'">

					<input type="button" class="btn btn-default" id="addfrnd"
						style="color: whitesmoke; background-color: darkgreen; display: none;"
						value="<s:text name="global.addfriend"/>" onclick="addtofriends()" />
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="sent"
							style="color: whitesmoke; background-color: darkgreen;">
							FriendRequestSent <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="Withdrawfrndreq()">With draw the request</a></li>
						</ul>
					</div>
				</s:elseif>


				<s:if test="getPurefriend()=='yes'">


					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="purefrnd"
							style="color: whitesmoke; background-color: darkgreen;">
							Friends<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="removefriends()">Remove</a></li>
							<!-- <li><a onclick="blockfriends()">Block</a></li> -->
						</ul>
					</div>
					<input type="button" class="btn btn-default" id="addfrnd"
						style="color: whitesmoke; background-color: darkgreen; display: none;"
						value="<s:text name="global.addfriend"/>" onclick="addtofriends()" />
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="sent"
							style="color: whitesmoke; background-color: darkgreen; display: none;">
							FriendRequestSent <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="Withdrawfrndreq()">With draw the request</a></li>
						</ul>
						</div>
						
				</s:if>
				<s:if test="getIshesentfriendrequest()=='yes'">
                     <div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="respond"
							style="color: whitesmoke; background-color: darkgreen;">
							ResponftoRequest <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="acceptfriends()">Accept</a></li>
							<li><a onclick="rejectfriends()">Reject</a></li>
						</ul>
						</div>
				     <div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="purefrnd"
							style="color: whitesmoke; background-color: darkgreen;display: none;">
							Friends<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="removefriends()">Remove</a></li>
							<!-- <li><a onclick="blockfriends()">Block</a></li> -->
						</ul>
					</div>
					<input type="button" class="btn btn-default" id="addfrnd"
						style="color: whitesmoke; background-color: darkgreen; display: none;"
						value="<s:text name="global.addfriend"/>" onclick="addtofriends()" />
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false" id="sent"
							style="color: whitesmoke; background-color: darkgreen; display: none;">
							FriendRequestSent <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a onclick="Withdrawfrndreq()">With draw the request</a></li>
						</ul>
						</div>

				</s:if>
			</div>
		</div>
    		
    		
    		
    		<!-- end -->
    		   			
			
   			</div>
  
   			 <div>
    			<ol class="breadcrumb" style="position: relative;
    height: 39px; width: 900px; margin: 2px; top: -146px; left: 375px;">
				  <li><a onclick="getprofile(${userid})">About</a></li>
				  <s:if test="getIsfriend()=='yes' || mainuserid==userid">
				  <li><a onclick="gettimeline(${userid})">Timeline</a></li>
				  </s:if>
					
				  <li> <a onclick="getfriends(${userid })">Friends</a></li>
				  <li><a href="#">Photos</a></li>
				</ol>
    	    </div>
	
<div id="timelinecenter">
<div class="row">
				<div class="col-lg-1"></div>
				<div class="col-lg-4" align="left">
				<div class="pj">
  						<table cellspacing="2" cellpadding="5" border="0"
						bordercolor="white">
						
						<tr>
							<td class="glyphicon glyphicon-search" aria-hidden="true"></td><td style="text-indent: " class="p" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;Currently in&nbsp;&nbsp;<s:property value="currentname" /></td>
						</tr>
						<tr>
							<th class="pi" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From&nbsp;&nbsp;<s:property value="currentfrom" /></th>
						</tr>
						<tr>
							<td class="glyphicon glyphicon-search" aria-hidden="true"></td><td class="p" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;Lives in&nbsp;&nbsp;<s:property value="currentplace" /></td>
						</tr>
						<tr>
							<td class="glyphicon glyphicon-search" aria-hidden="true"></td><td class="p" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;From &nbsp;&nbsp;<s:property value="homeplace" /></td>
						</tr>
						<tr>
							<td class="glyphicon glyphicon-search" aria-hidden="true"></td><td class="p" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;Friends with &nbsp;&nbsp;<s:property value="count" /></td>
						</tr>
						<tr>
							<td class="glyphicon glyphicon-search" aria-hidden="true"></td><td class="p" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;Born on &nbsp;&nbsp;<s:property value="udob" /></td>
						</tr>
					    </table>
			     </div>
			     </div>
		</div>

		<div class="row">
		<br><br><br>
		</div>
		
		<div class="row">
				
			   <div class="col-lg-4">
			   <div class="alert alert-warning" style="margin-left: 80px;">
			   			<div class="row" >
			   			<div class="col-lg-3" style="font-size: x-large; color:green; margin-left: 12px;">Friends</div>
			   			<div class="col-lg-2" style="margin-top: 8px;"><s:property value="count" /></div>
			   			</div>
			   			<div class="row"  >
  							<table cellspacing="2" cellpadding="5" border="0"
								bordercolor="white" >
						
							<tr>
								<c:forEach items="${friend}" var="user">
								<div class="item">
        							
        							<img onclick="getfriendprofile(this.id)"  id="${user.friendid}" class="img-thumbnail" alt="Thumbnail Image" src="./getprofileimage?profilepicid=${user.friendid}" width="100" height=100/>
           							<span class="caption">${user.name }</span>
           						</div>
           						</c:forEach>
           				
           					</tr>
           					</table>
           				</div>
           				
						 <div class="alert alert-warning">
						
						<b   onclick="getfriends()"> See more...</b>
						
						</div>
						
					    
			     </div>
		  </div>
</div>

</div>	
	
</body>

<script>
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

</script>
</html>