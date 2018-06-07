<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
select srr_id, sr_number, srrKey
from 
srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>

<div class="formbox" style="width:700px;">
<h1>Apply for a No-Fee A-permit</h1>

The following items will be included on your application for an A-permit:

<div align="center">
<cfinclude template="../common/item_list_apermit.cfm">
</div>


</div>
<br>


<div class="formbox" style="width:700px;">
If you need to add to this scope of work, please click Add to Scope.
<br><br>
If you do NOT need to add to scope of work, please click Submit A-permit
</div>

<div align="center">
<input type="button" name="add" id="add" value="Add to Scope" class="submit" onClick="location.href = 'add_to_scope.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
&nbsp;&nbsp;
<input type="button" name="submitA" id="submitA" value="Submit A-Permit" class="submit" onClick="location.href = 'submit_apermit1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">

&nbsp;&nbsp;
<input type="button" name="laterA" id="laterA" value="I will Continue Later" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>

 
</cfoutput> 

</body>
</html>