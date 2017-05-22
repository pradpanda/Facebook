<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.iiitb.facebook.action.model.Group"%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="edu.iiitb.facebook.util.ConnectionPool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List, java.sql.*"%>
<%@page import="edu.iiitb.facebook.util.ConnectionPool"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="/facebook/css/jquery-ui.css" rel="stylesheet">

<title>groups</title>
<script src="/facebook/js/jquery-ui.js"></script>
<script src="/facebook/js/jquery.min.js"></script>
<script src="/facebook/js/jquery.tokeninput.js"></script>
<link rel="stylesheet" href="css/token-input.css" type="text/css" />
<link rel="stylesheet" href="css/token-input-facebook.css"
	type="text/css" />
<script src="/facebook/js/bootstrap.min.js"></script>

<title>News Feeds</title>
<style>
.coverpic {
	width: 1200px;
	height: 567px;
	
}

.cover_pic {
	position: relative;
	margin: 20px;
	width: 55%;
	z-index: -1;
}

ul {
	position:relative;
	margin: 50px;
	padding: 0;
	left: 500px;
	top: -60px;
	left: 0px;

	
}

li {
	list-style-type: none;
	
	
	
}

#nav {
	display: table;
	table-layout: fixed;
	text-align: center;
	/* background-color: maroon; */
	
}

#nav li {
	display: table-cell;
	width: 25%;
	padding-right: 1px;
	height: auto;
	vertical-align: bottom;
}

#nav a {
	display: block;
	min-height: 100%;
	padding: 4px 10px;
	background-color: #222;
	color: white;
	border-radius: 6px 6px 0 0;
}
.mm {
    color: maroon;
    text-align: left;
	font-size: 35px;
	margin-left: 20px

}
</style>
<link rel="stylesheet" type="text/css" href="feeds/feeds.css" />

