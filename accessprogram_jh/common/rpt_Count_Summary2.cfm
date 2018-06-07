<cfparam name="start_row" default="1">
<!--- <cfoutput>
#request.ddate1# and #request.ddate2#
and
CD = #request.cd#
</cfoutput>
 <cfabort>
 --->
<style>
/* Preloader Start */
#preloader  {
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background-color: #fefefe;
     z-index: 99;
    height: 100%;
 }

#status  {
     width: 290px;
     height: 176px;
     position: absolute;
     left: 50%;
     top: 50%;
     background-image: url(../dashboard/images/boe_wait.gif);
     background-repeat: no-repeat;
     background-position: center;
     margin: -100px 0 0 -100px;
 }
/* Preloader End */
</style>

<script type="text/javascript">
jQuery(window).load(function() {
	jQuery("#status").fadeOut();
	jQuery("#preloader").delay(500).fadeOut("fast");
});
</script>
<!--- 
<cfquery name="unprocessed_investigations1" datasource="#request.dsn#" dbtype="datasource">
SELECT
  ar_info.ar_id
, ar_info.arKey
, ar_info.sr_number
, ar_info.ddate_submitted

, ar_info.app_name_nn
, ar_info.app_address1_nn
, ar_info.app_address2_nn
, ar_info.app_city_nn
, ar_info.app_state_nn
, ar_info.app_zip_nn
, ar_info.app_phone_nn
, ar_info.app_email_nn
, ar_info.job_address
, ar_info.council_dist
, ar_info.bss_assessed_dt

, ar_info.mailing_address1
, ar_info.mailing_address2
, ar_info.mailing_zip
, ar_info.mailing_city
, ar_info.mailing_state
 , ar_info.bpp
 , ar_info.pin
 , ar_info.pind
 , ar_info.zoningCode
 , ar_info.sr_email
 , ar_info.BSS_TO_SRP_DT
 ,ar_info.BSS_TO_SRP_by
 , dod_internal_comments
 , ufd_internal_comments
 , spd_internal_comments
  , bss_internal_comments
 , ar_status.ar_status_desc
 
, ar_info.SR_ACCESS_COMMENTS
 , dbo.ar_info.dod_denied_by
 , dbo.ar_info.dod_approved_dt
 , dbo.ar_info.dod_denied_dt
 , dbo.ar_info.dod_to_bss_dt
 
 , dateDiff("d", dbo.ar_info.ddate_submitted, getDate()) as daysInQueue
 
FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
</cfquery>
 --->

<cfquery name="CountRequest" datasource="#request.dsn#" dbtype="datasource">
select count(ar_id)as CntRequest
FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
where <!--- ar_info.ar_status_cd = 'received' 
	and	--->
	ddate_submitted between #CreateODBCDate(request.ddate1)# and  #CreateODBCDate(request.ddate2)#
	<cfif request.CD is 'All'>
	<!--- Do Nothing--->
	<cfelse>
	  and council_dist=#request.CD#
	</cfif>


</cfquery>


<cfquery name="CountDOD" datasource="#request.dsn#" dbtype="datasource">
select count(ar_id)as CntDOD
FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
where isdate(ar_info.dod_to_bss_dt)=1
	and	ddate_submitted between #CreateODBCDate(request.ddate1)# and  #CreateODBCDate(request.ddate2)#
	<cfif request.CD is 'All'>
	
	<cfelse>
	  and council_dist=#request.CD#
	</cfif>


</cfquery>

<cfquery name="CountBSS" datasource="#request.dsn#" dbtype="datasource">
select count(ar_id)as CntBSS
FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
where isdate(BSS_Assessed_dt)=1
	and	ddate_submitted between #CreateODBCDate(request.ddate1)# and  #CreateODBCDate(request.ddate2)#
	<cfif request.CD is 'All'>
	
	<cfelse>
	  and council_dist=#request.CD#
	</cfif>


</cfquery>


