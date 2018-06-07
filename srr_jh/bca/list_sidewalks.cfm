<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<cfquery name="list_sidewalks" datasource="apermits_sql" dbtype="datasource">
SELECT 
[sidewalk_id]
      ,[sidewalk_no]
      ,[ref_no]
      ,[sw_length_ft]
      ,[sw_length_in]
      ,[sw_width_ft]
      ,[sw_width_in]
      ,[sidewalk_qty]
     
	  
  FROM [Apermits].[dbo].[sidewalk_details]
  
  
  where ref_no = #request.ref_no#
</cfquery>

<div class="divSubTitle">
Sidewalks
</div>

<cfif #request.status_cd# is "pendingBcaReview">
<cfoutput>
<div style="margin-left:auto;margin-right:auto;text-align:right;width:95%">
<input type="button" name="addSidewalk" id="addSidewalk" value="Add Sidewalk" style="margin-right:0px;" onClick="location.href = 'add_sidewalk1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>
</cfif>

<div align="center">
<table style="width:95%;" class="datatable">
<tr>
	<th>Segment<br>No.</th>
	<th>Sq. ft.</th>
<!--- 	<th>Eligible</th> --->
	<th>Action</th>
</tr>

<cfoutput query="list_sidewalks">
<tr>
	<td style="text-align:center;">#list_sidewalks.sidewalk_no#</td>
	<td style="text-align:right;">#decimalformat(list_sidewalks.sidewalk_qty)#</td>
<!--- 	<td style="text-align:center;">Yes</td> --->
	<td style="text-align:center;"><cfif #request.status_cd# is "pendingBcaReview"><a href="remove_sidewalk.cfm?srrKey=#request.srrKey#&sidewalk_id=#list_sidewalks.sidewalk_id#&#request.addtoken#">Remove</a></cfif></td>
</tr>
</cfoutput>

</table>
</div>


<cfinclude template="footer.cfm">
