
<cfinclude template="../common/myCFfunctions.cfm">

<cfif isdefined("request.arKey")>
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
<cfif isnumeric(right(#validateAR.job_address#, 5))>
<cfset request.job_address= left(#validateAR.job_address#, len(#validateAR.job_address#) - 8)>
<cfelse>
<cfset request.job_address = #validateAR.job_address#>
</cfif>

<cfelse>
<cfset request.ar_id = "">
<cfset request.sr_number = "">
<cfset request.status_cd = "">
<cfset request.status_desc = "">
<cfset request.job_address = "">
</cfif>


<cfmodule template="../common/header.cfm" title="Sidewalk Access Request (BSS)">










<cfswitch expression = #request.action#>

<cfcase value = "home">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="instructions1.cfm">
</cfcase>

<cfcase value = "view_unprocessed">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="view_unprocessed.cfm">
</cfcase>

<cfcase value = "sidewalks1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="sidewalks1.cfm">
</cfcase>

<cfcase value = "spd_estimate_action">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="spd_estimate_action.cfm">
</cfcase>

<cfcase value = "trees1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="trees1.cfm">
</cfcase>

<cfcase value = "ufd_estimate_action">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="ufd_estimate_action.cfm">
</cfcase>


<cfcase value = "process_app_form">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app_form.cfm">
</cfcase>

<cfcase value = "process_app_action">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="process_app_action.cfm">
</cfcase>

<cfcase value = "bss_comments">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="bss_comments.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>

<cfcase value = "bss_comments2">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="bss_comments2.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>



<cfcase value = "reports">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/reports.cfm">
</cfcase>



<!---Report SubSections--->
<cfcase value = "Rpt_Count_Submittals1">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/Rpt_Count_Submittals1.cfm">
</cfcase>

<cfcase value = "Rpt_Count_Submittals2">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="../common/rpt_Count_Submittals2.cfm">
</cfcase>

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

<!---End of Rpt_Subsection--->



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



<cfcase value = "authorize">
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="authorize.cfm">
</cfcase>

<cfcase value = "log_out">
<cfset client.app_login = 0>
<cfset request.navbar="navbar1.cfm">
<Cfset request.content="log_out.cfm">
</cfcase>

<cfcase value = "print_app">
<cfset request.navbar="navbar1.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
<Cfset request.content="../common/print_app.cfm"><!--- ?ar_id=#request.ar_id#&#request.addtoken# --->
</cfcase>





</cfswitch>




<cfoutput>
<cfinclude template="#request.navbar#">
<cfif isnumeric(#request.AR_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif>

<cfif isnumeric(#request.AR_id#) and #request.status_cd# is "pendingBSSReview">
<!--- do nothing --->
<cfelseif isnumeric(#request.AR_id#) and #request.status_cd# is not "pendingBSSReview">
<div class="warning" style="width:700px;">This application is not currently in your queue.<br><br>No Action is Required at This Time.</div>
</cfif>
<!---<div class="title">Bureau of Street Services (BSS)</div>--->
<!--- <cfif isnumeric(#request.ar_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif> --->
<cfmodule template="#request.content#" ar_id="#request.ar_id#">
<!--- <cfinclude template="../common/footer.cfm"> --->
</cfoutput>


<!--- <cfoutput>
<cfinclude template="#request.navbar#">
<!---<div class="title">Bureau of Street Services (BSS)</div>--->
<cfif isnumeric(#request.ar_id#)>
<cfinclude template="../common/include_sr_job_address.cfm">
</cfif>
<cfmodule template="#request.content#" ar_id="#request.ar_id#">

<cfinclude template="../common/footer.cfm">
</cfoutput> --->