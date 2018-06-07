<cfinclude template="/srr/common/validate_srr_id.cfm">

<cfquery name="find_srr" datasource="#request.dsn#" dbtype="datasource">
SELECT 
srr_info.srr_id
, srr_info.ddate_submitted
, srr_info.boe_dist
, srr_info.council_dist
, srr_info.job_address
, srr_info.PIND
, srr_info.BPP
, srr_info.TBM_GRID
, srr_info.job_zip
, screen_dates.job_address_screen_dt
, boe_dist.boe_dist_short_name
, srr_info.address_verified

FROM  screen_dates RIGHT OUTER JOIN
               srr_info ON screen_dates.srr_id = srr_info.srr_id LEFT OUTER JOIN
               common.dbo.boe_dist  as boe_dist ON srr_info.boe_dist = boe_dist.boe_dist

where srr_info.srr_id=#request.srr_id#
</cfquery>

<cfif #find_srr.pind# is not "">
<CFQUERY NAME="get_zone" DATASOURCE="navla_spatial">
		select zone_cmplt 
		from pin_zone 
		where pin = '#find_srr.pind#'
</CFQUERY>
</cfif>


<cfif #find_srr.ddate_submitted# is not "">
<cflocation addtoken="No" url="control.cfm?action=dsp_app&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>

<cfif #find_srr.job_address_screen_dt# is "">
<cflocation addtoken="No" url="control.cfm?action=get_job_location1&srr_id=#request.srr_id#&#request.addtoken#">
</cfif>


<!---<cfinclude template="/srr/common/dsp_srr_id.cfm">--->


<div align="center">
For verified addresses, please click on Address to view property location and access more reports.
<table align="center" class="datatable" id="table1" style="width:75%;">
<TR>
<th>Address</th>
<th>BOE Dist.</th>
<th>Council Dist.</th>
<th>APN<br>(Assessor Parcel Number)</th>
<th>PIN<br>(Parcel Identification Number)</th>
<th>Address Verified</th>
<th>Zoning</th>
<th>Action</th>
</tr>

<cfset x=1>

<cfoutput query="find_srr">
<tr>
<td>
<cfif #address_verified# is 1>
<a href="http://navigatela.lacity.org/navigatela/?search=#URLEncodedFormat(find_srr.job_address)#" target="_blank">#trim(find_srr.job_address)#</a>
</cfif></td>
<td style="text-align:center;">#find_srr.boe_dist#&nbsp;</td> 
<td style="text-align:center;">#find_srr.council_dist#&nbsp;</td> 
<td style="text-align:center;">#find_srr.bpp#&nbsp;</td> 

<td style="text-align:center;"><!--- <a href="http://navigatela.lacity.org/navigatela/?search=#find_srr.pind#" target="_blank"> --->#find_srr.pind#<!--- </a> --->&nbsp;</td> 
<td style="text-align:center;"><cfif #find_srr.address_verified# is 1>Yes<cfelse>No</cfif></td> 

<td style="text-align:center;">
<cfif #find_srr.pind# is not "" and #get_zone.recordcount# is not 0>
#get_zone.zone_cmplt#
</cfif>
</td>
<td style="text-align:center;">
<a href="remove_job_location.cfm?srr_id=#request.srr_id#&#request.addtoken#"><strong>Remove</strong></a>
</td> 
</tr>
</table>
</div>
</cfoutput>

</table>
</div>

<cfoutput>
<div align="center"><input type="button" name="cancel" id="cancel" value="Cancel" class="submit" onClick="location.href = 'control.cfm?action=app_requirements&srr_id=#request.srr_id#&#request.addtoken#'"></div>
</cfoutput>