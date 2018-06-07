<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="getAppeal" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, srr_info.ddate_submitted
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, appeals.appealID
, dbo.appealReason.appealDesc
, dbo.appealReason.suspend
, dbo.appeals.appealDate
, dbo.appeals.appealReason
, dbo.appeals.sendTo
, dbo.appeals.appealCommentsApp
, dbo.appeals.appealDecision
, dbo.appeals.appealDecisionComments
, dbo.appeals.appealDecision_dt
, dbo.appeals.appealDecision_by
, isnull(dbo.appeals.grantedDays, 0) grantedDays

, dbo.srr_info.app_name_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
, dbo.srr_info.srr_status_cd
,  dbo.srr_status.srr_status_desc

, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd

,srr_info.cont_license_no
,srr_info.cont_name
,srr_info.cont_address
,srr_info.cont_city
,srr_info.cont_state
,srr_info.cont_zip
,srr_info.cont_phone
,srr_info.cont_lic_issue_dt
,srr_info.cont_lic_exp_dt
,srr_info.cont_lic_class



FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd RIGHT OUTER JOIN
               dbo.staff RIGHT OUTER JOIN
               dbo.appeals ON dbo.staff.user_id = dbo.appeals.appealDecision_by LEFT OUTER JOIN
               dbo.appealReason ON dbo.appeals.appealReason = dbo.appealReason.appealReason ON dbo.srr_info.srr_id = dbo.appeals.srr_id
			   

where 
appeals.appealID = #request.appealID#

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>



<cfoutput>

<div align="center">
<table width="1120px" border="0" align="center">
<tr>
<td width="400px" align="left" valign="top">
<div class="formbox" style="width:400px;">
<h1>Appeal Processing</h1>

<form action="control.cfm?action=process_appeal2&type=a&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="appealReason" id="appealReason" value="#getAppeal.appealReason#">
<input type="hidden" name="srr_status_cd" id="srr_status_cd" value="#getAppeal.srr_status_cd#">
<input type="hidden" name="appealID" id="appealID" value="#getAppeal.appealID#">



<div class="field">
<label for="appealDate">Appeal Date:</label>
<p><span class="data">#dateformat(getAppeal.appealDate,"mm/dd/yyyy")#</span></p>
</div>

<div class="field">
<label for="appealReason">Appeal Reason:</label>
<p><span class="data">#getAppeal.appealDesc#</span></p>
</div>

<div class="field">
<label for="appealReason">Appeal comments by applicant:</label>
<p><span class="data">#getAppeal.appealCommentsApp#</span></p>
</div>

<!--- appeal decision is "a" for approved and "d" for denied --->
<div class="field">
<label for="appealDecision">Decision</label>
<input type="radio" name="appealDecision" id="appealDecision" value="a" <cfif #getAppeal.appealDecision# is "a">checked</cfif> required="yes"> Approve Appeal
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="appealDecision" id="appealDecision"  value="d" <cfif #getAppeal.appealDecision# is "d">checked</cfif> required="yes"> Deny Appeal
</div>

<!--- <cfif #getAppeal.appealReason# is "appealedOfferExpired" 
OR #getAppeal.appealReason# is "appealedRequiredPermitsNotSubmitted" 
OR #getAppeal.appealReason# is "appealedConstDurationExp" 
OR #getAppeal.appealReason# is "appealedIncompleteDocsExp" 
OR #getAppeal.appealReason# is "appealedPaymentIncompleteDocsExp"> --->

<cfif #getAppeal.srr_status_cd# is "appealedOfferExpired" 
OR #getAppeal.srr_status_cd# is "appealedRequiredPermitsNotSubmitted" 
OR #getAppeal.srr_status_cd# is "appealedConstDurationExp" 
OR #getAppeal.srr_status_cd# is "appealedIncompleteDocsExp" 
OR #getAppeal.srr_status_cd# is "appealedPaymentIncompleteDocsExp">
<div class="field">
<label for="appealDecision">Grant Applicant</label>
<select name="grantedDays" id="grantedDays" required>
	<option value="0" <cfif #getAppeal.grantedDays# is "0">Selected</cfif>>Number of Days</option>
	<option value="14" <cfif #getAppeal.grantedDays# is "14">Selected</cfif>>14 days</option>
	<option value="30" <cfif #getAppeal.grantedDays# is "30">Selected</cfif>>30 days</option>
	<option value="45" <cfif #getAppeal.grantedDays# is "45">Selected</cfif>>45 days</option>
	<option value="60" <cfif #getAppeal.grantedDays# is "60">Selected</cfif>>60 days</option>
