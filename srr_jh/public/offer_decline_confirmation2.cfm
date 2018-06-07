Document not needed anymore
<cfabort>

<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">

<style>
li {
margin-left: 25px;
padding: 10px;
}
</style>

<cfinclude template="../common/validate_srrKey.cfm">

<cfif not isdefined("form.accept") and not isdefined("form.decline")>


<div class="warning">
Invalid Request!
</div>
</cfif>

<cfif isdefined("form.accept")>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
offerAccepted_dt = #now()#
, record_history = record_history + '|Offer ACCEPTED by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'
where 
srrKey = '#request.srrKey#'
</cfquery>

<div class="textbox" style="width:700px;padding:10px;">
<h1>Instructions</h1>
<strong>You have accepted the City's offer for Sidewalk Repair Rebate Program.</strong>
<br><br>
The next steps are:

<ul>
<li>Submit a No-Fee Permit online (you will need to have your contractor's license number to complete this step)</li>
<li>Accept a No-Fee Tree Removal Permit (if applicable).</li>
</ul>
<br><br>
<strong>You will receive an email with links to perform the above steps when you are ready.</strong>

</div>


</cfif>

<cfif isdefined("form.decline")>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
offerDeclined_dt = #now()#
, record_history = record_history + '|Offer DECLINED by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'
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




</body>
</html>