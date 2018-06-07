<!doctype html>

<html>
<head>
	<title>Address Module Test</title>
</head>


<body>

<cfparam name="request.hse_id" default="0">					<!--- The passed House Number ID - In the future someone can specify the exact address by using the House Number ID --->
<cfparam name="request.hse_nbr" default="0">				<!--- The passed House Number --->
<cfparam name="request.hse_frac_nbr" default="">			<!--- The passed House Number Fraction --->
<cfparam name="request.hse_dir_cd" default="">				<!--- The passed Street Direction Code --->
<cfparam name="request.str_nm" default="">					<!--- The passed Street Name --->
<cfparam name="request.str_sfx_cd" default="">				<!--- The passed Street Suffix --->
<cfparam name="request.str_sfx_dir_cd" default="">			<!--- The passed Street Suffix Direction --->
<cfparam name="request.zip_cd" default="">					<!--- The passed Zip Code --->
<cfparam name="request.x" default="">						<!--- The passed x ---><!--- Need this in case there are multiple addresses found since street suffix direction might not be passed --->
<cfparam name="request.y" default="">						<!--- The passed y ---><!--- Need this in case there are multiple addresses found since street suffix direction might not be passed --->
<cfparam name="request.lat" default="">
<cfparam name="request.lon" default="">
<cfparam name="request.debug_address" default="">


<cfmodule template="address_module.cfm" 
	hse_id="#request.hse_id#"
    hse_nbr="#request.hse_nbr#"
    hse_frac_nbr="#request.hse_frac_nbr#"
    hse_dir_cd="#request.hse_dir_cd#"
    str_nm="#request.str_nm#"
    str_sfx_cd="#request.str_sfx_cd#"
    str_sfx_dir_cd="#request.str_sfx_dir_cd#"
    zip_cd="#request.zip_cd#"
    x="#request.x#"
    y="#request.y#"
    lat="#request.lat#"
    lon="#request.lon#"
    debug_address="#request.debug_address#" 
>

<cfoutput>

<br>
Valid Address: #request.addr_md_valid_address#<br>
Official Address: #request.addr_md_official_address#<br>
Multiple Address: #request.addr_md_multi_address#<br>

<cfif request.addr_md_multi_address eq "Y">
	<cfloop from="1" to="#ArrayLen(request.addr_md_arrMultiAddress)#" index="a">
    	<a href="address_module_test.cfm?hse_id=#request.addr_md_arrMultiAddress[a].hse_id#">#request.addr_md_arrMultiAddress[a].address#</a><br>
    </cfloop>
</cfif>

Multiple APNs: #request.addr_md_multi_apn#<br>
Mutliple PINs: #request.addr_md_multi_pin#<br>
Mutliple Owners: #request.addr_md_multi_owner#<br>
Mutliple Zoning: #request.addr_md_multi_zoning#<br>
Mutliple Zoning Categories: #request.addr_md_multi_zoning_category#<br>
APN List: #request.addr_md_apn_list#<br>
PIN List: #request.addr_md_pin_list#<br>
Owner List: #request.addr_md_owner_list#<br>

<cfif request.addr_md_multi_owner eq "Y">
	<br>
    <cfloop from="1" to="#ArrayLen(request.addr_md_arrOwner)#" index="i">
        Owner: #request.addr_md_arrOwner[i].Owner# &nbsp;&nbsp; APN: #request.addr_md_arrOwner[i].APN#<br>
    </cfloop>
</cfif>

Zoning: #request.addr_md_zoning_list#<br>
Zoning Category: #request.addr_md_zoning_cateory_list#<br>
Zoning Specific Plan: #request.addr_md_zoning_specific_plan#<br>
Residential and more restrictive: #request.addr_md_residential_and_more_restrictive#<br>
Commercial and less restrictive: #request.addr_md_commercial_and_less_restrictive#<br>


</cfoutput>




</body>
</html>
