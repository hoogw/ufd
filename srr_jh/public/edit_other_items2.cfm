<cfinclude template="../common/validate_srrKey.cfm">
<cfset request.ref_no = #request.a_ref_no#>
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="find_permit" datasource="apermits_sql" dbtype="datasource">
select ddate_submitted, application_status, permit_type, record_history, ar_nbr, rate_nbr
 from permit_info
where ref_no=#request.ref_no#
</cfquery>

<cfif #request.partial_dwy_conc_qty_opt# is "">
<Cfset request.partial_dwy_conc_qty_opt = 0>
</cfif>

<cfif #request.access_ramp_qty_opt# is "">
<Cfset request.access_ramp_qty_opt = 0>
</cfif>

<cfif #request.conc_curb_qty_opt# is "">
<Cfset request.conc_curb_qty_opt = 0>
</cfif>

<!--- <cfif #request.curb_cuts_qty_opt# is "">
<Cfset request.curb_cuts_qty_opt = 0>
</cfif> --->

<!--- <cfif #request.drains_no_opt# is "">
<Cfset request.drains_no_opt = 0>
</cfif>
 --->
<cfif #request.conc_gutter_qty_opt# is "">
<Cfset request.conc_gutter_qty_opt = 0>
</cfif>

<cfquery name="getAotherItems" datasource="apermits_sql" dbtype="datasource">
select 
  ISNULL(partial_dwy_conc_qty, 0) partial_dwy_conc_qty
, ISNULL(access_ramp_qty, 0) access_ramp_qty
, ISNULL(conc_curb_qty, 0) conc_curb_qty
<!--- , ISNULL(curb_cuts_qty, 0) curb_cuts_qty --->
<!--- , ISNULL(drains_no, 0) drains_no --->
, ISNULL(conc_gutter_qty, 0) conc_gutter_qty

from other_items

where ref_no = #request.ref_no#
</cfquery>

<Cfset request.partial_dwy_conc_qty = #request.partial_dwy_conc_qty_opt# + #getAotherItems.partial_dwy_conc_qty#>
<Cfset request.access_ramp_qty = #request.access_ramp_qty_opt# + #getAotherItems.access_ramp_qty#>
<Cfset request.conc_curb_qty = #request.conc_curb_qty_opt# + #getAotherItems.conc_curb_qty#>
<!--- <Cfset request.curb_cuts_qty = #request.curb_cuts_qty_opt# + #getAotherItems.curb_cuts_qty#> --->
<!--- <Cfset request.drains_no = #request.drains_no_opt# + #getAotherItems.drains_no#> --->
<Cfset request.conc_gutter_qty = #request.conc_gutter_qty_opt# + #getAotherItems.conc_gutter_qty#>


<!--- <cfquery name="get_rates" datasource="apermits_sql" dbtype="datasource">
SELECT 
[rate_nbr]
      ,[ddate_implemented]
      ,[basic_uf]
      ,[basic_uf_internet]
      ,[conc_driveway_approach_uf]
      ,[sidewalk_uf]
      ,[access_ramp_uf]
      ,[alley_intersection_uf]
      ,[relative_compaction_test_uf]
      ,[core_test_uf]
      ,[conc_curb_uf]
      ,[curb_cuts_uf]
      ,[drains_uf]
      ,[conc_gutter_uf]

      ,[surcharge_1]
      ,[surcharge_2]
      ,[surcharge_1_min]
      ,[surcharge_2_min]

  FROM [apermits].[dbo].[fee_rates]
  
where rate_nbr=#find_permit.rate_nbr#
</cfquery> --->


<cfquery name="update_srr_other_items" datasource="#request.dsn#" dbtype="datasource">
update srr_other_items
set
  partial_dwy_conc_qty_opt = #toSqlNumeric(request.partial_dwy_conc_qty_opt)#
, access_ramp_qty_opt = #toSqlNumeric(request.access_ramp_qty_opt)#
, conc_curb_qty_opt = #toSqlNumeric(request.conc_curb_qty_opt)#
<!--- , curb_cuts_qty_opt = #toSqlNumeric(request.curb_cuts_qty_opt)# --->
<!--- , drains_no_opt = #toSqlNumeric(request.drains_no_opt)# --->
, conc_gutter_qty_opt = #toSqlNumeric(request.conc_gutter_qty_opt)#

where srr_id = #request.srr_id#
</cfquery>

<cfquery name="update_other_items" datasource="apermits_sql" dbtype="datasource">
update other_items
set
  partial_dwy_conc_qty = #toSqlNumeric(request.partial_dwy_conc_qty)#
, access_ramp_qty = #toSqlNumeric(request.access_ramp_qty)#
, conc_curb_qty = #toSqlNumeric(request.conc_curb_qty)#
<!--- , curb_cuts_qty = #toSqlNumeric(request.curb_cuts_qty)# --->
<!--- , drains_no = #toSqlNumeric(request.drains_no)# --->
, conc_gutter_qty = #toSqlNumeric(request.conc_gutter_qty)#

, waive_partial_dwy_conc_fee = 'Y'
, waive_partial_dwy_conc_surcharge1 = 'Y'
, waive_partial_dwy_conc_surcharge2 = 'Y'
, waive_access_ramp_fee = 'Y'
, waive_access_ramp_surcharge1 = 'Y'
, waive_access_ramp_surcharge2 = 'Y'
, waive_conc_curb_fee = 'Y'
, waive_conc_curb_surcharge1 = 'Y'
, waive_conc_curb_surcharge2 = 'Y'
<!--- , waive_curb_cuts_fee = 'Y'
, waive_curb_cuts_surcharge1 = 'Y'
, waive_curb_cuts_surcharge2 = 'Y' --->
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

<cfset request.record_history=#find_permit.record_history#&"<b>Other Items screen was Updated</b> on "&#dateformat(now(),"mm/dd/yyyy")#&" at "&#timeformat(now(),"h:mm tt")#&" by "&"Applicant"&"."&"<BR><BR>">

<cfquery name="update_app" datasource="apermits_sql" dbtype="datasource">
Update permit_info
Set
record_history='#request.record_history#'
where ref_no=#request.ref_no#
</cfquery>



<!--- <cfparam name="request.util_interference" default="">
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
  util_interference =  '#request.util_interference#'
, util_interference_comments =  '#toSqlText(request.util_interference_comments)#'
, pullbox_no = #toSqlNumeric(request.pullbox_no)#
, pullbox_comments = '#toSqlText(request.pullbox_comments)#'
, signage_no = #toSqlNumeric(request.signage_no)#
, signage_comments = '#toSqlText(request.signage_comments)#'
, st_furn_no = #toSqlNumeric(request.st_furn_no)#
, st_furn_comments = '#toSqlText(request.st_furn_comments)#'
, parking_meter_no = #toSqlNumeric(request.parking_meter_no)#
, survey_monument_no = #toSqlNumeric(request.survey_monument_no)#

where srrKey = '#request.srrKey#'
</cfquery>
--->



<cflocation addtoken="No" url="add_to_scope.cfm?srrKey=#request.srrKey#&#request.addtoken#"> 
