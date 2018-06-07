<cfinclude template="../common/myCFfunctions.cfm">

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
sr_status_cd = 'offerAccepted'
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
and  #request.TrPermitRequired# is 1  #request.TrPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 0 
and  #request.TpPermitRequired# is 1  #request.TpPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TrPermitRequired# is 1  #request.TrPermitSubmitted# is 0>
<cfset request.newStatus = "offerAccepted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.ApermitIssued# is 1 
and  #request.TpPermitRequired# is 1  #request.TpPermitSubmitted# is 0>
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
</cfif>

