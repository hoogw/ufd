<!-- reviewed on 10/29/2016 -->

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfset request.ref_no = #request.a_ref_no#>

<cfquery name="update_permit_info" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE permit_info
SET
ddate_submitted = #now()#
, application_status = 'received'
, record_history = record_history + '<br><br>A-permit submitted on(#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#) by Applicant under the Sidewalk Rebate Program.'

WHERE ref_no = #request.ref_no#
</cfquery>

<cfquery name="updateSrr" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE srr_info
SET
ApermitSubmitted_dt = #now()#
, record_history = record_history + '|A-permit submitted by applicant on (#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#).'

WHERE srrKey = '#request.srrKey#'
</cfquery>


<cfmodule template="../common/checkRequiredPermitsSubmitted_module.cfm" srrKey="#request.srrKey#">


<cfoutput>

<div class="warning">
Your A-Permit was Successfully Submitted
<br><br>
Your A-Permit Reference Number is:  #request.ref_no#
</div>


<div align="center"><input type="button" name="back" id="back" value="Back to Requirements" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'"></div>

</cfoutput>