<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="getCont" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[cont_license_no] 
,[cont_name]
,[cont_address]
,[cont_city]
,[cont_state] 
,[cont_zip] 
,[cont_phone]
,[cont_lic_issue_dt]
,[cont_lic_exp_dt]
,[cont_lic_class]
,[cont_info_comp_dt] 

from srr_info

where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<form action="control.cfm?action=remove_contractor2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<div class="formbox" style="width:600px;">
<h1>Overriding Contractor Name</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td>Contractor's License Number (California)</td>
<td>#getCont.cont_license_no#</td>
</tr>

<tr>
<td>Contractor Name</td>
<td>#getCont.cont_name#</td>
</tr>

<tr>
<td>Address</td>
<td>#getCont.cont_address#<br>#getCont.cont_city#, #getCont.cont_state# #getCont.cont_zip#</td>
</tr>

<tr>
<td>Phone</td>
<td>#getCont.cont_phone#</td>
</tr>

<tr>
<td>License Issued Date</td>
<td>#getCont.cont_lic_issue_dt#</td>
</tr>



<tr>
<td>License Expiration Date</td>
<td>#getCont.cont_lic_exp_dt#</td>
</tr>

<tr>
<td>License Class</td>
<td>#getCont.cont_lic_class#</td>
</tr>

</table>
</div>



  


</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Remove" class="submit"></div>

</FORM>

<br>

<div class="warning">
Removing the Contractor Information from this Record is an Irreversible Action
</div>

</cfoutput>





