<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<cfquery name="checkStatus" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, srr_status_cd
, ddate_submitted

, notEligible_exp_dt
, incompleteDocs_exp_dt
, AdaCompliant_exp_dt
, offerMade_exp_dt
, offerAccepted_exp_dt
<!--- If required permits are not submitted by this date, request will be set to requirededPermitsNotSubmitted --->

, offerDeclined_exp_dt
, paymentIncompleteDocs_exp_dt

, requiredPermitsNotSubmitted_exp_dt 
<!--- This date is used to determine when the appeal period expires for applications where applicant did not submit the required permits within 60 days of accepting the offer.  It is 14 days after requiredPermitsNotSubmitted_dt --->

, requiredPermitsIssued_exp_dt


from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfif 
#checkStatus.srr_status_cd# is not "notEligibleTemp" 
and #checkStatus.srr_status_cd# is not "notEligible"
and #checkStatus.srr_status_cd# is not "ADACompliantTemp"
and #checkStatus.srr_status_cd# is not "ADACompliant"
and #checkStatus.srr_status_cd# is not "OfferExpired"
and #checkStatus.srr_status_cd# is not "requiredPermitsNotSubmitted"
and #checkStatus.srr_status_cd# is not "constDurationExp"
and #checkStatus.srr_status_cd# is not "incompleteDocsExp"
and #checkStatus.srr_status_cd# is not "paymentIncompleteDocsExp"
>
<div class="warning">
There is no reason to submit an appeal at this time.
<br><br>
Please continue to monitor your email for further instructions
</div>	
<cfabort>
</cfif>	


<!-- check if there is an appeal in progress -->
<cfif 
#checkStatus.srr_status_cd# is "appealedNotEligible" 
OR #checkStatus.srr_status_cd# is "appealedADACompliant" 
OR #checkStatus.srr_status_cd# is "appealedOfferExpired"
OR #checkStatus.srr_status_cd# is "appealedRequiredPermitsNotSubmitted"
OR #checkStatus.srr_status_cd# is "appealedConstDurationExp"
OR #checkStatus.srr_status_cd# is "appealedIncompleteDocsExp"
OR #checkStatus.srr_status_cd# is "appealedPaymentIncompleteDocsExp"
>

<div class="warning">
We are currently considering your appeal.  
<br><br>
You will receive an email notification once a determination is made.
</div>
<cfabort>
</cfif>
<!-- check if there is an appeal in progress -->

<!--- Check appeal expiration date --->
<cfif #checkStatus.srr_status_cd# is "notEligible">
	<cfset request.appeal_exp_dt = #checkStatus.notEligible_exp_dt#>
	
<cfelseif #checkStatus.srr_status_cd# is "ADACompliant">
	<cfset request.appeal_exp_dt = #checkStatus.AdaCompliant_exp_dt#>
	
<cfelseif #checkStatus.srr_status_cd# is "OfferExpired">
	<cfset request.appeal_exp_dt = #checkStatus.offerMade_exp_dt#>
	
<cfelseif #checkStatus.srr_status_cd# is "requiredPermitsNotSubmitted">
	<cfset request.appeal_exp_dt = #checkStatus.requiredPermitsNotSubmitted_exp_dt#><!--- This date is used to determine when the appeal period expires for applications where applicant did not submit the required permits within 60 days of accepting the offer.  It is 14 days after requiredPermitsNotSubmitted_dt --->
	
<cfelseif #checkStatus.srr_status_cd# is "constDurationExp">
	<cfset request.appeal_exp_dt = #checkStatus.requiredPermitsIssued_exp_dt#>
	
<cfelseif #checkStatus.srr_status_cd# is "incompleteDocsExp">
	<cfset request.appeal_exp_dt = #checkStatus.incompleteDocs_exp_dt#>
	
<cfelseif #checkStatus.srr_status_cd# is "paymentIncompleteDocsExp">
	<cfset request.appeal_exp_dt = #checkStatus.paymentIncompleteDocs_exp_dt#>

<div class="warning">
Although the appeal window has expired on #dateformat(request.appeal_exp_dt,"mm/dd/yyyy")#, you may still submit an appeal for this expired application.
</div>	

</cfif>
<!--- Check appeal expiration date --->


<cfswitch expression = #checkStatus.srr_status_cd#>

<cfcase value = "notEligibleTemp">
<cfset request.appealReason="appealedNotEligible">
<Cfset request.appealDesc="Appealing Eligibility for Rebate">
</cfcase>

<cfcase value = "notEligible">
<cfset request.appealReason="appealedNotEligible">
<Cfset request.appealDesc="Appealing Eligibility for Rebate">
</cfcase>

<cfcase value = "ADACompliantTemp">
<cfset request.appealReason="appealedADACompliant">
<Cfset request.appealDesc="Appealing ADA Compliance">
</cfcase>

<cfcase value = "ADACompliant">
<cfset request.appealReason="appealedADACompliant">
<Cfset request.appealDesc="Appealing ADA Compliance">
</cfcase>

<cfcase value = "OfferExpired">
<cfset request.appealReason="appealedOfferExpired">
<Cfset request.appealDesc="Appealing an Expired Offer">
</cfcase>

<cfcase value = "requiredPermitsNotSubmitted">
<cfset request.appealReason="appealedRequiredPermitsNotSubmitted">
<Cfset request.appealDesc="Appealing Required Permits not Submitted within 60 days">
</cfcase>


<cfcase value = "constDurationExp">
<cfset request.appealReason="appealedConstDurationExp">
<Cfset request.appealDesc="Appealing Construction not Completed within 90 days">
</cfcase>

<cfcase value = "incompleteDocsExp">
<cfset request.appealReason="appealedIncompleteDocsExp">
<Cfset request.appealDesc="Appealing Required Documents not Submitted within 14 days">
</cfcase>

<cfcase value = "paymentIncompleteDocsExp">
<cfset request.appealReason="appealedPaymentIncompleteDocsExp">
<Cfset request.appealDesc="Appealing Required Documents for Rebate not Submiited within 14 days">
</cfcase>

</cfswitch>


<!--- add javascript validation here --->


	



<cfoutput>
<form action="submit_an_appeal2.cfm?#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<div class="formbox" style="width:650px;">
<h1>Submit an Appeal (step 1 of 2)</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td>Reason for Appeal</td>
<td>
<span class="data">#request.appealDesc#</span>
<input type="hidden" name="appealReason" id="appealReason" value="#request.appealReason#">
</td>
</tr>

<tr>
<td>Comments</td>
<td>
<textarea cols="" rows="" name="appealCommentsApp" id="appealCommentsApp" style="width:95%;height:200px;" placeholder="Maximum: 1000 Characters ..."></textarea>
</td>
</tr>

</table>
</div>

<br>
<div align="center"><input type="submit" name="submit" id="submit" value="Submit Appeal" class="submit"></div>


</form>
<br>
<div align="center">In the next step you will be able to add attachments to your appeal.</div>
 
</cfoutput> 

</body>
</html>