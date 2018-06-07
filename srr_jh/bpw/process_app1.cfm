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
, srr_info.address_verified

, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc

, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend

, dbo.srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments

, dbo.srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments

, srr_info.bpw1_comments_to_app
, srr_info.bpw1_internal_comments

, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd

, srr_info.boe_invest_comments
, srr_info.bpw1_internal_comments
, srr_info.bca_comments
, srr_info.bss_comments
, srr_info.filing_folder_created
, srr_info.w9_on_file

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>

<!--- <Cfoutput>
#findSRR.srr_status_cd#
</CFOUTPUT> --->

<cfif #request.status_cd# is not "received" and #request.status_cd# is not "incompleteDocsTemp">
<cfoutput>
<div class="warning">
<!---SR Status: #request.status_desc#<br><br>--->
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif>

<div align="center">
<table width="1120px" border="0" align="center">
<tr>
<td style="width:400px;vertical-align:top;text-align:left;">
<cfoutput query="findSRR">
<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="type" id="type" value="u">



<div class="field">
<label for="bpw1_ownership_verified">Ownership Information Complete?</label>
<input type="radio" name="bpw1_ownership_verified" id="bpw1_ownership_verified" value="y" <cfif #findSRR.bpw1_ownership_verified# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="bpw1_ownership_verified" id="bpw1_ownership_verified"  value="n" <cfif #findSRR.bpw1_ownership_verified# is "n">checked</cfif>> No
<label for="bpw1_ownership_comments">Comments to Applicant:</label>
<textarea  name="bpw1_ownership_comments" id="bpw1_ownership_comments" style="width:350px;height:100px;"><!--- #findSRR.bpw1_ownership_comments# ---></textarea>
</div>

<div class="field">
<label for="bpw1_tax_verified">Tax Information Complete?</label>
<input type="radio" name="bpw1_tax_verified" id="bpw1_tax_verified" value="y" <cfif #findSRR.bpw1_tax_verified# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="bpw1_tax_verified" id="bpw1_tax_verified"  value="n" <cfif #findSRR.bpw1_tax_verified# is "n">checked</cfif>> No
<label for="bpw1_tax_comments">Comments to Applicant:</label>
<textarea  name="bpw1_tax_comments" id="bpw1_tax_comments" style="width:350px;height:100px;"><!--- #findSRR.bpw1_tax_comments# ---></textarea>
</div>

<div class="field">
<label for="srr_status_cd">Request Status</label>

<!--- 1 ---><cfif #findSrr.srr_status_cd# is "PendingBcaReview" or  #findSrr.srr_status_cd# is "notEligibleTemp" OR #findSrr.srr_status_cd# is "inCompleteDocsTemp" OR #findSrr.srr_status_cd# is "pendingBOEReview" OR #findSrr.srr_status_cd# is "received">

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="PendingBcaReview" <cfif #findSrr.srr_status_cd# is "PendingBcaReview">checked</cfif>> Eligible for Rebate</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="notEligibleTemp" <cfif #findSrr.srr_status_cd# is "notEligibleTemp" or #findSrr.srr_status_cd# is "notEligible">checked</cfif>> NOT Eligible for Rebate</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="inCompleteDocsTemp" <cfif #findSrr.srr_status_cd# is "inCompleteDocsTemp" or #findSrr.srr_status_cd# is "inCompleteDocs">checked</cfif>> Incomplete Documents</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBoeReview" <cfif #findSrr.srr_status_cd# is "pendingBoeReview">checked</cfif>> Engineering Evaluation Required</label>

<br>
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="received" <cfif #findSrr.srr_status_cd# is "received">checked</cfif>> Keep for Further Investigation</label>
<!--- 1 ---><cfelse>
<strong>#request.status_desc#</strong>
<!-- 1 --></cfif>


<!--- <select name="srr_status_cd" id="srr_status_cd">
<cfloop query="status_codes">
	<option value="#status_codes.srr_status_cd#" <cfif #findSRR.srr_status_cd# is #status_codes.srr_status_cd#>Selected</cfif>>#status_codes.srr_status_desc#</option>
</cfloop>
</select> --->


<br>
<label for="srr_status_cd">General Comments to Applicant:</label>
<textarea name="bpw1_comments_to_app" id="bpw1_comments_to_app" style="width:350px;height:100px;margin-top:5px;"><!--- #findSRR.bpw1_comments_to_app# ---></textarea>

</div>


<div class="field">
<p>Application that are Eligible for Rebate will be forwarded to BCA for pre-inspection/assessment.</p>
<p>Denied/Ineligible applications will trigger an email to customer indicating that the property is ineligible for the Sidewalk Rebate Program.</p>
</div>



</div>

<cfif #request.status_cd# is "received" or #request.status_cd# is "incompleteDocsTemp">
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
</cfif>

</form>

<div class="formbox" style="width:400px;">
<h1>Application Processing (Part 2)</h1>
<form action="control.cfm?action=process_app2_form2&#request.addtoken#" method="post" name="form2" id="form2" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="type" id="type" value="u">

<div class="field">
<label for="filing_folder_created">Filing Folder Created?</label>
<input type="radio" name="filing_folder_created" id="filing_folder_created" value="y" <cfif #findSRR.filing_folder_created# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="filing_folder_created" id="filing_folder_created"  value="n" <cfif #findSRR.filing_folder_created# is "n">checked</cfif>> No
</div>

<div class="field">
<label for="w9_on_file">W9 on File?</label>
<input type="radio" name="w9_on_file" id="w9_on_file" value="y" <cfif #findSRR.w9_on_file# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="w9_on_file" id="w9_on_file"  value="n" <cfif #findSRR.w9_on_file# is "n">checked</cfif>> No
</div>

<div class="field">
<label for="bpw1_internal_comments">Internal Comments (Optional)</label>
<textarea name="bpw1_internal_comments" id="bpw1_internal_comments" style="width:350px;height:100px;margin-top:5px;"></textarea>
</div>

</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</cfoutput>
</td>
	
<td style="width:10px;vertical-align:top;">
&nbsp;
</td>
	
<td style="width:350px;vertical-align:top;">
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  width="350px">
<!--- hse_nbr="#findSRR.hse_nbr#" hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#" --->
</td>


<td style="width:10px;vertical-align:top;">
&nbsp;
</td>

<td style="width:350px;vertical-align:top;">
<!--- <cfmodule template="../modules/dsp_extra_info_module.cfm" srrKey="#request.srrKey#" width="350px"> --->
<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#" width="350px">
</td>
</tr>
</table>
</div>







