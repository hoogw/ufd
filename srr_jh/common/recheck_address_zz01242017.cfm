<cfabort>
This document is not used anymore.



<cfinclude template="validate_srrKey.cfm">

<cfinclude template="../common/myCFfunctions.cfm">

<cfif not isdefined("") or #request.hse_id# is "">
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

<cfabort>

<cfquery name="updateHistory" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set 
record_history = record_history + 'Address was updated:  Old Address: '+job_address+' New Address: #request.job_address#'
, HSE_ID = #checkAddress.#
, PIN = #checkAddress.#
, PIND = #checkAddress.#
, HSE_NBR = #checkAddress.#
, HSE_FRAC_NBR = #checkAddress.#
, HSE_DIR_CD = #checkAddress.#
, STR_NM = #checkAddress.#
, STR_SFX_CD = #checkAddress.#
, STR_SFX_DIR_CD = #checkAddress.#
, UNIT_RANGE = #checkAddress.#
, ZIP_CD = #checkAddress.#
, X_COORD_NBR = #checkAddress.#
, Y_COORD_NBR = #checkAddress.#
, ASGN_STTS_IND = #checkAddress.#
, ENG_DIST = #checkAddress.#
, CNCL_DIST = #checkAddress.#
, LON = #checkAddress.#
, LAT = #checkAddress.#

where srrKey = '#request.srrKey#'
</cfquery>

<cfquery name="readHouse" datasource="#request.dsn#" dbtype="datasource">
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
</cfquery>

<cfquery name="checkAddress" datasource="navla_spatial" dbtype="datasource">
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




<cfif #checkAddress.pin# is not "">
<cfquery name="getTBM" datasource="navla_spatial" dbtype="datasource">
SELECT TOP 1000 [PIN]
      ,[TBM_PAGE]
      ,[TBM_ROW]
      ,[TBM_COLUMN]
      ,[CRTN_DT]
      ,[LST_MODF_DT]
      ,[PIND]
  FROM [dbo].[TBM_GRID]
</cfquery>
<cfset request.tbm_grid = #getTBM.TBM_page#&" "&#getTBM.TBM_row#&" "&#getTBM.TBM_column#>
<cfelse>
<cfset request.tbm_grid = "">
</cfif>

<cfquery name="updateSRR" datasource="#request.dsn#" dbtype="datasource">
update srr_info

set 
address_verified = 'Y'
, prop_data_checked = 'Y'
,unit_range = '#toSqlText(checkAddress.unit_range)#'
,hse_id = #toSqlNumeric(checkAddress.hse_id)#
,tbm_grid = '#toSqlText(request.tbm_grid)#'
,boe_dist = '#toSqlText(checkAddress.ENG_DIST)#'
,council_dist = '#toSqlText(checkAddress.CNCL_DIST)#'
, zip_cd = '#toSqlText(checkAddress.zip_cd)#'
,pin = '#toSqlText(checkAddress.pin)#'
,pind = '#toSqlText(checkAddress.pind)#'
,x_coord = #toSqlNumeric(checkAddress.X_COORD_NBR)#
,y_coord = #toSqlNumeric(checkAddress.Y_COORD_NBR)#
,longitude = #toSqlNumeric(checkAddress.lon)#
,latitude = #toSqlNumeric(checkAddress.lat)#
, job_address = '#request.job_address#'

where srr_id = #request.srr_id#
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

where srr_id = #request.srr_id#
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

where srr_id = #request.srr_id#
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
  where srr_id = #request.srr_id#
  </cfquery>
  
</cfif><!-- 4 -->



</cfif><!--- 2 --->

<cfquery name="getSRRStatus" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id
,srr_status_cd
, prop_type
, offer_reserved_amt
, offer_open_amt
, offer_accepted_amt
, offer_paid_amt

from srr_info
where srr_id = #request.srr_id#
</cfquery>



