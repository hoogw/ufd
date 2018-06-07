<cfif not isdefined("request.submit")>

<cfoutput>
<form action="new_srr.cfm" method="post" name="form1" id="form1">

<div class="formbox" style="width:700px;">
<h1>Program Interest Form</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td colspan="2" align="center"><em>Please Complete All Applicable Fields</em></td>
</tr>

<tr>
<td style="width: 40%">Name</td>
<td><input type="text" name="app_name_nn" id="app_name_nn" size="35"></td>
</tr>

<tr>
<td style="width: 40%">Property</td>
<td>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td colspan="3">Address <br><input type="text" name="job_address" id="job_address" size="35"></td>
</tr>

<cfquery name="get_state" datasource="common" dbtype="datasource">
select * from state_lookup
</cfquery>



<tr>
	<td>City <br><input type="text" name="job_city" id="job_city" size="15"></td>
	
	<td>State <br><select NAME="job_state">
<option value="" selected>Select State</option>
<CFLOOP QUERY="get_state">
<option value="#get_state.state#">#get_state.state_name#</option>
</cfloop>
</select>
</td>


	<td>Zip <br><input type="text" name="job_zip" id="job_zip" size="7"></td>
	
</tr>
</table>

</td>
</tr>

<tr>
<td style="width: 40%">Mailing Address<br>(if different from above)</td>
<td>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td colspan="3">Address <br><input type="text" name="mailing_address" id="mailing_address" size="35"></td>
</tr>

<cfquery name="get_state" datasource="common" dbtype="datasource">
select * from state_lookup
</cfquery>



<tr>
	<td>City <br><input type="text" name="mailing_city" id="mailing_city" size="15"></td>
	
	<td>State <br><select NAME="mailing_state">
<option value="" selected>Select State</option>
<CFLOOP QUERY="get_state">
<option value="#get_state.state#">#get_state.state_name#</option>
</cfloop>
</select>
</td>


	<td>Zip <br><input type="text" name="mailing_zip_code" id="mailing_zip_code" size="7"></td>
	
</tr>
</table>

</td>
</tr>

<tr>
<td style="width: 40%">Email</td>
<td><!--- <input type="text" name="app_email" id="app_email" size="25"> ---></td>
</tr>

<tr>
<td style="width: 40%">Daytime Phone</td>
<td><!--- <input type="text" name="app_phone" id="app_phone" size="25"> ---></td>
</tr>

<tr>
<td style="width: 40%">Preferred Contact Method</td>
<td>
<select name="pref_contact_method" id="pref_contact_method">
	<option value="">Select one</option>
	<option value="email"  SELECTED>Email</option>
	<option value="mail">Mail</option>
</select>
</td>
</tr>

<tr>
<td style="width: 40%">Sidewalk Repair Includes</td>
<td>
<select></select>
</td>
</tr>

<tr>
<td style="width: 40%">Were damages caused by Street Trees?</td>
<td><input type="radio" name="tree_damage" id="tree_damage" value="n"> &nbsp;No&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio"  id="tree_damage" name="tree_damage" value="y"> &nbsp;Yes</td>
</tr>

</table>
<div align="center">Application must be submitted by property owner</div>
</div>
<div align="center"><input type="submit" name="submit" id="submit" value="Submit"></div>

</form>
</cfoutput>
</cfif>

<cfif isdefined("form.submit")>


<cfparam name="request.tree_damage" default="">

<!--- <cfoutput>
INSERT INTO [dbo].[srr_info]
           (
		   [app_id]
		   
           , [app_name_nn]
           , [job_address]
           , [job_city]
           , [job_state]
           , [job_zip]
		   
           , [mailing_address]
           , [mailing_zip_code]
           , [mailing_city]
           , [mailing_state]
           , [tree_damage]

           , [srr_status]
		   )
     VALUES
           (
		    #client.app_id#
			
           , '#request.app_name_nn#'
           , '#request.job_address#'
           , '#request.job_city#'
           , '#request.job_state#'
           , '#request.job_zip#'
		   
           , '#request.mailing_address#'
           , '#request.mailing_zip_code#'
           , '#request.mailing_city#'
           , '#request.mailing_state#'
           , '#request.tree_damage#'
           , 'received'
		   )
</cfoutput>

<cfabort> --->

<cfquery name="add_srr" datasource="#request.dsn#" dbtype="datasource">
INSERT INTO [dbo].[srr_info]
           (
		   [app_id]
		   , ddate_submitted
           , [app_name_nn]
           , [job_address]
           , [job_city]
           , [job_state]
           , [job_zip]
		   
           , [mailing_address]
           , [mailing_zip_code]
           , [mailing_city]
           , [mailing_state]
           , [tree_damage]

           , [srr_status]
		   )
     VALUES
           (
		    #client.app_id#
			, #now()#
			
           , '#request.app_name_nn#'
           , '#request.job_address#'
           , '#request.job_city#'
           , '#request.job_state#'
           , '#request.job_zip#'
		   
           , '#request.mailing_address#'
           , '#request.mailing_zip_code#'
           , '#request.mailing_city#'
           , '#request.mailing_state#'
           , '#request.tree_damage#'
           , 'received'
		   )
</cfquery>

</cfif>


