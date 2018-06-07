<cfinclude template="../common/validate_ArKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfif not isdefined("request.doc_desc") or  #request.doc_desc# is "">
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="Document Description is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif #len(request.doc_desc)# gt 150>
<cfmodule template="/accessprogram/common/error_msg.cfm" error_msg="Document Description cannot Exceed 150 characters!" showBackButton="1">
<cfabort>
</cfif>

<cfset request.file_name = getFileName("FileName")>
<cfset request.file_ext = getFileExt("FileName")>


<!-- check allowed file extensions -->
<cfif #request.file_ext# is not "jpg" AND #request.file_ext# is not "gif" AND #request.file_ext# is not "pdf" AND #request.file_ext# is not "png">
<div class = 'warning'>This File Format is not Acceptable</div>
<div class = 'warning'>jpg, gif, png, and pdf files are the only accepted formats</div>
<br><br>
<div align="center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfif>

<!-- check that file name does not exceed 150 charcters -->
<cfif len(#request.file_name#) gt 150>
<div class = 'warning'>File Name cannot exceed 150 characters (including extension).</div>
<br><br>
<div align="center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfif>

<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#request.upload_dir#">
</cfif>


<!-- CREATE REF. NO. DIRECTORY IF IT DOES NOT EXIST -->
<cfset request.upload_dir=#request.upload_dir#&"\"&#request.Ar_id#>
<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#request.upload_dir#">
</cfif>


<cftry>
<cffile action="UPLOAD" filefield="FILENAME" destination="#request.upload_dir#" nameconflict="ERROR">
<cfcatch>
<div class = 'warning'>Attachment was NOT successfully uploaded</div>
<br>
<div align="center">
<div align="left" style="width:700px;">
Please make sure that file name does not have any special characters like ?, :, ", ', /, \, #, ), (, %, ^ etc.
<br><br>
Please rename the file and try again.
</div>
</div>
<br><br>
<div align="center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfcatch>
</cftry>


<cffile action="RENAME" source="#request.upload_dir#\#serverfile#" destination="#request.upload_dir#\#request.file_name#">

<cfquery name="ADD_file_NAME" datasource="#request.dsn#" dbtype="datasource">
insert into uploads
(
ddate_uploaded,
ar_id,
file_name, 
doc_desc,
uploaded_by
)
values
(
#now()#,
#request.Ar_id#,
'#request.file_name#',
'#request.doc_desc#',
#client.staff_user_id#
)
</cfquery>

<cfquery name="updateAr" datasource="#request.dsn#" dbtype="datasource">
update Ar_info
set
record_history = ISNULL(record_history, '') + '|An attachment was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

where ArKey = '#request.ArKey#'
</cfquery>

<cflocation addtoken="No" url="control.cfm?action=attachments&ArKey=#request.ArKey#&#request.addtoken#">


