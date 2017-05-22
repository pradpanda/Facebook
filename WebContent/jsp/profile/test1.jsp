<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>About</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css" media="screen">
img.loc {
	height: 80px;
	width: 80px;
}

img.wne {
	height: 40px;
	width: 40px;
}
</style>
</head>
<%@include file="/jsp/ajaxscripts.jsp" %>
<body>
	
	<div class="container">
	
		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-lg-4">
			<div class="alert alert-warning">
				<div class="row">
			
					<div class="col-lg-12">
						
						<table>
						<tr>
						<th class="p">Basic Information</th>
						</tr>
						</table>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div id="a" class="col-lg-12">		
				
				<b class="new">Birth Date</b> &nbsp
						
						<div class="row">
						
								
								<div class="col-lg-8">
									<input type="date"  class="form-control" name="udob"  value="${udob}" placeholder="YYYY-MM-DD" id="udob">
								</div>
						</div>
						
						<br /> <br />
						<h5>
							<b class="new">Gender</b>&nbsp &nbsp &nbsp &nbsp
							<s:select
								list="#{'Male':'Male', 'Female':'Female', 'Other':'Other'}"
								name="ugender" value="%{ugender}" id="ugender" />
						</h5>
						<button type="submit"  onclick="addbasic()" class="btn btn-small btn-primary">
							Save <span class="fa fa-arrow-right"></span>
						</button>
				</div>
			</div>
		</div>
	
		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-lg-4">
			<div class="row">
			<div class="col-lg-12">
					<div class="alert alert-warning">
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
					</div>
			</div>
		</div>
			<div class="row">
			<div class="col-lg-12">
					
					<b class="new">Add You Relationship</b> &nbsp
							<s:select id="martialstatus"
								list="#{'Single':'Single', 'Breakup':'Breakup', 'Married':'Married', 'Divorced':'Divorced', 'Engaged':'Engaged'}"
								name="martialstatus" value="%{martialstatus}" />
							<br /> <br />
							<button type="submit" onclick="addmartialstatus()" class="btn btn-small btn-primary">
								Save <span class="fa fa-arrow-right"></span>
							</button>
			</div>
			</div>
		</div>
		</div>
		</div>
			
		<br><br>
		<div class="row" >
			<div class="col-lg-1" ></div>
			<div class="col-lg-4">
			
				<div class="row">
					<div class="col-lg-12">

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
					</div>
			</div>	
			<div class="row">
			<div class="col-lg-12">
				<label class="labelcolor">Home Town</label> <br />
						<s:textfield  name="homeplace" size="30"
							cssStyle="height:35px" id="homeplace" class="form-control" value="%{homeplace}"></s:textfield>
						<br /> <br /> <label class="labelcolor">Current City</label> <br />
						<s:textfield id="currentplace" class="form-control" name="currentplace" size="30"
							cssStyle="height:35px" value="%{currentplace}"></s:textfield>

						<br /> <br />
						<button type="submit" onclick="addlocation()" class="btn btn-small btn-primary">
							Save <span class="fa fa-arrow-right"></span>
						</button>
			</div>
			</div>
		</div>
		
		
		
		
		<div class="col-lg-1" ></div>
		<div class="col-lg-4"  style="background-color: white">
		
			
		<div class="row">
			<div class="col-lg-12">
			
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
											<b class="b"><s:property value="#org.designation" /></b><br>
											<b class="b"><s:property value="#org.workingfrom" /></b>&nbsp;to
											<b class="g"><s:property value="#org.workingto"  /></b></td>
												
											
									</tr>
									
								<div id="organizationcenter<%=count%>"></div>
								</s:iterator>
						</table> 
							
				   </div>
				</div>
			
		   </div>
		   <div class="row">
		   	<div class="col-lg-12">
	 		<input type="text" id="orgname" class="form-control" name="organizationname" placeholder="Enter your Organization Name"> <br />
					    <input id="designation" class="form-control" name="designation" placeholder="Add Your designation">
					     <br /> 
					
						 <br /> 
						
						<br />
						<div class="row">
								<!-- 1st column of 3rd row -->
								<div class="col-lg-8" >
									<b>Starting date</b>
								</div>		
						</div>
						<div class="row">
						
								
								<div class="col-lg-8">
									<input type="date" id="workingfrom" class="form-control" name="workingfrom"  placeholder="YYYY-MM-DD" >
								</div>
						</div>
						<div class="row">
								<!-- 1st column of 3rd row -->
								<div class="col-lg-5" >
									<b>last date</b>
								</div>		
						</div>
						<br>
						<div class="row">
						
								
								<div class="col-lg-8">
									<input type="date" id="workingto" class="form-control" name="workingto"  placeholder="YYYY-MM-DD" id="dob">
								</div>
						</div>
						
						<br /> <br />
						<button type="submit" onclick="addorg()" class="btn btn-small btn-primary">
							Add <span class="fa fa-arrow-right"></span>
						</button>
				</div>
			</div>
		</div>
		</div>
		<div class="row">
		<div class="col-lg-1"></div>
		<div class="col-lg-4">
						<br><br>
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
					<input type="text" class="form-control" id="institutename" name="institutename"
							placeholder="Add Your college here"> <br /> 
					<input
							type="text" class="form-control" id="degree" name="degree"
							placeholder="Add Your degree here"> <br /> <label
							class="labelcolor">College Joining Date</label> <br />
						
							<div class="col-lg-8">
									<input type="date" id="studiedfrom" class="form-control" name="studiedto"  placeholder="YYYY-MM-DD" >
								</div>
						<br /> <br /> <label class="labelcolor">College Leaving
							Date</label> <br />
							<div class="col-lg-8">
									<input type="date" id="studiedto" class="form-control" name="studiedto"  placeholder="YYYY-MM-DD" >
								</div>
						
						
						<br /> <br /><br/>
						
						
						<button type="submit" onclick="addinstitute()"  class="btn btn-small btn-primary">
							Add <span class="fa fa-arrow-right"></span>
						</button>
						
						<br><br>
			</div>
		</div>	
	</div>
	
</body>
<script>

</script>
</html>