
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">

<cfif not isdefined("request.driveway_id") or not isnumeric(#request.driveway_id#)>
<cfmodule template="/common/error_msg.cfm" error_msg="Invalid Request!" showBackButton="0">
<cfabort>
</cfif>

<cfquery name="removedriveway" datasource="apermits_sql" dbtype="datasource">
delete from driveway_details
  where ref_no = #request.ref_no# and driveway_id = #request.driveway_id#
</cfquery>

<cflocation addtoken="No" url="list_driveways.cfm?srrKey=#request.srrKey#&#request.addtoken#">