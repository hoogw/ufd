<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="findSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn

, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address

, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
, dbo.srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, dbo.srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments
, srr_info.bpw1_internal_comments
, srr_info.bpw1_comments_to_app

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


FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>



<cfoutput>

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td width="400px" align="left" valign="top">

<cfif #findSRR.srr_status_cd# is "pendingBoeReview">
<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>
<!--- 
#findSRR.srr_status_cd# is "received" 
OR #findSRR.srr_status_cd# is "PendingBcaReview" 
OR #findSRR.srr_status_cd# is "pendingBssReview"
OR  
or  #findSRR.srr_status_cd# is "notEligibleTemp"> --->

<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1"<!---  onSubmit="return checkForm();" --->>
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">



<div class="field">
<label for="boe_invest_comments"><strong>Investigation Results</strong> (will be displayed to BPW/BSS/BCA):</label>
<textarea name="boe_invest_comments" id="boe_invest_comments" style="width:92%;height:120px;margin-top:5px;" placeholder=""></textarea>
</div>

<div class="field">
<label for="srr_status_cd"><strong>Decision:</strong></label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="received" <cfif #findSRR.srr_status_cd# is "received">checked</cfif>> Send to Board of Public Works / Office of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Community Beautification</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBcaReview" <cfif #findSRR.srr_status_cd# is "pendingBcaReview">checked</cfif>> Send to BCA</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBssReview" <cfif #findSRR.srr_status_cd# is "pendingBssReview">checked</cfif>> Send to BSS/UFD</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBoeReview" <cfif #findSRR.srr_status_cd# is "pendingBoeReview">checked</cfif>> Keep for Further Investigation</label>

<br>
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="notEligibleTemp" <cfif #findSRR.srr_status_cd# is "notEligibleTemp">checked</cfif>> NOT Eligible for Rebate</label>

</div>

<div class="field">
<label for="boe_invest_response_to_app"><strong>Response to Applicant (use only if NOT Eligible):</strong></label>
<textarea name="boe_invest_response_to_app" id="boe_invest_response_to_app" style="width:92%;height:100px;margin-top:5px;" placeholder="">#findSRR.boe_invest_response_to_app#</textarea>
</div>

</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>


<cfelse>
<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>
<div class="warning" style="width:90%;">
This application cannot be processed by BOE at this time.
<br><br>
You may change the status of this application using the Override option.
</div>
</div>
</cfif>




<!--- <cfif #findSRR.srr_status_cd# is "pendingBoeReview"> --->

<!--- <cfelse>
<div class="warning" style="width:300px;">Application cannot be processed by SRP at this time.</div>
</cfif>
 --->
</form>
</cfoutput>

</td>

<td width="10px" valign="top">
&nbsp;
</td>

<td width="350px" valign="top"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" srrKey = "#request.srrKey#" width="350px">  
<!--- hse_nbr="#findSRR.hse_nbr#" hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#" --->
</td>
<td width="10px" valign="top">
&nbsp;
</td>

<td width="300px" valign="top">
<cfmodule template="../modules/dsp_extra_info_module.cfm" srrKey="#request.srrKey#" width="350px">
<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#" width="350px">
</td>
</tr>
</table>
</div>


