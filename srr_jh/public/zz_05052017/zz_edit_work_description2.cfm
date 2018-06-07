<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select srr_id, ddate_submitted
from srr_info
where srr_id = #request.srr_id#
</cfquery>


<cfparam name="request.tree_root_damage" default="">
<cfparam name="request.prop_type" default="">
<cfset request.cust_comments = ReplaceList("#request.cust_comments#","#chr(39)#","#chr(39)##chr(39)#")>

<cfquery name="update_record" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
Set
prop_type = '#request.prop_type#',
tree_root_damage = '#request.tree_root_damage#',
work_description='#request.work_description#',
cust_comments = '#request.cust_comments#'


where srr_id=#request.srr_id#
</cfquery>


<cfquery name="checkScreenDates" DATASOURCE="#request.dsn#" dbtype="datasource">
select * from  screen_dates

WHERE srr_id=#request.srr_id#
</cfquery>

<cfif #checkScreenDates.recordcount# is  0>
<cfquery name="addScreenDt" DATASOURCE="#request.dsn#" dbtype="datasource">
insert into screen_dates
(srr_id, work_desc_screen_dt, work_desc_screen_by)
values
(#request.srr_id#, #now()#, -1)
</cfquery>
<cfelse>
<cfquery name="update_screen_dates" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE screen_dates
SET

work_desc_screen_dt = #now()#
, work_desc_screen_by = -1

WHERE srr_id=#request.srr_id#
</cfquery>
</cfif>


<cfif #find_srr.ddate_submitted# is "">
<cflocation addtoken="No" url="control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#">
<cfelse>
<cflocation addtoken="No" url="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>
