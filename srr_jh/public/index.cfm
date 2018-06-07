<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">

<style>
body{
text-align:left;
}

li {
margin-left:15px;
padding: 10px;
}

</style>

<div style="width:900px;margin-left:auto;margin-right:auto;margin-top:5px;margin-bottom:12px;border:1px solid gray;border-radius:7px;padding:15px;">
<div style="color:maroon;font-weight:bold;font-size:110%">Applicant Side Notifications/Interaction with the Sidewalk Rapair Rebate System:</div>
<ul>
<li><a href="email_to_applicant_received.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate <strong>Received</strong>.</a></li>
<div style="margin-left:25px;">(MyLA311 will automatically send this email to customer, no action required on SRR side)</div>


<li><a href="email_to_applicant_waitlisted.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate was placed on <strong>Waiting List.</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 11 / Status = Pending / Reason Code Text = Application - On Waiting List)</div>

<li><a href="email_to_applicant_not_eligible.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate is <strong>not Eligible</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 13 / Status = Pending / Reason Code Text = Not Eligible for Rebate)</div>

<li><a href="email_to_applicant_appealed_eligibility.cfm" target="_blank">Email to customer - Sent by MyLA311 -  <strong> <strong>Appealed - Eligibilty</strong></a></li></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 14 / Status = Pending / Reason Code Text = Appealed Eligibilty)</div>

<li><a href="email_to_applicant_incomplete_eligibility.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate is <strong>Incomplete (Eligibility Phase)</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 15 / Status = Pending / Reason Code Text = Application is Incomplete.)</div>

<li><a href="email_to_applicant_eligible.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate is <strong>Eligible</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 16 / Status = Pending / Reason Code Text = Field Inspection Required)</div>
<div style="margin-left:25px;"><a href="email_to_applicant_eligible_bss_rev.cfm" target="_blank">(Programming Note: Send Reason Code = 17 when request status is BSS Pending Review / Status = Pending / Reason Code Text = Field Inspection Required)</a></div>
<div style="margin-left:25px;"><a href="email_to_applicant_eligible_boe_rev.cfm" target="_blank">(Programming Note: Send Reason Code = 18 when request status is BOE Pending Review / Status = Pending / Reason Code Text = Field Inspection Required)</a></div>


<li><a href="email_to_applicant_ada_compliant.cfm" target="_blank">Email to customer - Sent by MyLA311 - <strong>Site is Already ADA Compliant.</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 19 / Status = Pending / Reason Code Text = No sidewalk repair required, Site was found to be ADA Compliant - Send Resolution Code = DE for Denied, Status will change to Canceled)</div>


<li><a href="email_to_applicant_offer.cfm" target="_blank">Email to customer - Sent by MyLA311 - Request for Sidewalk Repair Rebate - <strong>Offer will be sent by email.</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 20 / Status = Pending / Reason Code Text = Offer will be sent to you.)</div>

<li><a href="email_to_applicant_offer_declined.cfm" target="_blank">Email to customer - Sent by SRR - Request for Sidewalk Repair Rebate - <strong>Offer Declined by Applicant.)</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = N/A, Resolution Code = OD, Status = Closed).</div>

<li><a href="email_to_applicant_offer_about_to_expire.cfm" target="_blank">Email to customer - Sent by SRR - Request for Sidewalk Repair Rebate - <strong>Offer about to expire.)</strong></a></li>
<div style="margin-left:25px;">(Programming Note: No need to change reason/resolution codes in MyLA311 - A nightly script will perform this task).</div>

<li><a href="email_to_applicant_offer_expired.cfm" target="_blank">Email to customer - Sent by SRR - Request for Sidewalk Repair Rebate - <strong>Offer Expired.)</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = N/A, Resolution Code = EX, Status = Expired).</div>

<li><a href="email_to_applicant_pull_permits_about_to_expire.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate - Instruct Applicant to <strong>Submit an A-permit Application - Offer about to expire</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = Warning30 / Status = Pending / Reason Code Text = Applicant need to Start Permitting Process - Offer will expire)</div>
<div style="margin-left:25px;"><a href="email_to_applicant_pull_permits_about_to_expire_w10.cfm" target="_blank">(Programming Note: Send Reason Code = Warning10 / Status = Pending / Reason Code Text = Applicant need to Start Permitting Process - Offer will expire)</a></div>

<li><a href="email_to_applicant_pull_permits.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate - Instruct Applicant to <strong>Submit an A-permit Application</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 21 / Status = Pending / Reason Code Text = Applicant need to Start Permitting Process)</div>

<!--- <li><a href="email_to_applicant_Tree_Removal_Board_Approval_Required.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate - Instruct Applicant <strong>Tree Removal Board Approval Required</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 22 / Status = Pending / Reason Code Text = Tree Removal Board Approval Required)</div> --->

<li><a href="email_to_applicant_a-permit_submited.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate - <strong>A-Permit Submitted</strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 23 / Status = Pending / Reason Code Text = A-Permit Submitted)</div>

<li><a href="email_to_applicant_permits_pulled.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  Permits Pulled -<strong> 90 days to complete construction.</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 24 / Status = Pending / Reason Code Text = You have 90 days to complete construction)</div>
<div style="margin-left:25px;"><a href="email_to_applicant_permits_pulled_25.cfm" target="_blank">(Programming Note: Send Reason Code = 25 / Status = Pending / Reason Code Text = You have 90 days to complete construction)</a></div>

<li><a href="email_to_applicant_construction_not_completed_reminder.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Reminder - Construction not Completed</strong></strong></a></li>

<li><a href="email_to_applicant_const_completed.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Construction Completed</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 26 / Status = Construction Completed / Reason Code Text = Construction Completed)</div>

<li><a href="email_to_applicant_payment_incomplete_docs.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Incomplete Documents to Process Payment</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 27 / Status = Payment - Incomplete Documents. / Reason Code Text = Incomplete Documents to Process Payment)</div>

<li><a href="email_to_applicant_payment_pending.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Payment Pending</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 28 / Status =  Payment Pending./ Reason Code Text = Payment Pending)</div>

<li><a href="email_to_applicant_payment_issued.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Payment Issued</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = N/A Payment Issued / Status =  Payment Completed / Reason Code Text = Payment Issued)</div>

<li><a href="email_to_applicant_appealed_assesment_phase.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Appealed Assessement</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 29 / Status =  Pending / Reason Code Text = Appealed Assesment Phase)</div>

<li><a href="email_to_applicant_appealed_construction_phase.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Appealed Construction Phase</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = 30 / Status =  Pending / Reason Code Text = Appealed Construction Phase)</div>

<li><a href="email_to_applicant_appeal_approved.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Appeal Approved</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = Appeal Approved / Status =  Pending / Reason Code Text = Appeal Approved)</div>

<li><a href="email_to_applicant_appeal_denied.cfm" target="_blank">Email to customer - Sent by SRR System - Request for Sidewalk Repair Rebate -  <strong>Appeal Denied</strong></strong></a></li>
<div style="margin-left:25px;">(Programming Note: Send Reason Code = Appeal Denied / Status =  Completed / Reason Code Text = Appeal Denied)</div>
</ul>
</div>



</div>

<cfinclude template="footer.cfm">