<!--- rate_nbr ready --->
<!--- <cfparam name="attributes.srrKey" default=""> --->


<cfinclude template="../common/validate_srrKey.cfm">



<cfset request.calc_rebate_total = 0>
<cfset request.rebateTotal = 0>

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

<cfif #getSideWalks.recordcount# gt 0>
<cfloop query="getSideWalks">
<cfif #getSideWalks.eligible# is "Y">
<cfset request.sidewalk_rebate = #getSideWalks.sidewalk_qty# * #getSideWalks.sidewalk_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_rebate#>
</cfif>
</cfloop>
</cfif>


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

<cfif #getDriveways.recordcount# gt 0>
<cfloop query="getDriveWays">
<cfif #getDriveways.eligible# is "Y">
<cfset request.driveway_rebate  = #getDriveways.driveway_qty# * #getDriveways.driveway_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.driveway_rebate#>
</cfif>
</cfloop>
</cfif>



<!--- Other Items --->
<!--- <cfif #request.a_ref_no# is not ""> ---><!--- 111 --->

<cfquery name="getOptItems" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_id   
      ,ISNULL(conc_curb_qty_opt , 0) conc_curb_qty_opt
      ,ISNULL(conc_gutter_qty_opt , 0) conc_gutter_qty_opt
      ,ISNULL(access_ramp_qty_opt , 0) access_ramp_qty_opt
      ,ISNULL(partial_dwy_conc_qty_opt , 0) partial_dwy_conc_qty_opt
  FROM srr.dbo.srr_other_items
 where srr_id = #request.srr_id#
 </cfquery>

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
where other_items.ref_no = #request.a_ref_no#
</cfquery>


<cfif #getOtherItems.recordcount# is not 0 and #getOptItems.recordcount# is not 0><!--- 1 --->
 <Cfset eligibleItems.partial_dwy_conc_qty = #getOtherItems.partial_dwy_conc_qty# - #getOptItems.partial_dwy_conc_qty_opt#>
 <cfif #eligibleItems.partial_dwy_conc_qty# lt 0>
 <cfset eligibleItems.partial_dwy_conc_qty = 0>
 </cfif>
 
<Cfset eligibleItems.access_ramp_qty =  #getOtherItems.access_ramp_qty# - #getOptItems.access_ramp_qty_opt#>
 <cfif #eligibleItems.access_ramp_qty# lt 0>
 <cfset eligibleItems.access_ramp_qty = 0>
 </cfif>
 
 
 
<Cfset eligibleItems.conc_curb_qty =  #getOtherItems.conc_curb_qty# - #getOptItems.conc_curb_qty_opt#>
 <cfif #eligibleItems.conc_curb_qty# lt 0>
 <cfset eligibleItems.conc_curb_qty = 0>
 </cfif>
 
 
<Cfset eligibleItems.conc_gutter_qty =  #getOtherItems.conc_gutter_qty# - #getOptItems.conc_gutter_qty_opt#>
<cfif #eligibleItems.conc_gutter_qty# lt 0>
 <cfset eligibleItems.conc_gutter_qty = 0>
 </cfif>

 <cfelseif #getOtherItems.recordcount# is 0 and #getOptItems.recordcount# is not 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = 0>
<cfset eligibleItems.access_ramp_qty = 0>
<cfset eligibleItems.conc_curb_qty = 0>
<cfset eligibleItems.conc_gutter_qty = 0>


 <cfelseif #getOtherItems.recordcount#  is 0 and #getOptItems.recordcount# is 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = 0>
<cfset eligibleItems.access_ramp_qty = 0>
<cfset eligibleItems.conc_curb_qty = 0>
<cfset eligibleItems.conc_gutter_qty = 0>

 <cfelseif #getOtherItems.recordcount# is not 0 and #getOptItems.recordcount# is 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = #getOtherItems.partial_dwy_conc_qty#>
<cfset eligibleItems.access_ramp_qty = #getOtherItems.access_ramp_qty#>
<cfset eligibleItems.conc_curb_qty = #getOtherItems.conc_curb_qty#>
<cfset eligibleItems.conc_gutter_qty = #getOtherItems.conc_gutter_qty#>
   
 </cfif><!--- 1 --->




<!--- <cfif #getOtherItems.recordcount# gt 0> ---><!--- 000 --->

<Cfif #eligibleItems.partial_dwy_conc_qty# is not 0>
<cfset request.partial_dwy_conc_rebate = #eligibleItems.partial_dwy_conc_qty# * #getOtherItems.driveway_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.partial_dwy_conc_rebate#>
</CFIF>

<Cfif #eligibleItems.access_ramp_qty# is not 0>
<cfset request.access_ramp_rebate = #eligibleItems.access_ramp_qty# * #getOtherItems.access_ramp_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.access_ramp_rebate#>
</CFIF>