<%-- <script type="text/javascript">
$("#Button1").on("click",function(){
    console.log("Inside Ajax call = "+  $('#tab0'));
    $.ajax({
        type: 'POST',
        url:'leaveGroup.action',
        dataType: 'json',
        success: function(data){

        }
    });

}); 
</script>  --%>
<%-- <script type="text/javascript">
$("#Button1").click(
		function() {
			$.ajax({
           	 url:"leaveGroup",
           	 dataType: "json",
			 contentType: 'application/json;charset=utf-8',
           	 type: "get",
           	 success:function(response){
           	alert("lol");
           		// document.write("here");
           	 showSearchResultDropDown(response);
           	 },
           	 error:function(){
           	 alert("lol"+response.name);
           	 } 
           	 });

</script> --%>
</head>

<body>



	<% ArrayList<Group> grpName = (ArrayList<Group>)request.getAttribute("grpName");%>
		<% int userID = (Integer)request.getAttribute("userID");
	
			Connection conn = ConnectionPool.getConnection();

	//System.out.print("nisarga");
	
		//	String name = "%" + request.getParameter("name") + "%";

			PreparedStatement stmt = conn
			.prepareStatement("select createdby from groups where groupid=?");

			stmt.setInt(1,grpName.get(0).getGroupID());
			
			ResultSet rs=stmt.executeQuery();
			
			rs.next();
			
			int createdby=rs.getInt(1);
			
			%>
	
	<div class="mm"><%=grpName.get(0).getGroupName()%></div>
	<div class="coverpic" id="myCover">
		<img class="cover_pic" height="420px"
			src="groupImage?picType=cover&grpID=<%=grpName.get(0).getGroupID()%>" /> <img />
			
			<s:form  enctype="multipart/form-data" autocomplete="off">

			<s:file key="cover"/>
			<input type="hidden" name="grpID" value="<%=grpName.get(0).getGroupID()%>" />
			
			<s:submit value="Upload" onclick="uploadMyCover(this.form)"/>
		</s:form>
		<s:actionerror />
		
		<ul id="nav" class="col-lg-6" >

<%-- 			<li><a href="#" style="color:ivory;background-color: navy;font-size: 20px"><%=grpName.get(0).getGroupName()%> </a></li>
 --%>			<li><a href="group" style="color:ivory;background-color: navy;font-size: 20px">Discussion</a></li>
			<!-- whatever whitespace between tabs -->
			<li><a href="viewGroupMembers?grpID=<%=grpName.get(0).getGroupID()%>" style="color:ivory;background-color: navy;font-size: 20px">Members</a></li>
			<!--<li><a href="viewFriends"> Members</a></li> -->
			<li><a href="#" style="color:ivory;background-color: navy;font-size: 20px"data-toggle="modal" data-target="#modal2">LeaveGroup</a></li>
			
			<%if(userID==createdby)
			{%>
				<li><a href="DeleteGroup?grpID=<%=grpName.get(0).getGroupID()%>" style="color:ivory;background-color: navy;font-size: 20px">DeleteGroup</a></li>
			<%}%>
			
		</ul>
	</div>
	
	<div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<h1>
							<b>Are You Sure</b>
						</h1>
					</h5>
				</div>
				
				<div class="modal-body">

					<hr width="100%">

					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="right"><input type="submit" value="NO" 
								align="right" id="Button2"/> <input type="submit" value="YES" 
								align="right" id="Button1" onclick="yes(<%=grpName.get(0).getGroupID()%>)" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<%-- <%-- <div id="Overlay" name="Overlay" class="overlay"
		onclick="funcClose(this);"></div>
	<s:set name="loggedInUser" value="userId" />
	<div id="status" class="status-container">

		<form id="statusform" action="groupstatusupdate" class="status-form">
			<div>
				<textarea name="status" cols="75" rows="5" id="groupstatusUpdate"
					placeholder='<s:text name="feeds.whatsonmind"/>'
					style="width: 95%;"></textarea>
			</div>
			<div class="status-action">
				<input type="submit" value="<s:text name="feeds.post"/>" />
			</div>
		</form>
	</div>
	<div id="feeds">
		<s:iterator value="newsFeeds" var="feeds">
			<div id='status_<s:property value="#feeds.postId"/>'
				class="feed-container">
				<div class="left-status">
					<a href="/facebook/profile?fref=<s:property value="fromUserId" />">
						<img width="80px"
						src="image?userId=<s:property value="fromUserId" />" />
					</a>
				</div>
				<div class="right-status">
					<s:if test="#feeds.postType == 'status'">
						<div class="status-description">
							<a
								href="/facebook/profile?fref=<s:property value="fromUserId" />">
								<span class="fullname"> <s:property
										value="fromUserFirstName" /> <s:property
										value="fromUserLastName" />
							</span>
							</a>
							<s:text name="posted" />
						</div>
						<div class="status-options">
							<span> <s:if test="#loggedInUser==#feeds.toUserId">
									<div class="btn-group">
										<button type="button"
											class="btn dropdown-toggle status-options-button"
											data-toggle="dropdown"></button>
										<ul class="dropdown-menu dropdown-menu-right">
											<li>
												<form id='<s:property value="#feeds.postId"/>'
													class="delete_post" method="post">
													<input type="submit" value="<s:text name="feeds.delete"/>" />
												</form>
											</li>
											<li class="divider"></li>
											<li>
												<form id='<s:property value="#feeds.postId"/>'
													class="edit_post" method="post">
													<input type="submit" value="<s:text name="feeds.edit"/>" />
												</form>
											</li>
										</ul>
									</div>
								</s:if>
							</span>
						</div>
						<div class="clear"></div>
					</s:if>
					<s:elseif test="#feeds.postType == 'wallpost'">
						<div>
							<div class="status-description">
								<a
									href="/facebook/profile?fref=<s:property value="fromUserId" />">
									<span class="fullname"> <s:property
											value="fromUserFirstName" /> <s:property
											value="fromUserLastName" />
								</span>
								</a>
								<s:text name="feeds.postedon" />
								<a href="/facebook/profile?fref=<s:property value="toUserId" />">
									<span class="fullname"> <s:property
											value="toUserFirstName" /> <s:property
											value="toUserLastName" />
								</span>
								</a>
								<s:text name="feeds.swall" />
							</div>
							<div class="status-options">
								<span> <s:if test="#loggedInUser==#feeds.toUserId">
										<div class="btn-group">
											<button type="button"
												class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown"></button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>
											</ul>
										</div>
									</s:if> <s:elseif test="#loggedInUser==#feeds.fromUserId">
										<div class="btn-group">
											<button type="button"
												class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown"></button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>
												<li class="divider"></li>
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="edit_post" method="post">
														<input type="submit" value="<s:text name="feeds.edit"/>" />
													</form>
												</li>
											</ul>
										</div>
									</s:elseif>
								</span>
							</div>
							<div class="clear"></div>
						</div>
					</s:elseif>
					<div id='post_<s:property value="#feeds.postId"/>' class="post">
						<s:property value="postText" />
					</div>
					<div class="timestamp">
						<s:property value="updatedTime" />
						<s:if test="#feeds.haveILiked == true">
							<span id='liked_<s:property value="#feeds.postId"/>'
								class="liked"><s:text name="feeds.liked" /></span>
						</s:if>
						<s:elseif test="#feeds.haveILiked == false">
							<span id='like_<s:property value="#feeds.postId"/>' class="like"><s:text
									name="feeds.like" /></span>
						</s:elseif>
						<span id='post_likers_<s:property value="#feeds.postId"/>'
							class="people-who-like"> <s:property
								value="#feeds.likeCount" /> <s:text name="feeds.likes" />
						</span>
					</div>
					<div>
						<s:iterator value="#feeds.postComments" var="comments">
							<div id='comment_<s:property value="#comments.commentId"/>'>
								<div class="left-comment">
									<a
										href="/facebook/profile?fref=<s:property value="#comments.commenterUserId" />">
										<img width="40px"
										src="image?userId=<s:property value="#comments.commenterUserId" />" />
									</a>
								</div>
								<div class="right-comment">
									<div class="comment-description">
										<div class="comment-post">
											<a
												href="/facebook/profile?fref=<s:property value="#comments.commenterUserId" />">
												<span class="fullname"> <s:property
														value="#comments.commenterFirstName" /> <s:property
														value="#comments.commenterLastName" />
											</span>
											</a> <span
												id='comment_text_<s:property value="#comments.commentId"/>'
												class="comment-text"> <s:property
													value="#comments.commentText" />
											</span>
										</div>
									</div>
									<div class="comment-options">
										<span> <s:if
												test="#loggedInUser==#feeds.toUserId && #loggedInUser!=#comments.commenterUserId">
												<div class="btn-group">
													<button type="button"
														class="btn dropdown-toggle comment-options-button"
														data-toggle="dropdown"></button>
													<ul class="dropdown-menu dropdown-menu-right">
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="delete_comment" method="post">
																<input type="submit"
																	value="<s:text name="feeds.delete"/>" />
															</form>
														</li>
													</ul>
												</div>
											</s:if> <s:elseif test="#loggedInUser==#comments.commenterUserId">
												<div class="btn-group">
													<button type="button"
														class="btn dropdown-toggle comment-options-button"
														data-toggle="dropdown"></button>
													<ul class="dropdown-menu dropdown-menu-right">
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="delete_comment" method="post">
																<input type="submit"
																	value="<s:text name="feeds.delete"/>" />
															</form>
														</li>
														<li class="divider"></li>
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="edit_comment" method="post">
																<input type="submit" value="<s:text name="feeds.edit"/>" />
															</form>
														</li>
													</ul>
												</div>
											</s:elseif>
										</span>
									</div>
									<div class="timestamp">
										<s:property value="#comments.commentTime" />
										<s:if test="#comments.haveILiked == true">
											<span
												id='comment_liked_<s:property value="#comments.commentId"/>'
												class="liked-comment"><s:text name="feeds.liked" /></span>
										</s:if>
										<s:elseif test="#comments.haveILiked == false">
											<span
												id='comment_like_<s:property value="#comments.commentId"/>'
												class="like-comment"><s:text name="feeds.like" /></span>
										</s:elseif>
										<span
											id='comment_likers_<s:property value="#comments.commentId"/>'
											class="people-who-like-comment"> <s:property
												value="#comments.likeCount" /> <s:text name="feeds.likes" />
										</span>
									</div>
								</div>
								<div class="clear"></div>
							</div>
						</s:iterator>
						<s:set var="postId" value="%{postId}" />
						<%
							int postId = (Integer) pageContext.getAttribute("postId");
						%>
						<form id="commentForm_<%=postId%>" class="comment-form"
							action="postcomment" method="post">
							<div class="comment-form">
								<div>
									<textarea name="comment" cols="57" rows="2"
										placeholder="<s:text name="feeds.postcomment"/>"
										style="width: 95%;"></textarea>
									<s:hidden name="postId" value="%{postId}" />
								</div>
								<div style="width: 95%; text-align: right;">
									<input type="submit" value="<s:text name="feeds.post"/>" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</s:iterator>
	</div>
</body>
<script>
function funcShow(_btn) {
    var ov = $("#Overlay");
    var pos = $(_btn).offset();
    var doc = $(document);
    ov.css({
        left: pos.left + 'px',
        top: pos.top + 'px',
        width: 0,
        height: 0
    })
    .show()
    .animate({
        left: pos.left + 'px',
        top: pos.right + 'px',
        width: '30%',
        height: '60%'
        }, "slow");
    
}

function funcClose() {
   $("#Overlay").hide("slow");
}

$(document).on("click", ".like",
		function(event) {		
	var postId = $(this)[0].id.split("_")[1];		
	$.ajax({
        url:  '/facebook/likepost',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	$("#post_likers_"+likeData.postId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#like_"+likeData.postId)[0].innerHTML = "<s:text name="feeds.liked"/>";
        	$("#like_"+likeData.postId)[0].className = "liked";
        	$("#like_"+likeData.postId)[0].id = "liked_"+likeData.postId;
        }
    });
});

$(document).on("click", ".like-comment",
		function(event) {		
	var commentId = $(this)[0].id.split("_")[2];	

	$.ajax({
        url:  '/facebook/likecomment',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#comment_like_"+likeData.commentId)[0].innerHTML = "<s:text name="feeds.liked"/>";
        	$("#comment_like_"+likeData.commentId)[0].className = "liked-comment";
        	$("#comment_like_"+likeData.commentId)[0].id = "comment_liked_"+likeData.commentId;
        }
    });
});

$(document).on("click", ".liked",
		function(event) {
	var postId = $(this)[0].id.split("_")[1];		
	$.ajax({
        url:  '/facebook/unlikepost',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	$("#post_likers_"+likeData.postId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#liked_"+likeData.postId)[0].innerHTML = "<s:text name="feeds.like"/>";
        	$("#liked_"+likeData.postId)[0].className = "like";
        	$("#liked_"+likeData.postId)[0].id = "like_"+likeData.postId;
        }
    });
});

$(document).on("click", ".liked-comment",
		function(event) {
	var commentId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  '/facebook/unlikecomment',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";            	
        	$("#comment_liked_"+likeData.commentId)[0].innerHTML = "<s:text name="feeds.like"/>";
        	$("#comment_liked_"+likeData.commentId)[0].className = "like-comment";
        	$("#comment_liked_"+likeData.commentId)[0].id = "comment_like_"+likeData.commentId;
        }
    });
});

