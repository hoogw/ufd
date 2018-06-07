<cfinclude template="validate_srrKey.cfm">
<!--- <cfset request.const_total = 0> --->
<cfset request.calc_rebate_total = 0>

<!--- <div class="title">Required Work to make Pathway ADA Compliant</div> --->
<div align="center"><strong>Rebate Valuation **</strong></div>
<table style="width:800px;" class="datatable">
<tr>
<th style="width:300px;">Item</th>
<th style="width:100px;">Qty</th>
<th style="width:100px;">Unit</th>
<th style="width:100px;">Rebate Rate</th>
<th style="width:200px;">Potential Rebate<br>Subtotal</th>
</tr>

<cfquery name="getSideWalks" datasource="#request.dsn#" dbtype="datasource">
SELECT 
sidewalk_details.sidewalk_no
, sidewalk_details.ref_no
, ISNULL(sidewalk_details.sidewalk_qty, 0)  sidewalk_qty
, ISNULL(rebate_rates.sidewalk_uf, 0) sidewalk_uf
, srr_info.sr_number
, srr_info.rate_nbr
, srr_info.srr_id
, sidewalk_details.eligible

FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr RIGHT OUTER JOIN
               Apermits.dbo.sidewalk_details AS sidewalk_details ON srr_info.a_ref_no = sidewalk_details.ref_no
			   
where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<!--- <cfdump var="#getSideWalks#" output="browser"> --->

<cfset xx = 1>
<cfoutput query="getSideWalks">
<tr>
<td>Sidewalk Segment #xx# <cfif #getSideWalks.eligible# is "N">(not eligible)</cfif></td>
<td style="text-align:right;">#decimalformat(getSideWalks.sidewalk_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getSideWalks.sidewalk_uf)#</td>
<cfif #getSideWalks.eligible# is "Y">
<cfset request.sidewalk_rebate = #getSideWalks.sidewalk_qty# * #getSideWalks.sidewalk_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_rebate#>
</cfif>
<td style="text-align:right;"><cfif #getSideWalks.eligible# is "Y">#dollarformat(request.sidewalk_rebate)#<cfelse>$0.00</cfif></td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>

<!-- driveway calcs -->
<cfquery name="getDriveways" datasource="#request.dsn#" dbtype="datasource">
SELECT 
driveway_details.ref_no
, driveway_details.driveway_no
, driveway_details.driveway_case
, ISNULL(driveway_details.driveway_qty, 0) driveway_qty
, driveway_details.eligible
, srr_info.srr_id
, srr_info.sr_number
, rebate_rates.rate_nbr
, rebate_rates.driveway_uf


FROM  apermits.dbo.driveway_details AS driveway_details LEFT OUTER JOIN
               srr_info ON driveway_details.ref_no = srr_info.a_ref_no LEFT OUTER JOIN
               rebate_rates ON srr_info.rate_nbr = rebate_rates.rate_nbr
			   
where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfset xx = 1>
<cfoutput query="getDriveWays">
<tr>
<td>Driveway No. #xx# <cfif #getDriveWays.eligible# is "N">(not eligible)</cfif></td>
<td style="text-align:right;">#decimalformat(getDriveWays.driveway_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getDriveWays.driveway_uf)#</td>
<cfif #getDriveWays.eligible# is "Y">
<cfset request.driveway_rebate  = #getDriveways.driveway_qty# * #getDriveways.driveway_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.driveway_rebate#>
</cfif>
<td style="text-align:right;"><cfif #getDriveWays.eligible# is "Y">#dollarformat(request.driveway_rebate)#<cfelse>$0.00</cfif></td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>

<cfquery name="getOtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, other_items.ref_no
, ISNULL(other_items.partial_dwy_conc_qty, 0) partial_dwy_conc_qty
, ISNULL(other_items.access_ramp_qty, 0) access_ramp_qty
, ISNULL(other_items.conc_curb_qty, 0) conc_curb_qty
, ISNULL(other_items.conc_gutter_qty, 0) conc_gutter_qty
<!--- , ISNULL(other_items.curb_cuts_qty, 0) curb_cuts_qty
, ISNULL(other_items.drains_no, 0) drains_no --->


, partial_dwy_conc_eligible
, access_ramp_eligible
, conc_curb_eligible
<!--- , curb_cuts_eligible 
, drains_eligible--->
, conc_gutter_eligible

, srr_info.sr_number
, rebate_rates.conc_curb_uf
, rebate_rates.conc_gutter_uf
<!--- , rebate_rates.curb_cuts_uf
, rebate_rates.drains_uf --->
<!--- , rebate_rates.pullbox_uf
, rebate_rates.st_furn_uf
, rebate_rates.signage_uf
, rebate_rates.parking_meter_uf --->
, rebate_rates.driveway_uf
, rebate_rates.access_ramp_uf

