<cfinclude template="/srr/common/validate_srrKey.cfm">
<!-- document can handle supp. permits -->


<cfquery name="find_applicant" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.app_id
, srr_info.ddate_submitted
, srr_info.app_name_nn
, srr_info.app_contact_name_nn
, srr_info.app_address1_nn
, srr_info.app_address2_nn
, srr_info.app_city_nn
, srr_info.app_state_nn
, srr_info.app_zip_nn
, srr_info.app_phone_nn
, srr_info.app_email_nn

, srr_info.mailing_address1
, srr_info.mailing_address2
, srr_info.mailing_city
, srr_info.mailing_state
, srr_info.mailing_zip

FROM  srr_info 
WHERE 
srrKey = '#request.srrKey#'
</cfquery>


<cfoutput query="find_applicant">
<div align="center">
<h1>Applicant Information</h1>
<table width="100%" cellspacing="0" cellpadding="1" style="border-width: 0px; border-collapse:collapse;border-color:black;">

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Applicant</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_name_nn#</span></td>
</tr>

<!--- <tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Contact</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_contact_name_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_address1_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address (Line2)</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_address2_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">City</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_city_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">State</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_state_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Zip/Postal Code *</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_zip_nn#</span></td>
</tr> --->

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Phone</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_phone_nn#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Email</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.app_email_nn#</span></td>
</tr>

<tr>
<td width="35%" colspan="2" align="center" class="head"><strong>Mailing Address (will be captured when offer is made)</strong></td>
</tr>



<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.mailing_address1#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address (Line2)</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.mailing_address2#</span></td>
</tr>

<tr>
<td width="35%"style="border-width: 1px;border-color:black;border-style:solid;">City</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.mailing_city#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">State</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.mailing_state#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Zip/Postal Code *</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#find_applicant.mailing_zip#</span></td>
</tr>



</table>
</div>
</cfoutput>