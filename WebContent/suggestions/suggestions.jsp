<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="global.friendsugg"/></title>
</head>
<body>
	<s:if test="%{getFriendSuggestionsList().isEmpty()}">
	</s:if>
	<s:else>
	<div id="suggestions">
		<h5 style="color:gray";" align="center"><s:text name="global.pplyoumayknow"/></h5>
		<s:iterator value="friendSuggestionsList" var="fsl">
			<s:set var="friendId" value="%{friendId}"/>
			<%
			  int friendId = (Integer) pageContext.getAttribute("friendId");						    
			%>
			<form id="suggFriendForm_<%=friendId %>" class="suggFriendForm" action="addSuggestedFriend" method="post">
			<div class="suggFriendForm" align="center">
				<img width="80px" src="image?userId=<s:property value="friendId" />" />
				<div><a href="profile?fref=<s:property value="friendId" />" >
					<b style="color:#45619d;"><s:property value="firstName" />&nbsp;<s:property value="lastName" /></b>
					</a>
					<br>
<%-- 						<a id="mutualFriends" style="color:gray;" onclick="getMutualFriends(<s:property value="userId"/>,<s:property value="friendId"/>);"> <s:text name="global.mutualfriends"/> </a> --%>
						<a style="color: gray;" onclick="getmutualfriends(<s:property value="userId"/>,<s:property value="friendId"/>)" > <s:text name="global.mutualfriends"/></a>
					
					
					<br>
					<input type="submit" class="btn btn-default" id="addfriend" value="<s:text name="global.addfriend"/>"/>

					<s:hidden name="friendId" value="%{friendId}" />
				</div>
			</div>
			</form>
			<hr>
		</s:iterator>
	</div>
	</s:else>
</body>
	<script type="text/javascript">	
	$(".suggFriendForm").submit(function(event) {

		/* stop form from submitting normally */
		event.preventDefault();

		/* get some values from elements on the page: */
		var form = $(this); 
		var url = form[0].action;
		var friendId = form[0][1].value;

		/* Send the data using post */
		var posting = $.post(url, {
			"friendId" : friendId			
		});
		
		posting.done(function(addSuggFriendData) {
			if (addSuggFriendData.status == true) {
				form[0][0].value = "<s:text name="global.friendreqsent"/>";
				form[0][0].disabled = true;
			}
		});
	});
		
		
	function getMutualFriends(userId, friendId) {   
        $.ajax({
            url: 'facebook/mutualfriends?userId=' + userId + '&friendId=' + friendId,
            data: {},
            dataType: 'html',
            success: function(html) {
            	$("#mutualFriends").popover({
                    content: html,
                    placement: 'bottom',
                    html: true                    
                }).popover('show');
            }
        });
	}
	
	$(document).ready(function(){
		  $("#addfriend").click(function(){
		   	$(this).html('<s:text name="global.friendreqsent"/>');
		  });
	});
			
	</script>
</html>