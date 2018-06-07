<cfinclude template="../common/validate_arKey.cfm">




<cfparam name="request.denial_reason_code" default="">

<!---<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>--->
<script src="/jquery/js/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
    $("select").change(function(){
        $(this).find("option:selected").each(function(){
            var optionValue = $(this).attr("value");
            if(optionValue){
                $(".panel").not("." + optionValue).hide();
                $("." + optionValue).show();
            //alert($(this).val());
            } else{
                $(".panel").hide();
            }
        });
	
		
		
		
    }).change();
});


</script>




<cfquery name="findAR" datasource="#request.dsn#" dbtype="datasource">
SELECT
  ar_info.ar_id
, ar_info.arKey
, ar_info.sr_number
, ar_info.ddate_submitted

, ar_info.app_name_nn
, ar_info.app_address1_nn
, ar_info.app_address2_nn
, ar_info.app_city_nn
, ar_info.app_state_nn
, ar_info.app_zip_nn
, ar_info.app_phone_nn
, ar_info.app_email_nn
, ar_info.job_address

, ar_info.mailing_address1
, ar_info.mailing_address2
, ar_info.mailing_zip
, ar_info.mailing_city
, ar_info.mailing_state
 , ar_info.bpp
 , ar_info.pin
 , ar_info.pind
 , ar_info.zoningCode
 , ar_info.sr_email
 , ar_info.BSS_TO_SRP_DT
 ,ar_info.BSS_TO_SRP_by
 , dod_internal_comments
 , ufd_internal_comments
 , spd_internal_comments
  , bss_internal_comments
 , ar_status.ar_status_desc
 
 , ar_info.AR_STATUS_CD
 
 , ar_info.BOE_INVEST_RESPONSE_TO_APP 
 
 , ar_info.boe_invest_comments
 
  , ar_info.rejected_reason_id
 
 FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
			   

where 
ar_info.arKey = '#request.arKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>



<cfoutput>

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td width="400px" align="left" valign="top">

<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>



<cfquery name="find_rejectedReason" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.Denial_Reason


</cfquery>
<div class="field">
<label for="denial_reason">Denied / Out of Scope / Exemption<br>
<label for="reason">Reason:</label>
<select name="rejected_reason_code" id="rejected_reason_code">
   <option value="" <cfif #findAR.rejected_reason_id# is "" >Selected</cfif>>Select a Reason</option>
<cfloop query="find_rejectedReason">

<option value="#rejected_reason_code#" <cfif #find_rejectedReason.rejected_reason_id# is  #findAR.rejected_reason_id#>selected </cfif>>
#find_rejectedreason.rejected_reason_desc#
</option>
</cfloop> 
</select>
</label>
<br>


<label for="language">Language :</label>
<div class="BCR panel" id="BCR">
<cfquery name="find_rejectedReason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'bcr'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>



</div>

<div class="MRR panel" id="MRR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'MRR'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>


<div class="TPO panel" id="TPO"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'tpo'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>


<div class="NPR panel" id="NPR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
 select
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'NPR'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>



<div class="PR panel" id="PR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'PR'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>




<div class="NEPF panel" id="NEPF"> 
 <cfquery name="find_rejectedReason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'NEPF'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>


<div class="ULPF panel" id="ULPF"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
 where rejected_reason_code = 'ULPF'
</cfquery>


<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>


</div>
























<div class="field">
<label for="boe_invest_comments"><strong>Investigation Results</strong><p>(will be displayed to DOD/BSS)</p></label>
<textarea name="boe_invest_comments" id="boe_invest_comments" style="width:92%;height:120px;margin-top:5px;" placeholder="">#findAR.boe_invest_comments#</textarea>
</div>

<!--- <div class="field">
<label for="boe_invest_response_to_app"><strong>Response to Applicant:</strong></label>
<textarea name="boe_invest_response_to_app" id="boe_invest_response_to_app" style="width:98%;height:120px;margin-top:5px;" placeholder="">#findAR.boe_invest_response_to_app#</textarea>
</div> --->



<div class="field">
<label for="ar_status_cd"><strong>Decision:</strong></label>
<cfif #findAR.ar_status_cd# is "received" OR #findAR.ar_status_cd# is "pendingBOEReview" OR #findAR.ar_status_cd# is "pendingBssReview" OR #findAR.ar_status_cd# is "notEligible">

<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="received" <cfif #findAR.ar_status_cd# is "received">checked</cfif>> Send to Department on Disability</label>


<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="pendingBssReview" <cfif #findAR.ar_status_cd# is "pendingBssReview">checked</cfif>> Send to BSS</label>

<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="notEligible" <cfif #findAR.ar_status_cd# is "notEligible">checked</cfif>> NOT Eligible</label>

<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="BSSAssessmentCompleted" <cfif #findAR.ar_status_cd# is "BSSAssessmentCompleted">checked</cfif>> Assessment Completed</label>

<br>
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="pendingBoeReview" <cfif #findAR.ar_status_cd# is "pendingBoeReview">checked</cfif>> Keep for Further Investigation</label>


<div class="field">
<label for="boe_invest_response_to_app"><strong>Response to Applicant (use only if NOT Eligible):</strong></label>
<textarea name="boe_invest_response_to_app" id="boe_invest_response_to_app" style="width:92%;height:100px;margin-top:5px;" placeholder="">#findAR.boe_invest_response_to_app#</textarea>
</div>


<cfelse>
<strong>#request.status_desc#</strong>
</cfif>
</div>

</div>

<cfif #findAR.ar_status_cd# is "pendingBoeReview">
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
<cfelse>
<div class="warning" style="width:300px;">Application cannot be processed by SRP at this time.</div>
</cfif>

</form>
</cfoutput>

</td>

<td width="10px" valign="top">
&nbsp;
</td>

<td width="350px" valign="top"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" arKey = "#request.arKey#" width="350px">

<!--- hse_nbr="#findAR.hse_nbr#" hse_frac_nbr="#findAR.hse_frac_nbr#" hse_dir_cd="#findAR.hse_dir_cd#" str_nm="#findAR.str_nm#" str_sfx_cd="#findAR.str_sfx_cd#" zip_cd="#findAR.zip_cd#" --->
</td>
<td width="10px" valign="top">
&nbsp;
</td>

<td width="300px" valign="top">
<cfmodule template="../modules/dsp_all_comments_module.cfm" arKey="#request.arKey#" width="350px">
</td>
</tr>
</table>
</div>


