<cfinclude template="../common/validate_srrKey.cfm">

<cfquery name="findSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn

, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address

, dbo.srr_info.srr_status_cd
, dbo.srr_status.srr_status_desc
, dbo.srr_status.agency
, dbo.srr_status.srr_list_order
, dbo.srr_status.suspend
, dbo.srr_info.bpw1_ownership_verified
, srr_info.bpw1_ownership_comments
, dbo.srr_info.bpw1_tax_verified
, srr_info.bpw1_tax_comments
, srr_info.bpw1_internal_comments
, srr_info.bpw1_comments_to_app
, srr_info.hse_nbr
, srr_info.hse_frac_nbr
, srr_info.hse_dir_cd
, srr_info.str_nm
, srr_info.str_sfx_cd
, srr_info.str_sfx_dir_cd
, srr_info.zip_cd
, boe_invest_comments
, srr_info.bpw1_internal_comments
, srr_info.bca_comments
, srr_info.bss_comments

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd
			   

where 
srr_info.srrKey = '#request.srrKey#'

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>


<cfquery name="find_tree_info1" datasource="#request.dsn#" dbtype="datasource">
SELECT 
      srr_id
      , isnull(nbr_trees_pruned, 0) nbr_trees_pruned
      , ISNULL(lf_trees_pruned , 0) lf_trees_pruned
      , ISNULL(nbr_trees_removed , 0) nbr_trees_removed
      , ISNULL(nbr_trees_onsite , 0) nbr_trees_onsite
      , ISNULL(nbr_trees_offsite , 0) nbr_trees_offsite
	  , meandering_viable
  FROM srr.dbo.tree_info

where srr_id = #findSRR.srr_id#
</cfquery>

