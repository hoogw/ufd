<cfquery name="getAddress" datasource="#request.dsn#" dbtype="datasource">
SELECT 
[srr_id]
      ,[srrKey]
      ,[sr_number]
      ,[srr_status_cd]
      ,[hse_nbr]
      ,[hse_frac_nbr]
      ,[hse_dir_cd]
      ,[str_nm]
      ,[str_sfx_cd]
      ,[str_sfx_dir_cd]
      ,[zip_cd]
      ,[unit_range]
      ,[hse_id]
      ,[tbm_grid]
      ,[boe_dist]
      ,[council_dist]
      ,[bpp]
      ,[pin]
      ,[pind]
      ,[address_verified]
      ,[zoningCode]
      ,[prop_type]
      ,[prop_data_checked]
      ,[job_address]
      ,[x_coord]
      ,[y_coord]
      ,[longitude]
      ,[latitude]
  

  FROM [srr].[dbo].[srr_info]
where srrKey = '#request.srrKey#'
</cfquery>

<cfoutput>
<form action="control.cfm?action=override_address2&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="srrKey" id="srrKey" value="#request.srrKey#">

<div class="formbox" style="width:600px;">
<h1>Overriding Address</h1>

<table border="1" align="center" class="datatable" style="width:100%;">
<tr>
	<td>Old Address:</td>
	<td><strong>#getAddress.job_address# - #getAddress.zip_cd#</strong></td>
</tr>

<tr>
	<td colspan="2"><strong>New Address:</strong></td>
</tr>

<tr>
	<td>House Number:</td>
	<td><input type="text" name="hse_nbr" id="hse_nbr" size="15"></td>
</tr>

<tr>
	<td>Street Name:</td>
	<td><input type="text" name="str_nm" id="str_nm" size="30" required> (Example: Spring)<br>(Do not type St, Ave, Dr, etc.)</td>
</tr>

<tr>
	<td colspan="2">You may search by Street Name only to see all addresses located on that street.</td>
</tr>



<!--- <tr>
	<td colspan="2" valign="top">Justification:<br>
	<textarea style="width:90%;height:100px;" name="justification" id="justification" required></textarea>
	</td>
</tr> --->
</table>



  


</div>

<div align="center"><input type="submit" name="submit" id="submit" value="Validate Address" class="submit"></div>

</FORM>

</cfoutput>