FROM  rebate_rates INNER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr RIGHT OUTER JOIN
               apermits.dbo.other_items AS other_items ON srr_info.a_ref_no = other_items.ref_no
where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfquery name="getSRROtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT srr_id   
      ,ISNULL(conc_curb_qty_opt , 0) conc_curb_qty_opt
      ,ISNULL(conc_gutter_qty_opt , 0) conc_gutter_qty_opt
      ,ISNULL(access_ramp_qty_opt , 0) access_ramp_qty_opt
      ,ISNULL(partial_dwy_conc_qty_opt , 0) partial_dwy_conc_qty_opt
  FROM srr.dbo.srr_other_items
 where srr_id = #request.srr_id#
 </cfquery>
 
 <cfscript>
    eligibleItems=StructNew();
</cfscript>
 
 <cfif #getOtherItems.recordcount# is not 0 and #getSRROtherItems.recordcount# is not 0><!--- 1 --->
 <Cfset eligibleItems.partial_dwy_conc_qty = #getOtherItems.partial_dwy_conc_qty# - #getSRROtherItems.partial_dwy_conc_qty_opt#>
 <cfif #eligibleItems.partial_dwy_conc_qty# lt 0>
 <cfset eligibleItems.partial_dwy_conc_qty = 0>
 </cfif>
 
<Cfset eligibleItems.access_ramp_qty =  #getOtherItems.access_ramp_qty# - #getSRROtherItems.access_ramp_qty_opt#>
 <cfif #eligibleItems.access_ramp_qty# lt 0>
 <cfset eligibleItems.access_ramp_qty = 0>
 </cfif>
 
 
 
<Cfset eligibleItems.conc_curb_qty =  #getOtherItems.conc_curb_qty# - #getSRROtherItems.conc_curb_qty_opt#>
 <cfif #eligibleItems.conc_curb_qty# lt 0>
 <cfset eligibleItems.conc_curb_qty = 0>
 </cfif>
 
 
<Cfset eligibleItems.conc_gutter_qty =  #getOtherItems.conc_gutter_qty# - #getSRROtherItems.conc_gutter_qty_opt#>
<cfif #eligibleItems.conc_gutter_qty# lt 0>
 <cfset eligibleItems.conc_gutter_qty = 0>
 </cfif>

 <cfelseif #getOtherItems.recordcount# is 0 and #getSRROtherItems.recordcount# is not 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = 0>
<cfset eligibleItems.access_ramp_qty = 0>
<cfset eligibleItems.conc_curb_qty = 0>
<cfset eligibleItems.conc_gutter_qty = 0>


 <cfelseif #getOtherItems.recordcount#  is 0 and #getSRROtherItems.recordcount# is 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = 0>
<cfset eligibleItems.access_ramp_qty = 0>
<cfset eligibleItems.conc_curb_qty = 0>
<cfset eligibleItems.conc_gutter_qty = 0>

 <cfelseif #getOtherItems.recordcount# is not 0 and #getSRROtherItems.recordcount# is 0><!--- 1 --->
<cfset eligibleItems.partial_dwy_conc_qty = #getOtherItems.partial_dwy_conc_qty#>
<cfset eligibleItems.access_ramp_qty = #getOtherItems.access_ramp_qty#>
<cfset eligibleItems.conc_curb_qty = #getOtherItems.conc_curb_qty#>
<cfset eligibleItems.conc_gutter_qty = #getOtherItems.conc_gutter_qty#>
   
 </cfif><!--- 1 --->
 
 




<cfoutput<!---  query="getOtherItems" --->>
<Cfif #eligibleItems.partial_dwy_conc_qty# is not 0>
<tr>
<td>Partial Driveway (Concrete)</td>
<td style="text-align:right;">#decimalformat(eligibleItems.partial_dwy_conc_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getOtherItems.driveway_uf)#</td>
<cfset request.partial_dwy_conc_rebate = #eligibleItems.partial_dwy_conc_qty# * #getOtherItems.driveway_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.partial_dwy_conc_cost#>
<cfset request.partial_dwy_conc_rebate= #request.partial_dwy_conc_cost# * 0.50> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.partial_dwy_conc_rebate#>
<td style="text-align:right;">#dollarformat(request.partial_dwy_conc_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.partial_dwy_conc_rebate)#</td> --->
<!--- <td style="text-align:center;">#ucase(partial_dwy_conc_eligible)#</td> --->
</tr>
</CFIF>

