<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">

<cfoutput>

<cfinclude template="../common/include_sr_job_address.cfm">

<div class="formbox" style="width:730px;">
<h1>Submit A Tree Removal Permit</h1>

<cfinclude template="../common/item_list_treeremoval.cfm">

You are about to Submit your a Tree Removal Permit Application.
<br><br>
No Changes can be made to the permit application after submitting the application.

</div>

<div align="center"><input type="button" name="submitTR" id="submitTR" value="Submit my Tree Removal Permit"  onClick="window.location.href='submit_tree_removal_permit2.cfm?srrKey=#request.srrKey#&#request.addtoken#'" class="submit">
&nbsp;&nbsp;
<input type="button" name="toReq" id="toReq" value="Back to Requirements"  onClick="window.location.href='app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'" class="submit">

</div>
</cfoutput>
<cfinclude template="../common/footer.cfm">