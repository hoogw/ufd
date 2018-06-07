<cfmodule template="../common/header.cfm">		

<cfparam name="request.council_dist" default="All">

<CFQUERY NAME="find_srr" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(ar_status_cd), count(ar_id) as num
from ar_info
group by ar_status_cd 
--->
SELECT        dbo.ar_status.ar_status_cd,dbo.ar_status.ar_status_desc, ar_status.ar_list_order, COUNT(dbo.ar_info.ar_id) AS Num

FROM  dbo.ar_status RIGHT OUTER JOIN
               dbo.ar_info ON dbo.ar_status.ar_status_cd = dbo.ar_info.ar_status_cd

<cfif #request.council_dist# is not "All">
where ar_info.council_dist = #request.council_dist#
</cfif>


GROUP BY dbo.ar_status.ar_status_cd, dbo.ar_status.ar_status_desc, ar_status.ar_list_order

order by ar_status.ar_list_order
</CFQUERY> 

<CFQUERY NAME="total_ar" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
<!--- 	select distinct(ar_status_cd), count(ar_id) as num
from ar_info
group by ar_status_cd 
--->
SELECT       COUNT(dbo.ar_info.ar_id) AS total_ar
FROM           
dbo.ar_info 

</CFQUERY> 
		
		
 <style>

 li
  {margin: 30px;
  padding-bottom:0px;
 }
</style>

<div class="title">Access Program Applications Grouped by Status</div>



<div class="textbox" style=" width: 700px;">
<h1>Status Report</h1>

<table class="datatable" id="table1" style=" width:100%;">
<tr>
<th valign="top" >Status </th>
<th valign="top" >Number of Applications<br>In-Queue</th>


</tr>

<cfoutput query="find_srr">
<tr>
<td style="align:center;"><a href="rpt_groupbyQueue.cfm?ar_status_cd=#ar_status_cd#">#ar_status_desc#</a></td>
<td style="align:center;"><div align="center">#num#</div></td>
</tr>
</cfoutput>

<cfoutput>
<tr>
<td style="align:center;background:yellow;"><strong>Total Number of Applications</strong></td>
<td style="align:center;background:yellow;"><div align="center">#total_ar.total_ar#</div></td>
</tr>
</cfoutput>		
</table>
</div>

<cfinclude template="footer.cfm">		
		
		
<!--- 		<cfoutput><td align="center"><a href="rpt_groupbyQueue.cfm?request.ar_status_cd=#ar_status_cd#">#num#</a></td>
<td align="left">#ar_status_desc#</td>
</cfoutput> --->