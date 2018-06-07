<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">

<cfoutput>


<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, srr_status_cd
, offerDeclined_dt
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>


<cfif #getSrr.srr_status_cd# is "offerDeclined" or #getSrr.srr_status_cd# is "offerDeclinedTemp">
<div class="warning">
You have already declined this offer on #dateformat(getSrr.offerDeclined_dt,"mm/dd/yyyy")#
</div>
<cfabort>
</cfif>

<cfquery name="updatesrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
  srr_status_cd = 'offerDeclinedTemp'
, offerDeclined_dt = #now()#
, offerDeclined_exp_dt = dateAdd("d", 14, #now()#)

, offer_open_amt = 0
, offer_paid_amt = 0
, offer_accepted_amt = 0

, record_history = record_history + '|Offer DECLINED by applicant on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.  Applicant has 14 days from this date to change his/her decision.'
where srrKey = '#request.srrKey#'
</cfquery>



<div class="warning">
You have declined an offer for the Sidewalk Repair Rebate Program
<br><br>
You still have 14 days to change your mind.  If you do that, you may use the same offer link to accept the offer.  After 14 days, you will not be able to change this decision.
<br><br>
By declining this offer, you lost your place in line and you will have to start a new application if you decide to participate in the Sidewalk Repair Rebate Program.
</div>




<cfset request.offerDeclined_exp_dt = dateAdd("d", 14, #now()#)>
<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "45"> <!--- Code 45 is offerDeclined and offerDeclinedTemp --->
<cfset request.srComment = "Thank you for your interest in the City of Los Angeles Sidewalk Repair Rebate Program. Our records indicate that on #dateformat(now(),'mm/dd/yyyy')#, you declined the rebate offer for #request.job_address#. You have 14 days to change your decision about declining this offer, otherwise, you will receive no further communications.

The following link may be used to change your decision before #dateformat(request.offerDeclined_exp_dt,"mm/dd/yyyy")#">

<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<!--- <div class="warning">
Success: #request.srupdate_success#<br>
Error Message: #request.srupdate_err_message#<br>
</div> --->
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- <div class="warning">
Error Updating Ticket in MyLA311<br><br>
Success: #request.srupdate_success#<br>
Error Message: #request.srupdate_err_message#<br>
</div> --->
<cfabort>
</cfcatch>
</cftry>


</cfoutput>
<cfinclude template="../common/footer.cfm">