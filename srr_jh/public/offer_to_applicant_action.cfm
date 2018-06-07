Canceled Document!
<cfabort>
<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">

<cfoutput>

<style>
li {
margin-left: 25px;
padding: 10px;
}
</style>


<cfif isdefined("form.accept")>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
offer_accepted_ddate = #now()#
where 
srrKey = '#request.srrKey#'
</cfquery>
</cfif>

<cflocation addtoken="No" url="app_requirements.cfm?srrKey=#request.srrKey#">

<div class="textbox" style="width:700px;">
<h1>Instructions</h1>
<p style="padding:7px;">
<strong>You have accepted the City's offer for Sidewalk Repair Rebate Program.</strong>
<br><br>
The next steps are:

<ul>
<li>You can add to the scope of work.  Since the rebate applies only to the work necessary to make the pathways around the property ADA compliant, you may elect to perform additional work and include that on the No-Fee A-permit.</li>

<li>Once you added the additional work to be included on the A-permit or if you do not have any additional work, you may proceed to submit a No-Fee A-Permit. </li>

<li>To Submit a No-Fee Permit online, you will need to have your contractor's license number to complete this step)</li>

<li>Accept a No-Fee Tree Removal Permit (if applicable).</li>

<li>If you would to continue this process later, please make sure you use the link labeled Submit A-Permit.</li>
</ul>
<br><br>
</p>
</div>

<div class="formbox" style="width:700px;">
If you need to add to this scope of work, please click Add to Scope.
<br><br>
If you do NOT need to add to scope of work, please click Submit A-permit
</div>

<div align="center">
<input type="button" name="add" id="add" value="Add to Scope" class="submit" onClick="location.href = 'add_to_scope.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
&nbsp;&nbsp;
<input type="button" name="submitA" id="submitA" value="Submit A-Permit" class="submit" onClick="location.href = 'submit_a_permit.cfm?srrKey=#request.srrKey#&#request.addtoken#'">

&nbsp;&nbsp;
<input type="button" name="laterA" id="laterA" value="I will Continue Later" class="submit" onClick="location.href = 'later_a_permit.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>




<!--- <cfif isdefined("form.decline")>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
offer_declined_ddate = #now()#
where 
srrKey = '#request.srrKey#'
</cfquery>

<div class="textbox" style="width:700px;padding:10px;">
<h1>Instructions</h1>
<strong>You have Declined the City's offer for Sidewalk Repair Rebate Program.</strong>
<br><br>
<strong>You will receive an email confirmation.</strong>

</div>
</cfif>
 --->

</cfoutput>

<cfinclude template="../common/footer.cfm">