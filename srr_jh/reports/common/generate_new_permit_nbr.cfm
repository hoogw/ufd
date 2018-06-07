<cfinclude template="/common/validate_referer.cfm">
<cfinclude template="/common/validate_ref_no.cfm">

<cfquery name="get_yr" datasource="#request.dsn#">
select * from permit_info where ref_no = #request.ref_no#
</cfquery>

<cfif #get_yr.permit_yr# is "">
<div align="center"><font face="Arial" size="2" color="#800000">
<b>You must select and update permit year before issuing permit.</b></font>
</div>
<cfabort>
</cfif>


<cfquery name="check_permit_info" datasource="#request.dsn#">
select count(permit_nbr) as apps_count
from permit_info where permit_nbr like '#get_yr.permit_yr#%'
</cfquery>

<!--- <cfoutput>
select count(permit_nbr) as apps_count
from permit_info where permit_nbr like '%#get_yr.permit_yr#'
<br><br>
#get_yr.permit_yr#
</cfoutput> --->

<!-- Case 1:       Count of  apps  is  0   -->
<cfif #check_permit_info.apps_count# is "0">
<cfset new_permit_nbr=#get_yr.permit_yr#&"0001">
<cfset request.permit_nbr=#new_permit_nbr#>
</cfif>
<!-- End of Case 1                                                                -->


<!-- Case 2:       Count of  apps  is  not 0    -->
<cfif #check_permit_info.apps_count# is not "0">

<cfquery name="max_permit_nbr" datasource="#request.dsn#">
select max(permit_nbr) as last_permit_nbr
from permit_info where permit_nbr like '#get_yr.permit_yr#%'
</cfquery>
<cfset new_permit_nbr=#MAX_permit_nbr.last_permit_nbr# + 1>
<cfset request.permit_nbr=#new_permit_nbr#>
</cfif>
<!-- End of Case 2                                                                -->


<!--- <cfoutput>
#request.permit_nbr#
</cfoutput> --->