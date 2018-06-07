<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<div class="divSubTitle">
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
	  
  FROM [driveway_details]
  
  where ref_no = #request.ref_no#
  
  order by driveway_no
</cfquery>

<cfif #request.status_cd# is "pendingBcaReview">
<cfoutput>
<div style="text-align:right;width:95%;margin-left:auto;margin-right:auto;">
<input type="button" name="addDriveway" id="addDriveway" value="Add Driveway" style="margin-right:10px;" onClick="location.href='add_driveway1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>
</cfif>

<div align="center">
<table style="width:95%;" class="datatable">
<tr>
	<th>Driveway<br>No.</th>
	<th>Sq. ft.</th>
<!--- 	<th>Eligible</th> --->
	<th>Action</th>
</tr>

<cfoutput query="list_driveways">
<tr>
	<td style="text-align:center;">#list_driveways.driveway_no#</td>
	<td style="text-align:right;">#decimalformat(list_driveways.driveway_qty)#</td>
<!--- 	<td style="text-align:center;">Yes</td> --->
	<td style="text-align:center;">
	<cfif #request.status_cd# is "pendingBcaReview">
	<a href="remove_driveway.cfm?srrKey=#request.srrKey#&driveway_id=#list_driveways.driveway_id#&#request.addtoken#">Remove</a>
	</cfif>
	</td>
</tr>
</cfoutput>
</table>
</div>


<cfinclude template="footer.cfm">
