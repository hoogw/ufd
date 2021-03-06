<cfinclude template="../common/validate_arKey.cfm">

<head>

<cfparam name="request.denial_reason_code" default="">

<!---<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>--->
<script src="/jquery/js/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
    $("select").change(function(){
        $(this).find("option:selected").each(function(){
            var optionValue = $(this).attr("value");
            if(optionValue){
                $(".panel").not("." + optionValue).hide();
                $("." + optionValue).show();
				$(".notDenial").hide();
				
            //alert($(this).val());
            } else{
                $(".panel").hide();
				$(".notDenial").show();
            }
        });
	
		
		
		
    }).change();
});


</script>

<!--- <script language="JavaScript" type="text/javascript">
function showDiv( ){ document.getElementById( 'optionalBox').style.display = 'block'; }
 function hideDiv( ){ document.getElementById( 'optionalBox').style.display = 'none'; } 
 
 </script> --->
<!--- <script>


document.getElementById('submit').disabled=true; 

return true;

}
</script> --->

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
	, dod_internal_comments
	, DOD_LOC_COMMENTS
	, residential_n
	, bus_stops
	, rejected_reason_id

				
				FROM  dbo.ar_info
where 
ar_info.arKey = '#request.arKey#'


 
</cfquery>

 

<!--- <cfif #request.status_cd# is not "pendingBssReview">
<cfoutput>
<div class="warning">
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif> --->

<div align="center">
<table width="1100px" border="0" align="center">
<tr>
<td style="width:400px;vertical-align:top;text-align:left;"> 
<!--- <cfoutput query="find_tree_info"> --->
<cfoutput query="findAR">
<form action="control.cfm?action=process_app2&#request.addtoken#" method="post" name="form1" id="form1"  onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

<div class="formbox" style="width:400px;">
<h1>Application Processing</h1>


<cfquery name="find_rejectedReason" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.Denial_Reason

</cfquery>



<div class="field">
<label for="denial_reason">Denied / Out of Scope / Exemption<br>
<label for="reason">Reason:</label>
<cfif #findAR.rejected_reason_id# is not "">
<select name="rejected_reason_code" id="rejected_reason_code">
<option value="#rejected_reason_id#">
#findAR.Rejected_reason_id#


</select>




<cfelse> 
<select name="rejected_reason_code" id="rejected_reason_code">
   <option value="" <cfif #findAR.rejected_reason_id# is "" >Selected</cfif>>Select a Reason</option>
<cfloop query="find_rejectedReason">

<option value="#rejected_reason_code#" <cfif #find_rejectedReason.rejected_reason_id# is  #findAR.rejected_reason_id#>selected </cfif>>
#find_rejectedreason.rejected_reason_desc#
</option>
</cfloop> 
</select>
</cfif>



</label>
<br>


<label for="language">Language :</label>
<div class="BCR panel" id="BCR">
<cfquery name="find_rejectedReason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'bcr'
</cfquery>
<label><p><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></p>
</label>



</div>

<div class="MRR panel" id="MRR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'MRR'
</cfquery>
<label><p><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></p>
</label>
</div>


<div class="TPO panel" id="TPO"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'tpo'
</cfquery>
<label><p><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></p>
</label>
</div>


<div class="NPR panel" id="NPR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
 select
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'NPR'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>



<div class="PR panel" id="PR"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'PR'
</cfquery>
<label><P><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>




<div class="NEPF panel" id="NEPF"> 
 <cfquery name="find_rejectedReason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
where rejected_reason_code = 'NEPF'
</cfquery>
<label><p><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></P>
</label>
</div>


<div class="ULPF panel" id="ULPF"> 
 <cfquery name="find_rejectedreason_lang" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rejected_reason_id
, rejected_reason_code
, rejected_reason_desc
, rejected_reason_lang
FROM            dbo.denial_Reason
 where rejected_reason_code = 'ULPF'
</cfquery>


