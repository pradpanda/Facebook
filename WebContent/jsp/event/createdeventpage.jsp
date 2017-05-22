<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-theme.css" rel="stylesheet">
<link href="css/bootstrap-theme.css.map" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/bootstrap.css.map" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/dashboard.css" rel="stylesheet"> -->
<script  type='text/javascript' src='js/jquery-1.11.2.js'></script>

<%-- <script>

​$(document).ready(function(){
    var content = "Hello World";
    $("#eventdescription").val(content);
});

</script> --%>

<style type="text/css">
.modalDialog {
	position: fixed;
	font-family: Arial, Helvetica, sans-serif;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.8);
	z-index: 99999;
	opacity: 0;
	-webkit-transition: opacity 400ms ease-in;
	-moz-transition: opacity 400ms ease-in;
	transition: opacity 400ms ease-in;
	pointer-events: none;
}

.modalDialog:target {
	opacity: 1;
	pointer-events: auto;
}

.modalDialog>div {
	width: 400px;
	position: relative;
	margin: 10% auto;
	padding: 5px 20px 13px 20px;
	border-radius: 10px;
	background: #fff;
	background: -moz-linear-gradient(#fff, #999);
	background: -webkit-linear-gradient(#fff, #999);
	background: -o-linear-gradient(#fff, #999);
}

.close {
	background: #606061;
	color: #FFFFFF;
	line-height: 25px;
	position: absolute;
	right: -12px;
	text-align: center;
	top: -10px;
	width: 24px;
	text-decoration: none;
	font-weight: bold;
	-webkit-border-radius: 12px;
	-moz-border-radius: 12px;
	border-radius: 12px;
	-moz-box-shadow: 1px 1px 3px #000;
	-webkit-box-shadow: 1px 1px 3px #000;
	box-shadow: 1px 1px 3px #000;
}

.close:hover {
	background: #00d9ff;
}
</style>

</head>
<body style="background-color: #E5E5E9;">
	<div style="background-color: #D2D2D8;">
		<br /> <br /> <br /> <br /> <br /> <br /> <br />
		<h2>&nbsp;<s:property value="eventtitle" /></h2>
		<br />
	</div>
	<div style="background-color: #FFFFFF; float: left; width: 520px;">
		<br /> &nbsp;Hosted by <a style="color: blue;" href='#'><s:property value="ufirstname" />&nbsp;<s:property value="ulastname" /></a> <br /> <br />
	</div>
	<!-- profile?fref=9 -->
	<div style="background-color: #FFFFFF;">
		   <a style="text-decoration: none;" href='invite?eventId=7'><input type="button" value="Invite"></a> 
			<!-- <a style="text-decoration: none;" href='editEvent?eventId=7'><input
			type="button" value="Edit"></a> -->
			
	              <a href="#openModal" style="font-size: medium; background-color: navy; color: white">Edit</a>
			
			 <br /> <br />
	</div>
	<br />
	<div style="float: left; width: 500px;">
		<div style="background-color: #FFFFFF;">
			<br /> &nbsp;<s:property value="eventdate" /> at <s:property value="eventtime" /> <br />
			<hr />
			&nbsp;<s:property value="eventdescription" /> <br /> <br />
		</div>
		<br />
		<div style="background-color: #FFFFFF;">
			<br /> &nbsp;<s:property value="eventplace" /> <br /> <br />
		</div>
	</div>
	<div style="margin-left: 510px;">
		<div style="background-color: #FFFFFF;">


			<table width="100%">
				<thead>
					<b>GUESTS</b>
				</thead>
				<tbody>
					<tr>
						<td><a style="text-decoration: none; color: blue;"
							href='goingList?eventId=7'>1</a></td>
						<td><a style="text-decoration: none; color: blue;"
							href='maybeList?eventId=7'>0</a></td>
						<td><a style="text-decoration: none; color: blue;"
							href='invitedList?eventId=7'>0</a></td>
					</tr>
					<tr>
						<td><a style="text-decoration: none; color: blue;"
							href='goingList?eventId=7'>going</a></td>
						<td><a style="text-decoration: none; color: blue;"
							href='maybeList?eventId=7'>maybe</a></td>
						<td><a style="text-decoration: none; color: blue;"
							href='invitedList?eventId=7'>invited</a></td>
					</tr>
				</tbody>
			</table>



		</div>
	</div>


	<div class="clear"></div>
	<div>
		<div style="width: 100%; text-align: center;">
			<span>Facebook © 2015</span>
		</div>
	</div>

	<%!String msg;%>
	<%
		msg = response.getHeader("msg");
		if (msg != null) {
	%>
	<div class="col-lg-12 form-group">
		<h2 align="center" class="label label-success"><%=msg%></h2>
	</div>
	<%
		}
	%>

	<div id="openModal" class="modalDialog">
		<div>
			<a href="#close" title="Close" class="close">X</a>

			<div class="container">
				<div class="panel panel-primary">
					<div class="panel-heading" align="left">
						<h3>Edit Event Info</h3>
					</div>

					<s:form class="form-horizontal" method="post"
						enctype="multipart/form-data" name="newevent" id="newevent" action="updateevent">
						<!-- action="createnewevent" "deleteevent"-->
					

							<!-- 0th row of form -->

							<div class="row">
								<!-- 1st column of 1st row -->
								<div class="col-lg-3" align="left">
									<b>Name:</b>
								</div>
								<div class="col-lg-5"></div>
								<div class="col-lg-4" align="center">
									<input type="text" class="form-control" name="eventtitle"
										placeholder="ex: Birthday Party" id="eventtitle" value=<s:property value = "eventtitle" /> />
								</div>
							</div>
<%-- value=<s:property value = "eventtitle" /> --%>
							<br>

							<!-- 1th row of form -->

							<div class="row">
								<!-- 1st column of 1st row -->
								<div class="col-lg-3" align="left">
									<b>Details:</b>
								</div>
								<div class="col-lg-5"></div>
								<div class="col-lg-4" align="center">
									<textarea class="form-control" name="eventdescription"
										placeholder="Add more info" id="eventdescription" ><s:property value="eventdescription" /></textarea>
								</div>
							</div>

							<br>

							<!-- 2th row of form -->

							<div class="row">
								<!-- 1st column of 1st row -->
								<div class="col-lg-3" align="left">
									<b>Where:</b>
								</div>
								<div class="col-lg-5"></div>
								<div class="col-lg-4" align="center">
									<input type="text" class="form-control" name="eventplace"
										placeholder="Add a place?" id="eventplace" value=<s:property value = "eventplace" />>
								</div>
								
								<div class="col-lg-4" align="center">
									<input  name="eventid" type="hidden" id="eventid" value=<s:property value = "eventid" />>
								</div>
							</div>

							<br>

							<!-- 3th row of form -->

							<div class="row">
								<!-- 1st column of 3rd row -->
								<div class="col-lg-3" align="left">
									<b>When:</b>
								</div>
								<div class="col-lg-4" align="center">
									<input type="date" class="form-control" name="eventdate"
										placeholder="YYYY-MM-DD" id="eventdate" value=<s:property value = "eventdate" />>
								</div>


								<!-- 2nd column of 3rd row -->
								<div class="col-lg-1"></div>
								<div class="col-lg-4" align="right">
									<select class="form-control" name="eventtime" id="eventtime">
										<option value="default" selected>Select time</option>
										<option value="00:00" selected>00:00</option>
										<option value="00:15" selected>00:15</option>
										<option value="00:30" selected>00:30</option>
									</select>

								</div>
							</div>

							<br>

							<div class="row">
								<div class="col-lg-6" align="left"></div>

								<div class="col-lg-3" align="center">
									<!-- <input type="submit" class="btn btn-primary" name="updateevent"
										value="Save" > -->
										<s:submit value="Save"></s:submit>
								</div>

								<div class="col-lg-3" align="right">
									<a href="#" class="btn btn-default">Cancel</a>
								</div>
								
								<div class="col-lg-3" align="center">
									<!-- <input type="submit" class="btn btn-primary" name="cancelevent"
										value="Cancel Event" action="deleteevent"> -->
									<s:submit value="Cancel Event" action="deleteevent"></s:submit>
								</div>

							</div>
					
					</s:form>

				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>