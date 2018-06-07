<!--- <cfinclude template="security.cfm"> --->

<cfparam name="header_message" default="">
<cfparam name="request.date_from" default="">
<cfparam name="request.date_to" default="">
<cfparam name="request.navbar" default="navbar_srr_reports.cfm">

<cfset client.action=#request.action#>
<CFPARAM NAME="request.bmark" DEFAULT="">

<cfif isdefined("url.action")>
	<cfset request.action=#url.action#>
</cfif>

<cfparam name="request.ref_nbr" default="">
<!--- always check for request.pif_id         isnumeric --->

<cfmodule template="common/header.cfm" maintitle="Sidewalk Repair Rebate Program">


<cfif not isdefined("request.action")>
	<cfmodule template="common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>


<cfswitch expression = #request.action#>

<cfcase value = "dateentry">
<cfset request.navbar="navbar_srr_reports.cfm">
<Cfset request.content="dateentry.cfm">
</cfcase>

<cfcase value = "reports_bydaterange">
<cfset request.navbar="navbar_srr_reports.cfm">
<Cfset request.content="reports_bydaterange.cfm">

</cfcase>



</cfswitch>

<cfoutput>

<!--- #request.navbar#
#request.content#
<cfabort> --->
<cfif #request.action# is "pdfreport">
<cfelseif #request.action# is "pdfreporttest">
<cfelseif #request.action# is "pdf_fms_boareports_all">
<cfelseif #request.action# is "pdf_fms_boareports_all2">
<cfelseif #request.action# is "pdf_fms_boareports">
<cfelse>
	<cfinclude template="#request.navbar#">
</cfif>

<cfmodule template="#request.content#" ref_nbr="#request.ref_nbr#" token="#request.addtoken#" bmark="#request.bmark#">




</cfoutput>
<cfinclude template="common/footer.cfm">




