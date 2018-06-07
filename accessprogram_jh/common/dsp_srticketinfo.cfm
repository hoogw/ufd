<cfinclude template="../common/validate_arKey.cfm">

<cfquery name="srInfo" datasource="#request.dsn#" dbtype="datasource">
select 
job_address
,[hse_nbr]
,[hse_frac_nbr]
,[hse_dir_cd]
,[str_nm]
,[str_sfx_cd]
,[str_sfx_dir_cd]
,[zip_cd]
,[unit_range]
, app_name_nn
, app_email_nn
, app_phone_nn

,[sr_app_comments]
,[sr_location_comments]
,[sr_attachments]
,[prop_owned_by]
from ar_info
where 
arKey = '#attributes.arKey#'
</cfquery>

<cfoutput query="srInfo">
<div class="formbox" style="width:#attributes.width#;text-align:center;">
<h1>Service Ticket Information:</h1>
<table border="1"  class = "formtable" style = "width: 97%;align:center;">
<tr>
<td>Applicant Name</td>
<td>
#arInfo.app_name_nn#
</td>
</tr>

<tr>
<td>Applicant Phone Number</td>
<td>
#arInfo.app_phone_nn#
</td>
</tr>

<tr>
<td>Applicant Email</td>
<td>
#arInfo.app_email_nn#
</td>
</tr>

<tr>
<td>Job Address</td>
<td>
#arInfo.HSE_NBR# #arInfo.HSE_FRAC_NBR# #arInfo.HSE_DIR_CD# #arInfo.STR_NM# #arInfo.STR_SFX_CD# #arInfo.STR_SFX_DIR_CD# #arInfo.ZIP_CD#
</td>
</tr>


<tr>
<td>SR Applicant Comments</td>
<td>
#srInfo.sr_app_comments#
</td>
</tr>

<tr>
<td>SR Location Comments</td>
<td>
#srInfo.sr_location_comments#
</td>
</tr>

<tr>
<td>SR Attachments</td>
<td>
<Cfset nn = 1>
<cfloop index="xx" list="#sr_attachments#" delimiters="|">
<div align="left"><a href="#xx#" target="_blank">Attachment No. #nn#</a></div>
<cfset nn = #nn# + 1>
</cfloop>
</td>
</tr>

</table>
</div>




























<!---<div class="notes" style="width:450px;">
<strong>Programming Notes:</strong>
Verify 311Script to copy data includes:<br>
app_name_nn,<br>
app_phone_nn,<br>
app_email_nn,<br>
job_address,<br>
hse_nbr,<br>
hse_dir_cd,<br>
str_nm,<br>
str_sfx_cd,<br>
str_sfx_dir_cd,<br>
zip_cd<br>
</div>--->

</cfoutput> 



<!--- <tr>
<td>Property Owned by:</td>
<td>
<cfif #arInfo.prop_owned_by# is "I">
Individual(s)
<cfelseif #arInfo.prop_owned_by# is "T">
Trust
<cfelseif #arInfo.prop_owned_by# is "B">
Business/Other
<cfelseif #arInfo.prop_owned_by# is "M">
Multiple Owners with an HOA or Management Association
</cfif>
</td>
</tr> --->
