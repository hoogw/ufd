<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	var rand = Math.random();
	url = "toc.cfm?r=" + rand;
	window.parent.document.getElementById('FORM2').src = url;
	self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
	</script>
	<cfabort>
</cfif>
<cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<html>
<head>
<title>Sidewalk Repair Program - Update Engineering Estimate / Contractor Pricing Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">
</head>

<style type="text/css">
body{background-color: transparent}
</style>

<cfparam name="url.sid" default="4">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">

<!--- Get Package --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>

<!--- Get Estimates --->
<cfquery name="getEst" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblEngineeringEstimate WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get QC Values --->
<cfquery name="getQCs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblQCQuantity WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get ChangeOrder Values --->
<cfquery name="getCOs" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblChangeOrders WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Contractor Price --->
<cfquery name="getContract" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblContractorPricing WHERE location_no = #getSite.location_no#
</cfquery>


<!--- <cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
</cfquery> --->

<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, sort_order, sort_group
FROM vwSortOrder
ORDER BY full_sort, sort_group, sort_order
</cfquery>

<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
	
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />
	
	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

	
<body>	
<!--- Get Curbs --->
<!--- <cfquery name="getTrees" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeRemovalInfo WHERE location_no = #getSite.location_no#
</cfquery>

<!--- Get Curb Fields --->
<cfquery name="getFlds3" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH as cml
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
</cfquery> --->

<!--- Create Diameter Array --->
<cfset arrDia = arrayNew(1)>
<cfloop index="i" from="6" to="48" step="2"><cfset go = arrayAppend(arrDia,i)></cfloop>

<!--- Get Species List --->
<cfquery name="getSpecies" datasource="treeinventory" dbtype="ODBC">
SELECT DISTINCT common FROM [TreeInventory].[dbo].trees WHERE common is not null ORDER BY common
</cfquery>
<!--- <cfset lstSpecies = ValueList(getSpecies.common,""",""")>
<cfdump var="#lstSpecies#"> --->

<cfquery name="getTreeInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSiteInfo WHERE location_no = #getSite.location_no#
</cfquery>

<cfquery name="getTreeSIRInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSIRs WHERE location_no = #getSite.location_no# AND deleted <> 1 ORDER BY group_no
</cfquery>

<cfquery name="getTreeListInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeList WHERE location_no = #getSite.location_no# AND deleted <> 1
</cfquery>