<cfinclude template="../common/calc_balanceNow.cfm">
<cfif #getSRRStatus.prop_type# is "R" and #request.balanceNow# lt 2000>
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<Cfelseif #getSRRStatus.prop_type# is "R" and #request.balanceNow# gte 2000>
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = 2000>
<Cfelseif #getSRRStatus.prop_type# is "C" and #request.balanceNow# lt 4000>
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<Cfelseif #getSRRStatus.prop_type# is "C" and #request.balanceNow# gte 4000>
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = 4000>
<cfelseif  #getSRRStatus.prop_type# is "" and #request.balanceNow# lt 4000><!--- when prop_type is not known, reserve $4000 --->
<cfset request.newStatus = "waitListed">
<cfset request.offer_reserved_amt = 0>
<cfelseif  #getSRRStatus.prop_type# is "" and #request.balanceNow# gte 4000><!--- when prop_type is not known, reserve $4000 --->
<cfset request.newStatus = "received">
<cfset request.offer_reserved_amt = 4000>
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

<!--- <cfset client.full_name = "x"> --->
<cfquery name="UpdateHistory" datasource="#request.dsn#" dbtype="datasource">
update srr_info
set
record_history = record_history + '|Address was re-validated on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")# by #client.full_name#.'
where srrKey='#request.srrKey#'
</cfquery>


<cfmail to="essam.amarragy@lacity.org" from="SRR@lacity.org" subject="Address Re-validation performed for SR: #request.sr_number#">
Address Re-validation performed for SR: #request.sr_number#
</cfmail>


<div class = "warning">
<p>Address was Validated.</p>
<cfif #request.newStatus# is "received">
<p>Application was sent back to Board of Public Works for Eligibility Review.</p>
<cfelseif #request.newStatus# is "waitlisted">
<p>Application was placed on the waiting list for lack of funds.</p>
</cfif>
</div>
<br><br>
<div align="center"><strong>You may now close this tab</strong></div>

</cfif><!--- 1 --->

<cfinclude template="footer.cfm">




<!--- <cfif #request.newStatus# is "waitListed">
<cfset request.srNum = #getSRRStatus.sr_number#>
<cfset request.srCode = "11">
<!-- This message is the latest message as of 11/4/2016 -->
<cfset request.srComment = "There are currently insufficient funds available to further process your application for the Sidewalk Rebate Program.  Your application has been placed on a waitlist until more funds become available. Your place in line is determined by the date your application was received - do not resubmit.  A change to your waitlist status will be posted to the original Service Request ticket in MyLA311 and will be sent via e-mail.">
<cftry>
<!--- No need to send comments to customer --->
<cfmodule template="../modules/updateSR_module.cfm" srNum="#request.srNum#" srCode="#request.srCode#" srComment="#left(request.srComment, 750)#">
<cfcatch type="Any">
<!--- do nothing --->
</cfcatch>
</cftry>
</cfif> --->



<!--- 
<cfquery name="updateReservedAmt" datasource="#request.dsn#" dbtype="datasource">
UPDATE
srr_info
SET
offer_reserved_amt =
(
CASE
WHEN ((srr_status_cd = 'received' or srr_status_cd = 'PendingBcaReview' or srr_status_cd = 'PendingBssReview') and prop_type = 'R')
THEN 2000
WHEN ((srr_status_cd = 'received' or srr_status_cd = 'PendingBcaReview' or srr_status_cd = 'PendingBssReview')  and prop_type = 'C')
THEN 4000
ELSE 0
END
)

, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0
</cfquery>

<cfquery name="updateAmt1" datasource="#request.dsn#" dbtype="datasource">
UPDATE
srr_info
SET
offer_reserved_amt = 0
, offer_open_amt = 0
, offer_accepted_amt = 0
, offer_paid_amt = 0

WHERE  (
srr_status_cd = 'notEligible' 
or 
srr_status_cd = 'inCompleteDocs' 
or 
srr_status_cd = 'AdaCompliant'
or 
srr_status_cd = 'constDurationExp'
or 
srr_status_cd = 'offerDeclined'
or 
srr_status_cd = 'denied'
)
</cfquery> --->

