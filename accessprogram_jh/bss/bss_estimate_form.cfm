<!--- <cfparam name="request.sr_number" default="1-134748571">
<cfparam name="request.ar_id" default="1000">
<cfparam name="request.arKey" default="6dfEfjWF0DRJHVAL9Kz2VFqextFwn57hGcfmbs0za3ijWIJ6Yu"> --->

<!--- <cfinclude template="../common/header.cfm">
<cfinclude template="../common/myCFfunctions.cfm"> --->

<!--- <cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
	
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />
	
	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction> --->




<cfquery name="checkAr" datasource="#request.dsn#" dbtype="datasource">
Select arKey from bssEstimate
where arKey = '#request.arKey#'
</cfquery>

<cfif #checkAr.recordcount# is 0>
<cfquery name="AddToEstimate" datasource="#request.dsn#" dbtype="datasource">
insert into bssEstimate
(
ar_id
, sr_number
, arKey
)
VALUES
(
#request.ar_id#
, '#request.sr_number#'
, '#request.arKey#'
)
</cfquery>
</cfif>

<cfquery name="readBSSEstimate" datasource="#request.dsn#" dbtype="datasource">
Select * from BSSEstimate
where arKey = '#request.arKey#'
</cfquery>


<cfoutput>
<form action="bss_estimate_action.cfm" method="post" name="bss_estimate_form" id="bss_estimate_form">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">
</cfoutput>
<div class="formbox" style="width:400px;">
<h1>Sidewalk Information</h1>
<table border="1" class="datatable" align="center"  style="width:390px;">
<tr>
<th>Item</th>
<th>Description</th>
<th>Unit</th>
<th>Quantity</th>
</tr>
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
  and bssDivision = 'sp'
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
<input type="text" name="#readFields.FieldName#_Quantity" id="#readFields.FieldName#_Quantity" value="#readBSSEstimate.xValue#" size="10">
</td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>
</cfloop>
</table>
</div>

<div align="center"><input type="submit" name="submitBSSForm" id="submitBSSForm" value="Save" class="submit"></div>

</form>