<!--- <cfoutput>
<cfif not isdefined("request.ddate1") or not isdate(#request.ddate1#)>
<span class="warning">Start Date is Required!</span>
<cfabort>
</cfif>

<cfif not isdefined("request.ddate2") or not isdate(#request.ddate2#)>
<span class="warning">End Date is Required!</span>
<cfabort>
</cfif>
</cfoutput>  --->






<!-- No record are found -->
<!--- <cfif #unprocessed_investigations.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif> --->
<!-- End of no record are found -->

<!--- <cfoutput>
<div class="subtitle">#unprocessed_investigations.recordcount# Applications Completed by BSS<br>
Between #request.ddate1# and #request.ddate2#</div>
</cfoutput> --->

<cfoutput>

<div class="subtitle">Summary Report by Status<br>
	#request.ddate1# - #request.ddate2#</div>
<br>
<div align="center">
<table align="center" cellspacing="19" cellpadding="4">
<tr>
<td>Total Count of Received Access Requests</td>
<td>#CountRequest.CntRequest#</td>
</tr>
<tr>
<td>Total Count of Approved Appliations by DOD</td>
<td>#CountDOD.CntDOD#</td>
</tr>
<tr>
<td>Total Count of Applications Completed by BSS</td>
<td>#CountBSS.CntBSS#</td>
</tr>

</table>
</div>




</cfoutput>







<!--- 
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS ------------------------------- -->
<CFPARAM NAME="request.page_nbr" DEFAULT="1">

<cfset request.nbr_of_pages = #unprocessed_investigations.recordcount# / #request.max_rows#>
<cfset request.nbr_of_pages = #int(request.nbr_of_pages)# + 1>
<cfset start_row = ((#request.page_nbr# - 1) * #request.max_rows#) +1>
<cfset end_row = #start_row# + #request.max_rows# -1>

<cfif #end_row# gt #unprocessed_investigations.recordcount#>
<cfset end_row = #unprocessed_investigations.recordcount#>
</cfif>

<cfset request.next_page = #request.page_nbr# + 1>
<cfset request.prev_page = #request.page_nbr# - 1>

<cfoutput>
<cfif #request.nbr_of_pages# gt 1>
<div align="center">
<table width="700" border="0" cellspacing="3" cellpadding="3" align="center">
<tr>
<td style="text-align:center;">
<cfif #request.prev_page# gt 0>
<a href="#cgi.script_name#?action=unprocessed_investigations&page_nbr=#request.prev_page#&#request.addtoken#">&lt;&lt; Previous</A> &nbsp;&nbsp; 
</cfif>
Page:&nbsp;&nbsp;<CFLOOP INDEX="pp" FROM="1" TO="#request.nbr_of_pages#" STEP="1"><cfif #request.page_nbr# is not #pp#><a href="#cgi.script_name#?action=unprocessed_investigations&page_nbr=#pp#&#request.addtoken#"></cfif>#pp#<cfif #request.page_nbr# is not #pp#></A></cfif>&nbsp;&nbsp;&nbsp;</cfloop>
<cfif #request.next_page# lte #request.nbr_of_pages#>
&nbsp;&nbsp; <a href="#cgi.script_name#?action=unprocessed_investigations&page_nbr=#request.next_page#&#request.addtoken#">Next &gt;&gt;</A>
</cfif>
</td>
</tr>
</table>
</div>
</cfif>
</cfoutput>
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS  ------------------------------- -->

<cfoutput>

<!--- Record Counter --->
<cfif #unprocessed_investigations.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #unprocessed_investigations.recordcount# lt #end_row#>
<cfset end_row=#unprocessed_investigations.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;"><div style="width:100%;text-align:right;">Records #start_row# To #END_ROW# out of #unprocessed_investigations.recordcount# Records</div></div>
</cfoutput>
</cfif>
<cfset prev_start= #start_row# - #request.max_rows#>
<cfset next_start=#start_row# + #request.max_rows#>
<!--- Record Counter --->

<div align = "center">
<table class="datatable" id="table1" style="width:95%;">
<tr>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<th nowrap>Date to BOE</th>
<th nowrap>Applicant</th>
<th>Council<br>District</th>
<th>Access Barrier Location <br>& Description</th>
<th>Comments</th>
<th>Status</th>
<th>How Old (Days)<br>from Date Submitted</th>
</tr>
</cfoutput>

<cfoutput query="unprocessed_investigations" startrow="#start_row#" maxrows="#request.max_rows#">


<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<a href="control.cfm?action=process_app1&arKey=#unprocessed_investigations.arKey#&#request.addtoken#">#unprocessed_investigations.sr_number#</a>
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(unprocessed_investigations.ddate_submitted,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
<p>#dateformat(unprocessed_investigations.bss_to_srp_dt,"mm/dd/yyyy")#</p>
<p>Referred by: BSS</p>

<cfif #unprocessed_investigations.bss_to_srp_by# is not "">
<cfquery name="getStaffName" datasource="#request.dsn#" dbtype="datasource">
select first_name, last_name from staff 
where user_id = #unprocessed_investigations.bss_to_srp_by#
</cfquery>
<p>#getStaffName.first_name# #getStaffName.last_name#</p>
</cfif>
</td>



<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_name_nn#
</td>


<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.Council_dist#
</td>



<td style="text-align:left;vertical-align:top;">
<strong>#unprocessed_investigations.job_address#</strong>
<br>
<strong>Description:</strong> <span class="data">#sr_access_comments#</span>
</td>




<td style="text-align:left;vertical-align:top;">
<cfif #dod_internal_comments# is not "">
<div align="left">
<span class="data"><strong>Dept. on Disability Comments</strong></span>
<cfloop index="xx" list="#unprocessed_investigations.dod_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #spd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Special Projects Comments</strong></span>
<cfloop index="xx" list="#unprocessed_investigations.spd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #ufd_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Urban Forestry Comments</strong></span>
<cfloop index="xx" list="#unprocessed_investigations.ufd_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>


<cfif #bss_internal_comments# is not "">
<div align="left">
<span class="data"><strong>BSS Comments</strong></span>
<cfloop index="xx" list="#unprocessed_investigations.bss_internal_comments#" delimiters="|">
<p><span class="data">#xx#</span></p>
</cfloop>
</div>
</cfif>
&nbsp;
</td>

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.ar_status_desc#
</td>


<td style="text-align:center;vertical-align:top;">
<strong>#daysInQueue#</strong>
</td>


</tr>
</cfoutput>
</table> 
 ---></div>

