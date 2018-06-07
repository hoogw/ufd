<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfinclude template="navbar2.cfm">


<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>


<cfparam name="request.sidewalk_sqft" default="0">
<cfparam name="request.driveway_sqft" default="0">
<cfparam name="request.sw_trans_panel_sqft" default="0">
<cfparam name="request.curb_lf" default="0">
<cfparam name="request.gutter_lf" default="0">
<cfparam name="request.pkwy_drain_lf" default="0">
<cfparam name="request.tree_stump_qty" default="0">
<cfparam name="request.catchbasin_lid_qty" default="0">
<cfparam name="request.pullbox_qty" default="0">

 
<cfquery name="updateAdjustments" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[rebateAdjustments]
SET

	sidewalk_sqft = #toSqlNumeric(request.sidewalk_sqft)#
	,driveway_sqft = #toSqlNumeric(request.driveway_sqft)#
	,sw_trans_panel_sqft = #toSqlNumeric(request.sw_trans_panel_sqft)#
	,curb_lf = #toSqlNumeric(request.curb_lf)#
	,gutter_lf = #toSqlNumeric(request.gutter_lf)#
	,pkwy_drain_lf = #toSqlNumeric(request.pkwy_drain_lf)#
	,tree_stump_qty = #toSqlNumeric(request.tree_stump_qty)#
	,catchbasin_lid_qty = #toSqlNumeric(request.catchbasin_lid_qty)#
	,pullbox_qty = #toSqlNumeric(request.pullbox_qty)#
where srr_id = #request.srr_id#
</cfquery>

 
 
 <cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
Update [dbo].[srr_info]
SET

record_history = isNull(record_history, '') + '|BCA made rebate adjustments - By #client.full_name# on #dnow#.'

<cfif #request.bca_comments# is not "">
, bca_comments = isnull(bca_comments, '') + '|#toSqlText(request.bca_comments)# - By:#client.full_name# on #dnow#.'
</cfif>



where srrKey ='#request.srrKey#'
</cfquery>

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">
 
<cfoutput> 
 
<div class = 'warning'>Adjustments were Saved</div>

</cfoutput>