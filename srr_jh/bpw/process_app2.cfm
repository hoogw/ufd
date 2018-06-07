<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.bpw1_ownership_verified" default="">
<cfparam name="request.bpw1_tax_verified" default="">

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

bpw1_ownership_verified='#request.bpw1_ownership_verified#'

<cfif #request.bpw1_ownership_comments# is not "">
, bpw1_ownership_comments = isnull(bpw1_ownership_comments, '') + '|#toSqlText(request.bpw1_ownership_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

, bpw1_tax_verified='#request.bpw1_tax_verified#'

<cfif #request.bpw1_tax_comments# is not "">
, bpw1_tax_comments= isnull(bpw1_tax_comments, '') + '|#toSqlText(request.bpw1_tax_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

<cfif #request.bpw1_comments_to_app# is not "">
, bpw1_comments_to_app= isnull(bpw1_comments_to_app, '')   + '|#toSqlText(request.bpw1_comments_to_app)# - By:#client.full_name# on #dnow#.'
</cfif>

<!--- <cfif #request.bpw1_internal_comments# is not "">
, bpw1_internal_comments= isnull(bpw1_internal_comments, '') + '|#toSqlText(request.bpw1_internal_comments)# - By:#client.full_name# on #dnow#.'
</cfif> --->

, srr_status_cd = '#request.srr_status_cd#'

, bpw1_action_dt = #now()#
, bpw1_action_by = #client.staff_user_id#

<cfif #request.srr_status_cd# is "pendingBCAReview">
, eligibility_dt = #now()#
, bpw_to_bca_dt = #now()#

, notEligible_dt = null
, notEligible_exp_dt = null

, incompleteDocs_dt = null
, incompleteDocs_exp_dt = null

, bpw_to_boe_dt = null

, record_history = record_history + '|Application was found to be eligible for the Sidewalk Rebate Program. BPW forwarded application to BCA for field investigation on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.srr_status_cd# is "incompleteDocsTemp">
, eligibility_dt = null
, bpw_to_bca_dt = null

, notEligible_dt = null
, notEligible_exp_dt = null

, incompleteDocs_dt = #now()#
, incompleteDocs_exp_dt = dateAdd("d", 14, #now()#)

, bpw_to_boe_dt = null

, record_history = record_history + '|BPW updated status to Incomplete Docuements on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|An email is sent to applicant with a link to upload requested documents.'
<cfelseif #request.srr_status_cd# is "notEligibleTemp">
, eligibility_dt = null
, bpw_to_bca_dt = null


, notEligible_dt = #now()#
, notEligible_exp_dt = dateAdd("d", 14, #now()#)

, incompleteDocs_dt = null
, incompleteDocs_exp_dt = null

, bpw_to_boe_dt = null

, record_history = record_history + '|BPW updated Status to NOT Eligible on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|An email was sent to applicant to indicate ineligibility with a link to appeal this decision.'
<cfelseif #request.srr_status_cd# is "pendingBOEReview">
, eligibility_dt = null
, bpw_to_bca_dt = null

, notEligible_dt = null
, notEligible_exp_dt = null

, incompleteDocs_dt = null
, incompleteDocs_exp_dt = null

, bpw_to_boe_dt = #now()#

, record_history = record_history + '|BPW forwarded application to Engineering for further investigation on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.srr_status_cd# is "Received">
, eligibility_dt = null
, bpw_to_bca_dt = null

, notEligible_dt = null
, notEligible_exp_dt = null

, incompleteDocs_dt = null
, incompleteDocs_exp_dt = null

, bpw_to_boe_dt = null
</cfif>

where srrKey = '#request.srrKey#'
</cfquery>


<cfset request.incompleteDocs_exp_dt = dateAdd("d", 14, #now()#)>
<cfset request.notEligible_exp_dt = dateAdd("d", 14, #now()#)>
<cfoutput>
<!--- <div class="warning"> --->
<cfif #request.srr_status_cd# is "pendingBCAReview">
<!--- Status is Updated to Eligible / Pending BCA Review<br>
Request now is in BCA queue. --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 Field Inspection Required --->
<cfset request.srComment = "Congratulations! Your property may be eligible for the City of Los Angeles Sidewalk Rebate Program. 
A City representative will assess the condition of the sidewalk adjacent to your property. After the assessment, a rebate offer will be generated and sent by email.
Information about the next steps in the process is found here:
<br><br>
#request.serverRoot#/srr/public/whatIsnext.cfm
<br><br>
In order to obtain the permit(s) within 60 days after the offer is sent, you will need to have a licensed contractor and the license number.">


<cfelseif #request.srr_status_cd# is "incompleteDocsTemp">
<!--- Status is Updated to Incomplete Documents --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "15"> <!--- Code 15 Incomplete  --->
<cfset request.srComment = "Further documentation is required to process your application for the Sidewalk Rebate Program. The specific documentation required is listed in the following link. The deadline to submit the requested information is #dateformat(request.incompleteDocs_exp_dt,'mm/dd/yyyy')#. Failure to provide the necessary documentation by #dateformat(request.incompleteDocs_exp_dt,'mm/dd/yyyy')# may result in the application being declared ineligible. 

<br><br>Please use the following link to provide the required  documentation (copy and paste in your browser):
<br><br>#request.serverRoot#/srr/public/EligibilityDocsRequired.cfm?srrKey=#request.srrKey#">


<cfelseif #request.srr_status_cd# is "notEligibleTemp">
<!--- Status is Updated to NOT Eligible --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "13"> <!--- Code 13 Not Eligible --->
<cfset request.srComment = "We regret to inform you that your application has been deemed ineligible for the Sidewalk Rebate Program. The specific reason(s) that the application was ineligible are provided in the following link: 
<br><br>
#request.serverRoot#/srr/public/whyNotEligible.cfm?srrKey=#request.srrKey#
<br><br>
To appeal this decision, use the following link to submit an appeal no later than #dateformat(request.notEligible_exp_dt,'mm/dd/yyyy')#
<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#request.srrKey#
<br><br>
The rules and regulations for the Sidewalk Rebate Program are available here: <br><br>
http://sidewalks.lacity.org/rebate-program-rules-and-regulations
">


<cfelseif #request.srr_status_cd# is "received">
<!--- Status is Updated to Received - Pending Review (BPW) - No Comments to Applicant needed. --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "12"><!--- code 12 is received --->
<cfset request.srComment = ""><!--- No Comments to Applicant needed. --->


<cfelseif #request.srr_status_cd# is "pendingBOEReview">
Status is Updated to Pending Engineering (BOE) Review
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 Field Inspection Required --->
<cfset request.srComment = ""><!--- No Comments to Applicant needed. --->

</cfif>
</div>



	<cfif #request.srr_status_cd# is "Received" 
	or #request.srr_status_cd# is "pendingBCAReview"
	or #request.srr_status_cd# is "incompleteDocsTemp"
	or #request.srr_status_cd# is "notEligibleTemp"><!--- 1 --->
	
	
	<cftry>
	
	<cfif #request.production# is "p"><!--- 000 --->
	<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
	</cfif><!--- 000 --->
	
	<!--- see footer for return values --->
	<cfcatch type="Any">
	<!--- see footer for return values --->
	</cfcatch>
	</cftry>
	
	
	</cfif><!--- 1 --->


</cfoutput>