$(document).on("click", ".people-who-like",
		function(event) {
	var postId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  '/facebook/postlikers',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	var html = [];
        	var postLikers = likeData.likers;
        	$("#post_likers_"+likeData.postId)[0].innerHTML = postLikers.length + " <s:text name="feeds.likes"/>";
        	html.push("<div class=\"Absolute-Center\">");
            	html.push("<span class=\"like-title\">");
	            	if (postLikers.length > 0) {            	
	            		html.push("<s:text name="feeds.postlikedbyfollowingpeople"/>");				       
	            	} else {
	            		html.push("<s:text name="feeds.postlikedbynoone"/>");
	            	}
            	html.push("</span>");
            	html.push("<div class=\"likers\">");
            	for (var index = 0; index < postLikers.length; index += 1) {
            		var user = postLikers[index];
            		html.push("<div>");
            			html.push("<div class=\"left-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\">");
            					html.push("<img width=\"60px\" src=\"image?userId="+user.userId+"\" />");
            				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"right-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
		            			html.push("<span>");
		            				html.push(user.firstName);
		            			html.push("</span>");
		            			html.push("<span>");
		        					html.push(user.lastName);
		        				html.push("</span>");
	        				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"clear\"></div> ");
            		html.push("</div>");
            	}
            	html.push("</div>");
            html.push("</div>");
        	$("#Overlay")[0].innerHTML = html.join(" ");
        	funcShow($(event)[0].target);
        }
    });		
		
});

$(document).on("click", ".people-who-like-comment",
		function(event) {
	var commentId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  '/facebook/commentlikers',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	var html = [];
        	var commentLikers = likeData.likers;
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = commentLikers.length + " <s:text name="feeds.likes"/>";
        	html.push("<div class=\"Absolute-Center\">");
            	html.push("<span class=\"like-title\">");
	            	if (commentLikers.length > 0) {            	
	            		html.push("<s:text name="feeds.commentlikedbyfollowingpeople"/>");				       
	            	} else {
	            		html.push("<s:text name="feeds.commentlikedbynoone"/>");
	            	}
            	html.push("</span>");
            	html.push("<div class=\"likers\">");
            	for (var index = 0; index < commentLikers.length; index += 1) {
            		var user = commentLikers[index];
            		html.push("<div>");
            			html.push("<div class=\"left-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
            					html.push("<img width=\"60px\" src=\"image?userId="+user.userId+"\" />");
            				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"right-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
		            			html.push("<span>");
		            				html.push(user.firstName);
		            			html.push("</span>");
		            			html.push("<span>");
		        					html.push(user.lastName);
		        				html.push("</span>");
	        				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"clear\"></div> ");
            		html.push("</div>");
            	}
            	html.push("</div>");
            html.push("</div>");
        	$("#Overlay")[0].innerHTML = html.join(" ");
        	funcShow($(event)[0].target);
        }
    });		
		
});

