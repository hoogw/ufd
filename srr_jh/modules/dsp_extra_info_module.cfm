<cfinclude template="../common/validate_srrKey.cfm">
<cfparam name="attributes.width" default="350px">

<style>
.data {
color:maroon;
font-weight:normal;
}
</style>

<cfoutput>
<div class="formbox" style="width:#attributes.width#;margin-left:auto;margin-right:auto;">
<h1>Permit(s) Information:</h1>
<cfif #request.a_ref_no# is not ""><!--- 1 --->
<cfquery name="getA" datasource="apermits_sql" dbtype="datasource">
Select
ref_no
, ddate_submitted
, application_status
, boe_ddate_processed
from permit_info
where ref_no = #request.a_ref_no#
</cfquery>
<p><strong>A-Permit Information:</strong></p>
<p>Reference Number: #getA.ref_no# .</p>
<p>Date Submitted: #dateformat(getA.ddate_submitted,"mm/dd/yyyy")#</p>
<p>Date Issued: #dateformat(getA.boe_ddate_processed,"mm/dd/yyyy")#</p>
<p><a href="/apermits/common/final_permit.cfm?ref_no=#request.a_ref_no#" target="_blank">View Estimate/Permit</a></p>
<cfelse>
<p>A-Permit was not started.</p>
</cfif><!--- 1 --->


<cfif #request.a_ref_no# is not ""><!--- 1 --->
<cfquery name="checkSupp" datasource="apermits_sql" dbtype="datasource">
Select 
ref_no 
from permit_info
where orig_ref_no = #request.a_ref_no#
</cfquery>

<cfif #checkSupp.recordcount# gt 0>
<cfset theList = #ValueList(checkSupp.ref_no, ",")#>
<cfset theList = #theList#&","&#request.a_ref_no#>
<cfelse>
<cfset theList = #request.a_ref_no#>
</cfif>

<cfset theList =ReplaceNoCase("#theList#"," ","","ALL")>

