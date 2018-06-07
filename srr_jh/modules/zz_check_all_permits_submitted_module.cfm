<cfinclude template="../common/validate_srrKey.cfm">
<!-- This module will called for requests where the status is offerAccepted -->


<!--- The purpose of this module is to check that all required permits are submitted within 60 days after offer is accepted. --->


<!-- At the end of this module, the status should be  -->

<cfquery name="srrPermits" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.srrKey
, srr_info.sr_number
, srr_info.a_ref_no
, srr_info.offerAccepted_dt
, srr_info.offerAccepted_exp_dt
, srr_info.ApermitSubmitted_dt 
, tree_info.nbr_trees_pruned
, tree_info.lf_trees_pruned
, tree_info.nbr_trees_removed
, srr_info.srr_status_cd

FROM  srr_info LEFT OUTER JOIN
               tree_info ON srr_info.srr_id = tree_info.srr_id

from srr_info
where srrKey = '#request.srrKey#'
</cfquery>



<!--- check if A-permit is submitted --->
<cfif isdate(#srrPermits.ApermitSubmitted_dt#)>
<cfset request.ApermitSubmitted = 1>
<cfset request.ApermitSubmitted_dt = #srrPermits.ApermitSubmitted_dt#>
<cfelse>
<cfset request.ApermitSubmitted = 0>
<cfset request.ApermitSubmitted_dt = "">
</cfif>
<!--- check if A-permit is submitted --->


<!-- check Tree Removal Permit -->
<cfif isnumeric(#srrPermits.nbr_trees_removed#) and #srrPermits.nbr_trees_removed# gt 0>
<cfset request.TrPermitRequired = 1>

<cfquery name="TrPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
      ,[CEQA_checked]
  FROM [srr].[dbo].[Tree_removal_permit]
  WHERE srr_id = #request.srr_id#
</cfquery>

<cfif #TrPermit.recordcount# is 0>
<cfset request.TrPermitSubmitted = 0>
<cfset request.TrPermitSubmitted_dt = "">
<cfelse>
<cfset request.TrPermitSubmitted = 1>
<cfset request.TrPermitSubmitted_dt = #TrPermit.ddate_submitted#>
</cfif>

<cfelse>

<cfset request.TrPermitRequired = 0>
<cfset request.TrPermitSubmitted = 0>
<cfset request.TrPermitSubmitted_dt = "">
</cfif>
<!-- check Tree Removal Permit -->


<!-- check Tree Pruning Permit -->
<cfif isnumeric(#srrPermits.nbr_trees_pruned#) and #srrPermits.nbr_trees_pruned# gt 0>
<cfset request.TpPermitRequired = 1>

<cfquery name="TpPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT TOP 1000 [recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
  FROM [srr].[dbo].[Tree_pruning_permit]
  WHERE srr_id = #request.srr_id#
</cfquery>

<cfif #TpPermit.recordcount# is 0>
<cfset request.TpPermitSubmitted = 0>
<cfset request.TpPermitSubmitted_dt = "">
<cfelse>
<cfset request.TpPermitSubmitted = 1>
<cfset request.TpPermitSubmitted_dt = #TpPermit.ddate_submitted#>
</cfif>

<cfelse>

<cfset request.TpPermitRequired = 0>
<cfset request.TpPermitSubmitted = 0>
<cfset request.TpPermitSubmitted_dt = "">
</cfif>
<!-- check Tree Pruning Permit -->

<cfset request.newStatus = #srrPermits.srr_status_cd#>

<cfif #request.ApermitSubmitted# is 0 and (dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is -1 or dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is 0)>
<cfset request.newStatus = "requiredPermitsNotSubmitted">
</cfif>


<cfif #request.TrPermitRequired# is 1  and  #request.trPermitSubmitted# is 0 and (dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is -1 or dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is 0)>
<cfset request.newStatus = "requiredPermitsNotSubmitted">
</cfif>


<cfif #request.TpPermitRequired# is 1  and  #request.TpPermitSubmitted# is 0 and (dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is -1 or dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is 0)>
<cfset request.newStatus = "requiredPermitsNotSubmitted">
</cfif>






<!--- Apermit was not submitted within 60 days of accepting offer, set resolution code to EX, messge: Expired because permits not submitted wifhin 60 days of accepting offer --->









<cfif #request.ApermitSubmitted# is 1 and #request.TrPermitRequired# is 0 and #request.TpPermitRequired# is 0>
<cfset request.newStatus = "requiredPermitsSubmitted">

<cfelseif #request.ApermitSubmitted# is 1 and #request.TrPermitRequired# is 1 #request.trPermitSubmitted# is 1 and #request.TpPermitRequired# is 0>
<cfset request.newStatus = "requiredPermitsSubmitted">

</cfif>




















<!--  dateCompare is 0 or 1 means date1 is less than or equal to date2 -->
<!--- 1 ---><cfif #request.ApermitSubmitted# is 0 and (dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is -1 or dateCompare(#srrPermits.offerAccepted_exp_dt#, #now()#) is 0)>
<cfset request.srr_status_cd = "requiredPermitsNotSubmitted"><!--- Apermit was not submitted within 60 days of accepting offer, set resolution code to EX, messge: Expired because permits not submitted wifhin 60 days of accepting offer --->
<cfelseif  #request.ApermitSubmitted# is 1>
<cfset request.srr_status_cd = "ApermitSubmitted">

<cfif isnumeric(#srrPermits.nbr_trees_removed#) and #srrPermits.nbr_trees_removed# gt 0>
<cfset request.treeRemovalPermitRequired = 1>
<cfelse>
<cfset request.treeRemovalPermitRequired = 0>
</cfif>

<cfif isnumeric(#srrPermits.nbr_trees_pruned#) and #srrPermits.nbr_trees_pruned# gt 0>
<cfset request.PruningPermitRequired = 1>
<cfelse>
<cfset request.treePruningPermitRequired = 0>
</cfif>



<!--- 1 ---></cfif>






<!--- check if a Tree Removal/Pruning Pemit is required --->
<cfquery name="srrTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[recordID]
      ,[srr_id]
      ,[nbr_trees_pruned]
      ,[lf_trees_pruned]
      ,[nbr_trees_removed]
      ,[meandering_viable]
      ,[nbr_trees_onsite]
      ,[nbr_trees_offsite]
	  
  FROM [srr].[dbo].[tree_info]

where srr_id = #request.srr_id#
</cfquery>

<cfif #srrTrees.recordcount# gt 0 isnumeric(#srrTrees.nbr_trees_removed#)>
<cfset request.treeRemovalPermitRequired = 1>
<cfquery name="treeRemoval" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
      ,[CEQA_checked]
  FROM [srr].[dbo].[Tree_removal_permit]
  WHERE srr_id = #request.srr_id#
</cfquery>

<cfelse>
<cfset request.treeRemovalPermitRequired = 0>
</cfif>

<cfif isnumeric(#srrTrees.lf_trees_pruned#)>
<cfset request.treePruningPermitRequired = 1>
<cfquery name="treePruning" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
  FROM [srr].[dbo].[Tree_pruning_permit]
   WHERE srr_id = #request.srr_id#
</cfquery>
<cfelse>
<cfset request.treePruningPermitRequired = 0>
</cfif>



