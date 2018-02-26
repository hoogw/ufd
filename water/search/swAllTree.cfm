


<!doctype html>          <!---  Must have, otherwise ng-grid display will mess up--->

<cfoutput>
		<cfif isdefined("session.userid") is false>
            <script>
               top.location.reload();
            
            </script>
            <cfabort>
            
             <cfelse>
            
                <cfset _user_id = session.user_num>   
            <script>
			
			     var user_id = #_user_id#;
				 
            </script>
            
            
            
		</cfif>

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




<cfoutput>


					                     <!---  **********************  Get tree numbers  ********************   --->
                                                 <cfquery name="search_tree_all" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                                                Select count(*) as total from vw_search_tree where deleted = 0
                                                 </cfquery>
                                                 
                                                  <cfset all_tree_total = search_tree_all.total >
                                                 
                    
                                               <!---
                                                  <cfloop query = "search_tree_all"> 
                                                      <cfset all_tree_total = total >
                                                  </cfloop>
                                               --->
                                               
                                               
                                                <cfquery name="Between_7_to_10" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                                                Select count(*) as total from vw_search_tree where deleted = 0 and days_since_last_water >= 7 
                                         and days_since_last_water <= 10
                                                 </cfquery>
                                                 
                                                  <cfset Between_7_to_10_total = Between_7_to_10.total >
                                               
                                               
                                               
                                               
                                               <cfquery name="more_than_10" datasource="#request.sqlconn2#" dbtype="ODBC" >
                                                                Select count(*) as total from vw_search_tree where deleted = 0 and days_since_last_water > 10 
                                         
                                                 </cfquery>
                                                 
                                                  <cfset more_than_10_total = more_than_10.total >
                           
                          
                           
                           
                                                <!---  *************     End    *********  Get tree numbers  ********************   --->



