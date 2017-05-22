<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
<title>View Group Members</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="/facebookv1/css/jquery-ui.css" rel="stylesheet">


<script src="/facebookv1/js/jquery-ui.js"></script>
<script src="/facebookv1/js/jquery.min.js"></script>
<script src="/facebookv1/js/jquery.tokeninput.js"></script>
<link rel="stylesheet" href="css/token-input.css" type="text/css" />
<link rel="stylesheet" href="css/token-input-facebook.css"
	type="text/css" />
<script src="/facebookv1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="feeds/feeds.css" />


<style>

.friends {
	position: relative;
	margin: 13px;
	top: 20px;
	left: -50px;
	-moz-column-count:2; /* Firefox */
     column-count:3;
}

div.img {
	margin: 61px;
	padding: 20px;
	border: 1px solid #0000ff;
	height: auto;
	width: 280px;
	float: left;
	text-align: center;
	-moz-column-count:3;
	/* Firefox */
    column-count:3;
}
	
}
/*opacity*/
img {
	opacity: 1.0;
	filter: alpha(opacity = 100);
	/* For IE8 and earlier */
}

img:hover {
	opacity: 0.7;
	filter: alpha(opacity = 100);
	/* For IE8 and earlier */
}

div.img img {
	display: inline;
	margin: 3px;
	border: 1px solid #ffffff;
}

div.desc {
	text-align: center;
	font-weight: normal;
	text-shadow: 5px 5px 5px #FF0000;
	color:#0000FF;
	width: 120px;
	margin: 5px;
}
h1
{
color:blue;
text-align:center;
}


.coverpic {
	width: 1200px;
	height: 567px;
}

.cover_pic {
	position: relative;
	margin: 20px;
	width: 55%;
	z-index: -1;
}
					
ul {
	position: relative;
	margin: 50px;
	padding: 0;
	left: 300px;
	top: -60px;
	left: 240px;
}

ul {
	position:relative;
	margin: 50px;
	padding: 0;
	left: 500px;
	top: -60px;
	left: 0px;
}

li {
	list-style-type: none;
	
	
}

#nav {
	display: table;
	table-layout: fixed;
	text-align: center;
}

#nav li {
	display: table-cell;
	width: 25%;
	padding-right: 1px;
	height: auto;
	vertical-align: bottom;
}

#nav a {
	display: block;
	min-height: 100%;
	padding: 4px 10px;
	background-color: #222;
	color: white;
	border-radius: 6px 6px 0 0;
}
.mm {
    color: maroon;
    text-align: left;
	font-size: 35px;
	margin-left: 20px

}

</style>
<%
	String grpID = ((String)request.getAttribute("grpID")); 
	System.out.print("hereee" + grpID);
	
	String grpName=(String)request.getAttribute("grpName");
%> 
<script type="text/javascript">
	$(document).ready(
			function() 
			{
				
				var grpID=<%=grpID%>
				var posting = $.post("searchAction2.action",
						{ "grpID" : grpID });
				posting.done(function(response) {
					// Pre-process response before passing to make it more friendly to tokenInput
					//alert("viewgrp");
					var grpUserList1 = [];
					//alert(response.grpUserList1.g);

				//	alert(jQuery.isEmptyObject(response.grpUserList1));
					var i = 0;
					//alert("here");
					$.each(response.grpUserList1, function(index, user) {
						i = i + 1;
						//alert(user.firstName);
						
						console.log('entered');
						grpUserList1.push({
							userId : user.userId,
							firstName : user.firstName,
							lastName : user.lastName,
							searchIn : user.firstName + " " + user.lastName
									+ " "
						});
					});
					$("#search3").tokenInput(
							grpUserList1,
							{
								propertyToSearch : "searchIn",
								theme : "facebook",
								tokenFormatter : function(item) {

									return "<li><strong>" + item.firstName
											+ " " + item.lastName + " "
											+ item.userId + "</strong></li>";
								}
					});
					
				});
				
				
				$("#Button5").click(
						function() {
							alert("eyyy");
							var memtxt = '';
							var grpID=<%=grpID%>
							//var temp = 'new check';
							var nametxt = $('#grpName').val();
							$("#search3").prev('ul').find('li:not(:last-child)').each(
											function() {

												memtxt += $(this).text() + " ";
												alert(memtxt);

											});
							var posting = $.post("extraMembers.action", {
								"grpMembers" : memtxt,
								"grpName" : nametxt,
								"grpID": grpID
							});
							$('#hidMem').val(memtxt);
							$('#hidName').val(nametxt);

							$('#modal3').modal('hide');
							$('#modal2').modal({
								show : 'true'
							});
							
							window.location.reload();
							
							return false;
						});  

				$("#Button2").click(function() {

					var memtxt = $('#hidMem').val();
					var nametxt = $('#hidName').val();
					$('#grpName').val("");
					$('#search1').val(" ");
					$('#modal3').modal('hide');
					$('#modal2').modal('hide');
					return false;
				});

				

			});
</script>

</head>

<body style="background-color:">
	<div class="modal fade" id="modal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Add Members</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search To Add</label>&nbsp;&nbsp;&nbsp;</td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 300px"
								id="search3" name="search1" /></td>
						</tr>
					</table>
					<hr width="100%">

					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="right"><!-- <input type="submit" value="cancel"
								align="right" id="Button2" />  --><input
								type="submit" value="ADD" align="right" id="Button5"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
	<div class="mm"><%=grpName%></div>

	<div class="coverpic" id="myCover">
		<img class="cover_pic" height="420px"
			src="groupImage?picType=cover&grpID=<%=grpID%>" /> <img />


			<ul id="nav" >
				<li><a href="group?grpID=<%=grpID%>" style="color:ivory;background-color: navy;font-size: 20px">Discussion</a></li>
 
				<!-- whatever whitespace between tabs -->
<!-- 			 	<li><a href="viewGroupMembers"> Members</a></li>  
 -->			<!-- <li><a href="viewFriends"> Members</a></li> -->
 
				<li><a href="#" data-toggle="modal" data-target="#modal3"  style="color:ivory;background-color: navy;font-size: 20px">Add Members</a></li>
				</ul>
			</div>
			

	
	
	
	<div class="friends">
<s:iterator value="friendsList" var="a">
<div class="img">
 <a href='profile?fref=<s:property value="%{userId}"/>'> <img align="left" width="120px" height="130px" 
					src="image?userId=<s:property value="%{userId}"/>" alt="klematis"></a>
 <div class="desc"><a href='profile?fref=<s:property value="%{userId}"/>'><s:property value="#a.firstName" /></a></div>
</div>
		
</s:iterator>
	
</div>
<script type="text/javascript">

/* function add(grpID)
{
	alert(grpID);
	
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
		    document.getElementById("1").innerHTML=xmlhttp.responseText;
		    //event.preventDefault();
		   
	    }
	  }
xmlhttp.open("POST","./extraMembers?grpID="+grpID,true);
	xmlhttp.send();
	$('#modal1').modal('hide');
	$('#modal2').modal({
		show : 'false',
	});
	//location.reload();
	return true;
	// event.preventDefault();
	//event.preventDefault();
} */




</script>
</html>