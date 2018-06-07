<cfinclude template="security.cfm">

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<meta name="description" content="Bureau of Engineering, City of Los Angeles, Sidewalk Rebate Report">
<meta name="keywords" content="SRR - Sidewalk Rebate">
<meta name="author" content="Essam Amarragy">
<title>SRR-Sidewalk Rebate Program</title>
<link href="/styles/boe_main_gray.css" rel="stylesheet" type="text/css" src="/styles/boe_main_gray.css">
</head>
<body>

<cfif NOT ISDATE(#request.ddate1#)>
<cfmodule template="/common/error_msg.cfm" error_msg = "Invalid Start Date">
<cfabort>
</CFIF>


<!--- <cfset request.ddate2 = dateAdd("d", 1, #request.ddate2#)> --->

<!--- <cfset request.ddate2 = dateAdd("d", 1, #request.ddate2#)> --->





<cfset request.ddate1=CreateODBCDate(#request.ddate1#)>
<cfset request.ddate2=CreateODBCDate(#request.ddate2#)>

<cfquery name="allrebates" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_info.srr_id
	,srr_info.sr_number
	,srr_info.tree_insp_sr_number
	,srr_info.sr_app_comments
	,srr_info.sr_location_comments
	,srr_info.sr_attachments
	,srr_status.srr_status_desc
	,srr_info.app_name_nn
	,srr_info.app_email_nn
	,prop_owned_by.prop_owned_by_desc
	,srr_info.a_ref_no
	,srr_info.app_id
	,srr_info.ddate_submitted
	,srr_info.waitListed_to_received_dt
	,srr_info.rate_nbr
	,srr_info.zip_cd
	,srr_info.tbm_grid
	,srr_info.boe_dist
	,srr_info.council_dist
	,srr_info.bpp
	,srr_info.pind
	,srr_info.address_verified
	,srr_info.zoningCode
	,srr_info.prop_type
	,srr_info.prop_data_checked
	,srr_info.job_address
	,srr_info.app_contact_name_nn
	,srr_info.app_address1_nn
	,srr_info.app_address2_nn
	,srr_info.app_city_nn
	,srr_info.app_state_nn
	,srr_info.app_zip_nn
	,srr_info.app_phone_nn
	,srr_info.mailing_address1
	,srr_info.mailing_address2
	,srr_info.mailing_zip
	,srr_info.mailing_city
	,srr_info.mailing_state
	,srr_info.mailing_address_comp_dt
	,srr_info.bpw1_action_by
	,srr_info.bpw1_action_dt
	,srr_info.bca_action_by
	,srr_info.bca_assessment_comp_dt
	,srr_info.bca_to_bss_dt
	,srr_info.bca_to_boe_dt
	,srr_info.AdaCompliant_dt
	,srr_info.AdaCompliant_exp_dt
	,srr_info.bss_action_by
	,srr_info.bss_to_boe_dt
	,srr_info.bss_assessment_comp_dt
	,srr_info.srp_action_dt
	,srr_info.bpw_to_bca_dt
	,srr_info.bpw_to_boe_dt
	,srr_info.eligibility_dt
	,srr_info.incompleteDocs_dt
	,srr_info.incompleteDocs_exp_dt
	,srr_info.record_history
	,srr_info.notEligible_dt
	,srr_info.notEligible_exp_dt
	,srr_info.offer_reserved_amt
	,srr_info.offer_open_amt
	,srr_info.offer_accepted_amt
	,srr_info.offer_paid_amt
	,srr_info.offerMade_dt
	,srr_info.offerMade_exp_dt
	,srr_info.offerAccepted_dt
	,srr_info.offerAccepted_exp_dt
	,srr_info.offerDeclined_dt
	,srr_info.offerDeclined_exp_dt
	,srr_info.gis_completed_dt
	,srr_info.gis_completed_by
	,srr_info.bpw1_ownership_verified
	,srr_info.bpw1_ownership_comments
	,srr_info.bpw1_tax_verified
	,srr_info.bpw1_tax_comments
	,srr_info.bpw1_comments_to_app
	,srr_info.bpw1_internal_comments
	,srr_info.bpw2_action_by
	,srr_info.bpw2_internal_comments
	,srr_info.bpw2_action_dt
	,srr_info.bca_comments
	,srr_info.bss_comments
	,srr_info.gis_comments
	,srr_info.paymentIncompleteReasons
	,srr_info.paymentIncompleteDocs_dt
	,srr_info.paymentIncompleteDocs_exp_dt
	,srr_info.paymentPending_dt
	,srr_info.cont_license_no
	,srr_info.cont_name
	,srr_info.cont_address
	,srr_info.cont_city
	,srr_info.cont_state
	,srr_info.cont_zip
	,srr_info.cont_phone
	,srr_info.cont_lic_issue_dt
	,srr_info.cont_lic_exp_dt
	,srr_info.cont_lic_class
	,srr_info.cont_info_comp_dt
	,srr_info.anyLiens
	,srr_info.liensText
	,srr_info.close_bss_sr311
	,srr_info.boe_invest_comments
	,srr_info.boe_invest_response_to_app
	,srr_info.boe_invest_response_dt
	,srr_info.boe_invest_response_by
	,srr_info.boe_invest_decision
	,srr_info.boe_invest_to_bpw_dt
	,srr_info.boe_invest_to_bpw_by
	,srr_info.boe_invest_to_bca_dt
	,srr_info.boe_invest_to_bca_by
	,srr_info.boe_invest_to_bss_dt
	,srr_info.boe_invest_to_bss_by
	,srr_info.boe_invest_notEligible_dt
	,srr_info.boe_invest_notEligible_by
	,srr_info.requiredPermitsNotSubmitted_dt
	,srr_info.requiredPermitsNotSubmitted_exp_dt
	,srr_info.requiredPermitsSubmitted_dt
	,srr_info.requiredPermitsIssued_dt
	,srr_info.requiredPermitsIssued_exp_dt
	,srr_info.constCompleted_dt
	,srr_info.ApermitIssued_dt
	,srr_info.ApermitSubmitted_dt
	,srr_info.app_last_update_dt
	,srr_info.lgd_completed_dt
	,srr_info.lgd_completed_by
	,srr_info.justification
	,srr_info.ext_grantedDays
	,srr_info.ext_granted_dt
	,srr_info.ext_granted_by
	,srr_info.close_cancel_comments
	,srr_info.close_cancel_by
	,srr_info.close_cancel_dt
	,srr_info.filing_folder_created
	,srr_info.w9_on_file
	,srr_info.valuation_est

FROM  srr_info LEFT OUTER JOIN
      srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
		LEFT OUTER JOIN
	prop_owned_by on srr_info.prop_owned_by=prop_owned_by.prop_owned_by
where
	(1=1)
	and ddate_submitted >= #request.ddate1# 
	and ddate_submitted <=#request.ddate2#
	<cfif request.cd is 'All'>
		<!--- do nothing --->
	<cfelse>
	and council_dist=#request.CD#
	</cfif> 

</cfquery>	
<!--- <cfoutput>
Sidewalk_#dateformat(Now(),"mm/dd/yyyy")#	
</cfoutput>
 <cfabort> 
 --->
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
	x = ReplaceList(x,"#chr(124)#"," ");
	x = ReplaceList(x,"#chr(41)#"," ");
	x = ReplaceList(x,"#chr(58)#"," ");
	x = ReplaceList(x,"#chr(32)#"," ");
	x = ReplaceList(x,"#chr(46)#"," ");	
	x = trim(x);
	return x;
	}
	else
	{
	return '';
	}
}
</cfscript>	

<!---  #chr(34)##jsonSafe(ListAllRpts[col][currentRow])##chr(34)# --->


<!--- <cfif #fileexists("#request.directory#\public\#client.customer_id#.xls")# is "yes">
<CFFILE
action="delete" file="#request.directory#\public\#client.customer_id#.xls">
</cfif> --->
<!---   <cfoutput>
<cfset filename="#request.directory#Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.xls">
</cfoutput> --->
<cfspreadsheet action="write" filename="#expandPath('Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.xls')#" query="allrebates" sheetname="Sidewalk Rebates" overwrite="true">

	<cfoutput>
	<div align="center">
<a href="Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.xls">CLICK HERE TO DOWNLOAD THE GENERATED FILE </a>
</div>
	</cfoutput>
	
	
	
	
<!--- <cfabort> --->

<cfset tsrr_id="SR ID">
<cfset tsr_number="SR Number">
<cfset ttree_insp_sr_number="Tree Inspection SR Number">
<cfset tsr_app_comments="Applicant Comment">
<cfset tsr_location_comments="Location Comment">
<cfset tsr_attachments="SR Attachment">
<cfset tsrr_status_desc="Status Description">
<cfset tapp_name_nn="Applicant Name">
<cfset tapp_email_nn="E-mail">
<cfset tprop_owned_by_desc="Property Owned By">
<cfset ta_ref_no="Ref. No">
<cfset tapp_id="Application ID">
<cfset tddate_submitted="Date Submitted">
<cfset twaitListed_to_received_dt="Waiting Listed to Received Date">
<cfset trate_nbr="Rate Number">
<cfset tzip_cd="Zip Code">
<cfset ttbm_grid="Thomas Book Map(TBM)Grid">
<cfset tboe_dist="District">
<cfset tcouncil_dist="Council District">
<cfset tbpp="BPP">
<cfset tpind="PIN ID">
<cfset taddress_verified="Address Verified">
<cfset tzoningCode="Zoning Code">
<cfset tprop_type="Property Type">
<cfset tprop_data_checked="Property Data Checked">
<cfset tjob_address="Job Address">
<cfset tapp_contact_name_nn="Application Contact Name">
<cfset tapp_address1_nn="Applicant Address1">
<cfset tapp_address2_nn="Applicant Address2">
<cfset tapp_city_nn="Applicant City">
<cfset tapp_state_nn="Applicant State">
<cfset tapp_zip_nn="Applicant Zip Code">
<cfset tapp_phone_nn="Applicant Phone Number">
<cfset tmailing_address1="Mailing Address1">
<cfset tmailing_address2="Mailing Address2">
<cfset tmailing_zip="Mailing City">
<cfset tmailing_city="Mailing State">
<cfset tmailing_state="Mailing Zip Code">
<cfset tmailing_address_comp_dt="Mailing Address Comp Date">
<cfset tbpw1_action_by="BPW1 Action By">
<cfset tbpw1_action_dt="BPW1 Action Date">
<cfset tbca_action_by="BCA Action By">
<cfset tbca_assessment_comp_dt="BCA Assesment Comp Date">
<cfset tbca_to_bss_dt="BCA to BSS Date">
<cfset tbca_to_boe_dt="BCA to BOE Date">
<cfset tAdaCompliant_dt="ADA Compliant Date">
<cfset tAdaCompliant_exp_dt="ADA Compliant Expiration Date">
<cfset tbss_action_by="BSS Action BY">
<cfset tbss_to_boe_dt="BSS to BOE Date">
<cfset tbss_assessment_comp_dt="BSS Assessment Comp Date">
<cfset tsrp_action_dt="SRP Action Date">
<cfset tbpw_to_bca_dt="BPW to BCA Date">
<cfset tbpw_to_boe_dt="BPW to BOE Date">
<cfset teligibility_dt="Elegibility Date">
<cfset tincompleteDocs_dt="Incomplete Docs Date">
<cfset tincompleteDocs_exp_dt="Incomplete Docs Expiration Date">
<cfset trecord_history="Record History">
<cfset tnotEligible_dt="Not Eligible Date">
<cfset tnotEligible_exp_dt="Not Eligible Expiration Date">
<cfset toffer_reserved_amt="Offer Reserved Amount">
<cfset toffer_open_amt="Offer Open Amount">
<cfset toffer_accepted_amt="Offer Accepted Amount">
<cfset toffer_paid_amt="Offer Paid Amount">
<cfset tofferMade_dt="Offer Made Date">
<cfset tofferMade_exp_dt="Offer Made Expiration Date">
<cfset tofferAccepted_dt="Offer Accepted Date">
<cfset tofferAccepted_exp_dt="Offer Accepted Expiration Date">
<cfset tofferDeclined_dt="Offer Declined Date">
<cfset tofferDeclined_exp_dt="Offer Declined Expiration Date">
<cfset tgis_completed_dt="GIS Completed Date">
<cfset tgis_completed_by="GIS Completed By">
<cfset tbpw1_ownership_verified="BPW1 Ownership Verified">
<cfset tbpw1_ownership_comments="BPW1 Ownership Comments">
<cfset tbpw1_tax_verified="Tax Verified">
<cfset tbpw1_tax_comments="Tax Comments">
<cfset tbpw1_comments_to_app="BPW1 Comments To Applicant">
<cfset tbpw1_internal_comments="BPW1 Internal Comments">
<cfset tbpw2_action_by="BPW2 Action By">
<cfset tbpw2_internal_comments="BPW2 Internal Comments ">
<cfset tbpw2_action_dt="BPW2 Action Date">
<cfset tbca_comments="BCA Comments">
<cfset tbss_comments="BSS Comments">
<cfset tgis_comments="GIS Comments">
<cfset tpaymentIncompleteReasons="Payment Incomplete Reasons">
<cfset tpaymentIncompleteDocs_dt="Payment Incomplete Docs Date">
<cfset tpaymentIncompleteDocs_exp_dt="Payment Incomplete Docs Expiration Date">
<cfset tpaymentPending_dt="Payment Pending Date">
<cfset tcont_license_no="Contractor License Number">
<cfset tcont_name="Contractor Name">
<cfset tcont_address="Contractor Address">
<cfset tcont_city="Contractor City">
<cfset tcont_state="Contractor State">
<cfset tcont_zip="Contractor Zip Code">
<cfset tcont_phone="Contractor Phone Number">
<cfset tcont_lic_issue_dt="Contractor License Issue Date">
<cfset tcont_lic_exp_dt="Contractor License Expiration Date">
<cfset tcont_lic_class="Contractor License Class">
<cfset tcont_info_comp_dt="Contractor Info Comp Date">
<cfset tanyLiens="Any Liens">
<cfset tliensText="Liens Text">
<cfset tclose_bss_sr311="Close BSS SR311">
<cfset tboe_invest_comments="BOE Investigation Comments">
<cfset tboe_invest_response_to_app="BOE Investigation Response to Applicant">
<cfset tboe_invest_response_dt="BOE Investigation Response Date">
<cfset tboe_invest_response_by="BOE Investigation Response By">
<cfset tboe_invest_decision="BOE Investigation Decision">
<cfset tboe_invest_to_bpw_dt="BOE Invest To BPW Date">
<cfset tboe_invest_to_bpw_by="BOE Invest To BPW By">
<cfset tboe_invest_to_bca_dt="BOE Invest To BCA Date">
<cfset tboe_invest_to_bca_by="BOE Invest To BCA By">
<cfset tboe_invest_to_bss_dt="BOE Invest To BSS Date">
<cfset tboe_invest_to_bss_by="BOE Invest To BSS By">
<cfset tboe_invest_notEligible_dt="BOE Invest Not Eligible Date">
<cfset tboe_invest_notEligible_by="BOE Invest Not Eligible By">
<cfset trequiredPermitsNotSubmitted_dt="Required Permits Not Submitted Date">
<cfset trequiredPermitsNotSubmitted_exp_dt="Required Permits Not Submitted Expiration Date">
<cfset trequiredPermitsSubmitted_dt="Required Permits Submitted Date">
<cfset trequiredPermitsIssued_dt="Required Permits Issued Date">
<cfset trequiredPermitsIssued_exp_dt="Required Permits Issued Expiration Date">
<cfset tconstCompleted_dt="Construction Completed Date">
<cfset tApermitIssued_dt="A-permit Issued Date">
<cfset tApermitSubmitted_dt="A-permit Submitted Date">
<cfset tapp_last_update_dt="Application Last Update Date">
<cfset tlgd_completed_dt="LGD Completed Date">
<cfset tlgd_completed_by="LGD Completed By">
<cfset tjustification="Justification">
<cfset text_grantedDays="Ext.Granted Days">
<cfset text_granted_dt="Ext.Granted Date">
<cfset text_granted_by="Ext.Granted By">
<cfset tclose_cancel_comments="Close Cancel Comments">
<cfset tclose_cancel_by="Close Cancel By">
<cfset tclose_cancel_dt="Close Cancel Date">
<cfset tfiling_folder_created="Filing Folder Created">
<cfset tw9_on_file="W9 On File">
<cfset tvaluation_est="Valuation Est.">



<!--- #request.directory# --->


<CFFILE action="append" 
file="#expandPath('Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.csv')#" 
output="#chr(34)##jsonSafe(tsrr_id)##chr(34)#,#chr(34)##jsonSafe(tsr_number)##chr(34)#,#chr(34)##jsonSafe(ttree_insp_sr_number)##chr(34)#,#chr(34)##jsonSafe(tsr_app_comments)##chr(34)#,#chr(34)##jsonSafe(tsr_location_comments)##chr(34)#,#chr(34)##jsonSafe(tsr_attachments)##chr(34)#,#chr(34)##jsonSafe(tsrr_status_desc)##chr(34)#,#chr(34)##jsonSafe(tapp_name_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_email_nn)##chr(34)#,#chr(34)##jsonSafe(tprop_owned_by_desc)##chr(34)#,#chr(34)##jsonSafe(ta_ref_no)##chr(34)#,#chr(34)##jsonSafe(tapp_id)##chr(34)#,#chr(34)##jsonSafe(tddate_submitted)##chr(34)#,#chr(34)##jsonSafe(twaitListed_to_received_dt)##chr(34)#,#chr(34)##jsonSafe(trate_nbr)##chr(34)#,#chr(34)##jsonSafe(tzip_cd)##chr(34)#,#chr(34)##jsonSafe(ttbm_grid)##chr(34)#,#chr(34)##jsonSafe(tboe_dist)##chr(34)#,#chr(34)##jsonSafe(tcouncil_dist)##chr(34)#,#chr(34)##jsonSafe(tbpp)##chr(34)#,#chr(34)##jsonSafe(tpind)##chr(34)#,#chr(34)##jsonSafe(taddress_verified)##chr(34)#,#chr(34)##jsonSafe(tzoningCode)##chr(34)#,#chr(34)##jsonSafe(tprop_type)##chr(34)#,#chr(34)##jsonSafe(tprop_data_checked)##chr(34)#,#chr(34)##jsonSafe(tjob_address)##chr(34)#,#chr(34)##jsonSafe(tapp_contact_name_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_address1_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_address2_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_city_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_state_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_zip_nn)##chr(34)#,#chr(34)##jsonSafe(tapp_phone_nn)##chr(34)#,#chr(34)##jsonSafe(tmailing_address1)##chr(34)#,#chr(34)##jsonSafe(tmailing_address2)##chr(34)#,#chr(34)##jsonSafe(tmailing_zip)##chr(34)#,#chr(34)##jsonSafe(tmailing_city)##chr(34)#,#chr(34)##jsonSafe(tmailing_state)##chr(34)#,#chr(34)##jsonSafe(tmailing_address_comp_dt)##chr(34)#,#chr(34)##jsonSafe(tbpw1_action_by)##chr(34)#,#chr(34)##jsonSafe(tbpw1_action_dt)##chr(34)#,#chr(34)##jsonSafe(tbca_action_by)##chr(34)#,#chr(34)##jsonSafe(tbca_assessment_comp_dt)##chr(34)#,#chr(34)##jsonSafe(tbca_to_bss_dt)##chr(34)#,#chr(34)##jsonSafe(tbca_to_boe_dt)##chr(34)#,#chr(34)##jsonSafe(tAdaCompliant_dt)##chr(34)#,#chr(34)##jsonSafe(tAdaCompliant_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tbss_action_by)##chr(34)#,#chr(34)##jsonSafe(tbss_to_boe_dt)##chr(34)#,#chr(34)##jsonSafe(tbss_assessment_comp_dt)##chr(34)#,#chr(34)##jsonSafe(tsrp_action_dt)##chr(34)#,#chr(34)##jsonSafe(tbpw_to_bca_dt)##chr(34)#,#chr(34)##jsonSafe(tbpw_to_boe_dt)##chr(34)#,#chr(34)##jsonSafe(teligibility_dt)##chr(34)#,#chr(34)##jsonSafe(tincompleteDocs_dt)##chr(34)#,#chr(34)##jsonSafe(tincompleteDocs_exp_dt)##chr(34)#,#chr(34)##jsonSafe(trecord_history)##chr(34)#,#chr(34)##jsonSafe(tnotEligible_dt)##chr(34)#,#chr(34)##jsonSafe(tnotEligible_exp_dt)##chr(34)#,#chr(34)##jsonSafe(toffer_reserved_amt)##chr(34)#,#chr(34)##jsonSafe(toffer_open_amt)##chr(34)#,#chr(34)##jsonSafe(toffer_accepted_amt)##chr(34)#,#chr(34)##jsonSafe(toffer_paid_amt)##chr(34)#,#chr(34)##jsonSafe(tofferMade_dt)##chr(34)#,#chr(34)##jsonSafe(tofferMade_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tofferAccepted_dt)##chr(34)#,#chr(34)##jsonSafe(tofferAccepted_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tofferDeclined_dt)##chr(34)#,#chr(34)##jsonSafe(tofferDeclined_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tgis_completed_dt)##chr(34)#,#chr(34)##jsonSafe(tgis_completed_by)##chr(34)#,#chr(34)##jsonSafe(tbpw1_ownership_verified)##chr(34)#,#chr(34)##jsonSafe(tbpw1_ownership_comments)##chr(34)#,#chr(34)##jsonSafe(tbpw1_tax_verified)##chr(34)#,#chr(34)##jsonSafe(tbpw1_tax_comments)##chr(34)#,#chr(34)##jsonSafe(tbpw1_comments_to_app)##chr(34)#,#chr(34)##jsonSafe(tbpw1_internal_comments)##chr(34)#,#chr(34)##jsonSafe(tbpw2_action_by)##chr(34)#,#chr(34)##jsonSafe(tbpw2_internal_comments)##chr(34)#,#chr(34)##jsonSafe(tbpw2_action_dt)##chr(34)#,#chr(34)##jsonSafe(tbca_comments)##chr(34)#,#chr(34)##jsonSafe(tbss_comments)##chr(34)#,#chr(34)##jsonSafe(tgis_comments)##chr(34)#,#chr(34)##jsonSafe(tpaymentIncompleteReasons)##chr(34)#,#chr(34)##jsonSafe(tpaymentIncompleteDocs_dt)##chr(34)#,#chr(34)##jsonSafe(tpaymentIncompleteDocs_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tpaymentPending_dt)##chr(34)#,#chr(34)##jsonSafe(tcont_license_no)##chr(34)#,#chr(34)##jsonSafe(tcont_name)##chr(34)#,#chr(34)##jsonSafe(tcont_address)##chr(34)#,#chr(34)##jsonSafe(tcont_city)##chr(34)#,#chr(34)##jsonSafe(tcont_state)##chr(34)#,#chr(34)##jsonSafe(tcont_zip)##chr(34)#,#chr(34)##jsonSafe(tcont_phone)##chr(34)#,#chr(34)##jsonSafe(tcont_lic_issue_dt)##chr(34)#,#chr(34)##jsonSafe(tcont_lic_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tcont_lic_class)##chr(34)#,#chr(34)##jsonSafe(tcont_info_comp_dt)##chr(34)#,#chr(34)##jsonSafe(tanyLiens)##chr(34)#,#chr(34)##jsonSafe(tliensText)##chr(34)#,#chr(34)##jsonSafe(tclose_bss_sr311)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_comments)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_response_to_app)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_response_dt)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_response_by)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_decision)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bpw_dt)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bpw_by)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bca_dt)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bca_by)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bss_dt)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_to_bss_by)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_notEligible_dt)##chr(34)#,#chr(34)##jsonSafe(tboe_invest_notEligible_by)##chr(34)#,#chr(34)##jsonSafe(trequiredPermitsNotSubmitted_dt)##chr(34)#,#chr(34)##jsonSafe(trequiredPermitsNotSubmitted_exp_dt)##chr(34)#,#chr(34)##jsonSafe(trequiredPermitsSubmitted_dt)##chr(34)#,#chr(34)##jsonSafe(trequiredPermitsIssued_dt)##chr(34)#,#chr(34)##jsonSafe(trequiredPermitsIssued_exp_dt)##chr(34)#,#chr(34)##jsonSafe(tconstCompleted_dt)##chr(34)#,#chr(34)##jsonSafe(tApermitIssued_dt)##chr(34)#,#chr(34)##jsonSafe(tApermitSubmitted_dt)##chr(34)#,#chr(34)##jsonSafe(tapp_last_update_dt)##chr(34)#,#chr(34)##jsonSafe(tlgd_completed_dt)##chr(34)#,#chr(34)##jsonSafe(tlgd_completed_by)##chr(34)#,#chr(34)##jsonSafe(tjustification)##chr(34)#,#chr(34)##jsonSafe(text_grantedDays)##chr(34)#,#chr(34)##jsonSafe(text_granted_dt)##chr(34)#,#chr(34)##jsonSafe(text_granted_by)##chr(34)#,#chr(34)##jsonSafe(tclose_cancel_comments)##chr(34)#,#chr(34)##jsonSafe(tclose_cancel_by)##chr(34)#,#chr(34)##jsonSafe(tclose_cancel_dt)##chr(34)#,#chr(34)##jsonSafe(tfiling_folder_created)##chr(34)#,#chr(34)##jsonSafe(tw9_on_file)##chr(34)#,#chr(34)##jsonSafe(tvaluation_est)##chr(34)#">
<!--- #request.directory# --->
<cfloop query="allrebates">
<CFFILE action="append" file="#expandPath('Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.csv')#" 
output="#chr(34)##jsonSafe(srr_id)##chr(34)#,
#chr(34)##jsonSafe(sr_number)##chr(34)#,
#chr(34)##jsonSafe(tree_insp_sr_number)##chr(34)#,
#chr(34)##jsonSafe(sr_app_comments)##chr(34)#,
#chr(34)##jsonSafe(sr_location_comments)##chr(34)#,
#chr(34)##jsonSafe(sr_attachments)##chr(34)#,
#chr(34)##jsonSafe(srr_status_desc)##chr(34)#,
#chr(34)##jsonSafe(app_name_nn)##chr(34)#,
#chr(34)##jsonSafe(app_email_nn)##chr(34)#,
#chr(34)##jsonSafe(prop_owned_by_desc)##chr(34)#,
#chr(34)##jsonSafe(a_ref_no)##chr(34)#,
#chr(34)##jsonSafe(app_id)##chr(34)#,
#chr(34)##jsonSafe(ddate_submitted)##chr(34)#,
#chr(34)##jsonSafe(waitListed_to_received_dt)##chr(34)#,
#chr(34)##jsonSafe(rate_nbr)##chr(34)#,
#chr(34)##jsonSafe(zip_cd)##chr(34)#,
#chr(34)##jsonSafe(tbm_grid)##chr(34)#,
#chr(34)##jsonSafe(boe_dist)##chr(34)#,
#chr(34)##jsonSafe(council_dist)##chr(34)#,
#chr(34)##jsonSafe(bpp)##chr(34)#,
#chr(34)##jsonSafe(pind)##chr(34)#,
#chr(34)##jsonSafe(address_verified)##chr(34)#,
#chr(34)##jsonSafe(zoningCode)##chr(34)#,
#chr(34)##jsonSafe(prop_type)##chr(34)#,
#chr(34)##jsonSafe(prop_data_checked)##chr(34)#,
#chr(34)##jsonSafe(job_address)##chr(34)#,
#chr(34)##jsonSafe(app_contact_name_nn)##chr(34)#,
#chr(34)##jsonSafe(app_address1_nn)##chr(34)#,
#chr(34)##jsonSafe(app_address2_nn)##chr(34)#,
#chr(34)##jsonSafe(app_city_nn)##chr(34)#,
#chr(34)##jsonSafe(app_state_nn)##chr(34)#,
#chr(34)##jsonSafe(app_zip_nn)##chr(34)#,
#chr(34)##jsonSafe(app_phone_nn)##chr(34)#,
#chr(34)##jsonSafe(mailing_address1)##chr(34)#,
#chr(34)##jsonSafe(mailing_address2)##chr(34)#,
#chr(34)##jsonSafe(mailing_zip)##chr(34)#,
#chr(34)##jsonSafe(mailing_city)##chr(34)#,
#chr(34)##jsonSafe(mailing_state)##chr(34)#,
#chr(34)##jsonSafe(mailing_address_comp_dt)##chr(34)#,
#chr(34)##jsonSafe(bpw1_action_by)##chr(34)#,
#chr(34)##jsonSafe(bpw1_action_dt)##chr(34)#,
#chr(34)##jsonSafe(bca_action_by)##chr(34)#,
#chr(34)##jsonSafe(bca_assessment_comp_dt)##chr(34)#,
#chr(34)##jsonSafe(bca_to_bss_dt)##chr(34)#,
#chr(34)##jsonSafe(bca_to_boe_dt)##chr(34)#,
#chr(34)##jsonSafe(AdaCompliant_dt)##chr(34)#,
#chr(34)##jsonSafe(AdaCompliant_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(bss_action_by)##chr(34)#,
#chr(34)##jsonSafe(bss_to_boe_dt)##chr(34)#,
#chr(34)##jsonSafe(bss_assessment_comp_dt)##chr(34)#,
#chr(34)##jsonSafe(srp_action_dt)##chr(34)#,
#chr(34)##jsonSafe(bpw_to_bca_dt)##chr(34)#,
#chr(34)##jsonSafe(bpw_to_boe_dt)##chr(34)#,
#chr(34)##jsonSafe(eligibility_dt)##chr(34)#,
#chr(34)##jsonSafe(incompleteDocs_dt)##chr(34)#,
#chr(34)##jsonSafe(incompleteDocs_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(record_history)##chr(34)#,
#chr(34)##jsonSafe(notEligible_dt)##chr(34)#,
#chr(34)##jsonSafe(notEligible_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(offer_reserved_amt)##chr(34)#,
#chr(34)##jsonSafe(offer_open_amt)##chr(34)#,
#chr(34)##jsonSafe(offer_accepted_amt)##chr(34)#,
#chr(34)##jsonSafe(offer_paid_amt)##chr(34)#,
#chr(34)##jsonSafe(offerMade_dt)##chr(34)#,
#chr(34)##jsonSafe(offerMade_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(offerAccepted_dt)##chr(34)#,
#chr(34)##jsonSafe(offerAccepted_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(offerDeclined_dt)##chr(34)#,
#chr(34)##jsonSafe(offerDeclined_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(gis_completed_dt)##chr(34)#,
#chr(34)##jsonSafe(gis_completed_by)##chr(34)#,
#chr(34)##jsonSafe(bpw1_ownership_verified)##chr(34)#,
#chr(34)##jsonSafe(bpw1_ownership_comments)##chr(34)#,
#chr(34)##jsonSafe(bpw1_tax_verified)##chr(34)#,
#chr(34)##jsonSafe(bpw1_tax_comments)##chr(34)#,
#chr(34)##jsonSafe(bpw1_comments_to_app)##chr(34)#,
#chr(34)##jsonSafe(bpw1_internal_comments)##chr(34)#,
#chr(34)##jsonSafe(bpw2_action_by)##chr(34)#,
#chr(34)##jsonSafe(bpw2_internal_comments)##chr(34)#,
#chr(34)##jsonSafe(bpw2_action_dt)##chr(34)#,
#chr(34)##jsonSafe(bca_comments)##chr(34)#,
#chr(34)##jsonSafe(bss_comments)##chr(34)#,
#chr(34)##jsonSafe(gis_comments)##chr(34)#,
#chr(34)##jsonSafe(paymentIncompleteReasons)##chr(34)#,
#chr(34)##jsonSafe(paymentIncompleteDocs_dt)##chr(34)#,
#chr(34)##jsonSafe(paymentIncompleteDocs_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(paymentPending_dt)##chr(34)#,
#chr(34)##jsonSafe(cont_license_no)##chr(34)#,
#chr(34)##jsonSafe(cont_name)##chr(34)#,
#chr(34)##jsonSafe(cont_address)##chr(34)#,
#chr(34)##jsonSafe(cont_city)##chr(34)#,
#chr(34)##jsonSafe(cont_state)##chr(34)#,
#chr(34)##jsonSafe(cont_zip)##chr(34)#,
#chr(34)##jsonSafe(cont_phone)##chr(34)#,
#chr(34)##jsonSafe(cont_lic_issue_dt)##chr(34)#,
#chr(34)##jsonSafe(cont_lic_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(cont_lic_class)##chr(34)#,
#chr(34)##jsonSafe(cont_info_comp_dt)##chr(34)#,
#chr(34)##jsonSafe(anyLiens)##chr(34)#,
#chr(34)##jsonSafe(liensText)##chr(34)#,
#chr(34)##jsonSafe(close_bss_sr311)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_comments)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_response_to_app)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_response_dt)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_response_by)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_decision)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bpw_dt)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bpw_by)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bca_dt)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bca_by)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bss_dt)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_to_bss_by)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_notEligible_dt)##chr(34)#,
#chr(34)##jsonSafe(boe_invest_notEligible_by)##chr(34)#,
#chr(34)##jsonSafe(requiredPermitsNotSubmitted_dt)##chr(34)#,
#chr(34)##jsonSafe(requiredPermitsNotSubmitted_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(requiredPermitsSubmitted_dt)##chr(34)#,
#chr(34)##jsonSafe(requiredPermitsIssued_dt)##chr(34)#,
#chr(34)##jsonSafe(requiredPermitsIssued_exp_dt)##chr(34)#,
#chr(34)##jsonSafe(constCompleted_dt)##chr(34)#,
#chr(34)##jsonSafe(ApermitIssued_dt)##chr(34)#,
#chr(34)##jsonSafe(ApermitSubmitted_dt)##chr(34)#,
#chr(34)##jsonSafe(app_last_update_dt)##chr(34)#,
#chr(34)##jsonSafe(lgd_completed_dt)##chr(34)#,
#chr(34)##jsonSafe(lgd_completed_by)##chr(34)#,
#chr(34)##jsonSafe(justification)##chr(34)#,
#chr(34)##jsonSafe(ext_grantedDays)##chr(34)#,
#chr(34)##jsonSafe(ext_granted_dt)##chr(34)#,
#chr(34)##jsonSafe(ext_granted_by)##chr(34)#,
#chr(34)##jsonSafe(close_cancel_comments)##chr(34)#,
#chr(34)##jsonSafe(close_cancel_by)##chr(34)#,
#chr(34)##jsonSafe(close_cancel_dt)##chr(34)#,
#chr(34)##jsonSafe(filing_folder_created)##chr(34)#,
#chr(34)##jsonSafe(w9_on_file)##chr(34)#,
#chr(34)##jsonSafe(valuation_est)##chr(34)#">

</cfloop>



<cfoutput>
<div align="center">
<strong>
<font color="red">
&quot;A COMMA SEPARATED VARIABLES&quot; FILE( Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.csv) 
<br>
WAS CREATED AND IS AVAILABLE FOR DOWNLOADING.
<br>
<br>
THIS FILE CAN BE VIEWED USING THE WINDOWS NOTEPAD<br> OR ANY OTHER ASCII EDITOR.<br>
IT CAN BE IMPORTED INTO MANY APPLICATIONS SUCH AS EXCEL, ACCESS, ETC.<br><br>
</font>
</strong>
</div>
<br>
<br>
<br>



<div align="center">
<a href="Sidewalk_#dateformat(Now(),"mm_dd_yyyy")#.csv">CLICK HERE TO DOWNLOAD THE GENERATED FILE </a>
</div>
</cfoutput>
</body>
</html>
