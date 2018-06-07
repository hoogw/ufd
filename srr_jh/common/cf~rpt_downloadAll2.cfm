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

<cfquery name="allrebates" datasource="#request.dsn#" dbtype="datasource">
SELECT	  srr_info.srr_id
		, srr_info.sr_number
		, srr_info.tree_insp_sr_number
		, replace(replace(cast(srr_info.sr_app_comments as varchar(max)),char(13),' '),char(10),' ')as applicant_comments
		, replace(replace(cast(srr_info.sr_location_comments as varchar(max)),char(13),' '),char(10),' ')as location_comments
		, srr_info.sr_attachments
<!--- 		--, srr_info.srr_status_cd --->
		, srr_status.srr_status_desc
		, srr_info.app_name_nn
		, srr_info.app_email_nn
<!--- 		--, srr_info.prop_owned_by --->
		, prop_owned_by.prop_owned_by_desc
		, srr_info.a_ref_no
		, srr_info.app_id
		, srr_info.ddate_submitted
		, srr_info.ddate_submitted_temp
		, srr_info.waitListed_to_received_dt
		, srr_info.rate_nbr
		, srr_info.hse_nbr
		, srr_info.hse_frac_nbr
		, srr_info.hse_dir_cd
		, srr_info.str_nm
		, srr_info.str_sfx_cd
		, srr_info.str_sfx_dir_cd
		, srr_info.zip_cd
		, srr_info.unit_range
		, srr_info.hse_id
		, srr_info.tbm_grid
		,CASE WHEN srr_info.boe_dist='V' THEN 'Valley'
			  WHEN srr_info.boe_dist='W' THEN 'West LA'
			  WHEN srr_info.boe_dist='C' THEN 'Central'
			  WHEN srr_info.boe_dist='H' THEN 'Harbor'
		 END as district 
		, srr_info.council_dist
		, srr_info.bpp
