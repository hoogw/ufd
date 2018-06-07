
<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfif not isdefined("request.hse_nbr") or #request.hse_nbr# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="House Number is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfif not isdefined("request.str_nm") or #request.str_nm# is "">
<cfmodule template="/srr/common/error_msg.cfm" error_msg="Street Name is Required!" showBackButton="1">
<cfabort>
</cfif>

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->




<cfquery name="update_record" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
Set
hse_nbr='#left(trim(request.hse_nbr),15)#',
<!---hse_frac_nbr='#left(trim(Ucase(request.hse_frac_nbr)),10)#',
hse_dir_cd='#left(trim(Ucase(request.hse_dir_cd)),100)#',--->
str_nm='#left(trim(Ucase(request.str_nm)),60)#'
<!---str_sfx_cd='#left(trim(Ucase(request.str_sfx_cd)),50)#',
str_sfx_dir_cd='#left(trim(Ucase(request.str_sfx_dir_cd)),15)#',

job_city='#left(trim(Ucase(request.job_city)),30)#',
job_zip='#left(trim(request.job_zip),12)#',
job_address='#left(Ucase(job_address),100)#',
boe_dist='#left(Ucase(request.boe_dist),1)#',

address_verified=0,
job_location_screen=1--->
where srr_id=#request.srr_id#
</cfquery>


<cfset request.hn=#trim(request.hse_nbr)#>
<cfset request.hs=#trim(request.str_nm)#>

<cfinclude template="../common/cleanup_hs.cfm">



<cfquery name="get_address" datasource="navla_spatial" dbtype="datasource">
SELECT 
LA_HSE_NBR.HSE_ID
, LA_HSE_NBR.PIN
, LA_HSE_NBR.HSE_NBR
, LA_HSE_NBR.HSE_FRAC_NBR
, LA_HSE_NBR.HSE_DIR_CD
, LA_HSE_NBR.STR_NM
, LA_HSE_NBR.STR_SFX_CD
, LA_HSE_NBR.STR_SFX_DIR_CD
, LA_HSE_NBR.UNIT_RANGE
, LA_HSE_NBR.ZIP_CD
, LA_HSE_NBR.X_COORD_NBR
, LA_HSE_NBR.Y_COORD_NBR
, LA_HSE_NBR.ASGN_STTS_IND
, LA_HSE_NBR.ENG_DIST
, LA_HSE_NBR.CNCL_DIST
, LA_HSE_NBR.CRTN_DT
, LA_HSE_NBR.LST_MODF_DT
, LA_HSE_NBR.SYS_USER_ID
, LA_HSE_NBR.EXIST_STTS_CD
, LA_HSE_NBR.LON
, LA_HSE_NBR.LAT
, LA_HSE_NBR.PIND
, LA_APN.BPP

FROM  dbo.LA_HSE_NBR LEFT OUTER JOIN
               dbo.LA_APN ON dbo.LA_HSE_NBR.PIN = dbo.LA_APN.PIN
			   
WHERE
LA_HSE_NBR.HSE_NBR = #request.HN# 
AND 
LA_HSE_NBR.STR_NM = '#Ucase(request.HS)#'
<!--- and
LA_HSE_NBR.EXIST_STTS_CD is null --->

</cfquery>

<cfif #get_address.pind# is not "">
<CFQUERY NAME="get_zone" DATASOURCE="navla_spatial">
		select zone_cmplt 
		from pin_zone 
		where pin = '#get_address.pind#'
</CFQUERY>
</cfif>



<!--- <cfset access=1>
</cfcatch>
</cftry> --->
<!-- End of Oracle query --->

<!-- Address was not found based on house number and street name -->
<Cfif #get_address.recordcount# is 0>
<cfoutput>
<cfinclude template="../common/no_matching_address_msg.cfm">
<div align="center"><input type="button" name="nomatch" id="nomatch" value="Add Address - Will Upload Docs" class="submit" onClick="location.href = 'control.cfm?action=add_job_location2&srr_id=#request.srr_id#&#request.addtoken#'"><input type="button" name="tryAgain" id="tryAgain" value="Try Again" class="submit" onClick="location.href = 'control.cfm?action=get_job_location1&srr_id=#request.srr_id#&#request.addtoken#'"><input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'"></div>
</cfoutput>
<cfabort>
</cfif>
<!-- Address was not found based on house number and street name -->


<!-- Address Found based on house number and street name -->
<div align="center">
<span class="subtitle">Please Click <strong>Select</strong> next to the address that matches your property address</span>
<br>
<table align="center" class="datatable" id="table1" style="width:75%;">
<TR>
<th>Address</th>
<th>Zip Code</th>
<th>BOE Dist.</th>
<th>Council Dist.</th>
<th>APN<br>(Assessor Parcel Number)</th>
<th>PIN<br>(Parcel Identification Number)</th>
<th>Zoning</th>
<th>Action</th>
</tr>


<cfset x=1>

<cfoutput query="get_address">
<cfif (#x# mod 2) is 0>
<tr class = "alt">
<cfelse>
<tr>
</cfif>


<cfset job_address=#get_address.hse_nbr#>
<cfif #trim(get_address.hse_frac_nbr)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.hse_frac_nbr)#>
</cfif>
<cfif #trim(get_address.hse_dir_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.hse_dir_cd)#>
</cfif>
<cfif #trim(get_address.str_nm)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.str_nm)#>
</cfif>
<cfif #trim(get_address.str_sfx_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.str_sfx_cd)#>
</cfif>

<cfif #trim(get_address.STR_SFX_DIR_CD)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.STR_SFX_DIR_CD)#>
</cfif>

<cfif #trim(get_address.unit_range)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.unit_range)#>
</cfif>

<td>
<a href="http://navigatela.lacity.org/navigatela/?search=#URLEncodedFormat(job_address)#" target="_blank">#trim(job_address)#</a>
</td>

<td style="text-align:center;">
#Zip_cd#
</td>


<td style="text-align:center;">
#eng_dist#&nbsp;
</td> 

<td style="text-align:center;">
#cncl_dist#&nbsp;
</td> 

<td style="text-align:center;">
#bpp#&nbsp;
</td> 

<td style="text-align:center;">
#pind#&nbsp;
</td> 
<td style="text-align:center;">

<cfif #get_address.pind# is not "" and #get_zone.recordcount# is not 0>
#get_zone.zone_cmplt#
</cfif>
</td>

<td style="text-align:center;">
<a href="control.cfm?action=get_job_location3&update=1&hse_id=#get_address.hse_id#&srr_id=#request.srr_id#&#request.addtoken#"><strong>Select</strong></a>
</td> 

</tr>
<cfset x=#x#+1>
</cfoutput>
</table>
Clicking on Address will display the property location and will provide access to more reports.
</div>

<cfoutput>
<div align="center"><input type="button" name="nomatch" id="nomatch" value="No Matching Address" class="submit" onClick="location.href = 'control.cfm?action=add_job_location1&srr_id=#request.srr_id#&#request.addtoken#'"><input type="button" name="tryAgain" id="tryAgain" value="Try Again" class="submit" onClick="location.href = 'control.cfm?action=get_job_location1&srr_id=#request.srr_id#&#request.addtoken#'"><input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'"></div>
<br><br>
<div class="textbox" style="width:700px;">
<h1>Instructions</h1>
If none of the listed addresses matches your property address, please click No Matching Address.  This will allow you to add an address manually.
</div>
</cfoutput>