<html >
   <head>
    <title>watering</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    
        
    
                
    
            
            <cfinclude template="../css/css.cfm">
         
            
             <!--- angular --->
            
            <!---
            <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.js"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-touch.js"></script>
            <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-animate.js"></script>
            --->
			
            <script src="../js/angularjs.1.5.0/angular.min.js"></script>
			<script src="../js/angularjs.1.5.0/angular-touch.min.js"></script>
            <script src="../js/angularjs.1.5.0/angular-animate.min.js"></script>
            
            
            
            
             			<!--- ui-grid angular --->
                        
                        <!---
                        
                             <!--- Exporter to excel, csv, pdf, slow unstable change to local    --->
							<script src="http://ui-grid.info/docs/grunt-scripts/csv.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/pdfmake.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/vfs_fonts.js"></script>
						
							 <!--- export for excel only --->
							<script src="http://ui-grid.info/docs/grunt-scripts/lodash.min.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/jszip.min.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/excel-builder.dist.js"></script>
							 <!--- export for excel only --->
                             
							<!--- End --- Exporter to excel, csv, pdf, slow unstable change to local   --->
                            
                        --->
                               <!--- local for fast load  ui-grid --->
                           
                             
                             <!---
                             <script src="../js/ui-grid.info/docs/grunt-scripts/csv.js"></script>
                            <script src="../js/ui-grid.info/docs/grunt-scripts/pdfmake.js"></script>
                            <script src="../js/ui-grid.info/docs/grunt-scripts/vfs_fonts.js"></script>
							--->
                            <script src="../js/csv-js/csv.js"></script>
                            <script src="../js/pdfmake/pdfmake.min.js"></script>
                             <script src="../js/pdfmake/vfs_fonts.js"></script>
                            
                         
                            <!---   local ---- export for excel only --->
                            <script src="../js/lodash/4.17.4/lodash.min.js"></script>
                            <script src="../js/jszip/jszip.min.js"></script>    
                             <script src="../js/excel-builder/excel-builder.dist.min.js"></script> 
                            
                            <!---    local ---- export for excel only --->
                        
                        
                        
                        
                       <!--- 
                        <!---  current 4.0.11 with angular 1.5.0 will get error   --->
                         	<script src="http://ui-grid.info/release/ui-grid.js"></script>
                           	<link rel="stylesheet" href="http://ui-grid.info/release/ui-grid.css" type="text/css">
                        
                        
						 	<script src="https://cdn.rawgit.com/angular-ui/bower-ui-grid/master/ui-grid.min.js"></script>
                        	<link rel="stylesheet" href="https://cdn.rawgit.com/angular-ui/bower-ui-grid/master/ui-grid.min.css" type="text/css">
                           
                        --->
                        	
                             <script src="../js/ui-grid.info/4.0.7/ui-grid.min.js"></script>
                             <link rel="stylesheet" href="../js/ui-grid.info/4.0.7/ui-grid.min.css" type="text/css">
                        
                        
                        
                        <link rel="stylesheet" href="../css/ng-grid.css">  
                        
                        
                           
                            
                          
                          
                          
                            <!---   --------------- for  Date range  filter  ------------ --->
                          
                          
                          <!---
                          	 <script src="https://cdn.jsdelivr.net/lodash/4.6.1/lodash.js"></script>
                             
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.3.2/ui-bootstrap.min.js"></script>    <!--- include default template   --->
    						<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.3.2/ui-bootstrap-tpls.min.js"></script>
							
							 
							
       <link data-require="bootstrap-css@*" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
                            
                            
   							 <script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.0.7/angular-material.min.js"></script>
							
							 
                           <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/angular_material/1.0.7/angular-material.min.css" />
						   --->
						   
						   
                           
                               <!---  local  --->
                          		  <!--- 	 <script src="../js/lodash/4.17.4/lodash.min.js"></script>   --->
                           
									   <!--- angular UI bootstrap  --->
											<script src="../js/angular_ui_bootstrap/ui-bootstrap-2.5.0.min.js"></script>       <!--- include default template   --->
                                              <script src="../js/angular_ui_bootstrap/ui-bootstrap-tpls-2.5.0.min.js"></script>                          
                                        <!--- <link data-require="bootstrap-css@*" data-semver="3.3.7" rel="stylesheet"  href="../js/bootstrap-3.3.7-dist/css/bootstrap.css">   --->
                                     
                                         <link  rel="stylesheet"  href="../js/bootstrap-3.3.7-dist/css/bootstrap.css"> 
                                          
                                     <!--- angular_material  --->
                                     
                                          
                                              <script src="../js/angular_material/1.1.5/angular-material.min.js"></script>                          
                                            <link rel="stylesheet" href="../js/angular_material/1.1.5/angular-material.min.css">    
                                     
                              <!---  End --- local  --->  
                              
                              
                              
                           <!---     ------  End -------   for    Date range  filter  --->
                           
                           
                           
            <!---End  angular --->
            
            
            
            
            <!---   720kb/angular-datepicker    --->
                <link href="../css/angular-datepicker.css" rel="stylesheet" type="text/css" />
                <script src="../js/angular-datepicker.js"></script>
                <script src="../js/moment.min.js"></script>
   
   
   
   
            
            
						<!---   modal  --->
                        
                          
                          
                          <script src="../js/jquery/jquery-3.2.1.min.js"></script>
                          
                          <!--- slow unstable change to local
                          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
                          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                          --->
						
                          <link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">        
                         <script language="JavaScript" src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
                        
                         <!--- End   modal  --->
             
            
            
            <!--- must load after jquery loaded.  jquery redirect = window.location.replace  with post json data --->
                    <script src="../js/jquery/jquery.redirect.js"></script>
            
            
            
            
            
            <!--- our js --->
            <script language="JavaScript" src="../js/swAllTree.js"></script>
          
          
          
          
          <link rel="shortcut icon" href=""> <!--- fix favicon.ico 404 not found error  --->
	</head>


<!---
		

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

--->


<cfparam name="url.dmt" default="0" />
<cfparam name="url.dlt" default="0" />
<cfset days_more_than = url.dmt />
<cfset days_less_than = url.dlt />




<cfset flw = "style='overflow:auto;'"><cfif shellName is "Handheld"><cfset flw="style='overflow:auto;'"></cfif>


