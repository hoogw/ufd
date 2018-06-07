<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<!--- <cfoutput>
select * 
from srr_info
where 
srrKey = '#request.srrKey#'
</cfoutput>
 --->
<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
select * from srr_info
where 
srrKey = '#request.srrKey#'
</cfquery>

<cfif #getSrr.recordcount# is 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfabort>
</cfif>

<cfif not isdefined("request.doc_desc") or  #request.doc_desc# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Document Description is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif #len(request.doc_desc)# gt 150>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Document Description cannot Exceed 150 characters!" showBackButton="1">
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
<cfset request.upload_dir=#request.upload_dir#&"\"&#getSrr.srr_id#>
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
srr_id,
file_name, 
doc_desc,
uploaded_by
)
values
(
#now()#,
#getSrr.srr_id#,
'#left(request.file_name,100)#',
'#left(request.doc_desc,100)#',
-1
)
</cfquery>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
app_last_update_dt = #now()#

, record_history = record_history + '|Applicant added an attachment on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'

where srrKey = '#request.srrKey#'
</cfquery>


<cflocation addtoken="No" url="attachments.cfm?srrKey=#request.srrKey#">


