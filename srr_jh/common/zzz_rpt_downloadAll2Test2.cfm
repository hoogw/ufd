<cfparam name="start_row" default="1">


<!--- 
My own Notes:  for CSV files
 Control white space: --->
<Cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<!--- Create a new line variable to start a new line --->
<!--- <cfset CrLF=ch(13) & ch(1)> --->
<!--- get query data --->
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

FROM  srr_info LEFT OUTER JOIN
      srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
		LEFT OUTER JOIN
	prop_owned_by on srr_info.prop_owned_by=prop_owned_by.prop_owned_by
where
	(1=1)
	and ddate_submitted >= #CreateODBCDate(request.ddate1)# 
	and ddate_submitted < #CreateODBCDate(request.ddate2)#
	<cfif request.cd is 'All'>
		<!--- do nothing --->
	<cfelse>
	and council_dist=#request.CD#
	</cfif>
</cfquery>

<!---ERROR MESSAGE TRIGGERED IF NO START OR END DATE SELECTED--->
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
<!---END--->

<!--- Set the filename for the report --->
<cfheader name="Content-Disposition" Value="attachment;filename=SidewalkRebateRpt.csv">
<!--- Set the mime type and output --->
<cfcontent type="text/csv" reset="true">


<!--- <cfoutput>
<cfheader name="content-disposition" value="inline;filename=SidewalkRebate_Rpt.xls">
<cfcontent type="application/msexcel" reset="Yes">
</cfoutput> --->
<!-- No record are found -->
<!--- <cfif #allrebates.recordcount# is 0>
<cfoutput>
<div class="warning">No Application are Currently in the Queue</div>
</cfoutput>
<cfabort>
<!-- End of no record are found -->
<cfelse> --->
<!--- move forward withoutput --->

<cfoutput query="allrebates">
	#allrebates.srr_id#
	#allrebates.sr_number#
	#allrebates.tree_insp_sr_number#
	#applicant_comments#
	#location_comments#
<cfset attachments=listchangedelims(sr_attachments,"<br>","|")>
#attachments#
	#srr_status_desc#
	#app_name_nn#
	#app_email_nn#
	#prop_owned_by_desc#
	#a_ref_no#
	#app_id#
#dateformat(allrebates.ddate_submitted,"mm/dd/yyyy")#
#dateformat(allrebates.ddate_submitted_temp,"mm/dd/yyyy")#
#dateformat(allrebates.waitListed_to_received_dt,"mm/dd/yyyy")#
	#rate_nbr#
	#hse_nbr#
	#hse_frac_nbr#
	#hse_dir_cd#
	#str_nm#
	#str_sfx_cd#
	#str_sfx_dir_cd#
	#zip_cd#
	#unit_range#
	#hse_id#
	#tbm_grid#
	#district#
#allrebates.council_dist#
#allrebates.bpp#
#allrebates.pind#
#allrebates.address_verified#
#allrebates.zoningCode#
#allrebates.Prop_Type#
#allrebates.prop_data_checked#
#allrebates.job_address#
#allrebates.x_coord#
#allrebates.y_coord#
#allrebates.longitude#
#allrebates.latitude#
#allrebates.app_contact_name_nn#
#allrebates.app_address1_nn#
#allrebates.app_address2_nn#
#allrebates.app_City_nn#
#allrebates.app_state_nn#
#allrebates.app_zip_nn#
#allrebates.app_phone_nn#
#allrebates.mailing_address1#
#allrebates.mailing_address2#
#allrebates.mailing_city#
#allrebates.mailing_state#
#allrebates.mailing_zip#
#dateformat(allrebates.mailing_address_comp_dt,"mm/dd/yyyy")#



#allrebates.bpw1_action_by#



#allrebates.bpw1_action_dt#



#dateformat(allrebates.AdaCompliant_dt,"mm/dd/yyyy")#



#dateformat(allrebates.AdaCompliant_exp_dt,"mm/dd/yyyy")#



#allrebates.bss_action_by#


#dateformat(allrebates.bss_to_boe_dt,"mm/dd/yyyy")#


#dateformat(allrebates.bss_assessment_comp_dt,"mm/dd/yyyy")#



#dateformat(allrebates.srp_action_dt,"mm/dd/yyyy")#



#dateformat(allrebates.bpw_to_bca_dt,"mm/dd/yyyy")#



#dateformat(allrebates.bpw_to_boe_dt,"mm/dd/yyyy")#



#dateformat(allrebates.eligibility_dt,"mm/dd/yyyy")#



#dateformat(allrebates.incompleteDocs_dt,"mm/dd/yyyy")#



