<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfoutput>

<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, srr_status_cd
, offerDeclined_dt
, offerAccepted_dt
from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfif #getSrr.srr_status_cd# is "offerAccepted">
<div class="warning">
You have already accepted this offer on #dateformat(getSrr.offerAccepted_dt,"mm/dd/yyyy")#
</div>
<br><br>
<input type="button" name="yes" id="yes" value="Change My Decision" class="submit" onClick="location.href='offer_to_applicant.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
<cfabort>
</cfif>

<style>
li {
margin-left: 25px;
padding: 10px;
}
</style>

<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = 'offerAccepted'
, record_history = record_history + '|Applicant accepted offer on (#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#).'
, offerAccepted_dt = #now()#
, offerAccepted_exp_dt = dateAdd("d", 60, #now()#)
, offer_reserved_amt = 0
, offer_accepted_amt = #toSqlNumeric(request.rebateTotal)#
, offer_open_amt = 0
, offer_paid_amt = 0
where 
srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srNum = #request.sr_number#>
<cfset request.srCode = "21"> <!--- If the value is numeric then it will update the Reason Code. Otherwise is will update the Resolution Code --->
<cfset request.srComment = "Thank you for accepting your Sidewalk Repair Rebate Offer.
To review the work scope and finalize your no-fee Class A-Permit and a no-fee Tree Removal/Root Pruning Permit(s) (if applicable), use the following link:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
<br><br>
In order to receive the rebate, you must apply for the necessary permit(s) within 60 days.  Details regarding you rebate offer are available here: 
<br><br>
#request.serverRoot#/srr/public/offer_to_applicant.cfm?srrKey=#request.srrKey#
">

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

<cflocation addtoken="No" url="app_requirements.cfm?srrKey=#request.srrKey#">
