<cfset request.drive_letter = "#left(CF_TEMPLATE_PATH, 3)#">

<cfset request.dsn="accessprogram">
<cfset request.from_email="Eng.LAPermits@lacity.org">

<cfset request.waitTime = "6">
<cfset request.upload_dir="#request.drive_letter#"&"docs"&"\"&"accessprogram"&"\"&"uploads">

<cfset request.upload_location="/docs/accessprogram">


<cfset request.production = "t">
<cfset request.proxy = "y"><!--- set to "n" if production, set to y if running on ".169" or localhost at work.  set to "n" if running at home --->


<!--- switch to t on test/development server --->
<cfif #request.production# is 0>
<cfset request.serverRoot = "http://localhost">
<cfset request.myLA311Root = "https://myla311test.lacity.org">
<cfelseif #request.production# is "t">
<cfset request.serverRoot = "http://10.78.5.169">
<cfset request.myLA311Root = "https://myla311test.lacity.org">
<cfelseif #request.production# is "p">
<cfset request.serverRoot = "https://engpermits.lacity.org">
<!--- <cfset request.myLA311Root = "https://myla311test.lacity.org"> --->
<cfset request.myLA311Root = "https://myla311.lacity.org">
</cfif>
<!-- end of production server settings -->

<cfset request.max_rows=100>

<!--- <CFERROR TYPE="REQUEST" TEMPLATE="/accessprogram/common/request_error.CFM" MAILTO="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">
<CFERROR TYPE="VALIDATION" TEMPLATE="/accessprogram/common/validation_error.cfm" MAILTO="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">
<cferror type="EXCEPTION" template="/accessprogram/common/request_error.cfm" mailto="Essam.Amarragy@lacity.org,Jimmy.Lam@lacity.org">

<CFERROR TYPE="REQUEST" TEMPLATE="/accessprogram/common/request_error.CFM" MAILTO="maria.diaz@lacity.org">
<CFERROR TYPE="VALIDATION" TEMPLATE="/accessprogram/common/validation_error.cfm" MAILTO="maria.diaz@lacity.org">
<cferror type="EXCEPTION" template="/accessprogram/common/request_error.cfm" mailto="maria.diaz@lacity.org">
 --->
 
<cfinclude template="/common/formURL2Request.cfm">
<cfset request.dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>


