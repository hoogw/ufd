<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<style>
.warning {
width:300px;
border: 1px solid maroon;
border-radius:7px;
color: maroon;
}
</style>

<!--- <cfset request.doc_desc = ReplaceList("#request.doc_desc#","#chr(39)#","#chr(39)##chr(39)#")> --->
<cfoutput>
<cfif not isdefined("request.doc_desc") or #request.doc_desc# is "">
<div class = 'warning'>Document Description is Required!</div>
<br><br>
<div align="center">
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
<cfabort>
</cfif>

<cfif #len(request.doc_desc)# gt 150>
<div class = 'warning'>Document Description cannot Exceed 150 characters!</div>
<br><br>
<div align="center">
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
<cfabort>
</cfif>



<cfset request.file_name = getFileName("FILENAME")>
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


 
 
 
 
 </cfoutput>
 
 
<!--- 
<cfif not isdefined("request.FILENAME") or #request.FILENAME# is "">
<div class = 'warning'>File Name is Required!</div>
<br><br>
<div align="center">
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
<cfabort>
</cfif>

 --->

 
  
 
 

<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#request.upload_dir#">
</cfif>

<cfset request.upload_dir=#request.upload_dir#&"\"&#request.srr_id#>
<!-- CREATE REF. NO. DIRECTORY IF IT DOES NOT EXIST -->
<cfif #directoryexists(request.upload_dir)# is "No">
<cfdirectory action="CREATE" directory="#request.upload_dir#">
</cfif>





<cfoutput>
<cftry>
<cffile action="UPLOAD" filefield="FILENAME" destination="#request.upload_dir#" nameconflict="ERROR">
<cfcatch >
<div class = 'warning'>Attachment was NOT successfully uploaded</div>
<br>
<div align="center">
<div align="left" style="width:700px;">
Please make sure that file name does not have any special characters like ?, :, ", ', /, \, ##, ), (, %, ^ etc.
<br><br>
Please rename the file and try again.
</div>
</div>
<br><br>
<div align="center">
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
<cfabort>
</cfcatch>
</cftry>

</cfoutput>

<cffile action="RENAME" source="#request.upload_dir#\#serverfile#" destination="#request.upload_dir#\#request.file_name#">

<cfquery name="addAttachment" datasource="#request.dsn#" dbtype="ODBC">
INSERT INTO [dbo].[uploads]
           (
		   [srr_id]
           ,[ddate_uploaded]
           ,[doc_desc]
           ,[file_name]
           ,[uploaded_by]
		   )
     VALUES
           (
		   #request.srr_id#
           , #now()#
           , '#request.doc_desc#'
           ,'#request.file_name#'
           , #client.staff_user_id#
		   )
</cfquery>




<!--- updating service ticket history --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="ODBC">
update srr_info
set
record_history = isnull(record_history, '') + '|An attachment was added on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name# (BCA).'
where srrKey='#request.srrKey#'
</cfquery>
<!--- updating service ticket history --->

<cflocation addtoken="No" url="list_attachments.cfm?srrKey=#request.srrKey#&#request.addtoken#">




























<!--- 
<!-- check allowed file extensions -->
<cfif #ServerfileExt# is not "jpg" AND #ServerfileExt# is not "gif" AND #ServerfileExt# is not "pdf">
<div class = 'warning'>This File Format is not Acceptable</div>
<div class = 'warning'>jpg, gif, and pdf files are the only accepted formats</div>
<br><br>
<CFIF FileExists("#request.upload_dir#\#serverfile#")>
<cffile action="DELETE" file="#request.upload_dir#\#serverfile#">
</cfif>
<div align="center">
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
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
<input type="button" name="back" id="back" value="back" class="submit" onClick="location.href = 'add_attachment1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div>
<cfabort>
</cfif>

<cfset request.file_name=#toFileName(serverfile)#>

<CFIF FileExists("#request.upload_dir#\#serverfile#")>
<cffile action="RENAME" source="#request.upload_dir#\#serverfile#" destination="#request.upload_dir#\#request.file_name#">
</cfif> --->




