<cfparam name="request.srr_id" default="10028">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, ddate_submitted
, app_id
, app_name_nn
, app_contact_name_nn
, app_address1_nn
, app_address2_nn
, app_city_nn
, app_state_nn
, app_zip_nn
, app_phone_nn
, app_email_nn
, job_address, job_city
, job_state, job_zip
, unit_range
, mailing_address1
, mailing_address2
, mailing_zip, mailing_city
, mailing_state
, job_address
, job_city
, job_state
, job_zip

FROM  dbo.srr_info

where srr_id = #request.srr_id#
</cfquery>


<cfoutput query="find_srr">
<form action="control.cfm?action=prep_not_eligible_ltr2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srr_id" id="srr_id" value="#request.srr_id#">
<div align="center">
<table width="75%" border="0" cellpadding="10" align="center">
<tr>
<td width="100%" valign="top">
<!---<cfmodule template="/styles/boe_ltr_head_html.cfm" seal = "/styles/seals.gif">--->

<br>
Applicant:<br>
<strong>#find_srr.app_name_nn#</strong><br>
#find_srr.app_address1_nn# #find_srr.app_address2_nn#<br>
#find_srr.app_city_nn#, #find_srr.app_state_nn# #find_srr.app_zip_nn#<br>
<br>
<br>
Property Information:<br>
<strong>#find_srr.job_address#</strong><br>
#find_srr.job_city#, #find_srr.job_state# #find_srr.job_zip#<br>
<br>
<div align="center">
<b>Property not Eligible for Sidewalk Repair Rebate Program</b>
</div>


<p>This letter is to inform you that the City of Los Angeles has completed reviewing your application under the Sidewalk Repair Rebate Program and the subject property is NOT ELIGIBLE for this program at this time for the following reason(s):</p>

<textarea cols="" rows="" name="reason_not_eligible" id="reason_not_eligible" style="width:500px;height:150px;"></textarea>

<p>If you would like to appeal this decision, please .................</p>

<p>If you have any question about this, please ........</p>

<br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td width="50%"></td>
<td>
Sincerely,<br>
XYZ
</td>
</tr>
</table>

</td>
</tr>
</table>
</div>
<div align="center"><input type="submit" name="submit" id="submit" value="Prepare Letter"></div>
</form>
</cfoutput>