<!doctype html>

<html>
<head>
	<title>Address Module Test Links</title>

<style>

body {
	font-family:Verdana, Geneva, sans-serif;
	font-size:12px;	
}
</style>

<script>

function submitAddress()
{
	document.form1.submit();
}

function goToAddress(a)
{
	temp_url = a;
	if(document.form1.debug_address.value == 1)
	{
		temp_url += "&debug_address=1";
	}
	
	window.open(temp_url);
}


</script>

</head>




<body>

<cfoutput>

<form name="form1" id="form1" method="post" action="address_module_test.cfm" target="_blank">
<div>
	<span style="font-weight:bold;">Enter Address</span>
</div>

<div>
	<table>
    	<tr>
        	<td>House Number:</td>
            <td><input type="text" id="hse_nbr" name="hse_nbr" style="width:80px;"></input></td>
        </tr>
        <tr>
        	<td>House Fraction:</td>
            <td><input type="text" id="hse_frac_nbr" name="hse_frac_nbr" style="width:40px;"></input></td>
        </tr>
        <tr>
        	<td>Street Direction:</td>
            <td><input type="text" id="hse_dir_cd" name="hse_dir_cd" style="width:20px;"></input></td>
        </tr>
        <tr>
        	<td>Street Name:</td>
            <td><input type="text" id="str_nm" name="str_nm" style="width:400px;"></input></td>
        </tr>
        <tr>
        	<td>Street Suffix:</td>
            <td><input type="text" id="str_sfx_cd" name="str_sfx_cd" style="width:100px;"></input></td>
        </tr>
        <tr>
        	<td>Street Suffix Direction:</td>
            <td><input type="text" id="str_sfx_dir_cd" name="str_sfx_dir_cd" style="width:100px;"></input></td>
        </tr>
        <tr>
        	<td>Zip Code:</td>
            <td><input type="text" id="zip_cd" name="zip_cd" style="width:100px;"></input></td>
        </tr>
        <tr>
        	<td>X:</td>
            <td><input type="text" id="x" name="x" style="width:140px;"></input></td>
        </tr>
        <tr>
        	<td>Y:</td>
            <td><input type="text" id="y" name="y" style="width:140px;"></input></td>
        </tr>
        <tr>
        	<td>House Number ID:</td>
            <td><input type="text" id="hse_id" name="hse_id" style="width:80px;"></input></td>
        </tr>
        <tr>
        	<td>Debug</td>
            <td>
            	<select id="debug_address" name="debug_address">
                	<option value=""></option>
                    <option value="1">Yes</option>
                </select>
            </td>
        </tr>
        <tr>
        	<td></td>
        	<td style="text-align:left;"><input type="button" value="Submit" onClick="submitAddress();"/></td>
        </tr>
    </table>
</div>
<br><br>

<div>
	<span style="font-weight:bold;">OR Click Links Below</span>
</div>
<br><br>


<div>
	<span style="font-weight:bold;">Address Searches</span>
</div>
<br>

<!--- NO Official Address found --->
<cfset hse_nbr = 606>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "SPRING">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90014">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- No Official Address Found <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>
</div>


<!--- Address with no other addresses on Parcel --->
<cfset hse_nbr = 548>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "SPRING">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90013">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with no other addresses on parcel <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 129A211-273" target="_blank">NavigateLA</a>
</div>

<!--- Address with Fraction on same parcel --->
<cfset hse_nbr = 848>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "HAMILTON">
<cfset str_sfx_cd = "AVE">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90731">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Fractions on same parcel <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 009B197-644" target="_blank">NavigateLA</a>
</div>

<!--- Address with Multiple Unit Ranges on same parcel --->
<cfset hse_nbr = 10639>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "WOODBRIDGE">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "91602">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Multiple Unit Ranges on same parcel <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 165B177-1123" target="_blank">NavigateLA</a>
</div>


<!--- Address with Multiple Unit Ranges on different parcel --->
<cfset hse_nbr = 18333>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "HATTERAS">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "91356">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Multiple Unit Ranges on different parcel <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 177B125-781" target="_blank">NavigateLA</a>
</div>

<br>

<div>
	<span style="font-weight:bold;">Ownership / Zoning examples</span>
</div>

<br>

<!--- Address with PIN that has Same APN on other Parcels --->
<cfset hse_nbr = 600>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "SPRING">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90014">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with PIN that has Same APN on other Parcels <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 129A211-252" target="_blank">NavigateLA</a>
</div>

<!--- Address with PIN that has multiple APNs on this Parcel --->
<cfset hse_nbr = 1312>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "SALTAIR">
<cfset str_sfx_cd = "AVE">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90025">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with PIN that has multiple APNs on this Parcel <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 126B145-225" target="_blank">NavigateLA</a>
</div>


<!--- Address with PIN that has multiple APNs on this Parcel and Other Parcels  --->
<cfset hse_nbr = 678>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "IROLO">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90005">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with PIN that has multiple APNs on this Parcel and Other Parcels <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 132B193-177" target="_blank">NavigateLA</a>
</div>


<!--- Address with Commercial and Residential Zoning --->
<cfset hse_nbr = 770>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "SUMMERLAND">
<cfset str_sfx_cd = "AVE">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90731">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Commercial and Residential Zoning <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 018B197-174" target="_blank">NavigateLA</a>
</div>

<!--- Address with Specific Plan Zoning (Central City West - Public Facilities)--->
<cfset hse_nbr = 1321>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "CORTEZ">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90026">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Specific Plan Zoning (Central City West - Public Facilities) <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 136-5A209-369" target="_blank">NavigateLA</a>
</div>

<!--- Address with Specific Plan Zoning (USC-1A Residential) --->
<cfset hse_nbr = 950>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "W">
<cfset str_nm = "JEFFERSON">
<cfset str_sfx_cd = "BLVD">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90089">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Specific Plan Zoning (USC-1A Residential) <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 120A201-20" target="_blank">NavigateLA</a>
</div>

<!--- Address with Specific Plan Zoning (USC-3 Commercial) --->
<cfset hse_nbr = 3205>
<cfset hse_frac_nbr = "">
<cfset hse_dir_cd = "S">
<cfset str_nm = "HOOVER">
<cfset str_sfx_cd = "ST">
<cfset str_sfx_dir_cd = "">
<cfset zip_cd = "90007">
<cfset x = "">
<cfset y = "">
<cfset params = "hse_nbr=#hse_nbr#&hse_frac_nbr=#hse_frac_nbr#&hse_dir_cd=#hse_dir_cd#&str_nm=#str_nm#&str_sfx_cd=#str_sfx_cd#&zip_cd=#zip_cd#&x=#x#&y=#y#">
<cfset address = hse_nbr & " " & hse_frac_nbr & " " & hse_dir_cd & " " & str_nm & " " & str_sfx_cd & " " & str_sfx_dir_cd & " " & zip_cd>
<cfset address = ReReplace(address,"\s\s+", " ", "all")>

<div style="margin-bottom:10px;">
- Address with Specific Plan Zoning (USC-3 Commercial) <br>
<a href="javascript:void(0);" onClick="goToAddress('address_module_test.cfm?#params#');">#address#</a>&nbsp;&nbsp;<a href="http://boemaps.eng.ci.la.ca.us/navigatela/?search=pin 120A201-4" target="_blank">NavigateLA</a>
</div>

</cfoutput>

</body>
</html>
