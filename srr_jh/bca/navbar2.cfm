<cfquery name="getNavbar2" datasource="#request.dsn#" dbtype="datasource">
Select srr_id, job_address, zip_cd , a_ref_no, sr_number
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>


<cfoutput>
<!--- <div align="center">srr_id = #getNavbar2.srr_id#, a_ref_no = #getNavbar2.a_ref_no#</div> --->
<div align="center">
<table style="width:95%;">
<tr>
	<td style="text-align:center;"><a href="view_unprocessed.cfm?#request.addtoken#"><img src="/srr/images/MobileButton_Home.png" alt="" width="48" height="48" border="0"></a></td>
	<td style="text-align:center;"><a href="application_options.cfm?srrKey=#request.srrKey#&#request.addtoken#"><img src="/srr/images/MobileButton_Edit.png" alt="" width="48" height="48" border="0"></a></td>
	<td style="text-align:center;"><a href="propertyReport.cfm?srrKey=#request.srrKey#&#request.addtoken#"><img src="/srr/bca/images/report.png" alt="" width="48" height="48" border="0"></a></td>
	<td style="text-align:center;"><a href="search1.cfm?#request.addtoken#"><img src="/srr/images/MobileButton_Search.png" alt="" width="48" height="48" border="0"></a></td>
	<td style="text-align:center;"><a href="logout.cfm?#request.addtoken#"><img src="/srr/images/MobileButton_Logout.png" alt="" width="48" height="48" border="0"></a></td>
</tr>
</table>

<div style="color:maroon;font-weight:bold;text-align:center;margin-top:5px;margin-bottom:5px;">#ucase(getNavbar2.job_address)# <!---#getNavbar2.zip_cd#---></div>
<h2>SR Number: #getNavbar2.sr_number#</h2>
</div>
</cfoutput>