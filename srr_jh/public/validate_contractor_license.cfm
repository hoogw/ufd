<cfmodule template="../common/header.cfm" title="Sidewalk Rebate Request (Public)">
<cfinclude template="../common/validate_srrKey.cfm">
<!--- 5425100 --->
<cfinclude template="../common/include_sr_job_address.cfm">

<cfif not isdefined("request.license_no")>
<cfoutput>
<div class = "warning" >Invalid Request!
<br><br>
To Provide Contractor's License, please <a href="get_contractor_license1.cfm?srrKey=#request.srrKey#">click here</a>
</div>
</cfoutput>
<cfabort>
</cfif>

<cfoutput>

<cftry>
<cfmodule template="../modules/licensing_module.cfm" license_no="#request.license_no#">
<cfcatch type="Any">
<div class="warning" style="width:550px;">Could Not Check the License Information</div>
<br>
<div align="center"><input type="button" name="tryAgain" id="tryAgain" value="Try Again" class="submit" onClick="location.href = 'get_contractor_license1.cfm?srrKey=#request.srrKey#'"></div>
<cfmail to="essam.amarragy@lacity.org" from="eng.lapermits@lacity.org" subject="Failed to Validate Contractor's License - #request.license_no#">
Failed to Validate Contractor's License - #request.license_no#
</cfmail>
<cfabort>
</cfcatch>
</cftry>
<cfif #request.cont_valid# is "N">
<div class="warning">
Invalid License Number
<br><br>
<strong>#request.cont_err_message#</strong>
<br><br>
A valid Contractor's License Number with class A, C-8, C-12, or C-61:D-06 is required to continue.
</div>
<br>
<div align="center"><input type="button" name="tryAgain" id="tryAgain" value="Try Again" class="submit" onClick="location.href = 'get_contractor_license1.cfm?srrKey=#request.srrKey#'">&nbsp;&nbsp;<input type="button" name="appRequirements" id="appRequirements" value="Back to Requirements" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#'"></div>
<cfabort>
</cfif>

<div class="formbox" style="width:550px;">
<h1>Contractor Verification</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td>Contractor's License Number (California)</td>
<td>#request.license_no#</td>
</tr>

<tr>
<td>Contractor Name</td>
<td>#request.cont_name#</td>
</tr>

<tr>
<td>Address</td>
<td>#request.cont_address#<br>#request.cont_city#, #request.cont_state# #request.cont_zip#</td>
</tr>

<tr>
<td>Phone</td>
<td>#request.cont_phone#</td>
</tr>

<tr>
<td>License Issued Date</td>
<td>#request.cont_iss_date#</td>
</tr>



<tr>
<td>License Expiration Date</td>
<td>#request.cont_exp_date#</td>
</tr>

<!--- <cfdump var="#request.cont_class#" output="browser"> --->

<tr>
<td>License Class</td>
<td>
<cfloop index="xx" list="#request.cont_class#" delimiters="|">
<div style="text-align:left;">#xx#</div>
</cfloop>
</td>
</tr>

</table>
</div>

<cfset request.cont_class1 = #request.cont_class#>

<cfset request.cont_class=ReplaceNoCase("#request.cont_class#"," ","","ALL")>
<cfset request.cont_class=ReplaceNoCase("#request.cont_class#","-","","ALL")>
<br>
<!--- or left(#request.cont_class#, 7) is "C61/D06" --->
<cfif left(#request.cont_class#, 2) is "C8" or left(#request.cont_class#, 3) is "C12" or left(#request.cont_class#, 1) is "A"   or FindNoCase("C8", #request.cont_class# , 0) or FindNoCase("C12", #request.cont_class# , 0) or FindNoCase("D06", #request.cont_class# , 0) or FindNoCase("|A", #request.cont_class# , 0)>
<div class="warning">Valid License Class for Concrete Work</div>
<form action="confirmContractor.cfm" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<input type="hidden" name="cont_license_no" id="cont_license_no" value="#request.license_no#">
<input type="hidden" name="cont_name" id="cont_name" value="#request.cont_name#">
<input type="hidden" name="cont_address" id="cont_address" value="#request.cont_address#">
<input type="hidden" name="cont_city" id="cont_city" value="#request.cont_city#">
<input type="hidden" name="cont_state" id="cont_state" value="#request.cont_state#">     
<input type="hidden" name="cont_zip" id="cont_zip" value="#request.cont_zip#">
<input type="hidden" name="cont_phone" id="cont_phone" value="#request.cont_phone#">
<input type="hidden" name="cont_lic_issue_dt" id="cont_lic_issue_dt" value="#request.cont_iss_date#">
<input type="hidden" name="cont_lic_exp_dt" id="cont_lic_exp_dt" value="#request.cont_exp_date#">
<input type="hidden" name="cont_lic_class" id="cont_lic_class" value="#request.cont_class1#">

<div align="center"><input type="submit" name="submit" id="submit" value="Confirm" class="submit">&nbsp;&nbsp;<input type="button" name="appRequirements" id="appRequirements" value="Back to Requirements" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#'"></div>
</form>
<cfelse>


<div class="warning" style="width:550px;">Invalid License Class for Concrete Work<br><br>
Please make sure you are hiring a contractor who is licensed to perform concrete work.
A valid Contractor's License Number with class <strong>A, C-8, C-12, or C-61:D-06</strong> is required to continue.
</div>
<br>
<div align="center"><input type="button" name="tryAgain" id="tryAgain" value="Try Again" class="submit" onClick="location.href = 'get_contractor_license1.cfm?srrKey=#request.srrKey#'">&nbsp;&nbsp;<input type="button" name="appRequirements" id="appRequirements" value="Back to Requirements" class="submit" onClick="location.href = 'app_requirements.cfm?srrKey=#request.srrKey#'"></div>
</cfif>


 
</cfoutput> 

</body>
</html>