<Cfif #eligibleItems.access_ramp_qty# is not 0>
<tr>
<td>Access Ramp(s)</td>
<td style="text-align:right;">#decimalformat(eligibleItems.access_ramp_qty)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getOtherItems.access_ramp_uf)#</td>
<cfset request.access_ramp_rebate = #eligibleItems.access_ramp_qty# * #getOtherItems.access_ramp_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.access_ramp_cost#>
<cfset request.access_ramp_rebate= #request.access_ramp_cost# * 0.50> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.access_ramp_rebate#>
<td style="text-align:right;">#dollarformat(request.access_ramp_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.access_ramp_rebate)#</td> --->
<!--- <td style="text-align:center;">#ucase(access_ramp_eligible)#</td> --->
</tr>
</CFIF>


<Cfif #eligibleItems.conc_curb_qty# is not 0>
<tr>
<td>Curb</td>
<td style="text-align:right;">#decimalformat(eligibleItems.conc_curb_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getOtherItems.conc_curb_uf)#</td>
<cfset request.conc_curb_rebate = #eligibleItems.conc_curb_qty# * #getOtherItems.conc_curb_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.conc_curb_cost#>
<cfset request.conc_curb_rebate= #request.conc_curb_cost# * 0.50> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_curb_rebate#>
<td style="text-align:right;">#dollarformat(request.conc_curb_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.conc_curb_rebate)#</td> --->
<!--- <td style="text-align:center;">#ucase(conc_curb_eligible)#</td> --->
</tr>
</CFIF>


<Cfif #eligibleItems.conc_gutter_qty# is not 0>
<tr>
<td>Gutter</td>
<td style="text-align:right;">#decimalformat(eligibleItems.conc_gutter_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getOtherItems.conc_gutter_uf)#</td>
<cfset request.conc_gutter_rebate = #eligibleItems.conc_gutter_qty# * #getOtherItems.conc_gutter_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.conc_gutter_cost#>
<cfset request.conc_gutter_rebate= #request.conc_gutter_cost# * 0.50> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.conc_gutter_rebate#>
<td style="text-align:right;">#dollarformat(request.conc_gutter_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.conc_gutter_rebate)#</td> --->
<!--- <td style="text-align:center;">#ucase(conc_gutter_eligible)#</td> --->
</tr>
</CFIF>



</cfoutput>

<cfquery name="getSRROtherItems" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.srrKey
, srr_info.sr_number
, ISNULL(srr_other_items.pullbox_no, 0) pullbox_no
, ISNULL(rebate_rates.pullbox_uf, 0) pullbox_uf
, ISNULL(srr_other_items.signage_no, 0) signage_no
, ISNULL(rebate_rates.signage_uf, 0) signage_uf
, ISNULL(srr_other_items.st_furn_no, 0) st_furn_no
, ISNULL(rebate_rates.st_furn_uf, 0) st_furn_uf
, ISNULL(srr_other_items.parking_meter_no, 0) parking_meter_no
, ISNULL(rebate_rates.parking_meter_uf, 0) parking_meter_uf
, ISNULL(srr_other_items.survey_monument_no, 0) survey_monument_no
, ISNULL(survey_monument_uf, 0) survey_monument_uf
, ISNULL(srr_other_items.sidewalk_trans_qty, 0) sidewalk_trans_qty
, ISNULL(rebate_rates.sidewalk_trans_uf, 0) sidewalk_trans_uf
, ISNULL(rebate_rates.catch_basin_lid_uf, 0) catch_basin_lid_uf
, ISNULL(srr_other_items.catch_basin_lid_qty, 0) catch_basin_lid_qty
, ISNULL(srr_other_items.pkwy_drain_qty, 0) pkwy_drain_qty
, ISNULL(rebate_rates.pkwy_drain_uf, 0) pkwy_drain_uf



FROM  srr_other_items RIGHT OUTER JOIN
               srr_info ON srr_other_items.srr_id = srr_info.srr_id LEFT OUTER JOIN
               rebate_rates ON srr_info.rate_nbr = rebate_rates.rate_nbr
			   
where srr_info.srr_id = #request.srr_id#
</cfquery>

<!--- 
<Cfif #getSRROtherItems.pullbox_no# is not 0>
<cfset request.pullbox_rebate = #getSRROtherItems.pullbox_no# * #getSRROtherItems.pullbox_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pullbox_rebate#>
</CFIF> --->

