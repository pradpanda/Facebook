<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@include file="/jsp/ajaxscripts.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutual Friends </title>
</head>
<body style="background-color: #c5c5df;" >
	<div style="margin-left: 25%; margin-top: 50px; width: 50%; border: thin; border-style: solid; background-color: #ffffff; height: 400px;">
		<table style="width: 100%">
			<tr style="background-color: #ffffff; height: 50px;">
				<td><b>Mutual Friends</b></td>
				<td align="right"><a style="text-decoration: none;" href='newsfeeds' ><input type="button" value="X" /></a></td>
			</tr>
		</table>
		<hr />
		<div style="overflow-y: scroll; height: 302px;">	
			<%-- <s:iterator value="mutualFriendsList" var="mf"> --%>
			<c:forEach items="${mutualFriendsList}" var="mf">
			<table style="width: 96%; margin-left: 2%;">
				<tr>
					<td width="50px"><a style="text-decoration: none;" ><img onclick="getfriendprofile(<s:property value="#mf.friendId" />)"  width="40px" height="40px" src='image?userId=<s:property value="#mf.friendId" />' /></a></td>
					<td><a style="text-decoration: none;" onclick="getfriendprofile(<s:property value="#mf.friendId" />)"><s:property value="#mf.firstName" />&nbsp;<s:property value="#mf.lastName" /></a></td>
				<td><img onclick="getfriendprofile(this.id)"  id="${mf.friendId}" class="img-thumbnail" alt="Thumbnail Image" src="./getprofileimage?profilepicid=${mf.friendId}" width="100" height=100/></td>
				</tr>
			</table>
			</c:forEach>
			<hr />
			
			<%-- </s:iterator> --%>
		</div>
	</div>
</body>
</html>