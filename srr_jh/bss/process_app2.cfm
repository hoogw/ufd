<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.close_bss_sr311" default="">
<cfparam name="request.meandering_viable" default="">
<cfparam name="request.srr_status_cd" default="">
<cfparam name="request.srNum" default="">
<cfparam name="request.srCode" default="">
<cfparam name="request.srComment" default="">

<cfquery name="updateTrees" datasource="#request.dsn#" dbtype="datasource">
Update tree_info
SET

nbr_trees_pruned = #toSqlNumeric(request.nbr_trees_pruned)#
, lf_trees_pruned = #toSqlNumeric(request.lf_trees_pruned)#
, nbr_trees_removed = #toSqlNumeric(request.nbr_trees_removed)#
, nbr_stumps_removed = #toSqlNumeric(request.nbr_stumps_removed)#
, nbr_trees_onsite = #toSqlNumeric(request.nbr_trees_onsite)#
, nbr_trees_offsite = #toSqlNumeric(request.nbr_trees_offsite)#
, meandering_viable = '#request.meandering_viable#'
, meandering_tree_nbr = #toSqlNumeric(request.meandering_tree_nbr)#

where srr_id =  #request.srr_id#
</cfquery>

<cfif not isnumeric(#request.nbr_trees_pruned#)>
<cfset request.nbr_trees_pruned = 0>
</cfif>

<cfif not isnumeric(#request.lf_trees_pruned#)>
<cfset request.lf_trees_pruned = 0>
</cfif>

<cfif not isnumeric(#request.nbr_trees_removed#)>
<cfset request.nbr_trees_removed = 0>
</cfif>

<cfif #request.nbr_trees_pruned# gt 0 and #request.lf_trees_pruned# is 0>
<div class="warning">Lineal Feet of Tree Root Pruning is Required!</div>
<cfabort>
</cfif>


<cfif #request.nbr_trees_pruned# is 0 and #request.lf_trees_pruned# gt 0>
<div class="warning">Number of Trees to be Root Pruned is Required!</div>
<cfabort>
</cfif>

<cfif #request.nbr_trees_removed# is 0>
<cfquery name="removeTreeRemovalPermit" datasource="#request.dsn#" dbtype="datasource">
delete from 
tree_removal_permit
where srr_id = #request.srr_id#
</cfquery>
</cfif>

<cfif #request.nbr_trees_pruned# is 0 and #request.lf_trees_pruned# is 0>
<cfquery name="removeTreePruningPermit" datasource="#request.dsn#" dbtype="datasource">
delete from 
tree_pruning_permit
where srr_id = #request.srr_id#
</cfquery>
</cfif>


<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

bss_action_by = #client.staff_user_id#
, close_bss_sr311 = '#request.close_bss_sr311#'


<cfif #request.srr_status_cd# is "offerMade">
, srr_status_cd = 'offerMade'
, offer_reserved_amt = 0
, offer_open_amt = #toSqlNumeric(request.rebateTotal)#
, offer_accepted_amt = 0
, offer_paid_amt = 0
, offerMade_dt = #now()#
, offerMade_exp_dt =  dateAdd("d", 14, #now()#)
, bss_assessment_comp_dt = #now()#
, record_history = record_history + '|BSS/UFD completed assessment on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#|Offer emailed to applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'
<cfelseif #request.srr_status_cd# is "pendingBOEReview">
, srr_status_cd = 'pendingBOEReview'
, bss_to_boe_dt = #now()#
, record_history = record_history + '|BSS/UFD forwarded application to Engineering (BOE) for further investigation on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
<cfelseif #request.srr_status_cd# is "PendingBssReview">
, srr_status_cd = 'PendingBssReview'
, record_history = record_history + '|BSS/UFD updated application on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.  No action was taken.'
</cfif>

, bss_comments = ISNULL(bss_comments, '') + '#toSqlText(request.bss_comments)#' + '| - By #client.full_name# on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srr_id =  #request.srr_id#
</cfquery>

<cfoutput>


<cfif #request.srr_status_cd# is "offerMade">
<div class="warning">Status is Updated to Estimate/Assessment Completed <br><br>(Offer Emailed to Applicant)</div>
<cfset request.offerMade_exp_dt =  dateAdd("d", 14, #now()#)>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "20"> <!--- Code 20 offerMade --->
<cfset request.srComment = "Your property has been approved to receive a rebate offer of #dollarformat(request.rebateTotal)# to make repairs that will ensure the fronting sidewalk is ADA compliant. In order to receive the rebate, you must submit the necessary permit(s) within 60 days. Further details regarding you rebate offer are available here:
<br><br>
#request.serverRoot#/srr/public/offer_to_applicant.cfm?srrKey=#request.srrKey#
<br><br>
This offer will expire on #dateformat(request.offerMade_exp_dt,"mm/dd/yyyy")#">


<cfelseif #request.srr_status_cd# is "pendingBOEReview">
<div class="warning">Status is Updated to Pending BOE Review</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 = pending BCA Review, Pending BOE Review, pending BSS Review --->
<cfset request.srComment = "">


<cfelseif #request.srr_status_cd# is "pendingBssReview">
<div class="warning">No Status Change<br><br>Application is still with BSS/UFD</div>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "16"> <!--- Code 16 = pending BCA Review, Pending BOE Review, pending BSS Review --->
<cfset request.srComment = "">


</cfif>



	<cfif #request.srr_status_cd# is "offerMade"><!--- 1 --->
	<cftry>
	
	<cfif #request.production# is "p"><!--- 000 --->
	<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->

	<!--- <div class="warning">
	Success: #request.srupdate_success#<br>
	Error Message: #request.srupdate_err_message#<br>
	</div> --->
	<cfcatch type="Any">
	<!--- <div class="warning">
	Error Updating Ticket in MyLA311<br><br>
	Success: #request.srupdate_success#<br>
	Error Message: #request.srupdate_err_message#<br>
	</div>
	<cfabort> --->
	</cfcatch>
	</cftry>
	</cfif><!--- 1 --->

</cfoutput>
