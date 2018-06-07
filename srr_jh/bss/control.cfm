<cfif isdefined("request.srrKey")>
<cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.a_ref_no
, dbo.srr_status.srr_status_desc
, srr_info.app_id
, srr_info.job_address
, srr_info.srr_status_cd

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srr_id = #validateSRR.srr_id#>
<cfset request.sr_number = #validateSRR.sr_number#>
<cfset request.a_ref_no = #validateSRR.a_ref_no#>
<cfset request.app_id = #validateSRR.app_id#>
<cfset request.job_address = #validateSRR.job_address#>
<cfset request.status_cd = #validateSRR.srr_status_cd#>
<cfset request.status_desc = #validateSRR.srr_status_desc#>
<cfelse>
<cfset request.srr_id = "">
<cfset request.sr_number = "">
<cfset request.a_ref_no = "">
<cfset request.app_id = "">
<cfset request.job_address = "">
<cfset request.status_cd = "">
<cfset request.status_desc = "">
</cfif>


<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (BSS)">

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

<cfcase value = "tr_view_unprocessed">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="tr_view_unprocessed.cfm">
</cfcase>

<cfcase value = "tp_view_unprocessed">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="tp_view_unprocessed.cfm">
</cfcase>

<cfcase value = "dsp_app">
<cfset request.navbar="navbar1.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/dsp_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "print_app">
<cfset request.navbar="navbar1.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?srr_id=#request.srr_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "rebate_estimate">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/itemized_rebate_estimate.cfm">
</cfcase>


<cfcase value = "process_app1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app1.cfm">
</cfcase>

<cfcase value = "process_app2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app2.cfm">
</cfcase>


<cfcase value = "bss_adjustments1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="bss_adjustments1.cfm">
</cfcase>

<cfcase value = "bss_adjustments2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="bss_adjustments2.cfm">
</cfcase>


<cfcase value = "process_tr_app1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_tr_app1.cfm">
</cfcase>


<cfcase value = "process_tr_app2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_tr_app2.cfm">
</cfcase>

<cfcase value = "process_tp_app1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_tp_app1.cfm">
</cfcase>


<cfcase value = "process_tp_app2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_tp_app2.cfm">
</cfcase>

<cfcase value = "reports">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/reports.cfm">
</cfcase>

<cfcase value = "srr_balance_sheet">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/srr_balance_sheet.cfm">
</cfcase>


<cfcase value = "attachments">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/attachments.cfm">
</cfcase>

<cfcase value = "add_attachment">
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


<cfcase value = "print_not_eligible_letter_pdf">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/print_not_eligible_letter_pdf.cfm">
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
<cfif isnumeric(#request.srr_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif>
<cfmodule template="#request.content#" srr_id="#request.srr_id#">
<cfinclude template="../common/footer.cfm">
</cfoutput>