<div id="box_tree" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:block;overflow:auto;">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td height="15"></td></tr>
          <tr><td align="center" class="pagetitle" style="height:35px;"><!--- Update ADA Curb Ramps Form ---></td></tr>
		  <tr><td height="15"></td></tr>
		</table>
  	</td>
  </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:850px;">
	<form name="form7" id="form7" method="post" action="" enctype="multipart/form-data">
	<tr>
	<td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
		<table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:850px;">
		<tr>
			<th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<th class="drk left middle" style="width:212px;">Tree Information</th>
					<td align="right" style="width:530px;">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="submitForm7();return false;">Update</a>
					</td>
					<td style="width:10px;"></td>
					<td align="center">
						<a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
						onclick="resetForm7();return false;">Cancel</a>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">

			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
				<td class="right" style="width:55px;">
				<td class="center"><span class="pagetitle" style="position:relative;top:0px;font-size: 12px;">Loc No: #getSite.location_no# - #getSite.name#</span></td>
				<td class="right" style="width:55px;"><span style="position:relative;top:1px;right:-5px;">
				<a href="" onclick="addSIR();return false;"><img src="../images/add_sir.png" width="24" height="24" title="Add New SIR" style="position:relative;right:0px;"></a>
					<a href="" onclick="delSIR();return false;"><img src="../images/remove_sir.png" width="24" height="24" title="Remove Last SIR" style="position:relative;right:0px;"></a>
				</span>
				</td></tr>
			</table>

			</td>
		</tr>
		
	<cfset lngth1 = 5>
	<cfset lngth2 = 20>
	<cfloop index="j" from="1" to="#lngth1#">
		<cfset scnt = j>
		
		<cfquery name="chkSIRs" dbtype="query">
		SELECT max(group_no) as mx FROM getTreeSIRInfo
		</cfquery>
		<cfset max_scnt = 1><cfif chkSIRs.recordcount gt 0><cfset max_scnt = chkSIRs.mx></cfif>
		
		<cfset tvis = "block"><cfset sirdis = "">
		<cfif j gt max_scnt><cfset tvis = "none"><cfset sirdis = "disabled"></cfif>
		<tr>
		<td colspan="2" style="padding:0px;">
			<div id="trees_div_#scnt#" style="display:#tvis#;">
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
			
			<tr>
				<th class="drk left middle" colspan="2" style="height:12px;padding:0px 0px 0px 0px;">
				</th>
			</tr>
			<cfif scnt is 1>
			<tr><td style="height:2px;"></td></tr>
			<cfelse>
			<tr><td style="height:20px;"></td></tr>
			</cfif>
			<tr>
				<th class="left middle" colspan="2" style="height:1px;padding:0px 0px 0px 0px;">
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<th class="drk left middle" colspan="2" style="height:3px;padding:0px 0px 0px 0px;">
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				
				<td colspan="2" style="padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
			
					<cfquery name="getSIRs" dbtype="query">
					SELECT * FROM getTreeSIRInfo WHERE group_no = #scnt#
					</cfquery>
					<cfset v = ""><cfif trim(getSIRs.sir_no) is not "">
					<cfset v = trim(getSIRs.sir_no)></cfif>
					<th class="left middle" style="height:22px;width:48px;">SIR #chr(35)#:</th>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:83px;"><input type="Text" name="sir_#scnt#" id="sir_#scnt#" value="#v#" 
					style="width:78px;height:20px;padding:0px 0px 0px 4px;" maxlength="8" class="roundedsmall" #sirdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getSIRs.sir_date) is not "">
					<cfset v = dateformat(trim(getSIRs.sir_date),"mm/dd/yyyy")></cfif>
					<th class="left middle" style="width:70px;">&nbsp;SIR Date:</th>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:100px;"><input type="Text" name="sirdt_#scnt#" id="sirdt_#scnt#" value="#v#" 
					style="width:95px;height:20px;padding:0px;" class="center roundedsmall" #sirdis#></td>
					<td style="width:2px;"></td>
					<th class="left middle"></th>			
				</table>
				</td>
				
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="drk left middle"><span style="position:relative;top:0px;">Tree Removals</span></th>
					<th class="drk right middle"><span style="position:relative;top:1px;">
					<a href="" onclick="addTree('rmv',#scnt#);return false;"><img src="../images/add.png" width="16" height="16" title="Add Tree Removal" style="position:relative;right:4px;"></a>
					<a href="" onclick="delTree('rmv',#scnt#);return false;"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Removal" style="position:relative;right:2px;"></a>
					</span>
					</th></tr>
				</table>
			</th></tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<td colspan="2" style="padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<th class="left middle" style="height:22px;width:48px;">Tree No:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:83px;">Size (Diameter):</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:113px;">Permit Issuance Date:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:103px;">Tree Removal Date:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:240px;">Address:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="">Species:</th>		
				</table>
				
				<cfloop index="i" from="1" to="#lngth2#">
				<cfset trcnt = i>
				
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 0 AND group_no = #scnt#
				</cfquery>
				
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
				
				<cfset vis = "block"><cfset trdis = ""><cfif i gt max_trcnt><cfset vis = "none"><cfset trdis = "disabled"></cfif>
				<div id="tr_rmv_div_#scnt#_#trcnt#" style="display:#vis#;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<cfquery name="getList" dbtype="query">
					SELECT * FROM getTreeListInfo WHERE action_type = 0 AND group_no = #scnt# AND tree_no = #trcnt#
					</cfquery>
					<td class="frm left middle" style="width:49px;height:26px;">
					<cfset v = 24><cfif trim(getList.tree_size) is not "">
					<cfset v = trim(getList.tree_size)></cfif>
					<input type="Text" name="trcnt_#scnt#_#trcnt#" id="trcnt_#scnt#_#trcnt#" value="#trcnt#" 
					style="width:46px;height:20px;padding:0px;" class="center roundedsmall" disabled></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:84px;">
					<select name="trdia_#scnt#_#trcnt#" id="trdia_#scnt#_#trcnt#" class="roundedsmall" style="width:81px;height:20px;" #trdis#>
					<cfloop index="i" from="1" to="#arrayLen(arrDia)#">
						<cfset sel = ""><cfif arrDia[i] is v><cfset sel = "selected"></cfif>
						<option value="#arrDia[i]#" #sel#>#arrDia[i]# Inches</option>
					</cfloop>
					</select>
					</td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.permit_issuance_date) is not "">
					<cfset v = dateformat(trim(getList.permit_issuance_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:114px;"><input type="Text" name="trpidt_#scnt#_#trcnt#" id="trpidt_#scnt#_#trcnt#" value="#v#" 
					style="width:111px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.tree_removal_date) is not "">
					<cfset v = dateformat(trim(getList.tree_removal_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:104px;"><input type="Text" name="trtrdt_#scnt#_#trcnt#" id="trtrdt_#scnt#_#trcnt#" value="#v#" 
					style="width:101px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = "">
					<cfif trim(getList.address) is not ""><cfset v = trim(getList.address)></cfif>
					<cfif getList.recordcount is 0><cfset v = getSite.address></cfif>
					<td class="frm left middle" style="width:241px;"><input type="Text" name="traddr_#scnt#_#trcnt#" id="traddr_#scnt#_#trcnt#" value="#v#" 
					style="width:238px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="">
					<div class="ui-widget">
					<cfset v = ""><cfif trim(getList.species) is not ""><cfset v = trim(getList.species)></cfif>
  					<label for="tr_species_#scnt#_#trcnt#"></label>
					<input type="Text" name="trspecies_#scnt#_#trcnt#" id="trspecies_#scnt#_#trcnt#" value="#v#" 
					style="width:217px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall" #trdis#></td>	
					</div>
				</table>
				</div>
				</cfloop>
				<cfset tr_rmv_cnt = max_trcnt>
				<input type="Hidden" id="tr_rmv_cnt_#scnt#" name="tr_rmv_cnt_#scnt#" value="#tr_rmv_cnt#" #sirdis#>
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="drk left middle"><span style="position:relative;top:0px;">Tree Plantings</span></th>
					<th class="drk right middle"><span style="position:relative;top:1px;">
					<a href="" onclick="addTree('add',#scnt#);return false;"><img src="../images/add.png" width="16" height="16" title="Add Tree Planting" style="position:relative;right:4px;"></a>
					<a href="" onclick="delTree('add',#scnt#);return false;"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Planting" style="position:relative;right:2px;"></a>
					</span>
					</th></tr>
				</table>
			</th></tr>
			<tr><td style="height:2px;"></td></tr>
			<tr>
				<td colspan="2" style="padding:0px;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<th class="left middle" style="height:22px;width:48px;">Tree No:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:83px;">Size (Diameter):</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:113px;">Permit Issuance Date:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:103px;">Tree Planting Date:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="width:240px;">Address:</th>
					<td style="width:2px;"></td>
					<th class="left middle" style="">Species:</th>		
				</table>
				
				<cfloop index="i" from="1" to="#lngth2#">
				<cfset trcnt = i>
				
				<cfquery name="chkList" dbtype="query">
				SELECT max(tree_no) as mx FROM getTreeListInfo WHERE action_type = 1  AND group_no = #scnt#
				</cfquery>
				<cfset max_trcnt = 0><cfif chkList.recordcount gt 0><cfset max_trcnt = chkList.mx></cfif>
				
				<cfset vis = "block"><cfset trdis = ""><cfif i gt max_trcnt><cfset vis = "none"><cfset trdis = "disabled"></cfif>
				<div id="tr_add_div_#scnt#_#trcnt#" style="display:#vis#;">
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
				<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<cfquery name="getList" dbtype="query">
					SELECT * FROM getTreeListInfo WHERE action_type = 1 AND group_no = #scnt# AND tree_no = #trcnt#
					</cfquery>
					<td class="frm left middle" style="width:49px;height:26px;">
					<cfset v = 24><cfif trim(getList.tree_size) is not "">
					<cfset v = trim(getList.tree_size)></cfif>
					<input type="Text" name="tpcnt_#scnt#_#trcnt#" id="tpcnt_#scnt#_#trcnt#" value="#trcnt#" 
					style="width:46px;height:20px;padding:0px;" class="center roundedsmall" disabled></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="width:84px;">
					<select name="tpdia_#scnt#_#trcnt#" id="tpdia_#scnt#_#trcnt#" class="roundedsmall" style="width:81px;height:20px;" #trdis#>
					<cfloop index="i" from="1" to="#arrayLen(arrDia)#">
						<cfset sel = ""><cfif arrDia[i] is v><cfset sel = "selected"></cfif>
						<option value="#arrDia[i]#" #sel#>#arrDia[i]# Inches</option>
					</cfloop>
					</select>
					</td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.permit_issuance_date) is not "">
					<cfset v = dateformat(trim(getList.permit_issuance_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:114px;"><input type="Text" name="tppidt_#scnt#_#trcnt#" id="tppidt_#scnt#_#trcnt#" value="#v#" 
					style="width:111px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getList.tree_planting_date) is not "">
					<cfset v = dateformat(trim(getList.tree_planting_date),"mm/dd/yyyy")></cfif>
					<td class="frm left middle" style="width:104px;"><input type="Text" name="tptrdt_#scnt#_#trcnt#" id="tptrdt_#scnt#_#trcnt#" value="#v#" 
					style="width:101px;height:20px;padding:0px;" class="center roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<cfset v = "">
					<cfif trim(getList.address) is not ""><cfset v = trim(getList.address)></cfif>
					<cfif getList.recordcount is 0><cfset v = getSite.address></cfif>
					<td class="frm left middle" style="width:241px;"><input type="Text" name="tpaddr_#scnt#_#trcnt#" id="tpaddr_#scnt#_#trcnt#" value="#v#" 
					style="width:238px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall" #trdis#></td>
					<td style="width:2px;"></td>
					<td class="frm left middle" style="">
					<div class="ui-widget">
					<cfset v = ""><cfif trim(getList.species) is not ""><cfset v = trim(getList.species)></cfif>
  					<label for="tp_species_#scnt#_#trcnt#"></label>
					<input type="Text" name="tpspecies_#scnt#_#trcnt#" id="tpspecies_#scnt#_#trcnt#" value="#v#" 
					style="width:217px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall" #trdis#></td>	
					</div>
				</table>
				</div>
				</cfloop>
				<cfset tr_add_cnt = max_trcnt>
				<input type="Hidden" id="tr_add_cnt_#scnt#" name="tr_add_cnt_#scnt#" value="#tr_add_cnt#" #sirdis#>
				</td>
			</tr>
			<tr><td style="height:2px;"></td></tr>
			<tr><th class="drk" style="height:0px;"></th></tr>
			</table>
			<!--- <input type="Hidden" id="tr_add_cnt_#scnt#" name="tr_add_cnt_#scnt#" value="#tr_add_cnt#"> --->
			</div>
		</td>
		</tr>
		
	</cfloop>
		
		<cfset arrTrees = arrayNew(1)>
		<cfset arrTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___">
		<cfset arrTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE___">
		<cfset arrTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER_">
		<cfset arrTrees[4] = "FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT_">
	
		<tr>
			<td style="padding:0px;" colspan="2">
			
			<div>
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
					<th class="drk left middle" colspan="9" style="height:12px;padding:0px 0px 0px 0px;">
					</th>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="center middle" style="height:20px;">DESCRIPTION</th>
					<td style="width:2px;"></td>
					<th class="center middle">UNIT</td>
					<td style="width:2px;"></td>
					<th class="center middle">Assessment Quantity</td>
					<td style="width:2px;"></td>
					<th class="center middle" colspan="3"></th>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="drk left middle" colspan="9" style="height:2px;padding:0px 0px 0px 0px;">
					</th>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;width:230px;">Tree Root Pruning / Shaving (Per Tree):&nbsp;</th>
					<td style="width:2px;"></td>
					<cfset tr_fld = arrTrees[1]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[1]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[1]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[1]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[1]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					<td style="width:2px;"></td>
					<th class="left middle" style="height:30px;width:145px;">Tree Removal Contractor:&nbsp;</th>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getTreeInfo.tree_removal_contractor) is not "">
					<cfset v = trim(getTreeInfo.tree_removal_contractor)></cfif>
					<td class="frm left middle"><input type="Text" name="tree_trc" id="tree_trc" value="#v#" 
					style="width:263px;" class="rounded"></td>
					
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;">Tree Canopy Pruning (Per Tree):&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[2]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[2]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[2]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[2]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[2]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					<td></td>
					<th class="left middle" style="height:30px;">Tree Planting Contractor:&nbsp;</th>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getTreeInfo.tree_planting_contractor) is not "">
					<cfset v = trim(getTreeInfo.tree_planting_contractor)></cfif>
					<td class="frm left middle"><input type="Text" name="tree_tpc" id="tree_tpc" value="#v#" 
					style="width:263px;" class="rounded"></td>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;">Install Root Control Barrier:&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[3]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[3]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[3]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[3]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[3]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					<td></td>
					<th class="left middle" style="height:30px;">Tree Watering Contractor:&nbsp;</th>
					<td style="width:2px;"></td>
					<cfset v = ""><cfif trim(getTreeInfo.tree_watering_contractor) is not "">
					<cfset v = trim(getTreeInfo.tree_watering_contractor)></cfif>
					<td class="frm left middle"><input type="Text" name="tree_twc" id="tree_twc" value="#v#" 
					style="width:263px;" class="rounded"></td>
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr>
					<th class="left middle" style="height:30px;">4' x 6' Tree Well Cut Out:&nbsp;</th>
					<td></td>
					<cfset tr_fld = arrTrees[4]>
					<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
					SELECT * FROM tblEstimateDefaults WHERE fieldname = '#left(tr_fld,len(tr_fld)-1)#'
					</cfquery>
					<cfset v = getDefault.units><cfif evaluate("getEst.#arrTrees[4]#UNITS") is not "">
					<cfset v = evaluate("getEst.#arrTrees[4]#UNITS")></cfif>
					<td class="frm left middle"><input type="Text" name="tree_#tr_fld#UNITS" id="tree_#tr_fld#UNITS" value="#v#" 
					style="width:40px;text-align:center;" class="center rounded" disabled></td>
					<td></td>
					<cfset v = 0><cfif evaluate("getEst.#arrTrees[4]#QUANTITY") is not "">
					<cfset v = evaluate("getEst.#arrTrees[4]#QUANTITY")></cfif>
					<td class="frm left middle" style="width:135px;"><input type="Text" name="tree_#tr_fld#QUANTITY" id="tree_#tr_fld#QUANTITY" value="#v#" 
					style="width:130px;text-align:center;" class="center rounded"></td>
					<td></td>
					<th class="left middle" colspan="3">
				</tr>
				<tr><td style="height:2px;"></td></tr>
				<tr><th class="left middle" colspan="9" style="height:20px;">
					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
					<tr><th class="left middle" style="padding:1px 0px 0px 0px">Tree Removal Notes:</th>
					<td class="right" style="padding:0px;"><a href="" onclick="expandTextArea('tree_trn',4,14);return false;" style="position:relative;top:1px;right:8px;"><img src="../images/fit.png" width="13" height="13"  title="Expand to View All Text"></a></td></tr>
					</table>
				</th></tr>
				<tr><td style="height:2px;"></td></tr>
				
				
				
				
				<tr>
					<cfset v = ""><cfif trim(getTreeInfo.tree_removal_notes) is not "">
					<cfset v = trim(getTreeInfo.tree_removal_notes)></cfif>
					<td class="frm" colspan="9" style="height:73px;">
					<textarea id="tree_trn" class="rounded" style="position:relative;top:0px;left:2px;width:836px;height:69px;">#v#</textarea>
					</td>
				</tr>
				
				
				
			</table>
			
			</div>
			
			
			</td>
		</tr>
		
		
		<cfif session.user_power gte 0>
		<tr>
		<th class="left middle" colspan="2" style="height:30px;">
			
			<cfset src_arb = "../images/pdf_icon_trans.gif"><cfset href_arb = "">
			<cfset src_rmvl = "../images/pdf_icon_trans.gif"><cfset href_rmvl = "">
			
			<cfset cnt = 5 - len(getSite.location_no)><cfset dir2 = getSite.location_no><cfloop index="i" from="1" to="#cnt#"><cfset dir2 = "0" & dir2></cfloop>
			<cfset dir = request.dir & "\pdfs\" & dir2>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.pdf">
			<cfloop query="pdfdir">
				<cfif lcase(pdfdir.name) is "tree_removal_permits." & dir2 & ".pdf">
					<cfset src_rmvl = "../images/pdf_icon.gif">
					<cfset href_rmvl = "href = '" & request.url & "pdfs/" & dir2 & "/tree_removal_permits." & dir2 & ".pdf' title='View Tree Removal Permits PDF'">
				</cfif>
				<cfif lcase(pdfdir.name) is "arborist_report." & dir2 & ".pdf">
					<cfset src_arb = "../images/pdf_icon.gif">
					<cfset href_arb = "href = '" & request.url & "pdfs/" & dir2 & "/arborist_report." & dir2 & ".pdf' title='View Arborist Report PDF'">
				</cfif>
			</cfloop>
			
			
			<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
				<tr>
					<cfset attvis = "hidden"><cfif href_rmvl is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:170px;"><a id="a_rmvl" #href_rmvl# target="_blank"><img id="img_rmvl" src="#src_rmvl#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Tree Removal Permits</span></a>
					<span id="rmv_rmvl" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(0);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Tree Removal Permits" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
					<cfset attvis = "hidden"><cfif href_arb is not ""><cfset attvis = "visible"></cfif>
					<th class="left" style="width:120px;"><a id="a_arb" #href_arb# target="_blank"><img id="img_arb" src="#src_arb#" width="17" height="17" style="position:relative;top:2px;">
					<span style="position:relative;top:-3px;">Arborist Report</span></a>
					<span id="rmv_arb" style="visibility:#attvis#;"><a href="" onclick="showRemoveAttach(1);return false;"><img src="../images/grey_x.png" width="8" height="8" title="Remove Arborist Report" style="position:relative;top:-2px;left:7px;"></a></span>
					</th>
					<th><a href="" onclick="showAttach();return false;"><img src="../images/attach.png" width="9" height="15" title="Attach Files" style="position:relative;top:3px;right:5px;">
					<span style="position:relative;top:0px;right:5px;" title="Attach Files">Attach Files</span></a></td>
				</tr>
			</table>
				
		</th>
		</tr>
		</cfif>
		
		
	
		
		</table>
	</td>
	</tr>
	<cfset trees_sir_cnt = max_scnt>
	<input type="Hidden" id="trees_sir_cnt" name="trees_sir_cnt" value="#trees_sir_cnt#">
	<input type="Hidden" id="sw_id" name="sw_id" value="#getSite.location_no#">
	</form>
</table>
	
	
<div id="msg5" class="box" style="top:40px;left:1px;width:380px;height:144px;display:none;z-index:505;">
	<a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onclick="$('#chr(35)#msg5').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
	<div class="box_header"><strong>The Following Error(s) Occured:</strong></div>
	<div class="box_body" style="margin: 4px 0px 0px 0px;width:100%;">
		<div id="msg_text5" style="top:10px;left:0px;height:200px;padding:25px 0px 0px 5px;align:center;text-align:center;">
		</div>
		
		<div style="position:absolute;bottom:15px;width:100%;">
		<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr><td align="center">
				<a href="" class="button buttonText" style="height:15px;width:60px;padding:2px 0px 0px 0px;" 
				onclick="$('#chr(35)#msg5').hide();return false;">Close</a>
			</td></tr>
		</table>
		</div>
		
	</div>
	
</div>
	
	
	
</div>



</body>


</cfoutput>

<script>

<cfoutput>
var url = "#request.url#";
var pid = #url.pid#;
var search = #url.search#;

var lgth1 = #lngth1#;
var lgth2 = #lngth2#;
</cfoutput>
var treeSub = false;

var arrSpecies = [];
<cfloop query="getSpecies">
<cfoutput>arrSpecies.push("#common#");</cfoutput>
</cfloop>

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
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
 
 
 
 
 
 function resetForm7() {
	if (treeSub == false) { $('#form7')[0].reset(); }
	$('#box_tree').hide();
	$('#msg5').hide();
}


function chkForm7() {
	
	var errors = "";
	var cnt = 0;
	<cfset cnt = 0>
	<cfoutput>	
	<cfloop index="i" from="1" to="#arrayLen(arrTrees)#">			
	
		<cfset v = replace(arrTrees[i],"_"," ","ALL")>
		<cfset v = replace(v,"FOUR FEET","4\'","ALL")>
		<cfset v = replace(v,"SIX FEET","6\'","ALL")>
		<cfset v = lcase(v)>
		<cfset v = CapFirst(v)>
		<cfset v = replace(v," Quantity","","ALL")>
		<cfset v = replace(v,"Per Tree","(Per Tree)","ALL")>
		<cfset v = replace(v,"And","and","ALL")>
		<cfset v = replace(v," ","&nbsp;","ALL")>
		<cfset v = replace(v,"&nbsp;L&nbsp;","&nbsp;/&nbsp;","ALL")>

		var chk = $.isNumeric(trim($('#chr(35)#tree_#arrTrees[i]#QUANTITY').val().replace(/,/g,""))); 
		var chk2 = trim($('#chr(35)#tree_#arrTrees[i]#QUANTITY').val());
		if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'#v#\' must be numeric!<br>'; }
		
		<cfset cnt = cnt + 1>
	</cfloop>
	</cfoutput>
	
	for (var i = 1; i < lgth1+1; i++) {
		if ($('#trees_div_' + i).is(':visible')) {
		
			//console.log(i);
			var chk = $.isNumeric(trim($('#sir_' + i).val().replace(/,/g,""))); 
			var chk2 = trim($('#sir_' + i).val());
			if (chk2 != '' && chk == false)	{ cnt++; errors = errors + '- \'SIR #\' for Entry ' + i + ' must be numeric!<br>'; }
		
			for (var j = 1; j < lgth2+1; j++) {
				if ($('#tr_rmv_div_' + i + '_' + j).is(':visible')) {
					var v = $('#trspecies_' + i + '_' + j).val();
					if (v != '') {
						var ok = false;
						$.each(arrSpecies, function(i, item) {
							if (v == item) { ok = true; return;}
						});
						if (ok == false) { cnt++; errors = errors + '- \'Species\' for Tree Removal ' + j + ' for entry ' + i + ' must be from the dropdown list!<br>'; }
					}
				}
				if ($('#tr_add_div_' + i + '_' + j).is(':visible')) {
					var v = $('#tpspecies_' + i + '_' + j).val();
					if (v != '') {
						var ok = false;
						$.each(arrSpecies, function(i, item) {
							if (v == item) { ok = true; return;}
						});
						if (ok == false) { cnt++; errors = errors + '- \'Species\' for Tree Planting ' + j + ' for entry ' + i + 'must be from the dropdown list!<br>'; }
					}
				}
			}
		}
	}

	return errors + ":" + cnt;

}

function submitForm7() {

	var chk = chkForm7().split(':');
	var errors = chk[0];
	var cnt = parseInt(chk[1]);
	if (errors != '') {
		showMsg5(errors,cnt);
		return false;	
	}
	
	var frm = $('#form7').serializeArray();
	frm.push({"name" : "tree_trn", "value" : trim($('#tree_trn').val()) });
	<cfoutput>
	<cfloop index="i" from="1" to="#arrayLen(arrTrees)#">
	frm.push({"name" : "tree_#arrTrees[i]#UNITS", "value" : trim($('#chr(35)#tree_#arrTrees[i]#UNITS').val()) });
	</cfloop>
	</cfoutput>
	
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: url + "cfc/sw.cfc?method=updateTrees2&callback=",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON(trim(data));
	  	console.log(data);

		/* if(data.RESULT != "Success") {
			showMsg5(data.RESULT,1);
			return false;	
		}
		
		$('#box_tree').hide();
		$('#msg5').hide();
		
		treeSub = true;
				
		showMsg("Tree Removals updated successfully!",1,"Tree Removal Form"); */
		
	  }
	});
	
}

