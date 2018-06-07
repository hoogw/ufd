
<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id, ddate_submitted
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<!--- <cfoutput>
Update srr_info
Set
job_address='#left(Ucase(request.job_address),120)#',
boe_dist = '#request.boe_dist#',
council_dist = '#request.council_dist#',
unit_range= '#left(request.unit_range1,7)#' ,
bpp='#left(Ucase(request.bpp),15)#',
job_zip='#left(request.job_zip,12)#',
job_state = 'CA',
job_city='LOS ANGELES',
address_verified=0

where srr_id=#request.srr_id#
</cfoutput>

<cfabort> --->

<cfquery name="update_record" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
Set
job_address='#left(Ucase(request.job_address),120)#',
boe_dist = '#request.boe_dist#',
council_dist = '#request.council_dist#',
unit_range= '#left(request.unit_range1,7)#' ,
bpp='#left(Ucase(request.bpp),15)#',
job_zip='#left(request.job_zip,12)#',
job_state = 'CA',
job_city='LOS ANGELES',
address_verified=0

where srr_id=#request.srr_id#
</cfquery>

<cfquery name="checkScreenDates" DATASOURCE="#request.dsn#" dbtype="datasource">
select * from  screen_dates

WHERE srr_id=#request.srr_id#
</cfquery>

<cfif #checkScreenDates.recordcount# is  0>
<cfquery name="addScreenDt" DATASOURCE="#request.dsn#" dbtype="datasource">
insert into screen_dates
(srr_id, job_address_screen_dt, job_address_screen_by) 
values
(#request.srr_id#, #now()#, -1)
</cfquery>
<cfelse>
<cfquery name="update_screen_dates" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE screen_dates
SET

job_address_screen_dt = #now()#
, job_address_screen_by = -1

WHERE srr_id=#request.srr_id#
</cfquery>
</cfif>


<cfif #find_srr.ddate_submitted# is "">
<cflocation addtoken="No" url="control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#">
<cfelse>
<cflocation addtoken="No" url="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>

