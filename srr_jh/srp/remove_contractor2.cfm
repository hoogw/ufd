<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="updateContractor" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

[cont_license_no] = null
,[cont_name] = null
,[cont_address] = null
,[cont_city] = null
,[cont_state] = null
,[cont_zip] = null
,[cont_phone] = null
,[cont_lic_issue_dt] = null
,[cont_lic_exp_dt] = null
,[cont_lic_class] = null
,[cont_info_comp_dt] = null

, record_history = record_history + '|OVERRIDE: Contractor information was removed by #client.full_name# on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srrKey = '#request.srrKey#'
</cfquery>



<div class = "warning">Contractor Information is Removed</div>

<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "21"> <!--- Code 21, offerAccepted --->
<cfset request.srComment = "Contractor Information has been removed from your Sidewalk Repair Rebate Application.  Please resume completing your application by providing a Licensed Contractor Information.  The following is a link to your application:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfoutput>
<div class="warning">
The following message is sent to applicant through MyLA311:<br><br>
Contractor Information has been removed from your Sidewalk Repair Rebate Application.  Please resume completing your application by providing a Licensed Contractor Information.  The following is a link to your application:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
</div>
</cfoutput>
<cfcatch>
<div class="warning">Could not Send Message to Applicant</div>
</cfcatch>
</cftry>