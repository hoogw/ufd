<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

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
	  , eligible
     
	  
  FROM [Apermits].[dbo].[sidewalk_details]
 
  where ref_no = #request.a_ref_no#
</cfquery>




<cfinclude template="add_to_scope_menu.cfm">

<div class="subtitle">
Sidewalks
</div>

<cfoutput>
<div style="margin-left:auto;margin-right:auto;text-align:right;width:70%">
<input type="button" name="addSidewalk" id="addSidewalk" class="submit" value="Add Sidewalk" style="margin-right:0px;" onClick="location.href = 'add_sidewalk1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>


<div align="center">
<table style="width:70%;" class="datatable">
<tr>
	<th>Item</th>
	<th>Sq. ft.</th>
<!--- 	<th>Eligible</th> --->
	<th>Action</th>
</tr>

<cfset xx = 1>
<cfoutput query="list_sidewalks">
<tr>
	<td style="text-align:center;">Sidewalk Segment No. #xx#</td>
	<td style="text-align:right;">#decimalformat(list_sidewalks.sidewalk_qty)#</td>
<!--- 	<td style="text-align:center;">Yes</td> --->
	<td style="text-align:center;">
	<cfif #list_sidewalks.eligible# is "Y">Required for ADA Compliance<cfelse><a href="remove_sidewalk.cfm?srrKey=#request.srrKey#&sidewalk_id=#list_sidewalks.sidewalk_id#&#request.addtoken#">Remove</a></cfif></td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>

</table>
</div>

<!--- <cfoutput>
<div align="center">
<input type="button" name="add" id="add" value="Add Sidewalk Segment" class="submit" onClick="location.href = 'add_sidewalk1.cfm?srrKey=#request.srrKey#&#request.addtoken#'"> 
&nbsp;&nbsp;
<input type="botton" name="add" id="add" value="Done with Sidewalks" class="submit" onClick="location.href = 'add_to_scope.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput> --->

<cfinclude template="footer.cfm">
