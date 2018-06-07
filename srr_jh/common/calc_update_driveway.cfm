
<cfparam name="t_in" default="0">
<cfparam name="x_ft" default="0">
<cfparam name="x_in" default="0">
<cfparam name="y_ft" default="0">
<cfparam name="y_in" default="0">

<cfquery name="find_permit" datasource="apermits_sql" dbtype="datasource">
select * from permit_info
where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_driveway" datasource="apermits_sql" dbtype="datasource">
SELECT 
 driveway_id
      , ref_no
      , driveway_no
      , driveway_case
      , driveway_category
      , driveway_material
      , ISNULL(x_ft, 0) x_ft
      , ISNULL(x_in, 0) x_in
      , ISNULL(y_ft, 0) y_ft
      , ISNULL(y_in, 0) y_in
      , ISNULL(t_in, 0) t_in
      , ISNULL(w_ft, 0) w_ft
      , ISNULL(w_in, 0) w_in
      , ISNULL(a_ft, 0) a_ft
      , ISNULL(a_in, 0) a_in
      , ISNULL(gw_ft, 0) gw_ft
      , ISNULL(gw_in, 0) gw_in
      , ISNULL(ch_in, 0) ch_in
      , items_near_driveway
      , items_near_driveway_comments
      , ISNULL(driveway_qty, 0) driveway_qty
      , ISNULL(driveway_fee, 0) driveway_fee
      , waive_driveway_fee
      , ISNULL(driveway_fee_discount, 0) driveway_fee_discount
      , ISNULL(driveway_net_fee, 0) driveway_net_fee
      , driveway_waiver_id
      , eligible
  FROM [Apermits].[dbo].[driveway_details]
where
ref_no=#request.ref_no# and driveway_no=#request.driveway_no#
</cfquery> 

<!-- set curb height to ch_in_in -->
<cfif #get_driveway.driveway_category# is "r">
<cfset t_in=4>
<cfelseif #get_driveway.driveway_category# is "c">
<Cfset t_in=6>
</cfif>

<Cfset ch_in=#get_driveway.ch_in#>
<Cfset w_ft=#get_driveway.w_ft#>
<Cfset w_in=#get_driveway.w_in#>
<cfset a_ft=#get_driveway.a_ft#>
<cfset a_in=#get_driveway.a_in#>



<!--- Determine Y for case 1 --->
<cfif #get_driveway.driveway_case# is "1">
<cfset x_ft=3>
<cfset x_in=0>
 	<cfif #ch_in# lte 8>
	<cfset y_ft=6>
	<cfset y_in=6>

	<cfelseif #ch_in# eq 9>
	<cfset y_ft=9>
	<cfset y_in=0>
 	
	<cfelseif #ch_in# eq 10>
	<cfset y_ft=10>
	<cfset y_in=0>
	
	<cfelseif #ch_in# eq 11>
	<cfset y_ft=11>
	<cfset y_in=0>
	
	<cfelseif #ch_in# gte 12>
	<cfset y_ft=12>
	<cfset y_in=0>
		
	</cfif>
	
</cfif>

<!--- Determine Y for case 2 --->
<cfif #get_driveway.driveway_case# is "2">
 	<cfif #ch_in# lte 6>
	<cfset x_ft=3>
	<cfset x_in=0>
 	<cfset y_ft=6>
	<Cfset y_in=0>

	
 	<cfelseif #ch_in# eq 7>
	<cfset x_ft=3>
	<cfset x_in=6>
 	<cfset y_ft=7>
	<Cfset y_in=0>

	
 	<cfelseif #ch_in# eq 8>
	<cfset x_ft=4>
	<cfset x_in=0>
 	<cfset y_ft=8>
	<Cfset y_in=0>

	
	<cfelseif #ch_in# eq 9>
	<cfset x_ft=4>
	<cfset x_in=6>
 	<cfset y_ft=9>
	<Cfset y_in=0>

	
	<cfelseif #ch_in# eq 10>
	<cfset x_ft=5>
	<cfset x_in=0>
 	<cfset y_ft=10>
	<Cfset y_in=0>

	
	<cfelseif #ch_in# eq 11>
	<cfset x_ft=5>
	<cfset x_in=6>
 	<cfset y_ft=11>
	<Cfset y_in=0>

	
	<cfelseif #ch_in# gte 12>
	<cfset x_ft=6>
	<cfset x_in=0>
	 <cfset y_ft=12>
	<Cfset y_in=0>	
	</cfif>
	
</cfif>

<!--- Determine Y for case  3 or 4 --->
<cfif #get_driveway.driveway_case# is "3" or #get_driveway.driveway_case# is"4">
<cfset x_ft=3>
<cfset x_in=0>

 	<cfif #ch_in# lte 6>
 	<cfset y_ft=6>
	 <cfset y_in=0>	

 	<cfelseif #ch_in# eq 7>
 	<cfset y_ft=7>
	 <cfset y_in=0>	

 	<cfelseif #ch_in# eq 8>
 	<cfset y_ft =8>
	 <cfset y_in=0>	

<cfelseif #ch_in# eq 9>
	<cfset y_ft=9>
	 <cfset y_in=0>	

<cfelseif #ch_in# eq 10>
	<cfset y_ft = 10>
	 <cfset y_in=0>	
	
<cfelseif #ch_in# eq 11>
	<cfset y_ft = 11>
	<cfset y_in=0>		
	
<cfelseif #ch_in# gte 12>
	<cfset y_ft = 12>
	<cfset y_in=0>	
	</cfif>


</cfif>



<!-- Start Calculating fees -->
<Cfset w=#w_ft# + (#w_in#/12)>

<cfset a=#a_ft# +(#a_in#/12)>

<cfset x=#x_ft# +(#x_in#/12)>

<cfset y=#y_ft# +(#y_in#/12)>

<cfset driveway_qty=(#w# + (2*#x#)) * (#a# + 2)>

<Cfset driveway_qty=(#driveway_qty#*100)>
<Cfset driveway_qty=#NumberFormat(driveway_qty, "9999999999")#/100>


<cfif #driveway_qty# gt 0 and #driveway_qty# lt 10>
<cfset driveway_qty = 10>
</cfif>


<cfquery name="update_driveway_details" datasource="apermits_sql" dbtype="datasource">
update driveway_details
set
x_ft=#x_ft#,
x_in=#x_in#,
y_ft=#y_ft#,
y_in=#y_in#,
t_in=#t_in#,

driveway_qty=#driveway_qty#

where ref_no=#request.ref_no# and driveway_no=#request.driveway_no#
</cfquery>