<cfif #find_tree_info1.recordcount# is 0>
<cfquery name="add_tree_info" datasource="#request.dsn#" dbtype="datasource">
insert into tree_info
(srr_id)
values
(#findSRR.srr_id#)
</cfquery>
</cfif>

<cfquery name="find_tree_info" datasource="#request.dsn#" dbtype="datasource">
SELECT 
tree_info.srr_id
, ISNULL(tree_info.nbr_trees_pruned , 0)  nbr_trees_pruned
, ISNULL(tree_info.lf_trees_pruned , 0) lf_trees_pruned
, ISNULL(tree_info.nbr_trees_removed , 0)  nbr_trees_removed
, ISNULL(tree_info.nbr_stumps_removed , 0)  nbr_stumps_removed
, ISNULL(tree_info.nbr_trees_onsite , 0) nbr_trees_onsite
, ISNULL(tree_info.nbr_trees_offsite , 0) nbr_trees_offsite
, tree_info.meandering_viable
, ISNULL(tree_info.meandering_tree_nbr , 0) meandering_tree_nbr
, srr_info.srrKey
, srr_info.sr_number
, srr_info.bss_comments
, srr_info.close_bss_sr311
, srr_info.srr_status_cd
, srr_info.prop_type
, srr_info.tree_insp_sr_number

FROM  tree_info LEFT OUTER JOIN
               srr_info ON tree_info.srr_id = srr_info.srr_id

where tree_info.srr_id = #findSRR.srr_id#
</cfquery>


<cfif #request.status_cd# is not "pendingBssReview">
<cfoutput>
<div class="warning">
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif>

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td style="width:100px;vertical-align:top;text-align:left;"> 
<cfoutput query="find_tree_info">

<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>

<div class="field">
<label for="nbr_trees_pruned">Number of trees to be root pruned</label>
<input type="number" name="nbr_trees_pruned" id="nbr_trees_pruned" <cfif #find_tree_info.nbr_trees_pruned# gt 0>value="#find_tree_info.nbr_trees_pruned#"</cfif>  size="12" placeholder="How Many?"><!--- Validate Integer --->
</div>

<div class="field">
<label for="lf_trees_pruned">Linear footage of root pruning (LF)</label>
<input type="number" name="lf_trees_pruned" id="lf_trees_pruned" size="12" <cfif #find_tree_info.lf_trees_pruned# gt 0>value="#numberFormat(find_tree_info.lf_trees_pruned)#"</cfif> placeholder="LF"><!-- This is a number (validate decimal) -->
</div>

<div class="field">
<label for="nbr_trees_removed">Number of trees to be removed</label>
<input type="number" name="nbr_trees_removed" id="nbr_trees_removed" <cfif #find_tree_info.nbr_trees_removed# gt 0>value="#find_tree_info.nbr_trees_removed#"</cfif> size="12" placeholder="How Many?"><!--- Validate Integer --->
</div>

<div class="field">
<label for="meandering_viable">Is meandering a viable option?</label>
<input type="radio" name="meandering_viable" id="meandering_viable" value="y" <cfif #find_tree_info.meandering_viable# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="meandering_viable" id="meandering_viable"  value="n" <cfif #find_tree_info.meandering_viable# is "n">checked</cfif>> No
<label for="meandering_tree_nbr">for how many trees?</label>
<input type="number" name="meandering_tree_nbr" id="meandering_tree_nbr" size="12" <cfif #find_tree_info.meandering_tree_nbr# gt 0>value="#find_tree_info.meandering_tree_nbr#"</cfif>  placeholder="How Many?">
</div>

<div class="field">
<label>Number of trees stumps to be removed</label>
<input type="number" name="nbr_stumps_removed" id="nbr_stumps_removed" size="12" <cfif #find_tree_info.nbr_stumps_removed# gt 0>value="#find_tree_info.nbr_stumps_removed#"</cfif>  placeholder="How Many?"><!--- validate integer --->
</div>


<div class="field">
<label>Number of trees to be planted onsite</label>
<input type="number" name="nbr_trees_onsite" id="nbr_trees_onsite" size="12" <cfif #find_tree_info.nbr_trees_onsite# gt 0>value="#find_tree_info.nbr_trees_onsite#"</cfif>  placeholder="How Many?"><!--- validate integer --->
</div>

<div class="field">
<label for="nbr_trees_offsite">Number of trees to be planted offsite</label>
<input type="number" name="nbr_trees_offsite" id="nbr_trees_offsite" size="12"  <cfif #find_tree_info.nbr_trees_offsite# gt 0>value="#find_tree_info.nbr_trees_offsite#"</cfif> placeholder="How Many?">
<!--- To be calculated  --->
<!--- validate integer --->
</div>

<div class="field">
<label for="bss_comments">Comments</label>
<textarea name="bss_comments" id="bss_comments" style="width:90%;height:80px;margin-top:5px;" placeholder="Type your comments here ...">#find_tree_info.bss_comments#</textarea>
</div>

<div class="field">
<label for="srr_status_cd">Request Status:</label>
<cfif #find_tree_info.srr_status_cd# is "PendingBssReview" or #find_tree_info.srr_status_cd# is "offerMade" or #find_tree_info.srr_status_cd# is "pendingBOEReview">
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="offerMade" <cfif #find_tree_info.srr_status_cd# is "offerMade">checked</cfif>> Assessment/Estimate Completed</label>
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBOEReview" <cfif #find_tree_info.srr_status_cd# is "pendingBOEReview">checked</cfif>> Engineering Evaluation Required</label>
<br>
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="PendingBssReview" <cfif #find_tree_info.srr_status_cd# is "PendingBssReview">checked</cfif>> Keep for Further Investigation</label>
<cfelse>
<strong>#request.status_desc#</strong>
</cfif>
</div>

<div class="field">
<label for="close_bss_sr311">Close MyLA311 Service Request</label>
<input type="radio" name="close_bss_sr311" id="close_bss_sr311" value="y" <cfif #find_tree_info.close_bss_sr311# is "y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="close_bss_sr311" id="close_bss_sr311"  value="n" <cfif #find_tree_info.close_bss_sr311# is "n">checked</cfif>> No

<div style="text-align:left; padding-top:7px;padding-left:7px;">311 Ticket Number: #tree_insp_sr_number#</div>
</div>

</div>

<cfif #request.status_cd# is "pendingBssReview">
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
</cfif>

</form>
<!--- <div align="center">(A-Permit Ref. No. #request.a_ref_no#) (Remove Later)</div> --->
</cfoutput>

</td>
	
<td style="width:10px;vertical-align:top;"> 
&nbsp;
</td>
	
<td style="width:350px;vertical-align:top;"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" srrKey = "#request.srrKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  hse_nbr="#findSRR.hse_nbr#" hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#">
</td>


<td style="width:10px;vertical-align:top;">
&nbsp;
</td>

<td style="width:300px;vertical-align:top;">
<cfmodule template="../modules/dsp_all_comments_module.cfm" srrKey="#request.srrKey#">
</td>
</tr>
</table>
</div>

