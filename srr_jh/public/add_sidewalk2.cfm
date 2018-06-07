<cfinclude template="../common/validate_srrKey.cfm">


<!--- detect next sidewalk segment number --->
<cfquery name="count_sidewalks" datasource="apermits_sql" dbtype="datasource">
select sidewalk_id
from sidewalk_details
where 
ref_no = #request.ref_no#
</cfquery>

<Cfif #count_sidewalks.recordcount# is not 0>
<cfquery name="get_last_sidewalk" datasource="apermits_sql" dbtype="datasource">
select max(sidewalk_no) as last_no
from sidewalk_details
where
ref_no = #request.ref_no#
</cfquery>
<cfset request.sidewalk_no=#get_last_sidewalk.last_no#+1>
<Cfelse>
<cfset request.sidewalk_no=1>
</cfif>
<!--- detect next sidewalk segment number --->

<!--- prep input --->


<Cfif #request.sw_length_ft# is "">
<cfset request.sw_length_ft=0>
</cfif>

<Cfif #request.sw_length_in# is "">
<cfset request.sw_length_in=0>
</cfif>

<Cfif #request.sw_width_ft# is "">
<cfset request.sw_width_ft=0>
</cfif>

<Cfif #request.sw_width_in# is "">
<cfset request.sw_width_in=0>
</cfif>


<cfinclude template="../common/generate_new_sidewalk_id.cfm">

<cfquery name="add_sidewalk" datasource="apermits_sql" dbtype="datasource">
insert into sidewalk_details
(
sidewalk_id,
ref_no,
sidewalk_no,
sw_length_ft,
sw_length_in,
sw_width_ft,
sw_width_in,
reason_for_work,
eligible,
waive_sidewalk_fee,
waive_sidewalk_fee_waiver_id
)

values

(
#request.sidewalk_id#,
#request.ref_no#,
#request.sidewalk_no#,

#request.sw_length_ft#,
#request.sw_length_in#,

#request.sw_width_ft#,
#request.sw_width_in#,
'Repair',
'N',
'Y',
22

)
</cfquery>

<!-- Updating A-Permit History -->
<cfquery name="updateApermitHistory" datasource="apermits_sql" dbtype="datasource">
update permit_info
set
record_history = record_history + 'A sidewalk segment was added by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.<br><br>'
where ref_no = #request.a_ref_no#
</cfquery>
<!-- Updating A-Permit History -->

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|A sidewalk segment was added by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cfinclude template="../common/calc_update_sidewalk.cfm">

<cflocation addtoken="No" url="list_sidewalks.cfm?srrKey=#request.srrKey#&#request.addtoken#">

