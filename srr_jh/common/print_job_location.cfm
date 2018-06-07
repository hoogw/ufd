<cfinclude template="/srr/common/validate_srrKey.cfm">
<!-- document can handle supp. permits -->
<cfquery name="get_address" datasource="#request.dsn#" dbtype="datasource">
Select
 job_address
, hse_nbr
, str_nm
, unit_range
, pind
, bpp
, job_zip
, job_city
, case 
when (boe_dist = 'c') Then 'Central'
when (boe_dist = 'v') Then 'Valley'
when (boe_dist = 'w') Then 'West LA'
when (boe_dist = 'h') Then 'Harbor'
when (boe_dist is null or boe_dist = '') Then 'Not Assigned'
end as boe_dist
, council_dist
, tbm_grid
, hse_id
, address_verified

from srr_info
where srrKey = '#request.srrKey#'
</cfquery>



<cfoutput query="get_address">
<div align="center">
<h1>Job Address</h1>
<table width="100%" cellspacing="0" cellpadding="1" style="border-width: 0px; border-collapse:collapse;border-color:black;">

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.job_address#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Unit Range</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.unit_range#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Parcel Identification No.</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.pind#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Assessor No.</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.bpp#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">City</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.job_city#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Zip Code</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.job_zip#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Engineering District</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.boe_dist#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Council District</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.council_dist#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Thomas Guide (Page/Grid)</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#get_address.tbm_grid#</span></td>
</tr>

<tr>
<td width="35%" style="border-width: 1px;border-color:black;border-style:solid;">Address Verified</td>
<td width="65%" style="border-width: 1px;border-color:black;border-style:solid;"><span class="data">#YesNoFormat(get_address.address_verified)#</span></td>
</tr>

</table>
</div>
</cfoutput>