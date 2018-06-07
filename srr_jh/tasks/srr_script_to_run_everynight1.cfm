<!--- rate_nbr ready --->
<cfinclude template="../common/myCFfunctions.cfm">

 <!--- Move application from the wailListed to received if funds are available --->
<cfquery name="waitListed" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.srrKey
, srr_info.sr_number
, srr_info.srr_status_cd
, srr_status.srr_status_desc
, srr_info.job_address
, srr_info.prop_type
, srr_info.tree_insp_sr_number
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   
WHERE 
srr_info.srr_status_cd = 'waitListed'
order by srr_info.ddate_submitted
</cfquery>

<!--- <cfdump var="#waitListed#" output="browser"> --->

<CFLOOP query="waitListed"><!--- Loop thru waitListed --->
<cfinclude template="../common/calc_balanceNow.cfm">
<cfif #waitListed.prop_type# is "R" and #request.balanceNow# gte #waitListed.res_cap_amt#>
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'received'
, waitListed_to_received_dt = #now()#
, offer_reserved_amt = #waitListed.res_cap_amt#
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application moved from waiting list to the received list on (#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#)  (Action taken by Automated Nightly Script).'
where srr_id = #waitListed.srr_id#
</cfquery>

<cfset request.srNum = #waitListed.sr_number#>
<cfset request.srCode = "12"><!--- Code 12 is received --->
<!--- message up to date 11/4/2016 --->
<cfset request.srComment = "Funds are now available for additional Sidewalk Repair Rebates. Your application was forwarded on (#dateformat(Now(),'mm/dd/yyyy')# for further processing. Staff will determine if your request is eligible for a rebate. Please monitor your email for further instructions.">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
<cfelseif (#waitListed.prop_type# is "C" or #waitListed.prop_type# is "") and #request.balanceNow# gte #waitListed.comm_cap_amt#>
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'received'
, waitListed_to_received_dt = #now()#
, offer_reserved_amt = #waitListed.comm_cap_amt#
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application moved from waiting list to the received list on (#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#)  (Action taken by Automated Nightly Script).'
where srr_id = #waitListed.srr_id#
</cfquery>


<cfset request.srNum = #waitListed.sr_number#>
<cfset request.srCode = "12"><!--- Code 12 is received ---> 
<cfset request.srComment = "Funds are now available for additional Sidewalk Repair Rebates. Your application was forwarded on (#dateformat(Now(),'mm/dd/yyyy')# for further processing. Staff will determine if your request is eligible for a rebate. Please monitor your email for further instructions.">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfif>

</CFLOOP><!--- Loop thru waitListed --->
<!--- Move application from the waiting list to received if funds are available --->


<!--- notEligibleTemp by BPW will stay in this status for 14 days and then becomes notEligible and cannot be appealed. --->
<cfquery name="notEligibleTemp" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, notEligible_dt
, notEligible_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'notEligibleTemp'
and notEligible_exp_dt < #CreateODBCDateTime(now())#
</cfquery><!--- if a request was appealed it will have an srr_status_cd of "appealedEligibility" --->

<cfloop query="notEligibleTemp"><!--- Loop thru notEligibleTemp that are expired --->
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'notEligible'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|14 days have passed since application was found to be NOT Eligible. Appeal deadline was on  #dateformat(notEligibleTemp.notEligible_exp_dt,"mm/dd/yyyy")# (Action taken by Automated Nightly Script).'
where srr_id = #notEligibleTemp.srr_id#
</cfquery>

<cfset request.srNum = #notEligibleTemp.sr_number#>
<cfset request.srCode = "13"><!--- notEligible Code = 13 --->
<cfset request.srComment = ""><!--- Applicant was previously informed, no email needed --->
<cftry>
<!--- No need to send comments to customer --->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfloop><!--- Loop thru notEligibleTemp that are expired --->

<!--- <cfdump var="#notEligibleTemp#" output="browser"> --->
<!--- notEligibleTemp by BPW will stay in this status for 14 days and then becomes notEligible and cannot be appealed. --->




<!--- incompleteDocsTemp by BPW will stay in this status for 14 days and then becomes incompleteDocs and cannot be appealed. --->
<cfquery name="incompleteDocsTemp" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, incompleteDocs_dt
, incompleteDocs_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'incompleteDocsTemp'
and incompleteDocs_exp_dt < #CreateODBCDateTime(now())#
</cfquery><!--- if a request was appealed it will have an srr_status_cd of "appealedIncompleteDocsExp" --->

<cfloop query="incompleteDocsTemp"><!--- Loop thru incompleteDocsTemp that are expired --->
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'incompleteDocs'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application expired on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.  14 days have passed since BPW requested addtional documents on #dateformat(incompleteDocsTemp.incompleteDocs_dt,"mm/dd/yyyy")# to verify eligibility.  Applicant did not provide the requested documents -  (Action taken by Automated Nightly Script).'
where srr_id = #incompleteDocsTemp.srr_id#
</cfquery>


<cfset request.srNum = #incompleteDocsTemp.sr_number#>
<cfset request.srCode = "15"><!--- incompleteDocs Code = 15 --->
<cfset request.srComment = "We regret to inform you that the documents requested on  #dateformat(incompleteDocsTemp.incompleteDocs_dt,'mm/dd/yyyy')# were not submitted within 14 days and your application for sidewalk rebate has been canceled on #dateformat(now(),'mm/dd/yyyy')#.">
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfloop><!--- Loop thru incompleteDocsTemp that are expired --->

<!--- <cfdump var="#incompleteDocsTemp#" output="browser"> --->
<!--- Not eligible Temp by BPW will stay in this status for 14 days and then becomes notEligible and cannot be appealed. --->


<!--- AdaCompliantTemp by BCA will stay in this status for 14 days and then becomes AdaCompliant and cannot be appealed. --->
<cfquery name="AdaCompliantTemp" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, AdaCompliant_dt
, AdaCompliant_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'AdaCompliantTemp'
and AdaCompliant_exp_dt < #CreateODBCDateTime(now())#
</cfquery><!--- if a request was appealed it will have an srr_status_cd of "appealedEligibility" --->

<cfloop query="AdaCompliantTemp">
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'AdaCompliant'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application Canceled on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#.  14 days have passed since BCA indicated that the site is already ADA compliant -  (Action taken by Automated Nightly Script).'
where srr_id = #AdaCompliantTemp.srr_id#
</cfquery>


<cfset request.srNum = #AdaCompliantTemp.sr_number#>
<cfset request.srCode = "19"><!--- ADA Compliant Code 19 --->
<cfset request.srComment = ""><!--- Applicant was previously informed, no email needed --->
<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif>
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfloop>

<!--- <cfdump var="#AdaCompliantTemp#" output="browser"> --->
<!---ADACompliantTemp by BCA will stay in this status for 14 days and then becomes ADACompliant and cannot be appealed. --->



<!--- check if offer expired with no accept or decline by applicant for 14 days --->
<cfquery name="offerMade" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, offerMade_dt
, offerMade_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt
, job_address

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'offerMade'
and offerMade_exp_dt < #CreateODBCDateTime(now())#
</cfquery>

<cfloop query="offerMade">
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'offerExpired'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application status has been updated to Offer Expired on(#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#).  Applicant did not accept or decline the offer within 14 days -  (Action taken by Automated Nightly Script).'
where srr_id = #offerMade.srr_id#
</cfquery>

<cfset request.srNum = #offerMade.sr_number#>
<cfset request.srCode = "46"> <!--- If the value is numeric then it will update the Reason Code. Otherwise is will update the Resolution Code --->
<cfset request.srComment = "Our records indicate that on #dateformat(offerMade.offerMade_dt,"mm/dd/yyyy")#, we have emailed you an offer for sidewalk repair rebate for #offerMade.job_address#.  Since you did not accept or decline the offer within 14 days, this offer is expired.  You may still appeal this determination by using the following link to file an appeal:<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#offerMade.srrKey#">
<cftry>
<!--- No need to send comments to customer  ??????--->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif>
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfloop><!--- End of looping thru offerMade where offer is expired --->



<!--- If offer is declined by applicant, leave it open for 7 days.  Applicant can accept offer within those 7 days, after that change status from offerDeclinedTemp to offerDeclined permanatly and leave the offer_declined_dt, set all offer amounts to zero --->
<cfquery name="offerDeclinedTemp" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, offerDeclined_dt
, offerDeclined_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'offerDeclinedTemp'
and offerDeclined_exp_dt < #CreateODBCDateTime(now())#
</cfquery><!--- if a request was appealed it will have an srr_status_cd of "appealedEligibility" --->

<!--- <cfmail to="Essam.Amarragy@lacity.org" from="SRROverNightTask@lacity.org" subject="offerDeclinedTemp">
#offerDeclinedTemp.recordcount# offerDeclinedTemp Applications are currently in database and 14 days have passed since the offer was declined.
</cfmail> --->

<cfloop query="offerDeclinedTemp">
<!---  <cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'offerDeclined'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application status has been permanently  updated to Offer Declined on(#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#).  Applicant cannot accept the offer anymore (14 days have passed since applicant declined the offer -  (Action taken by Automated Nightly Script).'
where srr_id = #notEligibleTemp.srr_id#
</cfquery> --->

<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'offerDeclined'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application status has been updated to Offer Declined on (#dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#).  Applicant cannot accept the offer anymore (14 days have passed since applicant declined the offer -  (Action taken by Automated Nightly Script).'
where srr_id = #offerDeclinedTemp.srr_id#
</cfquery>



<cfset request.srNum = #offerDeclinedTemp.sr_number#>
<cfset request.srCode = "45"> <!--- Code 45 = offerDeclined --->
<cfset request.srComment = ""><!--- no need to send email to applicant --->
<cftry>
<!--- No need to send comments to customer --->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif>
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfloop>

<!--- <cfdump var="#offerDeclinedTemp#" output="browser"> --->
<!--- Not eligible Temp by BPW will stay in this status for 14 days and then becomes notEligible and cannot be appealed. --->




<!--- Start Apermit submitted dates  --->
<cfquery name="getApermitSubmitted_dt" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, sr_number
, a_ref_no
, ApermitSubmitted_dt

from srr_info

where 
isdate(ApermitSubmitted_dt) = 0
and 
datalength(a_ref_no) > 0
</cfquery>


<cfloop query="getApermitSubmitted_dt">
<cfquery name="checkSubmitted" datasource="apermits_sql" dbtype="datasource">
select
ref_no
, ddate_submitted

from permit_info
where 
ref_no = #getApermitSubmitted_dt.a_ref_no#
and
isdate(ddate_submitted) = 1
</cfquery>
<cfif #checkSubmitted.recordcount# is 1>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
ApermitSubmitted_dt = #CreateODBCDate(checkSubmitted.ddate_submitted)#
where srr_id = #getApermitSubmitted_dt.srr_id#
</cfquery>


<!--- <cfset emailContent = #emailContent# &"<br><br>" & "
update srr_info
set 
ApermitSubmitted_dt = #CreateODBCDate(checkSubmitted.ddate_submitted)#
where srr_id = #getApermitSubmitted_dt.srr_id#
"> --->

</cfif>

</cfloop>
<!--- End of updating Apermit submitted dates  --->






<!--- Start Updating Apermit issued dates  --->
<cfquery name="getApermitIssuedDt" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, sr_number
, a_ref_no
, ApermitIssued_dt

from srr_info

where 
isdate(ApermitIssued_dt) = 0
and 
isdate(ApermitSubmitted_dt) = 1
and
datalength(a_ref_no) > 0
</cfquery>


<cfloop query="getApermitIssuedDt">
<cfquery name="checkIssued" datasource="apermits_sql" dbtype="datasource">
select
ref_no
, boe_ddate_processed
, application_status

from permit_info
where 
ref_no = #getApermitIssuedDt.a_ref_no#
and
isdate(boe_ddate_processed) = 1
and 
application_status = 'issued'
</cfquery>
<cfif #checkIssued.recordcount# is 1>
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
ApermitIssued_dt = #CreateODBCDate(checkIssued.boe_ddate_processed)#
where srr_id = #getApermitIssuedDt.srr_id#
</cfquery>
</cfif>

</cfloop>
<!--- End Updating Apermit issued dates  --->
<!--- <cfdump var="#getApermitIssuedDt#" output="browser"> --->


<!--- Start New Code 05/17/2017 --->

<!--- Select all applications with status offerAccepted and 60 days have not passed, i.e., offer did not expire.  If offer is accepted and applicant did not submit all required permits within 30 days, this offer will acquire a status of requiredPermitsNotSubmitted.  Later, applications with status requiredPermitsNotSubmitted should be canceled, not closed, manually by SRP staff. --->
<cfquery name="checkOfferAccepted" datasource="#request.dsn#" dbtype="datasource">
SELECT
 srr_info.srr_id
 , srr_info.srrKey
 , srr_info.sr_number
 , srr_info.a_ref_no
 , srr_info.srr_status_cd
 , srr_info.offerAccepted_dt
, srr_info.offerAccepted_exp_dt
, srr_info.ApermitSubmitted_dt 
, srr_info.ApermitIssued_dt
 
FROM  srr_info

where 
srr_status_cd = 'offerAccepted'
and
srr_info.offerAccepted_exp_dt >= #CreateODBCDate(now())#
</cfquery>

<cfloop query="checkOfferAccepted">


<!--- set defaults --->
<cfset request.newStatus = "offerAccepted">
<!--- Apermits --->
<cfset request.ApermitSubmitted = 0>
<cfset request.ApermitSubmitted_dt = "">
<cfset request.ApermitIssued = 0>
<cfset request.ApermitIssued_dt = "">

<!--- Tree Removal Permit --->
<cfset request.TrPermitRequired = 0>
<cfset request.TrPermitSubmitted = 0>
<cfset request.TrPermitSubmitted_dt = "">
<cfset request.TrPermitIssued = 0>
<cfset request.TrPermitIssued_dt = "">
<!--- Tree Pruning Permit --->
<cfset request.TpPermitRequired = 0>
<cfset request.TpPermitSubmitted = 0>
<cfset request.TpPermitSubmitted_dt = "">
<cfset request.TpPermitIssued = 0>
<cfset request.TpPermitIssued_dt = "">


<!--- check if A-permit is submitted --->
<cfif isdate(#checkOfferAccepted.ApermitSubmitted_dt#)>
<cfset request.ApermitSubmitted = 1>
<cfset request.ApermitSubmitted_dt = #checkOfferAccepted.ApermitSubmitted_dt#>
</cfif>
<!--- check if A-permit is submitted --->

<!--- check if A-permit is submitted --->
<cfif isdate(#checkOfferAccepted.ApermitIssued_dt#)>
<cfset request.ApermitIssued = 1>
<cfset request.ApermitIssued_dt = #checkOfferAccepted.ApermitIssued_dt#>
</cfif>
<!--- check if A-permit is submitted --->


<cfquery name="checkTreeInfo" datasource="#request.dsn#" dbtype="datasource">
Select 

 ISNULL(tree_info.nbr_trees_pruned, 0) AS nbr_trees_pruned
 , ISNULL(tree_info.lf_trees_pruned, 0) AS lf_trees_pruned
 , ISNULL(tree_info.nbr_trees_removed, 0) AS nbr_trees_removed

FROM  tree_info
where 
 tree_info.srr_id = #checkOfferAccepted.srr_id#
</cfquery>

<!--- Check Tree Removal Permit --->
<cfif #checkTreeInfo.recordcount# is 1><!--- 00000 --->
	
	<cfif #checkTreeInfo.nbr_trees_removed# gt 0><!--- 1 --->
	<cfset request.TrPermitRequired = 1>
	<cfquery name="checkTrPermit" datasource="#request.dsn#" dbtype="datasource">
	Select 
	Tree_removal_permit.ddate_submitted AS TrPermitSubmitted_dt
	, Tree_removal_permit.bss_ddate_issued AS TrPermitIssued_dt

	FROM  Tree_removal_permit 
	Where srr_id = #checkOfferAccepted.srr_id#
	</cfquery>
	
	<cfif #checkTrPermit.recordcount# gt 0 and isdate(#checkTrPermit.TrPermitSubmitted_dt#)>
		<cfset request.TrPermitSubmitted = 1>
		<cfset request.TrPermitSubmitted_dt = #checkTrPermit.TrPermitSubmitted_dt#>
	</cfif>
	
	<cfif #checkTrPermit.recordcount# gt 0 and isdate(#checkTrPermit.TrPermitIssued_dt#)>
		<cfset request.TrPermitIssued = 1>
		<cfset request.TrPermitIssued_dt = #checkTrPermit.TrPermitIssued_dt#>
	</cfif>
	
	
	</cfif><!--- 1 --->

	<!--- Check Tree Pruning Permit --->
	<cfif #checkTreeInfo.nbr_trees_pruned# gt 0 or #checkTreeInfo.lf_trees_pruned# gt 0>
	<cfset request.TpPermitRequired = 1>
	<cfquery name="checkTpPermit" datasource="#request.dsn#" dbtype="datasource">
	Select 
	Tree_pruning_permit.ddate_submitted AS TpPermitSubmitted_dt
 	, Tree_pruning_permit.bss_ddate_issued AS TpPermitIssued_dt

	FROM  Tree_pruning_permit
	Where srr_id = #checkOfferAccepted.srr_id#
	</cfquery>
	<cfif #checkTpPermit.recordcount# gt 0 and isdate(#checkTpPermit.TpPermitSubmitted_dt#)>
		<cfset request.TpPermitSubmitted = 1>
		<cfset request.TpPermitSubmitted_dt = #checkTpPermit.TpPermitSubmitted_dt#>
	</cfif>
	
	<cfif #checkTpPermit.recordcount# gt 0 and isdate(#checkTpPermit.TpPermitIssued_dt#)>
		<cfset request.TpPermitIssued = 1>
		<cfset request.TpPermitIssued_dt = #checkTpPermit.TpPermitIssued_dt#>
	</cfif>
	
	</cfif>

</cfif><!--- 0000 --->


<!--- done with evaluating all variables. --->




<cfif #request.ApermitSubmitted# is 0><!--- 222 --->
<cfset request.newStatus = "offerAccepted">

<!-- in all the following code, assume that request.ApermitSubmitted = 1 -->

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 0 
and  #request.TrPermitRequired# is 1 and #request.TrPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 0 
and  #request.TpPermitRequired# is 1  and #request.TpPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and #request.TrPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TpPermitRequired# is 1  and #request.TpPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">


<cfelseif #request.ApermitSubmitted# is 1 and  #request.TrPermitRequired# is 0 and #request.TpPermitRequired# is 0>
<cfset request.newStatus = "requiredPermitsSubmitted">
<cfset request.requiredPermitsSubmitted_dt = #request.ApermitSubmitted_dt#>


<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 0  and  #request.TpPermitRequired# is 0>
<cfset request.newStatus = "requiredPermitsIssued">

<cfset request.requiredPermitsIssued_dt = #request.ApermitIssued_dt#>



<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1 
and  #request.TpPermitRequired# is 0>

<cfset request.newStatus = "requiredPermitsSubmitted">
<cfset request.requiredPermitsSubmitted_dt = #request.ApermitSubmitted_dt#>

<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TrPermitSubmitted_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsSubmitted_dt = #request.TrPermitSubmitted_dt#>
</cfif>

<cfelseif 
#request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1  and  #request.TrPermitIssued# is 1 
and  #request.TpPermitRequired# is 0>
<cfset request.newStatus = "requiredPermitsIssued">
<cfset request.requiredPermitsIssued_dt = #request.ApermitIssued_dt#>
<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TrPermitIssued_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsIssued_dt = #request.TrPermitIssued_dt#>
</cfif>


<cfelseif 
#request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1  and  #request.TrPermitIssued# is 1 
and  #request.TpPermitRequired# is 1 and  #request.TpPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif 
#request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1  and  #request.TrPermitIssued# is 1 
and  #request.TpPermitRequired# is 1 and  #request.TpPermitSubmitted# is 1 and  #request.TpPermitIssued# is 0>
<cfset request.newStatus = "requiredPermitsSubmitted">

<cfset request.requiredPermitsSubmitted_dt = #request.ApermitSubmitted_dt#>

<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TrPermitSubmitted_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsSubmitted_dt = #request.TrPermitSubmitted_dt#>
</cfif>

<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TpPermitSubmitted_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsSubmitted_dt = #request.TpPermitSubmitted_dt#>
</cfif>



<cfelseif 
#request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1  and  #request.TrPermitIssued# is 1 
and  #request.TpPermitRequired# is 1 and  #request.TpPermitSubmitted# is 1 and  #request.TpPermitIssued# is 1>
<cfset request.newStatus = "requiredPermitsIssued">

<cfset request.requiredPermitsIssued_dt = #request.ApermitIssued_dt#>

<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TrPermitIssued_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsIssued_dt = #request.TrPermitIssued_dt#>
</cfif>

<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TpPermitIssued_dt#) is -1><!--- date1 is less than date 2 --->
<cfset request.requiredPermitsIssued_dt = #request.TpPermitIssued_dt#>
</cfif>


</cfif>
<!--- End Condition checking here --->



<cfif #request.newStatus# is "requiredPermitsSubmitted">
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = '#request.newStatus#'
, requiredPermitsSubmitted_dt = #CreateODBCDate(request.requiredPermitsSubmitted_dt)#
, record_history = isnull(record_history, '')  + '|All required permits were submitted as of #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# -  (Action taken by Automated Nightly Script).'
where srr_id = #checkOfferAccepted.srr_id#
</cfquery>


<cfelseif #request.newStatus# is "requiredPermitsIssued">
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = '#request.newStatus#'
, requiredPermitsIssued_dt = #CreateODBCDate(request.requiredPermitsIssued_dt)#
, requiredPermitsIssued_exp_dt = dateAdd("d", 90, #request.requiredPermitsIssued_dt#)<!--- This is the deadline to finish construction --->

, record_history = isnull(record_history, '')  + '|All required permits were Issued as of #dateformat(request.requiredPermitsIssued_dt,"mm/dd/yyyy")# -  (Action taken by Automated Nightly Script).'
where srr_id = #checkOfferAccepted.srr_id#
</cfquery>

<cfset request.srNum = #checkOfferAccepted.sr_number#>
<cfset request.srCode = "25"> <!--- Code 25, Required Permits Issued --->
<cfset request.srComment = "Thank you for your participation in the City of Los Angeles Sidewalk Rebate Program. Our records indicate that all required permits were issued. You now have 90 calendar days as of  #dateformat(request.requiredPermitsIssued_dt,'mm/dd/yyyy')# to properly complete the sidewalk repairs which gives a deadline until #dateformat(request.requiredPermitsIssued_exp_dt,'mm/dd/yyyy')#.<br><br>
Please be sure to call for inspection prior to performing the repairs as outlined on your Class A-Permit in order to ensure that the repair is properly recorded.
The following is a link to print all issued permit (as applicable).<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#checkOfferAccepted.srrKey#
">
<cftry>
<!--- No need to send comments to customer --->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif>
<cfcatch type="Any">
<!--- Do nothing --->
</cfcatch>
</cftry>

</cfif>

</cfloop>
<!--- End New Code 05/17/2017 --->


<!--- The script will not deal with offerAccepted and expired
Something has to be added to deal with this at a later time
 --->




<!--- start new code 5/18/2017 --->
<cfquery name="checkRequiredPermitsSubmitted" datasource="#request.dsn#" dbtype="datasource">
SELECT
 srr_info.srr_id
 , srr_info.srrKey
 , srr_info.sr_number
 , srr_info.a_ref_no
 , srr_info.srr_status_cd
 , srr_info.offerAccepted_dt
, srr_info.offerAccepted_exp_dt
, srr_info.ApermitSubmitted_dt 
, srr_info.ApermitIssued_dt
 
FROM  srr_info 

where srr_info.srr_status_cd = 'requiredPermitsSubmitted'
</cfquery>


<cfloop query="checkRequiredPermitsSubmitted">
<!--- Set Defaults --->
<cfset request.newStatus = "requiredPermitsSubmitted"><!--- this will be the default status if required permits are not issued --->
<!--- An A-permit is always required --->
<cfset request.ApermitIssued = 0>
<cfset request.ApermitIssued_dt = "">

<cfset request.TrPermitRequired = 0>
<cfset request.TrPermitIssued = 0>
<cfset request.TrPermitIssued_dt = "">

<cfset request.TpPermitRequired = 0>
<cfset request.TpPermitIssued = 0>
<cfset request.TpPermitIssued_dt = "">

<!--- check if A-permit is issued --->
<cfif isdate(#checkRequiredPermitsSubmitted.ApermitIssued_dt#)>
<cfset request.ApermitIssued = 1>
<cfset request.ApermitIssued_dt = #checkRequiredPermitsSubmitted.ApermitIssued_dt#>
</cfif>
<!--- check if A-permit is issued --->

<cfquery name="checkTreeInfo" datasource="#request.dsn#" dbtype="datasource">
Select 

 ISNULL(tree_info.nbr_trees_pruned, 0) AS nbr_trees_pruned
 , ISNULL(tree_info.lf_trees_pruned, 0) AS lf_trees_pruned
 , ISNULL(tree_info.nbr_trees_removed, 0) AS nbr_trees_removed

FROM  tree_info
where 
 tree_info.srr_id = #checkRequiredPermitsSubmitted.srr_id#
</cfquery>

<cfif #checkTreeInfo.recordcount# is 1><!--- 1 --->
	<!--- Check Tree Removal Permit --->
	<cfif #checkTreeInfo.nbr_trees_removed# gt 0>
	<cfset request.TrPermitRequired = 1>
	<cfquery name="checkTrPermit" datasource="#request.dsn#" dbtype="datasource">
	Select 
	Tree_removal_permit.ddate_submitted AS TrPermitSubmitted_dt
	, Tree_removal_permit.bss_ddate_issued AS TrPermitIssued_dt

	FROM  Tree_removal_permit 
	Where srr_id = #checkRequiredPermitsSubmitted.srr_id#
	</cfquery>
	<cfif #checkTrPermit.recordcount# gt 0 and isdate(#checkTrPermit.TrPermitIssued_dt#)>
		<cfset request.TrPermitIssued = 1>
		<cfset request.TrPermitIssued_dt = #checkTrPermit.TrPermitIssued_dt#>
	</cfif>
	</cfif>

	<!--- Check Tree Pruning Permit --->
	<cfif #checkTreeInfo.nbr_trees_pruned# gt 0>
	<cfset request.TpPermitRequired = 1>
	<cfquery name="checkTpPermit" datasource="#request.dsn#" dbtype="datasource">
	Select 
	Tree_pruning_permit.ddate_submitted AS TpPermitSubmitted_dt
 	, Tree_pruning_permit.bss_ddate_issued AS TpPermitIssued_dt

	FROM  Tree_pruning_permit
	Where srr_id = #checkRequiredPermitsSubmitted.srr_id#
	</cfquery>
	<cfif #checkTpPermit.recordcount# gt 0 and isdate(#checkTpPermit.TpPermitIssued_dt#)>
		<cfset request.TpPermitIssued = 1>
		<cfset request.TpPermitIssued_dt = #checkTpPermit.TpPermitIssued_dt#>
	</cfif>
	</cfif>

</cfif><!--- 1 --->


<cfif #request.ApermitIssued# is 0>
	<!--- Leave status as is:  requiredPermitsSubmitted  --->
	<!--- in all the following code, assume that request.ApermitSubmitted = 1 --->

<cfelseif #request.ApermitIssued# is 1 and #request.TrPermitRequired# is 0 and #request.TpPermitRequired# is 0>
	<cfset request.newStatus = "requiredPermitsIssued">
	<cfset request.requiredPermitsIssued_dt = #checkRequiredPermitsSubmitted.ApermitIssued_dt#>


<cfelseif #request.ApermitIssued# is 1 and #request.TrPermitRequired# is 1  and  #request.trPermitIssued# is 0>
	<!--- <cfset request.newStatus = "requiredPermitsSubmitted">
	<cfset request.requiredPermitsIssued_dt = ""> --->

<cfelseif #request.ApermitIssued# is 1 and #request.TpPermitRequired# is 1  and  #request.TpPermitIssued# is 0>
<!--- 	<cfset request.newStatus = "requiredPermitsSubmitted">
	<cfset request.requiredPermitsIssued_dt = ""> --->

	
	
<cfelseif #request.ApermitIssued# is 1 and #request.TrPermitRequired# is 1  and  #request.trPermitIssued# is 1 and #request.TpPermitRequired# is 0>
	<cfset request.newStatus = "requiredPermitsIssued">
	<cfset request.requiredPermitsIssued_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>
	<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TrPermitIssued_dt#) is -1>
	<cfset request.requiredPermitsIssued_dt = #request.TrPermitIssued_dt#>
	</cfif>
	
<cfelseif #request.ApermitIssued# is 1 and #request.TpPermitRequired# is 1  and  #request.TpPermitIssued# is 1 and #request.TrPermitRequired# is 0>
	<cfset request.newStatus = "requiredPermitsIssued">
	<cfset request.requiredPermitsIssued_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>
	<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TpPermitIssued_dt#) is -1>
	<cfset request.requiredPermitsIssued_dt = #request.TpPermitIssued_dt#>
	</cfif>

<cfelseif #request.ApermitIssued# is 1 and #request.TrPermitRequired# is 1  and  #request.trPermitIssued# is 1 and #request.TpPermitRequired# is 1 and #request.TpPermitIssued# is 0>

<cfelseif #request.ApermitIssued# is 1 and #request.TpPermitRequired# is 1  and  #request.TpPermitIssued# is 1 and #request.TrPermitRequired# is 1 and #request.TrPermitIssued# is 0>
<!--- 	<cfset request.newStatus = "requiredPermitsSubmitted">
	<cfset request.requiredPermitsIssued_dt = ""> --->

<cfelseif #request.ApermitIssued# is 1 and #request.TrPermitRequired# is 1  and  #request.TrPermitIssued# is 1 and #request.TpPermitRequired# is 1 and #request.TpPermitIssued# is 1>
	<cfset request.newStatus = "requiredPermitsIssued">
	<cfset request.requiredPermitsIssued_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>
	<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TrPermitIssued_dt#) is -1>
	<cfset request.requiredPermitsIssued_dt = #request.TrPermitIssued_dt#>
	</cfif>
	<cfif dateCompare(#request.requiredPermitsIssued_dt#, #request.TpPermitIssued_dt#) is -1>
	<cfset request.requiredPermitsIssued_dt = #request.TpPermitIssued_dt#>
	</cfif>

</cfif>

<cfif #request.newStatus# is "requiredPermitsSubmitted">
<!--- No Action Required --->
<cfelseif #request.newStatus# is "requiredPermitsIssued">
<cfset request.requiredPermitsIssued_exp_dt = dateAdd("d", 90, #request.requiredPermitsIssued_dt#)>
<!--- <cfabort> --->

<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = '#request.newStatus#'
, requiredPermitsIssued_dt = #CreateODBCDate(request.requiredPermitsIssued_dt)#
, requiredPermitsIssued_exp_dt = dateAdd("d", 90, #CreateODBCDate(request.requiredPermitsIssued_dt)#)
, record_history = isnull(record_history, '')  + '|All required permits were Issued as of #dateformat(request.requiredPermitsIssued_dt,"mm/dd/yyyy")# -  (Action taken by Automated Nightly Script).'
where srr_id = #checkRequiredPermitsSubmitted.srr_id#
</cfquery>


<cfset request.srNum = #checkRequiredPermitsSubmitted.sr_number#>
<cfset request.srCode = "25"> <!--- Code 25, Required Permits Issued --->
<cfset request.srComment = "Thank you for your participation in the City of Los Angeles Sidewalk Rebate Program. Our records indicate that all required permits were issued. You now have 90 calendar days as of  #dateformat(request.requiredPermitsIssued_dt,'mm/dd/yyyy')# to properly complete the sidewalk repairs which gives a deadline until #dateformat(request.requiredPermitsIssued_exp_dt,'mm/dd/yyyy')#.<br><br>
Please be sure to call for inspection prior to performing the repairs as outlined on your Class A-Permit in order to ensure that the repair is properly recorded.
The following is a link to print all issued permit (as applicable).<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#checkRequiredPermitsSubmitted.srrKey#
">
<cftry>
<!--- No need to send comments to customer --->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif>
<cfcatch type="Any">
<!--- Do nothing --->
</cfcatch>
</cftry>

</cfif>

</cfloop>
<!--- End of new code as of 5/18/2017 --->



<!--- Start: validated this loop on 5/18/2017 --->
<!--- get applications where All permit were issued and 90 days passed while in this status requiredPermitsIssued --->
<cfquery name="checkConstCompleted" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, sr_number
, requiredPermitsIssued_dt
, requiredPermitsIssued_exp_dt

from srr_info
where 
srr_status_cd = 'requiredPermitsIssued'
and 
requiredPermitsIssued_exp_dt < #CreateODBCDate(now())#
</cfquery>

<cfloop query="checkConstCompleted">
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = 'constDurationExp'
, record_history = isnull(record_history, '')  + '|All required permits were Issued as of #dateformat(checkConstCompleted.requiredPermitsIssued_dt,"mm/dd/yyyy")#.  90 days have passed since all required permits were issued.  This application is deemed expired as of #dateformat(checkConstCompleted.requiredPermitsIssued_exp_dt,"mm/dd/yyyy")# -  (Action taken by Automated Nightly Script).'
where 
srr_id = #checkConstCompleted.srr_id#
</cfquery>

<cfset request.srNum = #checkConstCompleted.sr_number#>
<cfset request.srCode = "46"> <!--- Code 46, constDurationExp --->
<cfset request.srComment = "Thank you for your participation in the City of Los Angeles Sidewalk Rebate Program. Our records indicate that all required permits were issued as of #dateformat(checkConstCompleted.requiredPermitsIssued_dt,'mm/dd/yyyy')#.  Since 90 calendar days have passed and the construction is not completed, this application for rebate is deemed expired as of #dateformat(checkConstCompleted.requiredPermitsIssued_exp_dt,'mm/dd/yyyy')#.
<br><br>
The following link can be used to appeal this decision within 14 days of this corresponsence date:<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#checkConstCompleted.srrKey#
">
<cftry>
<!--- No need to send comments to customer --->
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- Do nothing --->
</cfcatch>
</cftry>
</cfloop>
<!--- Inspection Finaled in A-permit - srr status should be constCompleted --->
<!--- End: validated this loop on 5/18/2017 --->



<!--- Start: Loop was validated on 5/18/2017 --->
<!--- paymentIncompleteDocsTemp by BPW will stay in this status for 14 days and then becomes paymentIncompleteDocs and cannot be appealed. --->
<cfquery name="paymentIncompleteDocsTemp" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srrKey
, sr_number
, paymentIncompleteDocs_dt
, paymentIncompleteDocs_exp_dt
, offer_open_amt
, offer_reserved_amt
, offer_accepted_amt
, offer_paid_amt

FROM  dbo.srr_info
			   
WHERE 
srr_status_cd = 'paymentIncompleteDocsTemp'
and paymentIncompleteDocs_exp_dt < #CreateODBCDateTime(now())#
</cfquery><!--- if a request was appealed it will have an srr_status_cd of "appealedEligibility" --->

<cfloop query="paymentIncompleteDocsTemp">
<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
srr_status_cd = 'paymentIncompleteDocs'
, offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
, record_history = isnull(record_history, '')  + '|Application was canceled on #dateformat(paymentIncompleteDocsTemp.paymentIncompleteDocs_exp_dt,"mm/dd/yyyy")#.  Reason:14 days have passed since the BPW requested addtional documents for payment processing.   Documents were requested on  #dateformat(paymentIncompleteDocsTemp.paymentIncompleteDocs_dt,"mm/dd/yyyy")# .  Applicant did not provide the requested documents -  (Action taken by Automated Nightly Script).'
where srr_id = #paymentIncompleteDocsTemp.srr_id#
</cfquery>

<cfset request.srNum = #paymentIncompleteDocsTemp.sr_number#>
<cfset request.srCode = "15"> 
<cfset request.srComment = "We regret to inform you that the documents, for rebate payment processing, requested on  #dateformat(paymentIncompleteDocsTemp.paymentIncompleteDocs_dt,'mm/dd/yyyy')# were not submitted within 14 days.   Your application for sidewalk rebate has been canceled on #dateformat(paymentIncompleteDocsTemp.paymentIncompleteDocs_exp_dt,'mm/dd/yyyy')#.
<br><br>
The following link can be used to appeal this decision within 14 days of this corresponsence date:<br><br>
#request.serverRoot#/srr/public/submit_an_appeal1.cfm?srrKey=#paymentIncompleteDocsTemp.srrKey#
">


<cftry>
<cfif #request.production# is "p"><!--- 000 --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>


</cfloop>
<!--- End: Loop was validated on 5/18/2017 --->




<cfquery name="updateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
offer_open_amt = 0
, offer_reserved_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

where 
srr_status_cd = 'offerExpired'
or
srr_status_cd = 'cancelTicket'
or
srr_status_cd = 'AdaCompliant'
or
srr_status_cd = 'offerDeclined'
or
srr_status_cd = 'requiredPermitsNotSubmitted'
or
srr_status_cd = 'incompleteDocs'
or
srr_status_cd = 'constDurationExp'
or
srr_status_cd = 'notEligible'
or
srr_status_cd = 'paymentIncompleteDocs'

</CFQUERY>


<!--- <cfabort> --->
<cfoutput>
<div align="center">SRR Nightly Script Successfully Completed on #now()#</div>
</cfoutput>

<cfmail to="essam.amarragy@lacity.org,Jimmy.Lam@lacity.org" from="SRRTasks@lacity.org" subject="Srr Nightly Script Successfully Completed">
SRR Nightly Script Successfully Completed on #now()#
</cfmail>

