<!doctype html>          <!---  Must have, otherwise ng-grid display will mess up--->


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

<html lang="en" >
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1"  http-equiv="Content-Type">
 
<title>Tree and watering</title>

<cfoutput>


<!---  our js --->

         <!-- Angular Material requires Angular.js Libraries -->
         
         <!--- angular 1.6.4 --->
         
          <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
          <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular-animate.min.js"></script>
          <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular-aria.min.js"></script>
          <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular-messages.min.js"></script>
           
           
           <!---  angular_material/1.1.4     version 1.1.0 have bug datepicker mal - display inside ng-repeat or tab, card  --->
            <!-- Angular Material Library -->
          <script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.4/angular-material.min.js"></script>
           <!-- Angular Material style sheet -->
           <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.4/angular-material.min.css">
           
          
		 
		 <!---
		<!---   angucomplete-alt auto complete    not in use,  --->
    <script language="JavaScript" src="../js/angucomplete-alt.min.js"></script>
         
    <link href="../css/angucomplete-alt.css" rel="stylesheet" type="text/css" />
            --->
             
        
        <script language="JavaScript" src="../js/species.js"></script>   
        
       
        <script language="JavaScript" src="../js/swTreeCreate_md.js"></script>
        
         <!---
        <link rel="stylesheet" href="../css/md.css">
         --->
        

          <link rel="shortcut icon" href=""> <!--- fix favicon.ico 404 not found error  --->






<!--- End our js --->

       
</head>




<cfparam name="url.sid" default="312">
<cfparam name="url.pid" default="0">
<cfparam name="url.search" default="false">
<cfparam name="url.crid" default="0">
<cfparam name="url.crsearch" default="false">

<!--- Get Site --->
<cfquery name="getSite" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM tblSites WHERE id = #url.sid#
</cfquery>


<!--- Get program type --->
<cfquery name="getProgramType" datasource="#request.sqlconn2#" dbtype="ODBC">
SELECT id, type FROM program_type WHERE id = #url.type_id#
</cfquery>





