<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sj:head />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>About</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css" media="screen">
table {
	border: none;
	border-collapse: collapse;
}

td {
	border: none;
}

th {
	border: none;
}

p {
	background-color: #eeeff4;
}

p.padding {
	padding-top: 25px;
	padding-bottom: 25px;
	padding-right: 50px;
	padding-left: 40px;
	border-color: #eeeff4;
}

button.padding {
	float: right;
}

p.padding {
	padding-top: 25px;
	padding-bottom: 25px;
	padding-right: 50px;
	padding-left: 40px;
	border-color: #eeeff4;
}

b.r {
	font-size: 25px;
	padding-right: 800px;
}

div.box1 {
	padding-top: 30px;
	padding-left: 40px;
}

td.a {
	color: blue;
	font-size: 14px;
}

td.b {
	color: grey;
	padding-left: 0px;
	text-align: left;
	font-size: 12px;
}

b.a {
	color: #3b5999;
	font-size: 16px;
}

b.b {
	color: grey;
	padding-left: 0px;
	text-align: left;
	font-size: 14px;
}

b.c {
	color: black;
	padding-left: 0px;
	text-align: left;
	font-size: 12px;
}

td.c {
	color: black;
	padding-left: 0px;
	text-align: left;
	font-size: 12px;
}

th.p {
	padding-bottom: 12px;
	font-size: 20px;
}

td.n {
	padding-left: 4px;
	text-align: left;
}

img.loc {
	height: 80px;
	width: 80px;
}

img.wne {
	height: 40px;
	width: 40px;
}

b.q {
	font-size: 25px;
	padding-right: 800px;
}

label.labelcolor {
	color: grey;
}

div.padding {
	padding-top: 30px;
	padding-bottom: 35px;
	padding-right: 50px;
	padding-left: 40px;
	border-color: #eeeff4;
	border-style: solid;
	background-color: #eeeff4;
	border-width: 3px
}

b.new {
	font-size: 16px;
	color: grey;
}

