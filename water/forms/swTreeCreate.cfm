<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=2");
	</script>
	<cfabort>
</cfif>
<!--- <cfif session.user_power is 1>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=2&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<html>
<head>
<title>Tree and watering</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<cfoutput>
<script language="JavaScript1.2" src="../js/fw_menu.js"></script>
<script language="JavaScript" src="../js/isDate.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
</script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>

  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>   


<!--- <link href="#request.stylesheet#" rel="stylesheet" type="text/css"> --->
<cfinclude template="../css/css.cfm">


<!---  our js --->


<!---   version 1.6.4 has bug on selectall check box   --->
	
    <!---
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
	--->
    
    <script src="../js/angularjs.1.6.4/angular.min.js"></script>  
    <script src="../js/angularjs.1.6.4/angular-touch.min.js"></script>
     

<!---   jquery auto complete   
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mockjax/1.6.2/jquery.mockjax.min.js"></script> 
<script language="JavaScript" src="../js/jquery.autocomplete.js"></script>
<link href="../css/jquery-auto-complete.css" rel="stylesheet" type="text/css" />
 --->
 
 
 
 
 <!---   720kb/angular-datepicker    --->
 	<link href="../css/angular-datepicker.css" rel="stylesheet" type="text/css" />
    <script src="../js/angular-datepicker.js"></script>
    <script src="../js/moment.min.js"></script>
   
    
    
    <!--- hueitan/angular-validation   
    <script src="../js/angular-validation.js"></script>
    <script src="../js/angular-validation-rule.js"></script>
    --->
    

<!---   angucomplete-alt auto complete    --->
    <script language="JavaScript" src="../js/angucomplete-alt.min.js"></script>
    <script language="JavaScript" src="../js/species.js"></script>  
     <link href="../css/angucomplete-alt.css" rel="stylesheet" type="text/css" />
  

<script language="JavaScript" src="../js/swTreeCreate.js"></script>


<!--- End our js --->

</head>

<style type="text/css">
body{background-color: transparent}
</style>


<!---
<cfparam name="url.sid" default="312">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">
<cfparam name="url.crid" default="0">
<cfparam name="url.crsearch" default="false">
--->



<!--- Get Site --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>


<!--- Get program type --->
<cfquery name="getProgramType" datasource="#request.sqlconn2#" dbtype="ODBC">
SELECT id, type FROM program_type WHERE id = #url.type_id#
</cfquery>



<!---

<cfif url.search is true><cfset url.pid = 0></cfif>

  // Get Package 
<cfset isBSS = false>
<cfset isCert = false>
<cfset sw_pid = ""><cfset sw_grp = "">
<cfif url.pid gt 0>
	<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
	SELECT * FROM tblPackages WHERE id = #url.pid#
	</cfquery>
	<cfset sw_pid = getPackage.package_no>
	<cfset sw_grp = getPackage.package_group>
	<cfif ucase(getPackage.contractor) is "BSS"><cfset isBSS = true></cfif>
<cfelse>
	<cfset sw_pid = getSite.package_no>
	<cfset sw_grp = getSite.package_group>
	<cfif sw_pid is not "" AND sw_grp is not "">
		<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT * FROM tblPackages WHERE package_no = #sw_pid# AND package_group = '#sw_grp#'
		</cfquery>
		<cfif getPackage.recordcount gt 0>
			<cfif ucase(getPackage.contractor) is "BSS"><cfset isBSS = true></cfif>
		</cfif>
	</cfif>
</cfif>
<cfif getSite.package_group is "BSS"><cfset isBSS = true></cfif>
<cfif isdefined("session.user_cert")>
	<cfif session.user_cert is 1><cfset isCert = true></cfif>
</cfif>

--->









<!--- Get Trees 
<cfquery name="getTreeInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSiteInfo WHERE location_no = #getSite.location_no#
</cfquery>

<cfquery name="getTreeSIRInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeSIRs WHERE location_no = #getSite.location_no# AND deleted <> 1 ORDER BY group_no
</cfquery>

<cfquery name="getTreeListInfo" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeList WHERE location_no = #getSite.location_no# AND deleted <> 1
</cfquery>

--->


<cfset arrDisabledTrees = arrayNew(1)>
<cfset arrDisabledTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE__">
<cfset arrDisabledTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE__">
<cfset arrDisabledTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER">
<cfset arrDisabledTrees[4] = "FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT">
<cfset arrDisabledTrees[5] = "TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER__">
<cfset arrDisabledTrees[6] = "TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER__">
<cfset arrDisabledTrees[7] = "FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE">
<cfset arrDisabledTrees[8] = "WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH">
<cfset arrDisabledTrees[9] = "EXISTING_STUMP_REMOVAL">





<cfoutput>
<body alink="#request.color#" vlink="#request.color#" link="#request.color#" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" style="overflow:auto;">
</cfoutput>

<!---

<!--- display returned json response for test only --->
        <pre id='return_json'>
        </pre>
    <!--- End ---- display returned json response for test only --->
	
--->

	
	
						<div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">

                                            <a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex">
                                            </a>
                                            
                                            
                                            <div id="msg_header" class="box_header">
                                                <strong>The Following Error(s) Occured:</strong>
                                            </div>
                                            
                                            
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





<!--- Create Diameter Array 
<cfset arrDia = arrayNew(1)>
<cfloop index="i" from="6" to="48" step="2"><cfset go = arrayAppend(arrDia,i)></cfloop>
--->



<!--- Get Species List 
<cfquery name="getSpecies" datasource="navla_spatial" dbtype="ODBC">
SELECT DISTINCT common FROM dbo.ags_bss_tree_inventory WHERE common is not null ORDER BY common
</cfquery>

--->



