<%@page import="java.util.Iterator"%>
<%@page import="java.util.List, java.sql.*"%>
<%@page import="edu.iiitb.facebook.action.model.User"%>
<%@page import="edu.iiitb.facebook.action.newsfeeds.NewsFeedsAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.iiitb.facebook.action.model.Group"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/jsp/ajaxscripts.jsp" %>
<%@include file="/groups/createGroupPage.jsp" %>
<style>
.lpcenter {
margin:auto;
width:70%;
}
</style>
<div class="lpcenter">
	<img align="left" width="50px" src="image?userId=<s:property value="#session['user'].userId" />" />
	<b><s:property value="#session['user'].firstName"/> <s:property value="#session['user'].lastName"/></b>
	<br>
	<a onclick="getmyprofile(<s:property value="#session['user'].userId" />)"><s:text name="global.editprofile"/></a>
	
	<br clear="all">
</div>
<hr>
<div class="lpcenter">
	  <a href="/facebook/newsfeeds"><h4 style="color:black;"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;<s:text name="global.newsfeeds"/></h4></a>
	<a onclick="gotoMessages()"><h4 style="color:black;"><span class="glyphicon glyphicon-envelope"></span>&nbsp;<s:text name="global.messages"/></h4></a>
	  
	  <a onclick="displayevents()"><h4 style="color:black;"><span class="glyphicon glyphicon-calendar"></span>&nbsp;<s:text name="global.events"/></h4></a>

<a href="#" data-toggle="modal" data-target="#modalCreateGroup"><img src="images/Facebook-Create-Group.png" width="30" height="30" /> Create
					Group</a>
					
		 <% ArrayList<Group> grpDetails = (ArrayList<Group>)request.getAttribute("grpDetails");
		
 if(request.getAttribute("grpDetails")!=null)
		for(int i=0;i<grpDetails.size();i++){%>
<%-- 		<input type="hidden" name="grpID" value="<%= grpDetails.get(i).getGroupID()%>">
 --%>		
 <a href="/facebookv1/group?grpID=<%=grpDetails.get(i).getGroupID()%>"><h4 style="color:black;"><span class="glyphicon glyphicon-calendar"></span>&nbsp;<%= grpDetails.get(i).getGroupName()%></h4></a>
		<%} %>
	
					
</div>





