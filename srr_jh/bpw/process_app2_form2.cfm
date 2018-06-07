<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfparam name="request.filing_folder_created" default="">
<cfparam name="request.w9_on_file" default="">

<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfquery name="update_srr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
fakeUpdate = 1

, filing_folder_created = '#request.filing_folder_created#'

, w9_on_file = '#request.w9_on_file#'

<cfif #request.bpw1_internal_comments# is not "">
, bpw1_internal_comments= isnull(bpw1_internal_comments, '') + '|#toSqlText(request.bpw1_internal_comments)# - By:#client.full_name# on #dnow#.'
</cfif>


where srrKey = '#request.srrKey#'
</cfquery>