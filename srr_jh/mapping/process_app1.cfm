
<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, gis_completed_dt
, srr_info.gis_comments



FROM  dbo.srr_info

where 

srr_info.srr_id = #request.srr_id#
</cfquery>


<cfoutput query="find_srr">
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">

<div class="formbox" style="width:700px;">
<h1>Application Processing</h1>
<table border="1"  class = "formtable" style = "width: 100%;">
	<tr>
		<td>GIS Completed?</td>
		<td><input type="radio" name="gis_completed" value="y" <cfif #gis_completed_dt# is not "">checked</cfif>> Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="gis_completed" value="n" <cfif #gis_completed_dt# is  "">checked</cfif>> No</td>
	</tr>
	
	
	
	
		<tr>
		<td colspan="2" align="center">GIS Comments<br />
		<textarea cols="" rows="" name="gis_comments" id="gis_comments" style="width:500px;height:200px;">#gis_comments#</textarea></td>
	</tr>

</table>
</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</form>
</cfoutput>

