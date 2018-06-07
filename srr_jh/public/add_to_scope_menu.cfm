<cfinclude template="../common/validate_srrKey.cfm">

<style>
.menuButton {
		margin-top: 10px;
		font-size:100%;
		padding-left: 20px; 
		padding-right: 20px; 
		padding-top: 6px; 
		padding-bottom: 6px; 
		color: #FFFFFF;
		/*background:#4D0000; */
		background: linear-gradient(to right, #004D99 , #80BFFF);
		border: 1px solid #999;
		cursor:pointer;
		-webkit-border-radius: 5px;
		border-radius: 5px; 
		}
</style>


<cfoutput>
<div align="center">
<span class="subtitle">Add to Scope:</span>&nbsp;&nbsp;
<input type="button" name="listSidewalks" id="listSidewalks" value="Sidewalks" class="menuButton"  onClick="location.href='list_sidewalks.cfm?srrKey=#request.srrKey#'">
&nbsp;&nbsp;
<input type="button" name="list_driveways" id="list_driveways" value="Driveways" class="menuButton"  onClick="location.href='list_driveways.cfm?srrKey=#request.srrKey#'">
&nbsp;&nbsp;
<input type="button" name="edit_other_items" id="edit_other_items" value="Other Items" class="menuButton"  onClick="location.href='edit_other_items1.cfm?srrKey=#request.srrKey#'">
&nbsp;&nbsp; <span class="subtitle">Or:</span> &nbsp;
<input type="button" name="submitA" id="submitA" value="Submit my A-Permit" class="menuButton"  onClick="location.href='submit_apermit1.cfm?srrKey=#request.srrKey#'">
<div align="center"><img src="../images/bluePixel.png" alt="" width="800px;" height="1" border="0"></div>

<!--- 
<a href="list_sidewalks.cfm?srrKey=#request.srrKey#">Sidewalks</a> |  <a href="list_driveways.cfm?srrKey=#request.srrKey#">Driveways</a>  |  <a href="edit_other_items.cfm?srrKey=#request.srrKey#">Other Items</a>  |  Submit my A-Permit --->
</div>
</cfoutput>