<cfoutput>
<Cfif #getSRROtherItems.pullbox_no# is not 0>
<tr>
<td>Utility Pullbox(es)</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.pullbox_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.pullbox_uf)#</td>
<cfset request.pullbox_rebate = #getSRROtherItems.pullbox_no# * #getSRROtherItems.pullbox_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pullbox_rebate#>
<td style="text-align:right;">#dollarformat(request.pullbox_rebate)#</td>
</tr>
</CFIF>
</cfoutput>

<!--- <Cfif #getSRROtherItems.signage_no# is not 0>
<cfset request.signage_rebate = #getSRROtherItems.signage_no# * #getSRROtherItems.signage_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.signage_rebate#>
</CFIF> --->

<!--- <cfoutput>
<Cfif #getSRROtherItems.signage_no# is not 0>
<tr>
<td>Signage</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.signage_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.signage_uf)#</td>
<cfset request.signage_rebate = #getSRROtherItems.signage_no# * #getSRROtherItems.signage_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.signage_rebate#>
<td style="text-align:right;">#dollarformat(request.signage_rebate)#</td>
</tr>
</CFIF>
</cfoutput> --->

<!--- <Cfif #getSRROtherItems.st_furn_no# is not 0>
<cfset request.st_furn_rebate = #getSRROtherItems.st_furn_no# * #getSRROtherItems.st_furn_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.st_furn_rebate#>
</CFIF> --->


<!--- <cfoutput>
<Cfif #getSRROtherItems.st_furn_no# is not 0>
<tr>
<td>Street Furniture</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.st_furn_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.st_furn_uf)#</td>
<cfset request.st_furn_rebate = #getSRROtherItems.st_furn_no# * #getSRROtherItems.st_furn_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.st_furn_rebate#>
<td style="text-align:right;">#dollarformat(request.st_furn_rebate)#</td>
</tr>
</CFIF>
</cfoutput> --->

<!--- <Cfif #getSRROtherItems.parking_meter_no# is not 0>
<cfset request.parking_meter_rebate = #getSRROtherItems.parking_meter_no# * #getSRROtherItems.parking_meter_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.parking_meter_rebate#>
</CFIF> --->

<!--- <cfoutput>
<Cfif #getSRROtherItems.parking_meter_no# is not 0>
<tr>
<td>Parking Meter(s)</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.parking_meter_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.parking_meter_uf)#</td>
<cfset request.parking_meter_rebate = #getSRROtherItems.parking_meter_no# * #getSRROtherItems.parking_meter_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.parking_meter_rebate#>
<td style="text-align:right;">#dollarformat(request.parking_meter_rebate)#</td>
</tr>
</CFIF>
</cfoutput> --->

<!--- <Cfif #getSRROtherItems.survey_monument_no# is not 0>
<cfset request.survey_monument_rebate = #getSRROtherItems.survey_monument_no# * #getSRROtherItems.survey_monument_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.survey_monument_rebate#>
</CFIF> --->


<!--- <cfoutput>
<Cfif #getSRROtherItems.survey_monument_no# is not 0>
<tr>
<td>Survey Monument(s)</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.survey_monument_no)#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.survey_monument_uf)#</td>
<cfset request.survey_monument_rebate = #getSRROtherItems.survey_monument_no# * #getSRROtherItems.survey_monument_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.survey_monument_rebate#>
<td style="text-align:right;">#dollarformat(request.survey_monument_rebate)#</td>
</tr>
</CFIF>
</cfoutput> --->


<!--- <Cfif #getSRROtherItems.sidewalk_trans_qty# is not 0>
<cfset request.sidewalk_trans_rebate = #getSRROtherItems.sidewalk_trans_qty# * #getSRROtherItems.sidewalk_trans_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_trans_rebate#>
</CFIF>
 --->
<cfoutput>
<Cfif #getSRROtherItems.sidewalk_trans_qty# is not 0>
<tr>
<td>Sidewalk Transition Panel</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.sidewalk_trans_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.sidewalk_trans_uf)#</td>
<cfset request.sidewalk_trans_rebate = #getSRROtherItems.sidewalk_trans_qty# * #getSRROtherItems.sidewalk_trans_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.sidewalk_trans_rebate#>
<td style="text-align:right;">#dollarformat(request.sidewalk_trans_rebate)#</td>
</tr>
</CFIF>
</cfoutput>


<!--- <Cfif #getSRROtherItems.catch_basin_lid_qty# is not 0>
<cfset request.catch_basin_lid_rebate = #getSRROtherItems.catch_basin_lid_qty# * #getSRROtherItems.catch_basin_lid_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.catch_basin_lid_rebate#>
</CFIF> --->