$(document).on("submit", ".comment-form",
		function(event) {

			/* stop form from submitting normally */
			event.preventDefault();

			/* get some values from elements on the page: */
			var form = $(this);
			var url = form[0].action;
			var comment = form[0][0].value;
			var postId = form[0][1].value;

			/* Send the data using post */
			var posting = $.post(url, {
				"comment" : comment,
				"postId" : postId
			});

			/* Put the results in the view */
			posting.done(function(commentData) {

				var html = [];
				html.push("<div id='comment_"+ commentData.commentId +"'>");
					html.push("<div class='left-comment'>");
						html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\" >");
							html.push("<img width='40px'" + "src='image?userId=" + commentData.userId + "'/>");
						html.push("</a>");
					html.push("</div>");

					html.push("<div class='right-comment'>");
						html.push("<div class='comment-description'>");
							html.push("<div class='comment-post'>");
								html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\" >");
									html.push("<span class='fullname'> " + commentData.fullname + "</span>");
								html.push("</a>");
								html.push("<span id='comment_text_"+commentData.commentId+"' class='comment-text'>" + commentData.comment + "</span>");
							html.push("</div>");
						html.push("</div>");
						html.push("<div class='comment-options'>");
							html.push("<div class=\"btn-group\">");
								html.push("<button type=\"button\" class=\"btn dropdown-toggle comment-options-button\" data-toggle=\"dropdown\">");										
								html.push("</button>");
								html.push("<ul class=\"dropdown-menu dropdown-menu-right\">");
									html.push("<li>");
										html.push("<form id='"+commentData.commentId+"' class=\"delete_comment\" method=\"post\">");
											html.push("<input type=\"submit\"  value=\"<s:text name="feeds.delete"/>\">");
										html.push("</form>");
									html.push("</li>");
									html.push("<li class=\"divider\"></li>");
									html.push("<li>");
										html.push("<form id='"+commentData.commentId+"' class=\"edit_comment\" method=\"post\">");
											html.push("<input type=\"submit\"  value=\"<s:text name="feeds.edit"/>\">");
										html.push("</form>");																
									html.push("</li>");												
								html.push("</ul>");
							html.push("</div>");
						
						html.push("</div>");
						html.push("<div class='timestamp'>");
							html.push(commentData.now);
							html.push("<span id='comment_like_"+commentData.commentId+"' class=\"like-comment\">Like</span>");																												
							html.push("<span id='comment_likers_"+commentData.commentId+"' class=\"people-who-like-comment\">0 <s:text name="feeds.likes"/></span>");
						html.push("</div>");
					html.push("</div>");											
				html.push("</div>");
				
				html.push("<div class=\"clear\"></div> ");
				html.push($("#commentForm_" + commentData.postId)[0].outerHTML);
				
				var parent = $("#commentForm_" + commentData.postId).parent();
				$("#commentForm_" + commentData.postId).remove();
				parent.append(html.join(" "));
				//$("#commentForm_" + commentData.postId)[0][0].value = "";
			});
		});

	$(document).on("submit", "#statusform",
				function(event) {

					/* stop form from submitting normally */
					event.preventDefault();

					/* get some values from elements on the page: */
					var form = $(this);
					var url = form[0].action;
					var status = form[0][0].value;

					/* Send the data using post */
					var posting = $.post(url, {
						"status" : status
					});

					/* Put the results in the view */
					posting.done(function(commentData) {
								var html = [];
								//html.push("<div id=\"feeds\"> ");
								html.push("<div id=\"status_"+commentData.postId+"\" class=\"feed-container\">");
									html.push("<div class=\"left-status\">");
										html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\">");
											html.push("<img width=\"80px\" ");
											html.push("src=\"image?userId="
												+ commentData.userId + "\" /> ");
										html.push("</a>");
									html.push("</div> ");
								html.push("<div class=\"right-status\">");
									html.push("<div>");
										html.push("<div class=\"status-memberption\">");
											html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\">");
												html.push("<span class=\"fullname\"> ");
												html.push(commentData.fullName);
												html.push("</span> ");
											html.push("</a>");
											html.push("<s:text name="feeds.updatedthestatus"/> ");
											html.push(" ");
										html.push("</div> ");
										html.push("<div class=\"status-options\">");
											html.push("<div class=\"btn-group\">");
												html.push("<button type=\"button\" class=\"btn dropdown-toggle status-options-button\" data-toggle=\"dropdown\">");														
												html.push("</button>");
												html.push("<ul class=\"dropdown-menu dropdown-menu-right\">");
													html.push("<li>");
														html.push("<form id='"+commentData.postId+"' class=\"delete_post\" method=\"post\">");
															html.push("<input type=\"submit\"  value=\"<s:text name="feeds.delete"/>\">");
														html.push("</form>");
													html.push("</li>");
													html.push("<li class=\"divider\"></li>");
													html.push("<li>");
														html.push("<form id='"+commentData.postId+"' class=\"edit_post\" method=\"post\">");
															html.push("<input type=\"submit\"  value=\"<s:text name="feeds.edit"/>\">");
														html.push("</form>");																
													html.push("</li>");												
												html.push("</ul>");
											html.push("</div>");																								
										html.push("</div> ");
										html.push("<div class=\"clear\"></div> ");
									html.push("</div> ");
								html.push("<div id='post_"+commentData.postId+"' class=\"post\"> ");
									html.push(commentData.status);
								html.push("</div>");
								html.push("<div class=\"timestamp\">");
									html.push(commentData.now);										
									html.push("<span id='like_"+commentData.postId+"' class=\"like\"><s:text name="feeds.like"/></span>");																												
									html.push("<span id='post_likers_"+commentData.postId+"' class=\"people-who-like\">0 likes</span>");										
								html.push("</div>");
								html.push("<div>");					   
									html.push("<form id=\"commentForm_"+commentData.postId+"\" class=\"comment-form\" action=\"postcomment\" method=\"post\"> ");
										html.push("<div class=\"comment-form\">");
											html.push("<div> ");
												html.push("<textarea name=\"comment\" cols=\"57\" rows=\"2\" ");
												html.push("placeholder=\"<s:text name="feeds.postcomment"/>\" style=\"width: 95%;\"></textarea> ");
												html.push("<input type=\"hidden\" name=\"postId\" value=\""+commentData.postId+"\" />");
											html.push("</div> ");
											html.push("<div style=\"width: 95%; text-align: right;\"> ");
												html.push("<input type=\"submit\" value=\"<s:text name="feeds.post"/>\" /> ");
											html.push("</div> ");
										html.push("</div> ");
									html.push("</form> ");
								html.push("</div> ");
								html.push("</div> ");
								html.push("</div> ");
								html.push("<div class=\"clear\"></div> ");
								//html.push("  </div>");

								$("#feeds").prepend(html.join(" "));
								$("#groupstatusUpdate")[0].value = "";

							});
				});

	
$(document).on("submit", ".delete_post",
	function(event) {

	event.preventDefault();
	var answer = confirm("<s:text name="feeds.areyousuredeletepost"/>");
	if (answer) {

		var url = "deletePostAction";
		var postidvalue = $(this).attr("id");

		var posting = $.post(url, {
			"postId" : postidvalue
		});

		posting.done(function(data) {

			if (data.value == "true") {

				$("div[id='status_" + postidvalue + "']").remove();
			}
		});
	}
	return false;
});

$(document).on("submit", ".delete_comment",
		function(event) {

		event.preventDefault();
		var answer = confirm("<s:text name="feeds.areyousuredeletecomment"/>");
		if (answer) {

			var url = "deleteCommentAction";
			var commentidvalue = $(this).attr("id");

			var posting = $.post(url, {
				"commentId" : commentidvalue
			});

			posting.done(function(data) {

				if (data) {
					$("div[id='comment_" + commentidvalue + "']").remove();
				}

			});

		}

		return false;
	});

$(document).on("submit", ".edit_post", function(event) {

	event.preventDefault();

	var url = "getPostAction";
	var postidvalue = $(this).attr("id");

	var posting = $.post(url, {
		"postId" : postidvalue
	});

	posting.done(function(data) {

		var text = prompt("<s:text name="feeds.editpost"/>", data.postText);

		if (text != null) {
			
			

			var otherusrl = "editPostAction";
			
			var newPosting = $.post(otherusrl, {
				"postId" : data.postId,
				"postText" : text
			});
			
			newPosting.done(function(newdata) {

				if(newdata.value="true")
				document.getElementById("post_" + data.postId).innerHTML =text;

			});

			
		}

	});

});