</select>
</div>
</cfif>



<cfif #getAppeal.srr_status_cd# is "appealedNotEligible" or #getAppeal.srr_status_cd# is "appealedADACompliant">
<div class="field">
<label for="ifApproved">If Approved, Place Application in:</label>

<label><input type="radio" name="sendTo" id="sendTo" value="received" <cfif #getAppeal.sendTo# is "received">checked</cfif>> Send to Board of Public Works / Office of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Community Beautification</label>

<label><input type="radio" name="sendTo" id="sendTo" value="pendingBcaReview" <cfif #getAppeal.sendTo# is "pendingBcaReview">checked</cfif>> Send to BCA</label>

<label><input type="radio" name="sendTo" id="sendTo" value="pendingBssReview" <cfif #getAppeal.sendTo# is "pendingBssReview">checked</cfif>> Send to BSS/UFD</label>

<!--- <label><input type="radio" name="notEligible" id="notEligible" value="notEligible" <cfif #getAppeal.srr_status_cd# is "notEligible">checked</cfif>> NOT Eligible for Rebate (Close Request)</label> --->

<br>
<label><input type="radio" name="sendTo" id="sendTo" value="pendingBoeReview" <cfif #getAppeal.sendTo# is "pendingBoeReview">checked</cfif>> Keep for Further Investigation</label>
</div>
</cfif>




<div class="field">
<label for="appealDecisionComments">Decision Comments:</label>
<textarea name="appealDecisionComments" id="appealDecisionComments" style="width:92%;height:120px;margin-top:5px;" placeholder="">#getAppeal.appealDecisionComments#</textarea>
</div>


<!--- <cfif #getAppeal.appealReason# is  "appealedOfferExpired" 
OR #getAppeal.appealReason# is  "appealedRequiredPermitsNotSubmitted" 
OR #getAppeal.appealReason# is  "appealedConstDurationExp" 
OR #getAppeal.appealReason# is  "appealedIncompleteDocsExp" 
OR #getAppeal.appealReason# is  "appealedPaymentIncompleteDocsExp"
OR #getAppeal.appealReason# is  "appealedNotEligible" 
OR #getAppeal.appealReason# is  "appealedADACompliant"
>
 --->

<cfif #getAppeal.srr_status_cd# is  "appealedOfferExpired" 
OR #getAppeal.srr_status_cd# is  "appealedRequiredPermitsNotSubmitted" 
OR #getAppeal.srr_status_cd# is  "appealedConstDurationExp" 
OR #getAppeal.srr_status_cd# is  "appealedIncompleteDocsExp" 
OR #getAppeal.srr_status_cd# is  "appealedPaymentIncompleteDocsExp"
OR #getAppeal.srr_status_cd# is  "appealedNotEligible" 
OR #getAppeal.srr_status_cd# is  "appealedADACompliant"
>
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
</form>
<cfelse>
<div class="warning" style="">
This application cannot be processed by BOE at this time.
<br><br>
You may change the status of this application using the Override option.
</div>
</cfif>
</div>

</cfoutput>

</td>

<td width="10px" valign="top">
&nbsp;
</td>

<td width="350px" valign="top"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#" width="350px">  <!--- hse_nbr="#getAppeal.hse_nbr#"  hse_frac_nbr="#getAppeal.hse_frac_nbr#" hse_dir_cd="#getAppeal.hse_dir_cd#" str_nm="#getAppeal.str_nm#" str_sfx_cd="#getAppeal.str_sfx_cd#" zip_cd="#getAppeal.zip_cd#" --->
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


