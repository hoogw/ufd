<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
Select record_history from srr_info
where srr_id = #request.srr_id#
</cfquery>

<cfset request.record_history=#find_srr.record_history#&"Application submitted on "&#dateformat(now(),"mm/dd/yyyy")#&" at "&#timeformat(now(),"h:mm tt")#&" by Applicant.<BR><BR>">

<cfquery name="update_srr_info" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE srr_info
SET
ddate_submitted = #now()#
, srr_status_cd = 'received'
, record_history = '#request.record_history#'

WHERE srr_id = #request.srr_id#
</cfquery>


<cflocation addtoken="No" url="control.cfm?action=dsp_app&frames=2&srr_id=#request.srr_id#&#request.addtoken#">
