<style>
li {
margin-left:25px;
}
</style>

<cfoutput>
<div class="textbox" style="width:700px;">
<h1>Prepare Document(s)</h1>

<ul>
<li><a href="control.cfm?action=prep_not_eligible_ltr1&srr_id=#request.srr_id#&#request.addtoken#">Prepare &quot;Not Eligible Letter&quot; to Applicant</a></li>
<li><a href="control.cfm?action=print_not_eligible_ltr_pdf&srr_id=#request.srr_id#&#request.addtoken#" target="_blank">Print &quot;Not Eligible Letter&quot; to Applicant</a></li>
</ul>

</div>
</cfoutput>