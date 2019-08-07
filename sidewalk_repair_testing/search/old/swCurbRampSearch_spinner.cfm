<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=3");
	</script>
	<cfabort>
</cfif>
<!--- <cfif session.user_level is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=3&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<cfset shellName = "">
<cfif (findNoCase('Android', cgi.http_user_agent,1) AND findNoCase('mobile', cgi.http_user_agent,1)) OR 
(findNoCase('Windows', cgi.http_user_agent,1) AND findNoCase('Phone', cgi.http_user_agent,1)) OR 
(findNoCase('iPhone', cgi.http_user_agent,1) OR findNoCase('iPod', cgi.http_user_agent,1)) OR 
(findNoCase('BlackBerry', cgi.http_user_agent,1) OR findNoCase('BB10', cgi.http_user_agent,1))>
	<cfset shellName = "Handheld">
<cfelseif findNoCase('Android', cgi.http_user_agent,1) OR 
findNoCase('iPad', cgi.http_user_agent,1) OR 
findNoCase('Playbook', cgi.http_user_agent,1) OR 
findNoCase('Touch', cgi.http_user_agent,1)>
	<cfset shellName = "Tablet">
<cfelse>
	<cfset shellName = "Desktop">
</cfif>

<html>
<head>
<title>Sidewalk Repair Program - Search Curb Ramp Repairs</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">

<script language="JavaScript" src="../js/progressing_loading_sign.js" type="text/javascript"></script>


</head>

<style type="text/css">
body{background-color: transparent}
</style>

<!--- Get Yes No Values --->
<cfquery name="getYesNo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblYesNo ORDER BY value
</cfquery>

<!--- Get Package Groups --->
<cfquery name="getGroups" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblPackageGroup ORDER BY package_group
</cfquery>

<!--- Get Facility Type --->
<cfquery name="getType" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblCurbRequestType ORDER BY type
</cfquery>

<cfset listCorner = "N,E,S,W,NE,NW,SE,SW">
<cfset arrCorner = listToArray(listCorner)>

<cfset flw = ""><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>
<body alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw#>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<a style="visibility:hidden;" id="lnk" href="../downloads/SidewalkRepairProgram.zip">asdas</a>
	<tr><td height="0"></td></tr>
</table>

