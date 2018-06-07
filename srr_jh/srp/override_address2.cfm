<cfinclude template="../common/validate_SrrKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfquery name="get_address" datasource="navla_spatial" dbtype="datasource">
select top 5000
HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR
WHERE
(1=1)
and EXIST_STTS_CD is null

<cfif #request.hse_nbr# is not "">
and
HSE_NBR = #trim(request.hse_nbr)# 
</cfif>
AND 
STR_NM like '%#Ucase(trim(request.str_nm))#%'
order by hse_nbr, str_nm
</cfquery>


<div class="formbox" style="width:730px;">
<h1>Address(es) Found</h1>
<div class="warning" style="text-align:left;">Clicking the Select option will:<br>
Overwrite the address for this application.<br>
Reset ownership, liens, maximum rebate amount<br>
and finally it will send the application to the Board of Public Works queue.<br>
Please click once on Select and allow 30 seconds.
</div>
<table border="1"  class = "formtable" style = "width: 100%;">
<tr>
<th>Address</th>
<th>Action</th>
<th>View on Google Maps</th>
</tr>
<cfoutput query="get_address">
<tr>
<td>
#get_address.hse_nbr# 
#get_address.HSE_FRAC_NBR# 
#get_address.HSE_DIR_CD# 
#get_address.STR_NM# 
#get_address.STR_SFX_CD# 
#get_address.STR_SFX_DIR_CD# 
#get_address.UNIT_RANGE# 
#get_address.ZIP_CD#
</td>

<td align="center"><a href="control.cfm?action=override_address3&srrKey=#request.srrKey#&HSE_ID=#hse_id#&#request.addtoken#">Select</a></td>

<td align="center"><a href="https://www.google.com/maps/place/#get_address.hse_nbr#+#get_address.STR_NM# +#get_address.STR_SFX_CD# +-+#get_address.ZIP_CD# " target="_blank">View</a></td>
</tr>
</cfoutput>
</table>
</div>