<!--- Get ChangeOrder Values 
<cfquery name="getTreeTypes" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblTreeTypes ORDER BY id
</cfquery>
--->


	<!--- <div id="box_tree" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;display:none;">   
    <div id="box_tree" style="position:absolute;top:0px;left:0px;height:100%;width:100%;border:0px red solid;z-index:25;">
    --->
    
    
    
    
    <!---  div style="overflow-x:auto;" responsible table with horizontal scrolling bar in case of more column than current width 950px --->
<div ng-app="tree-app" style="overflow-x:auto;">



<!---
    
     <!---   jquery  auto complete  sample --------------------   --->
       
     
      <div>
   
                        <p>simple  >>> Type country name in english:</p>
                        <input type="text" name="country" id="autocomplete"/>
   
                       
                        <p>Type country name in english:</p>
                        <div style="position: relative; height: 80px;">
                            <input type="text" name="country" id="autocomplete-ajax" style="position: absolute; z-index: 2; background: transparent;"/>
                            
                        </div>
                        <div id="selction-ajax"></div>
       </div>
       
       <!---         End ----     jquery  auto complete  sample --------------------   --->
       
    --->   
       
       
    
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" >
                      <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr><td colspan="3" height="15"></td></tr>
                                  <tr>
                                        <td style="width:25%;text-align:right;height:29px;">
                                        </td>
                                        <td align="center" class="pagetitle" style="color:white;">Create Tree Replacement and Watering Site</td>
                                        <td style="width:25%;"></td>
                                  </tr>
                            </table>
                        </td>
                      </tr>
                    </table>






     <!--- for <div ng-controller> to work inside a <table>, <div> is not valid table element, div must be wrap by <td> , but in this case, it still not work, so replace table with div --->  
    <!--- table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:950px;" --->   
     <!---  div style="overflow-x:auto;" responsible table with horizontal scrolling bar in case of more column than current width 950px --->
     
    <div id="box_tree" class="frame" align="center" style="width:952px;  overflow-x:auto;"  ng-controller="TreeController" data-ng-init="init()" >
    
    
    
    
        <form name="form7" id="form7" method="post" action="" enctype="multipart/form-data" ng-submit="submitForm7()">
              
              
              <tr>
				   <td cellspacing="0" cellpadding="0" border="0" bgcolor="white" bordercolor="white">
					
                       
                        <!--- table align=center bgcolor=white cellspacing="2" cellpadding="2" border="0" style="width:950px;"   --->
                         
                         <div  align="center"  style="background-color: white; width:950px; margin: 0px 2px 2px 0px; float:left; padding:2px 2px 0 0; border:0px">  		
                                    
                                    
                                    
                                    
                                    
                                    
                                    <!---    *********    title and button     **********   section  --->
                                    
                                    <tr>
                                        <th class="drk left middle" colspan="2" style="height:30px;padding:0px 0px 0px 0px;">
                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                    <!---
                                                                            <th class="drk left middle" style="height:30px;width:360px;">Create Tree</th>
                                                                      --->      
                                                                            
                                                                            <td align="right" class="drk" style="width:100%;">
                                                                                <cfif session.user_level gte 0 AND session.user_power gte 0>
                                                                                
                                                                                <!---
                                                                                <input type="submit" class="btn btn-primary addnew pull-right"  value="Create">
																				--->	
                                                                                
                                                                                <!--- hidden submit handle for html5 required valication only --->
                                                                                <input id="submit_handle" type="submit" style="display: none">
																					
                                                                                        <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                                                        ng-click="save();">Create</a>
                                                                                    
                                                                                
                                                                                </cfif>
                                                                            </td>
                                                                    
                                                                            <td style="width:10px;"></td>
                                                                    
                                                                    <!---
                                                                    
                                                                            <td align="center">
                                                                                <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                                                onclick="resetForm7();toggleArrows();return false;">Cancel</a>
                                                                            </td>
                                                                    --->
                                                                    
                                                                    
                                                                    </tr>
                                                        </table>
                                        </td>
                            		</tr>
		
        
                                    <!---    END  *********    title and button     **********   section  --->
                                    
                                    
                                    
                                    
                                    
                                    
                                    <!---    *********    Top info  bar    **********   section  --->
        
                                                    <tr>
                                                        <td class="center middle frm" colspan="2" style="height:25px;padding:0px 0px 0px 0px;text-align:center;">
                        
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                <tr>
                                                                   <td class="right" style="width:55px;">
                                                                
                                                                    <td class="center">
                                                                    
                                                                         
                                                                    
                                                                                    <span class="pagetitle" style="position:relative;top:0px;font-size: 12px;">
                                                                                    
                                                                                             
                                                                                              
                                                                                                     #getProgramType.type#  &nbsp;|&nbsp; Package :	#url.package_no#	&nbsp;|&nbsp;
                                                                                                    
                                                                                                    Site : #url.sid#  &nbsp;|&nbsp; CD:#url.cd# &nbsp;|&nbsp; CRM:#url.crm_no#
                                                                                                    
                                                                                                   <!--- &nbsp;|&nbsp;   #getSite.name#  --->
                                                                                                    &nbsp;|&nbsp;   #getSite.address#      
                                                                                                
                                                                                               
                                                                                               
                                                                             
                                                                                      </span>
                                                                             
                                                                             
                                                                    </td>
                                                                                
                                                                </tr>
                                                            </table>
                        
                                                        </td>
                                                    </tr>
		                             
                                     <!---  END  *********    Top info  bar    **********   section  --->
        
        
        
       
        
        
        
	                <!---    *********    all tree    **********   section  --->
		
		
					<tr>
                        <td colspan="2" style="padding:0px;">
                        
                       
                            <div id="all_tree_div" style="display:inline;" >
                            
                            
                            
                                    
                                    
                                           <!---    *********    Remove tree    **********   section  --->
                            
											 
                                             <!--- div id="remove_tree_div" style="display:inline;" ng-controller="RemoveTreeController" --->
                                             <div id="remove_tree_div" style="display:inline; " >
			
                                                    <tr>
                                                      <th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
                                                                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                    <tr>
                                                                        <th class="drk left middle">
                                                                        <span style="position:relative;top:0px;">Tree Removals</span>
                                                                        <span style="position:relative;top:0px;left:20px;">(Total: <strong><span id="_remove_total" style="color:red;">{{RemoveTreeList.length}}</span></strong> )</span></th>
                                                                        <th class="drk right middle">
                                                                           <span style="position:relative;top:1px;">
                                                                           
                                                                           <!---
                                                                           <input type="button" value="Remove" ng-click="remove()" >
                                                                           <input type="button" value="Add New" ng-click="addNew()">
                                                                           --->
                                                                           
                                                                        <cfif session.user_level gte 0 AND session.user_power gte 0>
                                                                                    <a href="" ng-click="addNew_remove_tree()"><img src="../images/add.png" width="16" height="16" 
                                                                                    title="Add Tree Removal" style="position:relative;right:4px;"></a>
                                                                                    <a href="" ng-click="remove_remove_tree()"><img src="../images/delete.png" width="16" height="16"
                                                                                     title="Delete Tree Removal" style="position:relative;right:2px;"></a>
                                                                        </cfif>
                                                                        </span>
                                                                        </th>
                                                                    </tr>
                                                                </table>
                                                        </th>
                                                     </tr>
                                    
                                                    <tr><td style="height:2px;"></td></tr>
			
            
            
                                                    <tr>
                                                        <td colspan="2" style="padding:0px;">
                                                        
                                                        
                                                        
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                        
                                                                       
                                                                        
                                                                            <th class="center middle" style="width:25px;">
                                                                                  <input type="checkbox" ng-model="selectedAll_remove_tree" ng-click="checkAll_remove_tree()" />  
                                                                                   
                                                                            </th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                        
                                                                           
                                                                             <th class="left middle" style="height:22px;width:30px;">No:</th>
                                                                              <td style="width:2px;"></td>
                                                                            
                                                                              
																			 <th class="left middle" style="height:22px;width:30px;">ID:</th>
                                                                              <td style="width:2px;"></td>
                                                                            
																			
																			
                                                                            <th class="left middle" style="width:260px;">Location:</th>
                                                                            <td style="width:2px;"></td>
                                                                            <th class="left middle" style="width:200px;">Species:</th>	
                                                                            <td style="width:2px;"></td>
                                                                            <th class="left middle" style="">Note:</th>
                                                                        </table>
                                                           
                                    
                                        
																		
                     
                                                                         <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                               <tr>
                                                                                    <td height="2px;">
                                                                                    </td>
                                                                               </tr>
                                                                         </table>
                
                
                
                                           
                                                                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                               
                                                                          <tr ng-repeat="RemoveTree in RemoveTreeList">
                                                                          
                                                                         
                                                                          
                                                                                       <td class="frm left middle" style="width:20px;">
                                                                                                 <input type="checkbox" ng-model="RemoveTree.selected" style="width:16px;height:20px;" class="center roundedsmall"/>
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        <!---
                                                                                        <td class="frm left middle" style="width:30px;height:26px;">
                                                                                        
                                                                                            <input ng-model="RemoveTree.count" type="Text" name="remove_tree_count" 
                                                                                               id="_remove_tree_count" value=""  style="width:30px;height:20px;padding:0px;" 
                                                                                               class="center roundedsmall">
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        --->
                                                                                        
                                                                                        
                                                                                        <td class="frm left middle" style="width:30px;height:26px;padding:0px;">
                                                                                             <input  type="Text" name="remove_tree_count" 
                                                                                               id="_remove_tree_count" value="{{$index +1}}"  style="width:30px;height:20px;padding:0px;" 
                                                                                               class="center roundedsmall" disabled>
                                                                                            
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        <td class="frm left middle" style="width:30px;height:26px;padding:0px;">
                                                                                             <input  type="Text" name="remove_tree_id" 
                                                                                               id="_remove_tree_id" ng-model="RemoveTree.tree_id"  style="width:30px;height:20px;padding:0px;" 
                                                                                               class="center roundedsmall" disabled>
                                                                                            
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        <!--- location --->
                                                                                        
                                                                                        <td class="frm left middle" style="width:261px;">
                                                                                        		<input ng-model="RemoveTree.location" type="Text" name="remove_tree_location" 
                                                                                                id="_remove_tree_location" value="" style="width:258px;height:20px;padding:0px 2px 0px 4px;" 
                                                                                                class="roundedsmall form-control" 
                                                                                                
                                                                                                
                                                                                            <!--- ng-init will create a empty object for http post, even if user did not type(empty input field)   --->    
                                                                                            <!---    ng-init="RemoveTree.location=''"   --->
                                                                                                
                                                                                                required/>
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                        <!--- species --->
                                                                                         <td class="frm left middle" style="width:200px;height:20px;">
                                                                                         
                                                                                            <!---    angucomplete-alt     --->
                                                                                              <div class="padded-row">
                                                                                                  <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100"
                                                                                                   selected-object="RemoveTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                   title-field="name" minlength="1" input-class="form-control form-control-small"
                                                                                                    match-class="highlight"
                                                                                                    
                                                                                                    input-changed="RemoveTreeSpecieInputChanged"
                                                                                                   initial-value="RemoveTree.init_specieSelected"   
                                                                                                    >
                                                                                                  </div>
                                                                                                </div>
                                                                                             <!--- End ----  angucomplete-alt --->
                                                                                         
                                                                                         
                                                                                           
                                                                                                    
                                                                                        </td>
                                                                                        
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                       
                                                                                        <!--- note --->
                                                                                        
                                                                                        <td class="frm left middle" >
                                                                                                <input ng-model="RemoveTree.note" type="Text" name="remove_tree_note" 
                                                                                                id="_remove_tree_note" value="" style="width:350px;height:20px;padding:0px 2px 0px 4px;" 
                                                                                                class="roundedsmall" 
                                                                                                
                                                                                            <!---    ng-init="RemoveTree.note=''"    --->
                                                                                                
                                                                                                >
                                                                                        </td>	
                                                                                        
                                                                    
                                                                    
                                                                           </tr>  <!--- end of ng-repeat   --->
                                                                        </table>
                                                                        
                                                                </td>
                                                            </tr>
                    
                                                       </div>   <!--- End remove tree div  --->
                                    
                                    
                                                        <tr><td style="height:2px;"></td></tr>
                                                         <!---  ----------------- end remove tree section  -------------------------    --->
                                                        
                                                        
                                                        
                                                         
                                                        
			
				
										<!---       On Site planting            --->
                                        
                                         <!--- div id="on_site_replace_tree_div" style="display:inline;" ng-controller="OnSiteReplaceTreeController" --->
                                         <div id="on_site_replace_tree_div" style="display:inline;" >
                                        
                                                <tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                        <tr><th class="drk left middle"><span style="position:relative;top:0px;">On Site Tree Replacement</span>
                                                        <span style="position:relative;top:0px;left:25px;">(Total: <strong><span id="_on_site_replacement_total" style="color:red;">{{OnSiteReplaceTreeList.length}}</span></strong> )</span></th>
                                                        <th class="drk right middle"><span style="position:relative;top:1px;">
                                                        <cfif session.user_level gte 0 AND session.user_power gte 0>
                                                        <a href="" ng-click="addNew_onsite_replace_tree()"><img src="../images/add.png" width="16" height="16" title="Add Tree Planting" style="position:relative;right:4px;"></a>
                                                        <a href="" ng-click="remove_onsite_replace_tree()"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Planting" style="position:relative;right:2px;"></a>
                                                        </cfif>
                                                        </span>
                                                        </th></tr>
                                                    </table>
                                                </th></tr>
                                                <tr><td style="height:2px;"></td></tr>
                                        
                                        
                                        
                                                <tr>
                                                    <td colspan="2" style="padding:0px;">
                                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                        
                                                        
                                                           
                                                        
                                                                            <th class="center middle" style="width:20px;">
                                                                                <!--- both ng-click and ng-change works  --->
                                                                                <!---  <input type="checkbox" ng-model="selectedAll" ng-click="checkAll()" />    --->
                                                                                    <input type="checkbox" ng-model="selectedAll_onsite_replace_tree" ng-change="checkAll_onsite_replace_tree()" />
                                                                            </th>
                                                                            <td style="width:2px;"></td>
                                                                    
                                                                 
                                                                            <th class="center middle" style="height:28px;width:26px;"><span style="font-size:10px;">No:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                    
                                                                    
                                                                            <th class="center middle" style="height:28px;width:26px;"><span style="font-size:10px;">ID:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                    
                                                    
                                                    						<th class="left middle" style="width:100px;">Location:</th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            <th class="left middle" style="width:160px;">Species:</th>	
                                                                            <td style="width:2px;"></td>
                                                                          
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:75px;"><span style="font-size:10px;">Planting Date:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                            <th class="center middle" style="width:75px;"><span style="font-size:10px;">Start Watering Date:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                           
                                                                            <th class="center middle" style="width:50px;"><span style="font-size:10px;">Parkway or Tree Well Size:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                             <th class="center middle" style="width:50px;"><span style="font-size:10px;">Overhead Wires:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:50px;">Sub Position:</th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:50px;"><span style="font-size:10px;">Concrete Completed:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                             <th class="center middle" style="width:50px;"><span style="font-size:10px;">Post Inspected:</span></th>
                                                                            <td style="width:2px;"></td>
                                                    
                                                    
                                                     						<th class="left middle" style="">Note:</th>
                                                                        
                                                                     
                                                        </table>
				
                
                
                                           
                                                    
                                                    
                                                   
                                                   
                                                    
                                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
                                                                    
                                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                    
                                                                    
                                                                    
                                                                       <tr ng-repeat="OnSiteReplaceTree in OnSiteReplaceTreeList">
                                                                    
                                                                                        <!--- check box --->
                                                                                        <td class="frm left middle" style="width:20px;">
                                                                                             <input type="checkbox" ng-model="OnSiteReplaceTree.selected" style="width:16px;height:20px;" class="center roundedsmall"/>
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                       
                                                                                        
                                                                                        
                                                                                <!--- number 
                                                                                <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input ng-model="OnSiteReplaceTree.count" type="Text" name="on_site_replace_tree_count" 
                                                                                   id="_on_site_replace_tree_count" value="" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall" >
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                            --->
                                                                            
                                                                            
                                                                            
                                                                                <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input  type="Text" name="on_site_replace_tree_count" 
                                                                                   id="_on_site_replace_tree_count" value="{{$index +1}}" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall"  disabled>
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                          
                                                                                  <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input  type="Text" name="on_site_replace_tree_id" 
                                                                                   id="_on_site_replace_tree_id" ng-model="OnSiteReplaceTree.tree_id" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall"  disabled>
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                       
                                                                                        <!--- location --->
                                                                                        
                                                                                        <td class="frm left middle" style="width:100px;">
                                                                                        		<input ng-model="OnSiteReplaceTree.location" type="Text" 
                                                                                                name="on_site_replace_tree_location" id="_on_site_replace_tree_location" 
                                                                                                value="" style="width:100px;height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" 
                                                                                                
                                                                                            <!---    ng-init="OnSiteReplaceTree.location=''"   --->
                                                                                                
                                                                                                required/>
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                         <!--- species --->
                                                                                         <td class="frm left middle " style="width:100px;height:20px;">
                                                                                         
																								<!---    angucomplete-alt     --->
                                                                                                  <div class="padded-row">
                                                                                                      <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100" 
                                                                                                      			selected-object="OnSiteReplaceTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                      			title-field="name" minlength="1" 
                                                                                                                input-class="form-control form-control-small" match-class="highlight" 
                                                                                                                
                                                                                                                input-changed="OnSiteReplaceTreeSpecieInputChanged"
                                                                                                                initial-value="OnSiteReplaceTree.init_specieSelected"   
                                                                                                                >
                                                                                                      </div>
                                                                                                    </div>
                                                                                                 <!--- End ----  angucomplete-alt --->
                                                                                             
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            
                                                                                       <!--- planting date --->
                                                                                        <td class="frm left middle" style="width:75px;">
                                                                                                        <datepicker date-format="MM/dd/yyyy" date-typer="true" >
                                                                                                              
                                                                                                                    <input ng-model="OnSiteReplaceTree.planting_date" type="text" style="width:75px;"
                                                                                                                    
                                                                                                                      ng-change="date_changed(OnSiteReplaceTree)"
                                                                                                                      class="center roundedsmall"
                                                                                                                      
                                                                                                                   <!---    ng-init="OnSiteReplaceTree.planting_date=''"   --->
                                                                                                                     />
                                                                                                        </datepicker  >
                                                                                                       
                                                                                                        
                                                                                                        
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                       
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                       <!--- start watering date --->
                                                                                        <td class="frm left middle" style="width:75px;">
                                                                                        
                                                                                        <!--- {{OnSiteReplaceTree.planting_date}}  --->
                                                                                        <input   type="text" 
                                                                                                value="{{OnSiteReplaceTree.planting_date}}" style="width:75px;" 
                                                                                                
                                                                                                  class="center roundedsmall"
                                                                                                 disabled />
                                                                                        
                                                                                         <!---
                                                                                           
                                                                                       
                                                                                                        <datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                              
                                                                                                                    <input ng-model="start_watering_date" type="text" style="width:75px;" />
                                                                                                        </datepicker>
                                                                                          --->              
                                                                                                        
                                                                                                        
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                            
                                                                            
                                                                                         <!---   parkway_size   --->
                                                                                          <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                 <input ng-model="OnSiteReplaceTree.parkway_size" type="Text" 
                                                                                                 name="on_site_parkway_size" id="_on_site_parkway_size" value="" 
                                                                                                 style="width:50px;height:20px;padding:0px;" class="center roundedsmall" 
                                                                                             <!---    ng-init="OnSiteReplaceTree.parkway_size=''"    --->
                                                                                                 >
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                         <!---   overhead_wires   --->
                                                                                         <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                        <!---     angular selection component  --->
                                                                                                                    
																												<select ng-model="OnSiteReplaceTree.overhead_wire" ng-options="item for item in overhead_wires"
                                                                                                                 name="on_site_overhead_wire" id="_on_site_overhead_wire" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;">
                                                                                                              <!---   ng-init="OnSiteReplaceTree.overhead_wire=''"     --->
                                                                                                                  
																												
																												</select>
																										<!---  ---  End ----  angular selection component  ---> 
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                                          
                                                                            
                                                                            
                                                                            
                                                                                        <!--- sub position  --->
                                                                            			        <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                  
																								  <input ng-model="OnSiteReplaceTree.sub_position" type="Text" 
                                                                                               name="on_site_replace_tree_sub_position" id="_on_site_replace_tree_sub_position" value="" 
                                                                                               style="width:50px;height:20px;" class="roundedsmall"
                                                                                               
                                                                                            <!---   ng-init="OnSiteReplaceTree.sub_position=''"   --->
                                                                                                >
																								  
																								  
																								  <!---
                                                                                                
																									 <!---     angular selection component  --->
                                                                                                                      <!--- Does not work with 's'  ng-model="sub_positions"--->
																												<select ng-model="sub_position" ng-options="item for item in sub_positions"
                                                                                                                 name="on_site_sub_position" id="_on_site_sub_position" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;" >
																												
																												</select>
																										<!---  ---  End ----  angular selection component  ---> 
																								     --->
                                                                                                
                                                                                                
                                                                                                </td>   
                                                                            
                                                                            
                                                                            
                                                                            
                                                                                        <!---  concrete_completed  --->
                                                                            			<td class="frm left middle" style="width:50px;height:20px;">
                                                                                        
                                                                                                           <select ng-model="OnSiteReplaceTree.concrete_completed" ng-options="item for item in concrete_completeds"
                                                                                                                 name=".on_site_concrete_completed" id="_on_site_concrete_completed" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;">
                                                                                                                 
                                                                                                                <!--- ng-init="OnSiteReplaceTree.concrete_completed=''"    --->
                                                                                                                 
																												
																												</select>
                                                                                                 
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                         <!--- post_inspected  --->
                                                                            			<td class="frm left middle" style="width:50px;height:20px;">
                                                                                        
                                                                                                               <select ng-model="OnSiteReplaceTree.post_inspected" ng-options="item for item in post_inspecteds"
                                                                                                                 name="on_site_post_inspected" id="_on_site_post_inspected" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;">
																												
                                                                                                              <!---  ng-init="OnSiteReplaceTree.post_inspected=''" --->
                                                                                                                 
																												</select>
                                                                                        
                                                                                                
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                                          
                                                                                          
                                                                     						<td class="frm left middle" >
                                                                                                <input ng-model="OnSiteReplaceTree.note" type="Text" 
                                                                                               name="on_site_replace_tree_note" id="_on_site_replace_tree_note" value="" 
                                                                                               style="height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" >
                                                                                               
                                                                                              <!--- ng-init="OnSiteReplaceTree.note=''" --->
                                                                                               
                                                                                              
                                                                                            </td>	
                                                                        
                                                                        
                                                                         </tr>  <!--- ng-repeat  --->  
                                                                    </table>
                                                    
                                          
                                            
                                                                  </td>
                                                                </tr> 
                                               </div>   
                                               <!--- end on site replace  section --->
                                                <!---                       End  on site tree replacement planting                       --->
    
    
    
    
	
    
    
    
    
    
							<!---       OFF  Site planting            --->
                           
                              <!--- div id="on_site_replace_tree_div" style="display:inline;" ng-controller="OffSiteReplaceTreeController" --->
                              <div id="on_site_replace_tree_div" style="display:inline;">
      
                                            <tr><th class="drk left middle" colspan="2" style="height:20px;padding:0px;">
                                                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                    <tr>
                                                            <th class="drk left middle"><span style="position:relative;top:0px;">Off Site Tree Replacement</span>
                                                                        <span style="position:relative;top:0px;left:25px;">
                                                                              (Total: <strong>
                                                                                        <span id="_off_site_replacement_total" style="color:red;">
                                                                                            {{OffSiteReplaceTreeList.length}}
                                                                                         </span>
                                                                                       </strong> )
                                                                        </span>
                                                            </th>
                                                    
                                                    
                                                            <th class="drk right middle"><span style="position:relative;top:1px;">
                                                            <cfif session.user_level gte 0 AND session.user_power gte 0>
                                                            <a href="" ng-click="addNew_offsite_replace_tree()"><img src="../images/add.png" width="16" height="16" title="Add Tree Planting" style="position:relative;right:4px;"></a>
                                                            <a href="" ng-click="remove_offsite_replace_tree()"><img src="../images/delete.png" width="16" height="16" title="Delete Tree Planting" style="position:relative;right:2px;"></a>
                                                            </cfif>
                                                            </span>
                                                            </th>
                                                    </tr>
                                                </table>
                                            </th></tr>
                                            <tr><td style="height:2px;"></td></tr>
                                
                                
                                
                                            <tr>
                                                <td colspan="2" style="padding:0px;">
                            
                                                					<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                
                                                                       <th class="center middle" style="width:20px;">
                                                                                 <!--- both ng-click and ng-change works  --->
                                                                                <!---  <input type="checkbox" ng-model="selectedAll" ng-click="checkAll()" />    --->
                                                                                    <input type="checkbox" ng-model="selectedAll_offsite_replace_tree" ng-change="checkAll_offsite_replace_tree()" />
                                                                        </th>
                                                                        <td style="width:2px;"></td>
                                                                        
                                                                        
                                                                  
                                                                        <th class="center middle" style="height:28px;width:26px;"><span style="font-size:10px;">No:</span></th>
                                                                        <td style="width:2px;"></td>
                                                                  
                                                    
                                                                          <th class="center middle" style="height:28px;width:26px;"><span style="font-size:10px;">ID:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                    
                                                    						<th class="left middle" style="width:100px;">Location:</th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            <th class="left middle" style="width:160px;">Species:</th>	
                                                                            <td style="width:2px;"></td>
                                                                          
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:75px;"><span style="font-size:10px;">Planting Date:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                            <th class="center middle" style="width:75px;"><span style="font-size:10px;">Start Watering Date:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                           
                                                                            <th class="center middle" style="width:50px;"><span style="font-size:10px;">Parkway or Tree Well Size:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                             <th class="center middle" style="width:50px;"><span style="font-size:10px;">Overhead Wires:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:50px;">Sub Position:</th>
                                                                            <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            
                                                                            <th class="center middle" style="width:50px;"><span style="font-size:10px;">Concrete Completed:</span></th>
                                                                            <td style="width:2px;"></td>
                                                                             <th class="center middle" style="width:50px;"><span style="font-size:10px;">Post Inspected:</span></th>
                                                                            <td style="width:2px;"></td>
                                                    
                                                    
                                                     						<th class="left middle" style="">Note:</th>
                                                					</table>
				
                
                
                                            
                                                   
                                                   
                                                    <!--- div id="tr_add0_div_" style="display:inline;" ng-controller="OffSiteReplaceTreeController"--->
                                                    
                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;"><tr><td height="2px;"></td></tr></table>
                                                    
                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                        
                                                        
                                                               <tr ng-repeat="OffSiteReplaceTree in OffSiteReplaceTreeList">
                                                        
                                                        
                                                                                          <!--- checkbox --->
                                                                                            <td class="frm left middle" style="width:20px;">
                                                                                                 <input type="checkbox" ng-model="OffSiteReplaceTree.selected" style="width:16px;height:20px;" 
                                                                                                 class="center roundedsmall"/>
                                                                                            </td>
                                                                                            <td style="width:2px;"></td>
                                                                                            
                                                                            
                                                                            
                                                                                <!--- number 
                                                                                <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input ng-model="OffSiteReplaceTree.count" type="Text" name="off_site_replace_tree_count" 
                                                                                   id="_off_site_replace_tree_count" value="" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall" >
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                            --->
                                                                            
                                                                            
                                                                            
                                                                                
                                                                                <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input type="Text" name="off_site_replace_tree_count" 
                                                                                   id="_off_site_replace_tree_count" value="{{$index+1}}" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall"  disabled>
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                           
                                                                            
                                                                             <td class="frm left middle" style="width:25px;height:26px;">
                                                                                   <input  type="Text" name="off_site_replace_tree_id" 
                                                                                   id="_off_site_replace_tree_id" ng-model="OffSiteReplaceTree.tree_id" style="width:25px;height:20px;padding:0px;" 
                                                                                   class="center roundedsmall"  disabled>
                                                                                </td>
                                                                                <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                       
                                                                                        <!--- location --->
                                                                                        
                                                                                        <td class="frm left middle" style="width:100px;">
                                                                                        		<input ng-model="OffSiteReplaceTree.location" type="Text" 
                                                                                                name="off_site_replace_tree_location" id="_off_site_replace_tree_location" 
                                                                                                value="" style="width:100px;height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" required/>
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                         <!--- species --->
                                                                                         <td class="frm left middle" style="width:100px;height:20px;">
                                                                                         
																								<!---    angucomplete-alt     --->
                                                                                                  <div class="padded-row">
                                                                                                      <div ng-model="OffSiteReplaceTree.specie" angucomplete-alt id="ex1" 
                                                                                                            placeholder="Search species" maxlength="50" pause="100" 
                                                                                                      			selected-object="OffSiteReplaceTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                      			title-field="name" minlength="1" 
                                                                                                                input-class="form-control form-control-small" match-class="highlight" 
                                                                                                              
                                                                                                              input-changed="OffSiteReplaceTreeSpecieInputChanged"
                                                                                                              initial-value="OffSiteReplaceTree.init_specieSelected" 
                                                                                                                >
                                                                                                      </div>
                                                                                                    </div>
                                                                                                 <!--- End ----  angucomplete-alt --->
                                                                                             
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                            
                                                                                       <!--- planting date --->
                                                                                        <td class="frm left middle" style="width:75px;">
                                                                                        
                                                                                        
                                                                                                        <datepicker date-format="MM/dd/yyyy" date-typer="true" >
                                                                                                              
                                                                                                                    <input ng-model="OffSiteReplaceTree.planting_date" type="text" style="width:75px;"
                                                                                                                    
                                                                                                                        class="center roundedsmall"
                                                                                                                     ng-change="date_changed(OffSiteReplaceTree)"  
                                                                                                                     />
                                                                                                        </datepicker>
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                                        
                                                                                       <!--- start watering date --->
                                                                                        <td class="frm left middle" style="width:75px;">
                                                                                        
                                                                                        <!--- {{OffSiteReplaceTree.planting_date}}  --->
                                                                                        <input   type="text" 
                                                                                                      class="center roundedsmall"
                                                                                                value="{{OffSiteReplaceTree.planting_date}}" style="width:75px;"  disabled />
                                                                                        
                                                                                         <!---
                                                                                           
                                                                                        
                                                                                       
                                                                                                        <datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                              
                                                                                                                    <input ng-model="start_watering_date" type="text" style="width:75px;" />
                                                                                                        </datepicker>
                                                                                          --->              
                                                                                                        
                                                                                                        
                                                                                        </td>
                                                                                        <td style="width:2px;"></td>
                                                                                        
                                                                                        
                                                                            
                                                                            
                                                                                         <!---   parkway_size   --->
                                                                                          <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                 <input ng-model="OffSiteReplaceTree.parkway_size" type="Text" 
                                                                                                 name="off_site_parkway_size" id="_off_site_parkway_size" value="" 
                                                                                                 style="width:50px;height:20px;padding:0px;" class="center roundedsmall" >
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                         <!---   overhead_wires   --->
                                                                                         <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                        <!---     angular selection component  --->
                                                                                                                    
																												<select ng-model="OffSiteReplaceTree.overhead_wire" ng-options="item for item in overhead_wires"
                                                                                                                 name="off_site_overhead_wire" id="_off_site_overhead_wire" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;" >
																												   
																												</select>
																										<!---  ---  End ----  angular selection component  ---> 
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                                          
                                                                            
                                                                            
                                                                            
                                                                                        <!--- sub position  --->
                                                                            			        <td class="frm left middle" style="width:50px;height:20px;">
                                                                                                
                                                                                                <input ng-model="OffSiteReplaceTree.sub_position" type="Text" 
                                                                                               name="off_site_replace_tree_sub_position" id="_off_site_replace_tree_sub_position" value="" 
                                                                                               style="width:50px;height:20px;" class="roundedsmall" >
                                                                                                
                                                                                                
                                                                                                <!---
																									 <!---     angular selection component  --->
                                                                                                                      <!--- Does not work with 's'  ng-model="sub_positions"--->
																												<select ng-model="sub_position" ng-options="item for item in sub_positions"
                                                                                                                 name="off_site_sub_position" id="_off_site_sub_position" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;" >
																												
																												</select>
																										<!---  ---  End ----  angular selection component  ---> 
																							      --->			
																										
																										
																								</td>   
                                                                            
                                                                            
                                                                            
                                                                            
                                                                                        <!---  concrete_completed  --->
                                                                            			<td class="frm left middle" style="width:50px;height:20px;">
                                                                                        
                                                                                                           <select ng-model="OffSiteReplaceTree.concrete_completed" ng-options="item for item in concrete_completeds"
                                                                                                                 name="off_site_concrete_completed" id="_off_site_concrete_completed" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;" >
																												        
																												</select>
                                                                                                 
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                            
                                                                            
                                                                                         <!--- post_inspected  --->
                                                                            			<td class="frm left middle" style="width:50px;height:20px;">
                                                                                        
                                                                                                               <select ng-model="OffSiteReplaceTree.post_inspected" ng-options="item for item in post_inspecteds"
                                                                                                                 name="off_site_post_inspected" id="_off_site_post_inspected" class="roundedsmall" 
                                                                                                                 style="width:50px;height:20px;" >
																												      
																												</select>
                                                                                        
                                                                                                
                                                                                               
                                                                                          </td>
                                                                                          <td style="width:2px;"></td>
                                                                                          
                                                                                          
                                                                     						<td class="frm left middle" >
                                                                                                <input ng-model="OffSiteReplaceTree.note" type="Text" 
                                                                                               name="off_site_replace_tree_note" id="_off_site_replace_tree_note" value="" 
                                                                                               style="height:20px;padding:0px 2px 0px 4px;" class="roundedsmall" >
                                                                                            </td>	
                                                                                        
                                                                    
                                                                    
                                                                           </tr>  <!--- end of ng-repeat   --->            
                                                   			 </table>
                                                    
                                                     </td>
                                                </tr>
                                        
                                        
                                    <div>   <!--- off site replace --->
                                                                      <!---                       End OFF site tree replacement planting                       --->
        
    
    
   
    
		                            <!---  All Site Notes --->
		
                                                            <tr>
                                                                <td style="padding:0px;" colspan="2">
                                                             
                                                                                    <div>
                                                                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                                        
                                                                                        
                                                                                            <tr>
                                                                                                <th class="drk left middle" colspan="11" style="height:12px;padding:0px 0px 0px 0px;">
                                                                                                </th>
                                                                                            </tr>
                                                                                            <tr><td style="height:2px;"></td></tr>
                                                                                            
                                                                                            <tr><td style="height:2px;"></td></tr>
                                                                                            <tr><th class="left middle" colspan="11" style="height:20px;">
                                                                                                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                                                                                                <tr>
                                                                                                    <th class="left middle" style="padding:1px 0px 0px 0px">Site Notes:</th>
                                                                                                    <!---
                                                                                                	<td class="right" style="padding:0px;">
                                                                                                        <a href="" onClick="expandTextArea('tree_trn',4,14);return false;" 
                                                                                                        style="position:relative;top:1px;right:8px;">
                                                                                                        <img src="../images/fit.png"
                                                                                                         width="13" height="13"  title="Expand to View All Text">
                                                                                                         </a>
                                                                                                 	</td>
																									--->
																									
                                                                                                 </tr>
                                                                                                </table>
                                                                                            </th></tr>
                                                                                            <tr><td style="height:2px;"></td></tr>
                                                                                            
                                                                                            <tr>
                                                                                                 <!---
                                                                                                <cfset v = ""><cfif trim(getTreeInfo.tree_removal_notes) is not "">
                                                                                                <cfset v = trim(getTreeInfo.tree_removal_notes)></cfif>
																								--->
                                                                                                <td class="frm" colspan="11" style="height:180px;">
                                                                                                <textarea ng-model="site_note" id="tree_trn" class="rounded" style="position:relative;top:0px;left:2px;width:936px;height:180px;"></textarea>
                                                                                                </td>
                                                                                            </tr>
                                                                                            
                                                                                        </table>
                                                        
                                                                                    </div>
                                                                
                                                                </td>
                                                            </tr>
                                                            
                                    <!---   End All Site Notes --->          
                                                            
                                     
                                            
                                                           
                                                               
                                                              
                                                               
                                                           
                                            
                                            
                                                            
                                                            
                                              			</div>      <!--- all tree div --->
                                              		</td>
                                              	</tr>
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                     
                                             <!---        ---------  END   ---- all tree sectin  ----------------          --->
                                     
                                     
                                     
                                     
                                     
                                                            
                                    <!---  .............. end of title button, top info bar  .................... --->                        
		                  
                          
                          
                           <!--- /table --->
                       </div>
                          
                       
	               </td>
	             </tr>
	
    
	                  </form>
                         <!--- /table --->
                       </div>
                       
                <!---   ********************        end tree 'form7' box                 **********************       --->
    
    
    
    
   
    
    
    
    
    
   			 </div>   <!--- ng-app: tree-app  --->
    
    
    
    
    
     														
   
    
                                                           
    
    
    </body>
    
    
     
    
