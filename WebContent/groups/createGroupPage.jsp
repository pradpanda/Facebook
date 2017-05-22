<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<!DOCTYPE html>
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
<link href="/facebookv1/css/jquery-ui.css" rel="stylesheet">

<title>Create New Group</title>

<script src="/facebookv1/js/jquery-ui.js"></script>
<script src="/facebookv1/js/jquery.min.js"></script>
<script src="/facebookv1/js/jquery.tokeninput.js"></script>
<link rel="stylesheet" href="css/token-input.css" type="text/css" />
<link rel="stylesheet" href="css/token-input-facebook.css" type="text/css" />
<script src="/facebookv1/js//bootstrap.min.js"></script>


<script type="text/javascript">
	$(document).ready(
			function() 
			{
				//alert("ready");
				var posting = $.post("searchAction1.action");
				posting.done(function(response) {
					// Pre-process response before passing to make it more friendly to tokenInput
					//alert("creategrp");
					var grpUserList = [];
					//alert(response.grpUserList.g);

					//alert(jQuery.isEmptyObject(response.grpUserList));
					var i = 0;
					$.each(response.grpUserList, function(index, user) {
						i = i + 1;
						//alert(user.firstName);
					//	console.log('entered');
						grpUserList.push({
							userId : user.userId,
							firstName : user.firstName,
							lastName : user.lastName,
							searchIn : user.firstName + " " + user.lastName
									+ " "
						});
					});
					$("#search1").tokenInput(
							grpUserList,
							{
								propertyToSearch : "searchIn",
								theme : "facebook",
								tokenFormatter : function(item) {
									return "<li><strong>" + item.firstName
											+ " " + item.lastName + " "
											+ item.userId + "</strong></li>";
								}
							});
				});
				

				$("#Button1").click(
						function() {
							var memtxt = '';
							//var temp = 'new check';
							var nametxt = $('#grpName').val();
							$("#search1").prev('ul').find('li:not(:last-child)').each(
											function() {

												memtxt += $(this).text() + " ";
											//	alert(memtxt);

											});
							var posting = $.post("addGroup.action", {
								"grpMembers" : memtxt,
								"grpName" : nametxt
							});
							$('#hidMem').val(memtxt);
							$('#hidName').val(nametxt);

							$('#modal1').modal('hide');
							$('#modal2').modal({
								show : 'true'
							});
						    //$(window.location).attr('href', 'http://localhost:8080/facebook/groupDummy.action');
							//window.location.href = "http://localhost:8080/facebook/group";
							/* 
							 $('#modal1').modal({
							 show: 'false'
							 }); */
							 location.reload();
							return false;
						}); 
				$("#Button2").click(function() {

					var memtxt = $('#hidMem').val();
					var nametxt = $('#hidName').val();
					$('#grpName').val("");
					$('#search1').val(" ");
					$('#modal1').modal('hide');
					$('#modal2').modal('hide');
					return false;
				});

				/* $("#selectImage").imagepicker({
					hide_select : true
				});
 */
/* 				var $container = $('.image_picker_selector');
				// initialize
				$container.imagesLoaded(function() {
					$container.masonry({
						columnWidth : 30,
						itemSelector : '.thumbnail'
					});
				}); */

			});
</script>
<script type="text/javascript">
	function getsearchfriends() {

	}
</script>

<script type="text/javascript">
	function validateAndSubmit() {
		if (document.getElementById("nm").value == "")
			alert("Name is empty.");
		else if (document.getElementById("dc").value == "")
			alert("Details are missing.");

		else {
			//document.getElementById("tm").value+=":00";
			document.getElementById("f1").submit();
		}
	}
</script>
</head>


<body style="background-color:">
	<div class="modal fade" id="modalCreateGroup" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" on>
		<div class="modal-dialog">
			<div class="modal-content modal-content-one">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h5 class="modal-title" id="myModalLabel" align="left">
						<b>Create New Group</b>
					</h5>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Group
									Name </label></td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 400px"  
								name="grpName" id="grpName" /></td>
						</tr>
						<tr>
							<td align="right"><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Members </label>&nbsp;&nbsp;&nbsp;</td>
							<td>&nbsp;&nbsp;<input type="text" style="width: 300px"
								id="search1" name="search1" /></td>
						</tr>
					</table>
					<hr width="100%">

					<hr width="100%">
					<table width="100%">
						<tr align="right">
							<td align="right"><input type="submit" value="cancel"
								align="right" id="Button2" /> <input
								type="submit" value="create" align="right" id="Button1" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>