<Cfif #eligibleItems.conc_curb_qty# is not 0>
<cfset request.conc_curb_rebate = #eligibleItems.conc_curb_qty# * #getOtherItems.conc_curb_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_curb_rebate#>
</CFIF>

<Cfif #eligibleItems.conc_gutter_qty# is not 0>
<cfset request.conc_gutter_rebate = #eligibleItems.conc_gutter_qty# * #getOtherItems.conc_gutter_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_gutter_rebate#>
</CFIF>


<Cfif #getOtherItems.drains_no# is not 0>
<cfset request.drains_rebate = #getOtherItems.drains_no# * #getOtherItems.drains_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.drains_rebate#>
</CFIF>

<!--- </cfif> ---><!--- 000 --->

<!--- </cfif> --->

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
			   
where srr_info.srr_id = #request.srr_id#
</cfquery>


<Cfif #getSRROtherItems.pullbox_no# gt 0>
<cfset request.pullbox_rebate = #getSRROtherItems.pullbox_no# * #getSRROtherItems.pullbox_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pullbox_rebate#>
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


<Cfif #getTrees.recordcount# gt 0>

<cfif #getTrees.lf_trees_pruned# is not 0>
<cfset request.tree_pruning_rebate = #getTrees.lf_trees_pruned# * #getTrees.tree_pruning_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_pruning_rebate#>
</cfif>

<cfif #getTrees.nbr_trees_removed# is not 0>
<cfset request.tree_removal_rebate = #getTrees.nbr_trees_removed# * #getTrees.tree_removal_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_removal_rebate#>
</cfif>

<cfif #getTrees.nbr_stumps_removed# is not 0>
<cfset request.tree_stump_rebate = #getTrees.nbr_stumps_removed# * #getTrees.tree_stump_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_stump_rebate#>
</cfif>


</CFIF>

<!--- <cfoutput>
Total Rebate Before Adjustments = #request.calc_rebate_total#
</cfoutput>
<cfabort> --->

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
			   
WHERE (dbo.srr_info.srrKey = '#attributes.srrKey#')
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


<!--- adding valuation estimate to database --->
<cfset request.valuation_est = #request.calc_rebate_total#>

<cfquery name="updateValuationEst" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
set
valuation_est = #request.valuation_est#
where
srrKey = '#attributes.srrKey#'
</cfquery>
<!--- adding valuation estimate to database --->




<cfquery name="getPropType" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.prop_type
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

FROM  srr_info LEFT OUTER JOIN
               rebate_rates ON srr_info.rate_nbr = rebate_rates.rate_nbr
			   
where srrKey = '#attributes.srrKey#'
</cfquery>

<!--- <cfdump var="#getPropType#" output="browser"> --->



<cfif #getPropType.prop_type# is "r">
<cfif #request.calc_rebate_total# gt #getPropType.res_cap_amt#>
<cfset request.rebateTotal = #getPropType.res_cap_amt#>
<cfelse>
<Cfset request.rebateTotal = #request.calc_rebate_total#>
</cfif>

<cfelseif #getPropType.prop_type# is "c" Or #getPropType.prop_type# is "">

<cfif #request.calc_rebate_total# gt #getPropType.comm_cap_amt#>
<cfset request.rebateTotal = #getPropType.comm_cap_amt#>
<cfelse>
<Cfset request.rebateTotal = #request.calc_rebate_total#>
</cfif>
</cfif>

<cfif #request.rebateTotal# is "">
<cfset request.rebateTotal = 0>
</cfif>


<cfif #request.status_cd# is "requiredPermitsSubmitted" 
OR 
#request.status_cd# is "requiredPermitsNotSubmitted" 
OR
#request.status_cd# is "offerAccepted" 
OR 
#request.status_cd# is "requiredPermitsIssued" 
OR 
#request.status_cd# is "constCompleted">
<cfquery name="updateSrrInfo" datasource="#request.dsn#" dbtype="datasource">
Update srr_info

set 

  offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #request.rebateTotal#
, offer_paid_amt = 0

where srrKey = '#attributes.srrKey#'
</cfquery>
</cfif>

<cfif #request.status_cd# is "offerMade">
<cfquery name="updateSrrInfo" datasource="#request.dsn#" dbtype="datasource">
Update srr_info

set 
offer_reserved_amt = 0
, offer_open_amt = #request.rebateTotal#
, offer_accepted_amt = 0
, offer_paid_amt = 0


where srrKey = '#attributes.srrKey#'
</cfquery>
</cfif>




<!--- <cfoutput>
<div align="center">Calculated Rebate= #request.rebateTotal#</div>
</cfoutput> --->

