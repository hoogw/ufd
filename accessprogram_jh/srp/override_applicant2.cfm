<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">
<cfset dnow = #dateformat(now(),"mm/dd/yyyy")#&" at: "&#timeformat(now(),"h:mm tt")#>

<cfif #trim(request.new_app_name)# is not "">
<cfquery name="updateApplicant" datasource="#request.dsn#" dbtype="datasource">
Update ar_info
SET

app_name_nn = '#request.new_app_name#'
, justification = isnull(justification, '') + '|#request.justification#'
, record_history = isnull(record_history, '') + '|Applicant name was changed from '+app_name_nn+' to #request.new_app_name# by #client.full_name# on #dnow#.  <br>Justification: #request.justification#'

where
arKey = '#request.arKey#'

</cfquery>
<div class="warning">Applicant Name was Successfully Updated</div>
<cfelse>
<div class="warning">Applicant Name was NOT Updated</div>
</cfif>