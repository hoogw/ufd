<cfinclude template="/common/validate_referer.cfm">

<cfset total_s1=0>
<cfset total_s2=0>

<!-- delete all records that belong to this ref_no from revenue_distribution table -->
<cfquery name="del_records" datasource="#request.revenue_distribution#" dbtype="ODBC">
delete from revenue_distribution
where ref_no = #request.ref_no# and permit_code='#left(request.permit_code,12)#'
</cfquery>

<cfquery name="find_permit" datasource="#request.dsn#" dbtype="ODBC">
SELECT     fee_rates.permit_fee as permit_fee, (fee_rates.per_card_fee * ISNULL(permit_info.nbr_of_cards , 0)) as card_fees, ISNULL(fee_rates.surcharge_1 , 0) as surcharge_1, ISNULL(fee_rates.surcharge_2 , 0) as surcharge_2
FROM         fee_rates RIGHT OUTER JOIN
                     permit_info ON fee_rates.rate_nbr = permit_info.rate_nbr

 where ref_no=#request.ref_no#
</cfquery>



<!-- MH Permit Annual Fee -->
<cfset request.quickcode=177>


<cfquery name="fund_lookup" datasource="#request.fund_lookup#" dbtype="ODBC">
select * from fund_codes where quickcode=#request.quickcode#
</cfquery>

<cfset request.quantity=1>



<cfif #find_permit.permit_fee# is "">
<cfset request.permit_fee=0>
<cfelse>
<cfset request.permit_fee=ReplaceNoCase("#find_permit.permit_fee#","$","","ALL")>
<cfset request.permit_fee=ReplaceNoCase("#request.permit_fee#",",","","ALL")>
</cfif>


<cfset s1=(#request.permit_fee#)*(#find_permit.surcharge_1#/100)>
<cfset s2=(#request.permit_fee#)*(#find_permit.surcharge_2#/100)>

<Cfset total_s1=#total_s1#+#s1#>
<cfset total_s2=#total_s2#+#s2#>


<cfif #find_permit.permit_fee# gt 0>
<cfinclude template="generate_new_item_id.cfm">
<cfquery name="dist_rev" datasource="#request.revenue_distribution#" dbtype="ODBC">
insert into revenue_distribution
(
item_id,
ref_no,
permit_code,
quickcode,
description,
quantity,
amount,
total,
fund,
dept,
revenue_code,
sub_revenue_code,
new_revenue_code
)
values
(
#request.item_id#,
#request.ref_no#,
'#left(request.permit_code,12)#',
#request.quickcode#,
'#left(fund_lookup.description,30)#',
#request.quantity#,
#request.permit_fee#,
#request.permit_fee#,
'#left(fund_lookup.fund,3)#',
'#left(fund_lookup.dept,2)#',
'#left(fund_lookup.revenue_code,4)#',
'#left(fund_lookup.sub_revenue_code,2)#',
'#left(fund_lookup.new_revenue_code,6)#'
)
</cfquery>
</cfif>
<!-- MH-Permit Basic Fee -->


<!-- MH Permit Cards / Certificates -->
<cfset request.quickcode=178>


<cfquery name="fund_lookup" datasource="#request.fund_lookup#" dbtype="ODBC">
select * from fund_codes where quickcode=#request.quickcode#
</cfquery>

<cfset request.quantity=1>


<cfset s1=(#find_permit.card_fees#)*(#find_permit.surcharge_1#/100)>
<cfset s2=(#find_permit.card_fees#)*(#find_permit.surcharge_2#/100)>

<Cfset total_s1=#total_s1#+#s1#>
<cfset total_s2=#total_s2#+#s2#>


<cfif #find_permit.card_fees# gt 0>
<cfinclude template="generate_new_item_id.cfm">
<cfquery name="dist_rev" datasource="#request.revenue_distribution#" dbtype="ODBC">
insert into revenue_distribution
(
item_id,
ref_no,
permit_code,
quickcode,
description,
quantity,
amount,
total,
fund,
dept,
revenue_code,
sub_revenue_code,
new_revenue_code
)
values
(
#request.item_id#,
#request.ref_no#,
'#left(request.permit_code,12)#',
#request.quickcode#,
'#left(fund_lookup.description,30)#',
#request.quantity#,
#find_permit.card_fees#,
#find_permit.card_fees#,
'#left(fund_lookup.fund,3)#',
'#left(fund_lookup.dept,2)#',
'#left(fund_lookup.revenue_code,4)#',
'#left(fund_lookup.sub_revenue_code,2)#',
'#left(fund_lookup.new_revenue_code,6)#'
)
</cfquery>
</cfif>
<!-- MH-Permit Basic Fee -->




<!-- Add Surcharge 1 -->
<Cfif #total_s1# gt 0>

<cfset total_s1=ReplaceNoCase("#total_s1#",",","","ALL")>
<cfset total_s1=#total_s1# * 100>
<cfset total_s1=round(#total_s1#)/100>

<cfset request.quickcode=502><!-- ONE STOP PERMIT CENTER FEE / M -->

<cfquery name="fund_lookup" datasource="#request.fund_lookup#" dbtype="ODBC">
select * from fund_codes where quickcode=#request.quickcode#
</cfquery>

<cfinclude template="generate_new_item_id.cfm">
<cfquery name="dist_rev" datasource="#request.revenue_distribution#" dbtype="ODBC">
insert into revenue_distribution
(
item_id,
ref_no,
permit_code,
quickcode,
description,
quantity,
amount,
total,
fund,
dept,
revenue_code,
sub_revenue_code,
new_revenue_code
)
values
(
#request.item_id#,
#request.ref_no#,
'#left(request.permit_code,12)#',
#request.quickcode#,
'#left(fund_lookup.description,30)#',
1,
0,
#total_s1#,
'#left(fund_lookup.fund,3)#',
'#left(fund_lookup.dept,2)#',
'#left(fund_lookup.revenue_code,4)#',
'#left(fund_lookup.sub_revenue_code,2)#',
'#left(fund_lookup.new_revenue_code,6)#'
)
</cfquery>

</cfif>
<!-- Add Surcharge 1 -->



<!-- Add Surcharge 2 -->
<Cfif #total_s2# gt 0>

<cfset total_s2=ReplaceNoCase(#total_s2#, "#chr(44)#" , "" , "ALL")>
<cfset total_s2=#total_s2# * 100>

<cfset total_s2=round(#total_s2#)/100>

<cfset request.quickcode=503><!-- EQUIP & TRAINING SURCHARGE / M -->

<cfquery name="fund_lookup" datasource="#request.fund_lookup#" dbtype="ODBC">
select * from fund_codes where quickcode=#request.quickcode#
</cfquery>

<cfinclude template="generate_new_item_id.cfm">
<cfquery name="dist_rev" datasource="#request.revenue_distribution#" dbtype="ODBC">
insert into revenue_distribution
(
item_id,
ref_no,
permit_code,
quickcode,
description,
quantity,
amount,
total,
fund,
dept,
revenue_code,
sub_revenue_code,
new_revenue_code
)
values
(
#request.item_id#,
#request.ref_no#,
'#left(request.permit_code,12)#',
#request.quickcode#,
'#left(fund_lookup.description,30)#',
1,
0,
#total_s2#,
'#left(fund_lookup.fund,3)#',
'#left(fund_lookup.dept,2)#',
'#left(fund_lookup.revenue_code,4)#',
'#left(fund_lookup.sub_revenue_code,2)#',
'#left(fund_lookup.new_revenue_code,6)#'
)
</cfquery>

</cfif>
<!-- Add Surcharge 2 -->

</body>

</html>
