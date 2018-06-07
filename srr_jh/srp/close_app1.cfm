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

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>

<cfparam name="request.newStatus" default="#findSRR.srr_status_cd#">

<cfif 
#findSRR.srr_status_cd# is 'notEligible'
OR
#findSRR.srr_status_cd# is 'ADACompliant'
OR
#findSRR.srr_status_cd# is 'incompleteDocs'
OR
#findSRR.srr_status_cd# is 'offerDeclined'
OR
#findSRR.srr_status_cd# is 'offerExpired'
OR
#findSRR.srr_status_cd# is  'paymentIncompleteDocs'
OR
#findSRR.srr_status_cd# is  'requiredPermitsNotSubmitted'
OR
#findSRR.srr_status_cd# is  'appealDenied'
OR
#findSRR.srr_status_cd# is 'constDurationExp'>

<cfset request.newStatus = "cancel">

<cfelseif #findSRR.srr_status_cd# is 'paymentPending'>

<cfset request.newStatus = "close">

</cfif>

<cfoutput>

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td width="400px" align="left" valign="top">
<cfif #request.newStatus# is "cancel" or #request.newStatus# is "close">
<div class="formbox" style="width:400px;">

<cfif #request.newStatus# is "cancel">
<h1>Canceling Application</h1>
<cfelseif #request.newStatus# is "close">
<h1>Closing Application</h1>
</cfif>

<!--- 
#findSRR.srr_status_cd# is "received" 
OR #findSRR.srr_status_cd# is "PendingBcaReview" 
OR #findSRR.srr_status_cd# is "pendingBssReview"
OR  
or  #findSRR.srr_status_cd# is "notEligibleTemp"> --->

<form action="control.cfm?action=close_app2&#request.addtoken#" method="post" name="form1" id="form1"<!---  onSubmit="return checkForm();" --->>
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<input type="hidden" name="newStatus" id="newStatus" value="#request.newStatus#">

<div class="field">
<label for="close_cancel_comments"><strong>BOE Canceling/Closing Comments:</strong></label>
<textarea name="close_cancel_comments" id="close_cancel_comments" style="width:92%;height:100px;margin-top:5px;" placeholder="Type your comments here ..."></textarea>
</div>

</div>


<cfif #request.newStatus# is "cancel">
<div align="center"><input type="submit" name="submit" id="submit" value="Cancel Application"></div>
<cfelseif #request.newStatus# is "close">
<div align="center"><input type="submit" name="submit" id="submit" value="Close Application"></div>
</cfif>



<cfelseif #findSRR.srr_status_cd# is "cancelTicket">
<div class="warning" style="width:90%;">
Application is already canceled
</div>
<cfelseif #findSRR.srr_status_cd# is "CloseTicket">
<div class="warning" style="width:90%;">
Application is already closed
</div>
<cfelse>
<div class="warning" style="width:90%;">
Current Status does not allow for Cancel or Close option.
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