<!--- 		--, srr_info.pin --->
		, srr_info.pind
		, Case when srr_info.address_verified='y' then 'Yes'
		       Else 'No'
		  END as address_verified
		, srr_info.zoningCode
		, Case When srr_info.prop_type='R' then 'Residential'
		       When srr_info.prop_type='C' Then 'Commercial'
		 End as Prop_Type
		, srr_info.prop_data_checked
		, srr_info.job_address
		, srr_info.x_coord
		, srr_info.y_coord
		, srr_info.longitude
		, srr_info.latitude
		, srr_info.app_contact_name_nn
		, srr_info.app_address1_nn
		, srr_info.app_address2_nn
		, srr_info.app_city_nn
		, srr_info.app_state_nn
		, srr_info.app_zip_nn
		, srr_info.app_phone_nn
		, srr_info.mailing_address1
		, srr_info.mailing_address2
		, srr_info.mailing_zip
		, srr_info.mailing_city
		, srr_info.mailing_state
		, srr_info.mailing_address_comp_dt
		, srr_info.bpw1_action_by
		, srr_info.bpw1_action_dt
		, srr_info.AdaCompliant_dt
		, srr_info.AdaCompliant_exp_dt
		, srr_info.bss_action_by
		, srr_info.bss_to_boe_dt
		, srr_info.bss_assessment_comp_dt
		, srr_info.srp_action_dt
		, srr_info.bpw_to_bca_dt
		, srr_info.bpw_to_boe_dt
		, srr_info.eligibility_dt
		, srr_info.incompleteDocs_dt
		, srr_info.incompleteDocs_exp_dt
		, replace(replace(cast(srr_info.record_history as varchar(max)),char(13),' '),char(10),' ')as record_history
		, srr_info.notEligible_dt
		, srr_info.notEligible_exp_dt
		, srr_info.offer_reserved_amt
		, srr_info.offer_open_amt
		, srr_info.offer_accepted_amt
		, srr_info.offer_paid_amt
		, srr_info.offerMade_dt
		, srr_info.offerMade_exp_dt
		, srr_info.offerAccepted_dt
		, srr_info.offerAccepted_exp_dt
		, srr_info.offerDeclined_dt
		, srr_info.offerDeclined_exp_dt
		, srr_info.gis_completed_dt
		, srr_info.gis_completed_by
		, srr_info.bpw1_ownership_verified
		, replace(replace(cast(srr_info.bpw1_ownership_comments as varchar(max)),char(13),' '),char(10),' ')as bpw1_Ownership_Comments
		, srr_info.bpw1_tax_verified
		, replace(replace(cast(srr_info.bpw1_tax_comments as varchar(max)),char(13),' '),char(10),' ')as tax_comments 
		, replace(replace(cast(srr_info.bpw1_comments_to_app as varchar(max)),char(13),' '),char(10),' ')as bpw1_comments_app 
		, replace(replace(cast(srr_info.bpw1_internal_comments as varchar(max)),char(13),' '),char(10),' ')as bpw1_internal_comments 
		, srr_info.bpw2_action_by
		, replace(replace(cast(srr_info.bpw2_internal_comments as varchar(max)),char(13),' '),char(10),' ')as bpw2_internal_comments 
		, srr_info.bpw2_action_dt
		, replace(replace(cast(srr_info.bca_comments as varchar(max)),char(13),' '),char(10),' ')as bca_comments 
		, replace(replace(cast(srr_info.bss_comments as varchar(max)),char(13),' '),char(10),' ')as bss_comments 
		, replace(replace(cast(srr_info.gis_comments as varchar(max)),char(13),' '),char(10),' ')as gis_comments 
		, srr_info.paymentIncompleteReasons
		, srr_info.paymentIncompleteDocs_dt
		, srr_info.paymentIncompleteDocs_exp_dt
		, srr_info.paymentPending_dt
		, srr_info.cont_license_no
		, srr_info.cont_name
		, srr_info.cont_address
		, srr_info.cont_city
		, srr_info.cont_state
		, srr_info.cont_zip
		, srr_info.cont_phone
		, srr_info.cont_lic_issue_dt
		, srr_info.cont_lic_exp_dt
		, srr_info.cont_lic_class
		, srr_info.cont_info_comp_dt
		, srr_info.anyLiens
		, srr_info.liensText
		, srr_info.close_bss_sr311
		, replace(replace(cast(srr_info.boe_invest_comments as varchar(max)),char(13),' '),char(10),' ')as boe_invest_comments
		, replace(replace(cast(srr_info.boe_invest_response_to_app as varchar(max)),char(13),' '),char(10),' ')as boe_invest_response_app
		, srr_info.boe_invest_response_dt
		, srr_info.boe_invest_response_by
		, srr_info.boe_invest_decision
		, srr_info.boe_invest_to_bpw_dt
		, srr_info.boe_invest_to_bpw_by
		, srr_info.boe_invest_to_bca_dt
		, srr_info.boe_invest_to_bca_by
		, srr_info.boe_invest_to_bss_dt
		, srr_info.boe_invest_to_bss_by
		, srr_info.boe_invest_notEligible_dt
		, srr_info.boe_invest_notEligible_by
		, srr_info.requiredPermitsNotSubmitted_dt
		, srr_info.requiredPermitsNotSubmitted_exp_dt
		, srr_info.requiredPermitsSubmitted_dt
		, srr_info.requiredPermitsIssued_dt
		, srr_info.requiredPermitsIssued_exp_dt
		, srr_info.constCompleted_dt
		, srr_info.ApermitIssued_dt
		, srr_info.ApermitSubmitted_dt
		, srr_info.app_last_update_dt
		, srr_info.lgd_completed_dt
		, srr_info.lgd_completed_by
		, srr_info.justification
		, srr_info.fakeUpdate
		, srr_info.ext_grantedDays
		, srr_info.ext_granted_dt
		, srr_info.ext_granted_by
		, replace(replace(cast(srr_info.close_cancel_comments as varchar(max)),char(13),' '),char(10),' ')as close_cancel_comments
		, srr_info.close_cancel_by
		, srr_info.close_cancel_dt
		, srr_info.filing_folder_created
		, srr_info.w9_on_file
		, srr_info.valuation_est
		, srr_info.OfferExpire_dt
		, srr_info.OfferExpire_exp_dt

FROM            srr_info LEFT OUTER JOIN
                         srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
						 LEFT OUTER JOIN
						 prop_owned_by on srr_info.prop_owned_by=prop_owned_by.prop_owned_by
where
	(1=1)
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

<!--- Use for attachments any other where the straight line needs to be replaced with a br or space
<cfset newname=listchangedelims(fieldname,"<br>","|")>
 --->




<!-- No record are found -->
<cfif #allrebates.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
</cfif>
<!-- End of no record are found -->

<cfoutput>
<div class="subtitle">#allrebates.recordcount# Records for Sidewalk Rebate Program<br>
Between #request.ddate1# and #request.ddate2#</div>
</cfoutput>

