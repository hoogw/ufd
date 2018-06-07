<cfabort>

<cfparam name="attributes.srrKey" default="">
<cfinclude template="validate_srrKey.cfm">

<cfset request.calc_rebate_total = 0>

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
			   
where srr_info.srrKey = '#attributes.srrKey#'
</cfquery>

<cfloop query="getSideWalks">
<cfset request.sidewalk_rebate = #getSideWalks.sidewalk_qty# * #getSideWalks.sidewalk_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_rebate#>
</cfloop>

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
			   
where srr_info.srrKey = '#attributes.srrKey#'
</cfquery>

<cfloop query="getDriveWays">
<cfset request.driveway_rebate  = #getDriveways.driveway_qty# * #getDriveways.driveway_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.driveway_rebate#>
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
, ISNULL(rebate_rates.pullbox_vault_uf, 0) pullbox_vault_uf
, ISNULL(rebate_rates.street_furn_uf, 0) street_furn_uf
, ISNULL(rebate_rates.signage_uf, 0) signage_uf
, ISNULL(rebate_rates.parking_meter_uf, 0) parking_meter_uf
, ISNULL(rebate_rates.driveway_uf, 0) driveway_uf
, ISNULL(rebate_rates.access_ramp_uf, 0) access_ramp_uf

FROM  rebate_rates INNER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr RIGHT OUTER JOIN
               apermits.dbo.other_items AS other_items ON srr_info.a_ref_no = other_items.ref_no
where other_items.ref_no = #request.a_ref_no#
</cfquery>


<Cfif #getOtherItems.partial_dwy_conc_qty# is not 0>
<cfset request.partial_dwy_conc_rebate = #getOtherItems.partial_dwy_conc_qty# * #getOtherItems.driveway_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.partial_dwy_conc_rebate#>
</CFIF>

<Cfif #getOtherItems.access_ramp_qty# is not 0>
<cfset request.access_ramp_rebate = #getOtherItems.access_ramp_qty# * #getOtherItems.access_ramp_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.access_ramp_rebate#>
</CFIF>



<Cfif #getOtherItems.conc_curb_qty# is not 0>
<cfset request.conc_curb_rebate = #getOtherItems.conc_curb_qty# * #getOtherItems.conc_curb_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_curb_rebate#>
</CFIF>

<Cfif #getOtherItems.conc_gutter_qty# is not 0>
<cfset request.conc_gutter_rebate = #getOtherItems.conc_gutter_qty# * #getOtherItems.conc_gutter_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_gutter_rebate#>
</CFIF>


<Cfif #getOtherItems.drains_no# is not 0>
<cfset request.drains_rebate = #getOtherItems.drains_no# * #getOtherItems.drains_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.drains_rebate#>
</CFIF>


<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
ISNULL(dbo.tree_info.nbr_trees_pruned, 0) nbr_trees_pruned
, ISNULL(dbo.tree_info.lf_trees_pruned, 0) lf_trees_pruned
, ISNULL(dbo.tree_info.nbr_trees_removed, 0) nbr_trees_removed
, dbo.tree_info.srr_id
, dbo.srr_info.sr_number
, dbo.srr_info.srrKey
, ISNULL(dbo.rebate_rates.tree_pruning_uf, 0) tree_pruning_uf

, ISNULL(dbo.rebate_rates.tree_removal_uf, 0) tree_removal_uf
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr RIGHT OUTER JOIN
               dbo.tree_info ON dbo.srr_info.srr_id = dbo.tree_info.srr_id

where srr_info.srrKey = '#attributes.srrKey#'
</cfquery>

<Cfif #getTrees.recordcount# is not 0>

<cfif #getTrees.lf_trees_pruned# is not 0>
<cfset request.tree_pruning_rebate = #getTrees.lf_trees_pruned# * #getTrees.tree_pruning_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_pruning_rebate#>
</cfif>

<cfif #getTrees.nbr_trees_removed# is not 0>
<cfset request.tree_removal_rebate = #getTrees.nbr_trees_removed# * #getTrees.tree_removal_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_removal_rebate#>
</cfif>

</CFIF>




<!--- Handling Adjustments --->
<cfset request.TotalAdjustments = 0>
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

, rebate_rates.sidewalk_uf
, rebate_rates.driveway_uf
, rebate_rates.conc_curb_uf
, rebate_rates.conc_gutter_uf
, rebate_rates.curb_cuts_uf
, rebate_rates.drains_uf
, rebate_rates.pullbox_uf
, rebate_rates.signage_uf
, rebate_rates.st_furn_uf
, rebate_rates.parking_meter_uf
, rebate_rates.access_ramp_uf
, rebate_rates.tree_pruning_uf
, rebate_rates.tree_removal_uf
, rebate_rates.pkwy_drain_uf
, rebate_rates.sidewalk_trans_uf
, rebate_rates.catch_basin_lid_uf
, rebate_rates.tree_stump_uf
, rebate_rates.survey_monument_uf

