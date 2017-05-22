<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
 <%@include file="/jsp/ajaxscripts.jsp"%> 

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/dashboard.css">
<script  type='text/javascript' src='js/bootstrap.min.js'></script>


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
<body>
	
		<a href="#openModal"
			style="font-size: medium; background-color: navy; color: white">+ Create Event</a>
	


	<div id="openModal" class="modalDialog"> -->
		<div>
			<a href="#close" title="Close" class="close">X</a>

			<div class="container">
				<div class="panel panel-primary">
					<div class="panel-heading" align="left">
						<h3>Create New Event</h3>
					</div>

					<form class="form-horizontal" method="post"
						enctype="multipart/form-data" name="newevent" id="newevent" action="createnewevent">
						<!-- action="createnewevent" -->
						<fieldset>

							<!-- 0th row of form -->

							<div class="row">
								<!-- 1st column of 1st row -->
								<div class="col-lg-3" align="left" >
									<b>Name:</b>
								</div>
								<div class="col-lg-5"></div>
								<div class="col-lg-4" align="center">
									<input type="text" class="form-control" name="eventtitle"
										placeholder="ex: Birthday Party" id="eventtitle" required>
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
										placeholder="Add more info" id="eventdescription" required></textarea>
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
										placeholder="Add a place?" id="eventplace" required>
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
										placeholder="YYYY-MM-DD" id="eventdate" required>
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

								<div class="col-lg-3" align="left">
									<input type="submit" class="btn btn-primary" name="eventbutton"
										value="create" >
										<!-- onclick="eventsubmit(this.form)" -->
								</div>

								<div class="col-lg-3" align="center">
									<a href="#" class="btn btn-default">Cancel</a>
								</div>

							</div>
						</fieldset>
					</form>

				</div>
			</div>
		</div>
	</div> 

</body>
</html>