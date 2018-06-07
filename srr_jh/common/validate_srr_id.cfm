<!--- Validate srr_id--->
<cfif not isdefined("request.srr_id") or not isnumeric(#request.srr_id#) or #request.srr_id# lte 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Invalid Request!" showBackButton="0">
<cfabort>
</cfif>
<cfoutput>
#srr_id#
</cfoutput>
<!--- Validate srr_id--->