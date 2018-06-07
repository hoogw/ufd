<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="navbar2.cfm">

<cfquery name="findSrr" datasource="#request.dsn#" dbtype="datasource">
Select 
srr_id
, srrKey
, sr_number
, bca_assessment_comp_dt
, bca_comments
, srr_status_cd

from srr_info
where srrKey = '#request.srrKey#'
</cfquery>

<cfif #request.status_cd# is not "pendingBcaReview">
<cfoutput>
<div class="warning">
SR Status: #request.status_desc#<br><br>
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif>

<cfoutput>
<form action="finalize2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<!---<div class="formbox">--->
<!---<h1>Finalize Request</h1>--->

<div class="divSubTitle">Finalize Request</div>

<div class="field">
<cfif #findSrr.srr_status_cd# is "ADACompliantTemp" OR #findSrr.srr_status_cd# is "pendingBssReview" OR #findSrr.srr_status_cd# is "offerMade" OR #findSrr.srr_status_cd# is "PendingBoeReview" OR #findSrr.srr_status_cd# is "pendingBcaReview">

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="ADACompliantTemp" <cfif #findSrr.srr_status_cd# is "ADACompliantTemp">checked</cfif>> Site Already ADA Compliant</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBssReview" <cfif #findSrr.srr_status_cd# is "pendingBssReview">checked</cfif>> BSS/UFD Inspection Required</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="offerMade" <cfif #findSrr.srr_status_cd# is "offerMade">checked</cfif>> Request/Estimate Completed</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="PendingBoeReview" <cfif #findSrr.srr_status_cd# is "PendingBoeReview">checked</cfif>> Engineering Evaluation Required</label>

<br>
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBcaReview" <cfif #findSrr.srr_status_cd# is "pendingBcaReview">checked</cfif>> Keep for Further Investigation</label>
<cfelse>
<strong>#request.status_desc#</strong>
</cfif>
</div>

<div class="field">
<label>BCA Comments (visible to BOE/BSS):</label>
<textarea name="bca_comments" id="bca_comments" style="width:98%;height:65px;margin-top:5px;" placeholder="Type your comments here ..."><!--- #findSRR.bca_comments# ---></textarea>
</div>



<!---</div>--->
<cfif #request.status_cd# is "pendingBcaReview">
<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>
</cfif>

</form>
</cfoutput>

<cfinclude template="footer.cfm">

