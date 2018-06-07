<cfinclude template="/apermits/common/html_top.cfm">
<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfinclude template="../common/dsp_ref_no.cfm">

<cfif #form.hse_nbr# is "" or #form.str_nm# is "">
<div align = "center"><font color="red">
<b>
You must provide a House Number and Street to verify your property address.
</b>
</font></div>
<br><br><div align = "center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfif>

<cfif not isnumeric(#form.hse_nbr#)>
<cfoutput>
<div align="center"><font color="red">
<b>Invalid House Number (must be a number)</b>
</FONT></div>
<div align = "center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
</cfoutput>
<cfabort>
</cfif>

<!---<cfif #form.boe_dist# is "">
<div align = "center"><font color="red">
<b>
YOU MUST SELECT AN ENGINEERING DISTRICT
</b>
</font></div>
<br><br><div align = "center">
<FORM METHOD="post">
<input type="button" value="Back" OnClick="history.go( -1 );return true;" class = "submit">
</form>
</div>
<cfabort>
</cfif>--->

<!---<cfset job_address=#trim(form.hse_nbr)#>

<cfif #trim(form.hse_frac_nbr)# is not "">
<cfset job_address=#job_address#&" "&#trim(form.hse_frac_nbr)#>
</cfif>

<cfif #trim(form.hse_dir_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(form.hse_dir_cd)#>
</cfif>

<cfif #trim(form.str_nm)# is not "">
<cfset job_address=#job_address#&" "&#trim(form.str_nm)#>
</cfif>

<cfif #trim(form.str_sfx_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(form.str_sfx_cd)#>
</cfif>

<cfif #trim(form.str_sfx_dir_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(form.str_sfx_dir_cd)#>
</cfif>--->


<cfquery name="update_record" datasource="#request.dsn#" dbtype="datasource">
Update permit_info
Set
hse_nbr='#left(trim(form.hse_nbr),15)#',
<!---hse_frac_nbr='#left(trim(Ucase(form.hse_frac_nbr)),10)#',
hse_dir_cd='#left(trim(Ucase(form.hse_dir_cd)),100)#',--->
str_nm='#left(trim(Ucase(form.str_nm)),60)#'
<!---str_sfx_cd='#left(trim(Ucase(form.str_sfx_cd)),50)#',
str_sfx_dir_cd='#left(trim(Ucase(form.str_sfx_dir_cd)),15)#',

prop_city='#left(trim(Ucase(form.prop_city)),30)#',
job_zip='#left(trim(form.job_zip),12)#',
job_address='#left(Ucase(job_address),100)#',
boe_dist='#left(Ucase(form.boe_dist),1)#',

address_verified=0,
job_location_screen=1--->
where ref_no=#request.ref_no#
</cfquery>


<cfset request.hn=#trim(form.hse_nbr)#>
<cfset request.hs=#trim(form.str_nm)#>

<cfinclude template="../common/cleanup_hs.cfm">


<!--- <cftry> --->
<!-- searching the Oracle database  -->
<!--- <cfquery name="get_address" datasource="db2_ita">
SELECT      ENG.LA_HSE_NBR.*, ENG.LA_APN.BPP
FROM         ENG.LA_APN, ENG.LA_HSE_NBR
WHERE       ENG.LA_HSE_NBR.HSE_NBR = #request.HN# AND ENG.LA_HSE_NBR.STR_NM LIKE '#Ucase(request.HS)#%' and ENG.LA_APN.PIN (+) = ENG.LA_HSE_NBR.PIN
</cfquery>
<cfset access=0>
<cfcatch type="Any"> --->



<!--- <cfquery name="get_address" datasource="la_addresses_sql" dbtype="datasource">
SELECT ENG_LA_HSE_NBR.*, ENG_LA_APN.BPP
FROM ENG_LA_APN RIGHT JOIN ENG_LA_HSE_NBR ON ENG_LA_APN.PIN = ENG_LA_HSE_NBR.PIN
WHERE
ENG_LA_HSE_NBR.HSE_NBR = #request.HN# AND ENG_LA_HSE_NBR.STR_NM = '#Ucase(request.HS)#'
</cfquery> --->



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

FROM  LA_HSE_NBR LEFT OUTER JOIN
               LA_APN ON LA_HSE_NBR.PIN = LA_APN.PIN
WHERE
LA_HSE_NBR.HSE_NBR = #request.HN# AND LA_HSE_NBR.STR_NM = '#Ucase(request.HS)#'
</cfquery>


<!--- <cfset access=1>
</cfcatch>
</cftry> --->
<!-- End of Oracle query --->

<!-- Address was not found based on house number and street name -->
<Cfif #get_address.recordcount# is 0>
<cfoutput>
<cfinclude template="../common/no_matching_address_msg.cfm">
</cfoutput>
<cfabort>
</cfif>
<!-- Address was not found based on house number and street name -->


<!-- Address Found based on house number and street name -->
<div align="center">
<span class="subtitle">Please Click <strong>Select</strong> next to the address that matches your property address</span>
<br><br>
<table align="center" class="datatable" id="table1" style="width:75%;">
<TR>
<th>Address</th>
<th>BOE Dist.</th>
<th>Council Dist.</th>
<th>APN<br>(Assessor Parcel Number)</th>
<th>PIN<br>(Parcel Identification Number)</th>
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
#trim(job_address)#
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
<a href="edit_job_location3.cfm?update=1&hse_id=#get_address.hse_id#&permit_type=#request.permit_type#&ref_no=#request.ref_no#&#request.addtoken#"><strong>Select</strong></a>
</td> 

</tr>
<cfset x=#x#+1>
</cfoutput>
</table>
</div>

<cfoutput>
<br>
<div align="center">If none of the listed addresses matches your property address, please click No Matching Address</div>
<br>
<div align="center"><input type="button" name="nomatch" id="nomatch" value="No Matching Address" class="submit" onClick="location.href = 'no_match1.cfm?ref_no=#request.ref_no#&permit_type=#request.permit_type#&#request.addtoken#'"></div>




</cfoutput>

<cfinclude template="/apermits/common/html_bottom.cfm">
