<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="navbar2.cfm">

<cfoutput>

<form action="add_comment2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="divSubTitle">Add Comment</div>


<div class="field">
<label>Comment</label>
<textarea cols="" rows="" name="comment_txt" id="comment_txt" style="width:95%;height:60px;" required="Yes"></textarea>
</div>




<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Add Comment">
</div>

</form>
</cfoutput>

<cfinclude template="footer.cfm">

