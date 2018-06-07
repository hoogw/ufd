
<cfinclude template="../common/validate_srrKey.cfm">
<!--- <cfinclude template="../common/myCFfunctions.cfm">
 --->



<cfquery name="read_it" DATASOURCE="#request.dsn#" dbtype="datasource">
select *  FROM uploads
WHERE srr_id=#request.srr_id# and file_no = #request.file_no#
</cfquery>


<cfset request.file_name = #read_it.file_name#>
<!--- 
<cfoutput>#request.file_name#</cfoutput> --->

<!--- <cftry> --->

 <cfquery name="delete_upload" datasource="#request.dsn#" dbtype="datasource">
delete FROM uploads
where srr_id = #request.srr_id# and file_no = #request.file_no#

</cfquery>
<!--- <cfcatch>


 <cfabort>
</cfcatch>
</cftry>
 --->

 <cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
record_history = record_history + '|An attachment file name: #request.file_name# was deleted on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name# (SRP).'

where srrKey = '#request.srrKey#'
</cfquery> 
<!--- 
<cflocation url="review_attachments.cfm?ref_no=#request.ref_no#" ADDTOKEN="yes">
 --->
 
 
<cflocation addtoken="No" url="control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#">

