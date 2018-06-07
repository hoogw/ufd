<!--- <cfinclude template="../common/html_top.cfm">
<cfinclude template="/common/validate_ref_no.cfm">
 --->
 <cfinclude template="../common/validate_srrKey.cfm">

<!--- <cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT dbo.uploads.file_no, dbo.uploads.srr_id, dbo.uploads.ddate_uploaded, dbo.uploads.doc_desc, dbo.uploads.file_name, dbo.uploads.uploaded_by, 
               dbo.staff.first_name, dbo.staff.last_name, dbo.staff.user_agency
FROM  dbo.uploads LEFT OUTER JOIN
               dbo.staff ON dbo.uploads.uploaded_by = dbo.staff.user_id
WHERE uploads.srr_id=#request.srr_id#
</cfquery>
 --->
 <cfquery name="uploaded_files" DATASOURCE="#request.dsn#" dbtype="datasource">
SELECT * 
FROM uploads
WHERE srr_id=#request.srr_id# and file_no = #file_no#
</cfquery>


<cfset request.file_no = #uploaded_files.file_no#>


<cfoutput>
<div class = 'warning'>Are You Sure You want to delete attachment File Name: #request.file_name#?</div>

<br>
<br>
<div align="center">


  <input type="button" name="Yes" id="Yes" value="Yes" class="submit" onClick="location.href = 'control.cfm?action=delete_attachment&file_no=#request.file_no#&srrKey=#request.srrKey#&#request.addtoken#'">
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <input type="button" name="No" id="No" value="No" class="submit" onClick="location.href = 'control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#'">
</div>

</cfoutput>
<!--- 
<cfinclude template="../common/html_bottom.cfm"> --->