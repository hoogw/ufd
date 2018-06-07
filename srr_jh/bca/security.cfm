<cfif not isdefined("client.staff_user_id")  or #client.staff_user_id# is "0" or #client.staff_user_id# is "" or #cgi.http_referer# is "" >
<!DOCTYPE HTML>
<html>
<!-- Developed by: Essam Amarragy *** CITY OF LOS ANGELES *** 213-482-7122 *** Essam.Amarragy@lacity.org -->
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>(SRR) Sidewalk Repair Rebate Program - City of Los Angeles</title>
<link rel="stylesheet" type="text/css" href="css/phone_2016.css">
</head>
<body ONLOAD="if (self !=top) top.location = self.location">

<br><br>
<div class="warning">
Either you did not logon or your session has expired, You need to <a href="../bca.htm" target="_top">Logon</a>
</div>

</body>
</html>
<cfabort>
</cfif>

