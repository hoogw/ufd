<cfinclude template="../common/header.cfm">
<!--- <cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.sr_number" default="1-134748571">
<cfparam name="request.ar_id" default="1000">
<cfparam name="request.arKey" default="6dfEfjWF0DRJHVAL9Kz2VFqextFwn57hGcfmbs0za3ijWIJ6Yu"> --->

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
  
order by sort_group, sort_order
</cfquery>


<cfset request.updateQuery = "UPDATE BSSEstimate  set  lastUpdatedOn = #now()#, ">



<cfloop query="readFields">

<cfoutput>
<cfset xValue = #Evaluate("request."&#readfields.FieldName#&"_Quantity")#>
<cfset xUnits = #readFields.Units#>
<cfif #xValue# is "">
<cfset xValue = 0>
<cfelse>
<cfset xValue=ReplaceNoCase("#xValue#","$","","ALL")>
<cfset xValue=ReplaceNoCase("#xValue#",",","","ALL")>
<cfset xValue=ReplaceNoCase("#xValue#","%","","ALL")>
</cfif>
<cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#_Quantity="&#xValue#&", ">
<cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#_Units='"&#xUnits#&"', ">
</cfoutput>

</cfloop>

<cfset request.updateQuery = left(#request.updateQuery#, (len(#request.updateQuery#) - 2))>
<cfset request.updateQuery = #request.updateQuery#&" where arKey = '#request.arKey#'">

<!--- <cfdump var="#request.updateQuery#" output="browser"> --->
<cfoutput>
#request.updateQuery#
</cfoutput>
<br><br>

<cfquery name="updateFields" datasource="#request.dsn#" dbtype="datasource">
#PreserveSingleQuotes(request.updateQuery)#
</cfquery>


<div class="warning">BSS Estimate was Successfully Updated</div>

<cfinclude template="../common/footer.cfm">

