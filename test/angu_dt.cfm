<!doctype html>

<html>
<head>
	<title>angu_datatable</title>

                         
						
                        
                     
                        
                        <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.5/angular.min.js"></script>
                       
                        
                        
                        
                            
                            
                            
                           <!---  datatables.net --->
                            
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/2.0.0/ui-bootstrap-tpls.min.js"></script>
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-utils/0.1.1/angular-ui-utils.min.js"></script>
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/js/jquery.dataTables.min.js"></script>
                             <script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>
                            
                             <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
                             <link href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
                            
                            
                            
                          <!---   <link href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />  --->
                            
                            
                             <script language="JavaScript" src="js/angu_dt.js"></script>  
    
    </head>

<body> 
    
    
    
    
   
  <div class="container" ng-app="formvalid">
  <div class="panel" data-ng-controller="validationCtrl">
    <div class="panel-heading border">
      <h2>Data table using jquery datatable in Angularjs
    </h2>
    </div>
    <div class="panel-body">
    
      <!---     ui-jq = angularjs binding .dataTable() function,   ui-options= bind to .dataTable({datatable option})--->
      <table id="example" class="table table-bordered bordered table-striped table-condensed datatable" ui-jq="dataTable" ui-options="dataTableOpt">   
     
       
        <thead>
          <tr>
            <th>#</th>
            <th>Name</th>
            <th>Position</th>
            <th>Office</th>
            <th>Age</th>
            <th>Start Date</th>
          </tr>
        </thead>
        
        
        <tfoot>
          <tr>
            <th>#</th>
            <th>Name</th>
            <th>Position</th>
            <th>Office</th>
            <th>Age</th>
            <th>Start Date</th>
          </tr>
        </tfoot>
        
        
        <tbody>
          <tr ng-repeat="n in data">
            <td>{{$index+1}}</td>
            <td>{{n[0]}}</td>
            <td>{{n[1]}}</td>
            <td>{{n[2]}}</td>
            <td>
                <a href="http://78boe99prod/ufd/trees1/cfc/tree_service.cfc?key={{n[3]}}&returnformat=json">
                          {{n[3]}}  
                </a>
                
            </td>
            <td>{{n[4] | date:'dd/MM/yyyy'}}</td>
          </tr>
        </tbody>
        
        
      </table>
    </div>
  </div>
</div>
    
    
    
    
    

</body>



<style>
tfoot {
    display: table-header-group;
}

</style>

</html>



