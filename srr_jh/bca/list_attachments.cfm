<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<cfquery name="list_attachments" datasource="#request.dsn#" dbtype="datasource">
SELECT dbo.uploads.file_no, dbo.uploads.srr_id, dbo.uploads.ddate_uploaded, dbo.uploads.doc_desc, dbo.uploads.file_name, dbo.uploads.uploaded_by, 
               dbo.staff.first_name, dbo.staff.last_name
FROM  dbo.staff LEFT OUTER JOIN
               dbo.uploads ON dbo.staff.user_id = dbo.uploads.uploaded_by
			   
where srr_id = #request.srr_id#
</cfquery>

<div class="divSubTitle">
Attachments
</div>

<cfoutput>
<div style="text-align:right;margin-left:auto;margin-right:auto;width:95%;">
<input type="button" name="addAttachment" id="addAttachment" value="Add Attachment" style="margin-right:10px;" onClick="location.href='add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
</cfoutput>


<div align="center">
<table style="width:95%;" class="datatable">
<tr>
	<th>No.</th>
	<th>Description</th>
	<th>Added By</th>
	<th>Action</th>
</tr>

<cfset xx = 1>
<cfoutput query="list_attachments">
<tr>
<tr>
	<td style="text-align:center;">#xx#</td>
	<td style="text-align:left;"><a href="/docs/srr/uploads/#srr_id#/#file_name#">#doc_desc#</a></td>
	<td style="text-align:center;">#first_name# #last_name#<br>#dateformat(ddate_uploaded,"mm/dd/yyyy")# #timeformat(ddate_uploaded,"h:mm tt")#</td>
	<td style="text-align:center;"><a href="remove_attachment.cfm?srrKey=#request.srrKey#&file_no=#list_attachments.file_no#&#request.addtoken#">Remove</a></td>
</tr>
<cfset xx = #xx# +1>
</cfoutput>


</table>
</div>


<cfinclude template="footer.cfm">
