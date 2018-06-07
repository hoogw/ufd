<cfinclude template="../common/validate_srrKey.cfm">

<cfinclude template="../common/myCFfunctions.cfm">

<cfif not isdefined("request.hse_id") or #request.hse_id# is "">
<div class="warning">
Invalid Request!
</div>
<cfabort>
</cfif>

<cfquery name="checkAddress" datasource="navla_spatial" dbtype="datasource">
select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR
Where

hse_id = #request.hse_id#
</cfquery>

<cfif #checkAddress.recordcount# is 0><!-- Invalid Address -->
<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info

set 
address_verified = 'N'
, prop_data_checked = 'Y'
where srr_id = #request.srr_id#
</cfquery>

<div class="warning">
<p>Address was not found in BOE Address database.</p>
<br>
<p>Please try at a later time ...</p>
</div>
<cfabort>
</cfif>

<cfif #checkAddress.recordcount# is not 0><!-- Valid Address --><!--- 1 --->

<cfset request.job_address = #checkAddress.hse_nbr#>
<cfif #checkAddress.hse_frac_nbr# NEQ "">
<cfset request.job_address = #request.job_address#&" "&#checkAddress.hse_frac_nbr#>
</cfif>

<cfif #checkAddress.hse_dir_cd# NEQ "">
<cfset request.job_address = #request.job_address#&" "&#checkAddress.hse_dir_cd#>
</cfif>

<cfif #checkAddress.str_nm# NEQ "">
<cfset request.job_address = #request.job_address#&" "&#checkAddress.str_nm#>
</cfif>

<cfif #checkAddress.str_sfx_cd# NEQ "">
<cfset request.job_address = #request.job_address#&" "&#checkAddress.str_sfx_cd#>
</cfif>

<cfif #checkAddress.str_sfx_dir_cd# NEQ "">
<cfset request.job_address = #request.job_address#&" "&#checkAddress.str_sfx_dir_cd#>
</cfif>

<cfif #checkAddress.zip_cd# NEQ "">
<cfset request.job_address = #request.job_address#&" - "&#checkAddress.zip_cd#>
</cfif>

</cfif>

<!--- <cfoutput>
#request.job_address#
</cfoutput>

<cfabort> --->

<cfquery name="updateHistory" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
record_history = isnull(record_history, '') + '|Address was updated:  Old Address: '+job_address+' New Address: #request.job_address# on #dateformat(Now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'

, HSE_ID = #checkAddress.HSE_ID#
, PIN = '#checkAddress.PIN#'
, PIND = '#checkAddress.PIND#'
, HSE_NBR = '#checkAddress.HSE_NBR#'
, HSE_FRAC_NBR = '#checkAddress.HSE_FRAC_NBR#'
, HSE_DIR_CD = '#checkAddress.HSE_DIR_CD#'
, STR_NM = '#checkAddress.STR_NM#'
, STR_SFX_CD = '#checkAddress.STR_SFX_CD#'
, STR_SFX_DIR_CD = '#checkAddress.STR_SFX_DIR_CD#'
, UNIT_RANGE = '#checkAddress.UNIT_RANGE#'
, ZIP_CD = '#checkAddress.ZIP_CD#'
, [x_coord] = #checkAddress.X_COORD_NBR#
, [y_coord] = #checkAddress.Y_COORD_NBR#
, boe_dist = '#checkAddress.ENG_DIST#'
, council_dist = '#checkAddress.CNCL_DIST#'
, [longitude] = #checkAddress.LON#
, [latitude] = #checkAddress.LAT#
, job_address = '#request.job_address#'
, address_verified = 'Y'
, prop_data_checked = 'Y'

, boe_invest_comments = isnull(boe_invest_comments, '') + '|Address was validated by BOE staff, please continue to process application (#client.full_name# - #dateformat(now(),"mm/dd/yyyy")#).'

where srrKey = '#request.srrKey#'
</cfquery>

<!--- <cfquery name="readHouse" datasource="#request.dsn#" dbtype="datasource">
select 
srr_id
, hse_id
, hse_nbr
, hse_frac_nbr
, hse_dir_cd
, str_nm
, str_sfx_cd
, str_sfx_dir_cd
, zip_cd

