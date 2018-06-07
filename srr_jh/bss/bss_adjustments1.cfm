<cfinclude template="../common/validate_srrKey.cfm">

<!--- add record into rebateAdjustments if it does not exist --->
<cfquery name="checkAdjustments" datasource="#request.dsn#" dbtype="datasource">
Select srr_id 
from 
rebateAdjustments
where srr_id = #request.srr_id#
</cfquery>

<cfif #checkAdjustments.recordcount# is 0>
<cfquery name="addAdjustment" datasource="#request.dsn#" dbtype="datasource">
insert into 
rebateAdjustments
(srr_id)
values
(
#request.srr_id#
)
</cfquery>
</cfif>
<!--- add record into rebateAdjustments if it does not exist --->

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

, rebate_rates.sidewalk_uf, rebate_rates.driveway_uf
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


<cfoutput>
<form action="control.cfm?action=bss_Adjustments2" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:550px;">
<!--- <div class="divSubTitle">Adjustments</div> --->
<h1>Rebate Adjustments</h1>

<div align="center">
<table style="width:95%;" class="datatable" border ="1">
<tr>
	<th>Item</th>
	<th>Qty</th>
	<th>Unit</th>
</tr>


<tr>
	<td>Number of trees to be root pruned</td>
	<td><input type="number" name="trees_pruned_qty" id="trees_pruned_qty" size="10" placeholder="#NumberFormat(getAdjustments.trees_pruned_qty)#" <cfif #getAdjustments.trees_pruned_qty# is not  0>value="#NumberFormat(getadjustments.trees_pruned_qty)#"</cfif> step="any"></td>
	<td align="center">Each</td>
</tr>

<tr>
	<td>Linear footage of root pruning</td>
	<td><input type="number" name="trees_pruned_lf" id="trees_pruned_lf" size="10" placeholder="#decimalformat(getAdjustments.trees_pruned_lf)#" <cfif #getAdjustments.trees_pruned_lf# is not  0>value="#decimalformat(getadjustments.trees_pruned_lf)#"</cfif> step="any"></td>
	<td align="center">LF</td>
</tr>


<tr>
	<td>Number of trees to be removed</td>
	<td><input type="number" name="trees_removed_qty" id="trees_removed_qty" size="10" placeholder="#NumberFormat(getAdjustments.trees_removed_qty)#" <cfif #getAdjustments.trees_removed_qty# is not  0>value="#NumberFormat(getadjustments.trees_removed_qty)#"</cfif> step="any"></td>
	<td align="center">Each</td>
</tr>

<tr>
	<td>Number of trees stumps to be removed</td>
	<td><input type="number" name="tree_stump_qty" id="tree_stump_qty" size="10" placeholder="#NumberFormat(getAdjustments.tree_stump_qty)#" <cfif #getAdjustments.tree_stump_qty# is not  0>value="#NumberFormat(getadjustments.tree_stump_qty)#"</cfif> step="any"></td>
	<td align="center">Each</td>
</tr>

<tr>
	<td>Number of trees to be planted onsite</td>
	<td><input type="number" name="trees_planted_onsite_qty" id="trees_planted_onsite_qty" size="10" placeholder="#NumberFormat(getAdjustments.trees_planted_onsite_qty)#" <cfif #getAdjustments.trees_planted_onsite_qty# is not  0>value="#NumberFormat(getadjustments.trees_planted_onsite_qty)#"</cfif> step="any"></td>
	<td align="center">Each</td>
</tr>



<tr>
	<td>Number of trees to be planted offsite</td>
	<td><input type="number" name="trees_planted_offsite_qty" id="trees_planted_offsite_qty" size="10" placeholder="#NumberFormat(getAdjustments.trees_planted_offsite_qty)#" <cfif #getAdjustments.trees_planted_offsite_qty# is not  0>value="#NumberFormat(getadjustments.trees_planted_offsite_qty)#"</cfif> step="any"></td>
	<td align="center">Each</td>
</tr>



<tr>
	<td colspan="3">BSS/UFD Comments:<br>
	
	<textarea name="bss_comments" id="bss_comments" style="width:98%;height:65px;margin-top:5px;" placeholder="Type your comments here ..."></textarea>
	</td>

</tr>



</table>
</div>
</div>

<BR>
<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>


</form>
<br>

</cfoutput>
<!--- <cfinclude template="footer.cfm"> --->