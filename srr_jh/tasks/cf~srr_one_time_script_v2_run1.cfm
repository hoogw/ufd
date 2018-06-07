<!--- rate_nbr ready --->
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info

set rate_nbr = 2
	   
WHERE 
(srr_info.srr_status_cd = 'received'
OR
srr_info.srr_status_cd = 'notEligibleTemp'
OR
srr_info.srr_status_cd = 'incompleteDocsTemp'
OR
srr_info.srr_status_cd = 'pendingBcaReview'
OR
srr_info.srr_status_cd = 'pendingBssReview'
OR
srr_info.srr_status_cd = 'PendingBoeReview'
OR
srr_info.srr_status_cd = 'offerMade'
OR
srr_info.srr_status_cd = 'offerAccepted'
OR
srr_info.srr_status_cd = 'offerDeclinedTemp'
OR
srr_info.srr_status_cd = 'requiredPermitsSubmitted')
</cfquery>



 <!--- Move application from the wailListed to received if funds are available --->
<cfquery name="SendNewOffer" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.rate_nbr
, srr_info.srrKey
, srr_info.sr_number
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_info.job_address
, srr_info.prop_type
, srr_info.tree_insp_sr_number
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

, srr_info.offer_reserved_amt
, srr_info.offer_open_amt
, srr_info.offer_accepted_amt
, srr_info.offer_paid_amt


FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   
WHERE 
(srr_info.srr_status_cd = 'received'
OR
srr_info.srr_status_cd = 'notEligibleTemp'
OR
srr_info.srr_status_cd = 'incompleteDocsTemp'
OR
srr_info.srr_status_cd = 'pendingBcaReview'
OR
srr_info.srr_status_cd = 'pendingBssReview'
OR
srr_info.srr_status_cd = 'PendingBoeReview'
OR
srr_info.srr_status_cd = 'offerMade'
OR
srr_info.srr_status_cd = 'offerAccepted'
OR
srr_info.srr_status_cd = 'offerDeclinedTemp'
OR
srr_info.srr_status_cd = 'requiredPermitsSubmitted')
</cfquery>

<cfdump var="#SendNewOffer#" output="browser">


<CFLOOP query="SendNewOffer"><!--- Loop thru waitListed --->

<cfoutput>
#SendNewOffer.srrKey#<br>
</cfoutput>

<cftry>
<cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey = "#trim(SendNewOffer.srrKey)#">

<cfcatch>
<cfoutput>
<br><br>
<div>Error [1] calculating rebate module #trim(SendNewOffer.srrKey)# SR ID = #trim(SendNewOffer.srr_id)#</div>
<P>#CFCATCH.message#</P>
    <P>Caught an exception, type = #CFCATCH.TYPE# </P>
    <P>The contents of the tag stack are:</P>
    <CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
          <CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
              <BR>#i# #sCurrent["ID"]# 
(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) #sCurrent["TEMPLATE"]#
</CFLOOP>
<br><br>

</cfoutput>
<!--- <cfabort> --->
</cfcatch>

</cftry>
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
fakeUpdate = 1
 <cfif (srr_status_cd is 'received' 
 OR srr_status_cd is 'notEligibleTemp' 
 OR srr_status_cd is 'incompleteDocsTemp' 
 OR srr_status_cd is 'pendingBcaReview'  
 OR srr_status_cd is 'pendingBssReview' 
 OR srr_status_cd is 'PendingBoeReview')>
, offer_reserved_amt = #SendNewOffer.res_cap_amt#
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0



 <cfelseif (srr_status_cd is 'offerMade')>
 , offer_reserved_amt = 0
, offer_open_amt = #request.rebateTotal#
, offer_accepted_amt = 0
, offer_paid_amt = 0

 <cfelseif (srr_status_cd is 'offerAccepted' OR srr_status_cd is 'requiredPermitsSubmitted')>
 , offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = #request.rebateTotal#
, offer_paid_amt = 0

 <cfelseif (srr_status_cd is 'offerDeclinedTemp')>
 , offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0


</cfif>

, record_history = isnull(record_history, '')  + '|Rebate Rate/Cap was automatically switched from rate 1 to rate 2 on #dateformat(now(),"mm/dd/yyyy")# since construction did not start.'

where srrKey = '#SendNewOffer.srrKey#'
</cfquery>

<cftry>
<cfmodule template="../modules/getCurrentSrCode.cfm" srrKey = "#SendNewOffer.srrKey#">
<cfcatch>
Error getting SRCode 
<cfabort>
</cfcatch>
</cftry>

<cfset request.srNum = #SendNewOffer.sr_number#>
<cfset request.srCode = "#request.currentSrCode#">
<cfset request.srComment = "Starting on August 1, 2017, the Board of Public Works has approved an increase to the maximum Rebate amount for both residential and commercial properties. The Rebate increase includes raising the maximum Rebate amount to $10,000 and raising the tree remove and replace valuation amount from $500 to $1,000 for both residential and commercial properties. 

If you previously received a Rebate Offer, it has already been updated to reflect the increased Rebate amounts.

To continue monitoring your application, use the following link:
https://engpermits.lacity.org/srr/public/app_requirements.cfm?srrKey=#SendNewOffer.srrKey#
">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<cfif #request.srupdate_success# is "N">
<cfmail to="essam.amarragy@lacity.org" from="srrUpdateError@lacity.org" subject="Error Updating MyLA311 - SR: #request.sr_number#">
Error Calling srr/modules/updateSR_module.cfm
Update Success = #request.srupdate_success#
Update Err Msg = #request.srupdate_err_message#
</cfmail>
</cfif>
</cfif><!--- 000 --->
<cfcatch type="Any">
<cfmail to="essam.amarragy@lacity.org" from="srrUpdateError@lacity.org" subject="Error Updating MyLA311 - SR: #request.sr_number#">
Error Calling srr/modules/updateSR_module.cfm - see CFcatch portion on override rebate rates 2
</cfmail>
</cfcatch>
</cftry>

</cfloop>

 <!--- Move application from the wailListed to received if funds are available --->
<cfquery name="SendNewOffer1" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.rate_nbr
, srr_info.srrKey
, srr_info.sr_number
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_info.job_address
, srr_info.prop_type
, srr_info.tree_insp_sr_number
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

, srr_info.offer_reserved_amt
, srr_info.offer_open_amt
, srr_info.offer_accepted_amt
, srr_info.offer_paid_amt


FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   
WHERE 
(srr_info.srr_status_cd = 'received'
OR
srr_info.srr_status_cd = 'notEligibleTemp'
OR
srr_info.srr_status_cd = 'incompleteDocsTemp'
OR
srr_info.srr_status_cd = 'pendingBcaReview'
OR
srr_info.srr_status_cd = 'pendingBssReview'
OR
srr_info.srr_status_cd = 'PendingBoeReview'
OR
srr_info.srr_status_cd = 'offerMade'
OR
srr_info.srr_status_cd = 'offerAccepted'
OR
srr_info.srr_status_cd = 'offerDeclinedTemp'
OR
srr_info.srr_status_cd = 'requiredPermitsSubmitted')
</cfquery>

<cfdump var="#SendNewOffer1#" output="browser">



<cfoutput>
<div align="center">SRR  one-time Script Completed on #now()#</div>
</cfoutput>

<!--- <cfmail to="essam.amarragy@lacity.org,Jimmy.Lam@lacity.org" from="SRRTasks@lacity.org" subject="Srr Nightly Script Successfully Completed">
SRR Nightly Script Successfully Completed on #now()#
</cfmail> --->

