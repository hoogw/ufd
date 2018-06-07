<cfif #cgi.http_referer# is ""  and not isdefined("url.nla") and not isdefined("url.permit_no")>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<meta name="description" content="Bureau of Engineering, City of Los Angeles, Excavation (U) Permits">
<meta name="keywords" content="Excavation Permit, U-Permit">
<meta name="author" content="Essam Amarragy">
<title>(SRR) Sidewalk Repair Rebate Program - City of Los Angeles</title>
<link href="/styles/boe_main_gray.css" rel="stylesheet" type="text/css" src="/styles/boe_main_gray.css">
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

