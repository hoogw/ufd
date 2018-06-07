<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">


<cfquery name="list_comments" datasource="#request.dsn#" dbtype="datasource">
SELECT dbo.bca_comments.comment_id, dbo.bca_comments.comment_txt, dbo.bca_comments.comment_by, dbo.bca_comments.comment_ddate, 
               dbo.bca_comments.srr_id, dbo.staff.first_name, dbo.staff.last_name
FROM  dbo.bca_comments LEFT OUTER JOIN
               dbo.staff ON dbo.bca_comments.comment_by = dbo.staff.user_id
			   
where 
srr_id = #request.srr_id#
</cfquery>

<div class="divSubTitle">
Comments
</div>

<cfoutput>
<div style="text-align:right;margin-left:auto;margin-right:auto;width:95%;">
<input type="button" name="addComment" id="addComment" value="Add Comment" style="margin-right:10px;" onClick="location.href='add_comment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>



<div align="center">
<table style="width:95%;" class="datatable">
<tr>
	<th>No.</th>
	<th>Comment</th>
	<th>By/Date</th>
</tr>

<cfset xx = 1>
<cfoutput query="list_comments">
<tr>
	<td style="text-align:center;">#xx#</td>
	<td style="text-align:left;">#comment_txt#</td>
	<td style="text-align:center;">#first_name# #last_name#<br>#dateformat(comment_ddate,"mm/dd/yyyy")# #timeformat(comment_ddate,"h:mm tt")#</td>
</tr>
<cfset xx = #xx# +1>
</CFOUTPUT>

</table>
</div>


<cfinclude template="footer.cfm">
