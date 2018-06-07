<!--- <cfparam name="request.sr_number" default="1-134748571">
<cfparam name="request.ar_id" default="1000">
<cfparam name="request.arKey" default="6dfEfjWF0DRJHVAL9Kz2VFqextFwn57hGcfmbs0za3ijWIJ6Yu">

<cfinclude template="../common/header.cfm"> --->


<script language="JavaScript" src="/styles/validation_alert_boxes.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">


// This is the main function to check the form entries [start]
function checkForm()
{


// Validate Radio Buttons 
if (document.form1.tree_step3_comp[0].checked == false && document.form1.tree_step3_comp[1].checked == false)
{
alert ("Please Select Yes or No!");
document.form1.tree_step3_comp[0].focus();
return false;
}
// Validate Radio Buttons 


document.getElementById('submit').value='Please Wait ...';
document.getElementById('submit').disabled=true; 

return true;
}
// This is the main function to check the form entries [end]

</script>

<cfinclude template="../common/validate_arKey.cfm">


<cfquery name="checkAr" datasource="#request.dsn#" dbtype="datasource">
Select arKey from bssEstimate
where arKey = '#request.arKey#'
</cfquery>

<cfif #checkAr.recordcount# is 0>
<cfquery name="AddToEstimate" datasource="#request.dsn#" dbtype="datasource">
insert into bssEstimate
(
ar_id
, sr_number
, arKey
)
VALUES
(
#request.ar_id#
, '#request.sr_number#'
, '#request.arKey#'
)
</cfquery>
</cfif>

<cfquery name="readBSSEstimate" datasource="#request.dsn#" dbtype="datasource">
Select * from BSSEstimate
where arKey = '#request.arKey#'
</cfquery>

<cfquery name="tree1" datasource="#request.dsn#" dbtype="datasource">
select tree_step3_comp,ar_status_cd
from ar_info
where arkey='#request.arkey#'
</cfquery>


<cfoutput>
<form action="control.cfm?action=ufd_estimate_action&#request.addtoken#" method="post" name="form1" id="form1" onSubmit="return checkForm();">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

<div align="center">
<div class="formbox" style="width:350px;">
<h1>Tree Information</h1>
<a href="http://navigatela.lacity.org/geocoder/geocoder.cfm?permit_code=SRPBSS&ref_no=#request.sr_number#&search=#URLEncodedFormat(request.job_address)#&allow_edit=1" target="_blank">Identify Tree Locations</a> (map)
<table border="1" class="datatable" align="center"  style="width:97%;font-size:90%;">
<tr>
<th>Item</th>
<th>Description</th>
<th>Unit</th>
<th>Quantity</th>
</tr>
</cfoutput>
<cfset xx = 1>
<cfset groupList = "2,3,4,5,6">
<cfloop index="y" list="#groupList#" delimiters=",">
<cfquery name="readFields" datasource="#request.dsn#" dbtype="datasource">
SELECT
[FieldName]
      ,[Units]
      ,[Price]
      ,[Sort_Order]
      ,[Sort_Group]
  FROM [accessprogram].[dbo].[bssEstimateForm]

  where suspend = 'n'
  and bssDivision = 'ufd'
  and sort_Group = #y#
  
order by sort_group, sort_order

</cfquery>


<cfif #readFields.recordcount# is not 0>
<cfquery name="groupName" datasource="#request.dsn#" dbtype="datasource">
SELECT
 [ID]
      ,[Category]
  FROM [accessprogram].[dbo].[tblSortGroup]
  where ID = #y#
</cfquery>
<cfoutput>
<tr>
<th colspan="4" style="text-align:left;">#groupName.Category#</th>
</tr>
</cfoutput>
</cfif>

