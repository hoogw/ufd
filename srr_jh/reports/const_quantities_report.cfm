<cfinclude template="../common/html_top.cfm">

<cfparam name="request.startDate" default="12/1/2016">
<cfparam name="request.endDate" default="#dateformat(now(),"mm/dd/yyyy")#">

<cfoutput>
<div class="title">Sidewalk Rebate Requests Quantities Report</div>
<div style="text-align:center;margin-bottom:7px;">(The quantities below represent the requests where construction is completed and accepted)</div>

<form action="#cgi.script_name#" method="post" name="form1" id="form1">
<div class="formbox" style="width:730px;">
<h1 style="margin-bottom: 0px;">Construction Completed between:</h1>
<input type="date" name="startDate" id="startDate" placeholder = "Start Date" value="#request.startDate#"> &nbsp;&nbsp;and &nbsp;&nbsp;<input type="date" name="endDate" id="endDate" placeholder = "End Date" value="#request.endDate#">&nbsp;&nbsp;<input type="submit" name="submit" id="submit" value="Refresh">
<br>
<div style="text-align:center;">(The default is from inception to date)</div>
</div>

</FORM>
</cfoutput>
<br>

<cfset request.endDate1= DateAdd ("d", 1, #request.endDate#)>

<cfquery name="getList" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_id, a_ref_no, srrKey
    
  FROM [srr].[dbo].[srr_info]
  where (srr_status_cd = 'paymentPending' or srr_status_cd = 'constCompleted')
  
  and srr_info.constCompleted_dt >= #CreateODBCDate(request.startDate)# and srr_info.constCompleted_dt < #CreateODBCDate(request.endDate1)#
  
</cfquery>

<!--- <cfoutput>
#CreateODBCDate(request.startDate)# 
<br>
#CreateODBCDate(request.endDate1)#
</cfoutput> --->

<cfset request.sidewalk_qty = 0>
<cfset request.driveway_qty = 0>

<cfset request.partial_dwy_conc_qty = 0>
<cfset request.access_ramp_qty = 0>
<cfset request.conc_curb_qty = 0>
<cfset request.curb_cuts_qty = 0>
<cfset request.drains_no = 0>
<cfset request.conc_gutter_qty = 0>

<cfset request.pullbox_no = 0>
<cfset request.signage_no = 0>
<cfset request.st_furn_no = 0>
<cfset request.parking_meter_no = 0>
<cfset request.survey_monument_no = 0>
<cfset request.sidewalk_trans_qty = 0>
<cfset request.catch_basin_lid_qty = 0>
<cfset request.pkwy_drain_qty = 0>

<cfset request.nbr_trees_pruned= 0>
<cfset request.lf_trees_pruned= 0>
<cfset request.nbr_trees_removed= 0>
<cfset request.nbr_stumps_removed= 0>

<cfset request.rebateSum = 0>

<cfloop query="getList">

<!--- sidewalks calcs --->
<cfquery name="getSideWalks" datasource="#request.dsn#" dbtype="datasource">
SELECT 
sidewalk_details.sidewalk_no
, sidewalk_details.ref_no
, ISNULL(sidewalk_details.sidewalk_qty, 0)  sidewalk_qty
, ISNULL(dbo.rebate_rates.sidewalk_uf, 0) sidewalk_uf
, dbo.srr_info.sr_number
, dbo.srr_info.rate_nbr
, dbo.srr_info.srr_id
, sidewalk_details.eligible

FROM  dbo.rebate_rates RIGHT OUTER JOIN
               dbo.srr_info ON dbo.rebate_rates.rate_nbr = dbo.srr_info.rate_nbr RIGHT OUTER JOIN
               Apermits.dbo.sidewalk_details AS sidewalk_details ON dbo.srr_info.a_ref_no = sidewalk_details.ref_no
			   
where srr_info.srr_id = #getList.srr_id#
</cfquery>

<cfloop query="getSideWalks">
<cfset request.sidewalk_qty = #request.sidewalk_qty# + #getSideWalks.sidewalk_qty#>
</cfloop>





<!--- <cfabort> --->


<!-- driveway calcs -->
<cfquery name="getDriveways" datasource="#request.dsn#" dbtype="datasource">
SELECT 
driveway_details.ref_no
, driveway_details.driveway_no
, driveway_details.driveway_case
, ISNULL(driveway_details.driveway_qty, 0) driveway_qty
, driveway_details.eligible
, dbo.srr_info.srr_id
, dbo.srr_info.sr_number
, dbo.rebate_rates.rate_nbr
, dbo.rebate_rates.driveway_uf


FROM  apermits.dbo.driveway_details AS driveway_details LEFT OUTER JOIN
               dbo.srr_info ON driveway_details.ref_no = dbo.srr_info.a_ref_no LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr
			   
where srr_info.srr_id = #getList.srr_id#
</cfquery>

<cfloop query="getDriveWays">
<cfset request.driveway_qty  = #request.driveway_qty# +  #getDriveways.driveway_qty#>
</cfloop>



<!--- Other Items --->
<cfquery name="getOtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, other_items.ref_no
, ISNULL(other_items.partial_dwy_conc_qty, 0) partial_dwy_conc_qty
, ISNULL(other_items.access_ramp_qty, 0) access_ramp_qty
, ISNULL(other_items.conc_curb_qty, 0) conc_curb_qty
, ISNULL(other_items.curb_cuts_qty, 0) curb_cuts_qty
, ISNULL(other_items.drains_no, 0) drains_no
, ISNULL(other_items.conc_gutter_qty, 0) conc_gutter_qty

, partial_dwy_conc_eligible
, access_ramp_eligible
, conc_curb_eligible
, curb_cuts_eligible
, drains_eligible
, conc_gutter_eligible

, srr_info.sr_number
, ISNULL(rebate_rates.conc_curb_uf, 0) conc_curb_uf
, ISNULL(rebate_rates.conc_gutter_uf, 0) conc_gutter_uf
, ISNULL(rebate_rates.curb_cuts_uf, 0)  curb_cuts_uf
, ISNULL(rebate_rates.drains_uf, 0) drains_uf
, ISNULL(rebate_rates.pullbox_uf, 0) pullbox_uf
, ISNULL(rebate_rates.st_furn_uf, 0) st_furn_uf
, ISNULL(rebate_rates.signage_uf, 0) signage_uf
, ISNULL(rebate_rates.parking_meter_uf, 0) parking_meter_uf
, ISNULL(rebate_rates.driveway_uf, 0) driveway_uf
, ISNULL(rebate_rates.access_ramp_uf, 0) access_ramp_uf

FROM  rebate_rates INNER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr RIGHT OUTER JOIN
               apermits.dbo.other_items AS other_items ON srr_info.a_ref_no = other_items.ref_no
where other_items.ref_no = #getList.a_ref_no#
</cfquery>



<cfif #getOtherItems.recordcount# is not 0><!--- 000 --->


<cfset request.partial_dwy_conc_qty = #request.partial_dwy_conc_qty# + #getOtherItems.partial_dwy_conc_qty#>
<cfset request.access_ramp_qty = #request.access_ramp_qty# + #getOtherItems.access_ramp_qty#>
<cfset request.conc_curb_qty = #request.conc_curb_qty# + #getOtherItems.conc_curb_qty#>
<cfset request.curb_cuts_qty = #request.curb_cuts_qty# + #getOtherItems.curb_cuts_qty#>
<cfset request.drains_no = #request.drains_no# + #getOtherItems.drains_no#>
<cfset request.conc_gutter_qty = #request.conc_gutter_qty# + #getOtherItems.conc_gutter_qty#>




</cfif><!--- 000 --->




<!--- SRR Other Items --->
<cfquery name="getSRROtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, ISNULL(dbo.srr_other_items.pullbox_no, 0) pullbox_no
, ISNULL(dbo.rebate_rates.pullbox_uf, 0) pullbox_uf
, ISNULL(dbo.srr_other_items.signage_no, 0) signage_no
, ISNULL(dbo.rebate_rates.signage_uf, 0) signage_uf
, ISNULL(dbo.srr_other_items.st_furn_no, 0) st_furn_no
, ISNULL(dbo.rebate_rates.st_furn_uf, 0) st_furn_uf
, ISNULL(dbo.srr_other_items.parking_meter_no, 0) parking_meter_no
, ISNULL(dbo.rebate_rates.parking_meter_uf, 0) parking_meter_uf
, ISNULL(dbo.srr_other_items.survey_monument_no, 0) survey_monument_no
, ISNULL(survey_monument_uf, 0) survey_monument_uf
, ISNULL(dbo.srr_other_items.sidewalk_trans_qty, 0) sidewalk_trans_qty
, ISNULL(dbo.rebate_rates.sidewalk_trans_uf, 0) sidewalk_trans_uf
, ISNULL(dbo.rebate_rates.catch_basin_lid_uf, 0) catch_basin_lid_uf
, ISNULL(dbo.srr_other_items.catch_basin_lid_qty, 0) catch_basin_lid_qty
, ISNULL(dbo.srr_other_items.pkwy_drain_qty, 0) pkwy_drain_qty
, ISNULL(dbo.rebate_rates.pkwy_drain_uf, 0) pkwy_drain_uf



FROM  dbo.srr_other_items RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_other_items.srr_id = dbo.srr_info.srr_id LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr
			   
where srr_info.srr_id = #getList.srr_id#
</cfquery>

<cfif #getSRROtherItems.recordcount# is not 0><!--- 000 --->


<cfset request.pullbox_no = #request.pullbox_no# + #getSRROtherItems.pullbox_no#>
<cfset request.signage_no = #request.signage_no# + #getSRROtherItems.signage_no#>
<cfset request.st_furn_no = #request.st_furn_no# + #getSRROtherItems.st_furn_no#>
<cfset request.parking_meter_no = #request.parking_meter_no# + #getSRROtherItems.parking_meter_no#>
<cfset request.survey_monument_no = #request.survey_monument_no# + #getSRROtherItems.survey_monument_no#>
<cfset request.sidewalk_trans_qty = #request.sidewalk_trans_qty# + #getSRROtherItems.sidewalk_trans_qty#>
<cfset request.catch_basin_lid_qty = #request.catch_basin_lid_qty# + #getSRROtherItems.catch_basin_lid_qty#>
<cfset request.pkwy_drain_qty = #request.pkwy_drain_qty# + #getSRROtherItems.pkwy_drain_qty#>


</cfif><!--- 000 --->










<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
ISNULL(dbo.tree_info.nbr_trees_pruned, 0) nbr_trees_pruned
, ISNULL(dbo.tree_info.lf_trees_pruned, 0) lf_trees_pruned
, ISNULL(dbo.tree_info.nbr_trees_removed, 0) nbr_trees_removed
, ISNULL(dbo.tree_info.nbr_stumps_removed, 0) nbr_stumps_removed
, dbo.tree_info.srr_id
, dbo.srr_info.sr_number
, dbo.srr_info.srrKey
, ISNULL(dbo.rebate_rates.tree_pruning_uf, 0) tree_pruning_uf
, ISNULL(dbo.rebate_rates.tree_removal_uf, 0) tree_removal_uf
, ISNULL(dbo.rebate_rates.tree_stump_uf, 0) tree_stump_uf
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr RIGHT OUTER JOIN
               dbo.tree_info ON dbo.srr_info.srr_id = dbo.tree_info.srr_id

where srr_info.srrKey = '#getList.srrKey#'
</cfquery>

<Cfif #getTrees.recordcount# is not 0>
<cfset request.nbr_trees_pruned= #request.nbr_trees_pruned# + #getTrees.nbr_trees_pruned#>
<cfset request.lf_trees_pruned= #request.lf_trees_pruned# + #getTrees.lf_trees_pruned#>
<cfset request.nbr_trees_removed= #request.nbr_trees_removed# + #getTrees.nbr_trees_removed#>
<cfset request.nbr_stumps_removed= #request.nbr_stumps_removed# + #getTrees.nbr_stumps_removed#>
</CFIF>


<!--- Adjustments --->
<cfquery name="getAdjustments" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rebateAdjustments.adjustmentID
, rebateAdjustments.srr_id
, ISNULL(rebateAdjustments.sidewalk_sqft, 0) AS sidewalk_sqft
, ISNULL(rebateAdjustments.driveway_sqft, 0) AS driveway_sqft
, ISNULL(rebateAdjustments.sw_trans_panel_sqft, 0) AS sw_trans_panel_sqft
, ISNULL(rebateAdjustments.curb_lf, 0) AS curb_lf
, ISNULL(rebateAdjustments.gutter_lf, 0) AS gutter_lf
, ISNULL(rebateAdjustments.pkwy_drain_lf, 0) AS pkwy_drain_lf
, ISNULL(rebateAdjustments.tree_stump_qty, 0) AS tree_stump_qty
, ISNULL(rebateAdjustments.catchBasin_lid_qty, 0) AS catchBasin_lid_qty
, ISNULL(rebateAdjustments.pullbox_qty, 0) AS pullbox_qty
, ISNULL(rebateAdjustments.trees_pruned_qty, 0) AS trees_pruned_qty
, ISNULL(rebateAdjustments.trees_pruned_lf, 0) AS trees_pruned_lf
, ISNULL(rebateAdjustments.trees_removed_qty, 0) AS trees_removed_qty
, ISNULL(rebateAdjustments.trees_planted_onsite_qty, 0) AS trees_planted_onsite_qty
, ISNULL(rebateAdjustments.trees_planted_offsite_qty, 0) AS trees_planted_offsite_qty
, srr_info.srrKey, srr_info.sr_number

FROM  dbo.rebate_rates RIGHT OUTER JOIN
               dbo.srr_info ON dbo.rebate_rates.rate_nbr = dbo.srr_info.rate_nbr LEFT OUTER JOIN
               dbo.rebateAdjustments ON dbo.srr_info.srr_id = dbo.rebateAdjustments.srr_id
			   
WHERE (dbo.srr_info.srrKey = '#getList.srrKey#')
</cfquery>

<cfif #getAdjustments.recordcount# is not 0>

<cfset request.sidewalk_qty = #request.sidewalk_qty# + #getAdjustments.sidewalk_sqft#>
<cfset request.driveway_qty  = #request.driveway_qty# +  #getAdjustments.driveway_sqft#>


<cfset request.conc_curb_qty = #request.conc_curb_qty# + #getAdjustments.curb_lf#>


<cfset request.conc_gutter_qty = #request.conc_gutter_qty# + #getAdjustments.gutter_lf#>

<cfset request.pullbox_no = #request.pullbox_no# + #getAdjustments.pullbox_qty#>


<cfset request.sidewalk_trans_qty = #request.sidewalk_trans_qty# + #getAdjustments.sw_trans_panel_sqft#>
<cfset request.catch_basin_lid_qty = #request.catch_basin_lid_qty# + #getAdjustments.catchBasin_lid_qty#>
<cfset request.pkwy_drain_qty = #request.pkwy_drain_qty# + #getAdjustments.pkwy_drain_lf#>

<cfset request.nbr_trees_pruned= #request.nbr_trees_pruned# + #getAdjustments.trees_pruned_qty#>
<cfset request.lf_trees_pruned= #request.lf_trees_pruned# + #getAdjustments.trees_pruned_lf#>
<cfset request.nbr_trees_removed= #request.nbr_trees_removed# + #getAdjustments.trees_removed_qty#>
<cfset request.nbr_stumps_removed= #request.nbr_stumps_removed# + #getAdjustments.tree_stump_qty#>

</cfif>

<cfquery name="rebateSum" datasource="#request.dsn#" dbtype="datasource">
SELECT isnull(offer_accepted_amt, 0)+ isnull(offer_paid_amt, 0) as rebateSum
FROM  dbo.srr_info
WHERE (srr_status_cd = 'paymentPending') OR
               (srr_status_cd = 'constCompleted')
			   
and srr_id = #getList.srr_id#
			  
</cfquery>

<cfset request.rebateSum = #request.rebateSum# + #rebateSum.rebateSum#>


</cfloop><!--- getList --->



<cfoutput>
<!--- <div style="text-align:center;"> --->
<div align="center">

<table border="1" align="center" class="datatable" style="width:65%">
<tr>
	<th style="vertical-align:top;">Item</th>
	<th style="vertical-align:top;">Quantity</th>
	<th style="vertical-align:top;">Unit</th>
</tr>

<tr>
	<td style="vertical-align:top;"><strong>Number of properties<br>where construction is completed</strong></td>
	<td style="vertical-align:top;"><strong>#getList.recordcount#</strong></td>
	<td style="vertical-align:top;"><strong>properties</strong></td>
</tr>
<tr>
	<td style="vertical-align:top;"><strong>Sidewalks Replaced</strong></td>
	<td style="vertical-align:top;"><strong>#NumberFormat(request.sidewalk_qty)#</strong></td>
	<td style="vertical-align:top;"><strong>sq. ft.</strong></td>
</tr>
<tr>
	<td style="vertical-align:top;">Driveway Repairs</td>
	<td style="vertical-align:top;">#NumberFormat(request.driveway_qty)#</td>
	<td style="vertical-align:top;">sq. ft.</td>
</tr>
<tr>
	<td style="vertical-align:top;">Partial Driveway Repairs</td>
	<td style="vertical-align:top;">#NumberFormat(request.partial_dwy_conc_qty)#</td>
	<td style="vertical-align:top;">sq. ft.</td>
</tr>

<tr>
	<td style="vertical-align:top;">Sidewalk Transitional Panel(s)</td>
	<td style="vertical-align:top;"> #NumberFormat(request.sidewalk_trans_qty)#</td>
	<td style="vertical-align:top;">sq. ft.</td>
</tr>




<tr>
	<td style="vertical-align:top;">Access Ramps</td>
	<td style="vertical-align:top;">#request.access_ramp_qty#</td>
	<td style="vertical-align:top;">each</td>
</tr>

<!--- <tr>
	<td style="vertical-align:top;">Curb Cuts</td>
	<td style="vertical-align:top;">#request.curb_cuts_qty#</td>
	<td style="vertical-align:top;">LF</td>
</tr> --->


<tr>
	<td style="vertical-align:top;">Concrete Curb</td>
	<td style="vertical-align:top;">#NumberFormat(request.conc_curb_qty)#</td>
	<td style="vertical-align:top;">LF</td>
</tr>

<tr>
	<td style="vertical-align:top;">Concrete Gutter</td>
	<td style="vertical-align:top;">#NumberFormat(request.conc_gutter_qty)#</td>
	<td style="vertical-align:top;">LF</td>
</tr>

<!--- <tr>
	<td style="vertical-align:top;">Drains</td>
	<td style="vertical-align:top;">#request.drains_no#</td>
	<td style="vertical-align:top;"></td>
</tr> --->

<tr>
	<td style="vertical-align:top;">Parkway Drain(s)</td>
	<td style="vertical-align:top;">#NumberFormat(request.pkwy_drain_qty)#</td>
	<td style="vertical-align:top;">LF</td>
</tr>
<tr>
	<td style="vertical-align:top;">Pullbox(es)</td>
	<td style="vertical-align:top;">#request.pullbox_no#</td>
	<td style="vertical-align:top;">Each</td>
</tr>
<tr>
	<td style="vertical-align:top;">Sign(s)</td>
	<td style="vertical-align:top;">#request.signage_no#</td>
	<td style="vertical-align:top;">Each</td>
</tr>
<tr>
	<td style="vertical-align:top;">Street Furniture</td>
	<td style="vertical-align:top;">#request.st_furn_no#</td>
	<td style="vertical-align:top;">Each</td>
</tr>
<tr>
	<td style="vertical-align:top;">Parking meter(s) </td>
	<td style="vertical-align:top;">#request.parking_meter_no#</td>
	<td style="vertical-align:top;">Each</td>
</tr>
<tr>
	<td style="vertical-align:top;">Survey monument(s) </td>
	<td style="vertical-align:top;">#request.survey_monument_no#</td>
	<td style="vertical-align:top;">Each</td>
</tr>
<tr>
	<td style="vertical-align:top;">Catch basin lid(s)</td>
	<td style="vertical-align:top;">#request.catch_basin_lid_qty#</td>
	<td style="vertical-align:top;">Each</td>
</tr>

<tr>
	<td style="vertical-align:top;">Number of Trees Pruned</td>
	<td style="vertical-align:top;">#request.nbr_trees_pruned#</td>
	<td style="vertical-align:top;">Each</td>
</tr>

<tr>
	<td style="vertical-align:top;">Lineal Feet of Tree Root Pruning</td>
	<td style="vertical-align:top;">#request.lf_trees_pruned#</td>
	<td style="vertical-align:top;">LF</td>
</tr>

<tr>
	<td style="vertical-align:top;">No. of Trees (Removed & Replaced)</td>
	<td style="vertical-align:top;">#request.nbr_trees_removed#</td>
	<td style="vertical-align:top;">Each</td>
</tr>

<tr>
	<td style="vertical-align:top;">Tree Stumps Removed</td>
	<td style="vertical-align:top;">#request.nbr_stumps_removed#</td>
	<td style="vertical-align:top;">Each</td>
</tr>

<tr>
	<td style="vertical-align:top;"><strong>Total Rebate</strong></td>
	<td style="vertical-align:top;"><strong>$#NumberFormat(request.rebateSum)#</strong></td>
	<td style="vertical-align:top;">&nbsp;</td>
</tr>

<cfif #getList.recordcount# gt 0>
<cfset request.avg = #request.rebateSum# / #getList.recordcount#>
</cfif>
<tr>
	<td style="vertical-align:top;"><strong>Average Rebate per Property</strong></td>
	<td style="vertical-align:top;"><strong><cfif #getList.recordcount# gt 0>$#NumberFormat(request.avg)#</cfif></strong></td>
	<td style="vertical-align:top;">&nbsp;</td>
</tr>
</table>
<!--- </div> --->

</div>

</cfoutput>


