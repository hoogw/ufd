<cfif not isdefined("client.admin_login") or #cgi.http_referer# is "" or #client.staff_user_id# is "0" or #client.staff_user_id# is "">

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<meta name="description" content="Bureau of Engineering, City of Los Angeles, Excavation (U) Permits">
<meta name="keywords" content="Excavation Permit, U-Permit">
<meta name="author" content="Essam Amarragy">
<title>Sidewalk Access Request - City of Los Angeles</title>
<link href="/accessprogram/css/boe_main_2015.css" rel="stylesheet" type="text/css" src="/accessprogram/css/boe_main_2015.css">
</head>
<body onload="if (self !=top) top.location = self.location">


<font color="red">
<div align="center">
<b>
Either you did not Login or your session has expired, You need to Login
</b>
</div>

</body>
</html>
<cfabort>
</cfif>