<label><p><strong>#find_rejectedreason_lang.rejected_reason_lang#</strong></p>
</label>
</div>


</div>

<cfif #findAR.disability_Valid# is not "Y" and #findAR.disability_Valid# is not "N">
<div class="notDenial">
<div class="field">
<label for="disability_valid">Person is a member of mobility/disability class?</label>

<p><input type="radio" name="disability_valid" id="disability_valid" value="Y" <cfif #findAR.disability_valid# is "Y">checked</cfif>> Yes</p>

<p><input type="radio" name="disability_valid" id="disability_valid"  value="N" <CFIF #findAr.disability_valid# is "N">checked</cfif>> No</p>

<p><input type="radio" name="disability_valid" id="disability_valid"  value="" <cfif #findAR.disability_valid# is "">checked</cfif>> Keep for Further Investigation</p> 
</div>

<div class="field">
<p><strong>Yes</strong> will send application to BSS for assessment.</p>
<p><strong>No</strong> will close request and send an email to applicant notifying him/her of inelgibility for Access Program.</p>
</div>

<div class="field">
<label for="residential_n">Residential neighborhood?</label>

<p><input type="radio" name="residential_n" id="residential_n" value="Y" <cfif #findAR.residential_n# is "Y">checked</cfif> required> Yes</p>

<p><input type="radio" name="residential_n" id="residential_n"  value="N" <CFIF #findAr.residential_n# is "N">checked</cfif> required> No</p>

</div>


<div class="field">
<label for="bus_stops">Access to bus stops or other forms of public transit?</label>

<p><input type="radio" name="bus_stops" id="bus_stops" value="Y" <cfif #findAR.bus_stops# is "Y">checked</cfif> required> Yes</p>

<p><input type="radio" name="bus_stops" id="bus_stops"  value="N" <CFIF #findAr.bus_stops# is "N">checked</cfif> required> No</p>

</div>
</div>

<cfelse>

<div class="notDenial">
<div class="field">
<label for="disability_valid">Person is a member of mobility/disability class?<br>
<cfif #findAR.disability_valid# is "Y"><span class="data"><strong>Yes</strong></span></cfif>
<cfif #findAR.disability_valid# is "N"><span class="data"><strong>No</strong></span></cfif>
</label>

<cfif #findAR.disability_valid# is "Y">
<input type="hidden" name="disability_valid" id="disability_valid" value="yy">
</cfif>
<cfif #findAR.disability_valid# is "N">
<input type="hidden" name="disability_valid" id="disability_valid" value="nn">
</cfif>
</div>

<div class="field">
<label for="residential_n">Residential neighborhood?<br>
<cfif #findAR.residential_n# is "Y"><span class="data"><strong>Yes</strong></span></cfif>
<cfif #findAR.residential_n# is "N"><span class="data"><strong>No</strong></span></cfif>
</label>

<cfif #findAR.residential_n# is "Y">
<input type="hidden" name="residential_n" id="residential_n" value="yy">
</cfif>
<cfif #findAR.residential_n# is "N">
<input type="hidden" name="residential_n" id="residential_n" value="nn">
</cfif>

</div>


<div class="field">
<label for="bus_stops">Access to bus stops or other forms of public transit?<br>
<cfif #findAR.bus_stops# is "Y"><span class="data"><strong>Yes</strong></span></cfif>
<cfif #findAR.bus_stops# is "N"><span class="data"><strong>No</strong></span></cfif>
</label>

<cfif #findAR.bus_stops# is "Y">
<input type="hidden" name="bus_stops" id="bus_stops" value="yy">
</cfif>
<cfif #findAR.bus_stops# is "N">
<input type="hidden" name="bus_stops" id="bus_stops" value="nn">
</cfif>

</div>
</div>
</cfif>





