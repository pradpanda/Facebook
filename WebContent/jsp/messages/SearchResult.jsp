<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<c:forEach items="${friends}" var="user">
	<div  style="background-color:#EBFFFF" onmouseover="this.style='background-color:#D4E6E6'" onmouseout="this.style='background-color:#EBFFFF'">
		<span id="${user.friendUserId}" onclick="selectedFriend(this.id)">${user.friendFname} ${user.friendLname}</span><br>
	</div>
</c:forEach>