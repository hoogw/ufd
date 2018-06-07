<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">
<cfset request.ref_no = #request.a_ref_no#>

<cfquery name="find_permit" datasource="apermits_sql" dbtype="datasource">
select ddate_submitted, application_status, permit_type, record_history, ar_nbr, rate_nbr
 from permit_info
where ref_no=#request.ref_no#
</cfquery>

<cfparam name="request.util_interference" default="">
<cfquery name="update_srr_other_items" datasource="#request.dsn#" dbtype="datasource">
update srr_other_items
set
  partial_dwy_conc_qty = #toSqlNumeric(request.partial_dwy_conc_qty)#
, access_ramp_qty = #toSqlNumeric(request.access_ramp_qty)#
, conc_curb_qty = #toSqlNumeric(request.conc_curb_qty)#
, conc_gutter_qty = #toSqlNumeric(request.conc_gutter_qty)#

, sidewalk_trans_qty = #toSqlNumeric(request.sidewalk_trans_qty)#
, pkwy_drain_qty = #toSqlNumeric(request.pkwy_drain_qty)#
, catch_basin_lid_qty = #toSqlNumeric(request.catch_basin_lid_qty)#


<!--- , curb_cuts_qty = #toSqlNumeric(request.curb_cuts_qty)# --->
<!--- , drains_no = #toSqlNumeric(request.drains_no)# --->


, util_interference =  '#request.util_interference#'
, util_interference_comments =  '#toSqlText(request.util_interference_comments)#'
, pullbox_no = #toSqlNumeric(request.pullbox_no)#
, pullbox_comments = '#toSqlText(request.pullbox_comments)#'
, signage_no = #toSqlNumeric(request.signage_no)#
, signage_comments = '#toSqlText(request.signage_comments)#'
, st_furn_no = #toSqlNumeric(request.st_furn_no)#
, st_furn_comments = '#toSqlText(request.st_furn_comments)#'
, parking_meter_no = #toSqlNumeric(request.parking_meter_no)#
, survey_monument_no = #toSqlNumeric(request.survey_monument_no)#

where srr_id = #request.srr_id#
</cfquery>

<cfquery name="update_other_items" datasource="apermits_sql" dbtype="datasource">
update other_items
set
  partial_dwy_conc_qty = #toSqlNumeric(request.partial_dwy_conc_qty)#
, access_ramp_qty= #toSqlNumeric(request.access_ramp_qty)#
, conc_curb_qty = #toSqlNumeric(request.conc_curb_qty)#
, conc_gutter_qty = #toSqlNumeric(request.conc_gutter_qty)#
<!--- , curb_cuts_qty = #toSqlNumeric(request.curb_cuts_qty)# --->
<!--- , drains_no = #toSqlNumeric(request.drains_no)# --->


, waive_partial_dwy_conc_fee = 'Y'
, waive_partial_dwy_conc_surcharge1 = 'Y'
, waive_partial_dwy_conc_surcharge2 = 'Y'
, waive_access_ramp_fee = 'Y'
, waive_access_ramp_surcharge1 = 'Y'
, waive_access_ramp_surcharge2 = 'Y'
, waive_conc_curb_fee = 'Y'
, waive_conc_curb_surcharge1 = 'Y'
, waive_conc_curb_surcharge2 = 'Y'
<!--- , waive_curb_cuts_fee = 'Y' --->
<!--- , waive_curb_cuts_surcharge1 = 'Y' --->
<!--- , waive_curb_cuts_surcharge2 = 'Y' --->
<!--- , waive_drains_fee = 'Y'
, waive_drains_surcharge1 = 'Y'
, waive_drains_surcharge2 = 'Y' --->
, waive_conc_gutter_fee = 'Y'
, waive_conc_gutter_surcharge1 = 'Y'
, waive_conc_gutter_surcharge2 = 'Y'
, partial_dwy_conc_waiver_id = 22
, access_ramp_waiver_id = 22
, conc_curb_waiver_id = 22
<!--- , curb_cuts_waiver_id = 22 --->
, drains_waiver_id = 22
, conc_gutter_waiver_id = 22

where ref_no = #request.ref_no#
</cfquery>

<cfinclude template="../common/update_all_fees.cfm">

<cfset request.record_history=#find_permit.record_history#&"<b>Other Items screen was Updated</b> on "&#dateformat(now(),"mm/dd/yyyy")#&" at "&#timeformat(now(),"h:mm tt")#&" by "&#client.full_name#&"."&"<BR><BR>">

<cfquery name="update_app" datasource="apermits_sql" dbtype="datasource">
Update permit_info
Set
record_history='#request.record_history#'
where ref_no=#request.ref_no#
</cfquery>

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|Other Items screen was updated on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->



<cflocation addtoken="No" url="application_options.cfm?srrKey=#request.srrKey#&#request.addtoken#">
