<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="w_ft" default="0">
<cfparam name="w_in" default="0">
<cfparam name="a_ft" default="0">
<cfparam name="a_in" default="0">
<cfparam name="gw_in" default="0">
<cfparam name="ch_in" default="0">


<!-- generate new driveway_no -->
<cfquery name="count_driveways" datasource="apermits_sql" dbtype="datasource">
SELECT [driveway_id]
      ,[ref_no]
      ,[driveway_no]
      ,[driveway_case]
      ,[driveway_category]
      ,[driveway_material]
      ,[w_ft]
      ,[w_in]
      ,[a_ft]
      ,[a_in]
      ,[gw_ft]
      ,[gw_in]
      ,[ch_in]
      ,[items_near_driveway]
      ,[items_near_driveway_comments]
      ,[driveway_qty]
      ,[driveway_fee]
      ,[waive_driveway_fee]
      ,[driveway_fee_discount]
      ,[driveway_net_fee]
      ,[driveway_waiver_id]
  FROM [Apermits].[dbo].[driveway_details]
where
ref_no = #request.ref_no#
</cfquery>

<cfif #count_driveways.recordcount# is not 0>
<cfquery name="get_last_driveway" datasource="apermits_sql" dbtype="datasource">
select max(driveway_no) as last_no
from driveway_details
where ref_no=#request.ref_no#
</cfquery>
<cfset request.driveway_no=#get_last_driveway.last_no#+1>
<cfelse>
<cfset request.driveway_no=1>
</cfif>
<!-- generate new driveway_no -->

<cfinclude template="../common/generate_new_driveway_id.cfm">


<cfparam name="request.driveway_category" default="c">
<cfparam name="request.driveway_material" default="c">
<cfparam name="request.items_near_driveway" default="">
<cfparam name="request.driveway_case" default="">

<cfquery name="add_driveway" datasource="apermits_sql" dbtype="ODBC">
insert into driveway_details
(
driveway_id,
ref_no,
driveway_no,
driveway_case,
driveway_category,
driveway_material,
w_ft,
w_in,
a_ft,
a_in,
gw_in,
ch_in,
items_near_driveway,
items_near_driveway_comments,
eligible,
waive_driveway_fee,
driveway_waiver_id
)

values

(
#request.driveway_id#,
#request.ref_no#,
#request.driveway_no#,
'#request.driveway_case#',
'#request.driveway_category#',
'#request.driveway_material#',
#toSqlNumeric(request.w_ft)#,
#toSqlNumeric(request.w_in)#,
#toSqlNumeric(request.a_ft)#,
#toSqlNumeric(request.a_in)#,
#toSqlNumeric(request.gw_in)#,
#toSqlNumeric(request.ch_in)#,
'#toSqlText(request.items_near_driveway)#',
'#request.items_near_driveway_comments#',
'Y',
'Y',
22
)
</cfquery>

<cfquery name="update_app" datasource="apermits_sql" dbtype="datasource">
Update permit_info
Set
record_history=record_history+ 'A driveway was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name# (BCA).<br><br>'
, boe_comments_to_final = 'THIS PERMIT IS ISSUED UNDER THE SIDEWALK REPAIR REBATE PROGRAM.'
where ref_no=#request.ref_no#
</cfquery>

<cfinclude template="../common/calc_update_driveway.cfm">

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|A driveway was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name# (BCA).'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cflocation addtoken="No" url="list_driveways.cfm?srrKey=#request.srrKey#&#request.addtoken#">

