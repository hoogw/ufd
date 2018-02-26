<!doctype html>

<html>
<head>
	<title>Test</title>
</head>

<body>

<cfset request.sr_no = "1-382648434">

<cfmodule template="retrieveSRPStatus_module.cfm" sr_no="#request.sr_no#">

<cfoutput>#request.srp_has_package#<br></cfoutput>
<cfoutput>#request.srp_has_ntp#<br></cfoutput>
<cfoutput>#request.srp_construction_started#<br></cfoutput>
<cfoutput>#request.srp_construction_completed#<br></cfoutput>
<cfoutput>#request.srp_package#<br></cfoutput>
<cfoutput>#request.srp_ntp_date#<br></cfoutput>
<cfoutput>#request.srp_construction_start_date#<br></cfoutput>
<cfoutput>#request.srp_construction_completed_date#<br></cfoutput>
<cfoutput>#request.srp_status#<br></cfoutput>
<cfoutput>#request.srp_retrieval_success#<br></cfoutput>
<cfoutput>#request.srp_retrieval_error_message#</cfoutput>

</body>
</html>
