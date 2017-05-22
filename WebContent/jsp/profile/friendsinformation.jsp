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

</style>
</head>
<body>
<div class="container-fluid">
	<div class="alert alert-warning" style="margin-left: 80px; font-size: large;">
	<div class="row">
	 
	 <div class="col-lg-1">
	 Friends</div>
	 <div class="col-lg-1" style="color: gray;"> ${count}</div>
	 </div>
	 </div>
		
		<div class="row">
		
		<c:forEach items="${friend}" var="user">
			
			<div class="col-lg-1"></div>
			<div class="col-lg-5" >
			<div class="alert alert-warning">
				<div class="row">
					<div class="col-lg-3">
 						<img onclick="getfriendprofile(this.id)"  id="${user.friendid}" class="img-thumbnail" alt="Thumbnail Image" src="./getprofileimage?profilepicid=${user.friendid}" width="100" height=100/>
    				</div>	
    				<div class="col-lg-9">
    					<div class="row">
    			
    						<div class="col-lg-6">${user.name}</div>
    						<div class="col-lg-6"></div>
    					</div>
    					<div class="row">
    					<div class="col-lg-2" style="color: blue; font: oblique;">Friends</div>
    					<div class="col-lg-4" >${user.fofcount}</div>
    					<div class="col-lg-6"></div>
    					</div>
    				</div>
    			</div>
    		</div>
    		</div>
    		
    		
         </c:forEach>
		</div>
		<div class="row">
		<div class="col-lg-12">all rights reserved</div>
		</div>

</body>

</html>