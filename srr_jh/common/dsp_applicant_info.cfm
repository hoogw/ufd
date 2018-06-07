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
<div class="formbox" style="width:490px;">
<h1>Applicant Information (Source: MyLA311)</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td width="35%">Applicant</td>
<td width="65%"><span class="data">#find_applicant.app_name_nn#</span></td>
</tr>

<!--- <tr>
<td width="35%">Contact</td>
<td width="65%"><span class="data">#find_applicant.app_contact_name_nn#</span></td>
</tr>

<tr>
<td width="35%">Address</td>
<td width="65%"><span class="data">#find_applicant.app_address1_nn#</span></td>
</tr>

<tr>
<td width="35%">Address (Line2)</td>
<td width="65%"><span class="data">#find_applicant.app_address2_nn#</span></td>
</tr>

<tr>
<td width="35%">City</td>
<td width="65%"><span class="data">#find_applicant.app_city_nn#</span></td>
</tr>

<tr>
<td width="35%">State</td>
<td width="65%"><span class="data">#find_applicant.app_state_nn#</span></td>
</tr>

<tr>
<td width="35%">Zip/Postal Code *</td>
<td width="65%"><span class="data">#find_applicant.app_zip_nn#</span></td>
</tr> --->

<tr>
<td width="35%">Phone</td>
<td width="65%"><span class="data">#find_applicant.app_phone_nn#</span></td>
</tr>

<tr>
<td width="35%">Email</td>
<td width="65%"><span class="data">#find_applicant.app_email_nn#</span></td>
</tr>

<tr>
<td width="35%" colspan="2" align="center" class="head"><strong>Mailing Address (will be captured when offer is accpeted)</strong></td>
</tr>



<tr>
<td width="35%">Address</td>
<td width="65%"><span class="data">#find_applicant.mailing_address1#</span></td>
</tr>

<tr>
<td width="35%">Address (Line2)</td>
<td width="65%"><span class="data">#find_applicant.mailing_address2#</span></td>
</tr>

<tr>
<td width="35%">City</td>
<td width="65%"><span class="data">#find_applicant.mailing_city#</span></td>
</tr>

<tr>
<td width="35%">State</td>
<td width="65%"><span class="data">#find_applicant.mailing_state#</span></td>
</tr>

<tr>
<td width="35%">Zip/Postal Code *</td>
<td width="65%"><span class="data">#find_applicant.mailing_zip#</span></td>
</tr>



</table>
</div>
</cfoutput>