<cfoutput query="readFields">
<cfset v = readfields.fieldname&"_">
			<cfset v = replace(v,"___",")_","ALL")>
			<cfset v = replace(v,"__"," (","ALL")>
			<cfset v = replace(v,"_UNITS","","ALL")>
			<cfset v = replace(v,"_l_","_/_","ALL")>
			<cfset v = replace(v,"_ll_",".","ALL")>
			<cfset v = replace(v,"FOUR_INCH","4#chr(34)#","ALL")>
			<cfset v = replace(v,"SIX_INCH","6#chr(34)#","ALL")>
			<cfset v = replace(v,"EIGHT_INCH","8#chr(34)#","ALL")>
			<cfset v = replace(v,"_INCH","#chr(34)#","ALL")>
			<cfset v = replace(v,"FOUR_FEET","4#chr(39)#","ALL")>
			<cfset v = replace(v,"SIX_FEET","6#chr(39)#","ALL")>
			<cfset v = replace(v,"_FEET","#chr(39)#","ALL")>
			<cfset v = replace(v,"_"," ","ALL")>
			<cfset v = lcase(v)>
			<cfset v = CapFirst(v)>
			<cfset v = replace(v," Dwp "," DWP ","ALL")>
			<cfset v = replace(v," Pvc "," PVC ","ALL")>
			<cfset v = replace(v,"(n","(N","ALL")>
			<cfset v = replace(v,"(t","(T","ALL")>
			<cfset v = replace(v,"(c","(C","ALL")>
			<cfset v = replace(v,"(r","(R","ALL")>
			<cfset v = replace(v,"(h","(H","ALL")>
			<cfset v = replace(v,"(o","(O","ALL")>
			<cfset v = replace(v,"(p","(P","ALL")>
			<cfset v = replace(v,"(u","(U","ALL")>
			<cfset v = replace(v,"(e","(E","ALL")>
			<cfset v = replace(v,"High Strength","High-Strength","ALL")>
			<cfset v = replace(v,"(ada","(ADA","ALL")>
			<cfset v = replace(v," And "," & ","ALL")>
			<cfset v = replace(v,"Composite","Comp","ALL")>
			<!--- <cfset v = replace(v," ","&nbsp;","ALL")> --->




<tr>
<td>#xx#</td>
<td>#v#</td>
<td>#readFields.Units#</td>
<cfquery name="readBSSEstimate" datasource="#request.dsn#" dbtype="datasource">
Select #readFields.FieldName#_Quantity as xValue from BSSEstimate
where arKey = '#request.arKey#'
</cfquery>

<td>
<input type="number" name="#readFields.FieldName#_Quantity" id="#readFields.FieldName#_Quantity" value="#readBSSEstimate.xValue#" style="width:30px;">
</td>
</tr>
<cfset xx = #xx# + 1>
</cfoutput>
</cfloop>

<tr>
<td colspan="4">
BSS Urban Forestry Comments:
<textarea style="width:95%;height:75px;" name="ufd_internal_comments" id="ufd_internal_comments"></textarea>
<p>(Internal Comments are shared among City staff)</p>
</td>
</tr>

<tr>
<td colspan="4">
	
	Is Tree Assessment Completed? <br>
	<p>
	<cfif #tree1.tree_step3_comp# is "">
		<input type="Radio" name="tree_step3_comp" value="Y" id="tree_step3_comp" style="width:65px;"<!---  required="true" --->> Yes
 		<input type="Radio" name="tree_step3_comp" value="N" id="tree_step3_comp" style="width:65px;" <!--- required="true" --->> No	
	
		<cfelseif #tree1.tree_step3_comp# is "y">
			<input type="Radio" name="tree_step3_comp" value="Y" id="tree_step3_comp" style="width:65px;" checked > Yes
	 		<input type="Radio" name="tree_step3_comp" value="N" id="tree_step3_comp" style="width:65px;" <!--- required="true" --->> No	

		<cfelseif #tree1.tree_step3_comp# is "N">
			<input type="Radio" name="tree_step3_comp" value="Y" id="tree_step3_comp" style="width:65px;"  > Yes
	 		<input type="Radio" name="tree_step3_comp" value="N" id="tree_step3_comp" style="width:65px;" checked> No	

<!--- 	<cfelse>
		Tree Assessment Status: <br>	<cfif #tree1.tree_step3_comp# is "y"> 
													Completed
												<cfelse> Not Completed
													<br>
													<br>
													Change Tree Assessment Status:<br>
													<input type="Radio" name="tree_step3_comp" value="Y" id="tree_step3_comp" style="width:65px;"<!---  required="true" --->> Yes
 													<input type="Radio" name="tree_step3_comp" value="N" id="tree_step3_comp" style="width:65px;" <!--- required="true" --->> No	
												</cfif>
 --->											
	</cfif>
	</p>
</td>
</tr>

</table>


</div>

<!--- <cfif #request.status_cd# is "pendingBSSReview"> --->


<cfif #tree1.ar_status_cd# is "BSSAssessmentCompleted">
<!----do nothing---->
<cfelse>
<div align="center"><input type="submit" name="submitUFDForm" id="submitUFDForm" value="Save" class="submit"></div>
</cfif>


<!--- <cfelse>
<div class="warning" style="width:90%;">This application is not currently in your queue.<br><br>No Action is Required at This Time.</div>
</cfif>
 --->
</form>