table.tablenew {
	padding-top: 0px;
}
</style>
</head>
<body>
	
	<div class="row" style="background-color: #f7f7f7">
		<div class="col-md-1" align="left"></div>
		<div class="col-md-10" align="left" style="background-color: white">
			


			<div class="col-md-6" align="left" style="background-color: #FFFFFF">
				<br /> <br />
		  <div class="alert alert-warning">
    
    			<table cellspacing="2" cellpadding="5" border="0" bordercolor="white">
						<tr>
							<th class="p" colspan="2">Work/Organization </th>
						</tr>
						<%int count=0; %>
						<s:iterator value="organ" var="org" status="status">
						<%count++; %>
							<tr>
								<td width="70px"><img src="jsp/profile/job.png" class="wne"></img></td>
								<td><b class="a"><s:property value="#org.organizationname" /></b><br />
									<b class="a"><button type="submit" onclick="submitabout(this.form)" class="btn btn-small btn-primary">
							delete <span class="fa fa-arrow-right"></span>
						</button></b>
									<b class="b"><s:property value="#org.designation" /></b><br>
									<b class="b"><s:property value="#org.workingfrom" /></b>&nbsp;to
									<b class="g"><s:property value="#org.workingto"  /></b></td>
										
									
							</tr>
							
						<div id="organizationcenter<%=count%>"></div>
						</s:iterator>
				</table> 
					
		   </div>
					<br><br>
				<div id="workinformation" class="workform-group">
					<form id="workinfo">
						<input type="hidden" id="userid" class="form-control" value="${userid}"name="organizationname" placeholder="Enter your Organization Name">
						<input type="text" id="test" class="form-control" name="organizationname" placeholder="Enter your Organization Name"> <br />
					    <input type="text" class="form-control" name="designation" placeholder="Add Your designation">
					     <br /> 
					
						 <br /> 
						<label class="labelcolor">Last working Date</label>
						<br />
						<div class="row">
								<!-- 1st column of 3rd row -->
								<div class="col-lg-5" >
									<b>Starting date</b>
								</div>		
						</div>
						<div class="row">
						
								
								<div class="col-lg-4">
									<input type="date" class="form-control" name="workingfrom"  placeholder="YYYY-MM-DD" id="dob">
								</div>
						</div>
						<div class="row">
								<!-- 1st column of 3rd row -->
								<div class="col-lg-5" >
									<b>last date</b>
								</div>		
						</div>
						<div class="row">
						
								
								<div class="col-lg-4">
									<input type="date" class="form-control" name="workingto"  placeholder="YYYY-MM-DD" id="dob">
								</div>
						</div>
						
						<br /> <br />
						<button type="submit" onclick="submitabout(this.form)" class="btn btn-small btn-primary">
							Add <span class="fa fa-arrow-right"></span>
						</button>
					</form>
				</div>

				<br /> <br />
			
			<div class="alert alert-warning">
				<table cellspacing="2" cellpadding="5" border="0"
						bordercolor="white">
						<tr>
							<th class="p" colspan="2">Education </th>
						</tr>
						
						<s:iterator value="inst" var="ins" status="status">
							<tr>
								<td width="70px"><img src="jsp/profile/school.png" class="wne"></img></td>
								<td><b class="a"><s:property value="#ins.degree" /></b><br />
									<b class="b"><s:property value="#ins.institutename" /></b><br>
									<b class="b"><s:property value="#ins.studiedfrom" /></b>&nbsp;to
									<b class="g"><s:property value="#ins.studiedto"  /></b>
								</td>
									
							</tr>

						</s:iterator>
					</table> 
					</div>
					<br><br>
				<div id="collegeinformation" class="collegeform-group">
					<form id="collegeinfo" action="submitabout" method="post">
						<input type="text" class="form-control" name="institutename"
							placeholder="Add Your college here"> <br /> <input
							type="text" class="form-control" name="degree"
							placeholder="Add Your degree here"> <br /> <label
							class="labelcolor">College Joining Date</label> <br />
						<sj:datepicker id="3" name="studiedfrom"
							displayFormat="yy-mm-dd" />
						<br /> <br /> <label class="labelcolor">College Leaving
							Date</label> <br />
						<sj:datepicker id="4" name="studiedto"
							displayFormat="yy-mm-dd" />
						<br /> <br />
						<button type="submit" class="btn btn-small btn-primary">
							Add <span class="fa fa-arrow-right"></span>
						</button>
					</form>
					<br />
				</div>

				<br /> <br />

				

				<br /> <br />
				
				<table>
						<tr>
							<th class="p">Relationship</th>
						</tr>
						<tr class="b">
							<td><img src="jsp/profile/relationships.png" height="70px"
								width="70px" alt="test" align="middle">&nbsp&nbsp&nbsp&nbsp<b><s:property
										value="martialstatus" /></b></img></td>
						</tr>
					</table>
				<div id="relation" class="relationgroup">

					<h5>
						<form id="relationships" action="submitabout" method="post">
							<b class="new">Add You Relationship</b> &nbsp
							<s:select id="rel"
								list="#{'Single':'Single', 'Breakup':'Breakup', 'Married':'Married', 'Divorced':'Divorced', 'Engaged':'Engaged'}"
								name="martialstatus" value="%{martialstatus}" />
							<br /> <br />
							<button type="submit" class="btn btn-small btn-primary">
								Save <span class="fa fa-arrow-right"></span>
							</button>
						</form>
					</h5>
				</div>
			</div>
			<div class="col-md-1" align="left"></div>
			<div class="col-md-4" align="left">


				<br />
				<div class="alert alert-warning">
				<table>
						<tr>
							<th class="p">Places Lived</th>
						</tr>
						<tr>
							<td><img src="jsp/profile/location.jpeg" class="loc"></img></td>
							<td><b class="a"><s:property value="currentplace" /></b><br /> <b
								class="b">Current City</b></td>
						</tr>
						<tr>
							<td><img src="jsp/profile/location.jpeg" class="loc"></img></td>
							<td><b class="a"><s:property value="homeplace" /></b><br />
								<b class="b">Hometown</b></td>
						</tr>
					</table>
				</div>
				<div id="location" class="locationgroup">
					<form id="locations" action="submitabout" method="post">
						<label class="labelcolor">Home Town</label> <br />
						<s:textfield id="ht" name="homeplace" size="30"
							cssStyle="height:35px" value="%{homeplace}"></s:textfield>
						<br /> <br /> <label class="labelcolor">Current City</label> <br />
						<s:textfield id="cc" name="currentplace" size="30"
							cssStyle="height:35px" value="%{currentplace}"></s:textfield>

						<br /> <br />
						<button type="submit" class="btn btn-small btn-primary">
							Save <span class="fa fa-arrow-right"></span>
						</button>
					</form>
				</div>
				<br />
				<table>
					<tr>
						<th class="p">Basic Information</th>
					</tr>
				</table>
				<br />
				<div id="other" class="othergroup">
					<form id="others" action="submitabout" method="post">
						<b class="new">Birth Date</b> &nbsp;
						<sj:datepicker id="7" name="udob" displayFormat="yy-mm-dd"
							value="%{udob}" />

						<br /> <br />
						<h5>
							<b class="new">Gender</b>&nbsp &nbsp &nbsp &nbsp
							<s:select
								list="#{'Male':'Male', 'Female':'Female', 'Other':'Other'}"
								name="ugender" value="%{ugender}" id="gen" />
						</h5>
						<button type="submit" class="btn btn-small btn-primary">
							Save <span class="fa fa-arrow-right"></span>
						</button>
					</form>
				</div>

			</div>
		</div>


	</div>


</body>


</html>