<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request">
<cfinclude template="../common/validate_srrKey.cfm">
<cfset request.ref_no = #request.a_ref_no#>

<cfinclude template="add_to_scope_menu.cfm">

<div class="subtitle">
Other Items
</div>


<!--- <cfquery name="getAOtherItems" datasource="apermits_sql" dbtype="datasource">
Select 
curb_cuts_qty
, conc_curb_qty
, conc_gutter_qty
, access_ramp_qty
, partial_dwy_conc_qty
, drains_no
from other_items
where ref_no = #request.ref_no#
</cfquery> --->

<cfquery name="getSrrOtherItems" datasource="#request.dsn#" dbtype="datasource">
Select 
<!--- curb_cuts_qty --->
conc_curb_qty
, conc_gutter_qty
, access_ramp_qty
, partial_dwy_conc_qty
<!--- , drains_no --->
<!--- , curb_cuts_qty_opt --->
, conc_curb_qty_opt
, conc_gutter_qty_opt
, access_ramp_qty_opt
, partial_dwy_conc_qty_opt
<!--- , drains_no_opt --->
, util_interference 
, util_interference_comments
, pullbox_no
, pullbox_comments
, signage_no
, signage_comments
, st_furn_no
, st_furn_comments
, parking_meter_no
, survey_monument_no

, catch_basin_lid_qty
, sidewalk_trans_qty
, pkwy_drain_qty

from srr_other_items
where srr_id = #request.srr_id#
</cfquery>

<cfoutput>
<form action="edit_other_items2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<div class="formbox" style="width:910px;">
<h1>Other Items</h1>

<table width="900" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>

<td style="width:400px;vertical-align:top;">
<div class="subtitle">Required for ADA Compliance</div>
<!--- <div class="field">
<label>Curb Cuts (LF)</label>
<span class="data">#NumberFormat(getSrrOtherItems.curb_cuts_qty)#</span>
</div> --->


<div class="field">
<label>Curb (remove and replace) (LF)</label>
<span class="data">#NumberFormat(getSrrOtherItems.conc_curb_qty)#</span>
</div>

<div class="field">
<label>Gutter (remove and replace) (LF)</label>
<span class="data">#NumberFormat(getSrrOtherItems.conc_gutter_qty)#</span>
</div>

<div class="field">
<label>Sidewalk Transition Panel (Sq. Ft.)</label>
<span class="data">#DecimalFormat(getSrrOtherItems.sidewalk_trans_qty)#</span>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Utility Interference</label>
<cfif #getSrrOtherItems.util_interference# is "Y"><span class="data">Yes</span></cfif>
<cfif #getSrrOtherItems.util_interference# is "N"><span class="data">No</span></cfif>
<br>Comments:<br>
<span class="data">#getSrrOtherItems.util_interference_comments#</span>
</div>

<div class="field">
<label>Access Ramp(s)  (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.access_ramp_qty)#</span>
</div>

<div class="field">
<label>Partial Driveway (Sq. Ft.)</label>
<span class="data">#decimalformat(getSrrOtherItems.partial_dwy_conc_qty)#</span>
</div>

<div class="field">
<label>Parkway Drain(s) (remove and replace) (LF)</label>
<span class="data">#DecimalFormat(getSrrOtherItems.pkwy_drain_qty)#</span>
</div>

<div class="field">
<label>Catch Basin Conc. Cover (remove and replace) (Sq. Ft.)</label>
<span class="data">#decimalFormat(getSrrOtherItems.catch_basin_lid_qty)#</span>
</div>


<!--- <div class="field">
<label>Curb Drains(s) (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.drains_no)#</span>
</div> --->

<!--- not part of A-permit --->
<div class="field">
<label>Pullbox(es) (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.pullbox_no)#</span>
<br>Comments:<br>
<span class="data">#getSrrOtherItems.pullbox_comments#</span>
</div>


<!--- not part of A-permit --->
<div class="field">
<label>Signage (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.signage_no)#</span>
<br>Comments:<br>
<span class="data">#getSrrOtherItems.signage_comments#</span>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Street Furniture (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.st_furn_no)#</span>
<br>Comments:<br>
<span class="data">#getSrrOtherItems.st_furn_comments#</span>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Parking Meter(s) (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.parking_meter_no)#</span>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Survey Monument(s) (How Many?)</label>
<span class="data">#NumberFormat(getSrrOtherItems.survey_monument_no)#</span>
</div>
</td>

<td style="width:10px;"></td>


<td style="width:400px;vertical-align:top;">
<div class="subtitle">Optional</div>
<!--- <div class="field">
<label>Curb Cuts (LF)</label>
<input type="number" name="curb_cuts_qty_opt" id="curb_cuts_qty_opt" size="10" placeholder="LF" value="#NumberFormat(getSrrOtherItems.curb_cuts_qty_opt)#">
</div> --->

<div class="field">
<label>Curb (remove and replace) (LF)</label>
<input type="number" name="conc_curb_qty_opt" id="conc_curb_qty_opt" size="10" placeholder="LF" value="#NumberFormat(getSrrOtherItems.conc_curb_qty_opt)#">
</div>

<div class="field">
<label>Gutter (remove and replace) (LF)</label>
<input type="number" name="conc_gutter_qty_opt" id="conc_gutter_qty_opt" size="10" placeholder="LF" value="#NumberFormat(getSrrOtherItems.conc_gutter_qty_opt)#">
</div>

<div class="field">
<label>Access Ramp(s)  (How Many?)</label>
<input type="number" name="access_ramp_qty_opt" id="access_ramp_qty_opt" size="10" placeholder="How Many?"  value="#NumberFormat(getSrrOtherItems.access_ramp_qty_opt)#">
<!---<label>Sq. Ft.</label>
<input type="number" name="access_ramp_qty" id="access_ramp_qty" size="10" placeholder="Sq Ft">--->
</div>

<div class="field">
<label>Partial Driveway (Sq. Ft.)</label>
<input type="number" name="partial_dwy_conc_qty_opt" id="partial_dwy_conc_qty_opt" size="10" placeholder="Sq. Ft."  value="#decimalformat(getSrrOtherItems.partial_dwy_conc_qty_opt)#">
</div>

<p>All quantities under &quot;Optional&quot; will not be included in calculating the rebate amounts.</p>



</td>
</tr>
</table>


</div>

<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>

</form>
</cfoutput>


<cfinclude template="footer.cfm">
