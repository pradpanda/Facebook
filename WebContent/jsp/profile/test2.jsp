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
<button type="submit" onclick="submitabout(this.form)" class="btn btn-small btn-primary">
							bye<span class="fa fa-arrow-right"></span>
						</button>


</body>
</html>