<CFQUERY NAME="find_inspec_records" DATASOURCE="apermits_sql" dbtype="datasource">
SELECT  [record_id]
      ,[inspec_no]
      ,[ref_no]
      ,[inspection_ddate]
      ,[inspector_id]
      ,[inspection_type]
      ,[inspection_hours]
      ,[record_added_on]
      ,[record_entered_by]
      ,[comments]
  FROM [apermits].[dbo].[inspection_records]
  WHERE ref_no in (#theList#) <!--- and inspection_type = 'F' --->
  </cfquery>
  
 <cfif #find_inspec_records.recordcount# is not 0>
<!--- <br>
&nbsp;&nbsp; --->

<p><a href="https://engpermits.lacity.org/apermits/common/print_previous_inspec_records.cfm?ref_no=#request.a_ref_no#" target="_blank">A-Permit Inspection Records</a></p>
<cfelse>
<!---&nbsp;&nbsp;<span class="data">Pending A-Permit Final Inspection  (<a href="https://engpermits.lacity.org/apermits/common/print_previous_inspec_records.cfm?ref_no=#request.a_ref_no#" target="_blank">Inspection Records</a>) 
<hr>--->
</cfif>

<!--- </cfif>
<hr> --->


<CFQUERY NAME="find_inspec_finals" DATASOURCE="apermits_sql" dbtype="datasource">
SELECT  [record_id]
      ,[inspec_no]
      ,[ref_no]
      ,[inspection_ddate]
      ,[inspector_id]
      ,[inspection_type]
      ,[inspection_hours]
      ,[record_added_on]
      ,[record_entered_by]
      ,[comments]
  FROM [apermits].[dbo].[inspection_records]
  WHERE ref_no in (#theList#) and inspection_type = 'F'
  </cfquery>
<!--- <cfif #request.a_ref_no# is not ""> --->
<cfquery name="findPind" datasource="#request.dsn#" dbtype="datasource">
Select pind from srr_info
where srrKey = '#request.srrKey#'
</cfquery>
 <cfif #find_inspec_finals.recordcount# is not 0>
<cfif #findPind.pind# is not "">
<p><a href="https://engpermits.lacity.org/cocompliance/generateCertificate.cfm?pind=#findPind.pind#" target="_blank">Certificate of Compliance</a></p>
<hr>
<cfelse>
<!--- <br>
&nbsp;&nbsp;<span class="data">Check that address is valid.</span> --->
</cfif>
<cfelse>
<!--- <br>
&nbsp;&nbsp;<span class="data">Certficate of Compliance (Pending)</span> --->
</cfif>
<!--- </cfif> --->
<!--- update 04212017 --->

</cfif>
<hr>

<cfquery name="checkChildTicket" datasource="#request.dsn#" dbtype="datasource">
SELECT 
 tree_insp_sr_number

FROM  srr_info

where srrKey = '#request.srrKey#'
</cfquery>

Tree Inspection SR No. <cfif #checkChildTicket.tree_insp_sr_number# is not ""><strong>#checkChildTicket.tree_insp_sr_number#</strong><cfelse><strong>None</strong></cfif>

<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
recordID
      ,srr_id
      , ISNULL(nbr_trees_pruned, 0) AS nbr_trees_pruned
      , ISNULL(lf_trees_pruned, 0) AS lf_trees_pruned
      , ISNULL(nbr_trees_removed, 0) AS nbr_trees_removed
      ,meandering_viable
      , ISNULL(meandering_tree_nbr, 0) AS meandering_tree_nbr
      , ISNULL(nbr_trees_onsite, 0) AS nbr_trees_onsite
      , ISNULL(nbr_trees_offsite, 0) AS nbr_trees_offsite
      , ISNULL(nbr_stumps_removed, 0) AS nbr_stumps_removed
  
  FROM srr.dbo.tree_info
  where srr_id = #request.srr_id#
</cfquery>

					<CFIF getTrees.recordcount is 0>
					<p><strong>Tree Information:</strong></p>
					<p>No Tree Removal Permit is required.</p>
					<p>No Tree Root Pruning Permit is required.</p>
					</CFIF>

<cfif #getTrees.recordCount# is not 0><!--- 2 --->
<p><strong>Tree Information:</strong></p>
<p>Trees to be pruned: #getTrees.nbr_trees_pruned#</p>
<p>Trees to be removed: #getTrees.nbr_trees_removed#</p>

<cfif #getTrees.nbr_trees_pruned# gt 0><!--- 3 --->
<p>Tree Pruning Permit Required.</p>
<cfquery name="TpPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT [recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
  FROM [srr].[dbo].[Tree_pruning_permit]
  where srr_id = #request.srr_id#
</cfquery>
<cfif #TpPermit.recordcount# is not 0><!--- 4 --->
<p>Tree Pruning Permit Submitted on: #dateformat(TpPermit.ddate_submitted,"mm/dd/yyyy")#</p>
<p>Tree Pruning Permit Issued on: #dateformat(TpPermit.bss_ddate_issued,"mm/dd/yyyy")#</p>
</cfif><!--- 4 --->
</cfif><!--- 3 --->

<cfif #getTrees.nbr_trees_removed# gt 0><!--- 5 --->
<p>Tree Removal Permit Required.</p>
<cfquery name="TrPermit" datasource="#request.dsn#" dbtype="datasource">
SELECT [recordID]
      ,[srr_id]
      ,[ddate_submitted]
      ,[bss_issued_by]
      ,[bss_ddate_issued]
  FROM [srr].[dbo].[Tree_removal_permit]
  where srr_id = #request.srr_id#
</cfquery>
<cfif #TrPermit.recordcount# is not 0>
<p>Tree Removal Permit Submitted on: #dateformat(TrPermit.ddate_submitted,"mm/dd/yyyy")#</p>
<p>Tree Removal Permit Issued on: #dateformat(TrPermit.bss_ddate_issued,"mm/dd/yyyy")#</p>
</cfif>
</cfif><!--- 5 --->
</cfif><!--- 2 --->


<hr>
<p><a href="/srr/public/app_requirements.cfm?srrKey=#request.srrKey#" target="_blank">Applicant will see</a></p>
<p>This link displays what the applicant will see on his/her side</p>
<p>(Do not Click any Button)</p>
<hr>




</div>
</cfoutput>



 
 


