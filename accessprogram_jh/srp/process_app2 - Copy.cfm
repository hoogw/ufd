<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">
<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>



<!--- New stuff --->
<cfif #request.rejected_reason_code# is not "">
<cfquery name="find_rejected_desc" datasource="#request.dsn#" dbtype="datasource">
select 
rejected_reason_id
,rejected_reason_code
,rejected_reason_desc
,rejected_reason_lang
from denial_reason
where rejected_reason_code = '#request.rejected_reason_code#'

</cfquery>

<cfset request.reason_denial_id = #find_rejected_desc.rejected_reason_id#>
<cfset request.reason_desc = #find_rejected_desc.rejected_reason_desc#>
<cfset request.reason_message = #find_rejected_desc.rejected_reason_lang#>

</cfif>




<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[ar_info]
SET

boe_invest_comments = ISNULL(boe_invest_comments, '') + '|#toSqlText(request.boe_invest_comments)#'
, boe_invest_response_to_app = '#toSqlText(request.boe_invest_response_to_app)#'
, ar_status_cd = '#request.ar_status_cd#'

<cfif #request.ar_status_cd# is "received">
, boe_invest_to_dod_dt = #now()#
, boe_invest_to_dod_by = #client.staff_user_id#
, record_history = record_history + '|BOE/SRP returned application to Dept. on Disability on #dnow# by #client.full_name#.'
<cfelseif #request.ar_status_cd# is "PendingBssReview">
, boe_invest_to_bss_dt = #now()#
, boe_invest_to_bss_by = #client.staff_user_id#
, record_history = record_history + '|BOE/SRP returned application to BSS on #dnow# by #client.full_name#.'
<cfelseif #request.ar_status_cd# is "notEligible">
, boe_notEligible_dt = #now()#
, boe_notEligible_by = #client.staff_user_id#
, record_history = record_history + '|BOE/SRP determined that application is not Eligible for the Access Program on #dnow# by #client.full_name#.'


<cfelseif #request.ar_status_cd# is "BSSAssessmentCompleted">
, bss_assessed_dt = #now()#
, bss_assessed_by = #client.staff_user_id#
, record_history = record_history + '|Application marked as BSS Assessment completed on #dnow# by #client.full_name# of BOE staff.'


</cfif>


<cfif #request.rejected_reason_code# is not "">
<!--- , dod_to_bss_dt = null
, dod_denied_dt = #now()#
, dod_denied_by = #client.staff_user_id# --->
, record_history = isnull(record_history, '') + '|Application was rejected (#request.reason_desc#).  Processed by: #client.full_name# on #dnow#.' <!--- add reason Blue Curb request rejected --->
<!--- , ar_status_cd = 'notEligible' --->
, rejected_reason_id = #request.reason_denial_id#
</cfif>



where arKey =  '#request.arKey#'
</cfquery>


<!--- <cfif #request.ar_status_cd# is "notEligibleTemp">
<cfset request.notEligible_exp_dt = dateAdd("d", 14, #now()#)>

<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"><!--- code 13 for notEligible --->
<cfset request.srComment = "We regret to inform you that your application has been deemed ineligible for the Sidewalk Rebate Program. The specific reason(s) that the application was ineligible are provided in the following link: 
<br><br>
#request.serverRoot#/srr/public/whyNotEligible.cfm?arKey=#request.arKey#
<br><br>
To appeal this decision, use the following link to submit an appeal no later than #dateformat(request.notEligible_exp_dt,'mm/dd/yyyy')#
<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?arKey=#request.arKey#
<br><br>
Rebate FAQ:
<br>
http://sidewalks.lacity.org/rebate-program-faqs
<br>
Rebate Program Rules and Regulations:
<br>
http://sidewalks.lacity.org/rebate-program-rules-and-regulations
"> --->

<!--- <cftry>
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry> --->


<!--- </cfif> --->


 <cfif #request.ar_status_cd# is "BSSAssessmentCompleted">
<cfmodule template="../modules/insertIntoSRP_module.cfm" sr_no="#request.sr_number#">

<!--- <div align="center">
<cfoutput>#request.srp_insert_success#<br></cfoutput>
<cfoutput>#request.srp_insert_error_message#</cfoutput>
</div> --->



</cfif>

<cfoutput>
<div class="warning">Application Updated</div>
</cfoutput>
