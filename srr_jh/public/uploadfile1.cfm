<cfinclude template="../common/validate_srrKey.cfm">
<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/include_sr_job_address.cfm">

<!--- <cfoutput>
select * 
from srr_info
where 
srrKey = '#request.srrKey#'
</cfoutput> --->

<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
select * from srr_info
where 
srrKey = '#request.srrKey#'
</cfquery>

<cfif #getSrr.recordcount# is 0>
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfabort>
</cfif>

<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
// This is the main function to check the form entries [start]
function checkForm()
{

// validating not blank
var fld = document.form1.doc_desc;
var msg = "Document Description is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// validating max size
var fld = document.form1.doc_desc;
var msg = "Document Description cannot exceed 100 characters";
if (!v_MaxLength(fld, 100, msg ))
{
fld.focus();
fld.select();
return false;
}
// validating max size

// validating not blank
var fld = document.form1.FILENAME;
var msg = "File Name is Required";
if (!isNotBlank(fld, msg))
{
fld.focus();
fld.select();
return false;
}
// validating not blank

// Validate that the file has an  ext extension
var file_name=document.form1.FILENAME.value
// alert ("File Name = " + file_name);
var file_ext=file_name.substring(file_name.length - 4)
// alert ("File EXT = " + file_ext);
file_ext=file_ext.toUpperCase()
// alert ("New File EXT=" + file_ext);
if (file_ext.toUpperCase() != ".JPG" && file_ext.toUpperCase() != ".GIF" && file_ext.toUpperCase() != ".PDF" && file_ext.toUpperCase() != ".PNG")
{
alert ("ONLY .JPG, .GIF, .PNG AND .PDF FILE TYPES ARE ACCEPTED")
document.form1.FILENAME.focus()
document.form1.FILENAME.select()
return false;
}
// end of check file name extension

document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;
}
// This is the main function to check the form entries [end]

</script>

<cfoutput>
<form action="uploadfile2.cfm?srrKey=#request.srrKey#&#request.addtoken#" method="post" enctype="MULTIPART/FORM-DATA" name="form1" id="form1" onSubmit="return checkForm();">

<div class="formbox" style="width:700px;">
<h1>Submit Documents</h1>
<p>Please be descriptive in the Document Description identifying the document type, i.e., Appeal, Deed, site photo, etc..</p>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td>Document Description</td>
<td><input type="text" name="doc_desc" size="40"></td>
</tr>

<tr>
<td>File to Upload&nbsp;</td>
<td><input type="file" name="FILENAME" size="40">&nbsp;</td>
</tr>
</table>
</div>

<br>
<div align="center"><input type="submit" name="submit" id="submit" value="Add Attachment" class="submit"></div>


<div align="center"><br>(Allowed file extensions  are    <b>.jpg</b> , <b>.gif</b> , <b>.png</b>  and <b>.pdf</b>)<br></div>



</form>
 
</cfoutput> 

</body>
</html>