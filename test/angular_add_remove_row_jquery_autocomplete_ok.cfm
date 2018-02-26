<!doctype html>

<html>
<head>
	<title>angular_add row </title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
    
    
    <!---   jquery auto complete    --->
    <script language="JavaScript" src="js/jquery.autocomplete.js"></script>   
    <script type="text/javascript" src="js/jquery.mockjax.js"></script>
 
 
 
       
    <!---   angucomplete-alt auto complete    --->
    <script src="js/angucomplete-alt.min.js"></script>
      
 
 
 
 <!---   <script language="JavaScript" src="js/countries.js"></script>   --->
 
 
 
    <!--- our js css --->
    <script language="JavaScript" src="js/angular_add_remove_row.js"></script>
    
    <link rel="stylesheet" type="text/css" href="css/angular_add_remove_row.css">
    
    
    
    
    
    
    
    
</head>

<body ng-app="myapp"> 


   <div>
   
              <!---  ===============================     auto complete     =====================   --->
   
   
      <div>
                       <p>simple  >>> Type country name in english:</p>
                        <input type="text" name="country" id="autocomplete"/>
   
                       
                        <p>ajax - mock  >>> Type country name in english:</p>
                        <div style="position: relative; height: 80px;">
                            <input type="text" name="country" id="autocomplete-ajax" style="position: absolute; z-index: 2; background: transparent;"/>
                            
                        </div>
                        <div id="selction-ajax"></div>
       </div>
   
   <!---
   
         <div angucomplete-alt id="ex1" placeholder="Search countries" maxlength="50" pause="100" selected-object="selectedCountry" local-data="countries" search-fields="name" title-field="name" minlength="1" input-class="form-control form-control-small" match-class="highlight">
          </div>
    
    --->
    
    
    
                 <!---  =============================== End     auto complete     =====================   --->
    
    
    
    
    
    
    
    
    
   <!---  ===============================     select                   =====================   --->
    
                                        <div class="container" ng-controller="ListController" >
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <form ng-submit="addNew()">
                                                                <table class="table table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th><input type="checkbox" ng-model="selectedAll" ng-click="checkAll()" /></th>
                                                                            <th>Firstname</th>
                                                                            <th>Lastname</th>
                                                                            <th>Email</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr ng-repeat="personalDetail in personalDetails">
                                                                            <td>
                                                                                <input type="checkbox" ng-model="personalDetail.selected"/></td>
                                                                            <td>
                                                                                <input type="text" class="form-control" ng-model="personalDetail.fname" /></td>
                                                                            <td>
                                                                                <input type="text" class="form-control" ng-model="personalDetail.lname" /></td>
                                                                            <td>
                                                                                <input type="email" class="form-control" ng-model="personalDetail.email" /></td>
                                                                                
                                                                            <td>
                                                                                <select ng-model="ttx" ng-options="item for item in tts">
                                                                                </select>
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
                                        
                                   
                                        ========================
                                        
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
                                                                                    <th><input type="checkbox" ng-model="selectedAll" ng-click="checkAll()" /></th>
                                                                                    <th>Firstname</th>
                                                                                    <th>Lastname</th>
                                                                                    <th>Email</th>
                                                                                </tr>
                                                                            </thead>
                                                                    
                                                                            <tbody>
                                                                                <tr ng-repeat="personalDetail2 in personalDetails2">
                                                                                    <td>
                                                                                        <input type="checkbox" ng-model="personalDetail2.selected"/></td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control" ng-model="personalDetail2.fname" /></td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control" ng-model="personalDetail2.lname" /></td>
                                                                                    <td>
                                                                                        <input type="email" class="form-control" ng-model="personalDetail2.email" /></td>
                                                                                </tr>
                                                                            </tbody>
                                                                </table>
                                    
                                                                <div class="form-group">
                                                                    <input ng-hide="!personalDetails2.length" type="button" class="btn btn-danger pull-right" ng-click="remove()" value="Remove">
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