<!--- body background="../images/tree2.jpg" alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw#  --->
<body style="background:url('../images/tree.jpg');" alink="darkgreen" vlink="darkgreen" bottommargin="0" marginheight="0" topmargin="2" rightmargin="0" #flw# >

 

<div ng-app="app">

                 <!---
                 
                  <div ng-controller="ModalDemoCtrl as $ctrl" class="modal-demo">
						<script type="text/ng-template" id="myModalContent.html">
                            <div class="modal-header">
                                <h3 class="modal-title" id="modal-title">I'm a modal!</h3>
                            </div>
                            <div class="modal-body" id="modal-body">
                                <ul>
                                    <li ng-repeat="item in $ctrl.items">
                                        <!--- a href="#" ng-click="$event.preventDefault(); $ctrl.selected.item = item">{{ item }}</a --->
                                    </li>
                                </ul>
                                Selected: <b>{{ $ctrl.selected.item }}</b>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">OK</button>
                                <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">Cancel</button>
                            </div>
                        </script>
                        <script type="text/ng-template" id="stackedModal.html">
                            <div class="modal-header">
                                <h3 class="modal-title" id="modal-title-{{name}}">The {{name}} modal!</h3>
                            </div>
                            <div class="modal-body" id="modal-body-{{name}}">
                                Having multiple modals open at once is probably bad UX but it's technically possible.
                            </div>
                        </script>
                    
                        <button type="button" class="btn btn-default" ng-click="$ctrl.open()">Open me!</button>
                        <button type="button" class="btn btn-default" ng-click="$ctrl.open('lg')">Large modal</button>
                        <button type="button" class="btn btn-default" ng-click="$ctrl.open('sm')">Small modal</button>
                        <button type="button" 
                            class="btn btn-default" 
                            ng-click="$ctrl.open('sm', '.modal-parent')">
                                Modal appended to a custom parent
                        </button>
                        <button type="button" class="btn btn-default" ng-click="$ctrl.toggleAnimation()">Toggle Animation ({{ $ctrl.animationsEnabled }})</button>
                        <button type="button" class="btn btn-default" ng-click="$ctrl.openComponentModal()">Open a component modal!</button>
                        <button type="button" class="btn btn-default" ng-click="$ctrl.openMultipleModals()">
                            Open multiple modals at once 
                        </button>
                        <div ng-show="$ctrl.selected">Selection from a modal: {{ $ctrl.selected }}</div>
                        <div class="modal-parent">
                        </div>
                    </div>
                             
                 
                 --->



	<div  ng-controller="MainCtrl" id="searchbox" style="display:block;">



                                 
                                 <!--- ------------------  head line -------------------------  --->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                      <tr>
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                              <tr><td height="0"></td></tr>
                                              <tr>
                                                    <td align="center" class="pagetitle"  style="position:relative;top:10px;color:white;">
                                                    
                                                      
                                                      <cfif days_more_than GT 0 AND days_less_than EQ 0>
                                                       
                                                           
                                                           
                                                             <a href="swAllTree.cfm">
                                                               <font size ="1" color="white"> All Tree (#all_tree_total#) </font>
                                                             </a>
                                                             
                                                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                             <a href="swAllTree.cfm?dmt=7&dlt=10">
                                                              <font size ="1" color="white"> 7 - 10 days (<font size ="1" color="red">#Between_7_to_10_total#</font>)  </font> 
                                                             </a>
                                                             
                                                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                              > <font size="6" color="red">#days_more_than# </font> Days (<font size="4" color="red">#more_than_10_total#</font>)
                                                           
                                                           
                                                      </cfif>
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                    
                                                        <cfif days_less_than GT 0 AND days_more_than GT 0>
                                                          
                                                          
                                                          <a href="swAllTree.cfm">
                                                               <font size ="1" color="white"> All Tree (#all_tree_total#) </font>
                                                             </a>
                                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                          
                                                          
                                                           <font size="6" color="red">#days_more_than# </font> ~ <font size="6" color="red">#days_less_than# </font>Days (<font size="4" color="red">#Between_7_to_10_total#</font>)  
                                                          
                                                           
                                                             
                                                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                             <a href="swAllTree.cfm?dmt=10">
                                                             <font size ="1" color="white">  > 10 days (<font size="1" color="red">#more_than_10_total#</font>) </font> 
                                                              </a>
                                                      
                                                      
                                                          
                                                        </cfif>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <cfif days_more_than EQ 0 AND days_less_than EQ 0>
                                                            <font  color="red">All </font> Tree (#all_tree_total#) 
                                                            
                                                             		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                     <a href="swAllTree.cfm?dmt=7&dlt=10">
                                                                      <font size ="1" color="white"> 7 - 10 days (<font size ="1" color="red">#Between_7_to_10_total#</font>)  </font> 
                                                                     </a>
                                                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                     <a href="swAllTree.cfm?dmt=10">
                                                                     <font size ="1" color="white">  > 10 days (<font size="1" color="red">#more_than_10_total#</font>) </font> 
                                                                      </a>
                                                        </cfif>
                                                    
                                                    <!---
                                                    
                                                    <!---  ----------  quick navigation link  --------------  --->
                                                    
                                                    
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                     <a href="swAllTree.cfm">
                                                       <font size ="1" color="white"> All Tree (#all_tree_total#) </font>
                                                     </a>
                                                     
                                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                     <a href="swAllTree.cfm?dmt=7&dlt=10">
                                                      <font size ="1" color="white"> 7 - 10 days (<font size ="1" color="red">#Between_7_to_10_total#</font>)  </font> 
                                                     </a>
                                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                     <a href="swAllTree.cfm?dmt=10">
                                                     <font size ="1" color="white">  > 10 days (<font size="1" color="red">#more_than_10_total#</font>) </font> 
                                                      </a>
                                                    
                                                    <!---  ----------  End ----------  quick navigation link  --------------  --->
                                                    
                                                    --->
                                                    
                                                    </td>
                                              </tr>
                                              <tr><td height="12"></td></tr>
                                            </table>
                                        </td>
                                      </tr>
                                    </table>
                                  <!--- ------------------   end head line -------------------------  --->
            
            
            
         
         <!---   
            
            
						<!--- ------------------ top filter box -------------------------  --->
                        
                        <table cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="width:850px;">
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
                                                <td class="frm"  style="width:168px;">
                                                <select name="ss_type" id="ss_type" class="roundedsmall" style="width:163px;height:20px;padding:0px 0px 0px 4px;">
                                                <option value=""></option>
                                                <cfloop query="getType">
                                                    <option value="#id#">#type#</option>
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
                                                <td class="frm" style="width:189px;">
                                                <input type="Text" name="ss_name" id="ss_name" value="" style="width:184px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:50px;">Address:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:247px;">
                                                <input type="Text" name="ss_address" id="ss_address" value="" style="width:242px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
                                                
                                                
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:50px;">Zip Code:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:60px;">
                                                <input type="Text" name="ss_zip" id="ss_zip" value="" style="width:55px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
                                                
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:58px;">Priority No:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:55px;">
                                                <input type="Text" name="ss_pn" id="ss_pn" value="" style="width:50px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
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
                                                <th class="left middle" style="width:100px;">Site Deleted:</th>
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
                                                <th class="left middle" style="width:107px;">Curb Ramp Only:</th>
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
                                                
                                                
                                                <th class="left middle" style="height:22px;width:81px;">Work Order:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:162px;">
                                                <input type="Text" name="ss_wo" id="ss_wo" value="" style="width:157px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:77px;">Keyword:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:152px;">
                                                <input type="Text" name="ss_keyword" id="ss_keyword" value="" style="width:147px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"></td>
                        
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:100px;">Has Before Image:</th>
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
                                                <th class="left middle" style="width:107px;">Has After Image:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm"  style="width:55px;">
                                                <select name="ss_hasA" id="ss_hasA" class="roundedsmall" style="width:50px;height:20px;padding:0px 0px 0px 4px;">
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
                                                <th class="left middle" style="height:22px;width:132px;">Assessed Date:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:267px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
                                                <span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
                                                <!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_assfrm" id="ss_assfrm" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
                                                <span class="page">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_assto" id="ss_assto" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
                                                
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_assfrm" id="ss_assfrm" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_assto" id="ss_assto" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('ass');">
                                                <cfset chk = ""><cfif isdefined("session.ss_assnull")><cfset chk = "checked"></cfif>
                                                <input type="checkbox" name="ss_assnull" id="ss_assnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('ass');" #chk#>
                                                <span class="page" style="position:relative;top:-1px;">Is Null</span>
                                                
                                                </td>
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:149px;">QC Date:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:267px;">
                                                <!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_qcfrm" id="ss_qcfrm" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
                                                <span class="page">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_qcto" id="ss_qcto" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
                                                
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_qcfrm" id="ss_qcfrm" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('qc');">
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_qcto" id="ss_qcto" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('qc');">
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
                                                <th class="left middle" style="height:22px;width:132px;">Construction Started Date:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:267px;"><!--- <input type="Text" name="ss_assdt" id="ss_assdt" value="" style="width:75px;" class="rounded">
                                                <span class="page">&nbsp;<strong>OR</strong>&nbsp;</span> --->
                                                <!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_consfrm" id="ss_consfrm" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
                                                <span class="page">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_consto" id="ss_consto" value="" style="width:97px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
                                                
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_consfrm" id="ss_consfrm" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('cons');">
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_consto" id="ss_consto" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('cons');">
                                                <cfset chk = ""><cfif isdefined("session.ss_consnull")><cfset chk = "checked"></cfif>
                                                <input type="checkbox" name="ss_consnull" id="ss_consnull" style="position:relative;top:2px;left:4px;" value="" onChange="clearFlds('cons');" #chk#>
                                                <span class="page" style="position:relative;top:-1px;">Is Null</span>
                                                
                                                </td>
                                                <td style="width:2px;"></td>
                                                <th class="left middle" style="width:149px;">Construction Completed Date:</th>
                                                <td style="width:2px;"></td>
                                                <td class="frm" style="width:267px;">
                                                <!--- <span class="page">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_concfrm" id="ss_concfrm" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall">
                                                <span class="page">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_concto" id="ss_concto" value="" style="width:82px;height:20px;padding:0px 0px 0px 4px;" class="roundedsmall"> --->
                                                
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;From:&nbsp;</span>
                                                <input type="Text" name="ss_concfrm" id="ss_concfrm" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('conc');">
                                                <span class="page" style="position:relative;top:-2px;">&nbsp;&nbsp;To:&nbsp;</span>
                                                <input type="Text" name="ss_concto" id="ss_concto" value="" style="width:60px;height:20px;padding:0px 0px 0px 4px;position:relative;top:-2px;" class="roundedsmall" onChange="clearChk('conc');">
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


--->





                                    <table align=center border="0" cellpadding="0" cellspacing="0" style="width:100%;">
                                        <tr><td height="15" colspan="10"></td></tr>
                                        <tr>
                                            <!--- <td><div style="visibility:hidden;"><img src="../images/excel.gif" width="16" height="16" alt="">
                                            <img src="../images/excel.png" width="17" height="17"></div></td> --->
                                            
                                          
                                               
                                            <td align="center">
                                            
                                            &nbsp; &nbsp;
                                                <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                ng-click="toggleFiltering()">Filter Column</a>
                                                
                                               &nbsp; &nbsp; 
                                                <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                ng-click='filter()'>Filter</a>
                                                
                                             <!---   <button ng-click='filter()'  >Filter</button> --->
                                                
                                                &nbsp; &nbsp;
                                           		<input ng-model='filterValue' 
                                                
                                                style="width:300px;"
                                                placeholder="Filter All Column By ... "
                                                
                                                />
                                                
                                                &nbsp; &nbsp;
                                                <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                ng-click="watering_selected_row()">Water</a>
                                                
                                                &nbsp; &nbsp;
                                                <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                ng-click="clear()">Clear</a>
                                                
                                            </td>
                                            
                                            
                                            
                                            <!--- <td style="text-align:right;"><img id="dlExcel" style="position:relative;top:8px;right:15px;visibility:hidden;" src="../images/excel.png" width="16" height="16" title="Download Search Results to Excel" onclick="downloadExcel();" onmouseover="this.style.cursor='pointer';">
                                            <a href="../reports/SiteSearch.cfm" target="_blank"><img id="dlPDF" style="position:relative;top:9px;right:12px;visibility:hidden;" src="../images/pdf_icon.gif" width="17" height="17" title="View Search Results PDF"></a></td> --->
                                        </tr>
                                        
                                           
                                        
                                        
                                    </table>
            
            
            
             <!--- ------------------  End top filter box -------------------------  --->
            
            
            </br>
            
            
            
            
            
                  
            
            
            
            
            
            
            
            					<!---  -------------------   ng-grid   ------------------   --->
            
            
                              <div  cellspacing="0" cellpadding="0" border="0" class="frame" align="center" style="background-color: white; ">   
                                               
                                               <!---  
                                         	 	<button ng-click='filter()'  >Filter</button>
                                           		<input ng-model='filterValue' />
                                                
                                                
                                           
                                            	<button id='toggleFiltering' ng-click="toggleFiltering()" style="float: right;" class="btn btn-success">Filter by column</button>  
												--->
												
												
                                           
                                          <!---  with cell edit    <div id="grid" ui-grid="gridOptions" ui-grid-exporter ui-grid-selection ui-grid-edit ui-grid-row-edit ui-grid-cellNav >    --->
                                                
                                                <div id="grid" ui-grid="gridOptions" style="height:800px;" ui-grid-exporter ui-grid-selection>     
                                                
                                               <!--- <div id="grid" ui-grid="gridOptions"  ui-grid-exporter ui-grid-selection>  --->
                                                </div>
                                       
                                        </div>   
                                    
                                        
            					<!---  -------------------   End ng-grid   ------------------   --->                        
                                    
                                    
                                    
                                    
                                      <!---   ~~~~~~~~~ double click row Modal ~~~~~~~~~~~~~~~~ --->
                                  <div class="modal fade" id="double_click_row_modal" role="dialog">
                                    <div class="modal-dialog">
                                    
                                      <!-- Modal content-->
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                                          
                                          
                                           <table>
                                             <tbody>
                                                    <tr>
                                                        
                                                         <td><h6 class="modal-title">Tree ID : {{modal_tree_id}} </h6></td>
                                                    
                                                         <td>
                                                           &nbsp; &nbsp; &nbsp; &nbsp; 
                                                        </td>
                                                    
                                                        <td><h6 class="modal-title">Previous Watering Date &nbsp;  </h6></td>
                                                        <td>
                                                          <input   type="text"  value="{{modal_previous_watering_date}}" style="width:75px;" 
                                                                                           class="center roundedsmall"
                                                                                                 disabled />
                                                        
                                                        </td>
                                                        
                                                        <td>
                                                           &nbsp; &nbsp; &nbsp; &nbsp; 
                                                        </td>
                                                        
                                                         <td> <h6 class="modal-title">  Current Watering Date &nbsp;  </h6></td>
                                                        <td>
                                                        
                                                             <datepicker date-format="MM/dd/yyyy" date-typer="true"  date-min-limit="{{modal_previous_watering_date}}">
                                                                                                              
                                                                 <input ng-model="modal_current_watering_date" type="text" style="width:75px;"
                                                                     
                                                                     
                                                                    class="center roundedsmall"/>
                                                 				</datepicker>
                                                        
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                            </table>
                                        
                                                    
                                         
                                        </div>
                                        <div class="modal-body">
                                        
                                       
                                               
                                                    
                                                     <tr>
                                                          <ul style="height: 120px; overflow: auto">
                                                      		<li ng-repeat=" opt in opts"  >
                                                                {{ opt.DATE }}
                                                            </li>
                                                         </ul>
                                                     </tr>
                                               
                                           
                                                 
                                                    
                                                   
                                             
                                        
                                        </div>
                                        <div class="modal-footer">
                                          <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="save_modal_watering_date()">Save</button>
                                        </div>
                                      </div>
                                      
                                    </div>
                                  </div>
                                  
                                </div>
                             <!---    ~~~~~~~~~ End ~~~~~~~~~~~~~   double click row Modal   ~~~~~~~~~~~~~~~~~~~  --->
                                    
                                    
                                    
                                    
                                    
                                    
                               <!---    only 1 modal can ng-binding, so this one merge with double_click_row_modal    ~~~~~~~~~   watering Modal ~~~~~~~~~~~~~~~~    --->
                               <!---
                                  <div class="modal fade" id="watering_date_modal" role="dialog">
                                    <div class="modal-dialog">
                                    
                                      <!-- Modal content-->
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                                          <h6 class="modal-title">Tree ID : {{modal_tree_id}} </h6>
                                        </div>
                                        <div class="modal-body">
                                        
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td><h6 class="modal-title">Previous Watering Date &nbsp;  </h6></td>
                                                        <td>
                                                          <input   type="text"  value="{{modal_previous_watering_date}}" style="width:75px;" 
                                                                                           class="center roundedsmall"
                                                                                                 disabled />
                                                        
                                                        </td>
                                                        
                                                        <td>
                                                           &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                                        </td>
                                                        
                                                         <td> <h6 class="modal-title">  Current Watering Date &nbsp;  </h6></td>
                                                        <td>
                                                        
                                                             <datepicker date-format="MM/dd/yyyy" date-typer="true"  date-min-limit="{{modal_previous_watering_date}}">
                                                                                                              
                                                                 <input ng-model="modal_current_watering_date" type="text" style="width:75px;"
                                                                     
                                                                     
                                                                    class="center roundedsmall"/>
                                                 				</datepicker>
                                                        
                                                        </td>
                                                    </tr>
                                                    
                                                   
                                                </tbody>
                                            </table>
                                        
                                        </div>
                                        <div class="modal-footer">
                                          <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="save_modal_watering_date()">Save</button>
                                        </div>
                                      </div>
                                      
                                    </div>
                                  </div>
                                  
                                </div>
								--->
                      <!---  ~~~~~~~~~~~~~~ End ~~~~~~~~~~~~~  only 1 modal can ng-binding, so this one merge with double_click_row_modal    ~~~~~~~~~   watering Modal ~~~~~~~~~~~~~~~~    --->
                                    
                                    
                                    
                                    
                                    
                                    
                                    <!---   ~~~~~~~~~  select 0 warning Modal ~~~~~~~~~~~~~~~~ --->
                                  <div class="modal fade" id="select_0_warning_modal" role="dialog">
                                    <div class="modal-dialog">
                                    
                                      <!-- Modal content-->
                                      <div class="modal-content">
                                      
                                       
                                      <!---
                                        <div class="modal-header">
                                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                                          
                                        </div>
                                       ---> 
                                       
                                        <div class="modal-body">
                                        
                                           <h6 class="modal-title">Selected Tree either is 0 or more than 200</h6>
                                          
                                        </div>
                                      
                                        
                                        
                                        <div class="modal-footer">
                                        
                                          <button type="button" class="btn btn-default" data-dismiss="modal" >Back</button>
                                        </div>
                                      </div>
                                      
                                    </div>
                                  </div>
                                  
                                </div>
                       <!---    ~~~~~~~~~   select 0 warning Modal   ~~~~~~~~~~~~~~~~~~~  --->
                                    
                                    
                       
                    </div>  <!--- MainController --->
                                    
                                    
                             
                    
                             
                             
                                    
                                    
                                     
                                    
                                    
                                 
                        

		</div>  <!--- ng-app --->
                    
                    
  
  
  
                           
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
	
                <div id="msg" class="box" style="top:40px;left:1px;width:300px;height:144px;display:none;z-index:505;">
                    <a id="close" href="" class="close" style="z-index:505;top:3px;right:4px;" 
                         onClick="$('#chr(35)#msg').hide();return false;"><img src="../images/close_icon.png" height="8" width="8" title="Close Tools"  border="0" class="closex"></a>
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
		
		
		var _days_more_than = #days_more_than#;
		var _days_less_than = #days_less_than#;
		
		</cfoutput>
		
		
		
</script>





</html>


    

				

	


