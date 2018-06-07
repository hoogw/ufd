<cfinclude template="../common/header.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.sr_number" default="1-134748571">
<cfparam name="request.ar_id" default="1000">
<cfparam name="request.arKey" default="6dfEfjWF0DRJHVAL9Kz2VFqextFwn57hGcfmbs0za3ijWIJ6Yu">


<!--- <cfquery name="checkAr" datasource="#request.dsn#" dbtype="datasource">
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
</cfif> --->

<cfquery name="readFields" datasource="#request.dsn#" dbtype="datasource">
SELECT
[FieldName]
      ,[Units]
      ,[Price]
      ,[Sort_Order]
      ,[Sort_Group]
  FROM [accessprogram].[dbo].[bssEstimateForm]
order by sort_group, sort_order
</cfquery>

<cfabort>

<!--- <cfset paramValue = 0>
<cfloop query="readFields">
<cfset paramName="request."&#readfields.FieldName#&"_Quantity">
<cfparam name="#paramName#" default="#paramValue#">
<cfoutput>
#paramName# = #paramValue#<br>
</cfoutput>
</cfloop> --->

<!--- <cfset paramValue = 0>
<cfloop query="readFields">
<cfoutput>
<cfset paramName="request."&#readfields.FieldName#&"_Quantity">
<cfparam name="#paramName#" default="0">
#paramName#= #Evaluate("#paramName#")#<br>
</cfoutput>
</cfloop> --->



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

<!--- <cfdump var="#readFields#" output="browser"> --->


<!--- <form action="bss_estimate_action.cfm" method="post" name="bss_estimate_form" id="bss_estimate_form">
<div align="center">
<table border="1" align="center" class="datatable" style="width:400px;">
<tr>
<th>Item</th>
<th>Description</th>
<th>Unit</th>
<th>Quantity</th>
</tr>
<cfset xx = 1>
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
			<cfset v = replace(v," ","&nbsp;","ALL")>




<tr>
<td>#xx#</td>
<td>#v#</td>
<td>#readFields.Units#</td>
<td><input type="text" name="#readFields.FieldName#_Quantity" id="#readFields.FieldName#_Quantity" size="10"></td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>
</table>
</div>

<div align="center"><input type="submit" name="submitBSSForm" id="submitBSSForm" value="Save" class="submit"></div>

</form>
 --->
<cfset request.updateQuery = "UPDATE BSSEstimate  set  lastUpdatedOn = #now()#, ">

<cfloop query="readFields">
<!--- <cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#_Quantity="&"toSqlNumeric("&"##"&"request.#readfields.FieldName#_Quantity"&"##"&")"&", "> --->
<!--- <cfif right(#readFields.FieldName#, 1) is "_">
<cfset request.updateQuery = #request.updateQuery#&"#readFields.FieldName#Quantity="&""&"##"&"request.#readfields.FieldName#_Quantity"&"##"&""&", ">
<Cfelse> --->
<cfoutput>
<cfset xValue = #Evaluate("request."&#readfields.FieldName#&"_Quantity")#>
<cfset xUnits = #Evaluate("request."&#readfields.FieldName#&"_Units")#>
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
<!--- </cfif> --->
</cfloop>

<!--- <cfset v = Evaluate("#request.updateQuery#")> --->

<cfset request.updateQuery = left(#request.updateQuery#, (len(#request.updateQuery#) - 2))>
<cfset request.updateQuery = #request.updateQuery#&" where arKey = '#request.arKey#'">

<!--- <cfdump var="#request.updateQuery#" output="browser"> --->
<cfoutput>
#request.updateQuery#
</cfoutput>


<cfabort>
<cfquery name="updateFields" datasource="#request.dsn#" dbtype="datasource">
#PreserveSingleQuotes(request.updateQuery)#
</cfquery>

<div class="warning">BSS Estimate was Successfully Updated</div>

<cfinclude template="../common/footer.cfm">

