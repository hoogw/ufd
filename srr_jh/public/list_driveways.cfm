<cfmodule template="../common/header.cfm" title = "Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfset request.ref_no = #request.a_ref_no#>
<cfinclude template="../common/include_sr_job_address.cfm">


<cfinclude template="add_to_scope_menu.cfm">

<div class="subtitle">
Driveways
</div>


<cfquery name="list_driveways" datasource="apermits_sql" dbtype="datasource">
SELECT 
	[driveway_id]
      ,[ref_no]
      ,[driveway_no]
      ,[driveway_case]
      ,[driveway_category]
      ,[driveway_material]
     
      ,[w_ft]
      ,[w_in]
      ,[a_ft]
      ,[a_in]
      ,[gw_ft]
      ,[gw_in]
      ,[ch_in]
      ,[items_near_driveway]
      ,[items_near_driveway_comments]
      ,[driveway_qty]
      ,[driveway_fee]
      ,[waive_driveway_fee]
      ,[driveway_fee_discount]
      ,[driveway_net_fee]
      ,[driveway_waiver_id]
	  , eligible
	  
  FROM [driveway_details]
  
  where ref_no = #request.ref_no#
  
  order by driveway_no
</cfquery>


<cfoutput>
<div style="text-align:right;width:70%;margin-left:auto;margin-right:auto;">
<input type="button" name="addDriveway" id="addDriveway" value="Add Driveway" style="margin-right:10px;" onClick="location.href='add_driveway1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>


<div align="center">
<table style="width:70%;" class="datatable">
<tr>
	<th>Item</th>
	<th>Sq. ft.</th>
<!---    <th>Rebate Eligible</th>--->
	<th>Action</th>
</tr>

<cfset xx = 1>
<cfoutput query="list_driveways">
<tr>
	<td style="text-align:center;">Driveway No. #xx#</td>
	<td style="text-align:right;">#decimalformat(list_driveways.driveway_qty)#</td>
<!---    <td style="text-align:center;"><cfif #eligible# is "Y">Yes<cfelse>No</cfif></td>--->
	<td style="text-align:center;"><cfif #eligible# is "N"><a href="remove_driveway.cfm?srrKey=#request.srrKey#&driveway_id=#list_driveways.driveway_id#&#request.addtoken#">Remove</a><cfelse>Required for ADA Compliance</cfif></td>
<cfset xx = #xx# + 1>
</tr>
</cfoutput>
</table>
</div>


<cfinclude template="footer.cfm">
