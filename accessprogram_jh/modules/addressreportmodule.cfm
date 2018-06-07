<!--- <cfinclude template="../common/validate_arKey.cfm">

<cfparam name="attributes.arKey" default="#request.arKey#">
<cfparam name="attributes.width" default="350px">

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

<cfquery name="getAddress" datasource="#request.dsn#" dbtype="datasource">
select 
<!--- HSE_ID --->
ar_id
, sr_number
, job_address
<!--- , address_verified --->
, bpp
, PIN
, PIND
, zoningCode
<!--- , prop_type --->

, HSE_NBR
, HSE_FRAC_NBR
, HSE_DIR_CD, STR_NM
, STR_SFX_CD
, STR_SFX_DIR_CD
, UNIT_RANGE
, ZIP_CD
, X_COORD
, Y_COORD
<!--- , ASGN_STTS_IND --->
<!--- , ENG_DIST
, CNCL_DIST --->
,[longitude]
      ,[latitude]

from ar_info
where arKey = '#attributes.arKey#'


</cfquery>
<cfoutput> 

<div align="center">

<div class="formbox" style="width:#attributes.width#;">
<h1>Property Information:</h1>
<p>
<strong>The Service Request Address:</strong><br>

<!--- <span class="data">#ucase(getAddress.job_address)#</span><br>
<cfif #getAddress.address_verified# is "Y">
<span class="data">Address is Valid</span>
<Cfelse>
<span class="data">Address is NOT Valid</span>
</cfif> --->



<!--- <cfif #getAddress.recordcount# is 0><!--- Address does not exist in BOE address database --->
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
</cfif> --->


</cfoutput>
<!--- End of part 1 - Address verification --->
<!--- 12072016 --->
<!--- <cfif #getAddress.address_verified# is "Y">

<!--- Part 2: Use the PIN to identify any other addresses associated with the same parcel --->
<cfquery name="getOtherAddresses" datasource="navla_spatial"  dbtype="datasource">
select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR

where PIN = '#getAddress.pin#'
</cfquery>
 --->

<!--- List other addresses on same parcel if found --->
<!--- <Cfif #getOtherAddresses.recordcount# gt 1>
<p>
<strong>The following address(es) are located on the same parcel:</strong><br>
<cfoutput query="getOtherAddresses">
<span class="data">#getOtherAddresses.HSE_NBR# #getOtherAddresses.HSE_FRAC_NBR# #getOtherAddresses.HSE_DIR_CD# #getOtherAddresses.STR_NM# #getOtherAddresses.STR_SFX_CD# #getOtherAddresses.STR_SFX_DIR_CD# #getOtherAddresses.UNIT_RANGE# -  #getOtherAddresses.ZIP_CD# </span><br>
</cfoutput>
</p>
</CFIF> --->
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


<h1>Owner(s) Information</h1>
<table border="1"  class = "datatable" style = "width:97%;font-size:12px;">
<tr>
<th>APN</th>
<th>Owner</th>
<th>Mailing Address</th>

</tr>
<cfoutput query="getOwnerInfo">
<cfquery name="checkLiens" datasource="form9_sql" dbtype="datasource">
SELECT dbo.apn.bpp, dbo.apn.reason, dbo.reason_codes.reason_text
FROM  dbo.apn LEFT OUTER JOIN
               dbo.reason_codes ON dbo.apn.reason = dbo.reason_codes.reason
where apn.bpp = '#getOwnerInfo.APN#'
</cfquery>
<tr>
<td>
#getOwnerInfo.APN#
<cfif #checkLiens.recordcount# is 0>
<br>No Liens
<cfelse>
<span style="color:red;font-weight:bold;"><br>Has Lien(s)</span>
</cfif>
</td>
<td>#getOwnerInfo.Owner1#</td>
<td>
#getOwnerInfo.MALHSENO# #getOwnerInfo.MALFRAC# #getOwnerInfo.MALDIR# #getOwnerInfo.MALSTNAM# #getOwnerInfo.MALUNIT#<br>
#getOwnerInfo.MALCITY#, #getOwnerInfo.MALZIP#
</td>
</tr>

<cfif #checkLiens.recordcount# is not "0">
<tr>
<td colspan="3">
<cfloop query="checkLiens"><span style="color:red;font-weight:bold;">#checkLiens.reason_text#</span><br></cfloop>
</td>
</tr>
</cfif>
</CFOUTPUT>
</table>

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
<cfloop query="getOtherParcels">#getOtherParcels.PIN#,&nbsp;&nbsp;</cfloop>
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





<!--- <cfquery name="getZoning" datasource="navla_spatial"  dbtype="datasource">
SELECT  [OBJECTID]
      ,[PIND]
      ,[ZONE_CMPLT] as zoningCode
  FROM [navla_spatial].[dbo].[dcp_zoning_pin]
  
  where pind = '#getAddress.pind#'
  </cfquery> --->

 
<!---  <cfdump var="#getZoning#" output="browser"><br><br> --->
 
<!---  <cfset request.zoningCode = #getZoning.zoningCode#>
 
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
 </cfif> --->
  <Cfoutput>
  
  <h1>Zoning</h1>
  <p>
 Zoning Code = <span class="data">#getAddress.zoningCode#</span><br>
 <cfif #getAddress.prop_Type# is "R">
 For Rebate Purpose, Property is considered: <span class="data">Residential</span><br>
 <cfelse>
 For Rebate Purpose, Property is considered: <span class="data">Commercial/Industrial</span><br>
 </cfif>
 </p>
 </CFOUTPUT>
 
</div>
			
			
</div>
 --->

<!--- </cfif>
 --->