</cfoutput>

<cfset ro = 0>
<cfif session.user_level gt 0 AND session.user_power gte 0><cfset ro = 1></cfif>

<script>

			<cfoutput>
					var url = "#request.url#";
					
					var sid = #url.sid#;
					
					var address = '#getSite.address#';
					
					
					
					
					
					var _primary_key_id = #url.primary_key_id#;
					var _type_id = #url.type_id#;
					var _package_no = #url.package_no#;
					var _site_id = #url.sid#;
					var _cd = #url.cd#;
					
					<cfif url.crm_no eq "">
					  var _crm_no = "";
					<cfelse>
					  var _crm_no = "#url.crm_no#";    <!---  crm_no is string varchar, so must use "", if int, no ""  --->
					</cfif>
					
					
					<cfif url.rebate eq "">
					 var _rebate =  "";
					<cfelse>
					  var _rebate = "#url.rebate#";   <!---  crm_no is string varchar, so must use "", if int, no ""  --->
					</cfif>
			
			</cfoutput>
			
</script>





<!---    ----- not use as production, only testing  for  display json output only    ---------    --->

<script>


function output(inp) {
    //document.body.appendChild(document.createElement('pre')).innerHTML = inp;
	$('#return_json').html(inp);
	
}

function syntaxHighlight(json) {
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
            } else {
                cls = 'string';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
        } else if (/null/.test(match)) {
            cls = 'null';
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}




</script>

<style>
  pre {outline: 1px solid #ccc; padding: 5px; margin: 5px; }
.string { color: green; }
.number { color: darkorange; }
.boolean { color: blue; }
.null { color: magenta; }
.key { color: red; }

</style>



<!--- End ---------------------  not use as production, only testing  for  display json output only --->



</html>


            

				

	


