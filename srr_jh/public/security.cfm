<cfif #cgi.http_referer# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg = "Invalid Request, Login Required!">
<cfabort>
</cfif>