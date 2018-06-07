<cfmodule template="../common/header.cfm">		

<cfparam name="request.council_dist" default="All">

<CFQUERY NAME="find_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT        dbo.srr_status.srr_status_cd,dbo.srr_status.srr_status_desc, srr_status.srr_list_order, COUNT(dbo.srr_info.srr_id) AS Num

FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd

<cfif #request.council_dist# is not "All">
where srr_info.council_dist = #request.council_dist#
</cfif>


GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, srr_status.srr_list_order

order by srr_status.srr_list_order
</CFQUERY> 

<CFQUERY NAME="total_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT       COUNT(dbo.srr_info.srr_id) AS total_srr
FROM           
dbo.srr_info 

</CFQUERY> 
		
		
 <style>

 li
  {margin: 30px;
  padding-bottom:0px;
 }
</style>

<div class="title">Rebate Applications Grouped by Status</div>



<div class="textbox" style=" width: 700px;">
<h1>Status Report</h1>

<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Status </th>
<th valign="top" >Number of Applications<br>In-Queue</th>


</tr>

<cfoutput query="find_srr">
<tr>
<td style="align:center;"><a href="rpt_groupbyQueue.cfm?srr_status_cd=#srr_status_cd#">#srr_status_desc#</a></td>
<td style="align:center;"><div align="center">#num#</div></td>
</tr>
</cfoutput>

<cfoutput>
<tr>
<td style="align:center;background:yellow;"><strong>Total Number of Applications</strong></td>
<td style="align:center;background:yellow;"><div align="center">#total_srr.total_srr#</div></td>
</tr>
</cfoutput>		
</table>









<CFQUERY NAME="find_Pending" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview','received'))
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>




 <CFQUERY NAME="total_srr2" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">

SELECT       COUNT(dbo.srr_info.srr_id) AS total_srNum
FROM           dbo.srr_info
WHERE        (dbo.srr_info.srr_status_cd IN ('pendingBcaReview', 'PendingBoeReview', 'pendingBssReview'))

</CFQUERY> 
<!--- 		
<cfoutput>#total_srr2.total_srNum#</cfoutput> --->

<CFQUERY NAME="total_PermitIssue" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT        dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
                         dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
WHERE        (dbo.srr_status.srr_status_cd = 'requiredPermitsIssued')
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

</cfquery>

<div class="textbox" style=" width: 90%;">
<h1>Layout For Mayor  Report</h1>
<cfoutput>
<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Total Applications </th>
<th valign="top" >Numbers</th>

</tr>

 <tr>
<td style="align:center;">Pending Review (BCA,BOE,BSS,DPW) </td>
<td style="align:center;"><div align="center">#total_srr2.total_srNum#</div>


</td>
</tr>

<tr>
<td style="align:center;">Permit Issued </td>
<td style="align:center;"><div align="center">#total_PermitIssue.num#</div></td>

</tr>

<tr>
<td style="align:center;">Rebate Issued </td>
<td style="align:center;"><div align="center">&nbsp;</div></td>
</tr>

<tr>
<td style="align:center;background:yellow;"><strong>Total Number of Applications</strong></td>
<td style="align:center;background:yellow;"><div align="center">#total_srr.total_srr#</div></td>
</tr>
	
</cfoutput>




</table>
</div>

<!--- </cfoutput>
 --->


</div>



</div>

<cfinclude template="footer.cfm">		
		
		
<!--- 		<cfoutput><td align="center"><a href="rpt_groupbyQueue.cfm?request.srr_status_cd=#srr_status_cd#">#num#</a></td>
<td align="left">#srr_status_desc#</td>
</cfoutput> --->













<!--- </div> --->
<!--- 
<cfinclude template="footer.cfm">		
		
		 --->
<!--- 		<cfoutput><td align="center"><a href="rpt_groupbyQueue.cfm?request.srr_status_cd=#srr_status_cd#">#num#</a></td>
<td align="left">#srr_status_desc#</td>
</cfoutput> --->