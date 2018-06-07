<cfset paramValue = 0>
<cfloop query="readFields">
<cfoutput>
<cfset paramName="request."&#readfields.FieldName#&"_Quantity">
<cfparam name="#paramName#" default="0">
#paramName# = #paramValue#<br>
</cfoutput>
</cfloop>