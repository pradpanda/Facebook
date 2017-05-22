<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%> 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.apache.struts2.ServletActionContext"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>About</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css" media="screen">
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
.
.name
{

position: relative;

margin: 2px;
top: -382px;
left: 900px;
}

</style>
</head>
<body>
<div class="container">
		<div class="row">
				
				<div class="col-lg-4">
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
        							${user.friendid}
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
		

</body>

</html>