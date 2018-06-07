<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="updateMailing" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
[mailing_address1] = '#request.mailing_address1#'
,[mailing_address2] = '#request.mailing_address2#'
,[mailing_city] = '#request.mailing_city#'
,[mailing_state] = '#request.mailing_state#'
,[mailing_zip] = '#request.mailing_zip#'

, mailing_address_comp_dt = #now()#

, record_history = record_history + '|Mailing address was provided by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srrKey = '#request.srrKey#'
</cfquery>

<cflocation addtoken="No" url="app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#">

