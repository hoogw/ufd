<cfif not isdefined("client.staff_user_id") or #cgi.http_referer# is "" or #client.staff_user_id# is "0" or #client.staff_user_id# is "">
<!DOCTYPE HTML>
<html>
<!-- Developed by: Essam Amarragy *** CITY OF LOS ANGELES *** 213-482-7122 *** Essam.Amarragy@lacity.org -->
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Access Program Request - City of Los Angeles</title>
<link rel="stylesheet" type="text/css" href="/accessprogram/css/boe_main_2016_v1.css">
</head>
<body ONLOAD="if (self !=top) top.location = self.location">


<font color="red">
<div align = "center">
<b>
Either you did not logon or your session has expired, You need to <a href="../dod.htm" target="_top">Logon</a>
</B>
</div>
</font>


</body>
</html>
<cfabort>
</cfif>