<div style="margin-bottom:10px;"></div>
	<cfif  #request.action# is "print_submital">
			Print All Sidewalk Rebates
		<cfelse>
				<a href="control.cfm?action=print_submital&arKey=#request.arKey#&#request.addtoken#" target="_blank">Print All Sidewalk Rebates</a>
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
	<cfoutput query="allrebates">
		#name#, #email# #CrLF#  <!--- this is the data being exported --->
	</cfoutput> --->

<cfoutput>
<cfheader name="content-disposition" value="inline;filename=SidewalkRebate_Rpt.xls">
<cfcontent type="application/msexcel" reset="Yes">

</cfoutput>
<!-- ---------------------------   PREVIOUS AND NEXT BUTTONS  ------------------------------- -->

<cfoutput>
<!--- Record Counter --->
<cfif #allrebates.recordcount# is  not 0>
<cfset end_row=#start_row# + #request.max_rows# -1>
<cfif #allrebates.recordcount# lt #end_row#>
<cfset end_row=#allrebates.recordcount#>
</cfif>
<cfoutput>
<div style="margin-right:auto;margin-left:auto;width:90%;">
	<div style="width:100%;text-align:left;">Records #start_row# To #END_ROW# out of #allrebates.recordcount# Records</div>
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
<th>SR ID</th>
<th nowrap>SR Number</th>
<th>Tree Inspection SR Number</th>
<Th>Applicant Comment</TH>
<Th>Location Comment</TH>
<th>SR Attachment</th>
<Th>Status Description</TH>
<TH>Applicant Name</TH>
<th nowrap>E-mail</th>
<th>Property Owned By</th>
<th>Ref. No</th>
<th nowrap>Application ID</th>
<th nowrap>Date Submitted</th>
<th nowrap>Date Submitted (Temp)</th>
<th>Waiting Listed to Received Date</th>
<th nowrap>Rate Number</th>
<th nowrap>House Number</th>
<th nowrap>House Fraction Number</th>
<th>House Direction Code</th>
<th nowrap>Street Name</th>
<th nowrap>Street Suffix</th>
<th>Street Suffix Dir.Code</th>
<th nowrap>Zip Code</th>
<th nowrap>Unit Range</th>
<th nowrap>House ID</th>
<th>Thomas Book Map(TBM)Grid</th>
<th nowrap>District</th>
<th>Council District</th>
<th nowrap>BPP</th>
<th nowrap>PIN ID</th>
<th nowrap>Address Verified</th>
<th>Zoning Code</th>
<th>Property Type</th>
<th>Property Data Checked</th>
<th>Job Address</th>
<th>X-Coordinate</th>
<th>Y-Coordinate</th>
<th>Longitude</th>
<th>Latitude</th>
<th>Application Contact Name</th>
<th>Applicant Address1</th>
<th>Applicant Address2</th>
<th>Applicant City</th>
<th>Applicant State</th>
<th nowrap>Applicant Zip Code</th>
<th nowrap>Applicant Phone Number</th>
<th nowrap>Mailing Address1</th>
<th nowrap>Mailing Address2</th>
<th nowrap>Mailing City</th>
<th nowrap>Mailing State</th>
<th nowrap>Mailing Zip Code</th>
<th nowrap>Mailing Address Comp Date</th>
<th nowrap>BPW1 Action By</th>
<th nowrap>BPW1 Action Date</th>
<th nowrap>ADA Compliant Date</th>
<th>ADA Compliant Expiration Date</th>
<th nowrap>BSS Action BY</th>
<th nowrap>BSS to BOE Date</th>
<th>BSS Assessment Comp Date</th>
<th>SRP Action Date</th>
<th>BPW to BCA Date</th>
<th>BPW to BOE Date</th>
<TH>Elegibility Date</TH>
<TH>Incomplete Docs Date</TH>
<th>Incomplete Docs Expiration Date</th>
<th>Record History</th>
<th>Not Eligible Date</th>
<th>Not Eligible Expiration Date</th>
<th>Offer Reserved Amount</th>
<th>Offer Open Amount</th>
<th>Offer Accepted Amount</th>
<th>Offer Paid Amount</th>
<th>Offer Made Date</th>
<th>Offer Made Expiration Date</th>
<th>Offer Accepted Date</th>
<th>Offer Accepted Expiration Date</th>
<th>Offer Declined Date</th>
<th>Offer Declined Expiration Date</th>
<th>GIS Completed Date</th>
<th>GIS Completed By</th>
<th>BPW1 Ownership Verified</th>
<th>BPW1 Ownership Comments</th>
<th>Tax Comments</th>
<th>BPW1 Comments To Applicant</th>
<th>BPW1 Internal Comments</th>
<th>BPW2 Action By</th>
<th>BPW2 Internal Comments </th>
<th>BPW2 Action Date</th>
<th>BCA Comments</th>
<th>BSS Comments</th>
<th>GIS Comments</th>
<th>Payment Incomplete Reasons</th>
<th>Payment Incomplete Docs Date</th>
<th>Payment Incomplete Docs Expiration Date</th>
<th>Payment Pending Date</th>
<th>Contractor License Number</th>
<th>Contractor Name</th>
<th>Contractor Address</th>
<th>Contractor City</th>
<th>Contractor State</th>
<th>Contractor Zip Code</th>
<th>Contractor Phone Number</th>
<th>Contractor License Issue Date</th>
<th>Contractor License Expiration Date</th>
<th>Contractor License Class</th>
<th>Contractor Info Comp Date</th>
<th>Any Liens</th>
<th>Liens Text</th>
<th>Close BSS SR311</th>
<th>BOE Investigation Comments</th>
<th>BOE Investigation Response to Applicant</th>
<th>BOE Investigation Response Date</th>
<th>BOE Investigation Response By</th>
<th>BOE Investigation Decision</th>
<th>BOE Investigation Response to Applicant</th>
<th>BOE Invest To BPW dt</th>
<th>BOE Invest To BPW By</th>
<th>BOE Invest To BCA Dt</th>
<th>BOE Invest To BCA By</th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
		, srr_info.
		, srr_info.
		, srr_info.
		, srr_info.
		, srr_info.boe_invest_to_bss_dt
		, srr_info.boe_invest_to_bss_by
		, srr_info.boe_invest_notEligible_dt
		, srr_info.boe_invest_notEligible_by
		, srr_info.requiredPermitsNotSubmitted_dt
		, srr_info.requiredPermitsNotSubmitted_exp_dt
		, srr_info.requiredPermitsSubmitted_dt
		, srr_info.requiredPermitsIssued_dt
		, srr_info.requiredPermitsIssued_exp_dt
		, srr_info.constCompleted_dt
		, srr_info.ApermitIssued_dt
		, srr_info.ApermitSubmitted_dt
		, srr_info.app_last_update_dt
		, srr_info.lgd_completed_dt
		, srr_info.lgd_completed_by
		, srr_info.justification
		, srr_info.fakeUpdate
		, srr_info.ext_grantedDays
		, srr_info.ext_granted_dt
		, srr_info.ext_granted_by


