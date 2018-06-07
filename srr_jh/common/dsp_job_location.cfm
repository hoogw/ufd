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
where srr_id=#request.srr_id#
</cfquery>



<cfoutput query="get_address">
<div class="formbox" style="width:490px;">
<h1>Job Address  (Source: MyLA311)</h1>
<table border="1"  class = "formtable" style = "width: 100%;">

<tr>
<td width="35%">Address</td>
<td width="65%"><span class="data"><a href="http://navigatela.lacity.org/navigatela/?search=#URLEncodedFormat(job_address)#" target="_blank">#get_address.job_address#</a></span></td>
</tr>

<tr>
<td width="35%">Unit Range</td>
<td width="65%"><span class="data">#get_address.unit_range#</span></td>
</tr>

<tr>
<td width="35%">Parcel Identification No.</td>
<td width="65%"><span class="data">#get_address.pind#</span></td>
</tr>

<tr>
<td width="35%">Assessor No.</td>
<td width="65%"><span class="data">#get_address.bpp#</span></td>
</tr>

<tr>
<td width="35%">City</td>
<td width="65%"><span class="data">#get_address.job_city#</span></td>
</tr>

<tr>
<td width="35%">Zip Code</td>
<td width="65%"><span class="data">#get_address.job_zip#</span></td>
</tr>

<tr>
<td width="35%">Engineering District</td>
<td width="65%"><span class="data">#get_address.boe_dist#</span></td>
</tr>

<tr>
<td width="35%">Council District</td>
<td width="65%"><span class="data">#get_address.council_dist#</span></td>
</tr>

<tr>
<td width="35%">Thomas Guide (Page/Grid)</td>
<td width="65%"><span class="data">#get_address.tbm_grid#</span></td>
</tr>

<tr>
<td width="35%">Address Verified</td>
<td width="65%"><span class="data">#YesNoFormat(get_address.address_verified)#</span></td>
</tr>

</table>
</div>
</cfoutput>