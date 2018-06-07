<cfinclude template="../common/myCFfunctions.cfm">
<cfparam name="request.ar_id" default="">

<!--- <cfoutput>#request.arkey#</cfoutput> --->
<!--- <cfif isdefined("request.arKey")>
<cfquery name="validateAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
ar_info.ar_id
, ar_info.arKey
, ar_info.sr_number
, ar_info.job_address
, ar_status.ar_status_desc
, ar_info.ar_status_cd

FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd

where 
ar_info.arKey = '#request.arKey#'
</cfquery>

<cfset request.ar_id = #validateAR.ar_id#>
<cfset request.sr_number = #validateAR.sr_number#>
<cfset request.status_cd = #validateAR.ar_status_cd#>
<cfset request.status_desc = #validateAR.ar_status_desc#>
<cfelse>
<cfset request.ar_id = "">
<cfset request.sr_number = "">
<cfset request.status_cd = "">
<cfset request.status_desc = "">
</cfif>
 --->

<cfmodule template="../common/header.cfm" title="Sidewalk Access Request (LDG)">

<cfif not isdefined("request.action")>
<div class="warning">Invalid Request!</div>
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>

<cfcase value = "view_unprocessed">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="view_unprocessed.cfm">
</cfcase>

<cfcase value = "add_comment_form">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="add_comment_form.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "add_comment_action">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="add_comment_action.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "dsp_app">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="../common/dsp_app.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>


<cfcase value = "print_app">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>


<cfcase value = "process_app1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app1.cfm">
</cfcase>

<cfcase value = "process_app2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app2.cfm">
</cfcase>


<cfcase value = "reports">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/reports.cfm">
</cfcase>

<cfcase value = "attachments">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/attachments.cfm">
</cfcase>

<cfcase value = "uploadfile1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="uploadfile1.cfm">
</cfcase>

<cfcase value = "uploadfile2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="uploadfile2.cfm">
</cfcase>


<cfcase value = "search1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="search1.cfm">
</cfcase>

<cfcase value = "search2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="search2.cfm">
</cfcase>

<cfcase value = "record_history">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/record_history.cfm">
</cfcase>

<cfcase value="mark_completed1">
<cfset request.navbar="navbar1.cfm">
<cfset request.content="mark_completed1.cfm">

</cfcase>


<cfcase value = "authorize">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="authorize.cfm">
</cfcase>

<cfcase value = "log_out">
<cfset client.app_login = 0>
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>


</cfswitch>

<cfoutput>
<cfinclude template="#request.navbar#">
<!---<div class="title">Bureau of Street Services (BSS)</div>--->
<cfif isnumeric(#request.ar_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif>
<cfmodule template="#request.content#" ar_id="#request.ar_id#">
<cfinclude template="../common/footer.cfm">
</cfoutput>
