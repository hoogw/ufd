<cfinclude template="../common/validate_srrKey.cfm">


<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, srr_info.job_address

FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd

where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<form action="control.cfm?action=override_status2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Overriding Application Status</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td>Current Status:</td>
	<td><strong>#getSRR.srr_status_desc#</strong></td>
</tr>

<tr>
	<td colspan="2"><strong>New Status:</strong></td>
</tr>

<tr>
	<td>Select an Action:</td>
	<td>
	<select name="srr_status_cd" id="srr_status_cd" required>
	
	<option value="received" SELECTED>Send to BPW for Eligibility Review</option>
	<option value="pendingBcaReview">Send to BCA for Assessment</option>
	<option value="pendingBssReview">Send to UFD/BSS for Assessment</option>
	<option value="pendingBoeReview">Send to BOE for Investigation</option>
	<option value="constCompleted" SELECTED>Send to BPW for Payment</option>
    <option value="cancelTicket">Cancel Application</option>
	<option value="waitListed">Move to Wait List</option>
	

	</select>
	</td>
</tr>


<tr>
	<td colspan="2">Justification for Status Change:
	<br>
	<textarea name="boe_invest_comments" id="boe_invest_comments" style="width:92%;height:120px;margin-top:5px;" placeholder="" required></textarea>
	</td>
</tr>



</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Change Status" class="submit"></div>

</FORM>
<!--- <br>
<div class="warning">Canceling an Application will close the MyLA311 Ticket.<br><br>This is an irreversible action.</div> --->

</cfoutput>





