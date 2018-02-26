<!doctype html>

<html>
<head>
	<title>Test</title>
</head>

<cfset request.myLA311Root = "https://myla311test.lacity.org">
<cfset request.production = "t">

<body>

<cfset request.srNum = "1-380417651">

<cfmodule template="insertSRTicket_module.cfm" srNum="#request.srNum#">

<cfoutput>#request.srticket_success#<br></cfoutput>
<cfoutput>#request.srticket_err_message#<br></cfoutput>
<cfoutput>#request.srticket_srnum#<br></cfoutput>

</body>
</html>
