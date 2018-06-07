<cfinclude template="../common/validate_srrKey.cfm">

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

FROM  dbo.srr_info
</cfquery>

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
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
</cfquery>


<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp">
<cfset request.paymentIncompleteDocs_exp_dt = dateAdd("d", 14, #now()#)>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "15"><!--- Code 15 is for any incomplete documents --->
<cfset request.srComment = "Further documentation is required to process your application for the Sidewalk Rebate Program. The specific documentation required is listed in the following link:<br><br>
#request.serverRoot#/srr/public/RebateDocsRequired.cfm?srrKey=#request.srrKey#
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


<!--- <cfoutput>
<div class="warning">
<cfif #request.srr_status_cd# is "paymentIncompleteDocsTemp">
Status is Updated to Incomplete Document (Payment Phase)
<br><br>
Applicant will be notified of what documents to provide.
<br><br>
Applicant will be instructed to mail (not email) documents.
<br><br>
A link will be provide to <a href="https://www.irs.gov/pub/irs-pdf/fw9.pdf" target="_blank">W9 form</a>
</cfif>
<cfif #request.srr_status_cd# is "paymentPending">
Status is Updated to Pending Payment
<br><br>
Update 311 reason code to 28 and provide External Comments to 311 
<br><br>
(Applicant will receive an email)
</cfif>
</div>
</cfoutput> --->
