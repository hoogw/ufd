<cfabort>

Document not needed any more.

<cfinclude template="../common/validate_SrrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">




<cfoutput>
<form action="control.cfm?action=create_child_ticket2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Creating Child Ticket</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td>Old Address:</td>
	<td><strong>#getAddress.job_address# - #getAddress.zip_cd#</strong></td>
</tr>

<tr>
	<td colspan="2"><strong>New Address:</strong></td>
</tr>

<tr>
	<td>House Number:</td>
	<td><input type="text" name="hse_nbr" id="hse_nbr" size="15"></td>
</tr>

<tr>
	<td>Street Name:</td>
	<td><input type="text" name="str_nm" id="str_nm" size="30" required> (Example: Spring)<br>(Do not type St, Ave, Dr, etc.)</td>
</tr>

<tr>
	<td colspan="2">You may search by Street Name only to see all addresses located on that street.</td>
</tr>



<!--- <tr>
	<td colspan="2" valign="top">Justification:<br>
	<textarea style="width:90%;height:100px;" name="justification" id="justification" required></textarea>
	</td>
</tr> --->
</table>



  


</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Validate Address" class="submit"></div>

</FORM>

</cfoutput>