$(document).on("submit", ".edit_comment", function(event) {

	event.preventDefault();
	var url = "editCommentAction";
	var commentidvalue = $(this).attr("id");
	var commentText = document.getElementById("comment_text_" + commentidvalue).innerText;
	var text = prompt("<s:text name="feeds.editcomment"/>", commentText);
	if (text != null) {									
		var newPosting = $.post(url, {
			"commentId" : commentidvalue,
			"comment" : text
		});			
		newPosting.done(function(newdata) {
			if(newdata)
			document.getElementById("comment_text_" + commentidvalue).innerText = text;

		});

		
	}
});


/* 
$(document).on(
		"submit",
		"#Button1",
		function(event) {

			/* $('othergroup').removeClass('has-error'); // remove the error class
			$('.help-block').remove(); // remove the error text
			$('.alert-success').remove(); */

			/* stop form from submitting normally */
			//event.preventDefault();
			/* get some values from elements on the page: */
		/* 	var formData = {
				'birthday' : $('input[name=birthday]').val(),
				'gender' : $("#gen option:selected").text()
			};
 */
			//$.ajax({
				////type : 'POST', // define the type of HTTP verb we want to use (POST for our form)
				//url : 'leaveGroup', // the url where we want to POST
				//data : formData, // our data object
				//dataType : 'json', // what type of data do we expect back from the server
				//encode : true
			//});

		//}); */ --%>


//jigar cover
	
	
		

		
		
<div id="Overlay" name="Overlay" class="overlay" onclick="funcClose(this);">		
	</div>	
	<s:set name="loggedInUser" value="userId" />
	<div id="status" class="status-container">

		<form id="statusform" action="groupstatusupdate" class="status-form">
			<div>
				<textarea name="status" cols="75" rows="5" id="groupstatusupdate"
					placeholder='<s:text name="feeds.whatsonmind"/>' style="width: 95%;"></textarea>					
			</div>
			<div class="status-action">
				<input type="submit" value="<s:text name="feeds.post"/>" />
			</div>
		</form>
	</div>
	<div id="feeds">

		<s:iterator value="groupnewsfeeds" var="feeds">
			<div id='status_<s:property value="#feeds.postId"/>' class="feed-container">
				<div class="left-status">
					<a href="/facebook/profile?fref=<s:property value="fromUserId" />">
						<img width="80px"
							src="image?userId=<s:property value="fromUserId" />" />
					</a>
				</div>
				<div class="right-status">
					<%-- <s:if test="#feeds.postType == 'Normal'">
						<div class="status-description">
		
							<a href="/facebook/profile?fref=<s:property value="fromUserId" />">
								<span class="fullname"> <s:property
										value="fromUserFirstName" /> <s:property
										value="fromUserLastName" />
								</span> 
							</a> <s:text name="feeds.updatedthestatus"/> 
						</div>
						<div class="status-options">							
							<span> 
								
									<div class="btn-group">
										<button type="button" class="btn dropdown-toggle status-options-button"
											data-toggle="dropdown">
										</button>
										<ul class="dropdown-menu dropdown-menu-right">
											<li>
												<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
													<input type="submit" value="<s:text name="feeds.delete"/>" />
												</form>
											</li>
											<li class="divider"></li>
											<li>
												<form id='<s:property value="#feeds.postId"/>'
														class="edit_post" method="post">
													<input type="submit" value="<s:text name="feeds.edit"/>" />
												</form>	
											</li>
										</ul>
									</div> 																										
							</span>
						</div>
						<div class="clear"></div>
					</s:if> --%>
					<%-- <s:elseif test="#feeds.postType == 'Friend'">
						<div>
							<div class="status-description">
								<a href="/facebook/profile?fref=<s:property value="fromUserId" />">
									<span class="fullname"> <s:property
											value="fromUserFirstName" /> <s:property
											value="fromUserLastName" />
									</span> 
								</a>
								<s:text name="feeds.postedon"/>
								<a href="/facebook/profile?fref=<s:property value="toUserId" />"> 
									<span class="fullname"> <s:property
											value="toUserFirstName" /> <s:property value="toUserLastName" />
									</span>
								</a><s:text name="feeds.swall"/>
							</div>
							<div class="status-options"> 
								<span> 							
									<s:if test="#loggedInUser==#feeds.toUserId">
										<div class="btn-group">
											<button type="button" class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown">
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>												
											</ul>
										</div> 											
									</s:if> 
									<s:elseif test="#loggedInUser==#feeds.fromUserId">
										<div class="btn-group">
											<button type="button" class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown">
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>
												<li class="divider"></li>
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="edit_post" method="post">
														<input type="submit" value="<s:text name="feeds.edit"/>" />
													</form>	
												</li>												
											</ul>
										</div> 																				
									</s:elseif>								
								</span>
							</div>						
							<div class="clear"></div>
						</div>
					</s:elseif> --%>
					<s:if test="#feeds.postType == 'Group'">
						<div>
							<div class="status-description">
								<a href="/facebook/profile?fref=<s:property value="fromUserId" />">
									<span class="fullname"> <s:property
											value="fromUserFirstName" /> <s:property
											value="fromUserLastName" />
									</span> 
								</a>
								<s:text name="feeds.postedon"/>
								<a href="/facebook/profile?fref=<s:property value="toUserId" />"> 
									<span class="fullname"> <s:property
											value="toUserFirstName" /> <s:property value="toUserLastName" />
									</span>
								</a><s:text name="feeds.swall"/>
							</div>
							<div class="status-options"> 
								<span> 							
									<s:if test="#loggedInUser==#feeds.toUserId">
										<div class="btn-group">
											<button type="button" class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown">
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>												
											</ul>
										</div> 											
									</s:if> 
									<s:elseif test="#loggedInUser==#feeds.fromUserId">
										<div class="btn-group">
											<button type="button" class="btn dropdown-toggle status-options-button"
												data-toggle="dropdown">
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="delete_post" method="post">
														<input type="submit" value="<s:text name="feeds.delete"/>" />
													</form>
												</li>
												<li class="divider"></li>
												<li>
													<form id='<s:property value="#feeds.postId"/>'
														class="edit_post" method="post">
														<input type="submit" value="<s:text name="feeds.edit"/>" />
													</form>	
												</li>												
											</ul>
										</div> 																				
									</s:elseif>								
								</span>
							</div>						
							<div class="clear"></div>
						</div>
					</s:if>
					<div id='post_<s:property value="#feeds.postId"/>' class="post">
						<s:property value="postText" />
					</div>
					<div class="timestamp">
						<s:property value="updatedTime" />
						<s:if test="#feeds.haveILiked == true">
							<span id='liked_<s:property value="#feeds.postId"/>' class="liked"><s:text name="feeds.liked"/></span>
						</s:if>
							<span id='like_<s:property value="#feeds.postId"/>' class="like"><s:text name="feeds.like"/></span>

						<span id='post_likers_<s:property value="#feeds.postId"/>' class="people-who-like">
							<s:property value="#feeds.likeCount" />	<s:text name="feeds.likes"/>
						</span>
					</div>
					<div>
						<s:iterator value="#feeds.postComments" var="comments">
							<div id='comment_<s:property value="#comments.commentId"/>'>
								<div class="left-comment">
									<a href="/facebook/profile?fref=<s:property value="#comments.commenterUserId" />">
										<img width="40px"
											src="image?userId=<s:property value="#comments.commenterUserId" />" />
									</a>
								</div>
								<div class="right-comment">
									<div class= "comment-description">
										<div class="comment-post">
											<a href="/facebook/profile?fref=<s:property value="#comments.commenterUserId" />">
												<span class="fullname"> <s:property
													value="#comments.commenterFirstName" /> <s:property
													value="#comments.commenterLastName" />
												</span>
											</a> 
												<span id='comment_text_<s:property value="#comments.commentId"/>' class="comment-text"> <s:property
													value="#comments.commentText" />
												</span>
										</div>
									</div>
									<div class="comment-options"> 
										<span> 							
											<s:if test="#loggedInUser==#feeds.toUserId && #loggedInUser!=#comments.commenterUserId">
												<div class="btn-group">
													<button type="button" class="btn dropdown-toggle comment-options-button"
														data-toggle="dropdown">
													</button>
													<ul class="dropdown-menu dropdown-menu-right">
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="delete_comment" method="post">
																<input type="submit" value="<s:text name="feeds.delete"/>" />
															</form>
														</li>																									
													</ul>
												</div> 											
											</s:if> 
											<s:elseif test="#loggedInUser==#comments.commenterUserId">
												<div class="btn-group">
													<button type="button" class="btn dropdown-toggle comment-options-button"
														data-toggle="dropdown">
													</button>
													<ul class="dropdown-menu dropdown-menu-right">
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="delete_comment" method="post">
																<input type="submit" value="<s:text name="feeds.delete"/>" />
															</form>
														</li>
														<li class="divider"></li>
														<li>
															<form id='<s:property value="#comments.commentId"/>'
																class="edit_comment" method="post">
																<input type="submit" value="<s:text name="feeds.edit"/>" />
															</form>	
														</li>												
													</ul>
												</div> 																				
											</s:elseif>								
										</span>
									</div>	
									<div class="timestamp">
										<s:property value="#comments.commentTime" />
										
											<span id='comment_liked_<s:property value="#comments.commentId"/>' class="liked-comment"><s:text name="feeds.liked"/></span>
										
										<s:elseif test="#comments.haveILiked == false">
											<span id='comment_like_<s:property value="#comments.commentId"/>' class="like-comment"><s:text name="feeds.like"/></span>
										</s:elseif>
										<span id='comment_likers_<s:property value="#comments.commentId"/>' class="people-who-like-comment">
											<s:property value="#comments.likeCount" /> <s:text name="feeds.likes"/>
										</span>
									</div>
								</div>
								<div class="clear"></div>
							</div>
						</s:iterator>
						<s:set var="postId" value="%{postId}" />
						<%
							int postId = (Integer) pageContext.getAttribute("postId");
						%>
						<form id="commentForm_<%=postId%>" class="comment-form"
							action="postcomment" method="post">
							<div class="comment-form">
								<div>
									<textarea name="comment" cols="57" rows="2"
										placeholder="<s:text name="feeds.postcomment"/>" style="width: 95%;"></textarea>
									<s:hidden name="postId" value="%{postId}" />
								</div>
								<div style="width: 95%; text-align: right;">
									<input type="submit" value="<s:text name="feeds.post"/>" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</s:iterator>
	</div>
