<cfparam name="start_row" default="1">
<cfscript>
function jsonSafe(x) {
    if (x is not '')
	{
	x = ReplaceList(x,"\","\\");	
	// x = ReplaceList(x,"/","\/");	
	x = ReplaceList(x,"&","\u0026"); //ampersand
	x = ReplaceList(x,"#chr(39)#","\#chr(39)#");
	x = ReplaceList(x,"#chr(34)#","\#chr(34)#");
	x = ReplaceList(x,"*","\u002A");  //asterisk
	x = ReplaceList(x,"{","(");
	x = ReplaceList(x,"}",")");
	x = ReplaceList(x,";","\u003B");
	x = ReplaceList(x,"#chr(13)#"," ");
	x = ReplaceList(x,"#chr(10)#"," ");
	x = ReplaceList(x,"#char(124)#"," ");
	x = ReplaceList(x,"#char(41)#"," ");
	x = ReplaceList(x,"#char(58)#"," ");
	x = ReplaceList(x,"#char(32)#"," ");
	x = ReplaceList(x,"#char(46)#"," ");	
	x = trim(x);
	return x;
	}
	else
	{
	return '';
	}
}
</cfscript>

<Cfsetting enablecfoutputonly="Yes" showdebugoutput="no">
<cfquery name="allrebates" datasource="#request.dsn#" dbtype="datasource">
SELECT	  srr_info.srr_id
		, srr_info.sr_number
		, srr_info.tree_insp_sr_number
		, replace(replace(cast(srr_info.sr_app_comments as varchar(max)),char(13),' '),char(10),' ')as applicant_comments
		, replace(replace(cast(srr_info.sr_location_comments as varchar(max)),char(13),' '),char(10),' ')as location_comments
		, srr_info.sr_attachments
		, srr_status.srr_status_desc
		, srr_info.app_name_nn
		, srr_info.app_email_nn
		, prop_owned_by.prop_owned_by_desc
		, srr_info.a_ref_no
		, srr_info.app_id
		, srr_info.ddate_submitted
		, srr_info.waitListed_to_received_dt
		, srr_info.rate_nbr
		, srr_info.zip_cd
		, srr_info.tbm_grid
		,CASE WHEN srr_info.boe_dist='V' THEN 'Valley'
			  WHEN srr_info.boe_dist='W' THEN 'West LA'
			  WHEN srr_info.boe_dist='C' THEN 'Central'
			  WHEN srr_info.boe_dist='H' THEN 'Harbor'
		 END as district 
		, srr_info.council_dist
		, srr_info.bpp
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
		, replace(replace(cast(srr_info.paymentIncompleteReasons as varchar(max)),char(13),' '),char(10),' ')as paymentIncompleteReasons
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

FROM  srr_info LEFT OUTER JOIN
      srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
		LEFT OUTER JOIN
	prop_owned_by on srr_info.prop_owned_by=prop_owned_by.prop_owned_by
where
	(1=1)
	and ddate_submitted >= #CreateODBCDate(request.ddate1)# 
	and ddate_submitted <= #CreateODBCDate(request.ddate2)#
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

<cfoutput>
<cfheader name="content-disposition" value="attachment;filename=SidewalkRebate_Rpt.xls">
<cfcontent type="application/msexcel" reset="Yes">
</cfoutput>

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
<th nowrap>Zip Code</th>
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
<th>BOE Invest To BPW Date</th>
<th>BOE Invest To BPW By</th>
<th>BOE Invest To BCA Date</th>
<th>BOE Invest To BCA By</th>
<th>BOE Invest To BSS Date</th>
<th>BOE Invest To BSS By</th>
<th>BOE Invest Not Eligible Date</th>
<th>BOE Invest Not Eligible By</th>
<th>Required Permits Not Submitted Date</th>
<th>Required Permits Not Submitted Expiration Date</th>
<th>Required Permits Not Submitted Date</th>
<th>Required Permits Submitted Date</th>
<th>Required Permits Issued Date</th>
<th>Required Permits Issued Expiration Date</th>
<th>Construction Completed Date</th>
<th>A-permit Issued Date</th>
<th>A-permit Submitted Date</th>
<th>Application Last Update Date</th>
<th>Lgd Completed Date</th>
<th>lgd Completed By</th>
<th>Justification</th>
<th>Ext.Granted Days</th>
<th>Ext.Granted Date</th>
<th>Ext.Granted By</th>
<th>Close Cancel Comments</th>
<th>Close Cancel By</th>
<th>Close Cancel Date</th>
<th>Filing Folder Created</th>
<th>W9 On File</th>
<th>Valuation Est.</th>
<th>OfferExpire Date</th>
<th>Offer-Expired Expiration Date</th>
</tr>


<cfoutput query="allrebates" startrow="1" >
<!---  startrow="#start_row#" maxrows="#request.max_rows#" --->>

<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#allrebates.arKey#&#request.addtoken#"> --->
	#allrebates.srr_id#
<!--- </a> --->
</td>
<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#allrebates.arKey#&#request.addtoken#"> --->
	#allrebates.sr_number#
<!--- </a> --->
</td>

<td style="text-align:center;white-space: nowrap;vertical-align:top;">
<!--- <a href="control.cfm?action=process_app1&arKey=#allrebates.arKey#&#request.addtoken#"> --->
	#allrebates.tree_insp_sr_number#
<!--- </a> --->
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.applicant_comments#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.location_comments#
</td>

<td style="text-align:center;vertical-align:top;">
<cfset attachments=listchangedelims(allrebates.sr_attachments,"<br>","|")>
#attachments#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.srr_status_desc#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.app_name_nn#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.app_email_nn#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.prop_owned_by_desc#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.a_ref_no#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.app_id#
</td>
<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.ddate_submitted,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.waitListed_to_received_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.rate_nbr#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.zip_cd#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.tbm_grid#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.district#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.council_dist#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpp#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.pind#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.address_verified#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.zoningCode#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.Prop_Type#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.prop_data_checked#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.job_address#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.app_contact_name_nn#
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

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.mailing_address_comp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_action_by#
</td>

<td style="text-align:left;vertical-align:top;">
#allrebates.bpw1_action_dt#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.AdaCompliant_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.AdaCompliant_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bss_action_by#
</td>
<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.bss_to_boe_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.bss_assessment_comp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.srp_action_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.bpw_to_bca_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.bpw_to_boe_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.eligibility_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.incompleteDocs_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.incompleteDocs_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.record_history#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.notEligible_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.notEligible_exp_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.offer_reserved_amt#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.offer_open_amt#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.offer_accepted_amt#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.offer_paid_amt#
</td>
<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerMade_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerMade_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerAccepted_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerAccepted_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerDeclined_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.offerDeclined_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.gis_completed_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.gis_completed_by#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_ownership_verified#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_Ownership_Comments#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_tax_verified#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.tax_comments#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_comments_app#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw1_internal_comments#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bpw2_action_by#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.bpw2_internal_comments#
</td>
<td style="text-align:center;vertical-align:top;">
#dateformat(allrebates.bpw2_action_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
#allrebates.bca_comments#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.bss_comments#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.gis_comments#
</td>
<td style="text-align:center;vertical-align:top;">
#allrebates.paymentIncompleteReasons#
</td>

<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.paymentIncompleteDocs_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.paymentIncompleteDocs_exp_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.paymentPending_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_license_no#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_name#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_address#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_city#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_state#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_zip#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_phone#
</td>

<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.cont_lic_issue_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.cont_lic_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.cont_lic_class#
</td>

<td style="text-align:center;vertical-align:top;" >
#dateformat(allrebates.cont_info_comp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.anyLiens#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.liensText#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.close_bss_sr311#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_comments#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_response_app#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.boe_invest_response_dt,"mm/dd/yyyy")#
</td>


<td style="text-align:left;vertical-align:top;">
	#allrebates.boe_invest_response_by#
</td>



<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_decision#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.boe_invest_to_bpw_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_to_bpw_by#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.boe_invest_to_bca_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_to_bca_by#
</td>
<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.boe_invest_to_bss_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_to_bss_by#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.boe_invest_notEligible_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.boe_invest_notEligible_by#
</td>



<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.requiredPermitsNotSubmitted_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.requiredPermitsNotSubmitted_exp_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.requiredPermitsSubmitted_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.requiredPermitsIssued_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.requiredPermitsIssued_exp_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.constCompleted_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.ApermitIssued_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.ApermitSubmitted_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.app_last_update_dt,"mm/dd/yyyy")#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.lgd_completed_dt,"mm/dd/yyyy")#
</td>






<td style="text-align:center;vertical-align:top;">
	#allrebates.lgd_completed_by#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.justification#
</td>

<td style="text-align:center;vertical-align:top;">
	#allrebates.ext_grantedDays#
</td>

<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.ext_granted_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.ext_granted_by#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.close_cancel_comments#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.close_cancel_by#
</td>



<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.close_cancel_dt,"mm/dd/yyyy")#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.filing_folder_created#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.w9_on_file#
</td>
<td style="text-align:center;vertical-align:top;">
	#allrebates.valuation_est#
</td>


<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.OfferExpire_dt,"mm/dd/yyyy")#
</td>


<td style="text-align:center;vertical-align:top;">
	#dateformat(allrebates.OfferExpire_exp_dt,"mm/dd/yyyy")#
</td>
</tr>
</cfoutput>
</table> 


