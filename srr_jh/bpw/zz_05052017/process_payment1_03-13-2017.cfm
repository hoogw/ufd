<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_contact_name_nn
, dbo.srr_info.app_address1_nn
, dbo.srr_info.app_address2_nn
, dbo.srr_info.app_city_nn
, dbo.srr_info.app_state_nn
, dbo.srr_info.app_zip_nn
, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn

<!--- , dbo.srr_info.job_address
, dbo.srr_info.job_city
, dbo.srr_info.job_state
, dbo.srr_info.job_zip
, dbo.srr_info.unit_range --->

, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd

, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
, dbo.srr_info.bpw1_ownership_verified
, dbo.srr_info.bpw1_tax_verified
, ISNULL(dbo.srr_info.offer_open_amt, 0) offer_open_amt
, ISNULL(srr_info.offer_paid_amt, 0) offer_paid_amt
, ISNULL(srr_info.offer_accepted_amt, 0) offer_accepted_amt
, ISNULL(srr_info.offer_reserved_amt, 0) offer_reserved_amt
, srr_info.paymentIncompleteReasons
			   
FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>


<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td style="width:400px;vertical-align:top;text-align:left;">
<cfoutput query="find_srr">
<form action="control.cfm?action=process_payment2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="type" id="type" value="p">

<div class="formbox" style="width:400px;">
<h1>Payment Processing</h1>

<div class="field">
<label for="offer_open_amt">Rebate Amount:</label>
&nbsp;&nbsp;
<strong>#dollarformat(request.rebateTotal)#</strong>
</div>

<div class="field">
<label for="estimate">Estimate:</label>
&nbsp;&nbsp;
<a href="control.cfm?action=itemized_rebate_estimate&SrrKey=#request.srrKey#&#request.addtoken#">View Rebate Estimate</a>
</div>


<div class="field">
<label for="srr_status_cd">Payment Status</label>
&nbsp;&nbsp;
<select name="srr_status_cd" id="srr_status_cd">
<option value="constCompleted" <cfif #find_srr.srr_status_cd# is 'constCompleted'>Selected</cfif>>Select Status</option>
<option value="paymentIncompleteDocsTemp" <cfif #find_srr.srr_status_cd# is 'paymentIncompleteDocsTemp'>Selected</cfif>>Incomplete Documents</option>

<option value="paymentPending" <cfif #find_srr.srr_status_cd# is 'paymentPending'>Selected</cfif>>Payment Pending</option>
</select>
</div>





<div class="field">
<label for="paymentIncompleteReasons"><strong>Application Incomplete Reasons:</strong></label>
<textarea name="paymentIncompleteReasons" id="paymentIncompleteReasons" style="width:95%;height:75px;margin-top:5px;"></textarea>
</div>


<div class="field">
<label for="bpw2_internal_comments">Internal Comments</label>
<textarea name="bpw2_internal_comments" id="bpw2_internal_comments" style="width:95%;height:75px;margin-top:5px;" placeholder=""></textarea>
</div>

</div>
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</td>

<td style="width:10px;vertical-align:top;">

<td style="width:350px;vertical-align:top;">

<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  hse_nbr="#find_srr.hse_nbr#" hse_frac_nbr="#find_srr.hse_frac_nbr#" hse_dir_cd="#find_srr.hse_dir_cd#" str_nm="#find_srr.str_nm#" str_sfx_cd="#find_srr.str_sfx_cd#" zip_cd="#find_srr.zip_cd#">
</td>

<td style="width:10px;vertical-align:top;">

<td style="width:300px;vertical-align:top;">
<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#">
</td>
</table>
</div>

</form>


</cfoutput>
</div>








<!--- <script>
function showDiv(elem)
{
   if (elem.value == 'paymentIncompleteDocsTemp')
      	{document.getElementById('paymentIncompleteDocsTemp').style.display = "block";}
	else
	  	{document.getElementById('paymentIncompleteDocsTemp').style.display = "none";}
	  
   
}
</script> --->


<!--- <div class="field">
<label for="bpw1_ownership_verified">Ownership Verified?</label>
<input type="radio" name="bpw1_ownership_verified" id="bpw1_ownership_verified" value="y" <cfif #bpw1_ownership_verified# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="bpw1_ownership_verified" id="bpw1_ownership_verified"  value="n" <cfif #bpw1_ownership_verified# is "n">checked</cfif>> No
</div>

<div class="field">
<label for="bpw1_tax_verified">Tax Information Verified?</label>
<input type="radio" name="bpw1_tax_verified" id="bpw1_tax_verified" value="y" <cfif #bpw1_tax_verified# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="bpw1_tax_verified" id="bpw1_tax_verified"  value="n" <cfif #bpw1_tax_verified# is "n">checked</cfif>> No
</div>

<div class="field">
<label for="zoning_verified">Zoning Verified?</label>
<input type="radio" name="zoning_verified" id="zoning_verified" value="y" <cfif #zoning_verified# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="zoning_verified" id="zoning_verified"  value="n" <cfif #zoning_verified# is "n">checked</cfif>> No
</div> --->

<!--- <div class="field">
<label for="zoning_verified">For Rebate Purposes, Property is:</label>
<input type="radio" name="comm_res" id="comm_res" value="y" <!--- <cfif #comm_res# is "y">checked</cfif> --->> Residential
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="comm_res" id="comm_res"  value="n" <!--- <cfif #comm_res# is "n">checked</cfif> --->> Commercial
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="comm_res" id="comm_res"  value="n" <!--- <cfif #comm_res# is "n">checked</cfif> --->> Neither
</div>
 --->
 
 
 <!--- <div id="notEligible" style="display:none;">
<label for="srr_status"><strong>Application Not Eligible Reasons:</strong></label>
<input type="checkbox" name="incomp_tax_info" id="incomp_tax_info" value="">&nbsp;&nbsp;Tax Information (BTRC for Corporation).<br>
<input type="checkbox" name="incomp_tax_info" id="incomp_prop_info" value="">&nbsp;&nbsp;Property Information (Sold owner, trust, LLC, etc...).<br>
<input type="checkbox" name="incomp_tax_info" id="incomp_owner_info" value="">&nbsp;&nbsp;Ownership Information
</div> 

<textarea name="sign_comments" id="sign_comments" style="width:95%;height:50px;margin-top:5px;" placeholder="Type any comments to applicant ... (Optional)"></textarea>

</div>--->






