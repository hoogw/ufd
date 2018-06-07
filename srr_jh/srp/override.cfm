<cfinclude template="../common/validate_srrKey.cfm">

<cfoutput>
<div class="textbox" style="width:700px;">
<h1>Overriding Utilities:</h1>

<p><a href="control.cfm?action=override_applicant1&srrKey=#request.srrKey#&#request.addtoken#">Override Applicant Name</a></p>

<p><a href="control.cfm?action=override_address1&srrKey=#request.srrKey#&#request.addtoken#">Override Applicant Address</a></p>

<p><a href="control.cfm?action=override_rebate_mailing_address1&srrKey=#request.srrKey#&#request.addtoken#">Override Rebate Mailing Address</a></p>

<p><a href="control.cfm?action=remove_contractor1&srrKey=#request.srrKey#&#request.addtoken#">Remove Contractor Information</a></p>

<cfif #request.status_cd# is "cancelTicket" or #request.status_cd# is "closeTicket">
<p>Current Status: <strong>#request.status_desc#</strong> - Override Status is not permitted.</p>
<cfelse>
<p><a href="control.cfm?action=override_status1&srrKey=#request.srrKey#&#request.addtoken#">Override Application Status</a></p>
</cfif>


<p><a href="control.cfm?action=override_rebate_rate1&srrKey=#request.srrKey#&#request.addtoken#">Override Rebate Rate/Cap</a></p>

<p><a href="control.cfm?action=create_child_ticket2&srrKey=#request.srrKey#&#request.addtoken#">Create Child Ticket for UFD Tree Inspection</a></p>

<!--- <p>Close Ticket</p> --->

</div>
</cfoutput>
