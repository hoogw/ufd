<!doctype html>

<html>
<head>
	<title>Test</title>
</head>

<body>

<cfset request.sr_no = "1-382648434">

<cfmodule template="insertIntoSRP_module.cfm" sr_no="#request.sr_no#">

<cfoutput>#request.srp_insert_success#<br></cfoutput>
<cfoutput>#request.srp_insert_error_message#</cfoutput>

</body>
</html>