function showMsg5(txt,cnt) {
	$('#msg_text5').html(txt);
	$('#msg5').height(35+cnt*14+30);
	$('#msg5').css({top:'50%',left:'50%',margin:'-'+($('#msg5').height() / 2)+'px 0 0 -'+($('#msg5').width() / 2)+'px'});
	$('#msg5').show();
}

function addTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	$('#tr_' + typ + '_div_' + scnt + '_' + (cnt+1)).show();
	$('#tr_' + typ + '_cnt_' + scnt).val(cnt+1);
	var pfx = "tr";
	if (typ == "add") { pfx = "tp"; }
	$("#" + pfx + "dia_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "pidt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "trdt_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "addr_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
	$("#" + pfx + "species_" + scnt + "_" + (cnt+1)).removeAttr('disabled');
}

function delTree(typ,scnt) {
	var cnt = parseInt($('#tr_' + typ + '_cnt_' + scnt).val());
	if (cnt != 0) {	
		$('#tr_' + typ + '_div_' + scnt + '_' + (cnt)).hide();
		$('#tr_' + typ + '_cnt_' + scnt).val(cnt-1); 
		var pfx = "tr";
		if (typ == "add") { pfx = "tp"; }
		$("#" + pfx + "dia_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "pidt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "trdt_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "addr_" + scnt + "_" + (cnt)).attr('disabled', true);
		$("#" + pfx + "species_" + scnt + "_" + (cnt)).attr('disabled', true);
	}
}

function addSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	$('#trees_div_' + (cnt+1)).show();
	$('#trees_sir_cnt').val(cnt+1);
	$('#sir_' + (cnt+1)).removeAttr('disabled');
	$('#sirdt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_rmv_cnt_' + (cnt+1)).removeAttr('disabled');
	$('#tr_add_cnt_' + (cnt+1)).removeAttr('disabled');
}

