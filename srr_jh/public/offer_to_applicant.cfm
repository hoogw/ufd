<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfoutput>
<h2>Service Ticket Number: #request.sr_number#</h2>
<div class="subtitle">#request.job_address#</div>

<cfquery name="getSrr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, offer_reserved_amt
, offerMade_dt
, offerMade_exp_dt
, offerAccepted_dt
, offerAccepted_exp_dt
, offerDeclined_dt
, offerDeclined_exp_dt
, srr_status_cd
FROM  dbo.srr_info
where srrKey = '#request.srrKey#'
</cfquery>


<cfif #getSRR.srr_status_cd# is "appealDenied">
<div class="warning">Your Appeal was Denied</div>
<cfabort>
</cfif>

<cfif 
#getSRR.srr_status_cd# is "requiredPermitsIssued" 
or 
#getSRR.srr_status_cd# is "incompleteDocs"
or 
#getSRR.srr_status_cd# is "incompleteDocsTemp"
or 
#getSRR.srr_status_cd# is "requiredPermitsNotSubmitted"
or 
#getSRR.srr_status_cd# is "constCompleted"
or 
#getSRR.srr_status_cd# is "constDurationExp"
>
<cflocation addtoken="No" url="app_requirements.cfm?srrKey=#request.srrKey#">
</cfif>


<cfif #getSrr.srr_status_cd# is "offerDeclined">
<div class = "warning">
You have declined this offer on #dateformat(getSrr.offerDeclined_dt,"mm/dd/yyyy")#
</div>
<cfabort>
</cfif>

<cfif #getSrr.srr_status_cd# is "cancelTicket">
<div class="warning">Your Application is Canceled<br><br>If you wish to participate in the Sidewalk Repair Rebate Program, please file a new application through <a href="https://myla311.lacity.org/portal/faces/home/service/create-sr?serviceType=Sidewalk%20Repair&isRebateProgram=Y" target="_blank">MyLA311</a></div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "closeTicket">
<div class="warning">Your Application is Closed/Completed</div>
<cfabort>
</cfif>


<cfif #getSRR.srr_status_cd# is "notEligibleTemp" 
or #getSRR.srr_status_cd# is "notEligible"
or #getSRR.srr_status_cd# is  "ADACompliantTemp"
or #getSRR.srr_status_cd# is  "ADACompliant"
>
<div class="warning">
Your Application is not Eligible for the Rebate Program.
<br><br>
You may <a href="submit_an_appeal1.cfm?srrKey=#request.srrKey#">file an appeal</a> 
</div>
<cfabort>
</cfif>



<cfif not isdate(#getSrr.offerMade_dt#) or not isdate(#getSrr.offerMade_exp_dt#)>
<div class="warning">Offer is Not Ready, please check at a later time</div>
<cfabort>
</cfif>





<cfif (dateCompare(#getSrr.offerMade_exp_dt#, #now()#) is -1) and #getSRR.srr_status_cd# is "offerMade">
<div class = "warning">
The offer for rebate expired on #dateformat(getSrr.offerMade_exp_dt,"mm/dd/yyyy")#
<br><br>
If you would like to appeal this determination, please user the following link:
<br><br>
<a href="#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#getSRR.srrKey#&type=offerExpired">File an Appeal</a>
</div>
<cfabort>
</cfif>



<cfif #getSrr.srr_status_cd# is "offerAccepted">
<div class = "warning">
You have accepted this offer on #dateformat(getSrr.offerAccepted_dt,"mm/dd/yyyy")#
<br><br>
To proceed to the next step, please click on the following link:
<br><br>
<a href="app_requirements.cfm?srrKey=#request.srrKey#">Complete My Rebate Application</a>
<br><br>
OR
<br><br>
You may also decline this offer at any time
</div>
</cfif>


</cfoutput>

<cfoutput>
<form action="offer_accept.cfm?srrKey=#request.srrKey#&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">


<cfif #getSrr.srr_status_cd# is NOT "offerDeclined" and  #getSrr.srr_status_cd# is NOT "offerAccepted">
<div class="warning">
<p>Your property may be eligible for the City of Los Angeles Sidewalk Rebate Program, the following is an estimate of the rebate amount</p>
</div>
</cfif>

<br>
<cfinclude template="../common/itemized_rebate_estimate.cfm">



<br>
<div align="center">
<cfif #getSrr.srr_status_cd# is not "offerAccepted"><input type="submit" name="accept" id="accept" value="Accept Offer" class="submit"> &nbsp;&nbsp;</cfif>

<input type="button" name="decline" id="decline" value="Decline Offer" class="submit" onClick="location.href='offer_decline_confirmation1.cfm?srrKey=#request.srrKey#&#request.addtoken#'"><cfif #getSrr.srr_status_cd# is NOT "offerDeclined" and  #getSrr.srr_status_cd# is NOT "offerAccepted">&nbsp;&nbsp;

<input type="button" name="later" id="later" value="I will Decide Later" class="submit" onClick="location.href='offer_later.cfm?srrKey=#request.srrKey#&#request.addtoken#'">

</cfif> 
</div>
</form>

</cfoutput> 

</body>
</html>