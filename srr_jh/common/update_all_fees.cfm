<!---<cfinclude template="../common/myCFfunctions.cfm">--->

<cfparam name="request.partial_dwy_conc_qty" default="0">
<cfparam name="request.partial_dwy_asphalt_qty" default="0">
<cfparam name="request.street_resurfacing_qty" default="0">
<cfparam name="request.access_ramp_qty" default="0">
<cfparam name="request.alley_intersection_no" default="0">
<cfparam name="request.conc_curb_qty" default="0">
<cfparam name="request.curb_cuts_qty" default="0">
<cfparam name="request.conc_gutter_qty" default="0">
<cfparam name="request.pipe_insp_no" default="0">




<!--- <cfoutput>
request.sidewalk_work = #request.sidewalk_work#<BR>
request.driveway_work=#request.driveway_work#<BR>
request.other_work=#request.other_work#<BR>
request.new_sidewalk=#request.new_sidewalk#<BR>
request.tree_work=#request.tree_work#<BR>
request.apply_sw_waiver=#request.apply_sw_waiver#
</cfoutput> --->


<cfquery name="find_old_permit" datasource="apermits_sql" dbtype="datasource">
SELECT * from permit_info where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_driveways" datasource="apermits_sql" dbtype="datasource">
select * from driveway_details
where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_sidewalks" datasource="apermits_sql" dbtype="datasource">
select * from sidewalk_details
where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_other_items" datasource="apermits_sql" dbtype="datasource">
select * from other_items
where ref_no=#request.ref_no#
</cfquery>

<cfquery name="get_rates" datasource="apermits_sql" dbtype="datasource">
select * from fee_rates
where rate_nbr=#find_old_permit.rate_nbr#
</cfquery>


<cfset total_fee=0>
<cfset total_fee_discount=0>
<Cfset total_net_fee=0>
<cfset total_s1=0>
<cfset total_s2=0>
<cfset total_collected_fee=0>



<!-- calculate fee=fee per municipal code for the item before any discount or waiving-->
<!-- calculate fee discount -->
<!-- calculate net_fee =fee per code - fee discount -->
<!-- calculate s1=net_fee * s1% -->
<!-- calculate s2=net_fee * s2% -->
<!-- calcuate grand_net_total=total_net_fee +total_s1+total_s2 -->


<!-- A-Permit Basic Fee -->
<cfset basic_fee_discount=0>


<cfif #find_old_permit.receive_method# is "I">
<cfset basic_fee=#get_rates.basic_uf_internet#>
<cfelse>
<cfset basic_fee=#get_rates.basic_uf#>
</cfif>

<cfset request.waive_basic_fee=1>
<cfset basic_fee_discount=#basic_fee#>



<cfset basic_net_fee=#basic_fee#-#basic_fee_discount#>
<cfset basic_net_fee=#decimalformat(basic_net_fee)#>
<cfset basic_net_fee=ReplaceNoCase("#basic_net_fee#",",","","ALL")>



