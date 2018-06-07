<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">

<cfinclude template="../common/include_sr_job_address.cfm">

<cfoutput>
<cfinclude template="add_to_scope_menu.cfm">


<div class="textbox" style="width:700px;">
<h1>Add to A-Permit Scope or Submit your A-Permit</h1>
<!--- <div align="center"><a href="list_sidewalks.cfm?srrKey=#request.srrKey#">Sidewalks</a> |  <a href="list_driveways.cfm?srrKey=#request.srrKey#">Driveways</a>  |  <a href="edit_other_items.cfm?srrKey=#request.srrKey#">Other Items</a>  |  Submit my A-Permit</div> --->
<p>
The City's Inspector included only the work necessary to make the pathways around the property ADA compliant.
<br><br>
You may elect to add to the scope of work by replacing other sidewalk segments, driveways, or other items.
<br><br>
Please use the links above to add to the scope of work if you wish to do so.
<br><br>
Whether you elect to add to the scope of work or not, <strong>please make sure to Submit your A-permit for processing</strong>.
</p>
</div>

<!--- <div align="center">
<input type="button" name="add" id="add" value="Add Sidewalk Segment" class="submit" onClick="location.href = 'add_sidewalk1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
&nbsp;&nbsp;
<input type="button" name="submit" id="submit" value="Add Driveway" class="submit" onClick="location.href = 'add_driveway1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">

&nbsp;&nbsp;
<input type="button" name="submit" id="submit" value="Add Other Items" class="submit" onClick="location.href = 'add_other_items1.cfm?srrKey=#request.srrKey#&#request.addtoken#'">
</div> --->

<div align="center"><input type="button" name="app_requirements" id="app_requirements"  class = "submit" value="Back to Application Requirements" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#&#request.addtoken#'"></div>
 
</cfoutput> 

<cfinclude template="../common/footer.cfm">