<cfoutput>
<Cfif #getSRROtherItems.catch_basin_lid_qty# is not 0>
<tr>
<td>Catch Basin Conc. Cover</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.catch_basin_lid_qty)#</td>
<td style="text-align:center;">Sq. Ft.</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.catch_basin_lid_uf)#</td>
<cfset request.catch_basin_lid_rebate = #getSRROtherItems.catch_basin_lid_qty# * #getSRROtherItems.catch_basin_lid_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.catch_basin_lid_rebate#>
<td style="text-align:right;">#dollarformat(request.catch_basin_lid_rebate)#</td>
</tr>
</CFIF>
</cfoutput>


<!--- <Cfif #getSRROtherItems.pkwy_drain_qty# is not 0>
<cfset request.pkwy_drain_rebate = #getSRROtherItems.pkwy_drain_qty# * #getSRROtherItems.pkwy_drain_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pkwy_drain_rebate#>
</CFIF> --->

<cfoutput>
<Cfif #getSRROtherItems.pkwy_drain_qty# is not 0>
<tr>
<td>Parkway Drain(s)</td>
<td style="text-align:right;">#decimalformat(getSRROtherItems.pkwy_drain_qty)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getSRROtherItems.pkwy_drain_uf)#</td>
<cfset request.pkwy_drain_rebate = #getSRROtherItems.pkwy_drain_qty# * #getSRROtherItems.pkwy_drain_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.pkwy_drain_rebate#>
<td style="text-align:right;">#dollarformat(request.pkwy_drain_rebate)#</td>
</tr>
</CFIF>
</cfoutput>




<cfquery name="getTrees" datasource="#request.dsn#" dbtype="datasource">
SELECT 
ISNULL(tree_info.nbr_trees_pruned, 0) nbr_trees_pruned
, ISNULL(tree_info.lf_trees_pruned, 0) lf_trees_pruned
, ISNULL(tree_info.nbr_trees_removed, 0) nbr_trees_removed
, ISNULL(tree_info.nbr_stumps_removed, 0) nbr_stumps_removed
, tree_info.srr_id
, srr_info.sr_number
, srr_info.srrKey
, ISNULL(rebate_rates.tree_pruning_uf, 0) tree_pruning_uf
, ISNULL(rebate_rates.tree_removal_uf, 0) tree_removal_uf
, ISNULL(rebate_rates.tree_stump_uf, 0) tree_stump_uf
FROM  srr_info LEFT OUTER JOIN
               rebate_rates ON srr_info.rate_nbr = rebate_rates.rate_nbr RIGHT OUTER JOIN
               tree_info ON srr_info.srr_id = tree_info.srr_id

where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<Cfif #getTrees.recordcount# is not 0>

<cfif #getTrees.lf_trees_pruned# is not 0>
<cfoutput>
<tr>
<td>Root Pruning</td>
<td style="text-align:right;">#decimalformat(getTrees.lf_trees_pruned)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getTrees.tree_pruning_uf)#</td>
<cfset request.tree_pruning_rebate = #getTrees.lf_trees_pruned# * #getTrees.tree_pruning_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.tree_pruning_cost#>
<cfset request.tree_pruning_rebate= #request.tree_pruning_cost# * 0.50> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_pruning_rebate#>
<td style="text-align:right;">#dollarformat(request.tree_pruning_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.tree_pruning_rebate)#</td> --->
<!--- <td style="text-align:center;">Y</td> --->
</tr>
</cfoutput>
</cfif>

<cfif #getTrees.nbr_trees_removed# is not 0>
<cfoutput>
<tr>
<td>Tree Remove and Replace</td>
<td style="text-align:right;">#getTrees.nbr_trees_removed#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getTrees.tree_removal_uf)#</td>
<cfset request.tree_removal_rebate = #getTrees.nbr_trees_removed# * #getTrees.tree_removal_uf#>
<!--- <cfset request.const_total = #request.const_total# + #request.tree_removal_cost#>
<cfset request.tree_removal_rebate= 500 * #getTrees.nbr_trees_removed#> --->
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_removal_rebate#>
<td style="text-align:right;">#dollarformat(request.tree_removal_rebate)#</td>
<!--- <td style="text-align:right;">#dollarformat(request.tree_removal_rebate)#</td> --->
<!--- <td style="text-align:center;">Y</td> --->
</tr>
</cfoutput>
</cfif>


<cfif #getTrees.nbr_stumps_removed# is not 0>
<cfoutput>
<tr>
<td>Tree Stump Removal</td>
<td style="text-align:right;">#getTrees.nbr_stumps_removed#</td>
<td style="text-align:center;">Each</td>
<td style="text-align:right;">#dollarformat(getTrees.tree_stump_uf)#</td>
<cfset request.tree_stump_rebate = #getTrees.nbr_stumps_removed# * #getTrees.tree_stump_uf#>
<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.tree_stump_rebate#>
<td style="text-align:right;">#dollarformat(request.tree_stump_rebate)#</td>
</tr>
</cfoutput>
</cfif>

