<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfset clientList = GetClientVariablesList()>		
<cfloop list="#clientList#" index="li">
	<CFSET IsDeleteSuccessful=DeleteClientVariable("#li#")>
</cfloop>

<html>
<head>
	<title>Untitled</title>
</head>

<body>



</body>
</html>
