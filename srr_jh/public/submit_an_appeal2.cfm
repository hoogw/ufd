<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="getReason" datasource="#request.dsn#" dbtype="datasource">
SELECT 
 [recordID]
      ,[appealReason]
      ,[appealDesc]
  FROM [srr].[dbo].[appealReason]
 
 where appealReason = '#request.appealReason#'
</cfquery>

<cfset request.srr_status_cd = #request.appealReason#><!--- The srr_status_cd will be set to this new value once the appeal is inserted in the appeal table --->
<cfset request.appealDesc = #getReason.appealDesc#>

<!--- check if there is already an open appeal for the same reason --->
<cfquery name="checkAppeal" datasource="#request.dsn#" dbtype="datasource">
Select appealID from appeals
where
appealReason = '#request.appealReason#'
and 
srr_id = #request.srr_id#
and
appealDecision is null
</cfquery>

<cfif #checkAppeal.recordcount# gt 0>
<div class="warning">
We are currently processing your appeal, please continue to monitor your email for further information/instructions.
</div>
<cfabort>
</cfif>
<!--- check if there is already an open appeal for the same reason --->


<cfquery name="addAppeal" datasource="#request.dsn#" dbtype="datasource">
insert into appeals
(
appealDate
, srr_id
, appealReason 
, appealCommentsApp
)
values
(
#now()#
, #request.srr_id#
, '#request.appealReason#'
, '#request.appealCommentsApp#'
)
</cfquery>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = '#request.appealReason#'
, record_history = record_history + '|Applicant  is #request.appealDesc#.  Appeal was submitted on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.'
where 
srrKey = '#request.srrKey#'
</cfquery>


<cfoutput>

<cfif #request.appealReason# is "appealedNotEligible" 
OR #request.appealReason# is "appealedADACompliant" 
OR #request.appealReason# is "appealedOfferExpired"
OR #request.appealReason# is "appealedRequiredPermitsNotSubmitted"
OR #request.appealReason# is "appealedConstDurationExp"
OR #request.appealReason# is "appealedIncompleteDocsExp"
OR #request.appealReason# is "appealedPaymentIncompleteDocsExp">
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "14"> <!--- If the value is numeric then it will update the Reason Code. Otherwise is will update the Resolution Code --->
<cfset request.srComment = "Your appeal has been received. Any documentation or other information received will be reviewed and a determination will be made. You will receive an email with a status update following a determination of your appeal.
<p>Please use the following link to provide any additional documentation (click or copy and paste in your browser):</p>
<p>#request.serverRoot#/srr/public/uploadfile1.cfm?srrKey=#request.srrKey#</p>
">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>

</cfif>

<div class="warning">
Your appeal has been received. Any documentation or other information received will be reviewed and a determination will be made. You will receive an email with a status update following a determination of your appeal.
<br><br>
Please Click Next if would like to attach any documents.
</div>
<br>
<div align="center"><input type="button" name="Next" id="next" value="Next &gt;&gt;" class="submit" onClick="location.href = 'uploadfile1.cfm?srrKey=#request.srrKey#'"></div>

</cfoutput>

<cfinclude template="../common/footer.cfm">