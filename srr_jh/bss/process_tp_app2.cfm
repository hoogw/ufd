<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="IssueTPPermit" datasource="#request.dsn#" dbtype="datasource">
update tree_pruning_permit
set 
bss_ddate_issued= #now()#
, bss_issued_by = #client.staff_user_id#
where srr_id = #request.srr_id#
</cfquery>

<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = record_history + '|A tree root pruning permit was issued on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cfoutput>
<div class="warning">
Tree Root Pruning Permit is Issued
<br><br>
<a href="../common/Print_TreePruningPermit.cfm?srrKey=#request.srrKey#" target="_blank">View Tree Root Pruning Permit</a>
</div>

</cfoutput>