<!doctype html>

<html>
<head>
	<title>angular_add row </title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
	
	<!---   version 1.6.4 has bug on selectall check box    --->
	
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
	
   
    
    <!---   angularjs/1.2.1   
     <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.1/angular.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular-touch.min.js"></script>
   --->
	
	
	
    <!---   jquery auto complete    --->
    <script language="JavaScript" src="js/jquery.autocomplete.js"></script>   
    <script type="text/javascript" src="js/jquery.mockjax.js"></script>
 
 
 
       
    <!---   angucomplete-alt auto complete    --->
    <script language="JavaScript" src="js/angucomplete-alt.min.js"></script>
    <script language="JavaScript" src="js/species.js"></script>  
 
 
 
 
 	<!---   720kb/angular-datepicker    --->
 	<link href="css/angular-datepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/angular-datepicker.js"></script>
    
    
    
    <!--- hueitan/angular-validation   
    <script src="js/angular-validation.js"></script>
    <script src="js/angular-validation-rule.js"></script>
    --->
 
 
 
 
    <!--- our js css --->
    <script language="JavaScript" src="js/angular_add_remove_row.js"></script>
    
    
    <link rel="stylesheet" type="text/css" href="css/angular_add_remove_row.css">
    
    <!--- css from angucomplete_alt example  --->
    <!---  <link rel="stylesheet" type="text/css" href="css/angucomplete_alt_structure.css">   --->
    
    
    
    
    
    
</head>

