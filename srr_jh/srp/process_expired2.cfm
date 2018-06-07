<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfif not isdefined("request.ext_grantedDays") or #request.ext_grantedDays# is 0>
<div class="warning">Invalid Number of Days for Extension</div>
<cfabort>
</cfif>

<cfset request.exp_dt = dateAdd("d", #request.ext_grantedDays#, #now()#)>

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>



<cfquery name="findSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.sr_number
, srr_info.app_name_nn

, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.job_address

, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_status.agency
, srr_status.srr_list_order
, srr_status.suspend
, srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments
, srr_info.bpw1_internal_comments
, srr_info.bpw1_comments_to_app
, srr_info.ext_grantedDays
, srr_info.ext_granted_dt
, srr_info.ext_granted_by

, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd
, boe_invest_comments
, boe_invest_response_to_app
, srr_info.bpw1_internal_comments
, srr_info.bpw2_internal_comments
, srr_info.bca_comments
, srr_info.bss_comments

<!--- 14 days to submit requested documents ---><!--- set back to from, incompeteDocs to incompleteDocsTemp and change incompleteDocs_exp_dt --->
, srr_info.incompleteDocs_dt 
, srr_info.incompleteDocs_exp_dt


<!--- 14 days to accept offer ---><!--- set back from offerExpired to offerMade and change offerMade_exp_dt --->
, srr_info.offerMade_dt
, srr_info.offerMade_exp_dt


<!--- those are not used now --->
, srr_info.offerDeclined_dt
, srr_info.offerDeclined_exp_dt

<!--- govern 60 days to submit required permits ---><!--- set back from requiredPermitsNotSubmitted to offerAccepted and change offerAccepted_exp_dt --->
, srr_info.offerAccepted_dt
, srr_info.offerAccepted_exp_dt

<!--- govern 90 days construction --->
, srr_info.requiredPermitsIssued_dt
, srr_info.requiredPermitsIssued_exp_dt

, srr_info.requiredPermitsNotSubmitted_dt
, srr_info.requiredPermitsNotSubmitted_exp_dt

, srr_info.paymentIncompleteDocs_dt
, srr_info.paymentIncompleteDocs_exp_dt

, srr_info.prop_type

, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

</cfquery>

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<cfif #findSRR.prop_type# is "r">
<cfset request.offer_reserved_amt = #findSRR.res_cap_amt#>
<cfelse>
<cfset request.offer_reserved_amt = #findSRR.comm_cap_amt#>
</cfif>


<cfif #findSRR.srr_status_cd# is "incompleteDocs" or  #findSRR.srr_status_cd# is "paymentIncompleteDocs">
<cfset request.srComment = "Thank you for applying for the Safe Sidewalks LA Rebate Program. We see that your application has expired.  We would like to re-open your application and provide a #request.ext_grantedDays#-day time extension. If you are interested in continuing with the Rebate Program, please click on the following link:
<br><br>
#request.serverRoot#/srr/public/uploadfile1.cfm?srrKey=#request.srrKey#
<br><br>
For more information about the Safe Sidewalks LA Rebate Program, please go to: sidewalks.lacity.org"> 

<cfelse>

<cfset request.srComment = "Thank you for applying for the Safe Sidewalks LA Rebate Program. We see that your application has expired.  We would like to re-open your application and provide a #request.ext_grantedDays#-day time extension. If you are interested in continuing with the Rebate Program, please click on the following link:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
<br><br>
For more information about the Safe Sidewalks LA Rebate Program, please go to: sidewalks.lacity.org"> 

</cfif>



<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

fakeUpdate = 1

<cfif #findSRR.srr_status_cd# is "incompleteDocs">
, srr_status_cd = 'incompleteDocsTemp'
, incompleteDocs_exp_dt = #CreateODBCDate(request.exp_dt)#
, record_history = isnull(record_history, '') + '|An extension of #request.ext_grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to submit documents to determine eligibility - By:#client.full_name# on #dnow#.'
, offer_reserved_amt = #toSqlNumeric(request.offer_reserved_amt)#
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

<cfelseif #findSRR.srr_status_cd# is "offerExpired">
, srr_status_cd = 'offerMade'
, offerMade_exp_dt = #CreateODBCDate(request.exp_dt)#
, record_history = isnull(record_history, '')  + '|An extension of #request.ext_grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to accept/deny the rebate offer - By:#client.full_name# on #dnow#.'

, offer_reserved_amt = 0
, offer_open_amt = #toSqlNumeric(request.rebateTotal)#
, offer_accepted_amt = 0
, offer_paid_amt = 0


<cfelseif #findSRR.srr_status_cd# is "requiredPermitsNotSubmitted">
, srr_status_cd = 'offerAccepted'
, requiredPermitsNotSubmitted_exp_dt = #CreateODBCDate(request.exp_dt)# 
, offerAccepted_exp_dt = #CreateODBCDate(request.exp_dt)# <!--- If required permits are not submitted by this date, request will be set to requiredPermitsNotSubmitted --->

, record_history = isnull(record_history, '')  + '|An extension of #request.ext_grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to submit all required permits - By:#client.full_name# on #dnow#.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0

<cfelseif #findSRR.srr_status_cd# is "constDurationExp">
, srr_status_cd = 'requiredPermitsIssued'
, requiredPermitsIssued_exp_dt = #CreateODBCDate(request.exp_dt)#<!--- Construction must be completed by this data --->
, record_history = isnull(record_history, '')  + '|An extension of #request.ext_grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to complete construction - By:#client.full_name# on #dnow#.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0

<cfelseif #findSRR.srr_status_cd# is "paymentIncompleteDocs">
, srr_status_cd = 'paymentIncompleteDocsTemp'
, paymentIncompleteDocs_exp_dt = #CreateODBCDate(request.exp_dt)#<!--- Construction must be completed by this data --->
, record_history = isnull(record_history, '')  + '|An extension of #request.ext_grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to provide requested documents to precess rebate payment - By:#client.full_name# on #dnow#.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0


</cfif>


where srrKey =  '#request.srrKey#'
</cfquery>




<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "88">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="SrrExpired@lacity.org" subject="Failed to update SRR">
Failed to update SR Ticket, check /srr/srp/process_expired2.cfm
srr_id = #request.srr_id#
</cfmail>
</cfcatch>
</cftry>

<div class = "warning">Application was Successfully Updated</div>