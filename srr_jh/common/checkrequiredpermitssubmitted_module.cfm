<cfif not isdefined("attributes.srrKey")>
<div class="warning">
Invalid Reqeust!
</div>
<cfabort>
</cfif>

<!--- If offerAccepted , applicant has to submit all required permits within 60 days or offer will be expired --->
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
 
 , ISNULL(tree_info.nbr_trees_pruned, 0) AS nbr_trees_pruned
 , ISNULL(tree_info.lf_trees_pruned, 0) AS lf_trees_pruned
 , ISNULL(tree_info.nbr_trees_removed, 0) AS nbr_trees_removed
 , Tree_pruning_permit.ddate_submitted AS TpPermitSubmitted_dt
 , Tree_pruning_permit.bss_ddate_issued AS TpPermitIssued_dt
 , Tree_removal_permit.ddate_submitted AS TrPermitSubmitted_dt
 , Tree_removal_permit.bss_ddate_issued AS TrPermitIssued_dt


FROM  srr_info LEFT OUTER JOIN
               Tree_removal_permit ON srr_info.srr_id = Tree_removal_permit.srr_id LEFT OUTER JOIN
               Tree_pruning_permit ON srr_info.srr_id = Tree_pruning_permit.srr_id LEFT OUTER JOIN
               tree_info ON srr_info.srr_id = tree_info.srr_id

where 
srr_info.srrKey = '#attributes.srrKey#'
</cfquery>


<!--- check if A-permit is submitted --->
<cfif isdate(#checkRequiredPermitsSubmitted.ApermitSubmitted_dt#)>
<cfset request.ApermitSubmitted = 1>
<cfset request.ApermitSubmitted_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>
<cfelse>
<cfset request.ApermitSubmitted = 0>
<cfset request.ApermitSubmitted_dt = "">
</cfif>
<!--- check if A-permit is submitted --->

<!--- Check Tree Removal Permit --->
<cfif #checkRequiredPermitsSubmitted.nbr_trees_removed# gt 0>
<cfset request.TrPermitRequired = 1>
<cfelse>
<cfset request.TrPermitRequired = 0>
</cfif>

<cfif isdate(#checkRequiredPermitsSubmitted.TrPermitSubmitted_dt#)>
<cfset request.TrPermitSubmitted = 1>
<cfset request.TrPermitSubmitted_dt = #checkRequiredPermitsSubmitted.TrPermitSubmitted_dt#>
<cfelse>
<cfset request.TrPermitSubmitted = 0>
<cfset request.TrPermitSubmitted_dt = "">
</cfif>
<!--- Check Tree Removal Permit --->


<!--- Check Tree Pruning Permit --->
<cfif #checkRequiredPermitsSubmitted.nbr_trees_pruned# gt 0>
<cfset request.TpPermitRequired = 1>
<cfelse>
<cfset request.TpPermitRequired = 0>
</cfif>

<cfif isdate(#checkRequiredPermitsSubmitted.TpPermitSubmitted_dt#)>
<cfset request.TpPermitSubmitted = 1>
<cfset request.TpPermitSubmitted_dt = #checkRequiredPermitsSubmitted.TpPermitSubmitted_dt#>
<cfelse>
<cfset request.TpPermitSubmitted = 0>
<cfset request.TpPermitSubmitted_dt = "">
</cfif>
<!--- Check Tree Pruning Permit --->

<!--- set defaults --->
<cfset request.requiredPermitsSubmitted = 0>
<cfset request.requiredPermitsSubmitted_dt = "">


<cfif #request.ApermitSubmitted# is 0>
<!--- <cfset request.requiredPermitsSubmitted = 0>
<cfset request.requiredPermitsSubmitted_dt = ""> --->


<!-- in all the following code, assume that request.ApermitSubmitted = 1 -->

<cfelseif #request.TrPermitRequired# is 0 and #request.TpPermitRequired# is 0>
<cfset request.requiredPermitsSubmitted = 1>
<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>

<cfelseif #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 0>
<!--- <cfset request.requiredPermitsSubmitted = "0"> --->

<cfelseif #request.TpPermitRequired# is 1  and  #request.TpPermitSubmitted# is 0>
<!--- <cfset request.requiredPermitsSubmitted = "0"> --->

<cfelseif #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1 and #request.TpPermitRequired# is 0>
<cfset request.requiredPermitsSubmitted = "1">
<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>
<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TrPermitSubmitted_dt#) is -1>
<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.TrPermitSubmitted_dt#>
</cfif>

<cfelseif #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1 and #request.TpPermitRequired# is 1 and #request.TpPermitSubmitted# is 0>
<!--- <cfset request.requiredPermitsSubmitted = "0"> --->

<cfelseif #request.TrPermitRequired# is 1  and  #request.TrPermitSubmitted# is 1 and #request.TpPermitRequired# is 1 and #request.TpPermitSubmitted# is 1>
<cfset request.requiredPermitsSubmitted = "1">

<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.ApermitSubmitted_dt#>

<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TrPermitSubmitted_dt#) is -1>
<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.TrPermitSubmitted_dt#>
</cfif>

<cfif dateCompare(#request.requiredPermitsSubmitted_dt#, #request.TpPermitSubmitted_dt#) is -1>
<cfset request.requiredPermitsSubmitted_dt = #checkRequiredPermitsSubmitted.TpPermitSubmitted_dt#>
</cfif>

</cfif>



<cfif #request.requiredPermitsSubmitted# is "1" and #checkRequiredPermitsSubmitted.srr_status_cd# is not "requiredPermitsSubmitted"><!--- 1 --->
<cfquery name="updateSrr" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = 'requiredPermitsSubmitted'
, requiredPermitsSubmitted_dt = #CreateODBCDate(request.requiredPermitsSubmitted_dt)#
, record_history = record_history + '|All required permits were submitted as of #dateformat(request.requiredPermitsSubmitted_dt,"mm/dd/yyyy")#.'
where srr_id = #checkRequiredPermitsSubmitted.srr_id#
</cfquery>
<cfset request.srNum = #checkRequiredPermitsSubmitted.sr_number#>
<cfset request.srCode = "23"> <!--- If the value is numeric then it will update the Reason Code. Otherwise is will update the Resolution Code --->
<cfset request.srComment = "Thank you for your participation in the City of Los Angeles Sidewalk Rebate Program. Our records indicate that you have submitted all required permits as of #dateformat(request.requiredPermitsSubmitted_dt,'mm/dd/yyyy')#. 
Once all permits are issued, you are required to follow the instructions on every permit and complete the construction within 90 days.<br><br>
Please continue to monitor you application using the following link.  
<br><br>
#request.serverRoot#/srr/public/app_requirements.cfm?srrKey=#request.srrKey#">


<cftry>

<cfif #request.production# is "p"><!--- 000 --->
	<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
</cfif><!--- 000 --->
<cfcatch type="Any">
<!--- <div class="warning">
Error Updating Ticket in MyLA311<br><br>
Success: #request.srupdate_success#<br>
Error Message: #request.srupdate_err_message#<br>
</div>
<cfabort> --->

</cfcatch>
</cftry>

</cfif><!--- 1 --->

<!--- Offer Accepted , applicant has to submit all required permits within 60 days or offer will be expired --->