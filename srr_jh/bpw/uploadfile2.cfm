<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">

<cfinclude template="../common/myCFfunctions.cfm">

<cfinclude template="../common/validate_srrKey.cfm">

<!--- <cfoutput>
select * 
from srr_info
where 
srrKey = '#request.srrKey#'
</cfoutput>
 --->
<!--- <cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
select * from srr_info
where 
srr_id = '#request.srr_id#'
</cfquery> --->

<!--- <cfif #getSrr.recordcount# is 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfabort>
</cfif>
 --->
 
<cfif not isdefined("request.doc_desc") or  #request.doc_desc# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Document Description is Required!" showBackButton="1">
<cfabort>
</cfif>


<cfif #len(request.doc_desc)# gt 150>
<cfmodule template="/srr/common/error_msg.cfm"  error_msg="Document Description cannot Exceed 150 characters!" showBackButton="1">
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




<cfset request.upload_dir=#request.upload_dir#&"\"&#request.srr_id#>
<!-- CREATE REF. NO. DIRECTORY IF IT DOES NOT EXIST -->
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
#request.srr_id#,
'#request.file_name#',
'#request.doc_desc#',
#client.staff_user_id#
)
</cfquery>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
record_history = record_history + '|An attachment was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

where srrKey = '#request.srrKey#'
</cfquery>

<cflocation addtoken="No" url="control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#">



















































<!--- 


<!--- <cfif #len(request.doc_desc)# gt 150>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Document Description cannot Exceed 100 characters!" showBackButton="1">
<cfabort>
</cfif>
 --->
<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#getSrr.upload_dir#">
</cfif>

<cfset request.upload_dir=#request.upload_dir#&"\"&#request.srr_id#>
<!-- CREATE REF. NO. DIRECTORY IF IT DOES NOT EXIST -->
<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#request.upload_dir#">
</cfif>


<cftry>
<cffile action="UPLOAD" filefield="FILENAME" destination="#request.upload_dir#" nameconflict="MAKEUNIQUE">
<cfcatch>
<div class = 'warning'>Attachment was NOT successfully uploaded</div>
<br>
<div align="center">
<div align="left" style="width:700px;">
Please make sure that file name does not have any special characters like ?, :, ", ', /, \, #, etc.
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
</cfcatch>
</cftry>
<!-- check allowed file extensions -->
<cfif #ServerfileExt# is not "jpg" AND #ServerfileExt# is not "gif" AND #ServerfileExt# is not "pdf" AND #ServerfileExt# is not "png">
<div class = 'warning'>This File Format is not Acceptable</div>
<div class = 'warning'>jpg, gif, png, and pdf files are the only accepted formats</div>
<br><br>
<CFIF FileExists("#request.upload_dir#\#serverfile#")>
<cffile action="DELETE" file="#request.upload_dir#\#serverfile#">
</cfif>
<div align="center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</body>
</html>
<cfabort>
</cfif>

<!-- check that file name does not exceed 100 charcters -->
<cfif len(#Serverfile#) gt 100>
<div class = 'warning'>File Name cannot exceed 100 characters (including extension).</div>
<CFIF FileExists("#request.upload_dir#\#serverfile#")>
<cffile action="DELETE" file="#request.upload_dir#\#serverfile#">
</cfif>
<br><br>
<div align="center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfif>

<!-- replace or remove any special characters in the file name -->
<cfset request.file_name=#toFileName(serverfile)#>

<CFIF FileExists("#request.upload_dir#\#serverfile#")>
<cffile action="RENAME" source="#request.upload_dir#\#serverfile#" destination="#request.upload_dir#\#request.file_name#">
</cfif>


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
#request.srr_id#,
'#left(request.file_name,100)#',
'#left(request.doc_desc,150)#',
#client.staff_user_id#
)
</cfquery>

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
record_history = record_history + '|An attachment was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

where srrKey = '#request.srrKey#'
</cfquery>

<cflocation addtoken="No" url="control.cfm?action=attachments&srrKey=#request.srrKey#&#request.addtoken#">


 --->