<cfinclude template="../common/validate_srr_id.cfm">

<cfif not isdefined("request.bss_action_req") or #request.bss_action_req# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="BSS Pre-Inspection: Yes or No is Required!" showBackButton="1">
<cfabort>
</cfif>

<!--- <cfoutput>
update srr_info
set
 bss_action_req = '#request.bss_action_req#'
<cfif #request.bss_action_req# is "y">
, bca_to_bss_dt = #now()#
, bca_action_by = #client.staff_user_id#
</cfif>

where srr_id = #request.srr_id#
</cfoutput>
<cfabort> --->

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
 bss_action_req = '#request.bss_action_req#'
<cfif #request.bss_action_req# is "y">
, bca_to_bss_dt = #now()#
, bca_action_by = #client.staff_user_id#
<cfelseif #request.bss_action_req# is "n">
, bca_to_ssd_dt = #now()#
, bca_action_by = #client.staff_user_id#
</cfif>


where srr_id = #request.srr_id#
</cfquery>


<cfoutput>
<cfif #request.bss_action_req# is "n">
<div class="warning">The Program Interest Form is Forwarded to Street and Stormdrain Division.</div>
<cfelseif #request.bss_action_req# is "y">
<div class="warning">The Program Interest Form is Forwarded to Bureau of Street Services.</div>
</cfif>
</cfoutput>
