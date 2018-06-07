<cfinclude template="html_top.cfm">
<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="get_history" datasource="#request.dsn#" dbtype="datasource">
select record_history from permit_info
where ref_no=#request.ref_no#
</cfquery>

<cfinclude template="dsp_ref_no.cfm">

<cfoutput>
<div class="formbox" style="width:700px;">
<h1>Record History</h1>
<cfif #get_history.record_history# is not "">
#get_history.record_history#
<cfelse>
<div class="warning">No Record History Found</div>
</cfif>
</div>
</cfoutput>

<cfinclude template="html_bottom.cfm">
