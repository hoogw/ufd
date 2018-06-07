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

<cfquery name="unprocessed_investigations" datasource="#request.dsn#" dbtype="datasource">
SELECT
  ar_info.ar_id
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
 ,replace(replace(cast(dod_internal_comments as varchar(max)),char(13),' '),char(10),' ')as dod_comments 
 ,replace(replace(cast(ufd_internal_comments as varchar(max)),char(13),' '),char(10),' ')as ufd_comments
 ,replace(replace(cast(spd_internal_comments as varchar(max)),char(13),' '),char(10),' ')as spd_comments
 ,replace(replace(cast(bss_internal_comments as varchar(max)),char(13),' '),char(10),' ')as bss_comments 
 , ar_status.ar_status_desc
 ,replace(replace(cast(SR_ACCESS_COMMENTS as varchar(max)),char(13),' '),char(10),' ')as SR_Access_comments 
 
 , dbo.ar_info.dod_denied_by
 , dbo.ar_info.dod_approved_dt
 , dbo.ar_info.dod_denied_dt
 , dbo.ar_info.dod_to_bss_dt
 
<!---  , dateDiff("d", dbo.ar_info.ddate_submitted, getDate()) as daysInQueue --->
 
 FROM  ar_info LEFT OUTER JOIN
               ar_status ON ar_info.ar_status_cd = ar_status.ar_status_cd
where
	(1=1)
<!--- 	and ar_status.ar_status_desc <> 'assessment completed' --->
	and ddate_submitted between #CreateODBCDate(request.ddate1)# 
	and  #CreateODBCDate(request.ddate2)#
	<cfif request.cd is 'All'>
		<!--- do nothing --->
	<cfelse>
	and council_dist=#request.CD#
	</cfif>

</cfquery>


