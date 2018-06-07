<cfquery name="get_cust" datasource="customers" dbtype="datasource">
SELECT [Record_id]
      ,[app_id]
      ,[app_name]
      ,[app_title]
      ,[app_contact_name]
      ,[app_address1]
      ,[app_address2]
      ,[app_city]
      ,[app_state]
      ,[app_zip]
      ,[app_phone]
      ,[app_email]
      ,[app_password]
      ,[app_notifications]
      ,[app_suspend]
      ,[ddate_modified]
      ,[theKey]
      ,[user_name]
      ,[app_history]
      ,[last_login_dt]
	  
	  
  FROM [customers].[dbo].[customers]
  where app_id = #client.app_id#
</cfquery>

<!--- <cfoutput>
INSERT INTO srr_info
(
app_id
,receive_method
,app_name_nn
,app_contact_name_nn
,app_address1_nn
,app_address2_nn
,app_city_nn
,app_state_nn
,app_zip_nn
,app_phone_nn
,app_email_nn

, srr_status

)

VALUES (
#client.app_id#
,'I'
,'#get_cust.app_name#'
,'#get_cust.app_contact_name#'
,'#get_cust.app_address1#'
,'#get_cust.app_address2#'
,'#get_cust.app_city#'
,'#get_cust.app_state#'
,'#get_cust.app_zip#'
,'#get_cust.app_phone#'
,'#get_cust.app_email#'

, 'inProgress'
)
</cfoutput>

<cfabort>
 --->
<cfquery name="add_to_srr_info" DATASOURCE="#request.dsn#" dbtype="datasource">
INSERT INTO srr_info
(
app_id
,receive_method
,app_name_nn
,app_contact_name_nn
,app_address1_nn
,app_address2_nn
,app_city_nn
,app_state_nn
,app_zip_nn
,app_phone_nn
,app_email_nn


,mailing_address1
,mailing_address2
,mailing_zip
,mailing_city
,mailing_state

, srr_status_cd

)

VALUES (
#client.app_id#
, 'I'
, '#get_cust.app_name#'
, '#get_cust.app_contact_name#'
, '#get_cust.app_address1#'
, '#get_cust.app_address2#'
, '#get_cust.app_city#'
, '#get_cust.app_state#'
, '#get_cust.app_zip#'
, '#get_cust.app_phone#'
, '#get_cust.app_email#'


, '#get_cust.app_address1#'
, '#get_cust.app_address2#'
, '#get_cust.app_zip#'
, '#get_cust.app_city#'
, '#get_cust.app_state#'

, 'inProgress'
)

SELECT @@IDENTITY AS 'srr_id'
</cfquery>

<cfset request.srr_id = #add_to_srr_info.srr_id#>

<!--- <cfoutput>
insert into


screen_dates
(
srr_id
, start_app_dt
, start_app_by
)

values
(
#request.srr_id#
, #now()#
, -1
)
</cfoutput>
<cfabort> --->

<cfquery name="add_start_app" DATASOURCE="#request.dsn#" dbtype="datasource">
insert into
screen_dates
(
srr_id
, start_app_dt
, start_app_by
, applicant_screen_dt
, applicant_screen_by
)

values
(
#request.srr_id#
, #now()#
, -1
, #now()#
, -1
)
</cfquery>

<cflocation addtoken="No" url="control.cfm?action=start_new_app2&srr_id=#request.srr_id#&#request.addtoken#">