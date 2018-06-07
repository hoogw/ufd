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



<cfdocument  format="PDF" pagetype="letter" margintop="0.5" marginbottom="0.5" marginright="0.2" marginleft="0.2" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="Yes" bookmark="False" localurl="Yes">


<cfmodule template="/styles/boe_ltr_head_pdf.cfm" seal = "../../styles/seals.gif">
<cfoutput query="find_srr">
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


<p>This letter is to inform you that the City of Los Angeles has completed reviewing your application under the Sidewalk Repair Rebate Program and the subject property is NOT ELIGIBLE for this program at this time.</p>

<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>

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
</cfoutput>


<cfdocumentitem type='footer'>
<cfoutput>
<table width='100%' border='0'>
<tr>
<td width='25%' align='left'><span style='font-family:Arial;font-size:10px;'>Printed on: #dateformat(now(),'mm/dd/yyyy')# &nbsp;&nbsp;at: #timeformat(now(),'h:mm tt')#</span></td>

<td width='50%' align='center' valign='bottom'>
<span style='font-family:Arial;font-size:10px;'>
<b>AN EQUAL EMPLOYMENT OPPORTUNITY - AFFIRMATIVE ACTION EMPLOYER</b>
</span>
</td>

<td width='25%' align='right'><span style='font-family:Arial;font-size:10px;'>Page: #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</span></td>
</tr>
</table>
</cfoutput>
</cfdocumentitem>

</cfdocument>
