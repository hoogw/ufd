<cfinclude template="../common/validate_srr_id.cfm">

<cfif not isdefined("request.gis_completed") or #request.gis_completed# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="GIS Completed is Required!" showBackButton="1">
<cfabort>
</cfif>


<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

<cfif #request.gis_completed# is "y">
gis_completed_dt=#now()#
, gis_completed_by = #client.staff_user_id#
<cfelse>
gis_completed_dt=null
, gis_completed_by = null
</cfif>
where srr_id = #request.srr_id#
</cfquery>


<cfoutput>
<!--- <cfif #request.program_eligible# is "n">
<div align="center"><a href="control.cfm?action=print_not_eligible_letter_pdf&#request.addtoken#" target="_top">Print &quot;Not Eligible Letter to Applicant&quot;</a></div> --->
<!--- <cfif #request.program_eligible# is "y"> --->
<div class="warning">GIS Processing Status Successfully Updated</div>
<!--- </cfif> --->


</cfoutput>
