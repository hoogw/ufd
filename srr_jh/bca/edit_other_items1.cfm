<cfinclude template="header.cfm">
<cfinclude template="../common/validate_srrKey.cfm">
<!--- <cfinclude template="../common/getSrrID.cfm"> --->
<cfinclude template="navbar2.cfm">

<cfif #request.status_cd# is not "pendingBcaReview">
<cfoutput>
<div class="warning">
SR Status: #request.status_desc#<br><br>
This Service Request is Locked at this time
</div><br>
</cfoutput>
</cfif>

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


<!--- curb_cuts_qty --->
<cfquery name="getSrrOtherItems" datasource="#request.dsn#" dbtype="datasource">
Select 

conc_curb_qty
, conc_gutter_qty
, access_ramp_qty
, partial_dwy_conc_qty
<!--- , drains_no --->
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
, sidewalk_trans_qty
, catch_basin_lid_qty
, pkwy_drain_qty

from srr_other_items
where srr_id = #request.srr_id#
</cfquery>

<cfoutput>
<form action="edit_other_items2.cfm" method="post" name="form1" id="form1" role="form">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">
<!--- <div class="formbox"> --->
<div class="divSubTitle">Other Items</div>

<!--- <div class="field">
<label>Curb Cuts (LF)</label>
<input type="number" name="curb_cuts_qty" id="curb_cuts_qty" size="10" placeholder="LF" <cfif #getSrrOtherItems.curb_cuts_qty# gt 0> value="#decimalformat(getSrrOtherItems.curb_cuts_qty)#"</cfif>>
</div> --->

<div class="field">
<label>Curb (remove and replace) (LF)</label>
<input type="number" name="conc_curb_qty" id="conc_curb_qty" size="10" placeholder="LF" <cfif #getSrrOtherItems.conc_curb_qty# gt 0>value="#decimalformat(getSrrOtherItems.conc_curb_qty)#"</cfif> step="any">
</div>

<div class="field">
<label>Gutter (remove and replace) (LF)</label>
<input type="number" name="conc_gutter_qty" id="conc_gutter_qty" size="10" placeholder="LF" <cfif #getSrrOtherItems.conc_gutter_qty# gt 0>value="#decimalformat(getSrrOtherItems.conc_gutter_qty)#"</cfif> step="any">
</div>

<div class="field">
<label>Sidewalk Transition Panel (Sq. Ft.)</label>
<input type="number" name="sidewalk_trans_qty" id="sidewalk_trans_qty" size="10" placeholder="Sq. Ft." <cfif #getSrrOtherItems.sidewalk_trans_qty# gt 0>value="#DecimalFormat(getSrrOtherItems.sidewalk_trans_qty)#"</cfif>>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Utility Interference</label>
<input type="radio" name="util_interference" id="util_interference" value="y" <cfif #getSrrOtherItems.util_interference# is "Y">checked</cfif>> Yes
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="util_interference" id="util_interference" value="n" <cfif #getSrrOtherItems.util_interference# is "N">checked</cfif>> No
<br>Comments:<br>
<textarea cols="" rows="" name="util_interference_comments" id="util_interference_comments" style="width:95%;height:50px;margin-top:5px;" placeholder="Describe ...">#getSrrOtherItems.util_interference_comments#</textarea>
</div>

<div class="field">
<label>Access Ramp(s)  (How Many?)</label>
<input type="number" name="access_ramp_qty" id="access_ramp_qty" size="10" placeholder="How Many?"  <cfif #getSrrOtherItems.access_ramp_qty# gt 0>value="#NumberFormat(getSrrOtherItems.access_ramp_qty)#"</cfif> step="any">
<!---<label>Sq. Ft.</label>
<input type="number" name="access_ramp_qty" id="access_ramp_qty" size="10" placeholder="Sq Ft">--->
</div>

<div class="field">
<label>Partial Driveway (Sq. Ft.)</label>
<input type="number" name="partial_dwy_conc_qty" id="partial_dwy_conc_qty" size="10" placeholder="Sq. Ft."  <cfif #getSrrOtherItems.partial_dwy_conc_qty# gt 0>value="#decimalformat(getSrrOtherItems.partial_dwy_conc_qty)#"</cfif> step="any">
</div>

<div class="field">
<label>Parkway Drain(s) (remove and replace) (LF)</label>
<input type="number" name="pkwy_drain_qty" id="pkwy_drain_qty" size="10" placeholder="LF" <cfif #getSrrOtherItems.pkwy_drain_qty# gt 0>value="#DecimalFormat(getSrrOtherItems.pkwy_drain_qty)#"</cfif>>
</div>

<div class="field">
<label>Catch Basin Conc. Cover (remove and replace) (Sq. Ft.)</label>
<input type="number" name="catch_basin_lid_qty" id="catch_basin_lid_qty" size="10" placeholder="Sq. Ft." <cfif #getSrrOtherItems.catch_basin_lid_qty# gt 0>value="#decimalFormat(getSrrOtherItems.catch_basin_lid_qty)#"</cfif>>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Pullbox(es) (How Many?)</label>
<input type="number" name="pullbox_no" id="pullbox_no" size="10" placeholder="How Many?" <cfif #getSrrOtherItems.pullbox_no# gt 0>value="#NumberFormat(getSrrOtherItems.pullbox_no)#"</cfif>>
<br>Comments:<br>
<textarea  name="pullbox_comments" id="pullbox_comments" style="width:95%;height:50px;margin-top:5px;" placeholder="Describe ...">#getSrrOtherItems.pullbox_comments#</textarea>
</div>


<!--- not part of A-permit --->
<div class="field">
<label>Signage (How Many?)</label>
<input type="number" name="signage_no" id="signage_no" size="10" placeholder="How Many?" <cfif #getSrrOtherItems.signage_no# gt 0>value="#NumberFormat(getSrrOtherItems.signage_no)#"</cfif>>
<br>Comments:<br>
<textarea  name="signage_comments" id="signage_comments" style="width:95%;height:50px;margin-top:5px;" placeholder="Describe ...">#getSrrOtherItems.signage_comments#</textarea>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Street Furniture (How Many?)</label>
<input type="number" name="st_furn_no" id="st_furn_no" size="10" placeholder="How Many?"  <cfif #getSrrOtherItems.st_furn_no# gt 0>value="#NumberFormat(getSrrOtherItems.st_furn_no)#"</cfif>>
<br>Comments:<br>
<textarea name="st_furn_comments" id="st_furn_comments" style="width:95%;height:50px;margin-top:5px;" placeholder="Describe ...">#getSrrOtherItems.st_furn_comments#</textarea>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Parking Meter(s) (How Many?)</label>
<input type="number" name="parking_meter_no" id="parking_meter_no" size="10" placeholder="How Many?" <cfif #getSrrOtherItems.parking_meter_no# gt 0>value="#NumberFormat(getSrrOtherItems.parking_meter_no)#"</cfif>>
</div>

<!--- not part of A-permit --->
<div class="field">
<label>Survey Monument(s) (How Many?)</label>
<input type="number" name="survey_monument_no" id="survey_monument_no" size="10" placeholder="How Many?"  <cfif #getSrrOtherItems.survey_monument_no# gt 0>value="#NumberFormat(getSrrOtherItems.survey_monument_no)#"</cfif>>
</div>


<!--- </div> --->
<cfif #request.status_cd# is "pendingBcaReview">
<div style="text-align:center;">
<input type="submit" name="save" id="save" value="Save">
</div>
</cfif>

</form>
</cfoutput>


<cfinclude template="footer.cfm">