from srr_info
where srrKey = '#request.srrKey#'
</cfquery> --->

<!--- <cfquery name="checkAddress" datasource="navla_spatial" dbtype="datasource">
select HSE_ID, PIN, PIND, HSE_NBR, HSE_FRAC_NBR, HSE_DIR_CD, STR_NM, STR_SFX_CD, STR_SFX_DIR_CD, UNIT_RANGE, ZIP_CD, 
X_COORD_NBR, Y_COORD_NBR, ASGN_STTS_IND, ENG_DIST, CNCL_DIST, LON, LAT
from LA_HSE_NBR
Where (1=1)
<cfif #readHouse.hse_nbr# is not "" and #readHouse.str_nm# is not "">
and HSE_NBR = #readHouse.hse_nbr# and STR_NM = '#readHouse.str_nm#' 
</cfif>

<cfif readHouse.hse_frac_nbr NEQ "">
and HSE_FRAC_NBR = '#readHouse.hse_frac_nbr#'
</cfif>

<cfif readHouse.hse_dir_cd NEQ "">
and HSE_DIR_CD = '#readHouse.hse_dir_cd#'
</cfif>

<cfif readHouse.str_sfx_cd NEQ "">
and STR_SFX_CD = '#readHouse.str_sfx_cd#'
</cfif>

<cfif readHouse.str_sfx_dir_cd NEQ "">
and STR_SFX_DIR_CD = '#readHouse.str_sfx_dir_cd#'
</cfif>

<cfif readHouse.zip_cd NEQ "">
and ZIP_CD = '#readHouse.zip_cd#'
</cfif>

and EXIST_STTS_CD Is Null
</cfquery> --->



<cfif #checkAddress.pin# is not "">
<cfquery name="getTBM" datasource="navla_spatial" dbtype="datasource">
SELECT  [PIN]
      ,[TBM_PAGE]
      ,[TBM_ROW]
      ,[TBM_COLUMN]
      ,[CRTN_DT]
      ,[LST_MODF_DT]
      ,[PIND]
  FROM [dbo].[PCIS_tbm_grid]
</cfquery>
<cfset request.tbm_grid = #getTBM.TBM_page#&" "&#getTBM.TBM_row#&" "&#getTBM.TBM_column#>
<cfelse>
<cfset request.tbm_grid = "">
</cfif>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info

set 
tbm_grid = '#toSqlText(request.tbm_grid)#'
where srrKey = '#request.srrKey#'
</cfquery>

<cfif #checkAddress.pin# is not ""><!--- 2 --->
<cfquery name="getAPN" datasource="navla_spatial" dbtype="datasource">
select PIN, BPP
from LA_APN
where PIN = '#checkAddress.pin#'
and exist_stts_cd is null
</cfquery>
<cfif #getAPN.recordCount# is 1><!--- 3 --->
<cfquery name="checkLiens" datasource="form9_sql" dbtype="datasource">
SELECT dbo.apn.bpp, dbo.apn.reason, dbo.reason_codes.reason_text
FROM  dbo.apn LEFT OUTER JOIN
               dbo.reason_codes ON dbo.apn.reason = dbo.reason_codes.reason
where apn.bpp = '#getAPN.bpp#'
</cfquery>

<cfif #checkLiens.recordcount# is 0>
<cfset request.anyLiens = "N">
<cfset request.LiensText = "">
<cfelse>
<cfset request.anyLiens = "Y">
<cfset request.LiensText = #checkLiens.reason_text#>
</cfif>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
bpp = '#getAPN.bpp#'
, anyLiens = '#request.anyLiens#'
, LiensText = '#request.liensText#'

where srrKey = '#request.srrKey#'
</cfquery>
<cfelse><!--- 3    multiple apn found--->
<cfset apnList = #ValueList(getAPN.bpp)#>
<cfset apnList = #listQualify(apnList, "'")#>
<cfquery name="checkLiens" datasource="form9_sql" dbtype="datasource">
SELECT dbo.apn.bpp, dbo.apn.reason, dbo.reason_codes.reason_text
FROM  dbo.apn LEFT OUTER JOIN
               dbo.reason_codes ON dbo.apn.reason = dbo.reason_codes.reason
