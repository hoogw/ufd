<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">


<cfif not isdefined("request.CEQA_checked")>
<div class = "warning">
You must select Yes or No for CEQA Checked
</div>
<cfabort>
</cfif>

<cfquery name="IssueTRPermit" datasource="#request.dsn#" dbtype="datasource">
update tree_removal_permit
set 
bss_ddate_issued= #now()#
, bss_issued_by = #client.staff_user_id#
, CEQA_checked = '#request.CEQA_checked#'
where srr_id = #request.srr_id#
</cfquery>

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|A tree removal permit was issued on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cfoutput>
<div class="warning">
Tree Removal Permit is Issued
<br><br>
<a href="../common/Print_TreeRemovalPermit.cfm?srrKey=#request.srrKey#" target="_blank">View Tree Removal Permit</a>
</div>

</cfoutput>