
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">

<cfif not isdefined("request.file_no") or not isnumeric(#request.file_no#)>
<div class="warning">Invalid Request!</div>
<cfabort>
</cfif>

<cfquery name="getFileName" datasource="#request.dsn#" dbtype="datasource">
Select file_name from uploads
  where srr_id = #request.srr_id# and file_no = #request.file_no#
</cfquery>

<cfquery name="removeAttachment" datasource="#request.dsn#" dbtype="datasource">
delete from uploads
  where srr_id = #request.srr_id# and file_no = #request.file_no#
</cfquery>

<cftry>
<cffile action="DELETE" file="#request.upload_dir#\#request.srr_id#\#getFileName.file_name#">
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|An attachment was removed on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name# (BCA).'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cflocation addtoken="No" url="list_attachments.cfm?srrKey=#request.srrKey#&#request.addtoken#">