<cfif url.search is true><cfset url.pid = 0></cfif>




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



                  <div ng-app="app" ng-cloak="" class="tabsdemoDynamicHeight" >
                     <!--- <div ng-controller="DemoCtrl as vm" layout="column" ng-cloak class="md-inline-form">      for sample 1 auto-complete --->
                     <div ng-controller="DemoCtrl as ctrl" layout="column" ng-cloak class="md-inline-form">
                  
                  
                  
                  
                  
                  
                          <md-toolbar class="md-primary" md-colors="{background: 'green'}" >
                                <div class="md-toolbar-tools">
                                  <h6 class="md-flex">
                                  
                                        #getProgramType.type#  &nbsp;|&nbsp; Package :	#url.package_no#	&nbsp;|&nbsp;
                                                                                                    
                                                                                                    Site : #getSite.location_no#  
                                                                                                    
                                                                                                   <!--- &nbsp;|&nbsp;   #getSite.name#  --->
                                                                                                    &nbsp;|&nbsp;   #getSite.address#  
                                  
                                  </h6>
                                </div>
                              </md-toolbar>
                  
                   
             <form name="treeForm">       
                  
                  
             <!--- tab structure  start --->
                  
                  <md-content>
                        <md-tabs md-dynamic-height="" md-border-bottom="">
                        
                        
                        <!--- tab remove --->
                        
                          <md-tab label="Remove ({{RemoveTreeList.length}})">
                              
                              
                            <md-content class="md-padding">
                            
                            
                               
                                
                              
                                   <!--- tab remove content --->
                                   
                                   
                                           <md-card >
                                               
                                               
                                                <md-card-title>
                                                  <md-card-title-text>
                                                  
                                                    <md-subheader class="md-primary">Remove Tree ({{RemoveTreeList.length}})</md-subheader>
                                                   <!--- <span class="md-headline">Remove Tree</span>   --->
                                                  </md-card-title-text>
                                                </md-card-title>
                                                
                                                
                                                
                                                  
                                                                      
                                                                      
                                                                     
                                                                       
                                                                      
                                                                      <div ng-repeat="RemoveTree in RemoveTreeList">  
                                                                        
                                                                              <md-card-content>
                                                                            
                                                                        
                                                                                        <div layout-gt-xs="row" >
                                                                                        
                                                                                        
                                                                                                     <md-button class="md-fab md-mini" md-colors="{background: 'lime'}" aria-label="Tree No">
                                                                                                     
                                                                                                        {{$index +1}}
                                                                                                    
                                                                                                    </md-button>
                                                                                        
                                                                                        
                                                                                                      <md-input-container>
                                                                                                        <label>Location</label>
                                                                                                        <input ng-model="RemoveTree.location">
                                                                                                      </md-input-container>
                                                                                                
                                                                                                    
                                                                                                        
                                                                                                        <!---
																								    <md-input-container>
                                                                                                        <label>Species</label>
                                                                                                        
                                                                                                        
                                                                                                        <!---    angucomplete-alt     --->
                                                                                                         
                                                                                                              <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100"
                                                                                                               selected-object="RemoveTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                               title-field="name" minlength="1" input-class="form-control form-control-small"
                                                                                                                match-class="highlight">
                                                                                                              </div>
                                                                                                          
                                                                                                         <!--- End ----  angucomplete-alt --->
																										</md-input-container>
                                                                                                        --->
                                                                                                        
                                                                                                        
                                                                                                        <!---
                                                                                                          
                                                                                                         <!---  ---- md-autocomplete --------  sample 1 https://jsfiddle.net/hoogw/Lctcxjqr/257/ --->
                                                                                                            <md-input-container>
                                                                                                                <md-autocomplete flex required
                                                                                                                       
                                                                                                                       
                                                                                                                      md-selected-item="selectedItem" 
                                                                                                                      md-search-text="searchText" 
                                                                                                                      md-items="item in vm.getMatches(searchText)" 
                                                                                                                      md-item-text="item.name" placeholder="Search states" 
                                                                                                                      md-no-cache="true">
                                                                                                                      
                                                                                                                    <md-item-template>
                                                                                                                        <span>{{item.abbreviation}} - </span>
                                                                                                                        <span md-highlight-text="searchText" md-highlight-flags="^i">{{item.name}}</span>
                                                                                                                    </md-item-template>
                                                                                                                    
                                                                                                                    <md-not-found>
                                                                                                                        No matches found.
                                                                                                                    </md-not-found>
                                                                                                                    
                                                                                                                </md-autocomplete>
                                                                                                             </md-input-container>
                                                                                                         <!---  ---- End --------  md-autocomplete --------  --->
                                                                                                        
                                                                                                         --->
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                           <!---  <md-autocomplete flex required  --->   
																										   <!--- flex means fill length of row, required means required field --->  
                                                                                                           
                                                                                                            <md-autocomplete 
                                                                                                                md-input-name="specie" 
                                                                                                                md-input-minlength="10"
                                                                                                                md-input-maxlength="18"
                                                                                                                
                                                                                                                                                                                                                        
                                                                                                                 md-no-cache="true"
                                                                                                                 md-selected-item="RemoveTree.selectedItem" 
                                                                                                                 md-search-text="RemoveTree.searchText"
                                                                                                                 md-items="item in ctrl.querySearch(RemoveTree.searchText)"
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                md-item-text="item.display"
                                                                                                                md-require-match
                                                                                                                md-floating-label="Specie">
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                  <md-item-template>
                                                                                                                    <span md-highlight-text='RemoveTree.searchText'>{{item.display}}</span>
                                                                                                                  </md-item-template>
                                                                                                              
                                                                                                              
                                                                                                              <!---
                                                                                                              <div ng-messages="searchForm.autocompleteField.$error" ng-if="searchForm.autocompleteField.$touched">
                                                                                                                <div ng-message="required">You <b>must</b> have a specie.</div>
                                                                                                                <div ng-message="md-require-match">Please select an existing specie.</div>
                                                                                                                <div ng-message="minlength">Your entry is not long enough.</div>
                                                                                                                <div ng-message="maxlength">Your entry is too long.</div>
                                                                                                              </div>
                                                                                                              --->
                                                                                                              
                                                                                                              
                                                                                                              
                                                                                                            </md-autocomplete>
                                                                                                        
                                                                                                    
                                                                                                        
                                                                                                   
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                    
                                                                                                      <md-input-container>
                                                                                                          <label>Note</label>
                                                                                                          <textarea ng-model="RemoveTree.note" md-maxlength="150" rows="1" md-select-on-focus></textarea>
                                                                                                        </md-input-container>
                                                                                                        
                                                                                                        
                                                                                                        <!---  remove button at end of row, species, auto-complete display scroll window, not looks good  --->
                                                                                                        
                                                                                                        <md-card-actions  layout-align="end center">
                                                                                         
                                                                                                          <md-button class="md-raised md-warn" ng-click="remove($index, 'remove_list')">Remove</md-button>
                                                                                                        </md-card-actions>
                                                                                                      
																									  
																									  
                                                                                        </div>
                                                                                        
                                                                                        
                                                                                        <!---  remove button at new row, end right bottom  
                                                                                        
                                                                                         <md-card-actions layout="row" layout-align="end center">
                                                                                         
                                                                                          <md-button class="md-raised md-warn" ng-click="remove($index, 'remove_list')">Remove</md-button>
                                                                                        </md-card-actions>
                                                                                        
                                                                                        --->
                                                                                        
                                                                                       <!---    <md-divider ng-if="!$last"></md-divider>  --->
                                                                        
                                                                        
                                                                        
                                                                             
                                                                               </md-card-content>
                                                                             
                                                                          
                                                                          </div>   <!--- ng-repeat --->
                                                                          
                                                                      
                                                                    
                                                                      
                                                                      
                                                        <!--- add button --->
                                                                        <md-card-actions layout="row" layout-align="end center">
                                                                          <md-button class="md-raised md-primary"  ng-click="addNew('remove_list');" >Add New</md-button>
                                                                          
                                                                        </md-card-actions>
                                                                      
                                                                      
                                                
                                              </md-card>
                              
                                             <!--- End  tab one content --->
                              
                              
                                       </md-content>
                                     </md-tab>
                          
                           <!--- End of tab remove --->
                          
                          
                          
                          
                          
                                          <!--- tab onsite --->
                        
                          <md-tab label="On-Site ({{OnSiteReplaceTreeList.length}})">
                            <md-content class="md-padding">
                            
                            
                               
                                
                              
                                   <!--- tab onsite content --->
                                   
                                   
                                           <md-card>
                                               
                                               
                                                <md-card-title>
                                                  <md-card-title-text>
                                                  
                                                    <md-subheader class="md-primary">On Site Replace Tree ({{OnSiteReplaceTreeList.length}})</md-subheader>
                                                 
                                                  </md-card-title-text>
                                                </md-card-title>
                                                
                                                
                                                
                                                  
                                                                      
                                                                   
                                                                       
                                                                       
                                                                        <div ng-repeat="OnSiteReplaceTree in OnSiteReplaceTreeList track by $index">
                                                                        
                                                                              <md-card-content>
                                                                             
                                                                            
                                                                                               <div layout-gt-xs="row" >
                                                                                                   <md-button class="md-fab md-mini" md-colors="{background: 'lime'}" aria-label="Tree No">
                                                                                                     
                                                                                                        {{$index +1}}
                                                                                                    
                                                                                                    </md-button>
                                                                                                </div>
                                                                                                
                                                                                                
                                                                        
                                                                                        <div layout-gt-xs="row" >
                                                                                                      <md-input-container>
                                                                                                        <label>Location</label>
                                                                                                        <input ng-model="OnSiteReplaceTree.location">
                                                                                                      </md-input-container>
                                                                                                
                                                                                                
                                                                                                <!---
                                                                                                      <md-input-container>
                                                                                                        <label>Species</label>
                                                                                                        <!---  -----  angucomplete-alt  ----   --->
                                                                                                          <div class="padded-row">
                                                                                                              <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100" 
                                                                                                                        selected-object="OnSiteReplaceTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                                        title-field="name" minlength="1" 
                                                                                                                        input-class="form-control form-control-small" match-class="highlight">
                                                                                                              </div>
                                                                                                            </div>
                                                                                                         <!--- End ----  angucomplete-alt --->
																										 
                                                                                                      </md-input-container>
                                                                                                   ---> 
                                                                                                      
                                                                                                        <md-autocomplete 
                                                                                                                md-input-name="specie" 
                                                                                                                md-input-minlength="10"
                                                                                                                md-input-maxlength="18"
                                                                                                                
                                                                                                                                                                                                                        
                                                                                                                 md-no-cache="true"
                                                                                                                 md-selected-item="OnSiteReplaceTree.selectedItem" 
                                                                                                                 md-search-text="OnSiteReplaceTree.searchText"
                                                                                                                 md-items="item in ctrl.querySearch(OnSiteReplaceTree.searchText)"
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                md-item-text="item.display"
                                                                                                                md-require-match
                                                                                                                md-floating-label="Specie">
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                  <md-item-template>
                                                                                                                    <span md-highlight-text='OnSiteReplaceTree.searchText'>{{item.display}}</span>
                                                                                                                  </md-item-template>
                                                                                                              
                                                                                                              
                                                                                                              <!---
                                                                                                              <div ng-messages="searchForm.autocompleteField.$error" ng-if="searchForm.autocompleteField.$touched">
                                                                                                                <div ng-message="required">You <b>must</b> have a specie.</div>
                                                                                                                <div ng-message="md-require-match">Please select an existing specie.</div>
                                                                                                                <div ng-message="minlength">Your entry is not long enough.</div>
                                                                                                                <div ng-message="maxlength">Your entry is too long.</div>
                                                                                                              </div>
                                                                                                              --->
                                                                                                              
                                                                                                              
                                                                                                              
                                                                                                            </md-autocomplete>
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container>
                                                                                                        <label>Planting Date</label>
                                                                                                        <md-datepicker ng-model="OnSiteReplaceTree.planting_date"></md-datepicker>
                                                                                                      </md-input-container>
                                                                                            
                                                                                                      <md-input-container>
                                                                                                        <label>Start Watering Date</label>
                                                                                                        <md-datepicker ng-model="OnSiteReplaceTree.start_watering_date"></md-datepicker>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                       
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                        </div>
                                                                        
                                                                        
                                                                        
                                                                                       
                                                                        
                                                                               
                                                                        
                                                                                        <div layout-gt-sm="row">
                                                                                        
                                                                                                      
                                                                                                      
                                                                                                       <md-input-container class="md-block" flex-gt-xs>
                                                                                                        <label>Parkway or Tree Well Size</label>
                                                                                                        <input ng-model="OnSiteReplaceTree.parkway_size">
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                     
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Overhead Wires</label>
                                                                                                        <md-select ng-model="OnSiteReplaceTree.overhead_wire">
                                                                                                          <md-option ng-repeat="overhead_wire in overhead_wires" value="{{overhead_wire}}">
                                                                                                            {{overhead_wire}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                            
                                                                                                     
                                                                                                     
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Sub Position</label>
                                                                                                        <input ng-model="OnSiteReplaceTree.sub_position">
                                                                                                      </md-input-container>
                                                                                                     
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Concrete Completed</label>
                                                                                                        <md-select ng-model="OnSiteReplaceTree.concrete_completed">
                                                                                                          <md-option ng-repeat="concrete_completed in concrete_completeds" value="{{concrete_completed}}">
                                                                                                            {{concrete_completed}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                      
                                                                                                       <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Post Inspected</label>
                                                                                                        <md-select ng-model="OnSiteReplaceTree.post_inspected">
                                                                                                          <md-option ng-repeat="post_inspected in post_inspecteds" value="{{post_inspected}}">
                                                                                                            {{post_inspected}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                   
                                                                                        
                                                                                                      
                                                                                                
                                                                                                     
                                                                                                      
                                                                                        </div>
                                                                        
                                                                                        
                                                                                          
                                                                                                      <md-input-container class="md-block">
                                                                                                          <label>Note</label>
                                                                                                          <textarea ng-model="OnSiteReplaceTree.note" md-maxlength="150" rows="1" md-select-on-focus></textarea>
                                                                                                        </md-input-container>
                                                                                        
                                                                                        
                                                                                        <md-card-actions layout="row" layout-align="end center">
                                                                                         
                                                                                          <md-button class="md-raised md-warn" ng-click="remove($index, 'onsite_list')">Remove</md-button>
                                                                                        </md-card-actions>
                                                                                        
                                                                                       <!---    <md-divider ng-if="!$last"></md-divider>  --->
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                              
                                                                            
                                                                                
                                                                             
                                                                               </md-card-content>
                                                                             
                                                                          
                                                                          </div>   <!--- ng-repeat --->
                                                                          
                                                                     
                                                                      
                                                                      
                                                        <!--- add button --->
                                                                        <md-card-actions layout="row" layout-align="end center">
                                                                          <md-button class="md-raised md-primary"  ng-click="addNew('onsite_list');" >Add New</md-button>
                                                                          
                                                                        </md-card-actions>
                                                                      
                                                                      
                                                
                                              </md-card>
                              
                                             <!--- End  tab onsite content --->
                              
                              
                                       </md-content>
                                     </md-tab>
                          
                           <!--- End of tab onsite --->
                                          
                                          
                                          
                                          
                                          
                                          
                                           <!--- tab offsite --->
                        
                          <md-tab label="Off-Site ({{OffSiteReplaceTreeList.length}})">
                            <md-content class="md-padding">
                            
                            
                               
                                
                              
                                   <!--- tab offsite content --->
                                   
                                   
                                           <md-card>
                                               
                                               
                                                <md-card-title>
                                                  <md-card-title-text>
                                                  
                                                    <md-subheader class="md-primary">Off Site Replace Tree ({{OffSiteReplaceTreeList.length}})</md-subheader>
                                                 
                                                  </md-card-title-text>
                                                </md-card-title>
                                                
                                                
                                                
                                                  
                                                                      
                                                                   
                                                                       
                                                                       
                                                                        <div ng-repeat="OffSiteReplaceTree in OffSiteReplaceTreeList track by $index">
                                                                        
                                                                              <md-card-content>
                                                                              
                                                                            
                                                                                               <div layout-gt-xs="row" >
                                                                                                   <md-button class="md-fab md-mini" md-colors="{background: 'lime'}" aria-label="Tree No">
                                                                                                     
                                                                                                        {{$index +1}}
                                                                                                    
                                                                                                    </md-button>
                                                                                                </div>
                                                                                                
                                                                                                
                                                                        
                                                                                        <div layout-gt-xs="row" >
                                                                                                      <md-input-container>
                                                                                                        <label>Location</label>
                                                                                                        <input ng-model="OffSiteReplaceTree.location">
                                                                                                      </md-input-container>
                                                                                                
                                                                                                
                                                                                                <!---
                                                                                                      <md-input-container>
                                                                                                        <label>Species</label>
                                                                                                        <!---    angucomplete-alt     --->
                                                                                                  <div class="padded-row">
                                                                                                      <div ng-model="OffSiteReplaceTree.specie" angucomplete-alt id="ex1" 
                                                                                                            placeholder="Search species" maxlength="50" pause="100" 
                                                                                                      			selected-object="OffSiteReplaceTree.selectedSpecie" local-data="species" search-fields="name" 
                                                                                                      			title-field="name" minlength="1" 
                                                                                                                input-class="form-control form-control-small" match-class="highlight">
                                                                                                      </div>
                                                                                                    </div>
                                                                                                 <!--- End ----  angucomplete-alt --->
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                  --->    
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                     <md-autocomplete 
                                                                                                                md-input-name="specie" 
                                                                                                                md-input-minlength="10"
                                                                                                                md-input-maxlength="18"
                                                                                                                
                                                                                                                                                                                                                        
                                                                                                                 md-no-cache="true"
                                                                                                                 md-selected-item="OffSiteReplaceTree.selectedItem" 
                                                                                                                 md-search-text="OffSiteReplaceTree.searchText"
                                                                                                                 md-items="item in ctrl.querySearch(OffSiteReplaceTree.searchText)"
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                md-item-text="item.display"
                                                                                                                md-require-match
                                                                                                                md-floating-label="Specie">
                                                                                                                
                                                                                                                
                                                                                                                
                                                                                                                  <md-item-template>
                                                                                                                    <span md-highlight-text='OffSiteReplaceTree.searchText'>{{item.display}}</span>
                                                                                                                  </md-item-template>
                                                                                                              
                                                                                                              <!---
                                                                                                              <div ng-messages="searchForm.autocompleteField.$error" ng-if="searchForm.autocompleteField.$touched">
                                                                                                                <div ng-message="required">You <b>must</b> have a specie.</div>
                                                                                                                <div ng-message="md-require-match">Please select an existing specie.</div>
                                                                                                                <div ng-message="minlength">Your entry is not long enough.</div>
                                                                                                                <div ng-message="maxlength">Your entry is too long.</div>
                                                                                                              </div>
                                                                                                              --->
                                                                                                              
                                                                                                              
                                                                                                              
                                                                                                            </md-autocomplete>
                                                                                                    
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container>
                                                                                                        <label>Planting Date</label>
                                                                                                        <md-datepicker ng-model="OffSiteReplaceTree.planting_date"></md-datepicker>
                                                                                                      </md-input-container>
                                                                                            
                                                                                                      <md-input-container>
                                                                                                        <label>Start Watering Date</label>
                                                                                                        <md-datepicker ng-model="OffSiteReplaceTree.start_watering_date"></md-datepicker>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                       
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                        </div>
                                                                        
                                                                        
                                                                        
                                                                                       
                                                                        
                                                                               
                                                                        
                                                                                        <div layout-gt-sm="row">
                                                                                        
                                                                                                      
                                                                                                      
                                                                                                       <md-input-container class="md-block" flex-gt-xs>
                                                                                                        <label>Parkway or Tree Well Size</label>
                                                                                                        <input ng-model="OffSiteReplaceTree.parkway_size">
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                     
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Overhead Wires</label>
                                                                                                        <md-select ng-model="OffSiteReplaceTree.overhead_wire">
                                                                                                         <md-option ng-repeat="overhead_wire in overhead_wires" value="{{overhead_wire}}">
                                                                                                            {{overhead_wire}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                            
                                                                                                     
                                                                                                     
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Sub Position</label>
                                                                                                        <input ng-model="OffSiteReplaceTree.sub_position">
                                                                                                      </md-input-container>
                                                                                                     
                                                                                                      
                                                                                                      
                                                                                                      <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Concrete Completed</label>
                                                                                                        <md-select ng-model="OffSiteReplaceTree.concrete_completed">
                                                                                                          <md-option ng-repeat="concrete_completed in concrete_completeds" value="{{concrete_completed}}">
                                                                                                            {{concrete_completed}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                      
                                                                                                       <md-input-container class="md-block" flex-gt-sm>
                                                                                                        <label>Post Inspected</label>
                                                                                                        <md-select ng-model="OffSiteReplaceTree.post_inspected">
                                                                                                          <md-option ng-repeat="post_inspected in post_inspecteds" value="{{post_inspected}}">
                                                                                                            {{post_inspected}}
                                                                                                          </md-option>
                                                                                                        </md-select>
                                                                                                      </md-input-container>
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                   
                                                                                        
                                                                                                      
                                                                                                
                                                                                                     
                                                                                                      
                                                                                        </div>
                                                                        
                                                                                        
                                                                                          
                                                                                                      <md-input-container class="md-block">
                                                                                                          <label>Note</label>
                                                                                                          <textarea ng-model="OffSiteReplaceTree.note" md-maxlength="150" rows="1" md-select-on-focus></textarea>
                                                                                                        </md-input-container>
                                                                                        
                                                                                        
                                                                                        <md-card-actions layout="row" layout-align="end center">
                                                                                         
                                                                                          <md-button class="md-raised md-warn" ng-click="remove($index, 'offsite_list')">Remove</md-button>
                                                                                        </md-card-actions>
                                                                                        
                                                                                       <!---    <md-divider ng-if="!$last"></md-divider>  --->
                                                                        
                                                                        
                                                                        
                                                                               
                                                                             
                                                                               </md-card-content>
                                                                             
                                                                          
                                                                          </div>   <!--- ng-repeat --->
                                                                          
                                                                     
                                                                      
                                                                      
                                                        <!--- add button --->
                                                                        <md-card-actions layout="row" layout-align="end center">
                                                                          <md-button class="md-raised md-primary"  ng-click="addNew('offsite_list');" >Add New</md-button>
                                                                          
                                                                        </md-card-actions>
                                                                      
                                                                      
                                                
                                              </md-card>
                              
                                             <!--- End  tab offsite content --->
                              
                              
                                       </md-content>
                                     </md-tab>
                          
                           <!--- End of tab offsite --->
                  
                  
                  <!--- tab structure  End  --->
                  
                  
                  

                      
                        
                         
                          
                          
                          
                          
                          
                           </form>
                          
                        
                        </div>
	
        </div>
    </body>
    
    
     
    
</cfoutput>

<cfset ro = 0>
<cfif session.user_level gt 0 AND session.user_power gte 0><cfset ro = 1></cfif>

<script>

			<cfoutput>
					var url = "#request.url#";
					var pid = #url.pid#;
					var sid = #url.sid#;
					var search = #url.search#;
					var crid = #url.crid#;
					var crsearch = #url.crsearch#;
					var loc = #getSite.location_no#;
					//var address = '#getSite.name#';
					var address = '#getSite.address#';
					var ro = #ro#;
					
					
					
					
					var _primary_key_id = #url.primary_key_id#;
					var _type_id = #url.type_id#;
					var _package_no = #url.package_no#;
					var _site_id = #url.sid#;
					
					<cfif url.crm_no eq "">
					  var _crm_no = "";
					<cfelse>
					  var _crm_no = #url.crm_no#;
					</cfif>
					
					
					<cfif url.crm_no eq "">
					 var _rebate =  "";
					<cfelse>
					  var _rebate = #url.rebate#;
					</cfif>
			
			</cfoutput>
			
</script>



<!---    ----- for display json output only    ---------    --->

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



<!--- End ----  for display json output only --->



</html>


            

				

	


