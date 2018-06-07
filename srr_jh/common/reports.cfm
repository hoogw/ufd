<style>
.spacing {
margin-left:25px;
margin-bottom:15px;
}
</style>
<cfoutput>
<div class="textbox" style="width:700px;">
<h1>Reports/Metrics</h1>

<p>
<strong>Reports:</strong>
<ul>


<li class="spacing"><a href="https://engpermits.lacity.org/srr/common/rpt_valuation_est.cfm" target="_blank">Rebate Valuation Report</a></li>

<cfif isdefined("client.user_agency") and (#client.user_agency# is "SRP" or #client.user_agency# is "all")  >
<li class="spacing"><a href="https://engpermits.lacity.org/srr/common/srr_balance_sheet.cfm" target="_blank">Balance Sheet</a></li>
<li class="spacing"><a href="https://engpermits.lacity.org/srr/common/rpt_groupbystatus.cfm" target="_blank">Rebate Applications by Status</a></li>
<li class="spacing"><a href="https://engpermits.lacity.org/srr/reports/const_quantities_report.cfm" target="_blank">Sidewalk Rebate Requests Quantities Report</a></li>
<li class="spacing"><a href="control.cfm?action=DownloadALL1&#request.addtoken#">Download Sidewalk Rebate Report</a></li>
</cfif>
<!--- <li class="spacing"><a href="control.cfm?action=rpt_by_status&rpt_groupbyQueue.cfm#request.addtoken#">Applications Classified by Status</a></li> --->
</ul>
</p>
<br>
<p>
<strong>Metrics:</strong>
<br>
In-Queue and Performance Metrics will be provided to measure the wait time and performance against preset goals by each Bureau or Office.
<br><br>
Your feedback is required to set the goal for each metric.
</p>

</div>
</cfoutput>






<!--- <cfif isdefined("request.user") and #request.user# is "boe"> --->