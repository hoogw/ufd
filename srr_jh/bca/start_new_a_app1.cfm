<cfquery name="get_cust" datasource="srr" dbtype="datasource">
SELECT 
	  [srr_id]
      ,[sr_number]
      ,[a_ref_no]
      ,[app_id]
      ,[app_name_nn]
      ,[app_contact_name_nn]
      ,[app_address1_nn]
      ,[app_address2_nn]
      ,[app_city_nn]
      ,[app_state_nn]
      ,[app_zip_nn]
      ,[app_phone_nn]
      ,[app_email_nn]
      ,[job_address]

      ,[zip_cd]
      ,[unit_range]
	  
      ,[hse_nbr]
      ,[hse_dir_cd]
      ,[str_nm]
      ,[str_sfx_cd]
      ,[longitude]
      ,[latitude]
      ,[boe_dist]
      ,[council_dist]
      ,[bpp]
      ,[pind]
      ,[address_verified]
      ,[hse_id]
      ,[tbm_grid]
      ,[srrKey]
  FROM [srr].[dbo].[srr_info]
  where srrKey = '#attributes.srrKey#'
</cfquery>

<!---<cfdump var="#get_cust#" output="browser">--->



<!-- check the current rate number --><!-- Activate New Rates as of March 06, 2016 -->
<cfset request.idate="12/11/2016">
<cfset request.idate=#dateformat(request.idate,"mm/dd/yyyy")#>
<cfset request.nnow=#dateformat(now(),"mm/dd/yyyy")#>
<!-- note 1 means first date greater than second, 0 means first date is equal to second date, -1, means first date less than second date -->
<cfif datecompare(#request.nnow#, #request.idate#) is 1  or datecompare(#request.nnow#, #request.idate#) is 0>
<cfset request.rate_nbr=13>
<cfelse>
<cfset request.rate_nbr=12>
</cfif>
<!-- check the current rate number -->


<!---<cfquery name="get_rates" datasource="apermits_sql" dbtype="datasource">
select * from fee_rates where rate_nbr=#request.rate_nbr#
</cfquery>--->


<cfquery name="add_to_permit_info" DATASOURCE="apermits_sql" dbtype="datasource">
INSERT INTO permit_info
(
ref_no
, rate_nbr
, app_id
, receive_method
, permit_type 

, app_name_nn
, app_contact_name_nn
, app_address1_nn
, app_address2_nn
, app_city_nn
, app_state_nn
, app_zip_nn
, app_phone_nn
, app_email_nn
, app_role


, prop_address
, boe_dist
, council_dist
, bpp
, pind


, application_status
, srrKey
, srr_id
, sr_number
, waive_basic_fee
, waive_basic_fee_waiver_id
)

VALUES (
#attributes.ref_no#
, #request.rate_nbr#
, #get_cust.app_id#
, 'I'
, 'n'

, '#get_cust.app_name_nn#'
, '#get_cust.app_contact_name_nn#'
, '#get_cust.app_address1_nn#'
, '#get_cust.app_address2_nn#'
, '#get_cust.app_city_nn#'
, '#get_cust.app_state_nn#'
, '#get_cust.app_zip_nn#'
, '#get_cust.app_phone_nn#'
, '#get_cust.app_email_nn#'
, 'HO'

, '#get_cust.job_address#'
, '#get_cust.boe_dist#'
, '#get_cust.council_dist#'
, '#get_cust.bpp#'
, '#get_cust.pind#'

, 'inProgress'
, '#attributes.srrKey#'
, '#get_cust.srr_id#'
, '#get_cust.sr_number#'
, 1
, 22
)
</cfquery>

<cfinclude template="generate_new_other_items_id.cfm">
<cfquery name="insert_other_items" datasource="apermits_sql" dbtype="datasource">
insert into other_items
(
  record_id
, ref_no
)
values
(
  #request.record_id#
, #request.ref_no#
)
</cfquery>


<!---<div align="center"><strong>Added Permit</strong><br><br></div>--->




<cfquery name="add_start_app" DATASOURCE="apermits_sql" dbtype="datasource">
insert into
screen_dates
(
ref_no
, start_app_dt
, start_app_by
)

values
(
#attributes.ref_no#
, #now()#
, 99999
)
</cfquery>

<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

applicant_screen_dt = #now()#
, applicant_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>


<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

job_address_screen_dt = #now()#
, job_address_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>

<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

other_items_screen_dt = #now()#
, other_items_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>

<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

work_desc_screen_dt = #now()#
, work_desc_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>

<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

sidewalk_screen_dt = #now()#
, sidewalk_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>

<cfquery name="update_screen_dates" DATASOURCE="apermits_sql" dbtype="datasource">
UPDATE screen_dates
SET

driveway_screen_dt = #now()#
, driveway_screen_by = 99999

WHERE ref_no=#attributes.ref_no#
</cfquery>



<!---<div align="center"><strong>Added screen dates<br><br></strong></div>--->