<div id="searchbox" style="display:block;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="0"></td></tr>
          <tr><td align="center" class="pagetitle">Search Curb Ramp Repairs</td></tr>
		  <tr><td height="8"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:850px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:26px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
						<tr>
						<th class="drk left middle" style="width:420px;">Search Curb Ramp Repairs:</th>
						
						<th class="drk right" style="color:white;font-size:11px;" id="rcnt"></th>
						<th class="drk" style="width:2px;"></th>
						</tr>
					</table>
			
			
			</td>
		</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:81px;">Curb Ramp No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:61px;">
						<input type="Text" name="scr_no" id="scr_no" value="" style="width:56px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="height:22px;width:61px;">Site No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:61px;">
						<input type="Text" name="scr_sno" id="scr_sno" value="" style="width:56px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						
						<th class="left middle" style="width:95px;">Package Group:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:77px;">
						<select name="scr_pgroup" id="scr_pgroup" class="roundedsmall" style="width:72px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfset cnt = 1>
						<cfloop query="getGroups">
							<cfset sel = ""><!--- <cfif cnt is 1><cfset sel = "selected"><cfset cnt = cnt+1></cfif> --->
							<option value="#package_group#" #sel#>#package_group#</option>
						</cfloop>
						<option value="ALL">ALL</option>
						<option value="NONE">NONE</option>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:85px;">Package No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<input type="Text" name="scr_pno" id="scr_pno" value="" style="width:55px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>						
						<th class="left middle" style="width:41px;">Type:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:153px;">
						<select name="scr_type" id="scr_type" class="roundedsmall" style="width:148px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getType">
							<option value="#id#">#type#</option>
						</cfloop>
						</select>
						</td>
						
						
						
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:81px;">Primary Street:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:257px;">
						<input type="Text" name="scr_primary" id="scr_primary" value="" style="width:252px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:95px;">Secondary Street:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:247px;">
						<input type="Text" name="scr_secondary" id="scr_secondary" value="" style="width:242px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:56px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:65px;">
						<input type="Text" name="scr_zip" id="scr_zip" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						
					
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:81px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:61px;">
						<select name="scr_assessed" id="scr_assessed" class="roundedsmall" style="width:56px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:105px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:78px;">
						<select name="scr_repairs" id="scr_repairs" class="roundedsmall" style="width:73px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:95px;">Design Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="scr_design" id="scr_design" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
                        
                        
                        <!---  -----------------  joe hu 6/14/18 added  ----- (1)-----   --->
                        
                        <td style="width:2px;"></td>
						<th class="left middle" style="width:111px;">Curb Ramp Deleted:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="scr_removed" id="scr_removed" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfif id is 1>
							<option value="#id#">#value#</option>
							</cfif>
						</cfloop>
						</select>
						</td>
                        
                         <!---  ------ End --------  joe hu 6/14/18 added  ----- (1)-----   --->
                        
                        
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Standard Plan Applicable:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="scr_applicable" id="scr_applicable" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
				
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:81px;">Utility Conflict:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:61px;">
						<select name="scr_utility" id="scr_utility" class="roundedsmall" style="width:56px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:105px;">Minor Repairs Only:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:78px;">
						<select name="scr_minor" id="scr_minor" class="roundedsmall" style="width:73px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:117px;">Intersection Corner:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:86px;">
						<select name="scr_corner" id="scr_corner" class="roundedsmall" style="width:81px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="#arrayLen(arrCorner)#">
							<option value="#arrCorner[i]#">#arrCorner[i]#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:58px;">Priority No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:55px;">
						<input type="Text" name="scr_priority" id="scr_priority" value="" style="width:50px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:55px;">
						<select name="scr_cd" id="scr_cd" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="15">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>	
						
						</tr>
					</table>
				</td>
			</tr>
			
			
			
			
			
			
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:125px;">Design Start Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:268px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="scr_dsdfrm" id="scr_dsdfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('dsd');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="scr_dsdto" id="scr_dsdto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('dsd');">
						<cfset chk = ""><cfif isdefined("session.scr_dsdnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="scr_dsdnull" id="scr_dsdnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('dsd');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:154px;">Design Finish Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:268px;">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="scr_dfdfrm" id="scr_dfdfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('dfd');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="scr_dfdto" id="scr_dfdto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('dfd');">
						<cfset chk = ""><cfif isdefined("session.scr_dfdnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="scr_dfdnull" id="scr_dfdnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('dfd');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:125px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:268px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="scr_assfrm" id="scr_assfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="scr_assto" id="scr_assto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
						<cfset chk = ""><cfif isdefined("session.scr_assnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="scr_assnull" id="scr_assnull" style="position:relative;top:2px;left:4px;" value="" class="roundedsmall" onChange="clearFlds('ass');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:154px;">Construction Completed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:268px;">
						<span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="scr_ccdfrm" id="scr_ccdfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ccd');">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="scr_ccdto" id="scr_ccdto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ccd');">
						<cfset chk = ""><cfif isdefined("session.scr_ccdnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="scr_ccdnull" id="scr_ccdnull" style="position:relative;top:2px;left:4px;" value="" class="roundedsmall" onChange="clearFlds('ccd');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						
						</td>
						</tr>
					</table>
				</td>
			</tr>
			

		</table>
	</td>
	</tr>
	</form>
</table>

<table align=center border="0" cellpadding="0" cellspacing="0" style="width:100%;">
	<tr><td height="15" colspan="5"></td></tr>
	<tr>
		<!--- <td><div style="visibility:hidden;"><img src="../images/excel.gif" width="16" height="16" alt="">
		<img src="../images/excel.png" width="17" height="17"></div></td> --->
		<td align="right">
			<a id="search" href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick="sortTable(0);return false;">Search</a>
		</td>
		<td style="width:15px;"></td>
		<td align="left">
			<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
			onclick=" $('#chr(35)#form1')[0].reset();clearChk('all');return false;">Clear</a>
		</td>
		<!--- <td style="text-align:right;"><img id="dlExcel" style="position:relative;top:8px;right:15px;visibility:hidden;" src="../images/excel.png" width="16" height="16" title="Download Search Results to Excel" onclick="downloadExcel();" onmouseover="this.style.cursor='pointer';">
		<a href="../reports/SiteSearch.cfm" target="_blank"><img id="dlPDF" style="position:relative;top:9px;right:12px;visibility:hidden;" src="../images/pdf_icon.gif" width="17" height="17" title="View Search Results PDF"></a></td> --->
	</tr>
</table>

</div>




<!--- joe hu  7/17/2018 ----- add progressing loading sign ------ (1) --->
<div id="processing_icon" align="center"></div>
<div id="result_panel">





<div name="ss_arrow" id="ss_arrow" onClick="toggleSearchBox();"
style="position:absolute;top:280px;left:0px;height:15px;width:50px;border:0px red solid;display:none;">
<img id="ss_arrow_img" style="position:absolute;top:0px;left:15px;visibility:visible;" src="../images/arrow_up.png" width="19" height="12" title="Hide Search Filter Box"  onmouseover="this.style.cursor='pointer';">
</div>

<div name="ss_downloads" id="ss_downloads"
style="position:absolute;top:273px;right:0px;height:20px;width:52px;border:0px red solid;display:block;">
<img id="dlExcel" style="position:relative;top:0px;left:0px;visibility:hidden;" src="../images/excel.png" width="16" height="16" title="Download Search Results to Excel" onClick="downloadExcel();" onMouseOver="this.style.cursor='pointer';"><a href="../reports/CurbSearch.cfm" target="_blank"><img id="dlPDF" style="position:relative;top:1px;left:7px;visibility:hidden;" src="../images/pdf_icon.gif" width="17" height="17" title="View Search Results PDF"></a>
</div>

<div name="ss_header" id="ss_header" 
style="position:relative;top:10px;left:5px;height:25px;width:100%;border:2px #request.color# solid;overflow:hidden;display:none;">
<table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
	<tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
		<tr>
			<th class="drk center middle" style="height:21px;width:30px;">Edit</th>
			<th class="drk center middle" style="width:70px;" onClick="sortTable(1);return false;" onMouseOver="this.style.cursor='pointer';">Curb Ramp</th>
			<th class="drk center middle" style="width:35px;" onClick="sortTable(2);return false;" onMouseOver="this.style.cursor='pointer';">CD</th>
			<th class="drk center middle" style="width:65px;" onClick="sortTable(3);return false;" onMouseOver="this.style.cursor='pointer';">Site</th>
			<th class="drk center middle" style="width:106px;" onClick="sortTable(9);return false;" onMouseOver="this.style.cursor='pointer';">Intersection Corner</th>
			<th class="drk center middle" onClick="sortTable(4);return false;" onMouseOver="this.style.cursor='pointer';">Primary Street</th>
			<th class="drk center middle" style="width:250px;" onClick="sortTable(5);return false;" onMouseOver="this.style.cursor='pointer';">Secondary Street</th>
			<th class="drk center middle" style="width:85px;" onClick="sortTable(11);return false;" onMouseOver="this.style.cursor='pointer';">Design Finished</th>
			<th class="drk center middle" style="width:85px;" onClick="sortTable(6);return false;" onMouseOver="this.style.cursor='pointer';">Con. Completed</th>
			<th class="drk center middle" style="width:78px;" onClick="sortTable(10);return false;" onMouseOver="this.style.cursor='pointer';">Designed By</th>
			<th class="drk center middle" style="width:78px;" onClick="sortTable(7);return false;" onMouseOver="this.style.cursor='pointer';">Priority No</th>
			<th id="fldWO" class="drk center middle" style="width:135px;" onClick="sortTable(8);return false;" onMouseOver="this.style.cursor='pointer';">Type</th>
		</tr>
		</table>
	</td></tr>
</table>

</div>

<div name="ss_results" id="ss_results" 
style="position:relative;top:8px;left:5px;height:100%;width:100%;border:2px #request.color# solid;overflow-y:auto;overflow-x:hidden;display:none;">
<table id="tbl_results" border="0" cellpadding="0" cellspacing="0" ><tr><td></td></tr></table>
</div>


</div> <!--- id="result_panel"   --->    

	
<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>
	
	
	
	

</body>
</cfoutput>

<cfset vis = "hidden">
<cfif isdefined("session.curbQuery")><cfset vis = "visible"></cfif>

<script>

<cfoutput>
var url = "#request.url#";
var vis = "#vis#";
</cfoutput>
var sort = {};

function changeHeight() {
	var ht = top.getIFrameHeight();
	var w = top.getIFrameWidth();
	ht = ht - 58;
	if ( $("#searchbox").is(":visible") ) { 
		ht = top.getIFrameHeight() - 333;
	}
	w = w - 14;
	$('#ss_results').height(ht);
	$('#ss_results').width(w);
	$('#ss_header').width(w);
	$('#fldWO').css('width',"152px");
	if ( $("#ss_results").height() > $("#tbl_results").height()) { $("#ss_results").height($("#tbl_results").height()); $('#fldWO').css('width',"135px");}
}

function sortTable(idx) {

	var dir = "ASC";
	if (idx == sort.id) {
		if(sort.dir == "ASC") { dir = "DESC"; } else { dir = "ASC"; }
	}

	switch (idx) {
	case 1: sort.id = idx; sort.dir = dir; sort.order = "ramp_no " + dir; break;
	case 2: sort.id = idx; sort.dir = dir; sort.order = "council_district " + dir + ",ramp_no"; break;
	case 3: sort.id = idx; sort.dir = dir; sort.order = "location_no " + dir + ",ramp_no"; break;
	case 4: sort.id = idx; sort.dir = dir; sort.order = "primary_street " + dir + ",secondary_street,ramp_no"; break;
	case 5: sort.id = idx; sort.dir = dir; sort.order = "secondary_street " + dir + ",primary_street,ramp_no"; break;
	case 6: sort.id = idx; sort.dir = dir; sort.order = "construction_completed_date " + dir + ",ramp_no"; break;
	case 7: sort.id = idx; sort.dir = dir; sort.order = "priority_no " + dir + ",ramp_no"; break;
	case 8: sort.id = idx; sort.dir = dir; sort.order = "type_description " + dir + ",ramp_no"; break;
	case 9: sort.id = idx; sort.dir = dir; sort.order = "intersection_corner " + dir + ",ramp_no"; break;
	case 10: sort.id = idx; sort.dir = dir; sort.order = "designed_by " + dir + ",ramp_no"; break;
	case 11: sort.id = idx; sort.dir = dir; sort.order = "design_finish_date " + dir + ",ramp_no"; break;
	default: sort.id = 1; sort.dir = "ASC"; sort.order = "";
	}
	submitForm();
}

function setForm() {
	if (typeof top.ssearch.length != "undefined") {
		//console.log(top.psearch);
		$.each(top.ssearch, function(i, item) {
			//console.log(item);
			$("#" + item.name ).val(item.value);
		});
		if (typeof top.ssearch.sort != "undefined") {
			sort = top.ssearch.sort;
		}
		submitForm();
	}
}

function submitForm() {

	var frm = $('#form1').serializeArray();
	
	if(sort.order != "" && (typeof sort.order != "undefined")) {
		frm.push({"name" : "scr_order", "value" : sort.order });
	}
	top.ssearch = frm;
	top.ssearch.sort = sort;
	//console.log(frm);
	//console.log(top.ssearch);
	
	
	<!---  ---- loading sign started ------  --->
	 $("#result_panel").hide();
	 show_loading_img_spinner('processing_icon', 'progressing_loading_sign')
	 
	 
	 
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=searchCurbRamps&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		var query = jQuery.parseJSON(data.QUERY);
		//console.log(query);
		
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		
		<!---  ---- loading sign ended ------  --->
		//wait(3000);  //3 seconds in milliseconds
		remove_loading_img_spinner('progressing_loading_sign');
		$("#result_panel").show();
		
		
		var sno; var rid; var pst; var sst; var sconc; var spry; var stype; var ic; var cd; var db; var dfd;
		$.each(query.COLUMNS, function(i, item) {
			switch (item) {
			case "RAMP_NO": rid = i; break;
			case "LOCATION_NO": sno = i; break;
			case "PRIMARY_STREET": pst = i; break;
			case "SECONDARY_STREET": sst = i; break;
			case "CONSTRUCTION_COMPLETED_DATE": sconc = i; break;
			case "PRIORITY_NO": spry = i; break;
			case "TYPE_DESCRIPTION": stype = i; break;
			case "INTERSECTION_CORNER": ic = i; break;
			case "COUNCIL_DISTRICT": cd = i; break;
			case "DESIGNED_BY": db = i; break;
			case "DESIGN_FINISH_DATE": dfd = i; break;
			}
		});
		
		/* console.log(rid);
		console.log(sno);
		console.log(pst);
		console.log(sst);
		console.log(sconc);
		console.log(spry);
		console.log(stype);
		console.log(ic);
		console.log(cd); */
		
		data = data.DATA;
		
		
		var items = [];
		items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
		items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
		items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
		
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
			
				if (item[rid] == null) {item[rid] = "";}
				if (item[sno] == null) {item[sno] = "";}
				if (item[pst] == null) {item[pst] = "";}
				if (item[sst] == null) {item[sst] = "";}
				if (item[sconc] == null) {item[sconc] = "";}
				if (item[spry] == null) {item[spry] = "";}
				if (item[stype] == null) {item[stype] = "";}
				if (item[sconc] == null) {item[sconc] = "";}
				if (item[stype] == null) {item[stype] = "";}
				if (item[ic] == null) {item[ic] = "";}
				if (item[cd] == null) {item[cd] = "";}
				if (item[db] == null) {item[db] = "";}
				if (item[dfd] == null) {item[dfd] = "";}
				
				/* if (item[scons] != "") {
					var d = new Date(item[scons]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[scons] = mm + '/' + dd + '/' + d.getFullYear();	
				} */
				
				if (item[sconc] != "") {
					var d = new Date(item[sconc]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[sconc] = mm + '/' + dd + '/' + d.getFullYear();
				}
				
				if (item[dfd] != "") {
					var d = new Date(item[dfd]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[dfd] = mm + '/' + dd + '/' + d.getFullYear();
				}
				
				
				//var pkg = item[sg] + item[sp]; if (pkg != "") { pkg = item[sg] + " - " + item[sp]; }
	
				items.push("<tr>");
				items.push("<td style='width:29px;height:20px;' class='small center frm'><a href='' onclick='goToSite(" + item[rid] + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
				items.push("<td style='width:69px;' class='small center frm'>" + item[rid]  + "</td>");
				items.push("<td style='width:34px;' class='small center frm'>" + item[cd] + "</td>");
				items.push("<td style='width:64px;' class='small center frm'>" + item[sno] + "</td>");
				items.push("<td style='width:105px;' class='small center frm'>" + item[ic] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;' class='small frm'>" + item[pst] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;width:246px;' class='small frm'>" + item[sst] + "</td>");
				//items.push("<td style='width:79px;' class='small center frm'>" + item[scons] + "</td>");
				items.push("<td style='width:84px;' class='small center frm'>" + item[dfd] + "</td>");
				items.push("<td style='width:84px;' class='small center frm'>" + item[sconc] + "</td>");
				items.push("<td style='width:77px;' class='small center frm'>" + item[db] + "</td>");
				items.push("<td style='width:77px;' class='small center frm'>" + item[spry] + "</td>");
				items.push("<td style='width:134px;' class='small center frm'>" + item[stype] + "</td>");
				items.push("</tr>");
			
			});
		}
		else {
			items.push("<td style='height:20px;' class='small center frm'>No Records Found</td>");
		}
		
		items.push("</table>");
		items.push("</td></tr>");
		items.push("</table>");
		
		$("#ss_results").html(items.join(""));
		
		$("#ss_header").show();
		$("#ss_results").show();
		$("#dlExcel").css("visibility","visible");
		$("#dlPDF").css("visibility","visible");
		$("#ss_arrow").show();
		changeHeight();
		
		$("#rcnt").html("Search Count: <strong>" + query.DATA.length + "</strong>");
		
		
	  }
	});
	
}

function showMsg(txt,cnt) {
	$('#msg_text').html(txt);
	$('#msg').height(35+cnt*14+30);
	$('#msg').css({top:'50%',left:'50%',margin:'-'+($('#msg').height() / 2)+'px 0 0 -'+($('#msg').width() / 2)+'px'});
	$('#msg').show();
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function goToSite(crid) {
	
	//  ---- loading sign started ------  --->
	 $("#result_panel").hide();
	 show_loading_img_spinner('processing_icon', 'progressing_loading_sign')
	
	location.replace(url + "forms/swCurbRampEdit.cfm?crid=" + crid + "&search=true");
}

$(window).resize(function() {
	changeHeight();
});

$(function() {
	$(document).keyup(function (e) { 
		if (e.keyCode == 13) { submitForm(); }
	});
});



function downloadExcel() {

	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=downloadCurbSearch&callback=",
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	//console.log(data);
		
		$('#lnk').attr('href',data.HREF);
		$link = $('#lnk:first');
		$link[0].click();
		
	  }
	});

}

