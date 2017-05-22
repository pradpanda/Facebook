<!-- "<br>"+$("#conversations-row").html().trim()+"<div class='sender alert alert-success' align='right'>"+text.trim()+"<br><span class='badge'>  "+datetime+"</span>"+"</div>" -->
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<c:set var="friendId" value='<s:property value="#session.userid" />'/>
<c:forEach items="${GetAllMessagesList}" var="user">
	<c:choose>
		<c:when test="${user.friendUserId == 0}">						
 			<div class='sender alert alert-success' align='right'>${user.messagedetails}<br><span class='badge'>${user.timestampMessage}</span></div>
		</c:when>
		<c:otherwise>
        	<div class='receiver alert alert-info' align='left'>${user.messagedetails}<br><span class='badge'>${user.timestampMessage}</span></div>
        </c:otherwise>
	</c:choose>
</c:forEach>
	
