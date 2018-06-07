<cfinclude template="validate_srrKey.cfm">
<cfset request.const_total = 0>
<cfset request.calc_rebate_total = 0>

<div class="title">Estimate of Work to be done to make sidewalks ADA Compliant</div>

<div align="center"><strong>Construction Estimate</strong></div>
<table style="width:800px;" class="datatable">
<tr>
<th>Item</th>
<th>Qty</th>
<th>Unit</th>
<th>Unit Cost</th>
<th>Subtotal</th>
<th>Rebate</th>
<!--- <th>Rebate Eligible</th> --->
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

<!--- <cfdump var="#getSideWalks#" output="browser"> --->

<cfset xx = 1>
<cfoutput query="getSideWalks">
<tr>
<td>Sidewalk Segment #xx#</td>
<td style="text-align:right;">#decimalformat(getSideWalks.sidewalk_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getSideWalks.sidewalk_uf)#</td>
<cfset request.sidewalk_Cost = #getSideWalks.sidewalk_qty# * #getSideWalks.sidewalk_uf#>
<cfset request.const_total = #request.const_total# + #request.sidewalk_Cost#>
<cfset request.sidewalk_rebate= #request.sidewalk_Cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_rebate#>
<td style="text-align:right;">#dollarformat(request.sidewalk_Cost)#</td>
<td style="text-align:right;">#dollarformat(request.sidewalk_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(eligible)#</td> --->
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
<td>Driveway No. #xx#</td>
<td style="text-align:right;">#decimalformat(getDriveWays.driveway_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getDriveWays.driveway_uf)#</td>
<cfset request.driveway_cost  = #getDriveways.driveway_qty# * #getDriveways.driveway_uf#>
<cfset request.const_total = #request.const_total# + #request.driveway_cost#>
<cfset request.driveway_rebate= #request.driveway_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.driveway_rebate#>
<td style="text-align:right;">#dollarformat(request.driveway_cost)#</td>
<td style="text-align:right;">#dollarformat(request.driveway_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(eligible)#</td> --->
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
<td>Partial Driveway (Concrete)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.partial_dwy_conc_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getOtherItems.driveway_uf)#</td>
<cfset request.partial_dwy_conc_cost = #getOtherItems.partial_dwy_conc_qty# * #getOtherItems.driveway_uf#>
<cfset request.const_total = #request.const_total# + #request.partial_dwy_conc_cost#>
<cfset request.partial_dwy_conc_rebate= #request.partial_dwy_conc_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.partial_dwy_conc_rebate#>
<td style="text-align:right;">#dollarformat(request.partial_dwy_conc_cost)#</td>
<td style="text-align:right;">#dollarformat(request.partial_dwy_conc_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(partial_dwy_conc_eligible)#</td> --->
</tr>
</CFIF>

<Cfif #getOtherItems.access_ramp_qty# is not 0>
<tr>
<td>Access Ramp(s)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.access_ramp_qty)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getOtherItems.access_ramp_uf)#</td>
<cfset request.access_ramp_cost = #getOtherItems.access_ramp_qty# * #getOtherItems.access_ramp_uf#>
<cfset request.const_total = #request.const_total# + #request.access_ramp_cost#>
<cfset request.access_ramp_rebate= #request.access_ramp_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.access_ramp_rebate#>
<td style="text-align:right;">#dollarformat(request.access_ramp_cost)#</td>
<td style="text-align:right;">#dollarformat(request.access_ramp_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(access_ramp_eligible)#</td> --->
</tr>
</CFIF>

<Cfif #getOtherItems.curb_cuts_qty# is not 0>
<tr>
<td>Curb Cuts</td>
<td style="text-align:right;">#decimalformat(getOtherItems.curb_cuts_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getOtherItems.curb_cuts_uf)#</td>
<cfset request.curb_cuts_cost = #getOtherItems.curb_cuts_qty# * #getOtherItems.curb_cuts_uf#>
<cfset request.const_total = #request.const_total# + #request.curb_cuts_cost#>
<cfset request.curb_cuts_rebate= #request.curb_cuts_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.curb_cuts_rebate#>
<td style="text-align:right;">#dollarformat(request.curb_cuts_cost)#</td>
<td style="text-align:right;">#dollarformat(request.curb_cuts_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(curb_cuts_eligible)#</td> --->
</tr>
</CFIF>


<Cfif #getOtherItems.conc_curb_qty# is not 0>
<tr>
<td>New Curb</td>
<td style="text-align:right;">#decimalformat(getOtherItems.conc_curb_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getOtherItems.conc_curb_uf)#</td>
<cfset request.conc_curb_cost = #getOtherItems.conc_curb_qty# * #getOtherItems.conc_curb_uf#>
<cfset request.const_total = #request.const_total# + #request.conc_curb_cost#>
<cfset request.conc_curb_rebate= #request.conc_curb_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_curb_rebate#>
<td style="text-align:right;">#dollarformat(request.conc_curb_cost)#</td>
<td style="text-align:right;">#dollarformat(request.conc_curb_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(conc_curb_eligible)#</td> --->
</tr>
</CFIF>

