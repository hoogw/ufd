<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/include_sr_job_address.cfm">

<!--- Applicant should not have access to this screen unless offer is accepted, check that condition or offer accepted dt --->

<cfquery name="getSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, srr_status_cd
, mailing_address1
, mailing_address2
, mailing_zip
, mailing_city
, mailing_state
, mailing_address_comp_dt

,[cont_license_no]
,[cont_name]
,[cont_address]
,[cont_city]
,[cont_state]
,[cont_zip]
,[cont_phone]
,[cont_lic_issue_dt]
,[cont_lic_exp_dt]
,[cont_lic_class]
,[cont_info_comp_dt]
, requiredPermitsIssued_exp_dt

FROM  dbo.srr_info

where srrKey = '#request.srrKey#'
</cfquery>

<cfif #getSRR.srr_status_cd# is "offerExpired">
<div class="warning">Our records indicate that the offer we emailed you has expired.</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "appealDenied">
<div class="warning">Your Appeal was Denied</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "offerDeclined">
<div class="warning">Our Records indicate that you have declined the Sidewalk Repair Rebate Program offer.</div>
<cfabort>
<!--- <cflocation addtoken="No" url="offer_to_applicant.cfm?srrKey=#request.srrKey#"> --->
</cfif>

<cfif #getSRR.srr_status_cd# is "cancelTicket">
<div class="warning">Your Application is Canceled<br><br>If you wish to participate in the Sidewalk Repair Rebate Program, please file a new application through <a href="https://myla311.lacity.org/portal/faces/home/service/create-sr?serviceType=Sidewalk%20Repair&isRebateProgram=Y" target="_blank">MyLA311</a></div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "closeTicket">
<div class="warning">Your Application is Closed/Completed</div>
<cfabort>
</cfif>


<cfoutput>
<cfif #getSRR.srr_status_cd# is "received" 
or #getSRR.srr_status_cd# is "PendingBcaReview"
or #getSRR.srr_status_cd# is "PendingBssReview"
or #getSRR.srr_status_cd# is "PendingBoeReview"
>
<div class="warning">Your Application is still in evaluation stage.<br><br>Please continue to monitor your email for further instructions.</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "appealedConstDurationExp" 
or #getSRR.srr_status_cd# is "appealedNotEligible"
or #getSRR.srr_status_cd# is "appealedADACompliant"
or #getSRR.srr_status_cd# is "appealedOfferExpired"
or #getSRR.srr_status_cd# is "appealedRequiredPermitsNotSubmitted"
or #getSRR.srr_status_cd# is "appealedIncompleteDocsExp"
or #getSRR.srr_status_cd# is "appealedPaymentIncompleteDocsExp"
>
<div class="warning">We are considering your appeal.<br><br>Please continue to monitor your email for further instructions.</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "waitListed">
<div class="warning">Your Application is on the waiting list.<br><br>Please continue to monitor your email for further instructions.</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "incompleteDocsTemp"<!---  or #getSRR.srr_status_cd# is "incompleteDocs" --->>
<div class="warning">You application is incomplete.<br><br>Please provide any requested documents using the following link:<br><br>
<a href="uploadfile1.cfm?srrKey=#request.srrKey#">Provide Documents</a>
</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "incompleteDocs"<!---  or #getSRR.srr_status_cd# is "incompleteDocs" --->>
<div class="warning">Your Application is Canceled.<br>Documents required to determine eligibility were not submitted within 14 days.<br>If you wish to participate in the Sidewalk Repair Rebate Program, please file a new application through <a href="https://myla311.lacity.org/portal/faces/home/service/create-sr?serviceType=Sidewalk%20Repair&isRebateProgram=Y" target="_blank">MyLA311</a></div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "offerMade">
<div class="warning">You have a rebate offer pending your review.<br><br>To review the rebate offer, please click on the following link:<br><br>
<a href="offer_to_applicant.cfm?srrKey=#request.srrKey#">Review Rebate Offer.</a>
</div>
<cfabort>
</cfif>

