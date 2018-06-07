<cfparam name="request.srr_id" default="">

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Mapping)">

<cfif not isdefined("request.action")>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>

<cfcase value = "record_history">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/record_history.cfm">
</cfcase>

<cfcase value = "view_unprocessed">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="view_unprocessed.cfm">
</cfcase>

<cfcase value = "dsp_app">
<cfset request.navbar="navbar_mapping.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/dsp_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "print_app">
<cfset request.navbar="navbar_mapping.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>


<cfcase value = "process_app1">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="process_app1.cfm">
</cfcase>

<cfcase value = "attachments">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="../common/attachments.cfm">
</cfcase>

<cfcase value = "process_app2">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="process_app2.cfm">
</cfcase>


<cfcase value = "search1">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="search1.cfm">
</cfcase>

<cfcase value = "search2">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="search2.cfm">
</cfcase>


<cfcase value = "print_not_eligible_letter_pdf">
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="../common/print_not_eligible_letter_pdf.cfm">
</cfcase>


<cfcase value = "log_out">
<cfset client.app_login = 0>
<cfset request.navbar="navbar_mapping.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>

<cfcase value="mark_completed1">
<cfset request.navbar="navbar_mapping.cfm">
<cfset request.content="mark_completed1.cfm">

</cfcase>




</cfswitch>

<cfoutput>


<cfinclude template="#request.navbar#">
<!---<div class="title">Land Development and GIS (LDG)</div>--->
<cfif isnumeric(#request.srr_id#)>
<div class="subtitle">Program Interest Form Reference No. #request.srr_id#</div>
<cfinclude template="/srr/common/get_srr_status.cfm">
<div class="warning">Status: #request.srr_status#</div>
</cfif>

<cfmodule template="#request.content#" srr_id="#request.srr_id#">
<cfinclude template="../common/footer.cfm">
</cfoutput>