<Cfif #getOtherItems.conc_gutter_qty# is not 0>
<tr>
<td>New Gutter</td>
<td style="text-align:right;">#decimalformat(getOtherItems.conc_gutter_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getOtherItems.conc_gutter_uf)#</td>
<cfset request.conc_gutter_cost = #getOtherItems.conc_gutter_qty# * #getOtherItems.conc_gutter_uf#>
<cfset request.const_total = #request.const_total# + #request.conc_gutter_cost#>
<cfset request.conc_gutter_rebate= #request.conc_gutter_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_gutter_rebate#>
<td style="text-align:right;">#dollarformat(request.conc_gutter_cost)#</td>
<td style="text-align:right;">#dollarformat(request.conc_gutter_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(conc_gutter_eligible)#</td> --->
</tr>
</CFIF>





<Cfif #getOtherItems.drains_no# is not 0>
<tr>
<td>Curb Drain(s)</td>
<td style="text-align:right;">#decimalformat(getOtherItems.drains_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getOtherItems.drains_uf)#</td>
<cfset request.drains_cost = #getOtherItems.drains_no# * #getOtherItems.drains_uf#>
<cfset request.const_total = #request.const_total# + #request.drains_cost#>
<cfset request.drains_rebate= #request.drains_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.drains_rebate#>
<td style="text-align:right;">#dollarformat(request.drains_cost)#</td>
<td style="text-align:right;">#dollarformat(request.drains_rebate)#</td>
<!--- <td style="text-align:center;">#ucase(drains_eligible)#</td> --->
</tr>
</CFIF>
</cfoutput>

<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT dbo.tree_info.nbr_trees_pruned, dbo.tree_info.lf_trees_pruned, dbo.tree_info.nbr_trees_removed, dbo.tree_info.srr_id, dbo.srr_info.sr_number, 
               dbo.srr_info.srrKey, dbo.rebate_rates.tree_pruning_uf, dbo.rebate_rates.tree_removal_uf
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.rebate_rates ON dbo.srr_info.rate_nbr = dbo.rebate_rates.rate_nbr RIGHT OUTER JOIN
               dbo.tree_info ON dbo.srr_info.srr_id = dbo.tree_info.srr_id

where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<Cfif #getTrees.recordcount# is not 0>

<cfif #getTrees.lf_trees_pruned# is not 0>
<cfoutput>
<tr>
<td>Root Pruning</td>
<td style="text-align:right;">#decimalformat(getTrees.lf_trees_pruned)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getTrees.tree_pruning_uf)#</td>
<cfset request.tree_pruning_cost = #getTrees.lf_trees_pruned# * #getTrees.tree_pruning_uf#>
<cfset request.const_total = #request.const_total# + #request.tree_pruning_cost#>
<cfset request.tree_pruning_rebate= #request.tree_pruning_cost# * 0.50>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_pruning_rebate#>
<td style="text-align:right;">#dollarformat(request.tree_pruning_cost)#</td>
<td style="text-align:right;">#dollarformat(request.tree_pruning_rebate)#</td>
<!--- <td style="text-align:center;">Y</td> --->
</tr>
</cfoutput>
</cfif>

<cfif #getTrees.nbr_trees_removed# is not 0>
<cfoutput>
<tr>
<td>Tree Removal</td>
<td style="text-align:right;">#getTrees.nbr_trees_removed#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getTrees.tree_removal_uf)# &amp; UP</td>
<cfset request.tree_removal_cost = #getTrees.nbr_trees_removed# * #getTrees.tree_removal_uf#>
<cfset request.const_total = #request.const_total# + #request.tree_removal_cost#>
<cfset request.tree_removal_rebate= 500 * #getTrees.nbr_trees_removed#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_removal_rebate#>
<td style="text-align:right;">#dollarformat(request.tree_removal_cost)#</td>
<td style="text-align:right;">#dollarformat(request.tree_removal_rebate)#</td>
<!--- <td style="text-align:center;">Y</td> --->
</tr>
</cfoutput>
</cfif>

</CFIF>



<cfoutput>
<tr>
<td style="background:gray;"><strong>Construction Cost</strong></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td style="background:gray;"><strong>#dollarformat(request.const_total)#</strong></td>
<td style="background:gray;"><strong>#dollarformat(request.calc_rebate_total)#</strong></td>
<!--- <td>&nbsp;</td> --->
</tr>
</cfoutput>

</table>

<cfquery name="getPropType" datasource="#request.dsn#" dbtype="datasource">
Select prop_type from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<p style="margin-left:auto;margin-right:auto;width:800px;border:1px solid silver;border-radius:7px;">
Maximum Rebate Amount is: $2000 for residential properties and $4000 for commercial properties.
<br /><br>
</p>

<div class = "warning">
<cfif #getPropType.prop_type# is "r">
<cfif #request.calc_rebate_total# gt 2000>
<strong>Rebate Amount = $2,000</strong>
<cfelse>
<strong>Rebate Amount = #request.calc_rebate_total#</strong>
</cfif>
<cfelseif #getPropType.prop_type# is "c">
<cfif #request.calc_rebate_total# gt 4000>
<strong>Rebate Amount = $4,000</strong>
<cfelse>
<strong>Rebate Amount = #request.calc_rebate_total#</strong>
</cfif>
</cfif>
</div>