</CFIF>



<cfoutput>
<tr>
<td colspan="4" style="background:silver;"><strong>Total</strong></td>

<td style="text-align:right;background:silver;"><strong>#dollarformat(request.calc_rebate_total)#<sup>*</sup></strong></td>
<!--- <td style="background:gray;"><strong>#dollarformat(request.calc_rebate_total)#</strong></td> --->
<!--- <td>&nbsp;</td> --->
</tr>
</cfoutput>

</table>




<!--- Handling Adjustments --->
<cfset request.TotalAdjustments = 0>
<cfquery name="getAdjustments" datasource="#request.dsn#" dbtype="datasource">
SELECT 
rebateAdjustments.adjustmentID
, rebateAdjustments.srr_id
, ISNULL(rebateAdjustments.sidewalk_sqft, 0) AS sidewalk_sqft
, ISNULL(rebateAdjustments.driveway_sqft, 0) AS driveway_sqft
, ISNULL(rebateAdjustments.sw_trans_panel_sqft, 0) AS sw_trans_panel_sqft
, ISNULL(rebateAdjustments.curb_lf, 0) AS curb_lf
, ISNULL(rebateAdjustments.gutter_lf, 0) AS gutter_lf
, ISNULL(rebateAdjustments.pkwy_drain_lf, 0) AS pkwy_drain_lf
, ISNULL(rebateAdjustments.tree_stump_qty, 0) AS tree_stump_qty
, ISNULL(rebateAdjustments.catchBasin_lid_qty, 0) AS catchBasin_lid_qty
, ISNULL(rebateAdjustments.pullbox_qty, 0) AS pullbox_qty
, ISNULL(rebateAdjustments.trees_pruned_qty, 0) AS trees_pruned_qty
, ISNULL(rebateAdjustments.trees_pruned_lf, 0) AS trees_pruned_lf
, ISNULL(rebateAdjustments.trees_removed_qty, 0) AS trees_removed_qty
, ISNULL(rebateAdjustments.trees_planted_onsite_qty, 0) AS trees_planted_onsite_qty
, ISNULL(rebateAdjustments.trees_planted_offsite_qty, 0) AS trees_planted_offsite_qty
, srr_info.srrKey, srr_info.sr_number

, rebate_rates.sidewalk_uf
, rebate_rates.driveway_uf
, rebate_rates.conc_curb_uf
, rebate_rates.conc_gutter_uf
, rebate_rates.curb_cuts_uf
, rebate_rates.drains_uf
, rebate_rates.pullbox_uf
, rebate_rates.signage_uf
, rebate_rates.st_furn_uf
, rebate_rates.parking_meter_uf
, rebate_rates.access_ramp_uf
, rebate_rates.tree_pruning_uf
, rebate_rates.tree_removal_uf
, rebate_rates.pkwy_drain_uf
, rebate_rates.sidewalk_trans_uf
, rebate_rates.catch_basin_lid_uf
, rebate_rates.tree_stump_uf
, rebate_rates.survey_monument_uf

FROM  rebate_rates RIGHT OUTER JOIN
               srr_info ON rebate_rates.rate_nbr = srr_info.rate_nbr LEFT OUTER JOIN
               rebateAdjustments ON srr_info.srr_id = rebateAdjustments.srr_id
			   
WHERE (srr_info.srrKey = '#request.srrKey#')
</cfquery>

<cfif 
#getAdjustments.sidewalk_sqft# is not 0 
OR #getAdjustments.driveway_sqft# is not 0 
OR #getAdjustments.sw_trans_panel_sqft# is not 0 
OR #getAdjustments.curb_lf# is not 0 
OR #getAdjustments.gutter_lf# is not 0 
OR #getAdjustments.pkwy_drain_lf# is not 0  
OR #getAdjustments.tree_stump_qty# is not 0 
OR #getAdjustments.catchBasin_lid_qty# is not 0 
OR #getAdjustments.pullbox_qty# is not 0 
OR #getAdjustments.trees_pruned_lf# is not 0 
OR #getAdjustments.trees_removed_qty# is not 0 
>
<!--- display and calculate Rebate Adjustments --->

