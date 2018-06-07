<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">



<cfinclude template="navbar2.cfm">


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



<!--- <cfdump var="#getAdjustments#"> --->

<cfoutput>
<form action="bca_Adjustments2.cfm" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<div class="divSubTitle">Rebate Adjustments</div>


<div align="center">
<table style="width:95%;" class="datatable" border ="1">
<tr>
	<th>Item(s)</th>
	<th>Qty</th>
	<th>Unit</th>
</tr>


<tr>
	<td>Sidewalks</td>
	<td><input type="number" name="sidewalk_sqft" id="sidewalk_sqft" size="10"  placeholder="#decimalformat(getAdjustments.sidewalk_sqft)#" <cfif #getAdjustments.sidewalk_sqft# is not  0>value="#decimalformat(getadjustments.sidewalk_sqft)#"</cfif> step="any"></td>
	<td align="center">SQ. FT.</td>
</tr>

<tr>
	<td>Driveways</td>
	<td><input type="number" name="driveway_sqft" id="driveway_sqft" size="10"  placeholder="#decimalformat(getAdjustments.driveway_sqft)#" <cfif #getAdjustments.driveway_sqft# is not  0>value="#decimalformat(getadjustments.driveway_sqft)#"</cfif> step="any"></td>
	<td align="center">SQ. FT.</td>
</tr>


<tr>
	<td>Sw Tansitional Panel</td>
	<td><input type="number" name="sw_trans_panel_sqft" id="sw_trans_panel_sqft" size="10"  placeholder="#decimalformat(getAdjustments.sw_trans_panel_sqft)#" <cfif #getAdjustments.sw_trans_panel_sqft# is not  0>value="#decimalformat(getadjustments.sw_trans_panel_sqft)#"</cfif> step="any"></td>
	<td align="center">SQ. FT.</td>
</tr>

<tr>
	<td>Curb</td>
	<td><input type="number" name="curb_lf" id="curb_lf" size="10"   placeholder="#decimalformat(getAdjustments.curb_lf)#" <cfif #getAdjustments.curb_lf# is not  0>value="#decimalformat(getadjustments.curb_lf)#"</cfif> step="any"></td>
	<td align="center">LF</td>
</tr>

<tr>
	<td>Gutter</td>
	<td><input type="number" name="gutter_lf" id="gutter_lf" size="10" placeholder="#decimalformat(getadjustments.gutter_lf)#"   <cfif #getAdjustments.gutter_lf# is not  0>value="#decimalformat(getadjustments.gutter_lf)#"</cfif> step="any"></td>
	<td align="center">LF</td>
</tr>



<tr>
	<td>Pkwy Drain</td>
	<td><input type="number" name="pkwy_drain_lf" id="pkwy_drain_lf" size="10" placeholder="#decimalformat(getAdjustments.pkwy_drain_lf)#"   <cfif #getAdjustments.pkwy_drain_lf# is not  0>value="#decimalformat(getadjustments.pkwy_drain_lf)#"</cfif> step="any"></td>
	<td align="center">LF</td>
</tr>







<tr>
	<td>Catch Basin Lid </td>
	<td><input type="number" name="catchbasin_lid_qty" id="catchbasin_lid_qty" size="10" placeholder="#NumberFormat(getAdjustments.catchbasin_lid_qty)#" <cfif #getAdjustments.catchbasin_lid_qty# is not  0>value="#NumberFormat(getAdjustments.catchbasin_lid_qty)#"</cfif>></td>
	<td align="center">Each</td>
</tr>


<tr>
	<td>Pullbox</td>
	<td><input type="number" name="pullbox_qty" id="pullbox_qty" size="10" placeholder="#NumberFormat(getAdjustments.pullbox_qty)#" <cfif #getAdjustments.pullbox_qty# is not 0>value="#NumberFormat(getAdjustments.pullbox_qty)#"</cfif>> </td>
	<td align="center">Each</td>
</tr>


<tr>
	<td>Tree Stumps</td>
	<td><input type="number" name="tree_stump_qty" id="tree_stump_qty" size="10" placeholder="#NumberFormat(getAdjustments.tree_stump_qty)#" <cfif #getAdjustments.tree_stump_qty# is not 0>value="#NumberFormat(getAdjustments.tree_stump_qty)#"</cfif>></td>
	<td align="center">Each</td>
</tr>


<tr>
	<td colspan="3">BCA Comments:<br>
	
	<textarea name="bca_comments" id="bca_comments" style="width:98%;height:65px;margin-top:5px;" placeholder="Type your comments here ..."></textarea>
	</td>

</tr>

</table>

<BR>
<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>


</form>
<br>

<div class="notes">
The amounts entered above represent quantity adjustments to BCA assessment.  To reduce original quantities, use negative quantities.
Quantities cannot be adjusted if the rebate payment processing has started.
</div>

</cfoutput>
<cfinclude template="footer.cfm">