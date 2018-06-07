<cfinclude template="validate_srrKey.cfm">

<table style="width:95%;" class="datatable">
<tr>
<th>Item</th>
<th>Qty</th>
<th>Unit</th>
</tr>

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
<td style="text-align:left;">Root Pruning</td>
<td style="text-align:right;">#decimalformat(getTrees.lf_trees_pruned)#</td>
<td style="text-align:center;">LF</td>
</tr>
</cfoutput>
</cfif>

</CFIF>


</table>

