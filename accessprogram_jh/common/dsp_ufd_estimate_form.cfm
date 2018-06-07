<cfparam name="request.sr_number" default="1-414802441">
<cfparam name="request.ar_id" default="1871">
<cfparam name="request.arKey" default="2CSxWZOtaap7oYhI6j1eNdQ4FLyVVxbDq92WD23WnXcioZiNos">

<cfinclude template="../common/validate_arKey.cfm">


<cfquery name="checkAr" datasource="#request.dsn#" dbtype="datasource">
Select arKey from bssEstimate
where arKey = '#request.arKey#'
</cfquery>

<cfif #checkAr.recordcount# is 0>
<div class="warning">
Estimate is Not Completed!
<br>
Please Try again Later!
</div>
<cfabort>
</cfif>

<cfquery name="readBSSEstimate" datasource="#request.dsn#" dbtype="datasource">
Select * from BSSEstimate
where arKey = '#request.arKey#'
</cfquery>


<cfoutput>
<div align="center">
<div class="formbox" style="width:350px;">
<h1>Tree Information</h1>
<a href="http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRPBSS&ref_no=#request.sr_number#&search=#URLEncodedFormat(request.job_address)#&allow_edit=0" target="_blank">Identify Tree Locations</a> (map)
<table border="1" class="datatable" align="center"  style="width:97%;font-size:90%;">
<tr>
<th>Item</th>
<th>Description</th>
<th>Unit</th>
<th>Quantity</th>
</tr>
</cfoutput>
<cfset xx = 1>
<cfset groupList = "2,3,4,5,6">
<cfloop index="y" list="#groupList#" delimiters=",">
<cfquery name="readFields" datasource="#request.dsn#" dbtype="datasource">
SELECT
[FieldName]
      ,[Units]
      ,[Price]
      ,[Sort_Order]
      ,[Sort_Group]
  FROM [accessprogram].[dbo].[bssEstimateForm]

  where suspend = 'n'
  and bssDivision = 'ufd'
  and sort_Group = #y#
  
order by sort_group, sort_order

</cfquery>


<cfif #readFields.recordcount# is not 0>
<cfquery name="groupName" datasource="#request.dsn#" dbtype="datasource">
SELECT
 [ID]
      ,[Category]
  FROM [accessprogram].[dbo].[tblSortGroup]
  where ID = #y#
</cfquery>
<cfoutput>
<tr>
<th colspan="4" style="text-align:left;">#groupName.Category#</th>
</tr>
</cfoutput>
</cfif>

<cfoutput query="readFields">
<cfset v = readfields.fieldname&"_">
			<cfset v = replace(v,"___",")_","ALL")>
			<cfset v = replace(v,"__"," (","ALL")>
			<cfset v = replace(v,"_UNITS","","ALL")>
			<cfset v = replace(v,"_l_","_/_","ALL")>
			<cfset v = replace(v,"_ll_",".","ALL")>
			<cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")>
			<cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
			<cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
			<cfset v = replace(v,"FOUR_FEET","4#chr(39)#","ALL")>
			<cfset v = replace(v,"SIX_FEET","6#chr(39)#","ALL")>
			<cfset v = replace(v,"_FEET","#chr(39)#","ALL")>
			<cfset v = replace(v,"_"," ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")>
			<cfset v = replace(v," Pvc "," PVC ","ALL")>
			<cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")>
			<cfset v = replace(v,"(c","(C","ALL")>
			<cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")>
			<cfset v = replace(v,"(o","(O","ALL")>
			<cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(u","(U","ALL")>
			<cfset v = replace(v,"(e","(E","ALL")>
			<cfset v = replace(v,"High Strength","High-Strength","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")>
			<cfset v = replace(v," And "," & ","ALL")>
			<cfset v = replace(v,"Composite","Comp","ALL")>
			<!--- <cfset v = replace(v," ","&nbsp;","ALL")> --->




<tr>
<td>#xx#</td>
<td>#v#</td>
<td>#readFields.Units#</td>
<cfquery name="readBSSEstimate" datasource="#request.dsn#" dbtype="datasource">
Select #readFields.FieldName#_Quantity as xValue from BSSEstimate
where arKey = '#request.arKey#'
</cfquery>

<td>
#readBSSEstimate.xValue#
</td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>
</cfloop>

<tr>
<td colspan="4">
<p>BSS Urban Forestry Comments:</p>
<p>#ufd_internal_comments#</p>
</td>
</tr>

</table>
</div>