</body>
<%-- <script src="js/jquery-1.10.2.js"></script> --%>
<script>
function funcShow(_btn) {
    var ov = $("#Overlay");
    var pos = $(_btn).offset();
    var doc = $(document);
    ov.css({
        left: pos.left + 'px',
        top: pos.top + 'px',
        width: 0,
        height: 0
    })
    .show()
    .animate({
        left: pos.left + 'px',
        top: pos.right + 'px',
        width: '30%',
        height: '60%'
        }, "slow");
    
}

function funcClose() {
   $("#Overlay").hide("slow");
}

$(document).on("click", ".like",
		function(event) {		
	var postId = $(this)[0].id.split("_")[1];		
	$.ajax({
        url:  './likepost',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	//alert("in feeds");
        	$("#post_likers_"+likeData.postId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#like_"+likeData.postId)[0].innerHTML = "<s:text name="feeds.liked"/>";
        	$("#like_"+likeData.postId)[0].className = "liked";
        	$("#like_"+likeData.postId)[0].id = "liked_"+likeData.postId;
        }
    });
});

$(document).on("click", ".like-comment",
		function(event) {		
	var commentId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  './likecomment',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#comment_like_"+likeData.commentId)[0].innerHTML = "<s:text name="feeds.liked"/>";
        	$("#comment_like_"+likeData.commentId)[0].className = "liked-comment";
        	$("#comment_like_"+likeData.commentId)[0].id = "comment_liked_"+likeData.commentId;
        }
    });
});

$(document).on("click", ".liked",
		function(event) {
	var postId = $(this)[0].id.split("_")[1];		
	$.ajax({
        url:  './unlikepost',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	$("#post_likers_"+likeData.postId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";
        	$("#liked_"+likeData.postId)[0].innerHTML = "<s:text name="feeds.like"/>";
        	$("#liked_"+likeData.postId)[0].className = "like";
        	$("#liked_"+likeData.postId)[0].id = "like_"+likeData.postId;
        }
    });
});

$(document).on("click", ".liked-comment",
		function(event) {
	var commentId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  './unlikecomment',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = likeData.likersCount + " <s:text name="feeds.likes"/>";            	
        	$("#comment_liked_"+likeData.commentId)[0].innerHTML = "<s:text name="feeds.like"/>";
        	$("#comment_liked_"+likeData.commentId)[0].className = "like-comment";
        	$("#comment_liked_"+likeData.commentId)[0].id = "comment_like_"+likeData.commentId;
        }
    });
});