<cfset basic_s1=(#basic_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset basic_s2=(#basic_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset basic_s1=#decimalformat(basic_s1)#>
<cfset basic_s1=ReplaceNoCase("#basic_s1#",",","","ALL")>

<cfset basic_s2=#decimalformat(basic_s2)#>
<cfset basic_s2=ReplaceNoCase("#basic_s2#",",","","ALL")>


<cfset basic_collected_fee=#basic_net_fee#+#basic_s1#+#basic_s2#>

<cfif #find_old_permit.permit_type# is "s">
<cfset basic_fee=0>
<cfset basic_fee_discount=0>
<cfset basic_net_fee=0>
<cfset basic_s1=0>
<cfset basic_s2=0>
<cfset basic_collected_fee=0>
</cfif>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset basic_fee=0>
<cfset basic_fee_discount=0>
<cfset basic_net_fee=0>
<cfset basic_s1=0>
<cfset basic_s2=0>
<cfset basic_collected_fee=0>
</cfif>


<cfset total_fee=#total_fee# + #basic_fee#>
<cfset total_fee_discount=#total_fee_discount# + #basic_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #basic_net_fee#>
<Cfset total_s1=#total_s1#+#basic_s1#>
<cfset total_s2=#total_s2#+#basic_s2#>
<cfset total_collected_fee=#total_collected_fee#+#basic_collected_fee#>
<!-- A-Permit Basic Fee -->


<!--- <cfoutput>
<BR><BR>basic_fee=#basic_fee#<BR><BR>
</cfoutput>

<cfoutput>
total_fee=#total_fee#<br>
basic_s1 = #basic_s1#<br>
basic_s2 = #basic_s2#<br>
</cfoutput> --->


<!-- driveway(s) Fee -->
<cfif #get_driveways.recordcount# is not 0>

<!--- <cfquery name="max_no" datasource="apermits_sql" dbtype="datasource">
select max(driveway_no) as max_no
from driveway_details
where ref_no=#request.ref_no#
</cfquery> --->

<cfloop query="get_driveways">
	<cfquery name="get_dwy" datasource="apermits_sql" dbtype="datasource">
	select * from driveway_details
	where ref_no=#request.ref_no# and driveway_no=#get_driveways.driveway_no#
	</cfquery>
	
	<cfif #get_dwy.driveway_material# eq "c">
	<cfset request.driveway_fee=#get_dwy.driveway_qty#*#get_rates.conc_driveway_approach_uf#>
	<cfelseif #get_dwy.driveway_material# eq "a">
	<cfset request.driveway_fee=#get_dwy.driveway_qty#*#get_rates.street_resurfacing_uf#>
	<cfelse>
	<cfset request.driveway_fee=#get_dwy.driveway_qty#*#get_rates.conc_driveway_approach_uf#>
	</cfif>
	
	<cfif #get_dwy.waive_driveway_fee# is "Y">
	<cfset request.driveway_fee_discount=#request.driveway_fee#>
	<!--cfelseif #get_dwy.driveway_fee_discount# is not "" and #get_dwy.driveway_fee_discount# is not 0-->
	<!--cfset driveway_fee_discount=#get_dwy.driveway_fee_discount#-->
	<cfelse>
	<cfset request.driveway_fee_discount=0>
	</cfif>
	
	
	<cfif #request.driveway_fee# is "">
	<cfset request.driveway_fee=0>
	</cfif>
	
	<cfset request.driveway_net_fee=#request.driveway_fee#-#request.driveway_fee_discount#>
	
	<cfset request.driveway_net_fee=#decimalformat(request.driveway_net_fee)#>
	<cfset request.driveway_net_fee=ReplaceNoCase("#request.driveway_net_fee#",",","","ALL")>
	
	<cfset request.driveway_s1=(#request.driveway_net_fee#)*(#get_rates.surcharge_1#/100)>
	<cfset request.driveway_s2=(#request.driveway_net_fee#)*(#get_rates.surcharge_2#/100)>
		
	<cfset request.driveway_s1=#decimalformat(request.driveway_s1)#>
	<cfset request.driveway_s1=ReplaceNoCase("#request.driveway_s1#",",","","ALL")>
	
	<cfset request.driveway_s2=#decimalformat(request.driveway_s2)#>
	<cfset request.driveway_s2=ReplaceNoCase("#request.driveway_s2#",",","","ALL")>
	
	<cfset request.driveway_collected_fee=#request.driveway_net_fee#+#request.driveway_s1#+#request.driveway_s2#>
	

<cfif #find_old_permit.ar_nbr# is not "">
<cfset request.driveway_fee = 0>
<cfset request.driveway_fee_discount = 0>
<cfset request.driveway_net_fee = 0>
<cfset request.driveway_s1 = 0>
<cfset request.driveway_s1 = 0>
<cfset request.driveway_collected_fee = 0>
</cfif>

	
	<cfset total_fee=#total_fee# + #request.driveway_fee#>
	<cfset total_fee_discount=#total_fee_discount# + #request.driveway_fee_discount#>
	<cfset total_net_fee=#total_net_fee# + #request.driveway_net_fee#>
	<Cfset total_s1=#total_s1#+#request.driveway_s1#>
	<cfset total_s2=#total_s2#+#request.driveway_s2#>
	<cfset total_collected_fee=#total_collected_fee#+#request.driveway_collected_fee#>
	
	
	<cfquery name="update_driveways" datasource="apermits_sql" dbtype="datasource">
	update driveway_details
	set
	driveway_fee=#request.driveway_fee#,
	driveway_fee_discount=#request.driveway_fee_discount#,
	driveway_net_fee=#request.driveway_net_fee#
	
	where ref_no=#request.ref_no# and driveway_no=#get_driveways.driveway_no#
	</cfquery>

</cfloop>


</cfif>
<!-- driveway(s) Fee -->


<!--- <cfoutput>
total_fee=#total_fee#<br>
driveway_s1 = #driveway_s1#<br>
driveway_s2 = #driveway_s2#<br>
</cfoutput> --->




<!-- Sidewalk(s) Fee -->
<cfif #get_sidewalks.recordcount# is not 0>

<cfquery name="max_no" datasource="apermits_sql" dbtype="datasource">
select max(sidewalk_no) as max_no
from sidewalk_details
where ref_no=#request.ref_no#
</cfquery>

<cfloop index="i" from="1" to="#max_no.max_no#" step="1">

<cfquery name="get_sidewalk" datasource="apermits_sql" dbtype="datasource">
select * from sidewalk_details
where ref_no=#request.ref_no# and sidewalk_no=#i#
</cfquery>

<cfif #get_sidewalk.recordcount# is not 0>

<cfif #get_sidewalk.sidewalk_qty# is "">
<cfset request.sidewalk_qty=0>
<cfelse>
<cfset request.sidewalk_qty=#get_sidewalk.sidewalk_qty#>
</cfif>

<cfset sidewalk_fee=#request.sidewalk_qty#*#get_rates.sidewalk_uf#>


<cfset sidewalk_fee_discount=0>


<!---<cfif #request.apply_sw_waiver# is 1>
<cfif #find_old_permit.single_family_residence# is 1 and  (#get_sidewalk.reason_for_work# is "Repair" or #get_sidewalk.reason_for_work# is "Replace")>
<cfset sidewalk_fee_discount=#sidewalk_fee#>
<cfquery name="update_sidewalks" datasource="apermits_sql" dbtype="datasource">
update sidewalk_details
set
waive_sidewalk_fee='Y',
waive_sidewalk_fee_waiver_id=22

where ref_no=#request.ref_no# and sidewalk_no=#i#
</cfquery>
<cfelse>
<cfset sidewalk_fee_discount=0>
</cfif>
</cfif>--->


<cfif #get_sidewalk.waive_sidewalk_fee# is "Y">
<cfset sidewalk_fee_discount=#sidewalk_fee#>
</cfif>


<cfif #sidewalk_fee# is "">
<cfset sidewalk_fee=0>
</cfif>

<cfset sidewalk_net_fee=#sidewalk_fee#-#sidewalk_fee_discount#>
<cfset sidewalk_net_fee=#decimalformat(sidewalk_net_fee)#>
<cfset sidewalk_net_fee=ReplaceNoCase("#sidewalk_net_fee#",",","","ALL")>


<cfset sidewalk_s1=(#sidewalk_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset sidewalk_s2=(#sidewalk_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset sidewalk_s1=#decimalformat(sidewalk_s1)#>
<cfset sidewalk_s1=ReplaceNoCase("#sidewalk_s1#",",","","ALL")>

<cfset sidewalk_s2=#decimalformat(sidewalk_s2)#>
<cfset sidewalk_s2=ReplaceNoCase("#sidewalk_s2#",",","","ALL")>


<cfset sidewalk_collected_fee=#sidewalk_net_fee#+#sidewalk_s1#+#sidewalk_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset sidewalk_fee = 0>
<cfset sidewalk_fee_discount = 0>
<cfset sidewalk_net_fee = 0>
<cfset sidewalk_s1 =0>
<cfset sidewalk_s2 = 0>
<cfset sidewalk_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #sidewalk_fee#>
<cfset total_fee_discount=#total_fee_discount# + #sidewalk_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #sidewalk_net_fee#>
<Cfset total_s1=#total_s1#+#sidewalk_s1#>
<cfset total_s2=#total_s2#+#sidewalk_s2#>
<cfset total_collected_fee=#total_collected_fee#+#sidewalk_collected_fee#>

<cfquery name="update_sidewalks" datasource="apermits_sql" dbtype="datasource">
update sidewalk_details
set
sidewalk_fee=#sidewalk_fee#,
sidewalk_fee_discount=#sidewalk_fee_discount#,
sidewalk_net_fee=#sidewalk_net_fee#

where ref_no=#request.ref_no# and sidewalk_no=#i#
</cfquery>
</cfif>
</cfloop>
</cfif>
<!-- Sidewalk(s) Fee -->


<!--- <cfoutput>
total_fee=#total_fee#<br>
sidewalk_s1 = #sidewalk_s1#<br>
sidewalk_s2 = #sidewalk_s2#<br>
</cfoutput> --->



<!-- Concrete Pvmt Insp-Driveway -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.partial_dwy_conc_qty# gt 0>

<cfif #get_other_items.partial_dwy_conc_qty# gt 0 and #get_other_items.partial_dwy_conc_qty# lt 10>
<cfset request.partial_dwy_conc_qty = 10>
<cfelse>
<cfset request.partial_dwy_conc_qty = #get_other_items.partial_dwy_conc_qty#>
</cfif>


<cfset partial_dwy_conc_fee=#request.partial_dwy_conc_qty#*#get_rates.conc_driveway_approach_uf#>

<cfif #get_other_items.waive_partial_dwy_conc_fee# is "Y">
<cfset partial_dwy_conc_fee_discount=#partial_dwy_conc_fee#>
<!--cfelseif #get_other_items.partial_dwy_conc_fee_discount# is not "" and #get_other_items.partial_dwy_conc_fee_discount# is not 0-->
<!--cfset partial_dwy_conc_fee_discount=#get_other_items.partial_dwy_conc_fee_discount#-->
<cfelse>
<cfset partial_dwy_conc_fee_discount=0>
</cfif>

<cfset partial_dwy_conc_net_fee=#partial_dwy_conc_fee#-#partial_dwy_conc_fee_discount#>

<cfset partial_dwy_conc_net_fee=#decimalformat(partial_dwy_conc_net_fee)#>
<cfset partial_dwy_conc_net_fee=ReplaceNoCase("#partial_dwy_conc_net_fee#",",","","ALL")>

<cfset partial_dwy_conc_s1=(#partial_dwy_conc_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset partial_dwy_conc_s2=(#partial_dwy_conc_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset partial_dwy_conc_s1=#decimalformat(partial_dwy_conc_s1)#>
<cfset partial_dwy_conc_s1=ReplaceNoCase("#partial_dwy_conc_s1#",",","","ALL")>
<cfset partial_dwy_conc_s2=#decimalformat(partial_dwy_conc_s2)#>
<cfset partial_dwy_conc_s2=ReplaceNoCase("#partial_dwy_conc_s2#",",","","ALL")>

<cfset partial_dwy_conc_collected_fee=#partial_dwy_conc_net_fee#+#partial_dwy_conc_s1#+#partial_dwy_conc_s2#>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset partial_dwy_conc_fee = 0>
<cfset partial_dwy_conc_fee_discount = 0>
<cfset partial_dwy_conc_net_fee = 0>
<cfset partial_dwy_conc_s1 =0>
<cfset partial_dwy_conc_s2 = 0>
<cfset partial_dwy_conc_collected_fee = 0>
</cfif>



<cfset total_fee=#total_fee# + #partial_dwy_conc_fee#>
<cfset total_fee_discount=#total_fee_discount# + #partial_dwy_conc_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #partial_dwy_conc_net_fee#>
<Cfset total_s1=#total_s1#+#partial_dwy_conc_s1#>
<cfset total_s2=#total_s2#+#partial_dwy_conc_s2#>
<cfset total_collected_fee=#total_collected_fee#+#partial_dwy_conc_collected_fee#>

<cfelse>
<cfset partial_dwy_conc_fee=0>
<cfset partial_dwy_conc_fee_discount=0>
<cfset partial_dwy_conc_net_fee=0>

</cfif>
</cfif>
<!-- Partial Driveway Concrete -->


<!--- <cfoutput>
partial_dwy_conc_fee=#partial_dwy_conc_fee#<br>
total_fee=#total_fee#<br>
partial_dwy_conc_s1 = #partial_dwy_conc_s1#<br>
partial_dwy_conc_s2 = #partial_dwy_conc_s2#<br>
</cfoutput> --->


<!-- Partial Driveway Asphalt -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.partial_dwy_asphalt_qty# gt 0>


<cfif #get_other_items.partial_dwy_asphalt_qty# gt 0 and #get_other_items.partial_dwy_asphalt_qty# lt 10>
<cfset request.partial_dwy_asphalt_qty = 10>
<cfelse>
<cfset request.partial_dwy_asphalt_qty = #get_other_items.partial_dwy_asphalt_qty#>
</cfif>




<cfset partial_dwy_asphalt_fee=#request.partial_dwy_asphalt_qty#*#get_rates.street_resurfacing_uf#>

<cfif #get_other_items.waive_partial_dwy_asphalt_fee# is "Y">
<cfset partial_dwy_asphalt_fee_discount=#partial_dwy_asphalt_fee#>
<!--cfelseif #get_other_items.partial_dwy_asphalt_fee_discount# is not "" or #get_other_items.partial_dwy_asphalt_fee_discount# is not 0-->
<!--cfset partial_dwy_asphalt_fee_discount=#get_other_items.partial_dwy_asphalt_fee_discount#-->
<cfelse>
<cfset partial_dwy_asphalt_fee_discount=0>
</cfif>

<cfif #partial_dwy_asphalt_fee# is "">
<cfset partial_dwy_asphalt_fee=0>
</cfif>
<cfif #partial_dwy_asphalt_fee_discount# is "">
<cfset partial_dwy_asphalt_fee_discount=0>
</cfif>

<cfset partial_dwy_asphalt_net_fee=#partial_dwy_asphalt_fee#-#partial_dwy_asphalt_fee_discount#>

<cfset partial_dwy_asphalt_net_fee=#decimalformat(partial_dwy_asphalt_net_fee)#>
<cfset partial_dwy_asphalt_net_fee=ReplaceNoCase("#partial_dwy_asphalt_net_fee#",",","","ALL")>

<cfset partial_dwy_asphalt_s1=(#partial_dwy_asphalt_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset partial_dwy_asphalt_s2=(#partial_dwy_asphalt_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset partial_dwy_asphalt_s1=#decimalformat(partial_dwy_asphalt_s1)#>
<cfset partial_dwy_asphalt_s1=ReplaceNoCase("#partial_dwy_asphalt_s1#",",","","ALL")>
<cfset partial_dwy_asphalt_s2=#decimalformat(partial_dwy_asphalt_s2)#>
<cfset partial_dwy_asphalt_s2=ReplaceNoCase("#partial_dwy_asphalt_s2#",",","","ALL")>

<cfset partial_dwy_asphalt_collected_fee=#partial_dwy_asphalt_net_fee#+#partial_dwy_asphalt_s1#+#partial_dwy_asphalt_s2#>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset partial_dwy_asphalt_fee = 0>
<cfset partial_dwy_asphalt_fee_discount = 0>
<cfset partial_dwy_asphalt_net_fee = 0>
<cfset partial_dwy_asphalt_s1 =0>
<cfset partial_dwy_asphalt_s2 = 0>
<cfset partial_dwy_asphalt_collected_fee = 0>
</cfif>




<cfset total_fee=#total_fee# + #partial_dwy_asphalt_fee#>
<cfset total_fee_discount=#total_fee_discount# + #partial_dwy_asphalt_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #partial_dwy_asphalt_net_fee#>
<Cfset total_s1=#total_s1#+#partial_dwy_asphalt_s1#>
<cfset total_s2=#total_s2#+#partial_dwy_asphalt_s2#>
<cfset total_collected_fee=#total_collected_fee#+#partial_dwy_asphalt_collected_fee#>

<cfelse>
<cfset partial_dwy_asphalt_fee=0>
<cfset partial_dwy_asphalt_fee_discount=0>
<cfset partial_dwy_asphalt_net_fee=0>

</cfif>


<!--- <cfoutput>
partial_dwy_asphalt_fee=#partial_dwy_asphalt_fee#<br>
total_fee=#total_fee#<br>
partial_dwy_asphalt_s1 = #partial_dwy_asphalt_s1#<br>
partial_dwy_asphalt_s2 = #partial_dwy_asphalt_s2#<br>
</cfoutput> --->

</cfif>
<!-- Partial Driveway Asphalt -->




<!-- access ramp(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.access_ramp_qty# gt 0>


<cfif #get_other_items.access_ramp_qty# gt 0 and #get_other_items.access_ramp_qty# lt 10>
<cfset request.access_ramp_qty = 10>
<cfelse>
<cfset request.access_ramp_qty = #get_other_items.access_ramp_qty#>
</cfif>



<cfset access_ramp_fee=#request.access_ramp_qty#*#get_rates.access_ramp_uf#>

<cfif #get_other_items.waive_access_ramp_fee# is "Y">
<cfset access_ramp_fee_discount=#access_ramp_fee#>
<!--cfelseif #get_other_items.access_ramp_fee_discount# is not "" or #get_other_items.access_ramp_fee_discount# is not 0-->
<!--cfset access_ramp_fee_discount=#get_other_items.access_ramp_fee_discount#-->
<cfelse>
<cfset access_ramp_fee_discount=0>
</cfif>


<cfif #access_ramp_fee# is "">
<cfset access_ramp_fee=0>
</cfif>

<cfif #access_ramp_fee_discount# is "">
<cfset access_ramp_fee_discount=0>
</cfif>

<cfset access_ramp_net_fee=#access_ramp_fee#-#access_ramp_fee_discount#>

<cfset access_ramp_net_fee=#decimalformat(access_ramp_net_fee)#>
<cfset access_ramp_net_fee=ReplaceNoCase("#access_ramp_net_fee#",",","","ALL")>

<cfset access_ramp_s1=(#access_ramp_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset access_ramp_s2=(#access_ramp_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset access_ramp_s1=#decimalformat(access_ramp_s1)#>
<cfset access_ramp_s1=ReplaceNoCase("#access_ramp_s1#",",","","ALL")>
<cfset access_ramp_s2=#decimalformat(access_ramp_s2)#>
<cfset access_ramp_s2=ReplaceNoCase("#access_ramp_s2#",",","","ALL")>

<cfset access_ramp_collected_fee=#access_ramp_net_fee#+#access_ramp_s1#+#access_ramp_s2#>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset access_ramp_fee = 0>
<cfset access_ramp_fee_discount = 0>
<cfset access_ramp_net_fee = 0>
<cfset access_ramp_s1 =0>
<cfset access_ramp_s2 = 0>
<cfset access_ramp_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #access_ramp_fee#>
<cfset total_fee_discount=#total_fee_discount# + #access_ramp_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #access_ramp_net_fee#>
<Cfset total_s1=#total_s1#+#access_ramp_s1#>
<cfset total_s2=#total_s2#+#access_ramp_s2#>
<cfset total_collected_fee=#total_collected_fee#+#access_ramp_collected_fee#>

<cfelse>
<cfset access_ramp_fee=0>
<cfset access_ramp_fee_discount=0>
<cfset access_ramp_net_fee=0>

</cfif>
</cfif>
<!-- access ramp(s) Fee -->



<!--- <cfoutput>
access_ramp_fee=#access_ramp_fee#<br>
total_fee=#total_fee#<br>
access_ramp_s1 = #access_ramp_s1#<br>
access_ramp_s2 = #access_ramp_s2#<br>
</cfoutput> --->


<!--alley_intersection(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.alley_intersection_no# gt 0>


<cfif #get_other_items.alley_intersection_no# gt 0 and #get_other_items.alley_intersection_no# lt 10>
<cfset request.alley_intersection_no = 10>
<cfelse>
<cfset request.alley_intersection_no = #get_other_items.alley_intersection_no#>
</cfif>


<cfset alley_intersection_fee=#request.alley_intersection_no#*#get_rates.alley_intersection_uf#>

<cfif #get_other_items.waive_alley_intersection_fee# is "Y">
<cfset alley_intersection_fee_discount=#alley_intersection_fee#>
<!--cfelseif #get_other_items.alley_intersection_fee_discount# is not "" or #get_other_items.alley_intersection_fee_discount# is not 0-->
<!--cfset alley_intersection_fee_discount=#get_other_items.alley_intersection_fee_discount#-->
<cfelse>
<cfset alley_intersection_fee_discount=0>
</cfif>


<cfif #alley_intersection_fee# is "">
<cfset alley_intersection_fee=0>
</cfif>

<cfif #alley_intersection_fee_discount# is "">
<cfset alley_intersection_fee_discount=0>
</cfif>


<cfset alley_intersection_net_fee=#alley_intersection_fee#-#alley_intersection_fee_discount#>
<cfset alley_intersection_net_fee=#decimalformat(alley_intersection_net_fee)#>
<cfset alley_intersection_net_fee=ReplaceNoCase("#alley_intersection_net_fee#",",","","ALL")>

<cfset alley_intersection_s1=(#alley_intersection_net_fee#)*(#get_rates.surcharge_1#/100)>


<cfset alley_intersection_s2=(#alley_intersection_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset alley_intersection_s1=#decimalformat(alley_intersection_s1)#>
<cfset alley_intersection_s1=ReplaceNoCase("#alley_intersection_s1#",",","","ALL")>
<cfset alley_intersection_s2=#decimalformat(alley_intersection_s2)#>
<cfset alley_intersection_s2=ReplaceNoCase("#alley_intersection_s2#",",","","ALL")>

<cfset alley_intersection_collected_fee=#alley_intersection_net_fee#+#alley_intersection_s1#+#alley_intersection_s2#>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset alley_intersection_fee = 0>
<cfset alley_intersection_fee_discount = 0>
<cfset alley_intersection_net_fee = 0>
<cfset alley_intersection_s1 =0>
<cfset alley_intersection_s2 = 0>
<cfset alley_intersection_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #alley_intersection_fee#>
<cfset total_fee_discount=#total_fee_discount# + #alley_intersection_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #alley_intersection_net_fee#>
<Cfset total_s1=#total_s1#+#alley_intersection_s1#>
<cfset total_s2=#total_s2#+#alley_intersection_s2#>
<cfset total_collected_fee=#total_collected_fee#+#alley_intersection_collected_fee#>

<cfelse>
<cfset alley_intersection_fee=0>
<cfset alley_intersection_fee_discount=0>
<cfset alley_intersection_net_fee=0>
</cfif>
</cfif>
<!--alley_intersection(s) Fee -->

<!--- <cfoutput>
alley_intersection_fee=#alley_intersection_fee#<br>
total_fee=#total_fee#<br>
alley_intersection_s1 = #alley_intersection_s1#<br>
alley_intersection_s2 = #alley_intersection_s2#<br>
</cfoutput> --->

<!-- relative_compaction_test(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.relative_compaction_test_no# gt 0>

<cfset relative_compaction_test_fee=#get_other_items.relative_compaction_test_no#*#get_rates.relative_compaction_test_uf#>

<cfif #get_other_items.waive_relative_compaction_test_fee# is "Y">
<cfset relative_compaction_test_fee_discount=#relative_compaction_test_fee#>
<!--cfelseif #get_other_items.relative_compaction_test_fee_discount# is not "" or #get_other_items.relative_compaction_test_fee_discount# is not 0-->
<!--cfset relative_compaction_test_fee_discount=#get_other_items.relative_compaction_test_fee_discount#-->
<cfelse>
<cfset relative_compaction_test_fee_discount=0>
</cfif>

<cfif #relative_compaction_test_fee# is "">
<cfset relative_compaction_test_fee=0>
</cfif>

<cfif #relative_compaction_test_fee_discount# is "">
<cfset relative_compaction_test_fee_discount=0>
</cfif>



<cfset relative_compaction_test_net_fee=#relative_compaction_test_fee#-#relative_compaction_test_fee_discount#>
<cfset relative_compaction_test_net_fee=#decimalformat(relative_compaction_test_net_fee)#>
<cfset relative_compaction_test_net_fee=ReplaceNoCase("#relative_compaction_test_net_fee#",",","","ALL")>

<cfset relative_compaction_test_s1=(#relative_compaction_test_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset relative_compaction_test_s2=(#relative_compaction_test_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset relative_compaction_test_s1=#decimalformat(relative_compaction_test_s1)#>
<cfset relative_compaction_test_s1=ReplaceNoCase("#relative_compaction_test_s1#",",","","ALL")>
<cfset relative_compaction_test_s2=#decimalformat(relative_compaction_test_s2)#>
<cfset relative_compaction_test_s2=ReplaceNoCase("#relative_compaction_test_s2#",",","","ALL")>

<cfset relative_compaction_test_collected_fee=#relative_compaction_test_net_fee#+#relative_compaction_test_s1#+#relative_compaction_test_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset relative_compaction_test_fee = 0>
<cfset relative_compaction_test_fee_discount = 0>
<cfset relative_compaction_test_net_fee = 0>
<cfset relative_compaction_test_s1 =0>
<cfset relative_compaction_test_s2 = 0>
<cfset relative_compaction_test_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #relative_compaction_test_fee#>
<cfset total_fee_discount=#total_fee_discount# + #relative_compaction_test_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #relative_compaction_test_net_fee#>
<Cfset total_s1=#total_s1#+#relative_compaction_test_s1#>
<cfset total_s2=#total_s2#+#relative_compaction_test_s2#>
<cfset total_collected_fee=#total_collected_fee#+#relative_compaction_test_collected_fee#>

<cfelse>
<cfset relative_compaction_test_fee=0>
<cfset relative_compaction_test_fee_discount=0>
<cfset relative_compaction_test_net_fee=0>

</cfif>
</cfif>
<!-- relative_compaction_test(s) Fee -->





<!-- Core Test Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.core_test_no# gt 0>

<cfset core_test_fee=#get_other_items.core_test_no#*#get_rates.core_test_uf#>

<cfif #get_other_items.waive_core_test_fee# is "Y">
<cfset core_test_fee_discount=#core_test_fee#>
<!--cfelseif #get_other_items.core_test_fee_discount# is not "" or #get_other_items.core_test_fee_discount# is not 0-->
<!--cfset core_test_fee_discount=#get_other_items.core_test_fee_discount#-->
<cfelse>
<cfset core_test_fee_discount=0>
</cfif>

<cfset core_test_net_fee=#core_test_fee#-#core_test_fee_discount#>
<cfset core_test_net_fee=#decimalformat(core_test_net_fee)#>
<cfset core_test_net_fee=ReplaceNoCase("#core_test_net_fee#",",","","ALL")>

<cfset core_test_s1=(#core_test_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset core_test_s2=(#core_test_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset core_test_s1=#decimalformat(core_test_s1)#>
<cfset core_test_s1=ReplaceNoCase("#core_test_s1#",",","","ALL")>

<cfset core_test_s2=#decimalformat(core_test_s2)#>
<cfset core_test_s2=ReplaceNoCase("#core_test_s2#",",","","ALL")>

<cfset core_test_collected_fee=#core_test_net_fee#+#core_test_s1#+#core_test_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset core_test_fee = 0>
<cfset core_test_fee_discount = 0>
<cfset core_test_net_fee = 0>
<cfset core_test_s1 =0>
<cfset core_test_s2 = 0>
<cfset core_test_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #core_test_fee#>
<cfset total_fee_discount=#total_fee_discount# + #core_test_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #core_test_net_fee#>
<Cfset total_s1=#total_s1#+#core_test_s1#>
<cfset total_s2=#total_s2#+#core_test_s2#>
<cfset total_collected_fee=#total_collected_fee#+#core_test_collected_fee#>

<cfelse>
<cfset core_test_fee=0>
<cfset core_test_fee_discount=0>
<cfset core_test_net_fee=0>

</cfif>
</cfif>
<!-- Core Test Fee -->



<!-- Concret Curb(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.conc_curb_qty# gt 0>

<cfif #get_other_items.conc_curb_qty# gt 0 and #get_other_items.conc_curb_qty# lt 3>
<cfset request.conc_curb_qty = 3>
<cfelse>
<cfset request.conc_curb_qty = #get_other_items.conc_curb_qty#>
</cfif>


<cfset conc_curb_fee=#request.conc_curb_qty#*#get_rates.conc_curb_uf#>

<cfif #get_other_items.waive_conc_curb_fee# is "Y">
<cfset conc_curb_fee_discount=#conc_curb_fee#>
<!--cfelseif #get_other_items.conc_curb_fee_discount# is not "" or #get_other_items.conc_curb_fee_discount# is not 0-->
<!--cfset conc_curb_fee_discount=#get_other_items.conc_curb_fee_discount#-->
<cfelse>
<cfset conc_curb_fee_discount=0>
</cfif>


<cfif #conc_curb_fee# is "">
<cfset conc_curb_fee=0>
</cfif>

<cfif #conc_curb_fee_discount# is "">
<cfset conc_curb_fee_discount=0>
</cfif>


<cfset conc_curb_net_fee=#conc_curb_fee#-#conc_curb_fee_discount#>
<cfset conc_curb_net_fee=#decimalformat(conc_curb_net_fee)#>
<cfset conc_curb_net_fee=ReplaceNoCase("#conc_curb_net_fee#",",","","ALL")>

<cfset conc_curb_s1=(#conc_curb_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset conc_curb_s2=(#conc_curb_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset conc_curb_s1=#decimalformat(conc_curb_s1)#>
<cfset conc_curb_s1=ReplaceNoCase("#conc_curb_s1#",",","","ALL")>

<cfset conc_curb_s2=#decimalformat(conc_curb_s2)#>
<cfset conc_curb_s2=ReplaceNoCase("#conc_curb_s2#",",","","ALL")>

<cfset conc_curb_collected_fee=#conc_curb_net_fee#+#conc_curb_s1#+#conc_curb_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset conc_curb_fee = 0>
<cfset conc_curb_fee_discount = 0>
<cfset conc_curb_net_fee = 0>
<cfset conc_curb_s1 =0>
<cfset conc_curb_s2 = 0>
<cfset conc_curb_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #conc_curb_fee#>
<cfset total_fee_discount=#total_fee_discount# + #conc_curb_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #conc_curb_net_fee#>
<Cfset total_s1=#total_s1#+#conc_curb_s1#>
<cfset total_s2=#total_s2#+#conc_curb_s2#>
<cfset total_collected_fee=#total_collected_fee#+#conc_curb_collected_fee#>

<cfelse>
<cfset conc_curb_fee=0>
<cfset conc_curb_fee_discount=0>
<cfset conc_curb_net_fee=0>

</cfif>
</cfif>
<!-- Concret Curb(s) Fee -->


<!--- <cfoutput>
conc_curb_fee=#conc_curb_fee#<br>
total_fee=#total_fee#<br>
conc_curb_s1 = #conc_curb_s1#<br>
conc_curb_s2 = #conc_curb_s2#<br>
</cfoutput> --->



<!-- Curb Cut(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.curb_cuts_qty# gt 0>

<cfif #get_other_items.curb_cuts_qty# gt 0 and #get_other_items.curb_cuts_qty# lt 3>
<cfset request.curb_cuts_qty = 3>
<cfelse>
<cfset request.curb_cuts_qty = #get_other_items.curb_cuts_qty#>
</cfif>


<cfset curb_cuts_fee=#request.curb_cuts_qty#*#get_rates.curb_cuts_uf#>

<cfif #get_other_items.waive_curb_cuts_fee# is "Y">
<cfset curb_cuts_fee_discount=#curb_cuts_fee#>
<!--cfelseif #get_other_items.curb_cuts_fee_discount# is not "" or #get_other_items.curb_cuts_fee_discount# is not 0-->
<!--cfset curb_cuts_fee_discount=#get_other_items.curb_cuts_fee_discount#-->
<cfelse>
<cfset curb_cuts_fee_discount=0>
</cfif>


<cfif #curb_cuts_fee# is "">
<cfset curb_cuts_fee=0>
</cfif>

<cfif #curb_cuts_fee_discount# is "">
<cfset curb_cuts_fee_discount=0>
</cfif>


<cfset curb_cuts_net_fee=#curb_cuts_fee#-#curb_cuts_fee_discount#>
<cfset curb_cuts_net_fee=#decimalformat(curb_cuts_net_fee)#>
<cfset curb_cuts_net_fee=ReplaceNoCase("#curb_cuts_net_fee#",",","","ALL")>


<cfset curb_cuts_s1=(#curb_cuts_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset curb_cuts_s2=(#curb_cuts_net_fee#)*(#get_rates.surcharge_2#/100)>


<cfset curb_cuts_s1=#decimalformat(curb_cuts_s1)#>
<cfset curb_cuts_s1=ReplaceNoCase("#curb_cuts_s1#",",","","ALL")>

<cfset curb_cuts_s2=#decimalformat(curb_cuts_s2)#>
<cfset curb_cuts_s2=ReplaceNoCase("#curb_cuts_s2#",",","","ALL")>

<cfset curb_cuts_collected_fee=#curb_cuts_net_fee#+#curb_cuts_s1#+#curb_cuts_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset curb_cuts_fee = 0>
<cfset curb_cuts_fee_discount = 0>
<cfset curb_cuts_net_fee = 0>
<cfset curb_cuts_s1 =0>
<cfset curb_cuts_s2 = 0>
<cfset curb_cuts_collected_fee = 0>
</cfif>

<cfset total_fee=#total_fee# + #curb_cuts_fee#>
<cfset total_fee_discount=#total_fee_discount# + #curb_cuts_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #curb_cuts_net_fee#>
<Cfset total_s1=#total_s1#+#curb_cuts_s1#>
<cfset total_s2=#total_s2#+#curb_cuts_s2#>
<cfset total_collected_fee=#total_collected_fee#+#curb_cuts_collected_fee#>

<cfelse>
<cfset curb_cuts_fee=0>
<cfset curb_cuts_fee_discount=0>
<cfset curb_cuts_net_fee=0>

</cfif>
</cfif>
<!-- Curb Cut(s) Fee -->

<!--- <cfoutput>
curb_cuts_fee=#curb_cuts_fee#<br>
total_fee=#total_fee#<br>
curb_cuts_s1 = #curb_cuts_s1#<br>
curb_cuts_s2 = #curb_cuts_s2#<br>
</cfoutput> --->




<!-- Pipe Inspection Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.pipe_insp_no# gt 0>

<cfset pipe_insp_fee=#request.pipe_insp_no#*#get_rates.pipe_insp_uf#>

<cfif #get_other_items.waive_pipe_insp_fee# is "Y">
<cfset pipe_insp_discount=#pipe_insp_fee#>
<!--cfelseif #get_other_items.pipe_insp_discount# is not "" and #get_other_items.pipe_insp_discount# is not 0-->
<!--cfset pipe_insp_discount=#get_other_items.pipe_insp_discount#-->
<cfelse>
<cfset pipe_insp_discount=0>
</cfif>

<cfif #pipe_insp_fee# is "">
<cfset pipe_insp_fee=0>
</cfif>

<cfif #pipe_insp_discount# is "">
<cfset pipe_insp_discount=0>
</cfif>


<cfset pipe_insp_net_fee=#pipe_insp_fee#-#pipe_insp_discount#>
<cfset pipe_insp_net_fee=#decimalformat(pipe_insp_net_fee)#>
<cfset pipe_insp_net_fee=ReplaceNoCase("#pipe_insp_net_fee#",",","","ALL")>

<cfset pipe_insp_s1=(#pipe_insp_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset pipe_insp_s2=(#pipe_insp_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset pipe_insp_s1=#decimalformat(pipe_insp_s1)#>
<cfset pipe_insp_s1=ReplaceNoCase("#pipe_insp_s1#",",","","ALL")>

<cfset pipe_insp_s2=#decimalformat(pipe_insp_s2)#>
<cfset pipe_insp_s2=ReplaceNoCase("#pipe_insp_s2#",",","","ALL")>

<cfset pipe_insp_collected_fee=#pipe_insp_net_fee#+#pipe_insp_s1#+#pipe_insp_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset pipe_insp_fee = 0>
<cfset pipe_insp_discount = 0>
<cfset pipe_insp_net_fee = 0>
<cfset pipe_insp_s1 =0>
<cfset pipe_insp_s2 = 0>
<cfset pipe_insp_collected_fee = 0>
</cfif>

<cfset total_fee=#total_fee# + #pipe_insp_fee#>
<cfset total_fee_discount=#total_fee_discount# + #pipe_insp_discount#>
<cfset total_net_fee=#total_net_fee# + #pipe_insp_net_fee#>
<Cfset total_s1=#total_s1#+#pipe_insp_s1#>
<cfset total_s2=#total_s2#+#pipe_insp_s2#>
<cfset total_collected_fee=#total_collected_fee#+#pipe_insp_collected_fee#>

<cfelse>
<cfset pipe_insp_fee=0>
<cfset pipe_insp_discount=0>
<cfset pipe_insp_net_fee=0>

</cfif>
</cfif>
<!-- Pipe Inspection Fee -->




<!-- Drain(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.drains_no# gt 0>

<cfset drains_fee=#get_other_items.drains_no#*#get_rates.drains_uf#>

<cfif #get_other_items.waive_drains_fee# is "Y">
<cfset drains_fee_discount=#drains_fee#>
<!--cfelseif #get_other_items.drains_fee_discount# is not "" and #get_other_items.drains_fee_discount# is not 0-->
<!--cfset drains_fee_discount=#get_other_items.drains_fee_discount#-->
<cfelse>
<cfset drains_fee_discount=0>
</cfif>


<cfif #drains_fee# is "">
<cfset drains_fee=0>
</cfif>

<cfif #drains_fee_discount# is "">
<cfset drains_fee_discount=0>
</cfif>


<cfset drains_net_fee=#drains_fee#-#drains_fee_discount#>
<cfset drains_net_fee=#decimalformat(drains_net_fee)#>
<cfset drains_net_fee=ReplaceNoCase("#drains_net_fee#",",","","ALL")>

<cfset drains_s1=(#drains_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset drains_s2=(#drains_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset drains_s1=#decimalformat(drains_s1)#>
<cfset drains_s1=ReplaceNoCase("#drains_s1#",",","","ALL")>

<cfset drains_s2=#decimalformat(drains_s2)#>
<cfset drains_s2=ReplaceNoCase("#drains_s2#",",","","ALL")>

<cfset drains_collected_fee=#drains_net_fee#+#drains_s1#+#drains_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset drains_fee = 0>
<cfset drains_fee_discount = 0>
<cfset drains_net_fee = 0>
<cfset drains_s1 =0>
<cfset drains_s2 = 0>
<cfset drains_collected_fee = 0>
</cfif>

<cfset total_fee=#total_fee# + #drains_fee#>
<cfset total_fee_discount=#total_fee_discount# + #drains_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #drains_net_fee#>
<Cfset total_s1=#total_s1#+#drains_s1#>
<cfset total_s2=#total_s2#+#drains_s2#>
<cfset total_collected_fee=#total_collected_fee#+#drains_collected_fee#>

<cfelse>
<cfset drains_fee=0>
<cfset drains_fee_discount=0>
<cfset drains_net_fee=0>

</cfif>
</cfif>
<!-- Drain(s) Fee -->





<!--Concrete Gutter(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.conc_gutter_qty# gt 0>

<cfif #get_other_items.conc_gutter_qty# gt 0 and #get_other_items.conc_gutter_qty# lt 10>
<cfset request.conc_gutter_qty = 10>
<cfelse>
<cfset request.conc_gutter_qty = #get_other_items.conc_gutter_qty#>
</cfif>


<cfset conc_gutter_fee=#request.conc_gutter_qty#*#get_rates.conc_gutter_uf#>

<cfif #get_other_items.waive_conc_gutter_fee# is "Y">
<cfset conc_gutter_fee_discount=#conc_gutter_fee#>
<!--cfelseif #get_other_items.conc_gutter_fee_discount# is not "" and #get_other_items.conc_gutter_fee_discount# is not 0-->
<!--cfset conc_gutter_fee_discount=#get_other_items.conc_gutter_fee_discount#-->
<cfelse>
<cfset conc_gutter_fee_discount=0>
</cfif>

<cfset conc_gutter_net_fee=#conc_gutter_fee#-#conc_gutter_fee_discount#>


<cfset conc_gutter_net_fee=#decimalformat(conc_gutter_net_fee)#>
<cfset conc_gutter_net_fee=ReplaceNoCase("#conc_gutter_net_fee#",",","","ALL")>

<cfset conc_gutter_s1=(#conc_gutter_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset conc_gutter_s2=(#conc_gutter_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset conc_gutter_s1=#decimalformat(conc_gutter_s1)#>
<cfset conc_gutter_s1=ReplaceNoCase("#conc_gutter_s1#",",","","ALL")>
<cfset conc_gutter_s2=#decimalformat(conc_gutter_s2)#>
<cfset conc_gutter_s2=ReplaceNoCase("#conc_gutter_s2#",",","","ALL")>

<cfset conc_gutter_collected_fee=#conc_gutter_net_fee#+#conc_gutter_s1#+#conc_gutter_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset conc_gutter_fee = 0>
<cfset conc_gutter_fee_discount = 0>
<cfset conc_gutter_net_fee = 0>
<cfset conc_gutter_s1 =0>
<cfset conc_gutter_s2 = 0>
<cfset conc_gutter_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #conc_gutter_fee#>
<cfset total_fee_discount=#total_fee_discount# + #conc_gutter_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #conc_gutter_net_fee#>
<Cfset total_s1=#total_s1#+#conc_gutter_s1#>
<cfset total_s2=#total_s2#+#conc_gutter_s2#>
<cfset total_collected_fee=#total_collected_fee#+#conc_gutter_collected_fee#>

<cfelse>
<cfset conc_gutter_fee=0>
<cfset conc_gutter_fee_discount=0>
<cfset conc_gutter_net_fee=0>

</cfif>
</cfif>
<!--Concrete Gutter(s) Fee -->

<!--- <cfoutput>
conc_gutter_fee=#conc_gutter_fee#<br>
total_fee=#total_fee#<br>
conc_gutter_s1 = #conc_gutter_s1#<br>
conc_gutter_s2 = #conc_gutter_s2#<br>
</cfoutput> --->




<!-- Inspection overtime Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.inspection_ot_no# gt 0>

<cfset inspection_ot_fee=#get_other_items.inspection_ot_no#*#get_rates.inspection_ot_uf#>

<cfif #get_other_items.waive_inspection_ot_fee# is "Y">
<cfset inspection_ot_fee_discount=#inspection_ot_fee#>
<cfelse>
<cfset inspection_ot_fee_discount=0>
</cfif>

<cfset inspection_ot_net_fee=#inspection_ot_fee#-#inspection_ot_fee_discount#>
<cfset inspection_ot_net_fee=#decimalformat(inspection_ot_net_fee)#>
<cfset inspection_ot_net_fee=ReplaceNoCase("#inspection_ot_net_fee#",",","","ALL")>


<cfset inspection_ot_s1=(#inspection_ot_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset inspection_ot_s2=(#inspection_ot_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset inspection_ot_s1=#decimalformat(inspection_ot_s1)#>
<cfset inspection_ot_s1=ReplaceNoCase("#inspection_ot_s1#",",","","ALL")>
<cfset inspection_ot_s2=#decimalformat(inspection_ot_s2)#>
<cfset inspection_ot_s2=ReplaceNoCase("#inspection_ot_s2#",",","","ALL")>

<cfset inspection_ot_collected_fee=#inspection_ot_net_fee#+#inspection_ot_s1#+#inspection_ot_s2#>


<cfif #find_old_permit.ar_nbr# is not "">
<cfset inspection_ot_fee = 0>
<cfset inspection_ot_fee_discount = 0>
<cfset inspection_ot_net_fee = 0>
<cfset inspection_ot_s1 =0>
<cfset inspection_ot_s2 = 0>
<cfset inspection_ot_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #inspection_ot_fee#>
<cfset total_fee_discount=#total_fee_discount# + #inspection_ot_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #inspection_ot_net_fee#>
<Cfset total_s1=#total_s1#+#inspection_ot_s1#>
<cfset total_s2=#total_s2#+#inspection_ot_s2#>
<cfset total_collected_fee=#total_collected_fee#+#inspection_ot_collected_fee#>

<cfelse>
<cfset inspection_ot_fee=0>
<cfset inspection_ot_fee_discount=0>
<cfset inspection_ot_net_fee=0>

</cfif>
</cfif>
<!-- Inspection overtime Fee -->



<!-- MTA Bus Shelter(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.mta_bus_shelter_no# gt 0>

<cfset mta_bus_shelter_fee=#get_other_items.mta_bus_shelter_no#*#get_rates.mta_bus_shelter_uf#>

<cfif #get_other_items.waive_mta_bus_shelter_fee# is "Y">
<cfset mta_bus_shelter_fee_discount=#mta_bus_shelter_fee#>
<cfelse>
<cfset mta_bus_shelter_fee_discount=0>
</cfif>

<cfset mta_bus_shelter_net_fee=#mta_bus_shelter_fee#-#mta_bus_shelter_fee_discount#>
<cfset mta_bus_shelter_net_fee=#decimalformat(mta_bus_shelter_net_fee)#>
<cfset mta_bus_shelter_net_fee=ReplaceNoCase("#mta_bus_shelter_net_fee#",",","","ALL")>


<cfset mta_bus_shelter_s1=(#mta_bus_shelter_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset mta_bus_shelter_s2=(#mta_bus_shelter_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset mta_bus_shelter_s1=#decimalformat(mta_bus_shelter_s1)#>
<cfset mta_bus_shelter_s1=ReplaceNoCase("#mta_bus_shelter_s1#",",","","ALL")>

<cfset mta_bus_shelter_s2=#decimalformat(mta_bus_shelter_s2)#>
<cfset mta_bus_shelter_s2=ReplaceNoCase("#mta_bus_shelter_s2#",",","","ALL")>

<cfset mta_bus_shelter_collected_fee=#mta_bus_shelter_net_fee#+#mta_bus_shelter_s1#+#mta_bus_shelter_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset mta_bus_shelter_fee = 0>
<cfset mta_bus_shelter_fee_discount = 0>
<cfset mta_bus_shelter_net_fee = 0>
<cfset mta_bus_shelter_s1 =0>
<cfset mta_bus_shelter_s2 = 0>
<cfset mta_bus_shelter_collected_fee = 0>
</cfif>

<cfset total_fee=#total_fee# + #mta_bus_shelter_fee#>
<cfset total_fee_discount=#total_fee_discount# + #mta_bus_shelter_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #mta_bus_shelter_net_fee#>
<Cfset total_s1=#total_s1#+#mta_bus_shelter_s1#>
<cfset total_s2=#total_s2#+#mta_bus_shelter_s2#>
<cfset total_collected_fee=#total_collected_fee#+#mta_bus_shelter_collected_fee#>

<cfelse>
<cfset mta_bus_shelter_fee=0>
<cfset mta_bus_shelter_fee_discount=0>
<cfset mta_bus_shelter_net_fee=0>

</cfif>
</cfif>
<!-- MTA Bus Shelter(s) Fee -->




<!-- Special Engineering Regular Time  Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.special_eng_rt_no# gt 0>

<cfset special_eng_rt_fee=#get_other_items.special_eng_rt_no#*#get_rates.special_eng_rt_uf#>

<cfif  #get_other_items.waive_special_eng_rt_fee# is "Y">
<cfset special_eng_rt_fee_discount=#special_eng_rt_fee#>
<cfelse>
<cfset special_eng_rt_fee_discount=0>
</cfif>

<cfset special_eng_rt_net_fee=#special_eng_rt_fee#-#special_eng_rt_fee_discount#>
<cfset special_eng_rt_net_fee=#decimalformat(special_eng_rt_net_fee)#>
<cfset special_eng_rt_net_fee=ReplaceNoCase("#special_eng_rt_net_fee#",",","","ALL")>

<cfset special_eng_rt_s1=(#special_eng_rt_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset special_eng_rt_s2=(#special_eng_rt_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset special_eng_rt_s1=#decimalformat(special_eng_rt_s1)#>
<cfset special_eng_rt_s1=ReplaceNoCase("#special_eng_rt_s1#",",","","ALL")>
<cfset special_eng_rt_s2=#decimalformat(special_eng_rt_s2)#>
<cfset special_eng_rt_s2=ReplaceNoCase("#special_eng_rt_s2#",",","","ALL")>

<cfset special_eng_rt_collected_fee=#special_eng_rt_net_fee#+#special_eng_rt_s1#+#special_eng_rt_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset special_eng_rt_fee = 0>
<cfset special_eng_rt_fee_discount = 0>
<cfset special_eng_rt_net_fee = 0>
<cfset special_eng_rt_s1 =0>
<cfset special_eng_rt_s2 = 0>
<cfset special_eng_rt_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #special_eng_rt_fee#>
<cfset total_fee_discount=#total_fee_discount# + #special_eng_rt_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #special_eng_rt_net_fee#>
<Cfset total_s1=#total_s1#+#special_eng_rt_s1#>
<cfset total_s2=#total_s2#+#special_eng_rt_s2#>
<cfset total_collected_fee=#total_collected_fee#+#special_eng_rt_collected_fee#>

<cfelse>
<cfset special_eng_rt_fee=0>
<cfset special_eng_rt_fee_discount=0>
<cfset special_eng_rt_net_fee=0>

</cfif>
</cfif>
<!-- Special Engineering Regular Time  Fee -->




<!-- Special Inspection Regular Time Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.special_inspection_rt_no# gt 0>

<cfset special_inspection_rt_fee=#get_other_items.special_inspection_rt_no#*#get_rates.special_inspection_rt_uf#>

<cfif #get_other_items.waive_special_inspection_rt_fee# is "Y">
<cfset special_inspection_rt_fee_discount=#special_inspection_rt_fee#>
<cfelse>
<cfset special_inspection_rt_fee_discount=0>
</cfif>

<cfset special_inspection_rt_net_fee=#special_inspection_rt_fee#-#special_inspection_rt_fee_discount#>
<cfset special_inspection_rt_net_fee=#decimalformat(special_inspection_rt_net_fee)#>
<cfset special_inspection_rt_net_fee=ReplaceNoCase("#special_inspection_rt_net_fee#",",","","ALL")>

<cfset special_inspection_rt_s1=(#special_inspection_rt_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset special_inspection_rt_s2=(#special_inspection_rt_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset special_inspection_rt_s1=#decimalformat(special_inspection_rt_s1)#>
<cfset special_inspection_rt_s1=ReplaceNoCase("#special_inspection_rt_s1#",",","","ALL")>
<cfset special_inspection_rt_s2=#decimalformat(special_inspection_rt_s2)#>
<cfset special_inspection_rt_s2=ReplaceNoCase("#special_inspection_rt_s2#",",","","ALL")>

<cfset special_inspection_rt_collected_fee=#special_inspection_rt_net_fee#+#special_inspection_rt_s1#+#special_inspection_rt_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset special_inspection_rt_fee = 0>
<cfset special_inspection_rt_fee_discount = 0>
<cfset special_inspection_rt_net_fee = 0>
<cfset special_inspection_rt_s1 =0>
<cfset special_inspection_rt_s2 = 0>
<cfset special_inspection_rt_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #special_inspection_rt_fee#>
<cfset total_fee_discount=#total_fee_discount# + #special_inspection_rt_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #special_inspection_rt_net_fee#>
<Cfset total_s1=#total_s1#+#special_inspection_rt_s1#>
<cfset total_s2=#total_s2#+#special_inspection_rt_s2#>
<cfset total_collected_fee=#total_collected_fee#+#special_inspection_rt_collected_fee#>

<cfelse>
<cfset special_inspection_rt_fee=0>
<cfset special_inspection_rt_fee_discount=0>
<cfset special_inspection_rt_net_fee=0>

</cfif>
</cfif>
<!-- Special Inspection Regular Time Fee -->



<!-- Standard Density Test Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.standard_density_test_no# gt 0>

<cfset standard_density_test_fee=#get_other_items.standard_density_test_no#*#get_rates.standard_density_test_uf#>

<cfif #get_other_items.waive_standard_density_test_fee# is "Y">
<cfset standard_density_test_fee_discount=#standard_density_test_fee#>
<cfelse>
<cfset standard_density_test_fee_discount=0>
</cfif>

<cfset standard_density_test_net_fee=#standard_density_test_fee#-#standard_density_test_fee_discount#>
<cfset standard_density_test_net_fee=#decimalformat(standard_density_test_net_fee)#>
<cfset standard_density_test_net_fee=ReplaceNoCase("#standard_density_test_net_fee#",",","","ALL")>

<cfset standard_density_test_s1=(#standard_density_test_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset standard_density_test_s2=(#standard_density_test_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset standard_density_test_s1=#decimalformat(standard_density_test_s1)#>
<cfset standard_density_test_s1=ReplaceNoCase("#standard_density_test_s1#",",","","ALL")>
<cfset standard_density_test_s2=#decimalformat(standard_density_test_s2)#>
<cfset standard_density_test_s2=ReplaceNoCase("#standard_density_test_s2#",",","","ALL")>

<cfset standard_density_test_collected_fee=#standard_density_test_net_fee#+#standard_density_test_s1#+#standard_density_test_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset standard_density_test_fee = 0>
<cfset standard_density_test_fee_discount = 0>
<cfset standard_density_test_net_fee = 0>
<cfset standard_density_test_s1 =0>
<cfset standard_density_test_s2 = 0>
<cfset standard_density_test_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #standard_density_test_fee#>
<cfset total_fee_discount=#total_fee_discount# + #standard_density_test_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #standard_density_test_net_fee#>
<Cfset total_s1=#total_s1#+#standard_density_test_s1#>
<cfset total_s2=#total_s2#+#standard_density_test_s2#>
<cfset total_collected_fee=#total_collected_fee#+#standard_density_test_collected_fee#>

<cfelse>
<cfset standard_density_test_fee=0>
<cfset standard_density_test_fee_discount=0>
<cfset standard_density_test_net_fee=0>

</cfif>
</cfif>
<!-- Standard Density Test Fee -->


<!-- Street Resurfacing(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.street_resurfacing_qty# gt 0>


<cfif #get_other_items.street_resurfacing_qty# gt 0 and #get_other_items.street_resurfacing_qty# lt 10>
<cfset request.street_resurfacing_qty = 10>
<cfelse>
<cfset request.street_resurfacing_qty = #get_other_items.street_resurfacing_qty#>
</cfif>



<cfset street_resurfacing_fee=#request.street_resurfacing_qty#*#get_rates.street_resurfacing_uf#>

<cfif #get_other_items.waive_street_resurfacing_fee# is "Y">
<cfset street_resurfacing_fee_discount=#street_resurfacing_fee#>
<cfelse>
<cfset street_resurfacing_fee_discount=0>
</cfif>

<cfset street_resurfacing_net_fee=#street_resurfacing_fee#-#street_resurfacing_fee_discount#>
<cfset street_resurfacing_net_fee=#decimalformat(street_resurfacing_net_fee)#>
<cfset street_resurfacing_net_fee=ReplaceNoCase("#street_resurfacing_net_fee#",",","","ALL")>

<cfset street_resurfacing_s1=(#street_resurfacing_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset street_resurfacing_s2=(#street_resurfacing_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset street_resurfacing_s1=#decimalformat(street_resurfacing_s1)#>
<cfset street_resurfacing_s1=ReplaceNoCase("#street_resurfacing_s1#",",","","ALL")>
<cfset street_resurfacing_s2=#decimalformat(street_resurfacing_s2)#>
<cfset street_resurfacing_s2=ReplaceNoCase("#street_resurfacing_s2#",",","","ALL")>

<cfset street_resurfacing_collected_fee=#street_resurfacing_net_fee#+#street_resurfacing_s1#+#street_resurfacing_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset street_resurfacing_fee = 0>
<cfset street_resurfacing_fee_discount = 0>
<cfset street_resurfacing_net_fee = 0>
<cfset street_resurfacing_s1 =0>
<cfset street_resurfacing_s2 = 0>
<cfset street_resurfacing_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #street_resurfacing_fee#>
<cfset total_fee_discount=#total_fee_discount# + #street_resurfacing_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #street_resurfacing_net_fee#>
<Cfset total_s1=#total_s1#+#street_resurfacing_s1#>
<cfset total_s2=#total_s2#+#street_resurfacing_s2#>
<cfset total_collected_fee=#total_collected_fee#+#street_resurfacing_collected_fee#>

<cfelse>
<cfset street_resurfacing_fee=0>
<cfset street_resurfacing_fee_discount=0>
<cfset street_resurfacing_net_fee=0>

</cfif>
</cfif>
<!-- Street Resurfacing(s) Fee -->


<!-- Tree Well(s) Fee -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.tree_well_no# gt 0>

<cfset tree_well_fee=#get_other_items.tree_well_no#*#get_rates.tree_well_uf#>

<cfif #get_other_items.waive_tree_well_fee# is "Y">
<cfset tree_well_fee_discount=#tree_well_fee#>
<cfelse>
<cfset tree_well_fee_discount=0>
</cfif>

<cfset tree_well_net_fee=#tree_well_fee#-#tree_well_fee_discount#>
<cfset tree_well_net_fee=#decimalformat(tree_well_net_fee)#>
<cfset tree_well_net_fee=ReplaceNoCase("#tree_well_net_fee#",",","","ALL")>

<cfset tree_well_s1=(#tree_well_net_fee#)*(#get_rates.surcharge_1#/100)>
<cfset tree_well_s2=(#tree_well_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset tree_well_s1=#decimalformat(tree_well_s1)#>
<cfset tree_well_s1=ReplaceNoCase("#tree_well_s1#",",","","ALL")>
<cfset tree_well_s2=#decimalformat(tree_well_s2)#>
<cfset tree_well_s2=ReplaceNoCase("#tree_well_s2#",",","","ALL")>

<cfset tree_well_collected_fee=#tree_well_net_fee#+#tree_well_s1#+#tree_well_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset tree_well_fee = 0>
<cfset tree_well_fee_discount = 0>
<cfset tree_well_net_fee = 0>
<cfset tree_well_s1 =0>
<cfset tree_well_s2 = 0>
<cfset tree_well_collected_fee = 0>
</cfif>


<cfset total_fee=#total_fee# + #tree_well_fee#>
<cfset total_fee_discount=#total_fee_discount# + #tree_well_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #tree_well_net_fee#>
<Cfset total_s1=#total_s1#+#tree_well_s1#>
<cfset total_s2=#total_s2#+#tree_well_s2#>
<cfset total_collected_fee=#total_collected_fee#+#tree_well_collected_fee#>

<cfelse>
<cfset tree_well_fee=0>
<cfset tree_well_fee_discount=0>
<cfset tree_well_net_fee=0>

</cfif>
</cfif>
<!-- Tree Well(s) Fee -->














<!-- 15 GAL Street Trees PKWY and Maintenance -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.tree_15_pkwy_nbr# gt 0>

<cfset tree_15_pkwy_fee=#get_other_items.tree_15_pkwy_nbr#*#get_rates.tree_15_gal_pkwy_uf#>
<cfset tree_15_pkwy_maint_fee=#get_other_items.tree_15_pkwy_nbr#*#get_rates.tree_15_gal_pkwy_maint_uf#>

<cfset total_net_fee=#total_net_fee# + #tree_15_pkwy_fee#+ #tree_15_pkwy_maint_fee#>


<cfset tree_15_pkwy_maint_s1=(#tree_15_pkwy_maint_fee#)*(#get_rates.surcharge_1#/100)>
<cfset tree_15_pkwy_maint_s2=0>


<cfset total_fee=#total_fee# + #tree_15_pkwy_fee#+ #tree_15_pkwy_maint_fee# + #tree_15_pkwy_maint_s1#>



<cfset total_collected_fee=#total_collected_fee#+ #tree_15_pkwy_fee#+ #tree_15_pkwy_maint_fee# + #tree_15_pkwy_maint_s1#>


<cfelse>
<cfset tree_15_pkwy_fee=0>
<cfset tree_15_pkwy_maint_fee=0>

</cfif>
</cfif>
<!-- 15 GAL Street Trees PKWY and Maintenance -->



<!-- 15 GAL Street Trees Sidewalk and Maintenance -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.tree_15_sidewalk_nbr# gt 0>

<cfset tree_15_sidewalk_fee=#get_other_items.tree_15_sidewalk_nbr#*#get_rates.tree_15_gal_sidewalk_uf#>
<cfset tree_15_sidewalk_maint_fee=#get_other_items.tree_15_sidewalk_nbr#*#get_rates.tree_15_gal_sidewalk_maint_uf#>


<cfset total_net_fee=#total_net_fee# + #tree_15_sidewalk_fee#+ #tree_15_sidewalk_maint_fee#>


<cfset tree_15_sidewalk_maint_s1=(#tree_15_sidewalk_maint_fee#)*(#get_rates.surcharge_1#/100)>
<cfset tree_15_sidewalk_maint_s2=0>


<cfset total_fee=#total_fee# + #tree_15_sidewalk_fee#+ #tree_15_sidewalk_maint_fee# + #tree_15_sidewalk_maint_s1#>



<cfset total_collected_fee=#total_collected_fee#+ #tree_15_sidewalk_fee#+ #tree_15_sidewalk_maint_fee# + #tree_15_sidewalk_maint_s1#>

<cfelse>
<cfset tree_15_sidewalk_fee=0>
<cfset tree_15_sidewalk_maint_fee=0>

</cfif>
</cfif>
<!-- 15 GAL Street Trees Sidewalk and Maintenance -->





<!-- 24 inch box Street Trees PKWY and Maintenance -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.tree_24_box_pkwy_nbr# gt 0>

<cfset tree_24_box_pkwy_fee=#get_other_items.tree_24_box_pkwy_nbr#*#get_rates.tree_24_box_pkwy_uf#>
<cfset tree_24_box_pkwy_maint_fee=#get_other_items.tree_24_box_pkwy_nbr#*#get_rates.tree_24_box_pkwy_maint_uf#>

<cfset total_net_fee=#total_net_fee# + #tree_24_box_pkwy_fee#+ #tree_24_box_pkwy_maint_fee#>

<cfset tree_24_box_pkwy_maint_s1=(#tree_24_box_pkwy_maint_fee#)*(#get_rates.surcharge_1#/100)>
<cfset tree_24_box_pkwy_maint_s2=0>


<cfset total_fee=#total_fee# + #tree_24_box_pkwy_fee#+ #tree_24_box_pkwy_maint_fee# + #tree_24_box_pkwy_maint_s1#>






<cfset total_collected_fee=#total_collected_fee#+ #tree_24_box_pkwy_fee#+ #tree_24_box_pkwy_maint_fee# + #tree_24_box_pkwy_maint_s1#>


<cfelse>
<cfset tree_24_box_pkwy_fee=0>
<cfset tree_24_box_pkwy_maint_fee=0>

</cfif>
</cfif>
<!-- 24 inch Street Trees PKWY and Maintenance -->



<!-- 24 inch box Street Trees sidewalk and Maintenance -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.tree_24_box_sidewalk_nbr# gt 0>

<cfset tree_24_box_sidewalk_fee=#get_other_items.tree_24_box_sidewalk_nbr#*#get_rates.tree_24_box_sidewalk_uf#>
<cfset tree_24_box_sidewalk_maint_fee=#get_other_items.tree_24_box_sidewalk_nbr#*#get_rates.tree_24_box_sidewalk_maint_uf#>

<cfset total_net_fee=#total_net_fee# + #tree_24_box_sidewalk_fee#+ #tree_24_box_sidewalk_maint_fee#>


<cfset tree_24_box_sidewalk_maint_s1=(#tree_24_box_sidewalk_maint_fee#)*(#get_rates.surcharge_1#/100)>
<cfset tree_24_box_sidewalk_maint_s2=0>


<cfset total_fee=#total_fee# + #tree_24_box_sidewalk_fee#+ #tree_24_box_sidewalk_maint_fee# +#tree_24_box_sidewalk_maint_s1#>





<cfset total_collected_fee=#total_collected_fee#+ #tree_24_box_sidewalk_fee#+ #tree_24_box_sidewalk_maint_fee# +#tree_24_box_sidewalk_maint_s1#>


<!--- <cfoutput>
#get_rates.surcharge_1#<br>
#tree_24_box_sidewalk_maint_s1#<br>
#tree_24_box_sidewalk_maint_fee#<br>
#total_collected_fee#
</cfoutput>
 --->


<cfelse>
<cfset tree_24_box_sidewalk_fee=0>
<cfset tree_24_box_sidewalk_maint_fee=0>

</cfif>
</cfif>
<!-- 24 inch Street Trees PKWY and Maintenance -->


























<!-- sdrf  Fee   No surcharge on SDRF-->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.sdrf_qty# gt 0>

<cfset sdrf_fee=#get_other_items.sdrf_qty#*#get_other_items.sdrf_rate#>

<cfif #get_other_items.waive_sdrf_fee# is "Y">
<cfset sdrf_fee_discount=#sdrf_fee#>
<!--cfelseif #get_other_items.sdrf_fee_discount# is not "" and #get_other_items.sdrf_fee_discount# is not 0-->
<!--cfset sdrf_fee_discount=#get_other_items.sdrf_fee_discount#-->
<cfelse>
<cfset sdrf_fee_discount=0>
</cfif>

<cfset sdrf_net_fee=#sdrf_fee#-#sdrf_fee_discount#>

<cfset sdrf_s1=0>

<cfset sdrf_s2=0>

<cfset sdrf_collected_fee=#sdrf_net_fee#+#sdrf_s1#+#sdrf_s2#>

<cfset total_fee=#total_fee# + #sdrf_fee#>
<cfset total_fee_discount=#total_fee_discount# + #sdrf_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #sdrf_net_fee#>
<Cfset total_s1=#total_s1#+#sdrf_s1#>
<cfset total_s2=#total_s2#+#sdrf_s2#>
<cfset total_collected_fee=#total_collected_fee#+#sdrf_collected_fee#>

<cfelse>
<cfset sdrf_fee=0>
<cfset sdrf_fee_discount=0>
<cfset sdrf_net_fee=0>

</cfif>
</cfif>
<!-- sdrf  Fee   No surcharge on SDRF-->






<!-- ssdrf  Fee   No surcharge on SSDRF-->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.ssdrf_fee# gt 0>

<cfset ssdrf_fee=#get_other_items.ssdrf_fee#>
<cfif #ssdrf_fee# is "">
<cfset ssdrf_fee = 0>
</cfif>

<cfif #get_other_items.waive_ssdrf_fee# is "Y">
<cfset ssdrf_fee_discount=#ssdrf_fee#>
<!--cfelseif #get_other_items.sdrf_fee_discount# is not "" and #get_other_items.sdrf_fee_discount# is not 0-->
<!--cfset sdrf_fee_discount=#get_other_items.sdrf_fee_discount#-->
<cfelse>
<cfset ssdrf_fee_discount=0>
</cfif>

<cfset ssdrf_net_fee=#ssdrf_fee#-#ssdrf_fee_discount#>

<cfset ssdrf_s1=0>
<cfset ssdrf_s2=0>

<cfset ssdrf_collected_fee=#ssdrf_net_fee#+#ssdrf_s1#+#ssdrf_s2#>

<cfset total_fee=#total_fee# + #ssdrf_fee#>
<cfset total_fee_discount=#total_fee_discount# + #ssdrf_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #ssdrf_net_fee#>
<Cfset total_s1=#total_s1#+#ssdrf_s1#>
<cfset total_s2=#total_s2#+#ssdrf_s2#>
<cfset total_collected_fee=#total_collected_fee#+#ssdrf_collected_fee#>

<cfelse>
<cfset ssdrf_fee=0>
<cfset ssdrf_fee_discount=0>
<cfset ssdrf_net_fee=0>

</cfif>
</cfif>
<!-- ssdrf  Fee   No surcharge on SSDRF-->







<!-- Additional Fee(s) Fee -->
<!--- <cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.additional_fee# gt 0>


<cfset additional_fee=#get_other_items.additional_fee#>

<cfif #get_other_items.waive_additional_fee# is "Y">
<cfset additional_fee_discount=#additional_fee#>
<!--cfelseif #get_other_items.additional_fee_discount# is not "" and #get_other_items.additional_fee_discount# is not 0-->
<!--cfset additional_fee_discount=#get_other_items.additional_fee_discount#-->
<cfelse>
<cfset additional_fee_discount=0>
</cfif>

<cfset additional_net_fee=#additional_fee#-#additional_fee_discount#>

<cfset additional_s1=(#additional_net_fee#)*(#get_rates.surcharge_1#/100)>



<cfset additional_s2=(#additional_net_fee#)*(#get_rates.surcharge_2#/100)>

<cfset additional_collected_fee=#additional_net_fee#+#additional_s1#+#additional_s2#>

<cfif #find_old_permit.ar_nbr# is not "">
<cfset additional_fee = 0>
<cfset additional_fee_discount = 0>
<cfset additional_net_fee = 0>
<cfset additional_s1 =0>
<cfset additional_s2 = 0>
<cfset additional_collected_fee = 0>
</cfif>



<cfset total_fee=#total_fee# + #additional_fee#>
<cfset total_fee_discount=#total_fee_discount# + #additional_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #additional_net_fee#>
<Cfset total_s1=#total_s1#+#additional_s1#>
<cfset total_s2=#total_s2#+#additional_s2#>
<cfset total_collected_fee=#total_collected_fee#+#additional_collected_fee#>

<cfelse>
<cfset additional_fee=0>
<cfset additional_fee_discount=0>
<cfset additional_net_fee=0>

</cfif>
</cfif> --->


<!-- Additional Fee(s) Fee -->
<!-- Additional Fee(s) Fee -->





<!-- SDRF Admin Fee(s)  -->
<cfif #get_other_items.recordcount# is not 0>
<Cfif #get_other_items.sdrf_fee# gt 0 or #get_other_items.ssdrf_fee# gt 0>

<cfset sdrf_admin_fee=#get_rates.sdrf_admin_uf#>

<cfif #get_other_items.waive_sdrf_admin_fee# is "Y">
<cfset sdrf_admin_fee_discount=#sdrf_admin_fee#>
<!--cfelseif #get_other_items.additional_fee_discount# is not "" and #get_other_items.additional_fee_discount# is not 0-->
<!--cfset additional_fee_discount=#get_other_items.additional_fee_discount#-->
<cfelse>
<cfset sdrf_admin_fee_discount=0>
</cfif>


<cfif #sdrf_admin_fee# is "">
<cfset sdrf_admin_fee=0>
</cfif>
<cfset sdrf_admin_net_fee=#sdrf_admin_fee#-#sdrf_admin_fee_discount#>


<cfif #find_old_permit.rate_nbr# lt 11>
<cfset sdrf_admin_s1=0>
<cfset sdrf_admin_s2=0>
<cfelse>
<cfset sdrf_admin_s1=(#get_rates.sdrf_admin_uf#)*(#get_rates.surcharge_1#/100)>
<cfset sdrf_admin_s2=(#get_rates.sdrf_admin_uf#)*(#get_rates.surcharge_2#/100)>
</cfif>




<cfset sdrf_admin_collected_fee=#sdrf_admin_net_fee#+#sdrf_admin_s1#+#sdrf_admin_s2#>

<cfset total_fee=#total_fee# + #sdrf_admin_fee#>
<cfset total_fee_discount=#total_fee_discount# + #sdrf_admin_fee_discount#>
<cfset total_net_fee=#total_net_fee# + #sdrf_admin_net_fee#>
<Cfset total_s1=#total_s1#+#sdrf_admin_s1#>
<cfset total_s2=#total_s2#+#sdrf_admin_s2#>
<cfset total_collected_fee=#total_collected_fee#+#sdrf_admin_collected_fee#>

<cfelse>
<cfset sdrf_admin_fee=0>
<cfset sdrf_admin_fee_discount=0>
<cfset sdrf_admin_net_fee=0>
<cfset sdrf_admin_s1=0>
<cfset sdrf_admin_s2=0>
</cfif>
</cfif>





<!-- SDRF Admin Fee(s) -->




<CFQUERY NAME="tree_fees" DATASOURCE="apermits_sql">
select sum(tree_15_pkwy_fee+tree_15_pkwy_maint_fee+tree_15_sidewalk_fee+tree_15_sidewalk_maint_fee+tree_24_box_pkwy_fee+tree_24_box_pkwy_maint_fee+tree_24_box_sidewalk_fee+tree_24_box_sidewalk_maint_fee) as tree_fees
from other_items
where ref_no = #request.ref_no#
</CFQUERY>


<!-- cfif #total_s1# lt 1 and #total_net_fee# gt 0 -->
<!-- cfset total_s1 = 1 -->
<!-- /cfif -->

<cfif #total_s1# gt 0 and #total_s1# lt 1>
<Cfset total_s1 = 1>
</cfif>

<cfif #total_s2# gt 0 and #total_s2# lt 1>
<Cfset total_s2 = 1>
</cfif>


<cfquery name="update_permit_info" datasource="apermits_sql" dbtype="datasource">
update permit_info
set
basic_fee=#basic_fee#,
basic_fee_discount=#basic_fee_discount#,
basic_net_fee=#basic_net_fee#,

total_fee=#total_fee#,
total_fee_discount=#total_fee_discount#,
total_net_fee=#total_net_fee#,
total_s1=#total_s1#,
total_s2=#total_s2#,
total_collected_fee=#total_collected_fee#

where ref_no=#request.ref_no#
</cfquery>


<cfif #get_other_items.recordcount# is not 0>

<!---<cfmail to="essam.amarragy@lacity.org" from="eng.lapermits@lacity.org" subject="Ref. No. #request.ref_no# Query Update All Fees">
update other_items
set


partial_dwy_conc_qty=#request.partial_dwy_conc_qty#,
partial_dwy_conc_fee=#partial_dwy_conc_fee#,
partial_dwy_conc_fee_discount=#partial_dwy_conc_fee_discount#,
partial_dwy_conc_net_fee=#partial_dwy_conc_net_fee#,


partial_dwy_asphalt_qty=#request.partial_dwy_asphalt_qty#,
partial_dwy_asphalt_fee=#partial_dwy_asphalt_fee#,
partial_dwy_asphalt_fee_discount=#partial_dwy_asphalt_fee_discount#,
partial_dwy_asphalt_net_fee=#partial_dwy_asphalt_net_fee#,

access_ramp_qty=#request.access_ramp_qty#,
access_ramp_fee=#access_ramp_fee#,
access_ramp_fee_discount=#access_ramp_fee_discount#,
access_ramp_net_fee=#access_ramp_net_fee#,


alley_intersection_no=#request.alley_intersection_no#,
alley_intersection_fee=#alley_intersection_fee#,
alley_intersection_fee_discount=#alley_intersection_fee_discount#,
alley_intersection_net_fee=#alley_intersection_net_fee#,

relative_compaction_test_fee=#relative_compaction_test_fee#,
relative_compaction_test_fee_discount=#relative_compaction_test_fee_discount#,
relative_compaction_test_net_fee=#relative_compaction_test_net_fee#,

core_test_fee=#core_test_fee#,
core_test_fee_discount=#core_test_fee_discount#,
core_test_net_fee=#core_test_net_fee#,

conc_curb_qty=#request.conc_curb_qty#,
conc_curb_fee=#conc_curb_fee#,
conc_curb_fee_discount=#conc_curb_fee_discount#,
conc_curb_net_fee=#conc_curb_net_fee#,


curb_cuts_qty=#request.curb_cuts_qty#,
curb_cuts_fee=#curb_cuts_fee#,
curb_cuts_fee_discount=#curb_cuts_fee_discount#,
curb_cuts_net_fee=#curb_cuts_net_fee#,


pipe_insp_fee=#pipe_insp_fee#,
pipe_insp_discount=#pipe_insp_discount#,
pipe_insp_net_fee=#pipe_insp_net_fee#,

drains_fee=#drains_fee#,
drains_fee_discount=#drains_fee_discount#,
drains_net_fee=#drains_net_fee#,


conc_gutter_qty=#request.conc_gutter_qty#,
conc_gutter_fee=#conc_gutter_fee#,
conc_gutter_fee_discount=#conc_gutter_fee_discount#,
conc_gutter_net_fee=#conc_gutter_net_fee#,

inspection_ot_fee=#inspection_ot_fee#,
inspection_ot_fee_discount=#inspection_ot_fee_discount#,
inspection_ot_net_fee=#inspection_ot_net_fee#,

mta_bus_shelter_fee=#mta_bus_shelter_fee#,
mta_bus_shelter_fee_discount=#mta_bus_shelter_fee_discount#,
mta_bus_shelter_net_fee=#mta_bus_shelter_net_fee#,

special_eng_rt_fee=#special_eng_rt_fee#,
special_eng_rt_fee_discount=#special_eng_rt_fee_discount#,
special_eng_rt_net_fee=#special_eng_rt_net_fee#,

special_inspection_rt_fee=#special_inspection_rt_fee#,
special_inspection_rt_fee_discount=#special_inspection_rt_fee_discount#,
special_inspection_rt_net_fee=#special_inspection_rt_net_fee#,

standard_density_test_fee=#standard_density_test_fee#,
standard_density_test_fee_discount=#standard_density_test_fee_discount#,
standard_density_test_net_fee=#standard_density_test_net_fee#,



street_resurfacing_qty=#request.street_resurfacing_qty#,
street_resurfacing_fee=#street_resurfacing_fee#,
street_resurfacing_fee_discount=#street_resurfacing_fee_discount#,
street_resurfacing_net_fee=#street_resurfacing_net_fee#,

tree_well_fee=#tree_well_fee#,
tree_well_fee_discount=#tree_well_fee_discount#,
tree_well_net_fee=#tree_well_net_fee#,



tree_15_pkwy_fee=#tree_15_pkwy_fee#,
tree_15_pkwy_maint_fee=#tree_15_pkwy_maint_fee#,

tree_15_sidewalk_fee=#tree_15_sidewalk_fee#,
tree_15_sidewalk_maint_fee=#tree_15_sidewalk_maint_fee#,


tree_24_box_pkwy_fee=#tree_24_box_pkwy_fee#,
tree_24_box_pkwy_maint_fee=#tree_24_box_pkwy_maint_fee#,

tree_24_box_sidewalk_fee=#tree_24_box_sidewalk_fee#,
tree_24_box_sidewalk_maint_fee=#tree_24_box_sidewalk_maint_fee#,



sdrf_fee=#sdrf_fee#,
sdrf_fee_discount=#sdrf_fee_discount#,
sdrf_net_fee=#sdrf_net_fee#,

ssdrf_fee=#ssdrf_fee#,
ssdrf_fee_discount=#ssdrf_fee_discount#,
ssdrf_net_fee=#ssdrf_net_fee#,

additional_fee=#additional_fee#,
additional_fee_discount=#additional_fee_discount#,
additional_net_fee=#additional_net_fee#,

sdrf_admin_fee=#sdrf_admin_fee#,
sdrf_admin_fee_discount=#sdrf_admin_fee_discount#,
sdrf_admin_net_fee=#sdrf_admin_net_fee#

where ref_no=#request.ref_no#
</cfmail>--->



<cfquery name="update_other_items" datasource="apermits_sql" dbtype="datasource">
update other_items
set

<cfif #request.partial_dwy_conc_qty# is not "">
partial_dwy_conc_qty=#toSqlNumeric(request.partial_dwy_conc_qty)#,
</cfif>

partial_dwy_conc_fee=#toSqlNumeric(partial_dwy_conc_fee)#,
partial_dwy_conc_fee_discount=#toSqlNumeric(partial_dwy_conc_fee_discount)#,
partial_dwy_conc_net_fee=#toSqlNumeric(partial_dwy_conc_net_fee)#,

<!--- <cfif #request.partial_dwy_asphalt_qty# is not ""> --->
partial_dwy_asphalt_qty=#toSqlNumeric(request.partial_dwy_asphalt_qty)#,
<!--- </cfif> --->
partial_dwy_asphalt_fee=#toSqlNumeric(partial_dwy_asphalt_fee)#,
partial_dwy_asphalt_fee_discount=#toSqlNumeric(partial_dwy_asphalt_fee_discount)#,
partial_dwy_asphalt_net_fee=#toSqlNumeric(partial_dwy_asphalt_net_fee)#,

<!--- <cfif #request.access_ramp_qty# is not ""> --->
access_ramp_qty=#toSqlNumeric(request.access_ramp_qty)#,
<!--- </cfif> --->
access_ramp_fee=#toSqlNumeric(access_ramp_fee)#,
access_ramp_fee_discount=#toSqlNumeric(access_ramp_fee_discount)#,
access_ramp_net_fee=#toSqlNumeric(access_ramp_net_fee)#,

<!--- <cfif #request.alley_intersection_no# is not ""> --->
alley_intersection_no=#toSqlNumeric(request.alley_intersection_no)#,
<!--- </cfif> --->

alley_intersection_fee=#toSqlNumeric(alley_intersection_fee)#,
alley_intersection_fee_discount=#toSqlNumeric(alley_intersection_fee_discount)#,
alley_intersection_net_fee=#toSqlNumeric(alley_intersection_net_fee)#,

relative_compaction_test_fee=#toSqlNumeric(relative_compaction_test_fee)#,
relative_compaction_test_fee_discount=#toSqlNumeric(relative_compaction_test_fee_discount)#,
relative_compaction_test_net_fee=#toSqlNumeric(relative_compaction_test_net_fee)#,

core_test_fee=#toSqlNumeric(core_test_fee)#,
core_test_fee_discount=#toSqlNumeric(core_test_fee_discount)#,
core_test_net_fee=#toSqlNumeric(core_test_net_fee)#,

conc_curb_qty=#toSqlNumeric(request.conc_curb_qty)#,
conc_curb_fee=#toSqlNumeric(conc_curb_fee)#,
conc_curb_fee_discount=#toSqlNumeric(conc_curb_fee_discount)#,
conc_curb_net_fee=#toSqlNumeric(conc_curb_net_fee)#,

<!--- <cfif #request.curb_cuts_qty# is not ""> --->
curb_cuts_qty=#toSqlNumeric(request.curb_cuts_qty)#,
<!--- </cfif> --->
curb_cuts_fee=#toSqlNumeric(curb_cuts_fee)#,
curb_cuts_fee_discount=#toSqlNumeric(curb_cuts_fee_discount)#,
curb_cuts_net_fee=#toSqlNumeric(curb_cuts_net_fee)#,


pipe_insp_fee=#toSqlNumeric(pipe_insp_fee)#,
pipe_insp_discount=#toSqlNumeric(pipe_insp_discount)#,
pipe_insp_net_fee=#toSqlNumeric(pipe_insp_net_fee)#,

drains_fee=#toSqlNumeric(drains_fee)#,
drains_fee_discount=#toSqlNumeric(drains_fee_discount)#,
drains_net_fee=#toSqlNumeric(drains_net_fee)#,

<!--- <cfif #request.conc_gutter_qty# is not ""> --->
conc_gutter_qty=#toSqlNumeric(request.conc_gutter_qty)#,
<!--- </cfif> --->
conc_gutter_fee=#toSqlNumeric(conc_gutter_fee)#,
conc_gutter_fee_discount=#toSqlNumeric(conc_gutter_fee_discount)#,
conc_gutter_net_fee=#toSqlNumeric(conc_gutter_net_fee)#,

inspection_ot_fee=#toSqlNumeric(inspection_ot_fee)#,
inspection_ot_fee_discount=#toSqlNumeric(inspection_ot_fee_discount)#,
inspection_ot_net_fee=#toSqlNumeric(inspection_ot_net_fee)#,

mta_bus_shelter_fee=#toSqlNumeric(mta_bus_shelter_fee)#,
mta_bus_shelter_fee_discount=#toSqlNumeric(mta_bus_shelter_fee_discount)#,
mta_bus_shelter_net_fee=#toSqlNumeric(mta_bus_shelter_net_fee)#,

special_eng_rt_fee=#toSqlNumeric(special_eng_rt_fee)#,
special_eng_rt_fee_discount=#toSqlNumeric(special_eng_rt_fee_discount)#,
special_eng_rt_net_fee=#toSqlNumeric(special_eng_rt_net_fee)#,

special_inspection_rt_fee=#toSqlNumeric(special_inspection_rt_fee)#,
special_inspection_rt_fee_discount=#toSqlNumeric(special_inspection_rt_fee_discount)#,
special_inspection_rt_net_fee=#toSqlNumeric(special_inspection_rt_net_fee)#,

standard_density_test_fee=#toSqlNumeric(standard_density_test_fee)#,
standard_density_test_fee_discount=#toSqlNumeric(standard_density_test_fee_discount)#,
standard_density_test_net_fee=#toSqlNumeric(standard_density_test_net_fee)#,


<!--- <cfif #request.street_resurfacing_qty# is not ""> --->
street_resurfacing_qty=#toSqlNumeric(request.street_resurfacing_qty)#,
<!--- </cfif> --->
street_resurfacing_fee=#toSqlNumeric(street_resurfacing_fee)#,
street_resurfacing_fee_discount=#toSqlNumeric(street_resurfacing_fee_discount)#,
street_resurfacing_net_fee=#toSqlNumeric(street_resurfacing_net_fee)#,

tree_well_fee=#toSqlNumeric(tree_well_fee)#,
tree_well_fee_discount=#toSqlNumeric(tree_well_fee_discount)#,
tree_well_net_fee=#toSqlNumeric(tree_well_net_fee)#,



tree_15_pkwy_fee=#toSqlNumeric(tree_15_pkwy_fee)#,
tree_15_pkwy_maint_fee=#toSqlNumeric(tree_15_pkwy_maint_fee)#,

tree_15_sidewalk_fee=#toSqlNumeric(tree_15_sidewalk_fee)#,
tree_15_sidewalk_maint_fee=#toSqlNumeric(tree_15_sidewalk_maint_fee)#,


tree_24_box_pkwy_fee=#toSqlNumeric(tree_24_box_pkwy_fee)#,
tree_24_box_pkwy_maint_fee=#toSqlNumeric(tree_24_box_pkwy_maint_fee)#,

tree_24_box_sidewalk_fee=#toSqlNumeric(tree_24_box_sidewalk_fee)#,
tree_24_box_sidewalk_maint_fee=#toSqlNumeric(tree_24_box_sidewalk_maint_fee)#,



sdrf_fee=#toSqlNumeric(sdrf_fee)#,
sdrf_fee_discount=#toSqlNumeric(sdrf_fee_discount)#,
sdrf_net_fee=#toSqlNumeric(sdrf_net_fee)#,

ssdrf_fee=#toSqlNumeric(ssdrf_fee)#,
ssdrf_fee_discount=#toSqlNumeric(ssdrf_fee_discount)#,
ssdrf_net_fee=#toSqlNumeric(ssdrf_net_fee)#,

<!--- additional_fee=#toSqlNumeric(additional_fee)#,
additional_fee_discount=#toSqlNumeric(additional_fee_discount)#,
additional_net_fee=#toSqlNumeric(additional_net_fee)#, --->

sdrf_admin_fee=#toSqlNumeric(sdrf_admin_fee)#,
sdrf_admin_fee_discount=#toSqlNumeric(sdrf_admin_fee_discount)#,
sdrf_admin_net_fee=#toSqlNumeric(sdrf_admin_net_fee)#

where ref_no=#request.ref_no#
</cfquery>
</cfif>

<!--- <cfoutput>
total_collected_fee=#total_collected_fee#
</cfoutput> --->