<body > 


   <div ng-app="myapp">
   
             
    
    
    
     			<!---  ===============================  validate required    =====================   --->
    
     ========================        ListController3       ==========  validate required   ============================
    
                             <div class="container" ng-controller="ListController3">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form ng-submit="addNew()">
                                                    <table class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                               
                                                                <th><input type="checkbox" ng-model="selectedAll" ng-change="checkAll();" /></th>
                                                                <th>Firstname</th>
                                                                <th>Lastname</th>
                                                                <th>Email</th>
                                                                <th>Method</th>
                                                                <th>species</th>
                                                                <th>Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr ng-repeat="personalDetail in personalDetails">
                                                                <td>
                                                                  
                                                                   <input type="checkbox"  ng-model="personalDetail.selected" /></td> 
                                                                   
                                                                <td>
                                                                    <input type="text" class="form-control" ng-model="personalDetail.fname" required/></td>
                                                                <td>
                                                                    <input type="text" class="form-control" ng-model="personalDetail.lname" required/></td>
                                                                <td>
                                                                    <input type="email" class="form-control" ng-model="personalDetail.email" required/></td>
                                                                    
                                                                    
                                                                             <td>
                                                                                <select ng-model="ttx" ng-options="item for item in tts">
                                                                                </select>
                                                                             </td>
                                                                    
                                                                    
                                                                    
                                                                              <td>
                                                                              
                                                                                  <div class="padded-row">
                                                                                      <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100" selected-object="selectedSpecie" local-data="species" search-fields="name" title-field="name" minlength="1" input-class="form-control form-control-small" match-class="highlight">
                                                                                      </div>
                                                                                    </div>
                                                                              
                                                                              </td>
                                                                              
                                                                              
                                                                              
                                                                                      <td>
                                                                                      		<datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                  
                                                                                              			<input ng-model="personalDetail.date" type="text"/>
                                                                                            </datepicker>
                                                                                      </td> 
                                                                    
                                                                    
                                                                    
                                                            </tr>
                                                        </tbody>
                                                    </table>
                        
                                                    <div class="form-group">
                                                        <input ng-hide="!personalDetails.length" type="button" class="btn btn-danger pull-right" ng-click="remove()" value="Remove">
                                                       
                                                     
                                                        <input type="submit" class="btn btn-primary addnew pull-right" value="Add New">
                                                      
                                                         <!---
                                                         <a href="" class="button buttonText" style="height:17px;width:80px;padding:3px 0px 0px 0px;" 
                                                                                                                onclick="addNew()">Add New</a>
                                                                                                                 --->
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
    
                <!---  ===============================   End  validate required    =====================   --->
    
    
    
    =======================================================================
    
    
   <!---  ===============================     select                   =====================   --->
    
                                        <div class="container" ng-controller="ListController" >
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <form id="form0">
                                                                <table class="table table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th><input type="checkbox" ng-model="selectedAll" ng-click="checkAll();" /></th>
                                                                            <th>Firstname</th>
                                                                            <th>Lastname</th>
                                                                            <th>Email</th>
                                                                            <th>Method</th>
                                                                            <th>species</th>
                                                                            <th>Date</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr ng-repeat="personalDetail in personalDetails">
                                                                                <td>
                                                                                   <input type="checkbox"  ng-model="personalDetail.selected" /></td> 
                                                                                <td>
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.fname" required/></td>
                                                                                <td>
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.lname" required/></td>
                                                                                <td>
                                                                                    <input type="email" class="form-control" ng-model="personalDetail.email" required/></td>
                                                                                
                                                                            <td>
                                                                                <select ng-model="ttx" ng-options="item for item in tts">
                                                                                </select>
                                                                             </td>
                                                                             
                                                                             
                                                                              <td>
                                                                              
                                                                                  <div class="padded-row">
                                                                                      <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100" selected-object="selectedSpecie" local-data="species" search-fields="name" title-field="name" minlength="1" input-class="form-control form-control-small" match-class="highlight">
                                                                                      </div>
                                                                                    </div>
                                                                              
                                                                              </td>
                                                                              
                                                                              
                                                                              
                                                                                      <td>
                                                                                      		<datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                  
                                                                                              			<input ng-model="personalDetail.date" type="text"/>
                                                                                            </datepicker>
                                                                                      </td>  
                                                                              
                                                                              
                                                                             
                                                                                
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                    
                                                                <div class="form-group">
                                                                    <input ng-hide="!personalDetails.length" type="button" class="btn btn-danger pull-right" ng-click="remove()" value="Remove">
                                                                    
                                                                     <!---
                                                                    <input type="submit" class="btn btn-primary addnew pull-right" value="Add New"  >
                                                                    --->
                                                                    
                                                                    <input type="button" class="btn btn-primary addnew pull-right" value="Add New" ng-click="addNew();" >
                                                                    <input id="submit_handle" type="submit" style="display: none">
                                                                    
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                   
           =====================================================================================
                                        
                                 <table>
                                        <tr>
                                           <td>
                                        
                                        <div class="container" ng-controller="ListController2" >
                                        
                                        
                                        
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <form ng-submit="addNew()">
                                                                <table class="table table-striped table-bordered">
                                                                
                                                                
                                                                            <thead>
                                                                                <tr>
                                                                                    <th><input type="checkbox" ng-model="selectedAll" ng-click="checkAll();" /></th>
                                                                                    <th>Firstname</th>
                                                                                    <th>Lastname</th>
                                                                                    <th>Email</th>
                                                                                    <th>species</th>
                                                                                    <th>Date</th>
                                                                                </tr>
                                                                            </thead>
                                                                    
                                                                            <tbody>
                                                                                <tr ng-repeat="personalDetail in personalDetails">
                                                                                    <td>
                                                                                        <input type="checkbox"  ng-model="personalDetail.selected" /></td> 
                                                                                    <td>
                                                                                        <input type="text" class="form-control" ng-model="personalDetail.fname" /></td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control" ng-model="personalDetail.lname" /></td>
                                                                                    <td>
                                                                                        <input type="email" class="form-control" ng-model="personalDetail.email" /></td>
                                                                                        
                                                                                        
                                                                                     <td>
                                                                              
                                                                                              <div class="padded-row">
                                                                                                  <div angucomplete-alt id="ex1" placeholder="Search species" maxlength="50" pause="100" selected-object="selectedSpecie" local-data="species" search-fields="name" title-field="name" minlength="1" input-class="form-control form-control-small" match-class="highlight">
                                                                                                  </div>
                                                                                                </div>
                                                                              
                                                                                     </td>
                                                                                        
                                                                                        
                                                                                      <td>
                                                                                      		<datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                              <input ng-model="personalDetail.date" type="text"/>
                                                                                            </datepicker>
                                                                                      
                                                                                      </td>  
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                        
                                                                                </tr>
                                                                            </tbody>
                                                                </table>
                                    
                                                                <div class="form-group">
                                                                    <input ng-hide="!personalDetails.length" type="button" class="btn btn-danger pull-right" ng-click="remove()" value="Remove">
                                                                    <input type="button" class="btn btn-primary addnew pull-right" value="Add New" ng-click="addNew()">
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                           
                                            
                                        </div>
                                        
                                        
                                    </td>
                                 </tr>
                              </table>
                              
                              
                         <!---  ===============================    End                select                   =====================   --->      
                              
                              
                              
                              
    
    
    
    
       
   </div>  <!---   ng-app  --->
    
    
  
    
</body>

</html>

