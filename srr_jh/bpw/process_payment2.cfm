<cfinclude template="../common/validate_srrKey.cfm">

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="mailingAddress" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, mailing_address1
, mailing_address2
, mailing_zip
, mailing_city
, mailing_state
, srr_status_cd

FROM  dbo.srr_info
where srrKey='#request.srrKey#'
</cfquery>

<cfif #mailingAddress.srr_status_cd# is "paymentPending">
<div class="warning">This payment is already processed</div>
<cfabort>
</cfif>

<!--- <cfoutput>
update srr_info
set
  paymentIncompleteReasons='#request.paymentIncompleteReasons#'
, bpw2_internal_comments='#request.bpw2_internal_comments#'

, bpw2_action_dt = #now()#
, bpw2_action_by = #client.staff_user_id#
, srr_status_cd = '#request.srr_status_cd#'

<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp">
, paymentIncompleteDocs_dt = #now()#
, paymentIncompleteDocs_exp_dt = dateAdd("d", 14, #now()#)
, record_history = record_history + '|BPW changed status to Incomplete Documents for Processing Rebate on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.srr_status_cd# is "paymentPending">
, paymentPending_dt = #now()#
, record_history = record_history + '|BPW changed status to Payment Pending on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelse>
, record_history = record_history + '|BPW updated the payment processing screen on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
</cfif>

where srrKey = '#request.srrKey#'
</cfoutput>

<cfabort> --->

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

fakeUpdate = 1

<cfif #trim(request.paymentIncompleteReasons)# is not "">
 , paymentIncompleteReasons = isnull(paymentIncompleteReasons, '') + '|#request.paymentIncompleteReasons#  - Date: #dnow#.'
 </cfif>
 
 <cfif #trim(request.bpw2_internal_comments)# is not "">
, bpw2_internal_comments=isnull(bpw2_internal_comments, '') + '|#request.bpw2_internal_comments# - By:#client.full_name# on #dnow#.'
</cfif>

, bpw2_action_dt = #now()#
, bpw2_action_by = #client.staff_user_id#
, srr_status_cd = '#request.srr_status_cd#'

<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp">
, paymentIncompleteDocs_dt = #now()#
, paymentIncompleteDocs_exp_dt = dateAdd("d", 14, #now()#)
, record_history = record_history + '|BPW changed status to Incomplete Documents for Processing Rebate - By:#client.full_name# on #dnow#.'
<cfelseif #request.srr_status_cd# is "paymentPending">
, paymentPending_dt = #now()#
, record_history = record_history + '|BPW changed status to Payment Pending  - By:#client.full_name# on #dnow#.'
, offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = #request.rebateTotal#

<cfelse>
, record_history = record_history + '|BPW updated the payment processing screen - By:#client.full_name# on #dnow#.'
</cfif>

where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
#request.srr_status_cd#
</cfoutput>

<!--- <cfabort> --->



<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp">
<cfset request.paymentIncompleteDocs_exp_dt = dateAdd("d", 14, #now()#)>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "15"><!--- Code 15 is for any incomplete documents --->
<cfset request.srComment = "Further documentation is required to process your application for the Sidewalk Rebate Program. The specific documentation required is listed in the following link under Important Messages:<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
<br><br>
 The deadline to submit the requested information is #dateformat(request.paymentIncompleteDocs_exp_dt,'mm/dd/yyyy')#. Failure to provide the necessary documentation by #dateformat(request.paymentIncompleteDocs_exp_dt,'mm/dd/yyyy')# may result in the application being declared ineligible.
">

<cfelseif #request.srr_status_cd# is "paymentPending">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "28"><!--- Code 28 is for Pending Payment --->
<cfset request.srComment = "Thank you for participating in the City of Los Angeles Sidewalk Rebate Program and for the successful completion of your sidewalk repairs. Your IRS W9 Form has been received, and your rebate check is being processed. If you do not receive your check in a reasonable time contact the Board of Public Works at (213) 978-0227.  The rebate check will be sent to the following address:
<br><br>
#Ucase(mailingAddress.mailing_address1)#
<cfif #mailingAddress.mailing_address2# is not "">
<br>#Ucase(mailingAddress.mailing_address2)#
</cfif>
#Ucase(mailingAddress.mailing_city)#, #Ucase(mailingAddress.mailing_state)# #mailingAddress.mailing_zip#
">
</cfif>



	<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp" or #request.srr_status_cd# is "paymentPending"><!--- 1 --->
	<cftry>
	
	<cfif #request.production# is "p"><!--- 000 --->
	<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
	</cfif><!--- 000 --->
	
	<!--- see footer for return values --->
	<cfcatch type="Any">
	<cfmail to="essam.amarragy@lacity.org" from="ProcessPayment@lacity.org" subject="UpdateSRR did not go through">
	Updating SR No. #request.srNum# did not go through - Check Process Payment 2.cfm
	</cfmail>
	</cfcatch>
	</cftry>
	</cfif><!--- 1 --->


<div class="warning">Payment Processed</div>


