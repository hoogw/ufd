<!doctype html>

<html>
<head>
	<title>Test</title>
</head>

<cfset request.myLA311Root = "https://myla311test.lacity.org">

<body>

<cfset request.srNum = "1-133489701">
<cfset request.srCode = "11"> <!--- If the value is numeric then it will update the Reason Code. Otherwise is will update the Resolution Code --->
<cfset request.srComment = "Here is a final test.">

<cfmodule template="updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#request.srComment#">

<cfoutput>Success: #request.srupdate_success#<br></cfoutput>
<cfoutput>Error Message: #request.srupdate_err_message#<br></cfoutput>

</body>
</html>
