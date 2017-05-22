<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Modal</title>

<link href="css/bootstrap.css" rel="stylesheet"/>
<link href="css/bootstrap-theme.css" rel="stylesheet">
<link href="css/bootstrap-theme.css.map" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet"/>
<link href="css/bootstrap.css.map" rel="stylesheet"/>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/dashboard.css" rel="stylesheet">
<%@include file="/jsp/ajaxscripts.jsp"%>

</head>
<body>
	After clicking this modal should pop up.....
	<br>
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading" align="left">
				<h3>Create New Event</h3>
			</div>
            <form class="form-horizontal"  method="post" enctype="multipart/form-data" name="myform" id="myform" >
			<form class="form-horizontal" method="post" enctype="multipart/form-data" name="newevent" id="newevent">
				<!-- action="createnewevent" -->
				
				<fieldset>

					<!-- 0th row of form -->

					<div class="row">
						<!-- 1st column of 1st row -->
						<div class="col-lg-3" align="left">
							<b>Name:</b>
						</div>
						<div class="col-lg-5"></div>
						<div class="col-lg-4" align="center">
							<input type="text" class="form-control" name="eventtitle"
								placeholder="ex: Birthday Party" id="eventtitle">
						</div>
					</div>

					<br>

					<!-- 1th row of form -->

					<div class="row">
						<!-- 1st column of 1st row -->
						<div class="col-lg-3" align="left">
							<b>Details:</b>
						</div>
						<div class="col-lg-5"></div>
						<div class="col-lg-4" align="center">
							<!-- 	<input type="textarea" class="form-control" name="eventdescription"
							placeholder="Add more info" id="eventdescription" required> -->
							<textarea class="form-control" name="eventdescription"
								placeholder="Add more info" id="eventdescription"></textarea>
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
								placeholder="Add a place?" id="eventplace">
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
								placeholder="YYYY-MM-DD" id="eventdate">
						</div>


						<!-- 2nd column of 3rd row -->
						<div class="col-lg-1"></div>
						<!-- <div class="col-lg-4" align="right">
							<select class="form-control" name="eventtime" id="eventtime">
								<option value="default" selected>Select time</option>
								<option value="00:00" selected>00:00</option>
								<option value="00:15" selected>00:15</option>
								<option value="00:30" selected>00:30</option>
							</select>

						</div>
 -->					</div>

					<br>

					<div class="row">
						<div class="col-lg-6" align="left"></div>
						
						<div class="col-lg-3" align="center" >
							
 <input type="button" id="submit" class="btn btn-primary" value="submit" onclick="eventsubmit123(this.form)">

						</div>
						<!-- <div class="col-lg-3" align="right">
							<input type="button" class="btn btn-primary" type="hidden"
								onclick="cancelevent()" name="eventcancel" value="cancel">
						</div> -->
						<div class="col-lg-3" align="right">
						 <a href="#" class="btn btn-default">Cancel</a> 
						</div>

				 </div>
				</fieldset>
			</form>

		</div>
	</div>
	
	

</body>
</html> --%>