<div align="center"><strong>Rebate Adjustments</strong></div>
<table style="width:800px;" class="datatable">
<tr>
<th style="width:300px;">Item</th>
<th style="width:100px;">Qty</th>
<th style="width:100px;">Unit</th>
<th style="width:100px;">Rebate Rate</th>
<th style="width:200px;">Potential Rebate<br>Subtotal</th>
</tr>


<cfoutput>

<cfif #getAdjustments.sidewalk_sqft# is not 0>
<tr>
<td>Sidewalk(s)</td>
<td style="text-align:right;">#decimalformat(getAdjustments.sidewalk_sqft)#</td>
<td style="text-align:center;">SQ. FT.</td>
<td style="text-align:right;">#dollarformat(getAdjustments.sidewalk_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.sidewalk_sqft# * #getAdjustments.sidewalk_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.sidewalk_sqft * getAdjustments.sidewalk_uf)#</td>
</tr>
</cfif>


<cfif #getAdjustments.driveway_sqft# is not 0>
<tr>
<td>Driveway(s)</td>
<td style="text-align:right;">#decimalformat(getAdjustments.driveway_sqft)#</td>
<td style="text-align:center;">SQ. FT.</td>
<td style="text-align:right;">#dollarformat(getAdjustments.driveway_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.driveway_sqft# * #getAdjustments.driveway_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.driveway_sqft * getAdjustments.driveway_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.sw_trans_panel_sqft# is not 0>
<tr>
<td>Sw Tansitional Panel</td>
<td style="text-align:right;">#decimalformat(getAdjustments.sw_trans_panel_sqft)#</td>
<td style="text-align:center;">SQ. FT.</td>
<td style="text-align:right;">#dollarformat(getAdjustments.sidewalk_trans_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.sw_trans_panel_sqft# * #getAdjustments.sidewalk_trans_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.sw_trans_panel_sqft * getAdjustments.sidewalk_trans_uf)#</td>
</tr>
</cfif>


<cfif #getAdjustments.curb_lf# is not 0>
<tr>
<td>Curb</td>
<td style="text-align:right;">#decimalformat(getAdjustments.curb_lf)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getAdjustments.conc_curb_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.curb_lf# * #getAdjustments.conc_curb_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.curb_lf * getAdjustments.conc_curb_uf)#</td>
</tr>
</cfif>


<cfif #getAdjustments.gutter_lf# is not 0>
<tr>
<td>Gutter</td>
<td style="text-align:right;">#decimalformat(getAdjustments.gutter_lf)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getAdjustments.conc_gutter_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.gutter_lf# * #getAdjustments.conc_gutter_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.gutter_lf * getAdjustments.conc_gutter_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.pkwy_drain_lf# is not 0>
<tr>
<td>Pkwy Drain</td>
<td style="text-align:right;">#decimalformat(getAdjustments.pkwy_drain_lf)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getAdjustments.pkwy_drain_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.pkwy_drain_lf# * #getAdjustments.pkwy_drain_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.pkwy_drain_lf * getAdjustments.pkwy_drain_uf)#</td>
</tr>
</cfif>


<cfif #getAdjustments.catchbasin_lid_qty# is not 0>
<tr>
<td>Catch Basin Lid</td>
<td style="text-align:right;">#decimalformat(getAdjustments.catchbasin_lid_qty)#</td>
<td style="text-align:center;">EA</td>
<td style="text-align:right;">#dollarformat(getAdjustments.catch_basin_lid_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.catchbasin_lid_qty# * #getAdjustments.catch_basin_lid_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.catchbasin_lid_qty * getAdjustments.catch_basin_lid_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.pullbox_qty# is not 0>
<tr>
<td>Pullbox</td>
<td style="text-align:right;">#decimalformat(getAdjustments.pullbox_qty)#</td>
<td style="text-align:center;">EA</td>
<td style="text-align:right;">#dollarformat(getAdjustments.pullbox_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.pullbox_qty# * #getAdjustments.pullbox_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.pullbox_qty * getAdjustments.pullbox_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.tree_stump_qty# is not 0>
<tr>
<td>Tree Stumps</td>
<td style="text-align:right;">#decimalformat(getAdjustments.tree_stump_qty)#</td>
<td style="text-align:center;">EA</td>
<td style="text-align:right;">#dollarformat(getAdjustments.tree_stump_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.tree_stump_qty# * #getAdjustments.tree_stump_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.tree_stump_qty * getAdjustments.tree_stump_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.trees_pruned_lf# is not 0>
<tr>
<td>Tree Root Pruning</td>
<td style="text-align:right;">#decimalformat(getAdjustments.trees_pruned_lf)#</td>
<td style="text-align:center;">LF</td>
<td style="text-align:right;">#dollarformat(getAdjustments.tree_pruning_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.trees_pruned_lf# * #getAdjustments.tree_pruning_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.trees_pruned_lf * getAdjustments.tree_pruning_uf)#</td>
</tr>
</cfif>

