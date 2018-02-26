<!doctype html>
<html >
  <head>
  

    <title>ui-grid</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-touch.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-animate.js"></script>
    
    
     <script src="https://cdn.rawgit.com/angular-ui/bower-ui-grid/master/ui-grid.min.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/angular-ui/bower-ui-grid/master/ui-grid.min.css" type="text/css">
    <!---
    <script src="http://ui-grid.info/release/ui-grid.js"></script>
    <link rel="stylesheet" href="http://ui-grid.info/release/ui-grid.css" type="text/css">
    --->
    
    
    
    <!--- http failed on jsFiddle and codepen, only https works --->
    <script src="http://ui-grid.info/docs/grunt-scripts/csv.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/pdfmake.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/vfs_fonts.js"></script>
                            <!--- export for excel only --->
							<script src="http://ui-grid.info/docs/grunt-scripts/lodash.min.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/jszip.min.js"></script>
							<script src="http://ui-grid.info/docs/grunt-scripts/excel-builder.dist.js"></script>
							 <!--- export for excel only --->
    
    <!---   end -----   http failed on jsFiddle and codepen, only https works --->
    
    
    
    
                        <!---   modal  --->
                          <script src="js/jquery/jquery-3.2.1.min.js"></script>
                          
                          <!--- slow unstable change to local
                          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
                          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                          --->
						
                          <link rel="stylesheet" href="js/bootstrap-3.3.7/dist/css/bootstrap.min.css">        
                         <script language="JavaScript" src="js/bootstrap-3.3.7/dist/js/bootstrap.min.js"></script>
                        
                         <!--- End   modal  --->
    
    
    
    
    
    <link rel="stylesheet" href="css/ng-grid.css" type="text/css">
     <script language="JavaScript" src="js/ng-grid.js"></script>  
    
    
    
    <link rel="shortcut icon" href=""> <!--- fix favicon.ico 404 not found error  --->
    
  </head>
  <body ng-app="app">

            <div ng-controller="MainCtrl">
              You can use asterisks to fuzz-match, i.e. use "*z*" as your filter to show any row where that column contains a "z".
              <br>
              <br>
              <strong>Note:</strong> The third column has the filter input disabled, but actually has a filter set in code that requires every company to have an 'a' in their name.
              <br>
              <br>
              <button id='toggleFiltering' ng-click="toggleFiltering()" class="btn btn-success">Toggle Filtering</button>
              <div id="grid" ui-grid="gridOptions" ui-grid-exporter ui-grid-selection ></div>
            </div>

      
      
      
       <!---   ~~~~~~~~~ double click row Modal ~~~~~~~~~~~~~~~~ --->
                                  <div class="modal fade" id="double_click_row_modal" role="dialog">
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
                                                        <td><h6 class="modal-title">Watering History &nbsp;  </h6></td>
                                                        
                                                        <td>
                                                         
                                                        </td>
                                                        
                                                        
                                                        
                                                        
                                                    </tr>
                                                    
                                                   
                                                </tbody>
                                            </table>
                                        
                                        </div>
                                        <div class="modal-footer">
                                          <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="">Save</button>
                                        </div>
                                      </div>
                                      
                                    </div>
                                  </div>
                                  
                                </div>
                       <!---    ~~~~~~~~~   double click row Modal   ~~~~~~~~~~~~~~~~~~~  --->
      
      
      
      
   
  </body>
</html>
