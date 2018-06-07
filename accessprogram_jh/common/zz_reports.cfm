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
	<div align="left">
			<!--- <li class="spacing"><a href="/srr/common/srr_balance_sheet.cfm" target="_blank">Balance Sheet for the Sidewalk Repair Rebate Program</a></li> --->
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="http://boe.ci.la.ca.us/divisions/safesidewalk/index.htm" target="_blank">Summary Report by Status from Inception to Date</a><br>
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><i>Summary Reports by  Date Range:</i></strong><br>
			<!--- <li class="spacing"><a href="control.cfm?action=rpt_by_status&rpt_groupbyQueue.cfm#request.addtoken#">Applications Classified by Status</a></li> --->
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="control.cfm?action=Rpt_Count_Summary1&#request.addtoken#">Summary Report by Status</a><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="control.cfm?action=Rpt_Count_Submittals1&#request.addtoken#">Count of Received Access Requests</a><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="control.cfm?action=Rpt_Count_Approved_DOD1&#request.addtoken#">Count of Application Approved By DOD</A><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="control.cfm?action=Rpt_Count_Approved_BSS1&#request.addtoken#">Count of Application Completed by BSS</a> <br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <a href="control.cfm?action=Rpt_Search_Status1&#request.addtoken#">Search by Status</a>
		</p>
	</div>
</ul>
</p>

<br>
<br>

<!--- <p>
<strong>Metrics:</strong>
<br>
<div align="center"><strong>UNDER CONSTRUCTION</strong></div>
</p> --->

</div>
</cfoutput>