<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">




<cfoutput>
<form action="add_attachment2.cfm" method="post" enctype="multipart/form-data" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<h2>Add Attachment</h2>

<div class="field">
<label>Document Title</label>
<input type="text" name="doc_desc" id="doc_desc" size="30" required="Yes">
</div>

<div class="field">
<label>Select Document/Photo</label>
<input type="file" name="FILENAME" id="FILENAME" accept="image/*" capture="camera" required="Yes">
</div>





<div style="text-align:center;">
<input type="submit" name="add" id="add" value="Add">
</div>

</form>
</cfoutput>




<cfinclude template="footer.cfm">
