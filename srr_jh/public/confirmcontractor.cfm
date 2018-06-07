<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="updateContractor" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set

[cont_license_no] = '#left(request.cont_license_no, 15)#'
,[cont_name] = '#left(request.cont_name, 65)#'
,[cont_address] = '#left(request.cont_address, 75)#'
,[cont_city] = '#left(request.cont_city, 35)#'
,[cont_state] = '#left(request.cont_state, 2)#'
,[cont_zip] = '#left(request.cont_zip, 15)#'
,[cont_phone] = '#left(request.cont_phone, 20)#'
<cfif isdate(#request.cont_lic_issue_dt#)>
,[cont_lic_issue_dt] = #CreateODBCDate(request.cont_lic_issue_dt)#
</cfif>
<cfif isdate(#request.cont_lic_exp_dt#)>
,[cont_lic_exp_dt] = #CreateODBCDate(request.cont_lic_exp_dt)#
</cfif>
,[cont_lic_class] = '#left(request.cont_lic_class, 150)#'
,[cont_info_comp_dt] = #now()#

, record_history = isnull(record_history, '') + '|Contractor information was added by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srrKey = '#request.srrKey#'
</cfquery>

<cflocation addtoken="No" url="app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#">