<!--- Prepare adderss for geocoder --->
<cfif isnumeric(right(#findAR.job_address#, 5))>
<cfset request.address= left(#findAR.job_address#, len(#findAR.job_address#) - 8)>
<cfelse>
<cfset request.address = #findAR.job_address#>
</cfif>

<div class="field">
<label for="geocoder"><a href="http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRPDOD&ref_no=#URLEncodedFormat(request.sr_number)#&search=#URLEncodedFormat(request.address)#&allow_edit=1" target="_blank">Identify Location</a> (map)</label>
<label for="barrier">Location/Barrier Description:</label>
<p>
<textarea style="width:95%;height:75px;" name="dod_loc_comments" id="dod_loc_comments"><!--- #findAR.dod_loc_comments# ---></textarea>
</p>
</div>



<div class="field">
<label for="geocoder">DOD Internal Comments:</label>

<p><textarea style="width:95%;height:75px;" name="dod_internal_comments" id="dod_internal_comments"></textarea></p>
<p>(Internal Comments are shared among City staff)</p>

</div>




<!--- <div align="right" style="width:98%; margin-bottom:5px;">
<input type="button" name="add" id="add" value="Add Comment" class="submit" onClick="location.href = 'control.cfm?action=add_comment_form&arKey=#request.ARKey#&#request.addtoken#'"> --->
<!--- <form action="control.cfm?action=dod_comments&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">
<input type="submit" name="add_comment" id="add_comment" value="Add Comment" > --->
<!--- onclick="../modules/dsp_all_comments_module.cfm" arKey="#request.arKey#">
</div> --->




<!--- <h1>Comments Log</h1>


<table style="width:95%;" class="datatable">
<tr>
	<th>No.</th>
	<th>Comment</th>
	<th>By/Date</th>
</tr>

<cfquery name="list_comments" datasource="#request.dsn#" dbtype="datasource">
SELECT dbo.dod_comments.comment_id, dbo.dod_comments.comment_txt, dbo.dod_comments.comment_by, dbo.dod_comments.comment_ddate, 
               dbo.dod_comments.ar_id, dbo.staff.first_name, dbo.staff.last_name
FROM  dbo.dod_comments LEFT OUTER JOIN
               dbo.staff ON dbo.dod_comments.comment_by = dbo.staff.user_id
			   
where 
ar_id = #request.ar_id#
</cfquery>

<cfset xx = 1>
<cfloop query="list_comments">
<tr>
	<td style="text-align:center;">#xx#</td>
	<td style="text-align:left;">#comment_txt#</td>
	<td style="text-align:center;">#first_name# #last_name#<br>#dateformat(comment_ddate,"mm/dd/yyyy")# #timeformat(comment_ddate,"h:mm tt")#</td>
</tr>
<cfset xx = #xx# +1>
</cfloop>

</table>



</div> --->

</div> 
<!--- <cfif #findAr.rejected_reason_id# is "">
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
<cfelse>
<div class="warning" style="width:90%;">This request is already proecessed</div>
</cfif>


<cfelseif  #findAR.disability_Valid# is not "Y" and #findAR.disability_Valid# is not "N" > --->

<!--- <cfif #findAR.rejected_reason_id# is not "">

<div class="warning" style="width:90%;">This request is already proecessed</div>
<cfelse>
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>

</cfif> --->
 <cfif #findAR.disability_Valid# is not "Y" and #findAR.disability_Valid# is not "N">
 <cfif #findAR.rejected_reason_id# is  "">
 
<div align="center"><input type="submit" name="submit" id="submit" value="Save"></div>
<cfelse>
<div class="warning" style="width:90%;">This request is already proecessed</div>
</cfif></cfif>
<!--- </cfif> --->

</form>


</cfoutput>

</td>
	
<td style="width:10px;vertical-align:top;"> 
&nbsp;
</td>
	
<td style="width:350px;vertical-align:top;"> 
<cfmodule template="../modules/dsp_srTicketInfo_module.cfm" arKey = "#request.arKey#" width="350px">
<!--- <cfmodule template="../modules/addressReportModule.cfm" arKey="#request.arKey#"> --->
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