<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="findTRPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT 

Tree_removal_permit.srr_id
, Tree_removal_permit.ddate_submitted
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

FROM  dbo.Tree_removal_permit LEFT OUTER JOIN
               dbo.tree_info RIGHT OUTER JOIN
               dbo.srr_info ON dbo.tree_info.srr_id = dbo.srr_info.srr_id LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd ON dbo.Tree_removal_permit.srr_id = dbo.srr_info.srr_id
			   
WHERE
srr_info.srr_id = #request.srr_id#
</cfquery>


<cfoutput>

<form action="control.cfm?action=process_tr_app2&srrKey=#request.srrKey#&#request.addtoken#" method="post" name="form1" id="form1">
<div class="formbox" style="width:730px;">
<h1>Processing a Tree Removal Permit</h1>
<cfinclude template="../common/item_list_treeremoval.cfm">



<div class="field">
<label>CEQA checked</label>
<input type="radio" name="CEQA_checked" id="CEQA_checked" value="Y" required="Yes"> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="CEQA_checked" id="CEQA_checked" value="N" required="Yes"> No
</div>
<br>
You are about to electronically issue a Tree Removal Permit.
<br><br>
No Changes can be made to the permit application after issueing the permit.
<br><br>
<a href="../common/Print_TreeRemovalPermit.cfm?srrKey=#request.srrKey#" target="_blank">View Permit Application</a>
</div>



<div align="center"><input type="submit" name="submit" id="submit" value="Issue Permit" class="submit"></div>

</form>

</cfoutput>