<th>DOD Denied Date</th>
<Th>DOD to BSS Date</TH>
</tr>
</cfoutput>


<cfoutput query="allrebates" startrow="#start_row#" maxrows="#request.max_rows#">

<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#allrebates.arKey#&#request.addtoken#"> --->
	#allrebates.ar_id#
<!--- </a> --->
</td>
<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#allrebates.arKey#&#request.addtoken#"> --->
	#allrebates.sr_number#
<!--- </a> --->
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.ddate_submitted,"mm/dd/yyyy")#
</td>

<!--- Applicant Information --->

<td style="text-align:center;vertical-align:top;">
#allrebates.app_name_nn#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.app_address1_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_address2_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_City_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_state_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_zip_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_phone_nn#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.app_email_nn#
</td>

<td style="text-align:left;vertical-align:top;">
#allrebates.job_address#
</td>


<td style="text-align:center;vertical-align:top;">
#allrebates.Council_dist#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.mailing_address1#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.mailing_address2#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.mailing_city#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.mailing_state#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.mailing_zip#
</td>

<!--- End --->

<td style="text-align:center;vertical-align:top;">
#allrebates.bpp#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.pin#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.pind#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.zoningCode#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.sr_email#
</td>



<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.bss_to_srp_dt,"mm/dd/yyyy")#
</td>


<td style="text-align:center;vertical-align:top;">
<!--- applicant name --->
<cfif #allrebates.bss_to_srp_by# is not "">
<cfquery name="getStaffName" datasource="#request.dsn#" dbtype="datasource">
select first_name, last_name from staff 
where user_id = #allrebates.bss_to_srp_by#
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
#allrebates.ar_status_desc#
</td>


<td style="text-align:center;vertical-align:top;">
<span class="data">#sr_access_comments#</span>
</td>

<td style="text-align:center;vertical-align:top;">
	#dod_denied_by#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.dod_approved_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
<strong>#dateformat(allrebates.dod_denied_dt,"mm/dd/yyyy")#</strong>
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.dod_to_bss_dt,"mm/dd/yyyy")#
</td>

</tr>
</cfoutput>
</table> 
</div>