<cfif #getSRR.srr_status_cd# is "notEligibleTemp" 
<!--- or #getSRR.srr_status_cd# is "notEligible" --->
or #getSRR.srr_status_cd# is  "ADACompliantTemp"
<!--- or #getSRR.srr_status_cd# is  "ADACompliant" --->
>
<div class="warning">
Your Application is not Eligible for the Rebate Program.
<br><br>
You may <a href="submit_an_appeal1.cfm?srrKey=#request.srrKey#">file an appeal</a> 
</div>
<cfabort>
</cfif>

<!--- #getSRR.srr_status_cd# is "OfferExpired"
or #getSRR.srr_status_cd# is "requiredPermitsNotSubmitted"
or #getSRR.srr_status_cd# is "constDurationExp"
or #getSRR.srr_status_cd# is "incompleteDocs"
or  ---> 
<cfif #getSRR.srr_status_cd# is "paymentIncompleteDocs" or #getSRR.srr_status_cd# is "constDurationExp">
<div class="warning">
Your Application is expired. <br><br>You did not meet the deadlines for the Rebate Program.
<br><br>
You may <a href="submit_an_appeal1.cfm?srrKey=#request.srrKey#">file an appeal</a> 
</div>
<cfabort>
</cfif>


<cfif #getSRR.srr_status_cd# is "requiredPermitsIssued">
<div class="warning">Construction must be completed by: #dateformat(getSRR.requiredPermitsIssued_exp_dt,"mm/dd/yyyy")#</div>
</cfif>


</cfoutput>



<cfoutput>

<cfif #getSRR.srr_status_cd# is "offerAccepted">
<div class="subtitle">You have accepted the City's offer for Sidewalk Repair Rebate.</div>
</cfif>



<div class="textbox" style="width:730px;">
<div style="text-align:right;margin-bottom:7px;"><a href="rebate_estimate.cfm?srrKey=#request.srrKey#" target="_blank">View Rebate Valuation&nbsp;&nbsp;</a></div>
<h1>What is next?</h1>
<br>
<strong>You need to complete the following steps:</strong>
<br><br>

<table class = "datatable" style="width=100%;">
<tr>
<th>Item</th>
<th>Status</th>
</tr>


