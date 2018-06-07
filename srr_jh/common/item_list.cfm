<cfinclude template="validate_srrKey.cfm">

<table style="width:95%;" class="datatable">
<tr>
<th>Item</th>
<th>Qty</th>
<th>Unit</th>
</tr>

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
			   
where srr_info.srrKey = '#request.srrKey#'
</cfquery>


<cfset xx = 1>
<cfoutput query="getSideWalks">
<tr>
<td style="text-align:left;">Sidewalk Segment #xx#</td>
<td style="text-align:right;">#decimalformat(getSideWalks.sidewalk_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>

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
			   
where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset xx = 1>
<cfoutput query="getDriveWays">
<tr>
<td style="text-align:left;">Driveway No. #xx#</td>
<td style="text-align:right;">#decimalformat(getDriveWays.driveway_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>

<cfquery name="getOtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
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

, dbo.srr_info.sr_number
, dbo.rebate_rates.conc_curb_uf
, dbo.rebate_rates.conc_gutter_uf
, dbo.rebate_rates.curb_cuts_uf
, dbo.rebate_rates.drains_uf
, dbo.rebate_rates.pullbox_uf
, dbo.rebate_rates.st_furn_uf
, dbo.rebate_rates.signage_uf
, dbo.rebate_rates.parking_meter_uf
, dbo.rebate_rates.driveway_uf
, dbo.rebate_rates.access_ramp_uf

FROM  dbo.rebate_rates INNER JOIN
               dbo.srr_info ON dbo.rebate_rates.rate_nbr = dbo.srr_info.rate_nbr RIGHT OUTER JOIN
               apermits.dbo.other_items AS other_items ON dbo.srr_info.a_ref_no = other_items.ref_no
where srr_info.srrKey = '#request.srrKey#'
</cfquery>


<cfoutput query="getOtherItems">
<Cfif #getOtherItems.partial_dwy_conc_qty# is not 0>
<tr>
<td style="text-align:left;">Partial Driveway (Concrete)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.partial_dwy_conc_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>

</tr>
</CFIF>

<Cfif #getOtherItems.access_ramp_qty# is not 0>
<tr>
<td style="text-align:left;">Access Ramp(s)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.access_ramp_qty)#</td>
<td style="text-align:center;">Each</td>
</tr>
</CFIF>

<!--- <Cfif #getOtherItems.curb_cuts_qty# is not 0>
<tr>
<td>Curb Cuts</td>
<td style="text-align:right;">#decimalformat(getOtherItems.curb_cuts_qty)#</td>
<td style="text-align:center;">LF</td>
</tr>
</CFIF> --->


<Cfif #getOtherItems.conc_curb_qty# is not 0>
<tr>
<td style="text-align:left;">New Curb</td>
<td style="text-align:right;">#decimalformat(getOtherItems.conc_curb_qty)#</td>
<td style="text-align:center;">LF</td>
</tr>
</CFIF>

<Cfif #getOtherItems.conc_gutter_qty# is not 0>
<tr>
<td style="text-align:left;">New Gutter</td>
<td style="text-align:right;">#decimalformat(getOtherItems.conc_gutter_qty)#</td>
<td style="text-align:center;">LF</td>
</tr>
</CFIF>





<Cfif #getOtherItems.drains_no# is not 0>
<tr>
<td style="text-align:left;">Curb Drain(s)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.drains_no)#</td>
<td style="text-align:center;">Each</td>
</tr>
</CFIF>
</cfoutput>

<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.tree_info.nbr_trees_pruned
, dbo.tree_info.lf_trees_pruned
, dbo.tree_info.nbr_trees_removed
, dbo.tree_info.srr_id
, dbo.srr_info.sr_number
, dbo.srr_info.srrKey
, dbo.rebate_rates.tree_pruning_uf
, dbo.rebate_rates.tree_removal_uf

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr RIGHT OUTER JOIN
               dbo.tree_info ON dbo.srr_info.srr_id = dbo.tree_info.srr_id

where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<Cfif #getTrees.recordcount# is not 0>

<cfif #getTrees.lf_trees_pruned# is not 0>
<cfoutput>
<tr>
<td style="text-align:left;">Root Pruning</td>
<td style="text-align:right;">#decimalformat(getTrees.lf_trees_pruned)#</td>
<td style="text-align:center;">LF</td>
</tr>
</cfoutput>
</cfif>

<cfif #getTrees.nbr_trees_removed# is not 0>
<cfoutput>
<tr>
<td style="text-align:left;">Tree Remove and Replace</td>
<td style="text-align:right;">#getTrees.nbr_trees_removed#</td>
<td style="text-align:center;">Each</td>
</tr>
</cfoutput>
</cfif>

</CFIF>


</table>

