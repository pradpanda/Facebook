<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
 <c:forEach items="${lastFriendMessage}" var="user">

		<div class="row LeftDivList" id="${user.getFriendUserId()},${user.getFriendFname()} ${user.getFriendLname()}" onclick="showAllMessages(this.id)">
				<div class="col-lg-2" align="left">
					<img width="60px" height="60px" src="getFriendsLastPhoto?userid=${user.getFriendUserId()}">
				</div>
				
				<div class="col-lg-10" align="left">
					<div class="row">
						<div class="col-lg-12">
							${user.getFriendFname()}&nbsp;${user.getFriendLname()}
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12 textOverflowMessage">
							${user.getMessagedetails()}
						</div>
					</div>
				</div>
		</div>

</c:forEach>