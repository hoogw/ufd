<!doctype html>

<html>
<head>
	<title>Test</title>
</head>

<body>

<cfset request.x = "6483532.59">
<cfset request.y = "1816256.36">

<cfmodule template="getDistricts_module.cfm" x="#request.x#" y="#request.y#">

<cfoutput>#request.get_districts_success#<br></cfoutput>
<cfoutput>#request.rslt_boe_district#<br></cfoutput>
<cfoutput>#request.rslt_bss_district#<br></cfoutput>
<cfoutput>#request.rslt_bss_name#<br></cfoutput>
<cfoutput>#request.rslt_bss_district_office#<br></cfoutput>
<cfoutput>#request.rslt_bca_district#<br></cfoutput>
<cfoutput>#request.rslt_bca_inspect_district#<br></cfoutput>

</body>
</html>
