<cfinclude template="/srr/common/validate_srr_id.cfm">


<cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT * 
FROM uploads
WHERE REF_NO=#request.ref_no#
</cfquery>

<!--- <cfif #uploaded_files.recordcount# is 0>
<cfoutput>
<div class="textbox" style="width:700px;">
<h1>Attachments</h1>
No Attachments were added to this application.
</div>
<div align="center"><input type="button" name="uppload" id="upload" value="Add Attachments" class="submit" onClick="location.href = 'uploadfile1.cfm?ref_no=#request.ref_no#&#request.addtoken#'"></div>
</cfoutput>
<cfabort>
</cfif> --->


<!---<cfoutput>
<div align="center">
<div align="right" style="width:700px; padding-bottom:10px; font-size:105%;">
<a href="uploadfile1.cfm?ref_no=#request.ref_no#&#request.addtoken#">Add Attachment</a>
</div>
</div>
</cfoutput>--->




<div class="formbox" style="width:700px;">
<h1>Attachments</h1>
<cfif #uploaded_files.recordcount# is  0>
<span class="warning">No Attachments were added to this application</span>
<cfelse>
<table border="1" class="datatable" style="width: 100%;">

<tr>
<th>Description</th>
<th>File Name</th>
<th>Date Uploaded</th>
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
<a href="/docs/apermits/uploads/#request.ref_no#/#file_name#" target="_blank">#file_name#</a>
<cfelse>
<a href="../common/display_attachment.cfm?file_name=#file_name#&ref_no=#request.ref_no#&#request.addtoken#" target="_blank">#file_name#</a>
</cfif>
</td>
<td style="text-align:center;">
#dateformat(Ddate_uploaded,"mm/dd/yyyy")#
</td>
</tr>
</cfoutput>
</table>
</div>

<!--- <cfoutput>
<div align="center">
<input type="button" name="uppload" id="upload" value="Add Attachments" class="submit" onClick="location.href = 'uploadfile1.cfm?ref_no=#request.ref_no#&#request.addtoken#'">
</div>
</cfoutput> --->


<!---<cfelse>--->
<!---<cfoutput>
<div class='title'>NO ATTACHMENT(S) WERE UPLOADED WITH THIS APPLICATION</div>
<br>
<div align="center"><a href="../public/uploadfile1.cfm?ref_no=#request.ref_no#&permit_type=#request.permit_type#&#request.addtoken#">Add Attachment</a></div>
</cfoutput>--->
<!---</CFIF>--->