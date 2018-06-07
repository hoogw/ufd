<cfif #cgi.http_referer# is ""  and not isdefined("url.nla")>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>::: Maintenance Hole Cover Opening Permit :::</title>
<link href="/styles/eng.css" rel="stylesheet" type="text/css" src="/styles/eng.css">
</head>
<body ONLOAD="if (self !=top) top.location = self.location" bgcolor="White">


<font color="red">
<center>
<b>
Either you did not Login or your session has expired, You need to Login</a>
</B>
</center>

</body>
</html>
<cfabort>
</cfif>