<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>About</title>
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

</style>
</head>
<%@include file="/jsp/ajaxscripts.jsp" %>
<body>

   	<div class="container">
	<div class="row" style="background-color: #f7f7f7">
		<div class="col-md-1" align="left"></div>
		<div class="col-md-10" align="left" style="background-color: white">
	
		<input  onclick="getfriendprofile(this.id)" type="button" id="9" value="Edit" align="right" />
			<div class="padding" >
			<input type="text" class="hide"  type="hidden" name="${userid}" id="${userid}"
							placeholder="Add Your college here"> <br /> 
			
			
			
				 <table>
					<tr>
						<td><b class="q">About</b></td>
						
						<s:if test="getUserid()==getMainuserid()">
						<td>
						
								<input  onclick="getabout(this.id)" type="button" id="${userid}" value="Edit" align="right" />
						
						</td>
						</s:if>
						
					</tr>
				</table> 

			</div>


			<div class="col-md-6" align="left" style="background-color: #FFFFFF">

				<div class="box1">
					
					 <table cellspacing="2" cellpadding="5" border="0"
						bordercolor="white">
						<tr>
							<th class="p" colspan="2">Work/Organization </th>
						</tr>
						
						<s:iterator value="organ" var="org" status="status">
							<tr>
								<td width="70px"><img src="jsp/profile/job.png" class="wne"></img></td>
								<td><b class="a"><s:property value="#org.organizationname" /></b><br />
									<b class="b"><s:property value="#org.designation" /></b><br>
									<b class="b"><s:property value="#org.workingfrom" /></b>&nbsp;to
									<b class="g"><s:property value="#org.workingto"  /></b></td>
									
							</tr>

						</s:iterator>
					</table> 
					<br><br>
					<table cellspacing="2" cellpadding="5" border="0"
						bordercolor="white">
						<tr>
							<th class="p" colspan="2">Education </th>
						</tr>
						
						<s:iterator value="inst" var="ins" status="status">
							<tr>
								<td width="70px"><img src="jsp/profile/school.png" class="wne"></img></td>
								<td><b class="a"><s:property value="#ins.degree" /></b><br />
									<b class="b"><s:property value="#ins.institutename" /></b><br>
									<b class="b"><s:property value="#ins.studiedfrom" /></b>&nbsp;to
									<b class="g"><s:property value="#ins.studiedto"  /></b></td>
									
							</tr>

						</s:iterator>
					</table> 
						
					<br /> <br />
					<table>
						<tr>
							<th class="p">Relationship</th>
						</tr>
						<tr class="b">
							<td><img src="jsp/profile/relationships.png" height="70px"
								width="70px" alt="test" align="middle">&nbsp&nbsp&nbsp&nbsp<b><s:property
										value="martialstatus" /></b></img></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="col-md-4" align="left">
				<div class="box1">


					<table>
						<tr>
							<th class="p">Places Lived</th>
						</tr>
						<tr>
							<td><img src="jsp/profile/location.jpeg" class="loc"></img></td>
							<td><b class="a"><s:property value="currentplace" /></b><br /> <b
								class="b">Current City</b></td>
						</tr>
						<tr>
							<td><img src="jsp/profile/location.jpeg" class="loc"></img></td>
							<td><b class="a"><s:property value="homeplace" /></b><br />
								<b class="b">Hometown</b></td>
						</tr>
					</table>
					<br /> <br />
					<table>
						<tr>
							<th class="p">Basic Information</th>
						</tr>
						
						<tr>
							<td><b class="i">Date of Birth</b></td>
							 <td class="h"><s:property value="udob" /></td> 
						</tr>
						<tr>
							<td><b class="i">Language</b></td>
							 <td class="h"><s:property value="language" /></td> 
						</tr>
						<tr>
							<td><b class="i">Gender</b></td>
						    <td><b class="h"><s:property value="ugender" /></b></td>
						</tr>
						<tr>
							<td><b class="i">Relationship</b></td>
							 <td><b class="h"><s:property value="martialstatus" /></b></td> 
						</tr>

					</table>
				</div>
			</div>
			<div class="col-md-1" align="left"></div>
		</div>
	</div>
</div>

<script>

</script>

</body>
</html>