<cfinclude template="../common/validate_SrrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfif #trim(request.boe_invest_comments)# is "">
<div class="warning">
Justification is Required!
</div>
<cfabort>
</cfif>

<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.srrKey
, srr_info.sr_number
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_info.job_address
, srr_info.prop_type
, srr_info.tree_insp_sr_number
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd

where srrKey = '#request.srrKey#'
</cfquery>

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfif #request.srr_status_cd# is "received">
<cfset request.newStatus = "Pending BPW Review">
<cfelseif #request.srr_status_cd# is "pendingBcaReview">
<cfset request.newStatus = "Pending BCA Review">
<cfelseif #request.srr_status_cd# is "pendingBssReview">
<cfset request.newStatus = "Pending BSS Review">
<cfelseif #request.srr_status_cd# is "pendingBoeReview">
<cfset request.newStatus = "Pending BOE Review">
<cfelseif #request.srr_status_cd# is "cancelTicket">
<cfset request.newStatus = "Application is Canceled">
<cfelseif #request.srr_status_cd# is "waitListed">
<cfset request.newStatus = "Application was moved to waiting list">
<cfelseif #request.srr_status_cd# is "constCompleted">
<cfset request.newStatus = "Construction Completed and Accepted">
</cfif>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
UPDATE srr_info

set

srr_status_cd = '#request.srr_status_cd#'

<cfif #request.srr_status_cd# is "received">

<cfif #getSRR.prop_type# is "r">
, offer_reserved_amt = #getSRR.res_cap_amt# 
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_reserved_amt = #getSRR.comm_cap_amt# 
</cfif>

, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

, offerAccepted_dt = null
, offerAccepted_exp_dt = null

, offerDeclined_dt = null
, offerDeclined_exp_dt = null

, offerMade_dt = null
, offerMade_exp_dt = null

, bca_assessment_comp_dt = null
, bca_to_bss_dt = null

, AdaCompliant_dt = null
, AdaCompliant_exp_dt = null

, bss_action_by = null
, bss_to_boe_dt = null

, bss_assessment_comp_dt = null
, bpw_to_bca_dt = null

<cfelseif  #request.srr_status_cd# is "pendingBcaReview">

<cfif #getSRR.prop_type# is "r">
, offer_reserved_amt = #getSRR.res_cap_amt# 
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_reserved_amt = #getSRR.comm_cap_amt# 
</cfif>

, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

, offerAccepted_dt = null
, offerAccepted_exp_dt = null

, offerDeclined_dt = null
, offerDeclined_exp_dt = null

, offerMade_dt = null
, offerMade_exp_dt = null

, bca_assessment_comp_dt = null
, bca_to_bss_dt = null

, AdaCompliant_dt = null
, AdaCompliant_exp_dt = null

, bss_action_by = null
, bss_to_boe_dt = null

, bss_assessment_comp_dt = null
, bpw_to_bca_dt = null

<cfelseif  #request.srr_status_cd# is "pendingBssReview">

<cfif #getSRR.prop_type# is "r">
, offer_reserved_amt = #getSRR.res_cap_amt#
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_reserved_amt = #getSRR.comm_cap_amt#
</cfif>

, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

, offerAccepted_dt = null
, offerAccepted_exp_dt = null

, offerDeclined_dt = null
, offerDeclined_exp_dt = null

, offerMade_dt = null
, offerMade_exp_dt = null

, bss_action_by = null
, bss_to_boe_dt = null

, bss_assessment_comp_dt = null
<cfelseif  #request.srr_status_cd# is "pendingBoeReview">

<cfif #getSRR.prop_type# is "r">
, offer_reserved_amt = #getSRR.res_cap_amt#
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_reserved_amt = #getSRR.comm_cap_amt#
</cfif>

, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0


, offerAccepted_dt = null
, offerAccepted_exp_dt = null

, offerDeclined_dt = null
, offerDeclined_exp_dt = null

, offerMade_dt = null
, offerMade_exp_dt = null

<cfelseif  #request.srr_status_cd# is "constCompleted">

<cfif #getSRR.prop_type# is "r">
, offer_open_amt = #getSRR.res_cap_amt#
<cfelseif #getSRR.prop_type# is "c" OR #getSRR.prop_type# is "">
, offer_open_amt = #getSRR.comm_cap_amt#
</cfif>
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0


<cfelseif  #request.srr_status_cd# is "cancelTicket">

, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

<cfelseif  #request.srr_status_cd# is "waitListed">

, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_open_amt = 0
, offer_paid_amt = 0

</cfif>

, boe_invest_comments = isnull(boe_invest_comments, '') + '|#toSqlText(request.boe_invest_comments)# - By:#client.full_name# on #dnow#.'

, record_history = isnull(record_history, '') + '|Application Status override: from #getSRR.srr_status_desc# to #request.newStatus# on #dnow# by #client.full_name#.'

where srrKey = '#request.srrKey#'

</cfquery>



<cfif  #request.srr_status_cd# is "cancelTicket">
<cfset #request.srComment# = "Your application for the Sidewalk Rebate Program has been cancelled. If you would like to reapply you may do so at sidewalks.lacity.org. If you have any questions, please contact us at sidewalks@lacity.org">
<cfset request.srCode = "CA">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.sr_number#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="SRR@lacity.org" subject="Failed to update MyLA311 Status - override_status2.cfm">sr number:  #request.sr_number#
</cfmail>
</cfcatch>
</cftry>
</cfif>



<cfif  #request.srr_status_cd# is "waitListed">
<cfset #request.srComment# = "There are currently insufficient funds available to further process your application for the Sidewalk Rebate Program.  Your application has been placed on a waitlist until more funds become available. Your place in line is determined by the date your application was received - do not resubmit.  A change to your waitlist status will be posted to the original Service Request ticket in MyLA311 and will be sent via e-mail.">
<cfset request.srCode = "11">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.sr_number#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="SRR@lacity.org" subject="Failed to update MyLA311 Status - override_status2.cfm">
sr number:  #request.sr_number#
</cfmail>
</cfcatch>
</cftry>
</cfif>













<cfif #getSRR.tree_insp_sr_number# is "" and #request.srr_status_cd# is "pendingBssReview"><!--- 2 --->
		<cfset request.srNum = "#getSRR.sr_number#">
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
		
		<cfoutput>
		<div class="warning">A Child Ticket Number: #request.srticket_srnum# was created for Tree Inspection.</div><br>
		</cfoutput>
</cfif><!--- 000 --->	
		<cfcatch>
		
		<cfoutput>
		<div class="warning">A Child Ticket for Tree Inspection could NOT be created.</div><br>
		</cfoutput>
		
		<cfmail to="essam.amarragy@lacity.org" from="overridestatus2@lacity.org" subject="Could Not Generate Child Ticket">
		Error:  Could Not Add MyLA311 Child Ticket for Tree Inspection
		</cfmail>
		
		</cfcatch>
		</cftry>
		
		
</cfif><!--- 2 --->





<div class = "warning">Status was Successfully Updated</div>