<cfoutput>
<cfif not isdefined("request.ddate1") or not isdate(#request.ddate1#)>
<span class="warning">Start Date is Required!</span>
<cfabort>
</cfif>

<cfif not isdefined("request.ddate2") or not isdate(#request.ddate2#)>
<span class="warning">End Date is Required!</span>
<cfabort>
</cfif>
</cfoutput> 






<!-- No record are found -->
<cfif #unprocessed_investigations.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#unprocessed_investigations.recordcount# Applications are Unprocessed<br>
Between #request.ddate1# and #request.ddate2#</div>
</cfoutput>

<div style="margin-bottom:10px;"></div>
	<cfif  #request.action# is "print_submital">
			Print All Sidewalk Requests
		<cfelse>
				<a href="control.cfm?action=print_submital&arKey=#request.arKey#&#request.addtoken#" target="_blank">Print All Sidewalk Requests</a>
	</cfif>
</div>

<!---  My own Notes:
	for CSV files:
<!--- Control white space: --->
<Cfsetting enabelcfoutputonly="yes">
<!--- Create a new line variable to start a new line --->
<cfset CrLF=ch(13) & ch(1)>
<!--- get query data --->
<cfquery name="unprocessed_investiagtions" datasource="request.dsn" >
 Input the query info in here
 select
 from
 where clause
 order by
 etc....
</cfquery>
<!--- Set the filename for the report --->
<cfheader name="Choose your title name in here" Value="filename=myCSV.csv">
<!--- Set the mime type and output --->
<cfcontent type="text/csv">
	<cfoutput query="unprocessed_investigations">
		#name#, #email# #CrLF#  <!--- this is the data being exported --->
	</cfoutput> --->

<cfoutput>
<cfheader name="content-disposition" value="inline;filename=AccessRequest_Rpt.xls">
<cfcontent type="application/msexcel" reset="Yes">

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
<div style="margin-right:auto;margin-left:auto;width:90%;">
	<div style="width:100%;text-align:left;">Records #start_row# To #END_ROW# out of #unprocessed_investigations.recordcount# Records</div>
</div>
</cfoutput>
</cfif>
<cfset prev_start= #start_row# - #request.max_rows#>
<cfset next_start=#start_row# + #request.max_rows#> 
<!--- Record Counter --->
<br>
<br>
<div align = "center">
<table class="datatable" id="table1" style="width:95%;" border="1">
<tr>
<th>AR ID</th>
<th nowrap>SR Number</th>
<th nowrap>Date Submitted</th>
<th nowrap>Applicant Name</th>
<th nowrap>Address1</th>
<th nowrap>Address2</th>
<th nowrap>City</th>
<th nowrap>State</th>
<th nowrap>Zip Code</th>
<th nowrap>Phone Number</th>
<th nowrap>E-mail</th>
<th>Access Barrier Location</th>
<th>Council<br>District</th>
<th nowrap>Mailing Address1</th>
<th nowrap>Mailing Address2</th>
<th nowrap>Mailing City</th>
<th nowrap>Mailing State</th>
<th nowrap>Mailing Zip Code</th>
<th nowrap>BPP</th>
<th nowrap>PIN</th>
<th nowrap>PIND</th>
<th nowrap>Zoning Code</th>
<th nowrap>SR E-Mail</th>
<th nowrap>Date to BOE</th>
<th>Staff Name</th>
<th>DOD Internal Comments</th>
<th>UFD Internal Comments</th>
<th>SPD Internal Comments</th>
<th>BSS Internal Comments</th>
<th>Status</th>
<th>Status Description</th>
<th>DOD Denied By</th>
<th>DOD Approved Date</th>
<th>DOD Denied Date</th>
<Th>DOD to BSS Date</TH>
</tr>
</cfoutput>


<cfoutput query="unprocessed_investigations" startrow="#start_row#" maxrows="#request.max_rows#">

<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#unprocessed_investigations.arKey#&#request.addtoken#"> --->
	#unprocessed_investigations.ar_id#
<!--- </a> --->
</td>
<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#unprocessed_investigations.arKey#&#request.addtoken#"> --->
	#unprocessed_investigations.sr_number#
<!--- </a> --->
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(unprocessed_investigations.ddate_submitted,"mm/dd/yyyy")#
</td>

<!--- Applicant Information --->

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_name_nn#
</td>

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_address1_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_address2_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_City_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_state_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_zip_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_phone_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.app_email_nn#
</td>

<td style="text-align:left;vertical-align:top;">
#unprocessed_investigations.job_address#
</td>


<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.Council_dist#
</td>

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.mailing_address1#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.mailing_address2#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.mailing_city#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.mailing_state#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.mailing_zip#
</td>

<!--- End --->

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.bpp#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.pin#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.pind#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.zoningCode#
</td>
<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.sr_email#
</td>



<td style="text-align:center;vertical-align:top;" >
#dateformat(unprocessed_investigations.bss_to_srp_dt,"mm/dd/yyyy")#
</td>


<td style="text-align:center;vertical-align:top;">
<!--- applicant name --->
<cfif #unprocessed_investigations.bss_to_srp_by# is not "">
<cfquery name="getStaffName" datasource="#request.dsn#" dbtype="datasource">
select first_name, last_name from staff 
where user_id = #unprocessed_investigations.bss_to_srp_by#
</cfquery>
<p>#getStaffName.first_name# #getStaffName.last_name#</p>
</cfif>
</td>

<td style="text-align:left;vertical-align:top;">
	#dod_comments#
</td>



<td style="text-align:center;vertical-align:top;">
	#ufd_comments#
</td>


<td style="text-align:center;vertical-align:top;">
	#spd_comments#
</td>



<td style="text-align:center;vertical-align:top;">
	#bss_comments#
</td>

<td style="text-align:center;vertical-align:top;">
#unprocessed_investigations.ar_status_desc#
</td>


<td style="text-align:center;vertical-align:top;">
<span class="data">#sr_access_comments#</span>
</td>

<td style="text-align:center;vertical-align:top;">
	#dod_denied_by#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(unprocessed_investigations.dod_approved_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
<strong>#dateformat(unprocessed_investigations.dod_denied_dt,"mm/dd/yyyy")#</strong>
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(unprocessed_investigations.dod_to_bss_dt,"mm/dd/yyyy")#
</td>

</tr>
</cfoutput>
</table> 
</div>

