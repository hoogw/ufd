<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="SRAttachments" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT sr_attachments
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT dbo.uploads.file_no, dbo.uploads.srr_id, dbo.uploads.ddate_uploaded, dbo.uploads.doc_desc, dbo.uploads.file_name, dbo.uploads.uploaded_by, 
               dbo.staff.first_name, dbo.staff.last_name, dbo.staff.user_agency
FROM  dbo.uploads LEFT OUTER JOIN
               dbo.staff ON dbo.uploads.uploaded_by = dbo.staff.user_id
WHERE 
uploads.srr_id=#request.srr_id#
and uploads.uploaded_by = -1
</cfquery>

<cfoutput>
<div style="width:700px; margin-left:auto;margin-right:auto;text-align:right;padding-right:10px;"><input type="button" name="add" id="add" value="Add Attachment" class="submit" onClick="location.href = 'uploadFile1.cfm?srrKey=#request.srrKey#'"></div>

<div class="formbox" style="width:700px;">
<h1>Attachments</h1>

<cfif #SRAttachments.sr_attachments# is not "">
<strong>MyLA311 Attachments:</strong>
		<Cfset nn = 1>
		<cfloop index="xx" list="#SRAttachments.sr_attachments#" delimiters="|">
		<div align="left"><a href="#xx#" target="_blank">Attachment No. #nn#</a></div>
		<cfset nn = #nn# + 1>
		</cfloop>
<cfelse>
<p style="text-align:left;">Applicant did not upload any documents with MyLA311 Service Request.</p>
<br>
</cfif>

</cfoutput>
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
<a href="/docs/srr/uploads/#request.srr_id#/#file_name#" target="_blank">#file_name#</a>
<cfelse>
<a href="../common/display_attachment.cfm?file_name=#file_name#&srrKey=#request.srrKey#&#request.addtoken#" target="_blank">#file_name#</a>
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
<br>

<cfoutput>
<div style="width:700px; margin-left:auto;margin-right:auto;text-align:center;padding-right:10px;"><input type="button" name="finished" id="finished" value="I&lsquo;m Finished" class="submit" onClick="location.href = 'IamFinished.cfm?srrKey=#request.srrKey#'"></div>
</cfoutput>
<cfinclude template="../common/footer.cfm">

<!--- <cfoutput>
<div align="center">
<input type="button" name="uppload" id="upload" value="Add Attachments" class="submit" onClick="location.href = 'uploadfile1.cfm?srr_id=#request.srr_id#&#request.addtoken#'">
</div>
</cfoutput> --->


<!---<cfelse>--->
<!---<cfoutput>
<div class='title'>NO ATTACHMENT(S) WERE UPLOADED WITH THIS APPLICATION</div>
<br>
<div align="center"><a href="../public/uploadfile1.cfm?srr_id=#request.srr_id#&permit_type=#request.permit_type#&#request.addtoken#">Add Attachment</a></div>
</cfoutput>--->
<!---</CFIF>--->