where apn.bpp in  (#listQualify(apnList, "'")#)
</cfquery>

<cfif #checkLiens.recordcount# is 0>
<cfset request.anyLiens = "N">
<cfset request.LiensText = "">
<cfelse>
<cfset request.anyLiens = "Y">
<cfset request.LiensText = #ValueList(checkLiens.reason_text)#>
</cfif>


<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
bpp = 'Multiple'
, anyLiens = '#request.anyLiens#'
, LiensText = '#request.liensText#'

where srrKey = '#request.srrKey#'
</cfquery>
</cfif><!--- 3 --->

<cfif #checkAddress.pind# is not ""><!-- 4 -->
<cfquery name="getZoning" datasource="navla_spatial" dbtype="datasource">
SELECT 
      PIN
	  , [PIND]
      ,[ZONE_CMPLT] as zoningCode
	  
  FROM dcp_zoning_pin
  
  where 
  pin = '#checkAddress.pin#'
  </cfquery>
  
<!---   <cfdump var="#getZoning#" output="browser"> --->
  
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
 <cfset request.prop_type = "R">
 <cfelse>
  <cfset request.prop_type = "C">
 </cfif>
  
  
  <cfquery name="updateZoning" datasource="#request.dsn#" dbtype="datasource">
  update srr_info
  set 
  prop_type = '#request.prop_type#'
  , ZoningCode = '#request.zoningCode#'
where srrKey = '#request.srrKey#'
  </cfquery>
  
</cfif><!-- 4 -->



</cfif><!--- 2 --->

<cfquery name="getSRRStatus" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id, srr_info.srrKey, srr_info.sr_number, srr_info.srr_status_cd, srr_status.srr_status_desc, srr_info.job_address, 
               srr_info.prop_type, srr_info.tree_insp_sr_number, rebate_rates.res_cap_amt, rebate_rates.comm_cap_amt
			   
FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               srr_status ON srr_info.srr_status_cd = srr_status.srr_status_cd
			   
where srrKey = '#request.srrKey#'
</cfquery>



<cfinclude template="../common/calc_balanceNow.cfm">
<cfif #getSRRStatus.prop_type# is "R" and #request.balanceNow# lt #getSRRStatus.res_cap_amt#>
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<Cfelseif #getSRRStatus.prop_type# is "R" and #request.balanceNow# gte #getSRRStatus.res_cap_amt#>
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = #getSRRStatus.res_cap_amt#>
<Cfelseif #getSRRStatus.prop_type# is "C" and #request.balanceNow# lt #getSRRStatus.comm_cap_amt#>
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<Cfelseif #getSRRStatus.prop_type# is "C" and #request.balanceNow# gte #getSRRStatus.comm_cap_amt#>
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = #getSRRStatus.comm_cap_amt#>
<cfelseif  #getSRRStatus.prop_type# is "" and #request.balanceNow# lt #getSRRStatus.comm_cap_amt#>
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<cfelseif  #getSRRStatus.prop_type# is "" and #request.balanceNow# gte #getSRRStatus.comm_cap_amt#>
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = #getSRRStatus.comm_cap_amt#>
</cfif>
<cfquery name="UpdateStatus" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
srr_status_cd = '#request.newStatus#'
, offer_reserved_amt = #request.offer_reserved_amt#

, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

where 
srr_id = #getSRRStatus.srr_id#
</cfquery>



<cfmail to="essam.amarragy@lacity.org" from="SRR@lacity.org" subject="Address Re-validation performed for SR: #request.sr_number#">
Address Re-validation performed for SR: #request.sr_number#
</cfmail>


<div class = "warning">
<p>Address was Validated.</p>
<cfif #request.newStatus# is "received">
<p>Application was sent back to Board of Public Works / Office of Community Beautification for Eligibility Review.</p>
<cfelseif #request.newStatus# is "waitlisted">
<p>Application was placed on the waiting list for lack of funds.</p>
</cfif>
</div>