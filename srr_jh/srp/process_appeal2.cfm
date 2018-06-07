<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
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

<cfif #getSRR.prop_type# is "r">
<cfset request.offer_reserved_amt = #getSRR.res_cap_amt#>
<cfelse>
<cfset request.offer_reserved_amt = #getSRR.comm_cap_amt#>
</cfif>






<cfoutput>

<cfparam name="request.grantedDays" default="0">
<cfparam name="request.appealDecision" default=""><!--- appeal decision is "a" for approved and "d" for denied --->

<cfset request.exp_dt = dateAdd("d", #request.grantedDays#, #now()#)>

<!--- <cfquery name="getReason" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[appealID]
      ,[srr_id]
      ,[appealDate]
      ,[appealReason]
      ,[appealCommentsApp]
      ,[appealDecision]
      ,[appealDecisionComments]
      ,[appealDecision_dt]
      ,[appealDecision_by]
  FROM [srr].[dbo].[appeals]
  where appealReason = '#request.appealReason#'
</cfquery>
 --->
 
 
<!--- 
appealedNotEligible
appealedADACompliant
appealedOfferExpired
appealedRequiredPermitsNotSubmitted
appealedConstDurationExp
appealedIncompleteDocsExp
appealedPaymentIncompleteDocsExp 
--->

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<cfquery name="updateAppeal" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[appeals]
SET

appealDecision = '#request.appealDecision#'  <!--- this is a or d or blank --->

<cfif #request.appealDecision# is "a" or #request.appealDecision# is "d">
, appealDecision_dt = #now()#
, appealDecision_by = #client.staff_user_id#
, grantedDays = #request.grantedDays#
</cfif>

<cfif isdefined("request.sendTo")>
, sendTo = '#request.sendTo#'
</cfif>

, appealDecisionComments = isnull(appealDecisionComments, '') + '|#toSqlText(request.appealDecisionComments)#'

where appealID = #request.appealID#
</cfquery>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

fakeUpdate = 1

<cfif #request.appealDecision# is "d">
<!--- , srr_status_cd = 'appealDenied' --->
, srr_status_cd = 'canceled'
, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

, record_history = isnull(record_history, '') + '|Appeal was denied on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.appealDecision# is "a">

<cfif #getSRR.srr_status_cd# is "appealedIncompleteDocsExp">
, srr_status_cd = 'incompleteDocsTemp'
, incompleteDocs_exp_dt = #CreateODBCDate(request.exp_dt)#
, record_history = isnull(record_history, '') + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. An extension of #request.grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to submit documents to determine eligibility.'
, offer_reserved_amt = #toSqlNumeric(request.offer_reserved_amt)#
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

<cfelseif #getSRR.srr_status_cd# is "appealedOfferExpired">
, srr_status_cd = 'offerMade'
, offerMade_exp_dt = #CreateODBCDate(request.exp_dt)#
, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. An extension of #request.grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to accept/deny the rebate offer.'

, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_open_amt = #toSqlNumeric(request.offer_reserved_amt)#
, offer_paid_amt = 0
<cfelseif #getSRR.srr_status_cd# is "appealedRequiredPermitsNotSubmitted">
, srr_status_cd = 'offerAccepted'
, requiredPermitsNotSubmitted_exp_dt = #CreateODBCDate(request.exp_dt)# <!--- This date is used to determine when the appeal period expires for applications where applicant did not submit the required permits within 60 days of accepting the offer.  It is 14 days after requiredPermitsNotSubmitted_dt --->

, offerAccepted_exp_dt = #CreateODBCDate(request.exp_dt)# <!--- If required permits are not submitted by this date, request will be set to requirededPermitsNotSubmitted --->

, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. An extension of #request.grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to submit all required permits.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0
<cfelseif #getSRR.srr_status_cd# is "appealedConstDurationExp">
, srr_status_cd = 'requiredPermitsIssued'  <!--- was 'requiredPermitsSubmitted'  on 6/5/2017--->
, requiredPermitsIssued_exp_dt = #CreateODBCDate(request.exp_dt)#<!--- Construction must be completed by this data --->
, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. An extension of #request.grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to complete construction.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0

<cfelseif #getSRR.srr_status_cd# is "appealedPaymentIncompleteDocsExp">
, srr_status_cd = 'paymentIncompleteDocsTemp'
, paymentIncompleteDocs_exp_dt = #CreateODBCDate(request.exp_dt)#
, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. An extension of #request.grantedDays# days was given to applicant, until #dateformat(request.exp_dt,"mm/dd/yyyy")#, to provide documents required for processing rebate payment.'

, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_paid_amt = 0

<cfelseif #getSRR.srr_status_cd# is "appealedNotEligible">
, srr_status_cd = '#request.sendTo#'
, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.  Application eligibility will be re-evaluated.'

, offer_reserved_amt = #toSqlNumeric(request.offer_reserved_amt)#
, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

<cfelseif #getSRR.srr_status_cd# is "appealedADACompliant">
, srr_status_cd = '#request.sendTo#'
, record_history = isnull(record_history, '')  + '|Appeal was approved on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#. Application will be re-evaluated for ADA Compliance.'

, offer_reserved_amt = #toSqlNumeric(request.offer_reserved_amt)#
, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

</cfif>

</cfif>

where srrKey =  '#request.srrKey#'
</cfquery>

<!--- code 40 appeal approved --->

<cfif #request.appealDecision# is "a">

<cfif #getSRR.srr_status_cd# is "appealedIncompleteDocsExp">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  Please submit the required documents to determine eligibility.  You have until #dateformat(request.exp_dt,'mm/dd/yyyy')#.  The following link can be used to submit the required documents:
<br><br>
#request.serverRoot#/srr/public/uploadfile1.cfm?srrKey=#request.srrKey#
 ">

<cfelseif #getSRR.srr_status_cd# is "appealedOfferExpired">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  You have until #dateformat(request.exp_dt,'mm/dd/yyyy')# to accept the Sidewalk Repair Rebate offer.  The following link can be used to view the rebate offer:
<br><br>
#request.serverRoot#/srr/public/offer_to_applicant.cfm?srrKey=#request.srrKey#
 ">
 
 <cfelseif #getSRR.srr_status_cd# is "appealedRequiredPermitsNotSubmitted">
 <cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  You have until #dateformat(request.exp_dt,'mm/dd/yyyy')# to submit all applicable permits.  The following link can be used to submit the required permits:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
 ">
 
 <cfelseif #getSRR.srr_status_cd# is "appealedConstDurationExp">
  <cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  You have until #dateformat(request.exp_dt,'mm/dd/yyyy')# to complete the required construction.  The following link can be used to monitor the rebate request progress:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
 ">
 
 <cfelseif #getSRR.srr_status_cd# is "appealedPaymentIncompleteDocsExp">
   <cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  You have until #dateformat(request.exp_dt,'mm/dd/yyyy')# to submit the completed documents.  The following link can be used to submit the required documents:
<br><br>
#request.serverRoot#/srr/public/uploadfile1.cfm?srrKey=#request.srrKey#
 ">
 
  <cfelseif #getSRR.srr_status_cd# is "appealedNotEligible">
   <cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  Your application will be re-evaluated for sidewalk rebate eligibility. Please continue to monitor your email for further notifications.">


  <cfelseif #getSRR.srr_status_cd# is "appealedADACompliant">
   <cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "40"><!--- code 40 appeal approved --->
<cfset request.srComment = "Your appeal was approved on #dateformat(Now(),'mm/dd/yyyy')#.  Your application will be re-evaluated for ADA Compliance.  Please continue to monitor your email for further notifications.">
 
 
 </cfif>
 
 </cfif>
 
 
 <cfif #request.appealDecision# is "d">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "CA"><!--- code 41 appeal denied but this request will be canceled based on SRP requirements for version 2.0 07/03/2017 --->
<cfset request.srComment = "We regret to inform you that your appeal for the Sidewalk Rebate Program was denied on #dateformat(Now(),'mm/dd/yyyy')#.  This request is canceled as of #dateformat(Now(),'mm/dd/yyyy')#">
 </cfif>

 
 <cfif #request.appealDecision# is "a" or #request.appealDecision# is "d">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfif>




<cfif isdefined("request.sendTo") and #request.sendTo# is "pendingBssReview"><!--- 1 --->
		<cfquery name="checkChildTicket" datasource="#request.dsn#" dbtype="datasource">
		Select srr_id, tree_insp_sr_number, sr_number
		from srr_info
		where srrKey='#request.srrKey#'
		</cfquery>
	
	<cfif #checkChildTicket.tree_insp_sr_number# is ""><!--- 2 --->
		<cfset request.srNum = "#checkChildTicket.sr_number#">
		<cftry>
		
<cfif #request.production# is "p"><!--- 000 --->		
		<cfmodule template="../modules/insertSRTicket_module.cfm" srNum="#request.srNum#">
	<!--- 	#request.srticket_success#<br>
		#request.srticket_err_message#<br>
		#request.srticket_srnum#<br> --->
		<cfquery name="TreeInspecSrNumber" datasource="#request.dsn#" dbtype="datasource">
		UPDATE srr_info
		set tree_insp_sr_number = '#request.srticket_srnum#'
		WHERE
		srrKey = '#request.srrKey#'
		</cfquery>
</cfif><!--- 000 --->

		<cfcatch>
		
		<cfmail to="essam.amarragy@lacity.org" from="ProcessAppeal2@lacity.org" subject="Could Not Generate Child Ticket">
		Error:  Could Not Add MyLA311 Child Ticket for Tree Inspection
		</cfmail>
		
		</cfcatch>
		</cftry>
	</cfif><!--- 2 --->


</cfif><!--- 1 --->

<div class = "warning">Application was Successfully Updated</div>

</cfoutput>