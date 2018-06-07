<cfmodule template="../common/header.cfm">		


<CFQUERY NAME="find_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(srr_status_cd), count(srr_id) as num
from srr_info
group by srr_status_cd 
--->
SELECT        dbo.srr_status.srr_status_cd,dbo.srr_status.srr_status_desc, COUNT(dbo.srr_info.srr_id) AS Num
FROM            dbo.srr_status INNER JOIN
dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd
GROUP BY dbo.srr_status.srr_status_cd, dbo.srr_status.srr_status_desc

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
<td style="align:center;"><a href="rpt_listByCD.cfm?request.council_dist=#council_dist#">#council_dist#</a></td>
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
</div>

<cfinclude template="footer.cfm">		
		
		
<!--- 		<cfoutput><td align="center"><a href="rpt_groupbyQueue.cfm?request.srr_status_cd=#srr_status_cd#">#num#</a></td>
<td align="left">#srr_status_desc#</td>
</cfoutput> --->