function delSIR() {
	var cnt = parseInt($('#trees_sir_cnt').val());
	if (cnt != 1) {	
		$('#trees_div_' + cnt).hide();
		$('#trees_sir_cnt').val(cnt-1); 
		$('#sir_' + cnt).attr('disabled', true);	
		$('#sirdt_' + cnt).attr('disabled', true);	
		$('#tr_rmv_cnt_' + cnt).attr('disabled', true);	
		$('#tr_add_cnt_' + cnt).attr('disabled', true);	
	}
}

function expandTextArea(tarea,rows,dy) {
	var l = $('#' + tarea).val().split("\n").length;
	var dht = (rows*dy)+5;
	$('#' + tarea).height(dht);
	var nht = $('#' + tarea)[0].scrollHeight-6;
	if (nht > dht) {	$('#' + tarea).height(nht); }
}


<cfoutput>
$(function() {
<cfloop index="i" from="1" to="#lngth1#">
	<cfloop index="j" from="1" to="#lngth2#">
	    $( "#chr(35)#trspecies_#i#_#j#" ).autocomplete({ source: arrSpecies });
		$( "#chr(35)#trpidt_#i#_#j#" ).datepicker();
		$( "#chr(35)#trtrdt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tpspecies_#i#_#j#" ).autocomplete({ source: arrSpecies });
		$( "#chr(35)#tppidt_#i#_#j#" ).datepicker();
		$( "#chr(35)#tptrdt_#i#_#j#" ).datepicker();
	</cfloop>
		$( "#chr(35)#sirdt_#i#" ).datepicker();
</cfloop>
 });
</cfoutput>
</script>

</html>


            

				

	