#dateformat(allrebates.incompleteDocs_exp_dt,"mm/dd/yyyy")#



#record_history#



#dateformat(allrebates.notEligible_dt,"mm/dd/yyyy")#



#dateformat(allrebates.notEligible_exp_dt,"mm/dd/yyyy")#


#offer_reserved_amt#


#offer_open_amt#



#allrebates.offer_accepted_amt#


#allrebates.offer_paid_amt#


#dateformat(allrebates.offerMade_dt,"mm/dd/yyyy")#



#dateformat(allrebates.offerMade_exp_dt,"mm/dd/yyyy")#



#dateformat(allrebates.offerAccepted_dt,"mm/dd/yyyy")#



#dateformat(allrebates.offerAccepted_exp_dt,"mm/dd/yyyy")#



#dateformat(allrebates.offerDeclined_dt,"mm/dd/yyyy")#



#dateformat(allrebates.offerDeclined_exp_dt,"mm/dd/yyyy")#



#dateformat(allrebates.gis_completed_dt,"mm/dd/yyyy")#



#allrebates.gis_completed_by#



#allrebates.bpw1_ownership_verified#



#allrebates.bpw1_Ownership_Comments#



#allrebates.bpw1_tax_verified#



#allrebates.tax_comments#



#allrebates.bpw1_comments_app#



#allrebates.bpw1_internal_comments#



#allrebates.bpw2_action_by#


#allrebates.bpw2_internal_comments#


#dateformat(allrebates.bpw2_action_dt,"mm/dd/yyyy")#



#allrebates.bca_comments#


#allrebates.bss_comments#


#allrebates.gis_comments#


#allrebates.paymentIncompleteReasons#



#dateformat(allrebates.paymentIncompleteDocs_dt,"mm/dd/yyyy")#



#dateformat(allrebates.paymentIncompleteDocs_exp_dt,"mm/dd/yyyy")#


#dateformat(allrebates.paymentPending_dt,"mm/dd/yyyy")#



	#allrebates.cont_license_no#


	#allrebates.cont_name#


	#allrebates.cont_address#


	#allrebates.cont_city#


	#allrebates.cont_state#


	#allrebates.cont_zip#


	#allrebates.cont_phone#



#dateformat(allrebates.cont_lic_issue_dt,"mm/dd/yyyy")#



#dateformat(allrebates.cont_lic_exp_dt,"mm/dd/yyyy")#



	#allrebates.cont_lic_class#



#dateformat(allrebates.cont_info_comp_dt,"mm/dd/yyyy")#



	#allrebates.anyLiens#


	#allrebates.liensText#


	#allrebates.close_bss_sr311#


	#allrebates.boe_invest_comments#


	#allrebates.boe_invest_response_app#



	#dateformat(allrebates.boe_invest_response_dt,"mm/dd/yyyy")#




	#boe_invest_response_by#





	#boe_invest_decision#



	#dateformat(allrebates.boe_invest_to_bpw_dt,"mm/dd/yyyy")#



	#boe_invest_to_bpw_by#



	#dateformat(allrebates.boe_invest_to_bca_dt,"mm/dd/yyyy")#



	#boe_invest_to_bca_by#


	#dateformat(allrebates.boe_invest_to_bss_dt,"mm/dd/yyyy")#



	#boe_invest_to_bss_by#



	#dateformat(allrebates.boe_invest_notEligible_dt,"mm/dd/yyyy")#



	#boe_invest_notEligible_by#





	#dateformat(allrebates.requiredPermitsNotSubmitted_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.requiredPermitsNotSubmitted_exp_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.requiredPermitsSubmitted_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.requiredPermitsIssued_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.requiredPermitsIssued_exp_dt,"mm/dd/yyyy")#


	#dateformat(allrebates.constCompleted_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.ApermitIssued_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.ApermitSubmitted_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.app_last_update_dt,"mm/dd/yyyy")#



	#dateformat(allrebates.lgd_completed_dt,"mm/dd/yyyy")#








	#lgd_completed_by#


	#justification#


	#fakeUpdate#


	#ext_grantedDays#



	#dateformat(allrebates.ext_granted_dt,"mm/dd/yyyy")#


	#ext_granted_by#


	#close_cancel_comments#


	#close_cancel_by#





	#dateformat(allrebates.close_cancel_dt,"mm/dd/yyyy")#


	#filing_folder_created#


	#w9_on_file#


	#valuation_est#




	#dateformat(allrebates.OfferExpire_dt,"mm/dd/yyyy")#




	#dateformat(allrebates.OfferExpire_exp_dt,"mm/dd/yyyy")#




</cfoutput>
<!--- </cfif> --->


