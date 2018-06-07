<cfparam name="request.srrKey" default="1NyWhesMv91Ztu9vXuKeaSAXRnFHNFSAAdmqw5lfpWEM4soUPc">
<cfparam name="attributes.srrKey" default="1NyWhesMv91Ztu9vXuKeaSAXRnFHNFSAAdmqw5lfpWEM4soUPc">
<cfparam name="abortflag" default="notabort">
<!--- <cfparam name="request.srrKey" default="LzRn0c4bHOlC4HQOlqdkGWXq0xq9bT6NJdrSLEZCfRgHMUMGV6">
<cfparam name="attributes.srrKey" default="LzRn0c4bHOlC4HQOlqdkGWXq0xq9bT6NJdrSLEZCfRgHMUMGV6"> --->

<style>
* {
font-family: arial;
font-size: 12px;
}

h1 {
font-size: 12px;
/*font-weight: bold;*/
text-align: center;
}

.data 
{
color:maroon;
font-weight:bold;
}

p {
padding-left: 20px;
margin-bottom:0px;
}



</style>

<!--- <cfinclude template="/srr/common/validate_srrKey.cfm"> --->

<cfif not isdefined("request.srrKey") or len(#request.srrKey#) is not 50>
<!--- <div class="warning">Invalid SRR Key!</div> --->
<cfset message="Invalid SRR Key!">
<cfset abortflag="abort">
<!--- <cfabort> --->
</cfif>


<cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.srrKey
, dbo.srr_info.sr_number
, dbo.srr_info.a_ref_no
, dbo.srr_status.srr_status_desc
, srr_info.app_id
, srr_info.job_address
, srr_info.srr_status_cd

FROM  dbo.srr_info LEFT OUTER JOIN
               dbo.srr_status ON dbo.srr_info.srr_status_cd = dbo.srr_status.srr_status_cd

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset request.srr_id = #validateSRR.srr_id#>
<cfset request.sr_number = #validateSRR.sr_number#>
<cfset request.a_ref_no = #validateSRR.a_ref_no#>
<cfset request.app_id = #validateSRR.app_id#>
<cfset request.job_address = #validateSRR.job_address#>
<cfset request.status_cd = #validateSRR.srr_status_cd#>
<cfset request.status_desc = #validateSRR.srr_status_desc#>

<cfif #validateSRR.recordcount# is 0>
<!--- <div class="warning">Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.</div> --->
<cfset message="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfset abortflag="abort">
<!--- <cfabort> --->
</cfif>

<cfoutput>
<div align="center">
#validateSRR.sr_number#&nbsp;&nbsp;&nbsp;
#validateSRR.srr_id#&nbsp;&nbsp;&nbsp;
A-Permit Ref. No. #validateSRR.a_ref_no#
</div>

</cfoutput>


<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id
, dbo.srr_info.ddate_submitted
, dbo.srr_info.sr_number
, dbo.srr_info.app_name_nn
, dbo.srr_info.app_phone_nn
, dbo.srr_info.app_email_nn
, dbo.srr_info.job_address
, dbo.srr_info.srr_status_cd
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
, tree_insp_sr_number

FROM  dbo.srr_info 			   

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>




<cfdocument  format="PDF" pagetype="letter" margintop=".5" marginbottom=".5" marginright=".5" marginleft=".5" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="No" bookmark="False" localurl="No">

<style>
* {
font-family: arial;
font-size: 12px;
}

h1 {
font-size: 12px;
/*font-weight: bold;*/
text-align: center;
}

.data 
{
color:maroon;
font-weight:bold;
}

p {
padding-left: 20px;
margin-bottom:0px;
}



</style>

<!--- <cfmodule template="../common/dsp_srTicketInfo.cfm" srrKey = "#request.srrKey#"> --->

<!--- <cfinclude template="../common/validate_srrKey.cfm"> --->

<cfif #abortflag# is "abort">
	#message#
<cfelse>
<!--- 	<cfdocumentitem type="header" evalatprint="true"> 
		<cfinclude template="print_app1_header.cfm">
	</cfdocumentitem>  --->

	<cfdocumentitem type="footer" evalatprint="true">
		<cfinclude template="print_app1_footer.cfm">
	</cfdocumentitem>

<!--- add javascript validation here --->

	<cfquery name="srInfo" datasource="#request.dsn#" dbtype="datasource">
SELECT
	 job_address
	 ,hse_nbr
	 ,hse_frac_nbr
	 ,hse_dir_cd
	 ,str_nm
	 ,str_sfx_cd
	 ,str_sfx_dir_cd
	 ,zip_cd
	 ,unit_range
	 ,app_name_nn
	 ,app_email_nn
	 ,app_phone_nn
	 ,sr_app_comments
	 ,sr_location_comments
	 ,sr_attachments
	 ,prop_owned_by
	 ,srr_info.mailing_address1
      ,srr_info.mailing_address2
      ,srr_info.mailing_zip
      ,srr_info.mailing_city
      ,srr_info.mailing_state

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
	  , srr_info.x_coord
	  , srr_info.y_coord
	  , srr_info.council_dist
	  , tree_insp_sr_number

		  
<!--- 	,[bpw1_ownership_comments]
	,[bpw1_tax_comments]
	,[bpw1_comments_to_app]

	, srr_info.bpw1_internal_comments
	, srr_info.bpw2_internal_comments
	
	, srr_info.bca_comments
	, srr_info.bss_comments
	
	, srr_info.boe_invest_comments
	, srr_info.boe_invest_response_to_app
	
	, gis_comments		  
				   --->
	from srr_info
	where 
	srrKey = '#request.srrKey#'
	</cfquery>
	
<!--- <cfoutput>
#request.srrKey#
</cfoutput> --->
	<cfoutput query="srInfo">
		<div align="left">
			<h2>SR Number: #request.sr_number# - Ticket Information</h2>
		</div>
		<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<th align="left" width="30%">Applicant Name:</th>
			<td>
			#srInfo.app_name_nn#
			</td>
		</tr>
		
		<tr>
			<th align="left">Applicant Phone Number:</th>
			<td>
			#srInfo.app_phone_nn#
			</td>
		</tr>
		
		<tr>
			<th align="left">Applicant Email:</th>
			<td>
			#srInfo.app_email_nn#
			</td>
		</tr>
		<tr>
			<th align="left">Job Address:</th>
			<td>
			#srInfo.HSE_NBR# #srInfo.HSE_FRAC_NBR# #srInfo.HSE_DIR_CD# #srInfo.STR_NM# #srInfo.STR_SFX_CD# #srInfo.STR_SFX_DIR_CD# #srInfo.ZIP_CD#
			</td>
		</tr>
		<tr>
			<th align="left">Property Owned by:</th>
			<td>
				<cfif #srInfo.prop_owned_by# is "I">
				Individual(s)
				<cfelseif #srInfo.prop_owned_by# is "T">
				Trust
				<cfelseif #srInfo.prop_owned_by# is "B">
				Business/Other
				<cfelseif #srInfo.prop_owned_by# is "M">
				Multiple Owners with an HOA or Management Association
				</cfif>
			</td>
		</tr>
		<tr>
			<th align="left">SR Applicant Comments:</th>
			<td>
			#srInfo.sr_app_comments#
			</td>
		</tr>
		<tr>
			<th align="left">SR Location Comments:</th>
			<td>
			#srInfo.sr_location_comments#
			</td>
		</tr>
		
		
		
<cfset request.rslt_boe_district = ""> 				<!--- Resulting BOE District 	--->	
<cfset request.rslt_bss_district = ""> 				<!--- Resulting BSS District	--->	
<cfset request.rslt_bss_name = "">					<!--- Resulting BSS Name		--->	
<cfset request.rslt_bss_district_office = "">		<!--- Resulting BOE District Office	 	--->				
<cfset request.rslt_bca_district = "">				<!--- Resulting BOE District	--->
<cfset request.rslt_bca_inspect_district = "">	
		
<cfif #srInfo.x_coord# is not "" and #srInfo.y_coord# is not "">
<cfmodule template="../modules/getDistricts_module.cfm" x="#srInfo.x_coord#" y="#srInfo.y_coord#">
</cfif>

<tr>
<td><strong>BOE District:</strong></td>
<td>
<strong>#request.rslt_boe_district#</strong>
</td>
</tr>

<tr>
<td><strong>BSS District:</strong></td>
<td>
<strong>#request.rslt_bss_name# - #request.rslt_bss_district# - #request.rslt_bss_district_office#</strong>
</td>
</tr>

<tr>
<td><strong>BCA District:</strong></td>
<td>
<strong>#request.rslt_bca_district# - #request.rslt_bca_inspect_district#</strong>
</td>
</tr>

<tr>
<td><strong>Council District:</strong></td>
<td>
<strong>#srInfo.council_dist#</strong>
</td>
</tr>

<tr>
<td><strong>Neighborhood Council:</strong></td>
<td>
<strong>#request.rslt_nc#</strong>
</td>
</tr>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<tr>
			<th align="left">SR Attachments:</th>
			<td>
			<Cfset nn = 1>
			<cfloop index="xx" list="#sr_attachments#" delimiters="|">
			<div align="left"><a href="#xx#" target="_blank">Attachment No. #nn#</a></div>
			<cfset nn = #nn# + 1>
			</cfloop>
			</td>
		</tr>
		</table>
		</div>
		<br>
		<!---<div class="notes" style="width:450px;">
		<strong>Programming Notes:</strong>
		Verify 311Script to copy data includes:<br>
		app_name_nn,<br>
		app_phone_nn,<br>
		app_email_nn,<br>
		job_address,<br>
		hse_nbr,<br>
		hse_dir_cd,<br>
		str_nm,<br>
		str_sfx_cd,<br>
		str_sfx_dir_cd,<br>
		zip_cd<br>
		</div>--->
	
	</cfoutput> 


<!--- <cfmodule template="../modules/addressReportModule.cfm" srrKey="#request.srrKey#"  hse_nbr="#find_srr.hse_nbr#" hse_frac_nbr="#find_srr.hse_frac_nbr#" hse_dir_cd="#find_srr.hse_dir_cd#" str_nm="#find_srr.str_nm#" str_sfx_cd="#find_srr.str_sfx_cd#" zip_cd="#find_srr.zip_cd#"> --->


<!--- <cfinclude template="../common/validate_srrKey.cfm"> --->



<cfoutput>
	<div align="left">
		<h2>Mailing Address (for Rebate):</h2>
	</div>
	<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
		<td>Address</td>
		<td>
		#srInfo.mailing_address1#
		<cfif #srInfo.mailing_address2# is not ""><br>#srInfo.mailing_address2#</cfif>
		<br>#srInfo.mailing_city#  #srInfo.mailing_state# #srInfo.mailing_zip#
		</td>
		</tr>
		
		
		</table>
		</div>
		<br>
		<cfif #request.a_ref_no# is not "">
			 <cfmodule template="../modules/calculate_rebate_amt_module.cfm" srrKey="#request.srrKey#">	
			 <cfelse>	 
		<cfset request.rebateTotal = 0>
			 </cfif>
		<div align="left">	  
	  <h2>Rebate Amount</h2>
		</div>
		<div style="width:800px;" align="left">	  
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<td>
	 Rebate Amount = <span style="color:maroon;font-weight:bold;">#dollarformat(request.rebateTotal)#</span><br>

			</td>
		</tr>
		</table>
		</div>
<br>






	<div align="left">
		<h2>Contractor Information:</h2>
	</div>
	<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
		<td>Contractor Name</td>
		<td>
		<strong>#srInfo.cont_name#</strong>
		</td>
		</tr>
		
		<tr>
		<td>License</td>
		<td>
		Number: #srInfo.cont_license_no#<br>
		Issued: #dateformat(srInfo.cont_lic_issue_dt,"mm/dd/yyyy")#<br>
		Expires: #dateformat(srInfo.cont_lic_exp_dt,"mm/dd/yyyy")#<br>
		Class: #srInfo.cont_lic_class#
		</td>
		</tr>
		
		<tr>
		<td>Address</td>
		<td>
		#srInfo.cont_address#<br>
		#srInfo.cont_city# #srInfo.cont_state# #srInfo.cont_zip#
		</td>
		</tr>
		
		<tr>
		<td>Phone</td>
		<td>
		#srInfo.cont_phone#
		</td>
		</tr>
		
		</table>
		</div>
		<br>
		</cfoutput>



		
		
		



	<cfquery name="getAddress" datasource="#request.dsn#" dbtype="datasource">
	select 
	<!--- HSE_ID --->
	srr_id
	, sr_number
	, job_address
	, address_verified
	, bpp
	, PIN
	, PIND
	, zoningCode
	, prop_type
	
	
	from srr_info
	where srrKey = '#request.srrKey#'
	
	
	</cfquery>

	<div align="left">
		<h2>Property Information:</h2>
	</div>
	<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr><td>
	<strong>The Service Request Address:</strong><br>
	<cfoutput>
		<span style="color:maroon;font-weight:bold;">#ucase(getAddress.job_address)#</span><br>
		<cfif #getAddress.address_verified# is "Y">
			<span style="color:maroon;font-weight:bold;">Address is Valid</span>
			<Cfelse>
			<br><br><br>
			<span style="color:maroon;font-weight:bold;font-size:24px;">Address is NOT Valid</span>
		</cfif>
	</cfoutput><!--- End of part 1 - Address verification --->
	
	<cfif #getAddress.address_verified# is "N">
		<cfset message="Address is not Verified!">
		<cfset abortflag="abort">
	</cfif>
<!--- 	<cfif #message# is not "">
	<cfoutput>
	<span style="color:maroon;font-weight:bold;">#message#</span>
	</cfoutput>
	</cfif> --->
<cfif #abortflag# is not "abort">
	<!--- Part 2: Use the PIN to identify any other addresses associated with the same parcel --->
	<cfquery name="getOtherAddresses" datasource="navla_spatial"  dbtype="datasource">
	select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
	X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
	from LA_HSE_NBR
	
	where PIN = '#getAddress.pin#'
	</cfquery>
	
	
	<!--- List other addresses on same parcel if found --->
	<Cfif #getOtherAddresses.recordcount# gt 1>
		<p>
		<strong>The following address(es) are located on the same parcel:</strong><br>
		<cfoutput query="getOtherAddresses">
			<span style="color:maroon;font-weight:bold;font-size:1em;">#HSE_NBR# #HSE_FRAC_NBR# #HSE_DIR_CD# #STR_NM# #STR_SFX_CD# #STR_SFX_DIR_CD# #UNIT_RANGE# -  #ZIP_CD# </span><br>
		</cfoutput>
		</p>
	</CFIF>
	<!--- <cfdump var="#getOtherAddresses#" output="browser"> --->
	<!--- List other addresses on same parcel if found --->
	<!--- <br><br>	 --->
	<!--- End of Part 2 --->
	</td>
	</tr>
</table>
	
	
	
	
	<!--- Part 3: Get All APNs associated with this parcel (PIN number) --->
	<cfquery name="getAPN" datasource="navla_spatial"  dbtype="datasource">
	select PIN, BPP as APN
	from LA_APN
	where PIN = '#getAddress.pin#'
	and exist_stts_cd is null 
	</cfquery>
	
	<cfset apnList = #ValueList(getAPN.APN)#>
	
	<cfset apnList = listQualify(apnList, "#chr(39)#")>
	<!--- <cfdump var="#apnList#" output="browser">
	<cfdump var="#getAPN#" output="browser">
	<br><br> --->
	<!--- Part 3: Get All APNs associated with this parcel (PIN number) --->

	<!--- Part 4: List all owners associated with this parcel using the APNs obtained in Part 3 --->
	<cfquery name="getOwnerInfo" datasource="navla_spatial"  dbtype="datasource">
	select APN, SITHSENO, SITFRAC, SITDIR, SITSTNAM, SITUNIT, SITCITY, SITZIP,
	MALHSENO, MALFRAC, MALDIR, MALSTNAM, MALUNIT, MALCITY, MALZIP, OWNER1, OWNER1_OVERFLOW, SPECNAM, SPECOWN, OWNER2
	from whse_lupams
	where APN in (#PreserveSingleQuotes(apnList)#)
	and PRCL_OBSLT_CD is null
	order by OWNER1
	</cfquery>

	<div align="left">
	<cfif #getOwnerInfo.recordcount# is 0>
	<div align="left">
		<h2><span style="color:red;font-weight:bold;">No Owner(s) Information Found</span></h2>
	</div>
	<cfelse>
	<div align="left">
		<h2>Owner(s) Information</h2>
	</div>
		<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
	<cfoutput query="getOwnerInfo">
	<cfquery name="checkLiens" datasource="form9_sql" dbtype="datasource">
	SELECT dbo.apn.bpp, dbo.apn.reason, dbo.reason_codes.reason_text
	FROM  dbo.apn LEFT OUTER JOIN
	               dbo.reason_codes ON dbo.apn.reason = dbo.reason_codes.reason
	where apn.bpp = '#getOwnerInfo.APN#'
	</cfquery>
	<tr>
	<th align="left" width="30%" valign="top">Owner:</th>
	<td><div style="margin-left:auto;margin-right:auto;text-align:center;">#getOwnerInfo.Owner1#</div>
	<div align="center">#getOwnerInfo.OWNER1_OVERFLOW#</div>
		<div align="center">#getOwnerInfo.OWNER2#</div>
	</td>
	</tr>
	
	<tr>
	<th align="left" width="30%" valign="top">APN:</th>
	<td>
	#getOwnerInfo.APN#
	<cfif #checkLiens.recordcount# is 0>
	<br>No Liens
	<cfelse>
	<span style="color:red;font-weight:bold;"><br>Has Lien(s)</span>
	</cfif>
	</td>
	</tr>
	
	<tr>
	<th align="left" width="30%" valign="top">Mailing Address:</th>
	<td>
	#getOwnerInfo.MALHSENO# #getOwnerInfo.MALFRAC# #getOwnerInfo.MALDIR# #getOwnerInfo.MALSTNAM# #getOwnerInfo.MALUNIT#<br>
	#getOwnerInfo.MALCITY#, #getOwnerInfo.MALZIP#
	</td>
	</tr>
	
	<cfif #checkLiens.recordcount# is not "0">
		<tr>
		<td colspan="2">
		<cfloop query="checkLiens"><span style="color:red;font-weight:bold;">#checkLiens.reason_text#</span><br></cfloop>
		</td>
		</tr>
	</cfif>
	<cfif #getOwnerInfo.recordcount# gt 1 and #getOwnerInfo.currentRow# is not #getOwnerInfo.recordcount#>
		<tr><td colspan="2"><div width="100%" align="center"><img src="../images/hr_line.jpg" alt="____________________________________" width="95%" height="1px" border="0"></div></td></tr>
	</cfif>
	</CFOUTPUT>
	</table>
	</cfif>
	
	
	
	<!--- <cfdump var="#getOwnerInfo#" output="browser"><br><br> --->
	<!--- Part 4: List all owners associated with this parcel using the APNs obtained in Part 3 --->
	
	
	
	
	<!-- Part 5 This portion will check if the address is part of a lot consisting of several parcels. -->
	<cfif #getAPN.recordcount# is 1>
		<cfquery name="getOtherParcels" datasource="navla_spatial"  dbtype="datasource">
		            	select PIN, BPP as APN
		                from LA_APN
		                where BPP in (#PreserveSingleQuotes(apnList)#)
		                and exist_stts_cd is null
		            </cfquery>
		
		<!--- <cfdump var="#getOtherParcels#" output="browser"> --->
		
		<cfif #getOtherParcels.recordcount# gt 1>
			<cfset next2last=#getOtherParcels.recordcount#-1>
			<cfoutput>
		<div align="left">
			<h2>Special Notes</h2>
		</div>
		<div style="width:800px;" align="left">			
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
		<td>
				<span style="color:red;font-weight:bold;">This Address is associated with a lot that has #getOtherParcels.recordcount# parcels.  Use <a href="http://boemaps.eng.ci.la.ca.us/navigatela/" target="_blank">Navigate LA</a> for further investigation.</span><br>
				
				
				The following are the Parcel ID Numbers associated with this lot:<br>
				<cfloop query="getOtherParcels">#getOtherParcels.PIN#
					<cfif #getOtherParcels.currentrow# is #next2last#>
					&nbsp;&nbsp;and&nbsp;&nbsp;
					<cfelseif #getOtherParcels.currentrow# is #getOtherParcels.recordcount#>
					.
					<cfelse>
					,&nbsp;&nbsp;
					</cfif>
				</cfloop>
			</td>
		</tr>
		</table>
	</div>
			</cfoutput>
		</cfif>
	</cfif>
	
	  <Cfoutput>
		<div align="left">	  
	  <h2>Zoning</h2>
		</div>
		<div style="width:800px;" align="left">	  
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<td>
	 Zoning Code = <span style="color:maroon;font-weight:bold;">#getAddress.zoningCode#</span><br>
	 <cfif #getAddress.prop_Type# is "R">
	 For Rebate Purpose, Property is considered: <span style="color:maroon;font-weight:bold;">Residential</span><br>
	 <cfelse>
	 For Rebate Purpose, Property is considered: <span style="color:maroon;font-weight:bold;">Commercial/Industrial</span><br>
	 </cfif>
			</td>
		</tr>
		</table>
		</div>
		

	
	 </CFOUTPUT>
	 
	
	 
	 
	 
	 
	</div>
	</cfif>
</cfif>
<br>
<cfoutput>
	<div align="left">
		<h2>Permit(s) Information:</h2>
	</div>
	<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<td>
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
			<!--- 	<p><a href="/apermits/common/final_permit.cfm?ref_no=#request.a_ref_no#" target="_blank">View Estimate/Permit</a></p> --->
				<hr>
				<cfelse>
				<p>A-Permit was not started.</p>
				</cfif>		
				
				<p>BSS/UFD Child Ticket No.: #srInfo.tree_insp_sr_number#</p>
								
					<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
					SELECT 
					recordID
					      ,srr_id
					      ,ISNULL(nbr_trees_pruned, 0) nbr_trees_pruned
					      ,ISNULL(lf_trees_pruned, 0) lf_trees_pruned
					      ,ISNULL(nbr_trees_removed, 0) nbr_trees_removed
					      ,meandering_viable
					      ,ISNULL(meandering_tree_nbr, 0) meandering_tree_nbr
					      ,Isnull(nbr_trees_onsite, 0) nbr_trees_onsite
					      ,ISNULL(nbr_trees_offsite, 0) nbr_trees_offsite

					  
					  FROM [srr].[dbo].[tree_info]
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

			</td>
		</TR>
	</TABLe>
	</cfoutput>
</div>
</div>

<br>
<cfquery name="CommentsModule" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.srr_info.srr_id

      ,srr_info.bpw1_ownership_comments
      ,srr_info.bpw1_tax_comments
      ,srr_info.bpw1_comments_to_app

, srr_info.bpw1_internal_comments
, srr_info.bpw2_internal_comments

, srr_info.bca_comments
, srr_info.bss_comments

, srr_info.boe_invest_comments
, srr_info.boe_invest_response_to_app

, gis_comments

FROM  dbo.srr_info
			   
where 
srr_info.srrKey = '#request.srrKey#'


<!--- srr_info.srrKey = '#attributes.srrKey#' --->

<!--- and srr_status.agency = 'bpw1' --->
</cfquery>





	<div align="left">
		<h2>Comments:</h2>
	</div>
	<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<td>


<cfoutput>
<cfif #trim(CommentsModule.bpw1_ownership_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Ownership Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_ownership_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_tax_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Tax Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_tax_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_comments_to_app)# is not "">
<div align="left">
<span class="data"><strong>BPW Comments to Applicant:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_comments_to_app#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw1_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Internal Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw1_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.bca_comments)# is not "">
<div align="left">
<span class="data"><strong>BCA Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bca_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.bss_comments)# is not "">
<div align="left">
<span class="data"><strong>BSS Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bss_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>



<cfif #trim(CommentsModule.boe_invest_comments)# is not "">
<div align="left">
<span class="data"><strong>BOE Investigation Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.boe_invest_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfif #trim(CommentsModule.bpw2_internal_comments)# is not "">
<div align="left">
<span class="data"><strong>BPW Internal Comments:</strong></span>
<cfloop index="xx" list="#CommentsModule.bpw2_internal_comments#" delimiters="|">
<cfoutput>
<p><span class="data">#xx#</span></p>
</cfoutput>
</cfloop>
</div>
</cfif>


<cfquery name="getAppeal" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.appealReason.appealDesc
, dbo.appealReason.suspend
, dbo.appeals.appealDate
, dbo.appeals.appealReason
, dbo.appeals.appealCommentsApp
, dbo.appeals.appealDecision
, dbo.appeals.appealDecisionComments
, dbo.appeals.appealDecision_dt
, dbo.appeals.appealDecision_by
, dbo.srr_info.srr_status_cd
,  dbo.srr_status.srr_status_desc


FROM  dbo.srr_status RIGHT OUTER JOIN
               dbo.srr_info ON dbo.srr_status.srr_status_cd = dbo.srr_info.srr_status_cd RIGHT OUTER JOIN
               dbo.staff RIGHT OUTER JOIN
               dbo.appeals ON dbo.staff.user_id = dbo.appeals.appealDecision_by LEFT OUTER JOIN
               dbo.appealReason ON dbo.appeals.appealReason = dbo.appealReason.appealReason ON dbo.srr_info.srr_id = dbo.appeals.srr_id
			   

where 
srr_info.srrKey = '#request.srrKey#'
<!--- srr_info.srrKey = '#attributes.srrKey#' --->
</cfquery>

<cfloop query="getAppeal">
<cfif #getAppeal.appealDesc# is not "">
<p><span class="data">
<strong>Appealed on:</strong> #dateformat(getAppeal.appealDate,"mm/dd/yyyy")#<br>
<strong>Appeal Desc.:</strong> #getAppeal.appealDesc#<br>
<strong>Applicant Comments:</strong> #getAppeal.appealCommentsApp#<br>

<strong>BOE's Decision:</strong> <cfif #getAppeal.appealDecision# is "a">Approved<cfelseif #getAppeal.appealDecision# is "d">Denied</cfif><br>
<strong>BOE's Appeal Comments:</strong> #getAppeal.appealDecisionComments#<br>
</span>
</p>
</cfif>
</cfloop>

</div>

</cfoutput>
</td>
</tr>
</table>
</div>
</div>

</cfdocument>