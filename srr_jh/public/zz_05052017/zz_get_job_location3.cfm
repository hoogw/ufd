
<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_id, ddate_submitted
FROM  srr_info
where srr_id=#request.srr_id#
</cfquery>

<!-- index field house_id or split this query into two queries for speed -->
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
LA_HSE_NBR.HSE_ID = #request.HSE_ID#
</cfquery>


<cfquery name="get_hse_attr" datasource="navla_spatial" dbtype="datasource">
SELECT [PIN]
      ,[TBM_PAGE]
      ,[TBM_ROW]
      ,[TBM_COLUMN]
      ,[CRTN_DT]
      ,[LST_MODF_DT]
      ,[PIND]
  FROM [navla_spatial].[dbo].[TBM_GRID]
WHERE       pind='#get_address.pind#'
</cfquery>

<cfset request.tbm_grid=#get_hse_attr.tbm_page#&"  "&#get_hse_attr.tbm_column#&#get_hse_attr.tbm_row#>


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
<cfif #trim(get_address.str_sfx_dir_cd)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.str_sfx_dir_cd)#>
</cfif>

<cfif #trim(get_address.unit_range)# is not "">
<cfset job_address=#job_address#&" "&#trim(get_address.unit_range)#>
</cfif>



<!--- <cfquery name="get_parcel_lat_lon" datasource="la_addresses_sql" dbtype="datasource">
select * from parcels where pin = '#get_address.pind#'
</cfquery> --->


<!-- index pin -->
<cfquery name="get_parcel_lat_lon" datasource="navla_spatial" dbtype="datasource">
select * from parcels where pin = '#get_address.pind#'
</cfquery>


<cfif #get_parcel_lat_lon.lat_min# is "">
<cfset request.lat_min="null">
<cfelse>
<cfset request.lat_min=#get_parcel_lat_lon.lat_min#>
</cfif>

<cfif #get_parcel_lat_lon.lat_max# is "">
<cfset request.lat_max="null">
<cfelse>
<cfset request.lat_max=#get_parcel_lat_lon.lat_max#>
</cfif>

<cfif #get_parcel_lat_lon.lon_min# is "">
<cfset request.lon_min="null">
<cfelse>
<cfset request.lon_min=#get_parcel_lat_lon.lon_min#>
</cfif>


<cfif #get_parcel_lat_lon.lon_max# is "">
<cfset request.lon_max="null">
<cfelse>
<cfset request.lon_max=#get_parcel_lat_lon.lon_max#>
</cfif>

<!--- <cfoutput>
Update srr_info
Set
job_address='#left(Ucase(job_address),100)#',

hse_nbr='#left(get_address.hse_nbr,15)#',
str_nm='#left(get_address.str_nm,60)#',
unit_range='#left(get_address.unit_range,7)#',
pind='#left(get_address.pind,15)#',
bpp='#left(Ucase(get_address.bpp),15)#',
job_zip='#left(get_address.zip_cd,12)#',
job_city='LOS ANGELES',
job_state = 'CA',
boe_dist='#left(Ucase(get_address.eng_dist),1)#',
council_dist='#left(get_address.cncl_dist,12)#',
tbm_grid='#left(request.tbm_grid,12)#',
hse_id=#get_address.hse_id#,

address_verified=1

where srr_id=#request.srr_id#
</cfoutput>
<cfabort> --->

<cfquery name="update_record" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
Set
job_address='#left(Ucase(job_address),100)#',

hse_nbr='#left(get_address.hse_nbr,15)#',
str_nm='#left(get_address.str_nm,60)#',
unit_range='#left(get_address.unit_range,7)#',
pind='#left(get_address.pind,15)#',
bpp='#left(Ucase(get_address.bpp),15)#',
job_zip='#left(get_address.zip_cd,12)#',
job_city='LOS ANGELES',
job_state = 'CA',
boe_dist='#left(Ucase(get_address.eng_dist),1)#',
council_dist='#left(get_address.cncl_dist,12)#',
tbm_grid='#left(request.tbm_grid,12)#',
hse_id=#get_address.hse_id#,

address_verified=1

where srr_id=#request.srr_id#
</cfquery>

<cfquery name="checkScreenDates" DATASOURCE="#request.dsn#" dbtype="datasource">
select * from  screen_dates

WHERE srr_id=#request.srr_id#
</cfquery>

<cfif #checkScreenDates.recordcount# is  0>
<cfquery name="addScreenDt" DATASOURCE="#request.dsn#" dbtype="datasource">
insert into screen_dates
(srr_id, job_address_screen_dt, job_address_screen_by) 
values
(#request.srr_id#, #now()#, -1)
</cfquery>
<cfelse>
<cfquery name="update_screen_dates" DATASOURCE="#request.dsn#" dbtype="datasource">
UPDATE screen_dates
SET

job_address_screen_dt = #now()#
, job_address_screen_by = -1

WHERE srr_id=#request.srr_id#
</cfquery>
</cfif>


<cfif #find_srr.ddate_submitted# is "">
<cflocation addtoken="No" url="control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#">
<cfelse>
<cflocation addtoken="No" url="control.cfm?dsp_app&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>