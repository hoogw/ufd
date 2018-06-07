<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfset request.ref_no = #request.a_ref_no#>

<cfquery name="checkSubmittedA" datasource="apermits_sql" dbtype="datasource">
SELECT 
ref_no
, ddate_submitted
from permit_info
where ref_no = #request.ref_no#
</cfquery>
<cfoutput>

<cfif isdate(#checkSubmittedA.ddate_submitted#)>
<div class="warning">This A Permit was already submitted on #checkSubmittedA.ddate_submitted#</div>

<cfelse>

<div class="formbox" style="width:730px;">
<h1>Submit A-Permit</h1>
You are about to Submit your A-Permit Application.
<br><br>
No Changes can be made to the A-Permit after Submitting the application.
</div>

<div align="center"><input type="button" name="submitA" id="submitA" value="Submit my A-Permit"  onClick="location.href='submit_apermit2.cfm?srrKey=#request.srrKey#&#request.addtoken#'"></div>

</cfif>

<cfinclude template="../common/footer.cfm">

</cfoutput>