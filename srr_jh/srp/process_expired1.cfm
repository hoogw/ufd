<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="findSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.sr_number
, srr_info.app_name_nn

, srr_info.app_phone_nn
, srr_info.app_email_nn
, srr_info.job_address

, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_status.agency
, srr_status.srr_list_order
, srr_status.suspend
, srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments
, srr_info.bpw1_internal_comments
, srr_info.bpw1_comments_to_app
, srr_info.ext_grantedDays
, srr_info.ext_granted_dt
, srr_info.ext_granted_by

, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd
, boe_invest_comments
, boe_invest_response_to_app
, srr_info.bpw1_internal_comments
, srr_info.bpw2_internal_comments
, srr_info.bca_comments
, srr_info.bss_comments

<!--- 14 days to submit requested documents ---><!--- set back to from, incompeteDocs to incompleteDocsTemp and change incompleteDocs_exp_dt --->
, srr_info.incompleteDocs_dt 
, srr_info.incompleteDocs_exp_dt


<!--- 14 days to accept offer ---><!--- set back from offerExpired to offerMade and change offerMade_exp_dt --->
, srr_info.offerMade_dt
, srr_info.offerMade_exp_dt


<!--- those are not used now --->
, srr_info.offerDeclined_dt
, srr_info.offerDeclined_exp_dt

<!--- govern 60 days to submit required permits ---><!--- set back from requiredPermitsNotSubmitted to offerAccepted and change offerAccepted_exp_dt --->
, srr_info.offerAccepted_dt
, srr_info.offerAccepted_exp_dt

<!--- govern 90 days construction --->
, srr_info.requiredPermitsIssued_dt
, srr_info.requiredPermitsIssued_exp_dt

, srr_info.requiredPermitsNotSubmitted_dt
, srr_info.requiredPermitsNotSubmitted_exp_dt

, srr_info.paymentIncompleteDocs_dt
, srr_info.paymentIncompleteDocs_exp_dt

FROM  srr_info LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>


<cfoutput>
<div align="center">
<table width="1120px" border="0" align="center">
<tr>
<td width="400px" align="left" valign="top">
<div class="formbox" style="width:400px;"><!--- start formbox --->
<h1>Processing Expired Application</h1>

<form action="control.cfm?action=process_expired2&type=a&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<cfif #findSRR.srr_status_cd# is "incompleteDocs"><!--- set new status to incompleteDocsTemp and  incompleteDocs_exp_dt to now + granted days--->
<div class="field">
<label for="expReason">Expiration Reason:</label>
<p><span class="data">

Documents necessary for determining eligibility were not submitted within 14 days.  Request for documents sent on #dateformat(findSRR.incompleteDocs_dt,"mm/dd/yyyy")#.

</span></p>
</div>

<div class="field">
<label for="expDate">Expiration Date:</label>
<p><span class="data">#dateformat(findSRR.incompleteDocs_exp_dt,"mm/dd/yyyy")#</span></p>
</div>
</cfif>

<cfif #findSRR.srr_status_cd# is "offerExpired"><!--- set new status to incompleteDocsTemp and  incompleteDocs_exp_dt to now + granted days--->
<div class="field">
<label for="expReason">Expiration Reason:</label>
<p><span class="data">

Offer is expired; applicant did not accept or delcine the rebate offer within 14 days.  Offer was made on #dateformat(findSRR.offerMade_dt,"mm/dd/yyyy")#.

</span></p>
</div>

<div class="field">
<label for="expDate">Expiration Date:</label>
<p><span class="data">#dateformat(findSRR.offerMade_exp_dt,"mm/dd/yyyy")#</span></p>
</div>
</cfif>

<cfif #findSRR.srr_status_cd# is "requiredPermitsNotSubmitted"><!--- set new status to incompleteDocsTemp and  incompleteDocs_exp_dt to now + granted days--->
<div class="field">
<label for="expReason">Expiration Reason:</label>
<p><span class="data">

Required permits were not submitted within 60 days of accepting rebate offer. Offer was accepted on #dateformat(findSRR.offerAccepted_dt,"mm/dd/yyyy")#.

</span></p>
</div>

<div class="field">
<label for="expDate">Expiration Date:</label>
<p><span class="data">#dateformat(findSRR.offerAccepted_exp_dt,"mm/dd/yyyy")#</span></p>
</div>
</cfif>

<cfif #findSRR.srr_status_cd# is "constDurationExp"><!--- set new status to incompleteDocsTemp and  incompleteDocs_exp_dt to now + granted days--->
<div class="field">
<label for="expReason">Expiration Reason:</label>
<p><span class="data">

Construction was not completed within 90 days of issuing all permits. Required permits were issued on #dateformat(findSRR.requiredPermitsIssued_dt,"mm/dd/yyyy")#.

</span></p>
</div>

<div class="field">
<label for="expDate">Expiration Date:</label>
<p><span class="data">#dateformat(findSRR.requiredPermitsIssued_exp_dt,"mm/dd/yyyy")#</span></p>
</div>
</cfif>

<cfif #findSRR.srr_status_cd# is "paymentIncompleteDocs"><!--- set new status to incompleteDocsTemp and  incompleteDocs_exp_dt to now + granted days--->
<div class="field">
<label for="expReason">Expiration Reason:</label>
<p><span class="data">

Required documents for processing rebate payment were not provided within 14 days of request. Documents were requested on #dateformat(findSRR.paymentIncompleteDocs_dt,"mm/dd/yyyy")#.

</span></p>
</div>

<div class="field">
<label for="expDate">Expiration Date:</label>
<p><span class="data">#dateformat(findSRR.paymentIncompleteDocs_exp_dt,"mm/dd/yyyy")#</span></p>
</div>
</cfif>


<div class="field">
<label for="appealDecision">Grant Applicant</label>
<select name="ext_grantedDays" id="ext_grantedDays" required>
	<option value="0" <cfif #findSRR.ext_grantedDays# is "0">Selected</cfif>>Number of Days</option>
	<option value="14" <cfif #findSRR.ext_grantedDays# is "14">Selected</cfif>>14 days</option>
	<option value="30" <cfif #findSRR.ext_grantedDays# is "30">Selected</cfif>>30 days</option>
	<option value="45" <cfif #findSRR.ext_grantedDays# is "45">Selected</cfif>>45 days</option>
	<option value="60" <cfif #findSRR.ext_grantedDays# is "60">Selected</cfif>>60 days</option>
</select> 
<br>Extension from today's date.
</div>




</div><!--- end form box --->

<div style="margin-left:auto;margin-right:auto;text-align:center;"><input type="submit" name="submit" id="submit" value="Save"></div>
</form>
</cfoutput>

</td>

<td width="10px" valign="top">
&nbsp;
</td>

<td width="350px" valign="top"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#" width="350px">  <!--- hse_nbr="#findSRR.hse_nbr#"  hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#" --->
</td>

<td width="10px" valign="top">
&nbsp;
</td>

<td width="350px" valign="top">
<cfmodule template="../modules/dsp_extra_info_module.cfm" srrKey="#request.srrKey#" width="350px">
<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#" width="350px">
</td>
</tr>
</table>
</div>

