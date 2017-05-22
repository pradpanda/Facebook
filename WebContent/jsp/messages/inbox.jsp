<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> --%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages</title>
<link rel="stylesheet" href="./css/bootstrap.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script  type='text/javascript' src='./js/jquery-1.11.2.js'></script>
<script  type='text/javascript' src='./js/bootstrap.min.js'></script> --%>
<style>
#friendList {
	height: 100px;
	overflow-y: auto;
}
#fix-at-bottom {
    position: fixed;
    top: 490px;
    padding-right: 80px;
}
#conversations-row {
    overflow-y: auto;
    position: relative;
    height: 300px;
}

	.sender {
  
   position: relative;
   display:block;
   bottom: 0;
   right: 0;
   word-break: break-all;
}
	 .receiver {
   
   position: relative;
   display:block;
   bottom: 0;
   left: 0;
   word-break: break-all;
}

.textOverflowMessage{

   	white-space: nowrap; 
    width: 14em; 
    overflow: hidden;
    text-overflow: clip; 

   }
 .LeftDivList{
 
 	margin-left: 4px;
 	margin-right: 4px;
 }
 .LeftDivList:hover {
 	background-color:#F3F9FF;
 }
 
    
</style>
</head>
<body>
	<div class="container">
		<br>
		<br>
		
		<div class="row">
			<input type="hidden" id="recipientId"/>
			<input type="hidden" id="dummyRecipientName"/>
			<div id="left-div" class="col-lg-4" style="border-left:1px solid #808080;height:500px">
				<div class="row" align="left">
					<b>Inbox</b>
				</div>
				<hr>
				<!-- Conversations -->
				<div id="conversations-div" class="row">
					<b>No conversations</b>
				</div>
			</div>
			<div id="right-div" class="col-lg-8" style="border-left:1px solid #808080;height:500px">
					<div class="row">
						<div id="other-participants-div" class="col-lg-6" align="left">
							<b>No conversation selected</b>
						</div>
						<div id="action-buttons-div" class="col-lg-6" align="right">
							<input type="button" class="btn-success" id="new-message-button" onclick="createNewMessage()" value="+ New Message"/>
						</div>
					</div>
					<hr>
					<div id="AllMessages">
					</div>
			</div>
		</div>
	</div>
	<script src="onCreateNewMessage.js"></script>
	<script src="SearchFriends.js"></script>
	<script src="SendNewMessage.js"></script>
	<script src="onPageLoad.js"></script>	
	<script src="MessageReceive.js"></script>
	<script src="ShowAllMessages.js"></script>
</body>
</html>