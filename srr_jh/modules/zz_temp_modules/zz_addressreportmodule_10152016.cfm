<style>
.data {
color:maroon;
font-weight:bold;
}

p {
padding-left: 20px;
margin-bottom:0px;
}
</style>
<cfparam name="attributes.hse_id" default="0">
<cfparam name="attributes.hse_nbr" default="">
<cfparam name="attributes.hse_frac_nbr" default="">
<cfparam name="attributes.hse_dir_cd" default="">
<cfparam name="attributes.str_nm" default="">
<cfparam name="attributes.str_sfx_cd" default="">
<cfparam name="attributes.str_sfx_dir_cd" default="">
<cfparam name="attributes.zip_cd" default="">
<cfparam name="attributes.x" default="">
<cfparam name="attributes.y" default="">
<cfparam name="attributes.lat" default="">
<cfparam name="attributes.lon" default="">

<cfif #attributes.hse_nbr# is "" or #attributes.str_nm# is "">
<div class="warning" style="width:450px;">House Number and Street Name are Required!</div>
<cfabort>
</cfif>

<!--- This query will just check if the address exists in BOE address database and get PIN number --->
<cfquery name="getAddress" datasource="navla_spatial" dbtype="datasource">
select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR
<cfif IsNumeric(attributes.hse_id) AND attributes.hse_id neq 0>
where HSE_ID = #attributes.hse_id#
<cfelse>
where HSE_NBR = #attributes.hse_nbr# and STR_NM = '#attributes.str_nm#' 
<cfif attributes.hse_frac_nbr NEQ "">
and HSE_FRAC_NBR = '#attributes.hse_frac_nbr#'
</cfif>
<cfif attributes.hse_dir_cd NEQ "">
and HSE_DIR_CD = '#attributes.hse_dir_cd#'
</cfif>

<cfif attributes.str_sfx_cd NEQ "">
and STR_SFX_CD = '#attributes.str_sfx_cd#'
</cfif>
<cfif attributes.str_sfx_dir_cd NEQ "">
and STR_SFX_DIR_CD = '#attributes.str_sfx_dir_cd#'
</cfif>
<cfif attributes.zip_cd NEQ "">
and ZIP_CD = '#attributes.zip_cd#'
</cfif>
</cfif>
and EXIST_STTS_CD Is Null
</cfquery>
    <!--- This query will just check if the address exists in BOE address database and get PIN number --->

<!--- Address Search Results --->
<!--- <cfdump var="#getAddress#" metainfo="no">
<br /><br /> --->


<div align="center">

<div class="textbox" style="width:450px;padding-left:10px;">
<h1>Property Information:</h1>
<p>
The Service Request Address:<br>
<cfoutput>
<cfif #getAddress.recordcount# is 0><!--- Address does not exist in BOE address database --->
<span class="data">#attributes.HSE_NBR# #attributes.HSE_FRAC_NBR# #attributes.HSE_DIR_CD# #attributes.STR_NM# #attributes.STR_SFX_CD# #attributes.STR_SFX_DIR_CD# #attributes.ZIP_CD#</span>
<br><br>
<span style="color:red;">The above address was not found in BOE Official Addresses. Applicant need to go to the address counter at any of the Engineering Districts with proof that this is a valid address and the counter will add this address to BOE's database. </span>
<cfabort><!--- Stop if address does not exist --->
<cfelse><!--- Address Exists, display info as it comes of the database for addresses --->
<span class="data">#getAddress.HSE_NBR# #getAddress.HSE_FRAC_NBR# #getAddress.HSE_DIR_CD# #getAddress.STR_NM# #getAddress.STR_SFX_CD# #getAddress.STR_SFX_DIR_CD# #getAddress.ZIP_CD#</span>
<br>
<span class="data">Address is valid.</span>
<br>PIN: <span class="data">#getAddress.PIN#</span>
</p>
</cfif>

</cfoutput><!--- End of part 1 - Address verification --->


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
<span class="data">#HSE_NBR# #HSE_FRAC_NBR# #HSE_DIR_CD# #STR_NM# #STR_SFX_CD# #STR_SFX_DIR_CD# #UNIT_RANGE# -  #ZIP_CD# </span><br>
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


