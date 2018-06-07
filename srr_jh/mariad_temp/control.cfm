<cfinclude template="../common/myCFfunctions.cfm">

<cfif isdefined("request.arKey")>
<cfquery name="validateAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.AR_info.AR_id
, dbo.AR_info.arKey
, dbo.AR_info.sr_number
, dbo.AR_status.AR_status_desc
, AR_info.job_address
, AR_info.AR_status_cd

FROM  dbo.AR_info LEFT OUTER JOIN
               dbo.AR_status ON dbo.AR_info.AR_status_cd = dbo.AR_status.AR_status_cd

where 
AR_info.arKey = '#request.arKey#'
</cfquery>

<cfset request.AR_id = #validateAR.AR_id#>
<cfset request.sr_number = #validateAR.sr_number#>
<cfset request.job_address = #validateAR.job_address#>
<cfset request.status_cd = #validateAR.AR_status_cd#>
<cfset request.status_desc = #validateAR.AR_status_desc#>

<cfelse>

<cfset request.AR_id = "">
<cfset request.sr_number = "">
<cfset request.job_address = "">
<cfset request.status_cd = "">
<cfset request.status_desc = "">

</cfif>



<cfmodule template="../common/header.cfm" title="Sidewalk Access Request (BOE)">

<cfif not isdefined("request.action")>
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="Invalid Request!">
<cfabort>
</cfif>

<!---<Cfset client.action=#request.action#>--->

<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>

<cfcase value = "unprocessed_investigations">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="unprocessed_investigations.cfm">
</cfcase>

<cfcase value = "unprocessed_appeals">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="unprocessed_appeals.cfm">
</cfcase>


<cfcase value = "dsp_app">
<cfset request.navbar="navbar1.cfm"><!--- ?AR_id=#request.AR_id#&#request.addtoken# --->
<Cfset request.content="../common/dsp_app.cfm"><!--- ?AR_id=#request.AR_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "print_app">
<cfset request.navbar="navbar1.cfm"><!--- ?AR_id=#request.AR_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?AR_id=#request.AR_id#&#request.addtoken# --->
</cfcase>


<cfcase value = "process_app1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app1.cfm">
</cfcase>

<cfcase value = "process_app2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app2.cfm">
</cfcase>

<cfcase value = "process_appeal1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_appeal1.cfm">
</cfcase>

<cfcase value = "process_appeal2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_appeal2.cfm">
</cfcase>

<cfcase value = "rebate_estimate">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/itemized_rebate_estimate.cfm">
</cfcase>


<cfcase value = "reports">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/reports.cfm">
</cfcase>


<!---Report SubSections--->
<cfcase value = "SumRpt_GrpByStatus">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_groupbystatus1.cfm">
</cfcase>

<cfcase value = "SumRpt_GrpbyCD">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_groupbystatus1.cfm">
</cfcase>

<!--- <cfcase value = "Rpt_Count_Submittals1"> --->
<cfcase value = "download_receivedar1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_Submittals1.cfm">
</cfcase>

<cfcase value = "downloadAll1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_Submittals1.cfm">
</cfcase>

<!----Currently Rpt_Count_Submittals Not being used. Replaced by Print_Submittals (01/03/2018)--->
<cfcase value = "Rpt_Count_Submittals2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Submittals2.cfm">
</cfcase>

<!---  changing "print_submittal" to "download_receivedAR" and adding
 Request.Action= "downloadall" --->
<cfcase value = "download_receivedar2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Submittals2_print.cfm">
</cfcase>

<cfcase value = "downloadAll2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_CountAll_Submittals2_print.cfm">
</cfcase>

<!----End---->


<cfcase value = "Rpt_Count_Approved_DOD1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_AppApproved_Dod1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Approved_DOD2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_AppApproved_Dod2.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Approved_BSS1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Approved_BSS1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Approved_BSS2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Approved_BSS2.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Summary1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Summary1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Summary2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Summary2.cfm">
</cfcase>

<cfcase value = "Rpt_Search_Status1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Search_Status1.cfm">
</cfcase>

<cfcase value = "Rpt_Search_Status2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Search_Status2.cfm">
</cfcase>

<cfcase value = "Rpt_Count_BssPending1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_BssPending1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_BssPending2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_BssPending2.cfm">
</cfcase>

<cfcase value = "Rpt_Count_BoePending1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_BoePending1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_BoePending2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_BoePending2.cfm">
</cfcase>


<!---End of Rpt_Subsection--->

<cfcase value = "override">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="override.cfm">
</cfcase>

<cfcase value = "override_applicant1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="override_applicant1.cfm">
</cfcase>

<cfcase value = "override_applicant2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="override_applicant2.cfm">
</cfcase>


<cfcase value = "remove_contractor1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="remove_contractor1.cfm">
</cfcase>

<cfcase value = "remove_contractor2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="remove_contractor2.cfm">
</cfcase>

<cfcase value = "AR_balance_sheet">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/AR_balance_sheet.cfm">
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


<cfcase value = "print_not_eligible_letter_pdf">
<cfset request.navbar="navbar2.cfm">
<Cfset request.content="../common/print_not_eligible_letter_pdf.cfm">
</cfcase>


<cfcase value = "record_history">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/record_history.cfm">
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
<cfif isnumeric(#request.AR_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif>
<cfmodule template="#request.content#" AR_id="#request.AR_id#">
<cfinclude template="../common/footer.cfm">
</cfoutput>