FROM  dbo.rebate_rates RIGHT OUTER JOIN
               dbo.srr_info ON dbo.rebate_rates.rate_nbr = dbo.srr_info.rate_nbr LEFT OUTER JOIN
               dbo.rebateAdjustments ON dbo.srr_info.srr_id = dbo.rebateAdjustments.srr_id
			   
WHERE (dbo.srr_info.srrKey = '#request.srrKey#')
</cfquery>

<cfif 
#getAdjustments.sidewalk_sqft# is not 0 
OR #getAdjustments.driveway_sqft# is not 0 
OR #getAdjustments.sw_trans_panel_sqft# is not 0 
OR #getAdjustments.curb_lf# is not 0 
OR #getAdjustments.gutter_lf# is not 0 
OR #getAdjustments.pkwy_drain_lf# is not 0  
OR #getAdjustments.tree_stump_qty# is not 0 
OR #getAdjustments.catchBasin_lid_qty# is not 0 
OR #getAdjustments.pullbox_qty# is not 0 
OR #getAdjustments.trees_pruned_lf# is not 0 
OR #getAdjustments.trees_removed_qty# is not 0 
>
<!--- display and calculate Rebate Adjustments --->


<cfif #getAdjustments.sidewalk_sqft# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.sidewalk_sqft# * #getAdjustments.sidewalk_uf#>
</cfif>


<cfif #getAdjustments.driveway_sqft# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.driveway_sqft# * #getAdjustments.driveway_uf#>
</cfif>

<cfif #getAdjustments.sw_trans_panel_sqft# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.sw_trans_panel_sqft# * #getAdjustments.sidewalk_trans_uf#>
</cfif>


<cfif #getAdjustments.curb_lf# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.curb_lf# * #getAdjustments.conc_curb_uf#>
</cfif>


<cfif #getAdjustments.gutter_lf# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.gutter_lf# * #getAdjustments.conc_gutter_uf#>
</cfif>

<cfif #getAdjustments.pkwy_drain_lf# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.pkwy_drain_lf# * #getAdjustments.pkwy_drain_uf#>
</cfif>


<cfif #getAdjustments.catchbasin_lid_qty# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.catchbasin_lid_qty# * #getAdjustments.catch_basin_lid_uf#>
</cfif>

<cfif #getAdjustments.pullbox_qty# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.pullbox_qty# * #getAdjustments.pullbox_uf#>
</cfif>

<cfif #getAdjustments.tree_stump_qty# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.tree_stump_qty# * #getAdjustments.tree_stump_uf#>
</cfif>

<cfif #getAdjustments.trees_pruned_lf# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.trees_pruned_lf# * #getAdjustments.tree_pruning_uf#>
</cfif>

<cfif #getAdjustments.trees_removed_qty# is not 0>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.trees_removed_qty# * #getAdjustments.tree_removal_uf#>
</cfif>

</cfif>

<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.TotalAdjustments#>
<!--- Handling Adjustments --->









<cfquery name="getPropType" datasource="#request.dsn#" dbtype="datasource">
Select prop_type from srr_info
where srrKey = '#attributes.srrKey#'
</cfquery>

<!--- <cfdump var="#getPropType#" output="browser"> --->



<cfif #getPropType.prop_type# is "r">
<cfif #request.calc_rebate_total# gt 2000>
<cfset request.rebateTotal = 2000>
<cfelse>
<Cfset request.rebateTotal = #request.calc_rebate_total#>
</cfif>

<cfelseif #getPropType.prop_type# is "c">

<cfif #request.calc_rebate_total# gt 4000>
<cfset request.rebateTotal = 4000>
<cfelse>
<Cfset request.rebateTotal = #request.calc_rebate_total#>
</cfif>
</cfif>

<cfif #request.rebateTotal# is "">
<cfset request.rebateTotal = 0>
</cfif>


<cfif #request.status_cd# is 'requiredPermitsSubmitted' 
#request.status_cd# is 'requiredPermitsNotSubmitted' 
#request.status_cd# is 'offerAccepted' 
#request.status_cd# is 'requiredPermitsIssued' 
#request.status_cd# is 'constCompleted'>
<cfquery name="updateSrrInfo" datasource="#request.dsn#" dbtype="datasource">
Update srr_info

set 

offer_accepted_amt = #request.rebateTotal#

where srrKey = '#request.srrKey#'
</cfquery>
</cfif>

<cfif #request.status_cd# is 'offerMade'>
<cfquery name="updateSrrInfo" datasource="#request.dsn#" dbtype="datasource">
Update srr_info

set 

offer_open_amt = #request.rebateTotal#

where srrKey = '#attributes.srrKey#'
</cfquery>
</cfif>




<!--- <cfoutput>
<div align="center">Calculated Rebate= #request.rebateTotal#</div>
</cfoutput> --->