<p>
<h1>Owner(s) Information</h1>
<table border="1"  class = "datatable" style = "width:450px;font-size:12px;">
<tr>
<th>APN</th>
<th>Owner</th>
<th>Mailing Address</th>

</tr>
<cfoutput query="getOwnerInfo">
<tr>
<td>#getOwnerInfo.APN#</td>
<td>#getOwnerInfo.Owner1#</td>
<td>
#getOwnerInfo.MALHSENO# #getOwnerInfo.MALFRAC# #getOwnerInfo.MALDIR# #getOwnerInfo.MALSTNAM# #getOwnerInfo.MALUNIT#<br>
#getOwnerInfo.MALCITY#, #getOwnerInfo.MALZIP#
</td>
</tr>
</CFOUTPUT>
</table>
</p>
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
<cfoutput>
<p>
<span style="color:red;font-weight:bold;">This Address is associated with a lot that has #getOtherParcels.recordcount# parcels.  Use <a href="http://boemaps.eng.ci.la.ca.us/navigatela/" target="_blank">Navigate LA</a> for further investigation.</span><br><br>
The following are the Parcel ID Numbers associated with this lot:<br>
<cfloop query="getOtherParcels"><a href="http://boemaps.eng.ci.la.ca.us/navigatela/?apn=#getAPN.APN#" target="_blank">#getOtherParcels.PIN#</a>,&nbsp;&nbsp;</cfloop>
</p>
</cfoutput>
</cfif>
</cfif>
<!-- This portion will check if the address is part of a lot consisting of several parcels. -->



<!--- <cfquery name="getOtherAddress" datasource="navla_spatial">
select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR

where PIN = '#getAddress.pin#'
</cfquery>

<cfdump var="#getOtherAddress#" output="browser"> --->



<!--- <cfoutput>
select APN, SITHSENO, SITFRAC, SITDIR, SITSTNAM, SITUNIT, SITCITY, SITZIP,
MALHSENO, MALFRAC, MALDIR, MALSTNAM, MALUNIT, MALCITY, MALZIP, OWNER1, SPECNAM, SPECOWN
from whse_lupams
where APN in (#PreserveSingleQuotes(apnList)#)
and PRCL_OBSLT_CD is null
order by OWNER1
</cfoutput> --->





<cfquery name="getZoning" datasource="navla_spatial"  dbtype="datasource">
SELECT  [OBJECTID]
      ,[PIND]
      ,[ZONE_CMPLT] as zoningCode
  FROM [navla_spatial].[dbo].[dcp_zoning_pin]
  
  where pind = '#getAddress.pind#'
  </cfquery>

 
<!---  <cfdump var="#getZoning#" output="browser"><br><br> --->
 
 <cfset request.zoningCode = #getZoning.zoningCode#>
 
 <cfset request.zoningCode=ReplaceNoCase("#request.zoningCode#","(T)","","ALL")>
<cfset request.zoningCode=ReplaceNoCase("#request.zoningCode#","(F)","","ALL")>
<cfset request.zoningCode=ReplaceNoCase("#request.zoningCode#","(Q)","","ALL")>
<cfset request.zoningCode=ReplaceNoCase("#request.zoningCode#","[Q]","","ALL")>
 <cfset request.zoningCode=ReplaceNoCase("#request.zoningCode#","[T]","","ALL")>
 
 <cfset zcLen = len(#request.zoningCode#)>
 
 <cfif left(#request.zoningCode#, 1) is "Q">
 <cfset request.zoningCode = right(#zoningCode#, (#zcLen# - 1))>
 </cfif>
 


 <cfif left(#request.zoningCode#, 1) is "R" or left(#request.zoningCode#, 2) is "OS" or left(#request.zoningCode#, 2) is "A">
 <cfset request.propZoning = "R">
 <cfelse>
  <cfset request.propZoning = "C">
 </cfif>
  <Cfoutput>
  
  <h1>Zoning</h1>
  <p>
 Zoning Code = <span class="data">#request.zoningCode#</span><br>
 <cfif #request.propZoning# is "R">
 For Rebate Purpose, Property is considered: <span class="data">Residential</span><br>
 <cfelse>
 For Rebate Purpose, Property is considered: <span class="data">Commercial/Industrial</span><br>
 </cfif>
 </p>
 </CFOUTPUT>
 
</div>
			
			
</div>
		
