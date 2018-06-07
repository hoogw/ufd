<!DOCTYPE html>
<html>
<head>
<title>Sidewalk Access Request - City of Los Angeles</title>
<style>

	* {
	margin:0;
	padding: 0;
	font-size: 100%;
	font-family: arial;
	}
	
	body {
	background: transparent;
	}
.warning {
padding:15px;
margin-left:auto;
margin-right:auto;
text-align:center;
margin-top:15px;
width:600px;
border: 1px solid maroon;
border-radius:7px;
color: maroon;
font-weight:bold;
background: linear-gradient(to right, #ffff80 , #ffffe6);
}

</style>
</head>


<body>
<cfoutput>

<div class="warning">
An Error was Encountered.  
<br><br>
An email was sent to the system administrator.
<br><br>
Please try at a later time.
</div>
</cfoutput>
</body>
</html>


<cfinclude template="email_error.cfm">

<cfabort>