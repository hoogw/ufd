<!--- <cfparam name="attributes.srrKey" default=""> --->
<cfinclude template="/srr/common/validate_srrKey.cfm">

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


<!--- A-Permit Other Items --->
<cfquery name="getOtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, other_items.ref_no
, ISNULL(other_items.partial_dwy_conc_qty, 0) partial_dwy_conc_qty
, ISNULL(other_items.access_ramp_qty, 0) access_ramp_qty
, ISNULL(other_items.conc_curb_qty, 0) conc_curb_qty
, ISNULL(other_items.conc_gutter_qty, 0) conc_gutter_qty
<!--- , ISNULL(other_items.curb_cuts_qty, 0) curb_cuts_qty --->
<!--- , ISNULL(other_items.drains_no, 0) drains_no --->


, partial_dwy_conc_eligible
, access_ramp_eligible
, conc_curb_eligible
, conc_gutter_eligible
<!--- , curb_cuts_eligible --->
<!--- , drains_eligible --->


, srr_info.sr_number
, ISNULL(rebate_rates.conc_curb_uf, 0) conc_curb_uf
, ISNULL(rebate_rates.conc_gutter_uf, 0) conc_gutter_uf
<!--- , ISNULL(rebate_rates.curb_cuts_uf, 0)  curb_cuts_uf --->
<!--- , ISNULL(rebate_rates.drains_uf, 0) drains_uf --->
<!--- , ISNULL(rebate_rates.pullbox_uf, 0) pullbox_uf --->
<!--- , ISNULL(rebate_rates.st_furn_uf, 0) st_furn_uf
, ISNULL(rebate_rates.signage_uf, 0) signage_uf
, ISNULL(rebate_rates.parking_meter_uf, 0) parking_meter_uf --->
, ISNULL(rebate_rates.driveway_uf, 0) driveway_uf
, ISNULL(rebate_rates.access_ramp_uf, 0) access_ramp_uf

<!--- , ISNULL(rebate_rates.sidewalk_trans_uf, 0) sidewalk_trans_uf
, ISNULL(rebate_rates.catch_basin_lid_uf, 0) catch_basin_lid_uf
, ISNULL(rebate_rates.tree_stump_uf, 0) tree_stump_uf --->


FROM  rebate_rates INNER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr RIGHT OUTER JOIN
               apermits.dbo.other_items AS other_items ON srr_info.a_ref_no = other_items.ref_no
where other_items.ref_no = #request.a_ref_no#
</cfquery>

<cfif #getOtherItems.recordcount# is not 0><!--- 1 --->

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

</cfif><!--- 1 --->

<!--- <Cfif #getOtherItems.drains_no# is not 0>
<cfset request.drains_rebate = #getOtherItems.drains_no# * #getOtherItems.drains_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.drains_rebate#>
</CFIF>
 --->

<!--- A-Permit Other Items --->
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
			   
where srr_info.srr_id = #request.srr_id#
</cfquery>


<cfif #getSRROtherItems.recordcount# is not 0><!--- 2 --->

<Cfif #getSRROtherItems.pullbox_no# is not 0>
<cfset request.pullbox_rebate = #getSRROtherItems.pullbox_no# * #getSRROtherItems.pullbox_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pullbox_rebate#>
</CFIF>

<Cfif #getSRROtherItems.signage_no# is not 0>
<cfset request.signage_rebate = #getSRROtherItems.signage_no# * #getSRROtherItems.signage_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.signage_rebate#>
</CFIF>

<Cfif #getSRROtherItems.st_furn_no# is not 0>
<cfset request.st_furn_rebate = #getSRROtherItems.st_furn_no# * #getSRROtherItems.st_furn_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.st_furn_rebate#>
</CFIF>


<Cfif #getSRROtherItems.parking_meter_no# is not 0>
<cfset request.parking_meter_rebate = #getSRROtherItems.parking_meter_no# * #getSRROtherItems.parking_meter_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.parking_meter_rebate#>
</CFIF>

<Cfif #getSRROtherItems.survey_monument_no# is not 0>
<cfset request.survey_monument_rebate = #getSRROtherItems.survey_monument_no# * #getSRROtherItems.survey_monument_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.survey_monument_rebate#>
</CFIF>


<Cfif #getSRROtherItems.sidewalk_trans_qty# is not 0>
<cfset request.sidewalk_trans_rebate = #getSRROtherItems.sidewalk_trans_qty# * #getSRROtherItems.sidewalk_trans_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_trans_rebate#>
</CFIF>


<Cfif #getSRROtherItems.catch_basin_lid_qty# is not 0>
<cfset request.catch_basin_lid_rebate = #getSRROtherItems.catch_basin_lid_qty# * #getSRROtherItems.catch_basin_lid_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.catch_basin_lid_rebate#>
</CFIF>


<Cfif #getSRROtherItems.pkwy_drain_qty# is not 0>
<cfset request.pkwy_drain_rebate = #getSRROtherItems.pkwy_drain_qty# * #getSRROtherItems.pkwy_drain_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pkwy_drain_rebate#>
</CFIF>

</cfif><!--- 2 --->



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

<cfif #getTrees.nbr_stumps_removed# is not 0>
<cfset request.stump_removal_rebate = #getTrees.nbr_stumps_removed# * #getTrees.tree_stump_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.stump_removal_rebate#>
</cfif>

</CFIF>



<cfquery name="getPropType" datasource="#request.dsn#" dbtype="datasource">
Select prop_type from srr_info
where srrKey = '#attributes.srrKey#'
</cfquery>

<!--- <cfdump var="#getPropType#" output="browser"> --->



<cfif #getPropType.prop_type# is "r"  or #getPropType.prop_type# is "">
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

<!--- <cfoutput>
<div align="center">Calculated Rebate= #request.rebateTotal#</div>
</cfoutput> --->

