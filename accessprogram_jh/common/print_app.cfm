<!--- <cfparam name="request.arKey" >
<cfparam name="attributes.arKey" > --->
<cfparam name="abortflag" default="notabort">
<!--- <cfparam name="request.srrKey" default="LzRn0c4bHOlC4HQOlqdkGWXq0xq9bT6NJdrSLEZCfRgHMUMGV6">
<cfparam name="attributes.srrKey" default="LzRn0c4bHOlC4HQOlqdkGWXq0xq9bT6NJdrSLEZCfRgHMUMGV6"> --->
<!--- default="1NyWhesMv91Ztu9vXuKeaSAXRnFHNFSAAdmqw5lfpWEM4soUPc" ---><!--- default="1NyWhesMv91Ztu9vXuKeaSAXRnFHNFSAAdmqw5lfpWEM4soUPc" --->
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

<cfif not isdefined("request.arKey") or len(#request.arKey#) is not 50>
<!--- <div class="warning">Invalid SRR Key!</div> --->
<cfset message="Invalid SRR Key!">
<cfset abortflag="abort">
<!--- <cfabort> --->
</cfif>


<!--- <cfquery name="validateSRR" datasource="#request.dsn#" dbtype="datasource">
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
 --->
 
 <cfquery name="validateAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
dbo.ar_info.ar_id
, dbo.ar_info.arKey
, dbo.ar_info.sr_number
, dbo.ar_status.ar_status_desc
, ar_info.job_address
, ar_info.ar_status_cd

FROM  dbo.ar_info LEFT OUTER JOIN
               dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd

where 
ar_info.arKey = '#request.arKey#'
</cfquery>

<cfset request.ar_id = #validateAR.ar_id#>
<cfset request.sr_number = #validateAR.sr_number#>
<cfset request.job_address = #validateAR.job_address#>
<cfset request.status_cd = #validateAR.ar_status_cd#>
<cfset request.status_desc = #validateAR.ar_status_desc#>
<!--- <cfif #validateSRR.recordcount# is 0>
<!--- <div class="warning">Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.</div> --->
<cfset message="Could not Find Your Sidewalk Rebate Request!<br><br>Please Contact the Sidewalk Repair Program.">
<cfset abortflag="abort">
<!--- <cfabort> --->
</cfif>
 --->
<cfif #validateAR.recordcount# is 0>
<div class="warning">Could not Find Your Sidewalk Access Request!<br><br>Please Contact the Sidewalk Repair Program.</div>
<cfabort>
</cfif>
 
 
 
 
<!--- 
<cfoutput>
<div align="center">
#validateSRR.sr_number#&nbsp;&nbsp;&nbsp;
#validateSRR.srr_id#&nbsp;&nbsp;&nbsp;
A-Permit Ref. No. #validateSRR.a_ref_no#
</div>

</cfoutput> --->

<cfoutput>
<div align="center">
#validateAr.sr_number#&nbsp;&nbsp;&nbsp;
#validateAr.Ar_id#&nbsp;&nbsp;&nbsp;
<!--- A-Permit Ref. No. #validateAr.a_ref_no# --->
</div>

</cfoutput>












<!--- <cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
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

FROM  dbo.srr_info 			   

where 
srr_info.srrKey = '#request.srrKey#'
</cfquery>
 --->

<cfquery name="findAR" datasource="#request.dsn#" dbtype="datasource">
SELECT 
<!--- dbo.ar_info.ar_id
, dbo.ar_info.ddate_submitted
, dbo.ar_info.sr_number
, dbo.ar_info.app_name_nn

, dbo.ar_info.app_phone_nn
, dbo.ar_info.app_email_nn
, dbo.ar_info.job_address

, dbo.ar_info.ar_status_cd
, dbo.ar_status.ar_status_desc
, dbo.ar_status.agency
, dbo.ar_status.srr_list_order
, dbo.ar_status.suspend
, dbo.ar_info.bpw1_ownership_verified
, ar_info.bpw1_ownership_comments
, dbo.ar_info.bpw1_tax_verified
, ar_info.bpw1_tax_comments
, ar_info.bpw1_internal_comments
, ar_info.bpw1_comments_to_app
, ar_info.hse_nbr
, ar_info.hse_frac_nbr
, ar_info.hse_dir_cd
, ar_info.str_nm
, ar_info.str_sfx_cd
, ar_info.str_sfx_dir_cd
, ar_info.zip_cd
, boe_invest_comments
, ar_info.bpw1_internal_comments
, ar_info.bca_comments
, ar_info.bss_comments

FROM  dbo.ar_info LEFT OUTER JOIN
               dbo.ar_status ON dbo.ar_info.ar_status_cd = dbo.ar_status.ar_status_cd
			    --->

				
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



<cfdocument  format="PDF" pagetype="letter" margintop=".5" marginbottom=".5" marginright=".5" marginleft=".5" orientation="portrait" unit="in" encryption="none" fontembed="Yes" backgroundvisible="No" bookmark="False" localurl="No">

<!--- <cfmodule template="../common/dsp_srTicketInfo.cfm" srrKey = "#request.srrKey#"> --->

<!--- <cfinclude template="../common/validate_srrKey.cfm"> --->

<!--- <cfif #abortflag# is "abort">
	#message#
<cfelse> --->
<!--- 	<cfdocumentitem type="header" evalatprint="true"> 
		<cfinclude template="print_app1_header.cfm">
	</cfdocumentitem>  --->

<!--- 	<cfdocumentitem type="footer" evalatprint="true">
		<cfinclude template="print_app1_footer.cfm">
	</cfdocumentitem> --->

<!--- add javascript validation here --->

<cfquery name="ArInfo" datasource="#request.dsn#" dbtype="datasource">
SELECT 
job_address
, hse_nbr
, hse_frac_nbr
, hse_dir_cd
, str_nm
, str_sfx_cd
, str_sfx_dir_cd
, zip_cd
, unit_range
, app_name_nn
, app_email_nn
, app_phone_nn
, sr_app_comments
, sr_location_comments
, sr_attachments
, sr_mobility_disability
, sr_access_barrier_type
, sr_communication_method
, sr_email
, sr_tty_number
, sr_phone
, sr_video_phone
, from_st
, to_st
, section_id
, tbm_grid
, boe_dist
, council_dist

from Ar_info
where 
arKey = '#request.arKey#'
</cfquery>
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!--- <cfoutput>
#request.srrKey#
</cfoutput> --->


	<cfoutput query="ArInfo">
		<div align="left">
			<h2>SR Number: #request.sr_number# - Ticket Information</h2>
		</div>
		<div style="width:800px;" align="left">
	<table style = "width: 100%;border: 1px solid black;border-collapse: collapse;">
		<tr>
			<th align="left" width="30%">Applicant Name:</th>
			<td width="70%">
			#ArInfo.app_name_nn#
			</td>
		</tr>
		
		<tr>
			<th align="left">Applicant Phone Number:</th>
			<td>
			#ArInfo.app_phone_nn#
			</td>
		</tr>
		
		<tr>
			<th align="left">Applicant Email:</th>
			<td>
			#ArInfo.app_email_nn#
			</td>
		</tr>
		<tr>
			<th align="left">Job Address:</th>
			<td>
			#ArInfo.HSE_NBR# #ArInfo.HSE_FRAC_NBR# #ArInfo.HSE_DIR_CD# #ArInfo.STR_NM# #ArInfo.STR_SFX_CD# #ArInfo.STR_SFX_DIR_CD# #ArInfo.ZIP_CD#
			</td>
		</tr>
<!--- 		<tr>
			<th align="left"><!--- Property Owned by: ---></th>
			<td>
		<!--- 		<cfif #srInfo.prop_owned_by# is "I">
				Individual(s)
				<cfelseif #srInfo.prop_owned_by# is "T">
				Trust
				<cfelseif #srInfo.prop_owned_by# is "B">
				Business/Other
				<cfelseif #srInfo.prop_owned_by# is "M">
				Multiple Owners with an HOA or Management Association
				</cfif> --->
			</td>
		</tr> --->
		<tr>
			<th align="left">Street Name:</th>
			<td>
			#ArInfo.STR_NM#
			</td>
		</tr>
		<tr>
			<th align="left">From:</th>
			<td>
			#ArInfo.from_st#
			</td>
		</tr>
		<tr>
			<th align="left">To:</th>
			<td>
			#ArInfo.to_st#
			</td>
		</tr>
		<tr>
			<th align="left">Section ID:</th>
			<td>
			#ArInfo.section_id#
			</td>
		</tr>
		<tr>
			<th align="left">Thomas Guide:</th>
			<td>
			#ArInfo.tbm_grid#
			</td>
		</tr>		
		
		<tr>
			<th align="left">BOE District:</th>
			<td>
			#ArInfo.boe_dist#
			</td>
		</tr>		
		
		<tr>
			<th align="left">Council District:</th>
			<td>
			#ArInfo.council_dist#
			</td>
		</tr>								
						
		<tr>
			<th align="left">SR Applicant Comments:</th>
			<td>
			#ArInfo.sr_app_comments#
			<!--- <cfif #len(ArInfo.sr_app_comments)# gt 200>
			#insert(ArInfo.sr_app_comments,"<br>",200)#
			#insert(ArInfo.sr_app_comments,"<br>",100)# --->
			<cfset modnum=70><!--- 
			<cfset string=ArInfo.sr_app_comments>
			<cfset stringlen=len(string)>
			<cfset cutoff=0>
			<cfset stringparse="">
			<cfset countvar=0>
			<cfloop condition="countvar LESS THAN stringlen">
				<cfset countvar = countvar + 1>
				<cfset cutoff=countvar mod modnum>
				<cfset stringparse=stringparse&mid(string,countvar,1)>
				<cfif cutoff is 0>
					<cfif (mid(string,countvar-1,1) is not " " or mid(string,countvar+1,1)) is not " ">
						<cfset stringparse=stringparse&"-">
					</cfif>
					<cfset stringparse=stringparse&"<br>">
				</cfif>
			</cfloop>
			#stringparse# --->
			</td>
		</tr>
		<tr>
			<th align="left">SR Location Comments:</th>
			<td>
			
	#ArInfo.sr_location_comments#
			<!--- <cfset string=ArInfo.sr_location_comments>
			<cfset stringlen=len(string)>
			<cfset cutoff=0>
			<cfset stringparse="">
			<cfset countvar=0>
			<cfloop condition="countvar LESS THAN stringlen">
				<cfset countvar = countvar + 1>
				<cfset cutoff=countvar mod modnum>
				<cfset stringparse=stringparse&mid(string,countvar,1)>
				<cfif cutoff is 0>
					<cfif (mid(string,countvar-1,1) is not " " or mid(string,countvar+1,1)) is not " ">
						<cfset stringparse=stringparse&"-">
					</cfif>
					<cfset stringparse=stringparse&"<br>">
				</cfif>
			</cfloop>
			#stringparse#			 --->
			</td>
		</tr>
		
		
		
<!--- 		
		<tr>
<td>SR Applicant Comments</td>
<td>
#arInfo.sr_app_comments#
</td>
</tr>

<tr>
<td>SR Location Comments</td>
<td>
#arInfo.sr_location_comments#
</td>
</tr>
 --->

<tr>
<!--- <td>SR Mobility Disablility</td> --->
	<th align="left">SR Mobility Disablility:</th>
	<td> #arInfo.sr_mobility_disability#</td>
</tr>



<tr>
	<!--- <td>SR Access Barrier Type</td> --->
	<th align="left">SR Access Barrier Type:</th>
	<td> #arInfo.sr_access_barrier_type#</td>
</tr>


<tr>
	<!--- <td>SR Communication Method</td> --->
	<th align="left">SR Communication Method:</th>
	<td> #arInfo.sr_communication_method#</td>
</tr>

<tr>
	<!--- <td>SR Email</td> --->
	<th align="left">SR Email:</th>
	<td> #arInfo.sr_email#</td>
</tr>


<tr>
	<!--- <td>SR TTY Number</td> --->
	<th align="left">SR TTY Number:</th>
	<td> #arInfo.sr_tty_number#</td>
</tr>


<tr>
	<!--- <td>SR Phone</td> --->
	<th align="left">SR Phone:</th>
	<td> #arInfo.sr_phone#</td>
</tr>

<tr>
	<!--- <td>SR Video Phone</td> --->
	<th align="left">SR Video Phone:</th>
	<td> #arInfo.sr_video_phone#</td>
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

<!--- 

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

	 --->
	
	
	
	
	
	<!--- 
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
			<span style="color:maroon;font-weight:bold;font-size:.8em;">#HSE_NBR# #HSE_FRAC_NBR# #HSE_DIR_CD# #STR_NM# #STR_SFX_CD# #STR_SFX_DIR_CD# #UNIT_RANGE# -  #ZIP_CD# </span><br>
		</cfoutput>
		</p>
	</CFIF>
	<!--- <cfdump var="#getOtherAddresses#" output="browser"> --->
	<!--- List other addresses on same parcel if found --->
	<!--- <br><br>	 --->
	<!--- End of Part 2 --->
	
	
	
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
	MALHSENO, MALFRAC, MALDIR, MALSTNAM, MALUNIT, MALCITY, MALZIP, OWNER1, SPECNAM, SPECOWN
	from whse_lupams
	where APN in (#PreserveSingleQuotes(apnList)#)
	and PRCL_OBSLT_CD is null
	order by OWNER1
	</cfquery>
	</td>
	</tr>
</table>
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
	<td>#getOwnerInfo.Owner1#</td>
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
<!--- 	 Zoning Code = <span style="color:maroon;font-weight:bold;">#getAddress.zoningCode#</span><br>
	 <cfif #getAddress.prop_Type# is "R">
	 For Rebate Purpose, Property is considered: <span style="color:maroon;font-weight:bold;">Residential</span><br>
	 <cfelse>
	 For Rebate Purpose, Property is considered: <span style="color:maroon;font-weight:bold;">Commercial/Industrial</span><br>
	 </cfif> --->
			</td>
		</tr>
		</table>
		</div>
	
	 </CFOUTPUT>
	 
	</div>
	</cfif>
</cfif> --->




</cfdocument>