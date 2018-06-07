
<cfquery name="find_permit" datasource="apermits_sql" dbtype="datasource">
select * from permit_info
where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_sidewalk" datasource="apermits_sql" dbtype="datasource">
Select
[sidewalk_id]
      ,[sidewalk_no]
      ,[ref_no]
      ,ISNULL([sw_length_ft], 0) as sw_length_ft
      ,ISNULL([sw_length_in], 0) as sw_length_in
      ,ISNULL([sw_width_ft], 0) as sw_width_ft
      ,ISNULL([sw_width_in], 0) as sw_width_in
      ,ISNULL([sidewalk_qty], 0) as sidewalk_qty
     
	  
  FROM [Apermits].[dbo].[sidewalk_details]
where
ref_no=#request.ref_no# and sidewalk_no=#request.sidewalk_no#
</cfquery> 

<cfset request.sw_length=#get_sidewalk.sw_length_ft#+(#get_sidewalk.sw_length_in#/12)>
<cfset request.sw_width=#get_sidewalk.sw_width_ft#+(#get_sidewalk.sw_width_in#/12)>

<cfset request.sidewalk_qty=#request.sw_length# * #request.sw_width#>

<Cfset request.sidewalk_qty=(#request.sidewalk_qty#*100)>
<Cfset request.sidewalk_qty=#NumberFormat(request.sidewalk_qty,"999999999999")#>
<Cfset request.sidewalk_qty=(#request.sidewalk_qty#/100)>

<cfquery name="update_permit_info" datasource="apermits_sql" dbtype="datasource">
update permit_info
set
 waive_basic_fee=1
, waive_basic_fee_waiver_id = 22
where ref_no=#request.ref_no#
</cfquery>

<cfif #request.sidewalk_qty# gt 0 and  #request.sidewalk_qty# lt 10>
<cfset request.sidewalk_qty = 10>
</cfif>


<cfquery name="update_sidewalk_details" datasource="apermits_sql" dbtype="datasource">
update sidewalk_details
set
waive_sidewalk_fee='Y',
council_motion_waived=0,
waive_sidewalk_fee_waiver_id = 22,
sidewalk_qty=#request.sidewalk_qty#,
ddate_modified = #now()#,
ddate_added = #now()#

where ref_no=#request.ref_no# and sidewalk_no=#request.sidewalk_no#
</cfquery>