$(document).on("click", ".people-who-like",
		function(event) {
	var postId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  './postlikers',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"postId" : postId
        },
        success: function(likeData) {
        	var html = [];
        	var postLikers = likeData.likers;
        	$("#post_likers_"+likeData.postId)[0].innerHTML = postLikers.length + " <s:text name="feeds.likes"/>";
        	html.push("<div class=\"Absolute-Center\">");
            	html.push("<span class=\"like-title\">");
	            	if (postLikers.length > 0) {            	
	            		html.push("<s:text name="feeds.postlikedbyfollowingpeople"/>");				       
	            	} else {
	            		html.push("<s:text name="feeds.postlikedbynoone"/>");
	            	}
            	html.push("</span>");
            	html.push("<div class=\"likers\">");
            	for (var index = 0; index < postLikers.length; index += 1) {
            		var user = postLikers[index];
            		html.push("<div>");
            			html.push("<div class=\"left-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\">");
            					html.push("<img width=\"60px\" src=\"image?userId="+user.userId+"\" />");
            				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"right-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
		            			html.push("<span>");
		            				html.push(user.firstName);
		            			html.push("</span>");
		            			html.push("<span>");
		        					html.push(user.lastName);
		        				html.push("</span>");
	        				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"clear\"></div> ");
            		html.push("</div>");
            	}
            	html.push("</div>");
            html.push("</div>");
        	$("#Overlay")[0].innerHTML = html.join(" ");
        	funcShow($(event)[0].target);
        }
    });		
		
});

$(document).on("click", ".people-who-like-comment",
		function(event) {
	var commentId = $(this)[0].id.split("_")[2];		
	$.ajax({
        url:  './commentlikers',
        type: 'POST', 
        dataType: 'json',
        data: {
        	"commentId" : commentId
        },
        success: function(likeData) {
        	var html = [];
        	var commentLikers = likeData.likers;
        	$("#comment_likers_"+likeData.commentId)[0].innerHTML = commentLikers.length + " <s:text name="feeds.likes"/>";
        	html.push("<div class=\"Absolute-Center\">");
            	html.push("<span class=\"like-title\">");
	            	if (commentLikers.length > 0) {            	
	            		html.push("<s:text name="feeds.commentlikedbyfollowingpeople"/>");				       
	            	} else {
	            		html.push("<s:text name="feeds.commentlikedbynoone"/>");
	            	}
            	html.push("</span>");
            	html.push("<div class=\"likers\">");
            	for (var index = 0; index < commentLikers.length; index += 1) {
            		var user = commentLikers[index];
            		html.push("<div>");
            			html.push("<div class=\"left-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
            					html.push("<img width=\"60px\" src=\"image?userId="+user.userId+"\" />");
            				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"right-likers\">");
            				html.push("<a href=\"/facebook/profile?fref="+user.userId+"\" >");
		            			html.push("<span>");
		            				html.push(user.firstName);
		            			html.push("</span>");
		            			html.push("<span>");
		        					html.push(user.lastName);
		        				html.push("</span>");
	        				html.push("</a>");
            			html.push("</div>");
            			html.push("<div class=\"clear\"></div> ");
            		html.push("</div>");
            	}
            	html.push("</div>");
            html.push("</div>");
        	$("#Overlay")[0].innerHTML = html.join(" ");
        	funcShow($(event)[0].target);
        }
    });		
		
});

$(document).on("submit", ".comment-form",
		function(event) {

			/* stop form from submitting normally */
			event.preventDefault();

			/* get some values from elements on the page: */
			var form = $(this);
			var url = form[0].action;
			var comment = form[0][0].value;
			var postId = form[0][1].value;

			/* Send the data using post */
			var posting = $.post(url, {
				"comment" : comment,
				"postId" : postId
			});

			/* Put the results in the view */
			posting.done(function(commentData) {

				var html = [];
				html.push("<div id='comment_"+ commentData.commentId +"'>");
					html.push("<div class='left-comment'>");
						html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\" >");
							html.push("<img width='40px'" + "src='image?userId=" + commentData.userId + "'/>");
						html.push("</a>");
					html.push("</div>");

					html.push("<div class='right-comment'>");
						html.push("<div class='comment-description'>");
							html.push("<div class='comment-post'>");
								html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\" >");
									html.push("<span class='fullname'> " + commentData.fullname + "</span>");
								html.push("</a>");
								html.push("<span id='comment_text_"+commentData.commentId+"' class='comment-text'>" + commentData.comment + "</span>");
							html.push("</div>");
						html.push("</div>");
						html.push("<div class='comment-options'>");
							html.push("<div class=\"btn-group\">");
								html.push("<button type=\"button\" class=\"btn dropdown-toggle comment-options-button\" data-toggle=\"dropdown\">");										
								html.push("</button>");
								html.push("<ul class=\"dropdown-menu dropdown-menu-right\">");
									html.push("<li>");
										html.push("<form id='"+commentData.commentId+"' class=\"delete_comment\" method=\"post\">");
											html.push("<input type=\"submit\"  value=\"<s:text name="feeds.delete"/>\">");
										html.push("</form>");
									html.push("</li>");
									html.push("<li class=\"divider\"></li>");
									html.push("<li>");
										html.push("<form id='"+commentData.commentId+"' class=\"edit_comment\" method=\"post\">");
											html.push("<input type=\"submit\"  value=\"<s:text name="feeds.edit"/>\">");
										html.push("</form>");																
									html.push("</li>");												
								html.push("</ul>");
							html.push("</div>");
						
						html.push("</div>");
						html.push("<div class='timestamp'>");
							html.push(commentData.now);
							html.push("<span id='comment_like_"+commentData.commentId+"' class=\"like-comment\">Like</span>");																												
							html.push("<span id='comment_likers_"+commentData.commentId+"' class=\"people-who-like-comment\">0 <s:text name="feeds.likes"/></span>");
						html.push("</div>");
					html.push("</div>");											
				html.push("</div>");
				
				html.push("<div class=\"clear\"></div> ");
				html.push($("#commentForm_" + commentData.postId)[0].outerHTML);
				
				var parent = $("#commentForm_" + commentData.postId).parent();
				$("#commentForm_" + commentData.postId).remove();
				parent.append(html.join(" "));
				//$("#commentForm_" + commentData.postId)[0][0].value = "";
			});
		});

	$(document).on("submit", "#statusform",
				function(event) {

					/* stop form from submitting normally */
					event.preventDefault();

					/* get some values from elements on the page: */
					var form = $(this);
					var url = form[0].action;
					var status = form[0][0].value;
					var grpID = <%=grpName.get(0).getGroupID()%>
					
					var posting = $.post(url, {
						"status" : status,
						"grpID"  : grpID
					});

					/* Put the results in the view */
					posting.done(function(commentData) {
								var html = [];
								//html.push("<div id=\"feeds\"> ");
								html.push("<div id=\"status_"+commentData.postId+"\" class=\"feed-container\">");
									html.push("<div class=\"left-status\">");
										html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\">");
											html.push("<img width=\"80px\" ");
											html.push("src=\"image?userId="
												+ commentData.userId + "\" /> ");
										html.push("</a>");
									html.push("</div> ");
								html.push("<div class=\"right-status\">");
									html.push("<div>");
										html.push("<div class=\"status-description\">");
											html.push("<a href=\"/facebook/profile?fref="+commentData.userId+"\">");
												html.push("<span class=\"fullname\"> ");
												html.push(commentData.fullName);
												html.push("</span> ");
											html.push("</a>");
											html.push("<s:text name="feeds.updatedthestatus"/> ");
											html.push(" ");
										html.push("</div> ");
										html.push("<div class=\"status-options\">");
											html.push("<div class=\"btn-group\">");
												html.push("<button type=\"button\" class=\"btn dropdown-toggle status-options-button\" data-toggle=\"dropdown\">");														
												html.push("</button>");
												html.push("<ul class=\"dropdown-menu dropdown-menu-right\">");
													html.push("<li>");
														html.push("<form id='"+commentData.postId+"' class=\"delete_post\" method=\"post\">");
															html.push("<input type=\"submit\"  value=\"<s:text name="feeds.delete"/>\">");
														html.push("</form>");
													html.push("</li>");
													html.push("<li class=\"divider\"></li>");
													html.push("<li>");
														html.push("<form id='"+commentData.postId+"' class=\"edit_post\" method=\"post\">");
															html.push("<input type=\"submit\"  value=\"<s:text name="feeds.edit"/>\">");
														html.push("</form>");																
													html.push("</li>");												
												html.push("</ul>");
											html.push("</div>");																								
										html.push("</div> ");
										html.push("<div class=\"clear\"></div> ");
									html.push("</div> ");
								html.push("<div id='post_"+commentData.postId+"' class=\"post\"> ");
									html.push(commentData.status);
								html.push("</div>");
								html.push("<div class=\"timestamp\">");
									html.push(commentData.now);										
									html.push("<span id='like_"+commentData.postId+"' class=\"like\"><s:text name="feeds.like"/></span>");																												
									html.push("<span id='post_likers_"+commentData.postId+"' class=\"people-who-like\">0 likes</span>");										
								html.push("</div>");
								html.push("<div>");					   
									html.push("<form id=\"commentForm_"+commentData.postId+"\" class=\"comment-form\" action=\"postcomment\" method=\"post\"> ");
										html.push("<div class=\"comment-form\">");
											html.push("<div> ");
												html.push("<textarea name=\"comment\" cols=\"57\" rows=\"2\" ");
												html.push("placeholder=\"<s:text name="feeds.postcomment"/>\" style=\"width: 95%;\"></textarea> ");
												html.push("<input type=\"hidden\" name=\"postId\" value=\""+commentData.postId+"\" />");
											html.push("</div> ");
											html.push("<div style=\"width: 95%; text-align: right;\"> ");
												html.push("<input type=\"submit\" value=\"<s:text name=".post"/>\" /> ");
											html.push("</div> ");
										html.push("</div> ");
									html.push("</form> ");
								html.push("</div> ");
								html.push("</div> ");
								html.push("</div> ");
								html.push("<div class=\"clear\"></div> ");
								//html.push("  </div>");

								$("#feeds").prepend(html.join(" "));
								$("#statusUpdate")[0].value = "";

							});
				});

	
