<cfinclude template="/srr/common/validate_srr_id.cfm">
<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id, ddate_submitted
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->

<cfinclude template="../common/no_matching_address_msg.cfm">

<cfoutput>
<div align="center"><input type="button" name="next" id="next" value="Add Property Address" class="submit" onClick="location.href = 'control.cfm?action=add_job_location2&srr_id=#request.srr_id#&#request.addtoken#'"></div>
</cfoutput>
