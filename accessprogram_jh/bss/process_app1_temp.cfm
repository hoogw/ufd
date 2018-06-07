<cfinclude template="../common/validate_arKey.cfm">

<cfquery name="findAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 

[ar_id] 				
	,[arKey] 
	,[sr_number] 
	,[ar_status_cd] 
	,[record_history] 
	,[app_name_nn] 
	,[app_email_nn] 
	,[app_address1_nn] 
	,[app_address2_nn] 
	,[app_city_nn] 
	,[app_state_nn]
	,[app_zip_nn] 
	,[app_phone_nn] 
	,[mailing_address1] 
	,[mailing_address2]
	,[mailing_zip]
	,[mailing_city]
	,[mailing_state] 
	,[hse_nbr] 
	,[hse_frac_nbr] 
	,[hse_dir_cd] 
	,[str_nm] 
	,[str_sfx_cd] 
	,[str_sfx_dir_cd] 
	,[zip_cd] 
	,[unit_range] 
	,[hse_id]
	,[tbm_grid]
	,[boe_dist] 
	,[council_dist] 
	,[bpp] 
	,[pin] 
	,[pind] 
	,[zoningCode] 
	,[job_address] 
	,[x_coord] 
	,[y_coord]
	,[longitude] 
	,[latitude] 
	,[sr_app_comments]
	,[sr_location_comments] 
	,[sr_access_comments] 
	,[sr_attachments] 
	,[sr_mobility_disability]
	,[sr_access_barrier_type] 
	,[sr_communication_method] 
	,[sr_email] 
	,[sr_tty_number] 
	,[sr_phone] 
	,[sr_video_phone] 
	,[ddate_submitted] 	
	,[DISABILITY_VALID]			
				
				
				FROM  dbo.ar_info
where 
ar_info.arKey = '#request.arKey#'

<!--- and ar_status.agency = 'bpw1' --->
</cfquery>


 
 <cfquery name="find_Ramp_Dimen1" datasource="#request.dsn#" dbtype="datasource">
SELECT 
       ar_id
      , site_address
      , nbr_access_ramp
      , nbr_truncated_domes
      , depressed_curb_lf
      , sidewalk_sqft
	  , curb_lf
	  , Gutter_lf
	  , Driveway_Sqft
	  , Spandrels_Sqft
	  , Alley_Approaches_SqFt
	  , Cross_gutter_Sqft
	  , Additional_RampOver_135SqFT

  FROM [accessprogram].[dbo].[ramp_dimension]

where ar_id = #findAr.Ar_id#
</cfquery>