function toggleSearchBox() {
	if ( $("#searchbox").is(":visible") ) {
		$("#ss_arrow").css("top",'2px');
		$("#ss_downloads").css("top",'2px');
		$("#ss_arrow_img").css("top",'3px');
		$("#ss_arrow_img").attr("src",'../images/arrow_down.png');
		$("#ss_arrow_img").attr("title",'Show Search Filter Box');
	}
	else {
		$("#ss_arrow").css("top",'280px');
		$("#ss_downloads").css("top",'273px');
		$("#ss_arrow_img").css("top",'0px');
		$("#ss_arrow_img").attr("src",'../images/arrow_up.png');
		$("#ss_arrow_img").attr("title",'Hide Search Filter Box');
	}
	$( "#searchbox" ).toggle();
	changeHeight();
}


function clearFlds(ctrl) {
	if ($("#scr_" + ctrl + "null").is(":checked")) {
		$("#scr_" + ctrl + "frm").val('');
		$("#scr_" + ctrl + "to").val('');
	}
}

function clearChk(ctrl) {

	if (ctrl == 'all') {
		var list = 'dsd,dfd,ass,ccd';
		list = list.split(",");
		$.each(list, function(i, item) {
			$("#scr_" + item + "null").attr('checked', false);
		});
	}
	else {
		$("#scr_" + ctrl + "null").attr('checked', false);
	}
}



if($("#ss_header").is(":visible") == false || vis == 'hidden') {$("#dlExcel").css("visibility","hidden"); $("#dlPDF").css("visibility","hidden");}

$( "#scr_dsdfrm" ).datepicker();
$( "#scr_dsdto" ).datepicker();
$( "#scr_dfdfrm" ).datepicker();
$( "#scr_dfdto" ).datepicker();

$( "#scr_assfrm" ).datepicker();
$( "#scr_assto" ).datepicker();
$( "#scr_ccdfrm" ).datepicker();
$( "#scr_ccdto" ).datepicker();

changeHeight();
setForm();
</script>

</html>


            

				

	


