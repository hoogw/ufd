<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfparam name="request.trees_pruned_qty" default="0">
<cfparam name="request.trees_pruned_lf" default="0">
<cfparam name="request.trees_removed_qty" default="0">
<cfparam name="request.tree_stump_qty" default="0">
<cfparam name="request.trees_planted_onsite_qty" default="0">
<cfparam name="request.trees_planted_offsite_qty" default="0">


<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>
 
<cfquery name="updateAdjustments" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[rebateAdjustments]
SET
	trees_pruned_qty = #toSqlNumeric(request.trees_pruned_qty)#
	,trees_pruned_lf = 	#toSqlNumeric(request.trees_pruned_lf)#
	,trees_removed_qty = #toSqlNumeric(request.trees_removed_qty)#
	,tree_stump_qty = #toSqlNumeric(request.tree_stump_qty)#
	,trees_planted_onsite_qty = #toSqlNumeric(request.trees_planted_onsite_qty)#
	,trees_planted_offsite_qty = #toSqlNumeric(request.trees_planted_offsite_qty)#
      
where srr_id = #request.srr_id#
</cfquery>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

record_history = isNull(record_history, '') + '|BSS/UFD made rebate adjustments - By #client.full_name# on #dnow#.'

<cfif #request.bss_comments# is not "">
, bss_comments = isnull(bss_comments, '') + '|#toSqlText(request.bss_comments)# - By:#client.full_name# on #dnow#.'
</cfif>

where srrKey ='#request.srrKey#'
</cfquery>

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">
 
<cfoutput> 
 
<div class = 'warning'>Adjustments were Saved</div>

</cfoutput>