<cfif #find_Ramp_Dimen1.recordcount# is 0>
<cfquery name="add_Ramp_Dimen" datasource="#request.dsn#" dbtype="datasource">
insert into Ramp_dimension
(ar_id)
values
(#findAR.Ar_id#)
</cfquery>
</cfif>
 
 
 <cfquery name="find_Ramp_Dimen" datasource="#request.dsn#" dbtype="datasource">
SELECT 


   ramp_dimension.ar_id
      , ramp_dimension.site_address
      , ramp_dimension.nbr_access_ramp
      , ramp_dimension.nbr_truncated_domes
      , ramp_dimension.depressed_curb_lf
      , ramp_dimension.sidewalk_sqft
	  , ramp_dimension.curb_lf
	  , ramp_dimension.Gutter_lf
	  , ramp_dimension.Driveway_Sqft
	  , ramp_dimension.Spandrels_Sqft
	  , ramp_dimension.Alley_Approaches_SqFt
	  , ramp_dimension.Cross_gutter_Sqft
	  , ramp_dimension.Additional_RampOver_135SqFT

, ar_info.arkey
, ar_info.sr_number


FROM  ramp_dimension LEFT OUTER JOIN
               ar_info ON ramp_dimension.ar_id = ar_info.ar_id

where ramp_dimension.ar_id = #findAR.ar_id#
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

<cfoutput query="find_Ramp_Dimen"> 
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>

<cfif isnumeric(right(#findAR.job_address#, 5))>
<cfset request.address= left(#findAR.job_address#, len(#findAR.job_address#) - 8)>
<cfelse>
<cfset request.address = #findAR.job_address#>
</cfif>

 <div class="field">
<label for="site_address">Site Name (Address)</label>
<input type="text" name="site_address" id="site_address" size="30"  <cfif #find_ramp_dimen.site_address# neq "" >value="#find_ramp_dimen.site_address#"</cfif>><!--- validate integer --->
<label for="disability_valid"><a href="http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRPDOD&ref_no=#URLEncodedFormat(request.sr_number)#&search=#URLEncodedFormat(request.address)#&allow_edit=1" target="_blank">View Location</a></label>
</div>



<div class="field">
<label for="nbr_access_ramp">Number of Access Ramps</label>
<input type="number" name="nbr_access_ramp" id="nbr_access_ramp" size="12" <cfif #find_ramp_dimen.nbr_access_ramp# gt 0> value="#find_ramp_dimen.nbr_access_ramp#"</cfif>  placeholder="How Many?"><!--- validate integer --->
</div>

<div class="field">
<label for="nbr_Truncated_domes">Number Truncated Domes</label>
<input type="number" name="nbr_Truncated_domes" id="nbr_Truncated_domes" size="12" <cfif #find_ramp_dimen.nbr_truncated_domes# gt 0>value="#find_ramp_dimen.nbr_truncated_domes#"</cfif>  placeholder="How Many?"><!--- validate integer --->
</div>

<div class="field">
<label for="Depressed_Curb_LF" >Depressed Curb (LF)</label>
<input type="number" name="Depressed_Curb_LF" id="Depressed_curb_lf" size="12" <cfif #find_ramp_dimen.Depressed_curb_lf# gt 0>value="#find_ramp_dimen.Depressed_curb_lf#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label for="Sidewalk_SqFt" >Sidewalk (SqFt)</label>
<input type="number" name="Sidewalk_SqFt" id="Sidewalk_SqFT" size="12" <cfif #find_ramp_dimen.Sidewalk_SqFt# gt 0>value="#find_ramp_dimen.Sidewalk_SQft#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label for="Curb_lf" >Curb (LF)</label>
<input type="number" name="Curb_lf" id="Curb_lf" size="12" <cfif #find_ramp_dimen.Curb_lf# gt 0>value="#find_ramp_dimen.Curb_lf#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label for="Gutter_Lf" >Gutter (LF/SqFt?)</label>
<input type="number" name="Gutter_Lf" id="Gutter_Lf" size="12" <cfif #find_ramp_dimen.Gutter_Lf# gt 0>value="#find_ramp_dimen.Gutter_lf#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label for="Driveway_Sqft" >Driveway (SqFt)</label>
<input type="number" name="Driveway_Sqft" id="Driveway_SqFt" size="12" <cfif #find_ramp_dimen.Curb_lf# gt 0>value="#find_ramp_dimen.Driveway_SqFt#"</cfif>  placeholder=""><!--- validate integer --->
</div>


<div class="field">
<label for="Spandrels_SqFt">Spandrels (SqFt)</label>
<input type="number" name="Spandrels_SqFt" id="Spandrels_Sqft" size="12" <cfif #find_ramp_dimen.Spandrels_Sqft# gt 0>value="#find_ramp_dimen.Spandrels_SqFt#"</cfif>  placeholder=""><!--- validate integer --->
</div>


<div class="field">
<label for="alley_approaches_Sqft" >Alley Approaches (SqFt)</label>
<input type="number" name="alley_approaches_Sqft" id="alley_approaches_SqFt" size="12" <cfif #find_ramp_dimen.alley_approaches_Sqft# gt 0>value="#find_ramp_dimen.Alley_approaches_sqft#"</cfif>  placeholder=""><!--- validate integer --->
</div>


<div class="field">
<label for="cross_gutter_Sqft" >Cross Gutter (SqFt)</label>
<input type="number" name="cross_gutter_Sqft" id="cross_gutter_sqft" size="12" <cfif #find_ramp_dimen.cross_gutter_sqft# gt 0>value="#find_ramP_dimen.Cross_gutter_sqft#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label for="additional_rampOver_135sqft">Additional Ramp Over 135 (SqFt)</label>
<input type="number" name="additional_rampOver_135sqft" id="additional_rampOver_135sqft" size="12" <cfif #find_ramp_dimen.Additional_RampOver_135Sqft# gt 0>value="#find_ramP_dimen.Additional_rampOver_135sqft#"</cfif>  placeholder=""><!--- validate integer --->
</div>

<div class="field">
<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="PendingBcaReview"> Assessment Completed</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBoeReview"> Engineering Evaluation Required</label>

<label><input type="radio" name="srr_status_cd" id="srr_status_cd" value="pendingBoeReview"> Keep for Further Investigation</label>
</div>

<div class="field">
<label for="bpw1_internal_comments">Internal Comments (Optional)</label>
<textarea name="bpw1_internal_comments" id="bpw1_internal_comments" style="width:350px;height:100px;margin-top:5px;" placeholder="500 characters."></textarea>
</div>

</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</form></cfoutput>






</td>
	
 <td style="width:10px;vertical-align:top;"> 
&nbsp;
</td>
	
<td style="width:350px;vertical-align:top;"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" arKey = "#request.arKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" arKey="#request.arKey#"  <!--- hse_nbr="#findSRR.hse_nbr#" hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#" --->>
</td>


<td style="width:10px;vertical-align:top;">
&nbsp;
</td>

<td style="width:300px;vertical-align:top;">
<cfmodule template="../modules/dsp_all_comments_module.cfm" arKey="#request.arKey#">
</td>
</tr>
</table>
</div>


















































<!--- 


<div class="field">
<label for="nbr_trees_pruned">Number of trees to be root pruned</label>
<input type="number" name="nbr_trees_pruned" id="nbr_trees_pruned" value="" size="12" placeholder="How Many?"><!--- Validate Integer --->
</div>

<div class="field">
<label for="lf_trees_pruned">Linear footage of root pruning (LF)</label>
<input type="number" name="lf_trees_pruned" id="lf_trees_pruned" size="12" value="" placeholder="LF"><!-- This is a number (validate decimal) -->
</div>

<div class="field">
<label for="nbr_trees_removed">Number of trees to be removed</label>
<input type="number" name="nbr_trees_removed" id="nbr_trees_removed" value="" size="12" placeholder="How Many?"><!--- Validate Integer --->
</div>

<div class="field">
<label for="meandering_viable">Is meandering a viable option?</label>
<input type="radio" name="meandering_viable" id="meandering_viable" value="y" checked> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="meandering_viable" id="meandering_viable"  value="n" checked> No
<label for="meandering_tree_nbr">for how many trees?</label>
<input type="number" name="meandering_tree_nbr" id="meandering_tree_nbr" size="12" value=""  placeholder="How Many?">
</div>

<div class="field">
<label>Number of trees stumps to be removed</label>
<input type="number" name="nbr_stumps_removed" id="nbr_stumps_removed" size="12" value=""  placeholder="How Many?"><!--- validate integer --->
</div>


<div class="field">
<label>Number of trees to be planted onsite</label>
<input type="number" name="nbr_trees_onsite" id="nbr_trees_onsite" size="12" value=""  placeholder="How Many?"><!--- validate integer --->
</div>

<div class="field">
<label for="nbr_trees_offsite">Number of trees to be planted offsite</label>
<input type="number" name="nbr_trees_offsite" id="nbr_trees_offsite" size="12"  value="" placeholder="How Many?">
<!--- To be calculated  --->
<!--- validate integer --->
</div>

<div class="field">
<label for="bss_comments">Comments</label>
<textarea name="bss_comments" id="bss_comments" style="width:90%;height:80px;margin-top:5px;" placeholder="Type your comments here ...">&nbsp;</textarea>
</div>

<div class="field">
<label for="ar_status_cd">Request Status:</label>

<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="offerMade" checked> Assessment/Estimate Completed</label>
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="pendingBOEReview" checked> Engineering Evaluation Required</label>
<br>
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="PendingBssReview" checked> Keep for Further Investigation</label>
<!--- <cfelse> --->
<!--- <strong>#request.status_desc#</strong> --->
<!--- </cfif> --->
</div>

<div class="field">
<label for="close_bss_sr311">Close MyLA311 Service Request</label>
<input type="radio" name="close_bss_sr311" id="close_bss_sr311" value="y" checked> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="close_bss_sr311" id="close_bss_sr311"  value="n" checked> No

<div style="text-align:left; padding-top:7px;padding-left:7px;">311 Ticket Number: #tree_insp_sr_number#</div>
</div> --->

<!--- </div> --->

<!--- <cfif #request.status_cd# is "pendingBssReview"> --->
<!--- <div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
<!--- </cfif> --->

</form> --->
<!--- <div align="center">(A-Permit Ref. No. #request.a_ref_no#) (Remove Later)</div> --->
<!--- </cfoutput> --->




































<!--- OLD --->

<!--- 




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
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

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
<label for="ar_status_cd">Request Status:</label>
<cfif #find_tree_info.ar_status_cd# is "PendingBssReview" or #find_tree_info.ar_status_cd# is "offerMade" or #find_tree_info.ar_status_cd# is "pendingBOEReview">
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="offerMade" <cfif #find_tree_info.ar_status_cd# is "offerMade">checked</cfif>> Assessment/Estimate Completed</label>
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="pendingBOEReview" <cfif #find_tree_info.ar_status_cd# is "pendingBOEReview">checked</cfif>> Engineering Evaluation Required</label>
<br>
<label><input type="radio" name="ar_status_cd" id="ar_status_cd" value="PendingBssReview" <cfif #find_tree_info.ar_status_cd# is "PendingBssReview">checked</cfif>> Keep for Further Investigation</label>
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
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" arKey = "#request.arKey#" width="350px">
<cfmodule template="../modules/addressReportModule.cfm" arKey="#request.arKey#"  hse_nbr="#findSRR.hse_nbr#" hse_frac_nbr="#findSRR.hse_frac_nbr#" hse_dir_cd="#findSRR.hse_dir_cd#" str_nm="#findSRR.str_nm#" str_sfx_cd="#findSRR.str_sfx_cd#" zip_cd="#findSRR.zip_cd#">
</td>


<td style="width:10px;vertical-align:top;">
&nbsp;
</td>

<td style="width:300px;vertical-align:top;">
<cfmodule template="../modules/dsp_all_comments_module.cfm" arKey="#request.arKey#">
</td>
</tr>
</table>
</div>

 --->