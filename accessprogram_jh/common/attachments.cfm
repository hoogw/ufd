<cfinclude template="../common/validate_arKey.cfm">

<cfquery name="ArAttachments" datasource="#request.dsn#" dbtype="datasource">
SELECT 
ar_id,
sr_attachments
from ar_info
where ar_id = #request.ar_id#
</cfquery>

<cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT dbo.uploads.file_no, dbo.uploads.ar_id, dbo.uploads.ddate_uploaded, dbo.uploads.doc_desc, dbo.uploads.file_name, dbo.uploads.uploaded_by, 
               dbo.staff.first_name, dbo.staff.last_name, dbo.staff.user_agency
FROM  dbo.uploads LEFT OUTER JOIN
               dbo.staff ON dbo.uploads.uploaded_by = dbo.staff.user_id
WHERE uploads.ar_id=#request.ar_id#
order by uploads.ddate_uploaded
</cfquery>

<cfoutput>

<div class="formbox" style="width:700px;">
<h1>MyLA311 Attachments</h1>

<cfif #ARAttachments.sr_attachments# is not "">
		<Cfset nn = 1>
		<cfloop index="xx" list="#ArAttachments.sr_attachments#" delimiters="|">
		<p style="text-align:left;paddin-left:15px;"><a href="#xx#" target="_blank">Attachment No. #nn#</a></p>
		<cfset nn = #nn# + 1>
		</cfloop>
<cfelse>
<p style="text-align:left;paddin-left:15px;">Applicant did not upload any documents with MyLA311 Service Request.</p>
<br>
</cfif>


</div>
<br>
<div style="width:700px; margin-left:auto;margin-right:auto;text-align:right;padding-right:10px;"><input type="button" name="add" id="add" value="Add Attachment" class="submit" onClick="location.href = 'control.cfm?action=uploadfile1&arKey=#request.arKey#&#request.addtoken#'"></div>

</cfoutput>
<div class="formbox" style="width:700px;">
<h1>Other Attachments</h1>
<cfif #uploaded_files.recordcount# is  0>
<br>
<span class="warning">No Attachments were added to this application</span>
<br><br>
<cfelse>
<table border="1" class="datatable" style="width: 100%;">

<tr>
<th>Document</th>
<th>File Name</th>
<th>Date Uploaded</th>
<th>Uploaded by</th>
<!---<th>Action</th>--->
</tr>
</cfif>


<cfoutput query="uploaded_files">
<tr>
<td><!-- This is to handle old uploads before adding the doc_desc field -->
<cfif #doc_desc# is not "">
#doc_desc#
<cfelse>
#file_name#
</cfif>
</td>
<td>
<cfif #right(file_name,4)# is  ".pdf">
<a href="/docs/accessprogram/uploads/#request.ar_id#/#file_name#" target="_blank">#file_name#</a>
<cfelse>
<a href="../common/display_attachment.cfm?file_name=#file_name#&arKey=#request.arKey#&#request.addtoken#" target="_blank">#file_name#</a>
</cfif>
</td>
<td style="text-align:center;">
#dateformat(Ddate_uploaded,"mm/dd/yyyy")#
</td>

<td style="text-align:center;">
<Cfif #uploaded_by# is "-1">
Applicant
<cfelse>
#first_name# #last_name#
</CFIF>
</td>
</tr>
</cfoutput>
</table>
</div>