<cfif #getAdjustments.trees_removed_qty# is not 0>
<tr>
<td>Tree(s) to be Removed</td>
<td style="text-align:right;">#decimalformat(getAdjustments.trees_removed_qty)#</td>
<td style="text-align:center;">EA</td>
<td style="text-align:right;">#dollarformat(getAdjustments.tree_removal_uf)#</td>
<cfset request.TotalAdjustments = #request.TotalAdjustments# + #getAdjustments.trees_removed_qty# * #getAdjustments.tree_removal_uf#>
<td style="text-align:right;">#dollarformat(getAdjustments.trees_removed_qty * getAdjustments.tree_removal_uf)#</td>
</tr>
</cfif>


<tr>
<td colspan="4" style="background:silver;"><strong>Total Adjustments</strong></td>
<td style="text-align:right;background:silver;"><strong>#dollarformat(request.TotalAdjustments)#</strong></td>
</tr>


</cfoutput>
</table>

<cfset request.calc_rebate_total = #request.calc_rebate_total# + #request.TotalAdjustments#>

<cfoutput>
<div align="center"><strong>Adjusted Rebate Valuation</strong></div>
<table style="width:800px;" class="datatable">
<!--- <tr>
<th style="width:33%;border: 1px solid black;">Item</th>
<th style="width:10%;border: 1px solid black;">Qty</th>
<th style="width:10%;border: 1px solid black;">Unit</th>
<th style="width:10%;border: 1px solid black;">Rebate Rate</th>
<th style="width:37%;border: 1px solid black;">Potential Rebate<br>Subtotal</th>
</tr> --->
<tr>
<td colspan="4" style="background:silver;"><strong>Total</strong></td>
<td style="text-align:right;background:silver;"><strong>#dollarformat(request.calc_rebate_total)#</strong></td>
</tr>

</table>
</cfoutput>

<cfelse><!--- do not display or calculate Rebate Adjustments --->

</cfif>

<!--- Handling Adjustments --->


<!--- adding valuation estimate to database --->
<cfset request.valuation_est = #request.calc_rebate_total#>

<cfquery name="updateValuationEst" datasource="#request.dsn#" dbtype="datasource">
Update srr_info
set
valuation_est = #request.valuation_est#
where
srrKey = '#request.srrKey#'
</cfquery>
<!--- adding valuation estimate to database --->



<cfquery name="getPropType" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.prop_type
, rebate_rates.res_cap_amt
, rebate_rates.comm_cap_amt

FROM  srr_info LEFT OUTER JOIN
               rebate_rates ON srr_info.rate_nbr = rebate_rates.rate_nbr
			   
where srr_info.srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<p style="margin-left:auto;margin-right:auto;width:790px;border:1px solid silver;border-radius:7px;">
<span style="font-size:130%;">*</span> Maximum Rebate Amount is: #dollarformat(getPropType.res_cap_amt)# for residential properties and #dollarformat(getPropType.comm_cap_amt)# for commercial properties.
<br /><br>
<span style="color:red;font-weight:bold;">**The detail provided is for valuation of the rebate amount to be offered.  The rebate valuation is not intended or expected to cover the full cost of the repair work. You should obtain cost estimates from properly licensed contractor(s) to determine the cost of the ADA compliance repairs.</span>
<br><br>
Items added voluntarily to the scope of work by applicant are not eligible for rebate.
</p>



<div class = "warning">
<cfif #getPropType.prop_type# is "r">
<cfif #request.calc_rebate_total# gt #getPropType.res_cap_amt#>
<strong>Rebate Amount (Residential Property) = #dollarformat(getPropType.res_cap_amt)#</strong>
<cfelse>
<strong>Rebate Amount (Residential Property) = #dollarformat(request.calc_rebate_total)#</strong>
</cfif>
<cfelseif #getPropType.prop_type# is "c" OR #getPropType.prop_type# is "">
<cfif #request.calc_rebate_total# gt #getPropType.comm_cap_amt#>
<strong>Rebate Amount (Commercial/Industrial Property) = #dollarformat(getPropType.comm_cap_amt)#</strong>
<cfelse>
<strong>Rebate Amount (Commercial/Industrial Property) = #dollarformat(request.calc_rebate_total)#</strong>
</cfif>
<cfelse>
<strong>Please make sure the property has a valid address and is classified as either residential or commercial.</strong>
</cfif>
</div>
</cfoutput>