<tr>
<td>
<cfif isdate(#getSRR.mailing_address_comp_dt#)>
<strong>1. Provide your mailing address.</strong><br>
#getSRR.mailing_address1#
<cfif #getSRR.mailing_address2# is not "">
<br>
#getSRR.mailing_address2#
</cfif>
<br>
#getSRR.mailing_city# #getSRR.mailing_state#, #getSRR.mailing_zip#
<cfelse>
<strong><a href="edit_mailing_address1.cfm?srrKey=#request.srrKey#">1.  Provide your mailing address.</a></strong>
</cfif>

</td>
<td style="text-align:center;vertical-align:top;"><span class="data"><Cfif isdate(#getSRR.mailing_address_comp_dt#)>Completed on #dateformat(getSRR.mailing_address_comp_dt,"mm/dd/yyyy")#<cfelse>Not Completed</CFIF></span></td>
</tr>


<tr>
<td>
<Cfif isdate(#getSRR.cont_info_comp_dt#)>
<strong>2. Provide the license number for the contractor</strong> who is going to perform the work.<br>
<strong>Contractor:</strong> #getSRR.cont_name#<br>
License Number: #getSRR.cont_license_no#<br>
Address: #getSRR.cont_address#<br>
#getSRR.cont_city# #getSRR.cont_state#  #getSRR.cont_zip# <br>
Phone: #getSRR.cont_phone# <br>
License Class: #getSRR.cont_lic_class#
<cfelseif not isdate(#getSRR.cont_info_comp_dt#) and isdate(#getSRR.mailing_address_comp_dt#)>
<a href="get_contractor_license1.cfm?srrKey=#request.srrKey#"><strong>2. Provide the license number for the contractor</strong></a> who is going to perform the work (license must be class A, C-8, C-12, or C-61:D-06)<br>
<!--- <span style="color:red;">Step 2 must be completed before submitting any required permits.</span> --->
<cfelseif not isdate(#getSRR.cont_info_comp_dt#) and not isdate(#getSRR.mailing_address_comp_dt#)>
<strong>2. Provide the license number for the contractor</strong> who is going to perform the work (license must be class A, C-8, C-12, or C-61:D-06)<br>
<span style="color:red;">Step 1 must be completed first.</span>
</cfif>

</td>
<td style="text-align:center;vertical-align:top;"><span class="data"><Cfif isdate(#getSRR.cont_info_comp_dt#)>Completed on #dateformat(getSRR.cont_info_comp_dt,"mm/dd/yyyy")#<cfelse>Not Completed</CFIF></span></td>
</tr>




<tr>
<td>
<cfif #request.a_ref_no# is not "">
<cfquery name="checkApermit" datasource="apermits_sql" dbtype="datasource">
Select 
ref_no
, ddate_submitted
, boe_ddate_processed
, application_status
from permit_info
where ref_no = #request.a_ref_no#
</cfquery>
</cfif>


<Cfif<!---  isdate(#getSRR.cont_info_comp_dt#) and  ---> #request.a_ref_no# is not "" and isdate(#checkApermit.ddate_submitted#) and NOT isdate(#checkApermit.boe_ddate_processed#)>
3. Your Application for an A-permit is submitted.  You will receive an email once your A-permit is issued or in case we need more information.<br><br>
You may also continue to use the following link to monitor the status of your Sidewalk Rebate Request.<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
<Cfelseif isdate(#getSRR.cont_info_comp_dt#) and NOT isdate(#checkApermit.ddate_submitted#)>
<a href="start_a_permit1.cfm?srrKey=#request.srrKey#"><strong>3.  Start a No-Fee class "A" permit online to perform the required work.</strong></a><br><br>
<cfelseif NOT isdate(#getSRR.cont_info_comp_dt#)>
<strong>3.  Start a No-Fee class "A" permit online to perform the required work.</strong><br>
<span style="color:red;">Complete Steps 1 and 2 first.</span>
<br>
<strong>Note:</strong> The City staff have included only the portions of the pathway around your property that will make the pathway compliant with the Americans with Disabilities Act (ADA).  Before you submit your A-Permit, you may choose to perform additional work on sidewalks and/or driveways that are not eligible for rebate and we will include this additional work on your No-Fee A-permit.  Please consult with your contractor.
<cfelseif #request.a_ref_no# is not "" and isdate(#checkApermit.boe_ddate_processed#)>
<strong>3. Your A-permit is issued.</strong><br><br>
Please use the following link to print a copy of your A-permit.<br>
<a href="#request.serverRoot#/apermits/common/final_permit.cfm?ref_no=#request.a_ref_no#&nla=&srrKey=#request.srrKey#" target="_blank">Print my A-Permit</a>
<br><br>
<font color="red"><strong>THIS PERMIT IS ISSUED UNDER THE SIDEWALK REPAIR REBATE PROGRAM. CONTACT PUBLIC WORKS INSPECTOR 213-485-5080 FOR PRE- AND POST-CONSTRUCTION INSPECTION. CONTACT URBAN FORESTRY 213-847-3077 FOR TREE PRUNING/REMOVING AND/OR REPLACING. ALL WORK MUST BE DONE BY CITY STANDARDS AND MUST BE ADA COMPLIANT.</strong></font>
<br><br>
You may also continue to use the following link to monitor the status of your Sidewalk Rebate Request.<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
</cfif>
</td>
<td style="text-align:center;vertical-align:top;">
<span class="data">
<cfif #request.a_ref_no# is not "" and #checkApermit.ddate_submitted# is "">
Not Submitted
</cfif>
<cfif #request.a_ref_no# is not "" and isdate(#checkApermit.ddate_submitted#) and not isdate(#checkApermit.boe_ddate_processed#)>
Submitted on: <br>#dateformat(checkApermit.ddate_submitted,"mm/dd/yyyy")#
</cfif>
<cfif #request.a_ref_no# is not "" and  isdate(#checkApermit.boe_ddate_processed#)>
Issued on: <br>#dateformat(checkApermit.boe_ddate_processed,"mm/dd/yyyy")#
</cfif>
</span>
<!--- add here last inspection date and if it is finaled, display Construction completed and accepted on xxxxxxxx
If not finaled, display Construction is not completed.
 --->
</td>
</tr>

<cfquery name="checkTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
		recordID
      , srr_id
      , ISNULL(nbr_trees_pruned, 0) AS nbr_trees_pruned
      , ISNULL(lf_trees_pruned, 0) AS lf_trees_pruned
      , ISNULL(nbr_trees_removed,0 ) AS  nbr_trees_removed
      , ISNULL(nbr_trees_onsite, 0) AS  nbr_trees_onsite
      , ISNULL(nbr_trees_offsite, 0) AS nbr_trees_offsite
  FROM srr.dbo.tree_info
  
  where srr_id = #request.srr_id#
</cfquery>


<!-- Tree Removal -->
<cfquery name="chkTreeRemovalPermit" datasource="#request.dsn#" dbtype="datasource">
Select srr_id, ddate_submitted, bss_ddate_issued
from tree_removal_permit
where 
srr_id = #request.srr_id#
</cfquery>
<tr>
<td>
<cfif #checkTrees.recordcount# IS 0 OR #checkTrees.nbr_trees_removed# IS 0>
<strong>4.  Tree Removal Permit is NOT Required.</strong>
<cfelseif NOT isdate(#checkApermit.ddate_submitted#) and #checkTrees.nbr_trees_removed# GT 0>
<strong>4.  Start a No-Fee Tree Removal permit online.</strong><br>
<span style="color:red;">Complete Steps 1, 2 and 3 first.</span>
<cfelseif isdate(#checkApermit.ddate_submitted#) and #checkTrees.nbr_trees_removed# GT 0 and NOT isdate(#chkTreeRemovalPermit.ddate_submitted#)>
<a href="submit_tree_removal_permit1.cfm?srrKey=#request.srrKey#"><strong>4.  Start a No-Fee Tree Removal permit online.</strong></a>
<cfelseif isdate(#chkTreeRemovalPermit.ddate_submitted#) and NOT isdate(#chkTreeRemovalPermit.bss_ddate_issued#)>
<strong>4. You have submitted a No-Fee Tree Removal Permit.</strong>
<cfelseif  isdate(#chkTreeRemovalPermit.bss_ddate_issued#)>
<strong>4.  Your Tree Removal Permit is Issued.</strong><br>
<a href="../common/Print_TreeRemovalPermit.cfm?srrKey=#request.srrKey#" target="_blank">Print my Tree Removal Permit</a>
</cfif>
</td>
<td style="text-align:center;vertical-align:top;">
<span class="data">
<cfif #checkTrees.recordcount# IS 0 OR #checkTrees.nbr_trees_removed# IS 0>
NOT Required
<cfelseif NOT isdate(#checkApermit.ddate_submitted#) and #checkTrees.nbr_trees_removed# GT 0>
NOT Completed
<cfelseif isdate(#checkApermit.ddate_submitted#) and #checkTrees.nbr_trees_removed# GT 0 and NOT isdate(#chkTreeRemovalPermit.ddate_submitted#)>
NOT Completed
<cfelseif isdate(#chkTreeRemovalPermit.ddate_submitted#) and NOT isdate(#chkTreeRemovalPermit.bss_ddate_issued#)>
Submitted on:<br>
#dateformat(chkTreeRemovalPermit.ddate_submitted,"mm/dd/yyyy")#
<cfelseif  isdate(#chkTreeRemovalPermit.bss_ddate_issued#)>
Issued on:
#dateformat(chkTreeRemovalPermit.bss_ddate_issued,"mm/dd/yyyy")#
</cfif>
</span>
</td>
</tr>
<!-- Tree Removal -->

<!--- Tree Pruning --->
<cfquery name="chkTreePruningPermit" datasource="#request.dsn#" dbtype="datasource">
Select srr_id, ddate_submitted, bss_ddate_issued
from tree_pruning_permit
where 
srr_id = #request.srr_id#
</cfquery>
<tr>
<td>
<cfif #checkTrees.recordcount# IS 0 OR #checkTrees.lf_trees_pruned# IS 0>
<strong>5.  Tree Root Pruning Permit is NOT Required.</strong>
<cfelseif NOT isdate(#checkApermit.ddate_submitted#) and #checkTrees.lf_trees_pruned# GT 0>
<strong>5.  Start a No-Fee Tree Root Pruning Permit online.</strong><br>
<span style="color:red;">Complete Steps 1, 3 and 3 first.</span>
<cfelseif isdate(#checkApermit.ddate_submitted#) and #checkTrees.lf_trees_pruned# GT 0 and NOT isdate(#chkTreePruningPermit.ddate_submitted#)>
<a href="submit_tree_pruning_permit1.cfm?srrKey=#request.srrKey#"><strong>5.  Start a No-Fee Tree Root Pruning Permit online.</strong></a>
<cfelseif isdate(#chkTreePruningPermit.ddate_submitted#) and NOT isdate(#chkTreePruningPermit.bss_ddate_issued#)>
<strong>5. You have submitted a No-Fee Tree Root Pruning Permit. Permit is not issued.</strong>
<cfelseif  isdate(#chkTreePruningPermit.bss_ddate_issued#)>
<strong>5.  Your Tree Root Pruning Permit is Issued.</strong><br>
<a href="../common/Print_TreePruningPermit.cfm?srrKey=#request.srrKey#" target="_blank">Print my Tree Root Pruning Permit</a>
</cfif>
</td>
<td style="text-align:center;vertical-align:top;">
<span class="data">
<cfif #checkTrees.recordcount# IS 0 OR #checkTrees.lf_trees_pruned# IS 0>
NOT Required
<cfelseif NOT isdate(#checkApermit.ddate_submitted#) and #checkTrees.lf_trees_pruned# GT 0>
NOT Completed
<cfelseif isdate(#checkApermit.ddate_submitted#) and #checkTrees.lf_trees_pruned# GT 0 and NOT isdate(#chkTreePruningPermit.ddate_submitted#)>
NOT Completed
<cfelseif isdate(#chkTreePruningPermit.ddate_submitted#) and NOT isdate(#chkTreePruningPermit.bss_ddate_issued#)>
Submitted on:<br>
#dateformat(chkTreePruningPermit.ddate_submitted,"mm/dd/yyyy")#
<cfelseif  isdate(#chkTreePruningPermit.bss_ddate_issued#)>
Issued on:
#dateformat(chkTreePruningPermit.bss_ddate_issued,"mm/dd/yyyy")#

</cfif>
</span>
</td>
</tr>
<!--- Tree Pruning --->






<tr>
<td>
<strong>6. Complete and MAIL a <a href="https://www.irs.gov/pub/irs-pdf/fw9.pdf" target="_blank">W9 Form</a> to the following address:</strong><br><br>
City of Los Angeles<br>
Board of Public Works / Office of Community Beautification<br>
200 North Spring Street, Room 356<br>
Los Angeles, CA 90012-4801<br>
Mail Stop 464<br><br>
Attn: Office of Community Beautification
Service Request No. #request.sr_number#
Please DO NOT use any electronic means to submit your W9.<br>
This step may be done now or when the construction is completed and inspected.
</td>
<td style="text-align:center;vertical-align:top;">
<span class="data">Submit by Mail</span>
</td>
</tr>

<cfquery name="getComments" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
, bpw1_comments_to_app
, bpw1_ownership_comments
, bpw1_tax_comments
, bpw1_comments_to_app
, paymentIncompleteReasons
, boe_invest_response_to_app
FROM  dbo.srr_info

where srrKey = '#request.srrKey#'
</cfquery>

<tr>
<td colspan="2">
<p><strong>Important Messages:</strong></p>
<br>
<cfif #trim(getComments.paymentIncompleteReasons)# is not "">
<div align="left">
<span class="data"><strong>Payment Comments:</strong></span>
<cfloop index="xx" list="#getComments.paymentIncompleteReasons#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>

</td>
</tr>



</table>
</div>

<!---<div class="warning" style="width:730px;font-weight:normal;">
Please make a copy of the following link and use it to complete/monitor your Sidewalk Repair Rebate Application:
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#
<br><br>
The link was also provided to you in previous emails.
</div>--->








</cfoutput>

<cfinclude template="../common/footer.cfm">
