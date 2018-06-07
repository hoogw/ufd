<cfinclude template="../common/validate_arKey.cfm">
<cfoutput>


<form action="control.cfm?action=bss_comments2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">
<input type="hidden" name="ar_id" id="ar_id" value="#request.ar_id#">
<div class="formbox" style="width:550px;">
<h1>Adding Comments </h1>
<!--- <table border="1"  class = "formtable" style = "width: 100%;"> --->
<div class="field">
<label for="bss_comments">Comments</label>
<textarea name="comment_txt" id="comment_txt" style="width:90%;height:80px;margin-top:5px;" placeholder="Type your comments here ...">&nbsp;</textarea>
</div>
</div>



<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>


</form>
</cfoutput>