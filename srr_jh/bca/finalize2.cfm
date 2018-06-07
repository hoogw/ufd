<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">
<cfinclude template="navbar2.cfm">



<cfoutput>

<!--- <cfif not isdefined("request.bca_action") or #request.bca_action# is ""> 
<div class="warning">
Error!
<br><br>
An Action is Required!
</div>
<cfabort>
</cfif> --->

<cfset request.ADACompliant_exp_dt = dateAdd("d", 14, #now()#)>

<cfif #request.srr_status_cd# is "ADACompliantTemp">
<div class="warning">Site is already ADA Compliant - No Repairs Required</div>
<!--- A  Certificate of Compliance has been issued for the subject property and available here: <br>
{Certificate of Compliance} --->
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "19"> <!---  Code 19 is ADA Compliant and ADA Compliant Temp --->
<cfset request.srComment = "Thank you for your interest in the City of Los Angeles Sidewalk Rebate Program. A City official has determined that your sidewalk is compliant with all ADA requirements and no further action is needed. 
<br><br>
ADA compliance requirements are found here: 
<br>
http://sidewalks.lacity.org/rebate-program-faqs
<br>
http://sidewalks.lacity.org/rebate-program-rules-and-regulations
<br><br>
You may appeal this determination by: #dateformat(request.ADACompliant_exp_dt,'mm/dd/yyyy')#, using the following link:
<br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#request.srrKey#
">


<cfelseif #request.srr_status_cd# is "pendingBssReview">
<div class="warning">Request is sent to BSS/UFD</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16, pending review by BCA, BSS, or BOE --->
<cfset request.srComment = ""><!--- No Comments needed for this reason code. No Emails will be sent to applicant. --->




<cfelseif #request.srr_status_cd# is "PendingBoeReview">
<div class="warning">Request is sent to BOE</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16, pending review by BCA, BSS, or BOE --->
<cfset request.srComment = ""><!--- No Comments needed for this reason code. No Emails will be sent to applicant. --->



<cfelseif #request.srr_status_cd# is "offerMade">
<cfset request.offerMade_exp_dt =  dateAdd("d", 14, #now()#)>
<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#" width="95%">
<div class="warning">Offer Emailed to Applicant</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "20"> <!--- Code 20 = offerMade --->
<cfset request.srComment = "Your property has been approved to receive a rebate offer of #dollarformat(request.rebateTotal)# to make repairs that will ensure the fronting sidewalk is ADA compliant. In order to receive the rebate, you must submit the necessary permit(s) within 60 days. Further details regarding you rebate offer are available here:
<br><br>
#request.serverRoot#/srr/public/offer_to_applicant.cfm?srrKey=#request.srrKey#
<br><br>
This offer will expire on #dateformat(request.offerMade_exp_dt,"mm/dd/yyyy")#
">


<cfelseif #request.srr_status_cd# is "pendingBcaReview">
<div class="warning">Request is still with BCA</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16, pending review by BCA, BSS, or BOE --->
<cfset request.srComment = ""><!--- No Comments needed for this reason code. No Emails will be sent to applicant. --->
</cfif>

<!--- <cfset request.bca_comments = ReplaceList("#request.bca_comments#","#chr(39)#","#chr(39)##chr(39)#")> --->

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">


<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
  srr_status_cd = '#request.srr_status_cd#'
  
<cfif #request.bca_comments# is not "">
, bca_comments = isnull(bca_comments, '') + '|#toSqlText(request.bca_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

<!--- , bca_action_dt = #now()# --->
, bca_action_by = #client.staff_user_id#

<cfif #request.srr_status_cd# is "pendingBssReview">
, bca_to_bss_dt = #now()#
, record_history = record_history + '|BCA forwarded application to BSS for review on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.srr_status_cd# is "ADACompliantTemp">
, AdaCompliant_dt = #now()#
, AdaCompliant_exp_dt = dateAdd("d", 14, #now()#)
, record_history = record_history + '|Application status was changed to ADA Compliant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|An Email was sent to applicant, on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#, with a link to appeal determination.'
<cfelseif #request.srr_status_cd# is "offerMade">
, bca_assessment_comp_dt = #now()#
, offerMade_dt = #now()#
, offerMade_exp_dt =  dateAdd("d", 14, #now()#)
, record_history = record_history + '|BCA site investigation was completed on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|Offer was emailed to applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

, offer_reserved_amt = 0
, offer_open_amt = #request.rebateTotal#
, offer_accepted_amt = 0
, offer_paid_amt = 0
<cfelseif #request.srr_status_cd# is "pendingBOEReview">
, bca_to_boe_dt = #now()#
, record_history = record_history + '|BCA forwarded application to Engineering (BOE) for further investigation on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
</cfif>
where srr_id = #request.srr_id#
</cfquery>



<cfif #request.srr_status_cd# is "ADACompliantTemp" or #request.srr_status_cd# is "offerMade"><!--- 1 --->
<cftry>

		<cfif #request.production# is "p"><!--- 000 --->	
			<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
		</cfif><!--- 000 --->

<!--- see footer --->
<cfcatch type="Any">
<!--- see footer --->
</cfcatch>
</cftry>
</cfif><!--- 1 --->


<!--- Open new ticket for Tree Inspection --->
<cfif #request.srr_status_cd# is "pendingBssReview">
<div class="notes">
<cfset request.srNum = "#request.sr_number#">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/insertSRTicket_module.cfm" srNum="#request.srNum#">
<cfquery name="TreeInspecSrNumber" datasource="#request.dsn#" dbtype="datasource">
UPDATE srr_info
set tree_insp_sr_number = '#request.srticket_srnum#'
WHERE
srr_id = #request.srr_id#
</cfquery>
<!--- #request.srticket_success#<br>
#request.srticket_err_message#<br>
#request.srticket_srnum#<br> --->
</cfif><!--- 000 --->

<cfcatch>
Error:  Could Not Add MyLA311 Child Ticket for Tree Inspection
</cfcatch>
</cftry>
</cfif>

</div>



</cfoutput>
<cfinclude template="footer.cfm">