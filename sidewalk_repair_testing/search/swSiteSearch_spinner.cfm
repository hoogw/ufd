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
<title>Sidewalk Repair Program - Search Sidewalk Repair Sites</title>
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
SELECT * FROM tblType ORDER BY type
</cfquery>

<!--- Get Category Type --->
<cfquery name="getCategory" dbtype="query">
SELECT DISTINCT category FROM getType ORDER BY category
</cfquery>


<cfset flw = "style='overflow:auto;'"><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>
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
          <tr><td align="center" class="pagetitle">Search Sidewalk Repair Sites</td></tr>
		  <tr><td height="12"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:870px;">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0">
		<tr>
			<th class="drk left middle" colspan="4" style="height:26px;padding:0px 0px 0px 0px;">
			
				
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
						<tr>
						<th class="drk left middle" style="width:420px;">Search Sidewalk Repair Sites:</th>
						
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
						<th class="left middle" style="height:22px;width:81px;">Site No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:61px;">
						<input type="Text" name="ss_no" id="ss_no" value="" style="width:56px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						<!--- <th class="left middle" style="width:60px;">Site Suffix:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<select name="ss_sfx" id="ss_sfx" class="rounded" style="width:45px;">
						<option value=""></option>
						<option value="a">a</option>
						<option value="b">b</option>
						<option value="c">c</option>
						<option value="d">d</option>
						<option value="e">e</option>
						<option value="f">f</option>
						<option value="f">g</option>
						<option value="f">h</option>
						<option value="f">i</option>
						<option value="f">j</option>
						<option value="f">k</option>
						</select>
						</td>
						<td style="width:2px;"></td> --->
						<th class="left middle" style="width:95px;">Package Group:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:77px;">
						<select name="ss_pgroup" id="ss_pgroup" class="roundedsmall" style="width:72px;height:20px;padding:0px 0px 0px 4px;">
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
						<th class="left middle" style="width:70px;">Package No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:55px;">
						<input type="Text" name="ss_pno" id="ss_pno" value="" style="width:50px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>						
						<th class="left middle" style="width:35px;">Type:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:188px;">
						<select name="ss_category" id="ss_category" class="roundedsmall" style="width:183px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getCategory">
							<option value="#category#">#category#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Council District:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:55px;">
						<select name="ss_cd" id="ss_cd" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
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
						<th class="left middle" style="height:22px;width:81px;">Facility Name:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:163px;">
						<input type="Text" name="ss_name" id="ss_name" value="" style="width:158px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:50px;">Address:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:158px;">
						<input type="Text" name="ss_address" id="ss_address" value="" style="width:153px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						
						<td style="width:2px;"></td>						
						<th class="left middle" style="width:55px;">Subtype:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:168px;">
						<select name="ss_type" id="ss_type" class="roundedsmall" style="width:163px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getType">
							<option value="#id#">#type#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:80px;">Zip Code:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:55px;">
						<input type="Text" name="ss_zip" id="ss_zip" value="" style="width:50px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:58px;">Priority No:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:35px;">
						<input type="Text" name="ss_pn" id="ss_pn" value="" style="width:30px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td> --->
					</table>
				</td>
			</tr>
			
			<tr>	
				<td colspan="4" style="padding:0px 0px 0px 0px;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th class="left middle" style="height:22px;width:81px;">Field Assessed:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:60px;">
						<select name="ss_assessed" id="ss_assessed" class="roundedsmall" style="width:55px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:85px;">Field Assessor:<br><div style="position:relative;left:20px;">(Intials)</div></th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<input type="Text" name="ss_assessor" id="ss_assessor" value="" style="width:55px;" class="rounded"></td> --->
						<td style="width:2px;"></td>
						<th class="left middle" style="width:95px;">Repairs Required:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:78px;">
						<select name="ss_repairs" id="ss_repairs" class="roundedsmall" style="width:73px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						<!--- <td style="width:2px;"></td>
						<th class="left middle" style="width:55px;">QC'd By:<br><div style="position:relative;left:2px;">(Intials)</div></th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:50px;">
						<input type="Text" name="ss_qc" id="ss_qc" value="" style="width:45px;" class="rounded"></td> --->
						<td style="width:2px;"></td>
						<th class="left middle" style="width:85px;">Severity Index:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:60px;">
						<select name="ss_severity" id="ss_severity" class="roundedsmall" style="width:55px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop index="i" from="1" to="3">
							<option value="#i#">#i#</option>
						</cfloop>
						</select>
						</td>			
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:120px;">Site Deleted:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="ss_removed" id="ss_removed" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<cfif id is 1>
							<option value="#id#">#value#</option>
							</cfif>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:108px;">Curb Ramp Only:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="ss_curbramp" id="ss_curbramp" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
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
						
						
						<th class="left middle" style="height:22px;width:63px;">Work Order:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:78px;">
						<input type="Text" name="ss_wo" id="ss_wo" value="" style="width:73px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:52px;">Keyword:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:121px;">
						<input type="Text" name="ss_keyword" id="ss_keyword" value="" style="width:116px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>

						<td style="width:2px;"></td>
						<th class="left middle" style="width:99px;">Has Before Image:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="ss_hasB" id="ss_hasB" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:88px;">Has After Image:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="ss_hasA" id="ss_hasA" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#id#">#value#</option>
						</cfloop>
						</select>
						</td>
						
						<td style="width:2px;"></td>
						<th class="left middle" style="width:131px;">Certificate of Compliance:</th>
						<td style="width:2px;"></td>
						<td class="frm"  style="width:55px;">
						<select name="ss_hascert" id="ss_hascert" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
						<option value=""></option>
						<cfloop query="getYesNo">
							<option value="#value#">#value#</option>
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
						<th class="left middle" style="height:22px;width:142px;">Assessed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:267px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
						<!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_assfrm" id="ss_assfrm" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_assto" id="ss_assto" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
						
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_assfrm" id="ss_assfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_assto" id="ss_assto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
						<cfset chk = ""><cfif isdefined("session.ss_assnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="ss_assnull" id="ss_assnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('ass');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:160px;">QC Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:267px;">
						<!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_qcfrm" id="ss_qcfrm" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_qcto" id="ss_qcto" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
						
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_qcfrm" id="ss_qcfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('qc');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_qcto" id="ss_qcto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('qc');">
						<cfset chk = ""><cfif isdefined("session.ss_qcnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="ss_qcnull" id="ss_qcnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('qc');" #chk#>
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
						<th class="left middle" style="height:22px;width:142px;">Construction Started Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:267px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
						<span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
						<!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_consfrm" id="ss_consfrm" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_consto" id="ss_consto" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
						
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_consfrm" id="ss_consfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('cons');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_consto" id="ss_consto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('cons');">
						<cfset chk = ""><cfif isdefined("session.ss_consnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="ss_consnull" id="ss_consnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('cons');" #chk#>
						<span class="page" style="position:relative;top:-1px;">Is Null</span>
						
						</td>
						<td style="width:2px;"></td>
						<th class="left middle" style="width:160px;">Construction Completed Date:</th>
						<td style="width:2px;"></td>
						<td class="frm" style="width:267px;">
						<!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_concfrm" id="ss_concfrm" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
						<span class="page">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_concto" id="ss_concto" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
						
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
						<input type="Text" name="ss_concfrm" id="ss_concfrm" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('conc');">
						<span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
						<input type="Text" name="ss_concto" id="ss_concto" value="" style="width:67px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('conc');">
						<cfset chk = ""><cfif isdefined("session.ss_concnull")><cfset chk = "checked"></cfif>
						<input type="checkbox" name="ss_concnull" id="ss_concnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('conc');" #chk#>
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
	<tr><td height="10" colspan="5"></td></tr>
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
<img id="dlExcel" style="position:relative;top:0px;left:0px;visibility:hidden;" src="../images/excel.png" width="16" height="16" title="Download Search Results to Excel" onClick="downloadExcel();" onMouseOver="this.style.cursor='pointer';"><a href="../reports/SiteSearch.cfm" target="_blank"><img id="dlPDF" style="position:relative;top:1px;left:7px;visibility:hidden;" src="../images/pdf_icon.gif" width="17" height="17" title="View Search Results PDF"></a>
</div>

<div name="ss_header" id="ss_header" 
style="position:relative;top:10px;left:5px;height:25px;width:100%;border:2px #request.color# solid;overflow:hidden;display:none;">
<table border="0" cellpadding="0" cellspacing="0" style="height:25px;width:100%;border:0px red solid;">
	<tr><td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align="center" bgcolor="white" cellspacing="2" cellpadding="2" border="0" style="width:100%;">
		<tr>
			<th class="drk center middle" style="height:21px;width:30px;">Edit</th>
			<th class="drk center middle" style="width:35px;" onClick="sortTable(1);return false;" onMouseOver="this.style.cursor='pointer';">Site</th>
			<th class="drk center middle" style="width:25px;" onClick="sortTable(10);return false;" onMouseOver="this.style.cursor='pointer';">CD</th>
			<th class="drk center middle" style="width:50px;" onClick="sortTable(2);return false;" onMouseOver="this.style.cursor='pointer';">Package</th>
			<th class="drk center middle" style="width:350px;" onClick="sortTable(3);return false;" onMouseOver="this.style.cursor='pointer';">Facility Name</th>
			<th class="drk center middle" onClick="sortTable(4);return false;" onMouseOver="this.style.cursor='pointer';">Address</th>
            
            <!--- joe hu --- 3/14/2018 --- add Days in queue --->
            <th class="drk center middle" style="width:80px;" onClick="sortTable(14);return false;" onMouseOver="this.style.cursor='pointer';">Days In Queue</th>
            
			<th class="drk center middle" style="width:70px;" onClick="sortTable(5);return false;" onMouseOver="this.style.cursor='pointer';">Con. Started</th>
			<th class="drk center middle" style="width:85px;" onClick="sortTable(6);return false;" onMouseOver="this.style.cursor='pointer';">Con. Completed</th>
			<th class="drk center middle" style="width:40px;" onClick="sortTable(7);return false;" onMouseOver="this.style.cursor='pointer';">Priority</th>
			<th class="drk center middle" style="width:75px;" onClick="sortTable(13);return false;" onMouseOver="this.style.cursor='pointer';">Eng. Estimate</th>
			<th class="drk center middle" style="width:75px;" onClick="sortTable(11);return false;" onMouseOver="this.style.cursor='pointer';">Total Cost</th>
			<th class="drk center middle" style="width:75px;" onClick="sortTable(12);return false;" onMouseOver="this.style.cursor='pointer';">Total Concrete</th>
			<th class="drk center middle" style="width:80px;" onClick="sortTable(8);return false;" onMouseOver="this.style.cursor='pointer';">Subtype</th>
			<th id="fldWO" class="drk center middle" style="width:65px;" onClick="sortTable(9);return false;" onMouseOver="this.style.cursor='pointer';">Work Order</th>
			<!--- <th class="drk center middle" style="width:25px;" onclick="sortTable(3);return false;" onmouseover="this.style.cursor='pointer';">CD</th> --->
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
<cfif isdefined("session.siteQuery")><cfset vis = "visible"></cfif>

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
	$('#fldWO').css('width',"82px");
	if ( $("#ss_results").height() > $("#tbl_results").height()) { $("#ss_results").height($("#tbl_results").height()); $('#fldWO').css('width',"65px");}
}

function sortTable(idx) {

	var dir = "ASC";
	if (idx == sort.id) {
		if(sort.dir == "ASC") { dir = "DESC"; } else { dir = "ASC"; }
	}

	switch (idx) {
	case 1: sort.id = idx; sort.dir = dir; sort.order = "location_no " + dir + ",location_suffix "  + dir; break;
	case 2: sort.id = idx; sort.dir = dir; sort.order = "package_group " + dir + ",package_no "  + dir; break;
	case 3: sort.id = idx; sort.dir = dir; sort.order = "rtrim(ltrim(name)) " + dir + ",location_no,location_suffix"; break;
	case 4: sort.id = idx; sort.dir = dir; sort.order = "address " + dir + ",name"; break;
	case 5: sort.id = idx; sort.dir = dir; sort.order = "construction_start_date " + dir + ",location_no,location_suffix"; break;
	case 6: sort.id = idx; sort.dir = dir; sort.order = "construction_completed_date " + dir + ",location_no,location_suffix"; break;
	case 7: sort.id = idx; sort.dir = dir; sort.order = "priority_score " + dir + ",location_no,location_suffix"; break;
	case 8: sort.id = idx; sort.dir = dir; sort.order = "subtype_desc " + dir + ",location_no,location_suffix"; break;
	case 9: sort.id = idx; sort.dir = dir; sort.order = "work_order " + dir + ",location_no,location_suffix"; break;
	case 10: sort.id = idx; sort.dir = dir; sort.order = "council_district " + dir + ",location_no,location_suffix"; break;
	case 11: sort.id = idx; sort.dir = dir; sort.order = "total_cost " + dir + ",location_no,location_suffix"; break;
	case 12: sort.id = idx; sort.dir = dir; sort.order = "total_concrete " + dir + ",location_no,location_suffix"; break;
	case 13: sort.id = idx; sort.dir = dir; sort.order = "engineers_estimate " + dir + ",location_no,location_suffix"; break;
	case 14: sort.id = idx; sort.dir = dir; sort.order = "Days_In_Queues " + dir + ",location_no,location_suffix"; break;
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
		frm.push({"name" : "ss_order", "value" : sort.order });
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
	  url: url + "cfc/sw.cfc?method=searchSites&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
		//console.log("data---");
	  	//console.log(data);
		var query = jQuery.parseJSON(data.QUERY);
		//console.log("query=====");
		//console.log(query);
		if(data.RESULT != "Success") {
			showMsg(data.RESULT,1);
			return false;	
		}
		
		
		<!---  ---- loading sign ended ------  --->
		remove_loading_img_spinner('progressing_loading_sign');
		$("#result_panel").show();
		
		
		var sno; var ssfx; var sp; var sg; var sname; var saddr; var stype; var swo; var sid; var spid; var spry; var cd; var tc; var tcon; var eest;
		$.each(query.COLUMNS, function(i, item) {
			switch (item) {
			case "ID": sid = i; break;
			case "LOCATION_NO": sno = i; break;
			case "LOCATION_SUFFIX": ssfx = i; break;
			case "PACKAGE_NO": sp = i; break;
			case "PACKAGE_GROUP": sg = i; break;
			case "NAME": sname = i; break;
			case "ADDRESS": saddr = i; break;
			
			<!--- joe hu --- 3/14/2018 --- add Days in queue --->
			case "DAYS_IN_QUEUES": sdays = i; break;
			
			
			case "CONSTRUCTION_START_DATE": scons = i; break;
			case "CONSTRUCTION_COMPLETED_DATE": sconc = i; break;
			case "PRIORITY_SCORE": spry = i; break;
			case "SUBTYPE_DESC": stype = i; break;
			case "WORK_ORDER": swo = i; break;
			case "PACKAGE_ID": spid = i; break;
			case "COUNCIL_DISTRICT": cd = i; break;
			case "TOTAL_COST": tc = i; break;
			case "TOTAL_CONCRETE": tcon = i; break;
			case "ENGINEERS_ESTIMATE": eest = i; break;
			}
		});
		
		/* console.log(sid);
		console.log(sno);
		console.log(ssfx);
		console.log(sp);
		console.log(sg);
		console.log(sname);
		console.log(saddr);
		console.log(stype);
		console.log(swo); */
		
		data = data.DATA;
		
		
		var items = [];
		items.push("<table id='tbl_results' border='0' cellpadding='0' cellspacing='0' style='height:25px;width:100%;border:0px red solid;'>");
		items.push("<tr><td cellspacing='0' cellpadding='0' border='0' bgcolor='white' bordercolor='white'>");
		items.push("<table align='center' bgcolor='white' cellspacing='2' cellpadding='2' border='0' style='width:100%;'>");
		
		if (query.DATA.length > 0) {
			$.each(query.DATA, function(i, item) {
			
				if (item[sno] == null) {item[sno] = "";}
				if (item[ssfx] == null) {item[ssfx] = "";}
				if (item[sp] == null) {item[sp] = "";}
				if (item[sg] == null) {item[sg] = "";}
				if (item[sname] == null) {item[sname] = "";}
				if (item[saddr] == null) {item[saddr] = "";}
				
				<!--- joe hu --- 3/14/2018 --- add Days in queue --->
				if (item[sdays] == null) {item[sdays] = "";}
				
				
				if (item[scons] == null) {item[scons] = "";}
				if (item[sconc] == null) {item[sconc] = "";}
				if (item[stype] == null) {item[stype] = "";}
				if (item[spry] == null) {item[spry] = "";}
				if (item[swo] == null) {item[swo] = "";}
				if (item[spid] == null) {item[spid] = 0;}
				if (item[cd] == null) {item[cd] = "";}
				if (item[tc] == null) {item[tc] = 0;}
				if (item[tcon] == null) {item[tcon] = 0;}
				if (item[eest] == null) {item[eest] = 0;}
				
				if (item[scons] != "") {
					var d = new Date(item[scons]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[scons] = mm + '/' + dd + '/' + d.getFullYear();	
				}
				
				if (item[sconc] != "") {
					var d = new Date(item[sconc]);
					var mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
					var dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
					item[sconc] = mm + '/' + dd + '/' + d.getFullYear();
				}
				
				
				var pkg = item[sg] + item[sp]; if (pkg != "") { pkg = item[sg] + " - " + item[sp]; }
	
				items.push("<tr>");
				items.push("<td style='width:29px;height:20px;' class='small center frm'><a href='' onclick='goToSite(" + item[sid] + "," + item[spid] + ");return false;'><img src='../Images/rep.gif' width='13' height='16' alt='Edit Package' title='Edit Package' style='position:relative;top:-1px;'></a></td>");
				items.push("<td style='width:34px;' class='small center frm'>" + item[sno] + item[ssfx]  + "</td>");
				items.push("<td style='width:24px;' class='small center frm'>" + item[cd] + "</td>");
				items.push("<td style='width:49px;' class='small center frm'>" + pkg + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;width:346px;' class='small frm'>" + item[sname] + "</td>");
				items.push("<td style='padding:2px 0px 0px 5px;' class='small frm'>" + item[saddr] + "</td>");
				
				<!--- joe hu --- 3/14/2018 --- add Days in queue --->
				items.push("<td style='width:79px;' class='small center frm'>" + item[sdays] + "</td>");
				
				
				items.push("<td style='width:69px;' class='small center frm'>" + item[scons] + "</td>");
				items.push("<td style='width:84px;' class='small center frm'>" + item[sconc] + "</td>");
				items.push("<td style='width:39px;' class='small center frm'>" + item[spry] + "</td>");
				items.push("<td style='width:74px;' class='small center frm'>$" + item[eest].formatMoney(2) + "</td>");
				items.push("<td style='width:74px;' class='small center frm'>$" + item[tc].formatMoney(2) + "</td>");
				items.push("<td style='width:74px;' class='small center frm'>" + item[tcon].toFixed(2).replace('.00','') + "</td>");
				items.push("<td style='width:79px;' class='small center frm'>" + item[stype] + "</td>");
				items.push("<td style='width:64px;' class='small center frm'>" + item[swo] + "</td>");
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

function goToSite(sid,spid) {
	
	//  ---- loading sign started ------  --->
	 $("#result_panel").hide();
	 show_loading_img_spinner('processing_icon', 'progressing_loading_sign')
	 
	location.replace(url + "forms/swSiteEdit.cfm?sid=" + sid + "&pid=" + spid + "&search=true");
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
	  url: url + "cfc/sw.cfc?method=downloadSiteSearch&callback=",
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

function clearChk(ctrl) {
	if (ctrl == 'all') {
		var list = 'ass,qc,cons,conc';
		list = list.split(",");
		$.each(list, function(i, item) {
			$("#ss_" + item + "null").attr('checked', false);
		});
	}
	else {
		$("#ss_" + ctrl + "null").attr('checked', false);
	}
}

function clearFlds(ctrl) {
	if ($("#ss_" + ctrl + "null").is(":checked")) {
		$("#ss_" + ctrl + "frm").val('');
		$("#ss_" + ctrl + "to").val('');
	}
}

Number.prototype.formatMoney = function(c, d, t){
var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };


if($("#ss_header").is(":visible") == false || vis == 'hidden') {$("#dlExcel").css("visibility","hidden"); $("#dlPDF").css("visibility","hidden");}

$( "#ss_assfrm" ).datepicker();
$( "#ss_assto" ).datepicker();
$( "#ss_qcfrm" ).datepicker();
$( "#ss_qcto" ).datepicker();

$( "#ss_consfrm" ).datepicker();
$( "#ss_consto" ).datepicker();
$( "#ss_concfrm" ).datepicker();
$( "#ss_concto" ).datepicker();

changeHeight();
setForm();
</script>

</html>


            

				

	