$(document).on("submit", ".delete_post",
	function(event) {

	event.preventDefault();
	var answer = confirm("<s:text name="feeds.areyousuredeletepost"/>");
	if (answer) {

		var url = "deletePostAction";
		var postidvalue = $(this).attr("id");

		var posting = $.post(url, {
			"postId" : postidvalue
		});

		posting.done(function(data) {

			if (data.value == "true") {

				$("div[id='status_" + postidvalue + "']").remove();
			}

		});

	}

	return false;
});

$(document).on("submit", ".delete_comment",
		function(event) {

		event.preventDefault();
		var answer = confirm("<s:text name="feeds.areyousuredeletecomment"/>");
		if (answer) {

			var url = "deleteCommentAction";
			var commentidvalue = $(this).attr("id");

			var posting = $.post(url, {
				"commentId" : commentidvalue
			});

			posting.done(function(data) {

				if (data) {
					$("div[id='comment_" + commentidvalue + "']").remove();
				}

			});

		}

		return false;
	});

$(document).on("submit", ".edit_post", function(event) {

	event.preventDefault();

	var url = "getPostAction";
	var postidvalue = $(this).attr("id");

	var posting = $.post(url, {
		"postId" : postidvalue
	});

	posting.done(function(data) {

		var text = prompt("<s:text name="feeds.editpost"/>", data.postText);

		if (text != null) {
			
			

			var otherusrl = "editPostAction";
			
			var newPosting = $.post(otherusrl, {
				"postId" : data.postId,
				"postText" : text
			});
			
			newPosting.done(function(newdata) {

				if(newdata.value="true")
				document.getElementById("post_" + data.postId).innerHTML =text;

			});

			
		}

	});

});

$(document).on("submit", ".edit_comment", function(event) {

	event.preventDefault();
	var url = "editCommentAction";
	var commentidvalue = $(this).attr("id");
	var commentText = document.getElementById("comment_text_" + commentidvalue).innerText;
	var text = prompt("<s:text name="feeds.editcomment"/>", commentText);
	if (text != null) {									
		var newPosting = $.post(url, {
			"commentId" : commentidvalue,
			"comment" : text
		});			
		newPosting.done(function(newdata) {
			if(newdata)
			document.getElementById("comment_text_" + commentidvalue).innerText = text;

		});

		
	}
});
		
		
function uploadMyCover(form)
{
	alert("hereeee");
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			 console.log(xmlhttp.responseText);
		    document.getElementById("").innerHTML=xmlhttp.responseText;
		   
	    }
	  }
	
xmlhttp.open("POST","./groupcoverpicupload",true);
//?grpID="+grpID
	var formData = new FormData(form);
	xmlhttp.send(formData);
	//xmlhttp.send();
	//location.replace("http://localhost:8080/facebook/newsfeeds.action");
	location.reload();
	return true;
}

function yes(grpID)
{
//	alert(semname);
	alert(grpID);
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			 console.log(xmlhttp.responseText);
		    document.getElementById("1").innerHTML=xmlhttp.responseText;
		    //event.preventDefault();
		   
	    }
	  }
xmlhttp.open("POST","./leaveGroup?grpID="+grpID,true);
	xmlhttp.send();
	$('#modal1').modal('hide');
	$('#modal2').modal({
		show : 'false',
	});
	location.reload();
	return true;
	// event.preventDefault();
	//event.preventDefault();
}

</script>
</html>
