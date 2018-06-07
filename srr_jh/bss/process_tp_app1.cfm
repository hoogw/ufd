<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="findTpPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT 

tree_pruning_permit.srr_id
, tree_pruning_permit.ddate_submitted
, ISNULL(tree_info.nbr_trees_removed , 0) nbr_trees_removed
, ISNULL(tree_info.nbr_trees_pruned , 0) nbr_trees_pruned
, ISNULL(tree_info.lf_trees_pruned , 0) lf_trees_pruned
, srr_info.sr_number
, srr_info.sr_app_comments
, srr_info.sr_location_comments
, srr_info.sr_attachments
, srr_info.job_address
, srr_info.app_name_nn
, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.bca_comments
, srr_info.bss_comments
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_info.srrKey

FROM  dbo.tree_pruning_permit LEFT OUTER JOIN
               dbo.tree_info RIGHT OUTER JOIN
               dbo.srr_info ON dbo.tree_info.srr_id = dbo.srr_info.srr_id LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd ON dbo.tree_pruning_permit.srr_id = dbo.srr_info.srr_id
			   
WHERE
srr_info.srr_id = #request.srr_id#
</cfquery>




<cfoutput>

<div class="formbox" style="width:730px;">
<h1>Processing a Tree Root Pruning Permit</h1>



<cfinclude template="../common/item_list_treepruning.cfm">

You are about to electronically issue a Tree Root Pruning Permit Application.
<br><br>
No Changes can be made to the permit application after submitting the application.
<br><br>
<a href="../common/Print_TreePruningPermit.cfm?srrKey=#request.srrKey#" target="_blank">View Permit Application</a>
</div>

<div align="center"><input type="button" name="submitTP" id="submitTP" value="Issue Permit"  onClick="location.href='control.cfm?action=process_tp_app2&srrKey=#request.srrKey#&#request.addtoken#'" class="submit">


</div>
</cfoutput>





