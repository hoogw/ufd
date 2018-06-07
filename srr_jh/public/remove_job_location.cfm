<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id, ddate_submitted
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>


<cfquery name="update_permit_record" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
Set
job_address='',
hse_nbr='',
str_nm='',
unit_range='',
pind='',
bpp='',
job_zip='',
job_city='',
boe_dist='',
council_dist='',
tbm_grid='',
hse_id=null,

address_verified=0

where srr_id=#request.srr_id#
</cfquery>


<cfquery name="updateScreenDt" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE screen_dates
SET

job_address_screen_dt = null
, job_address_screen_by = null

WHERE srr_id=#request.srr_id#
</cfquery>


<cfif #find_srr.ddate_submitted# is "">
<cflocation addtoken="No" url="control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#">
<cfelse>
<cflocation addtoken="No" url="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>