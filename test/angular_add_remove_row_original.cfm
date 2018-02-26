<!doctype html>

<html>
<head>
	<title>angular_add row </title>
    
    
	<!--- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>   --->
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.1/angular.min.js"></script>
    
    
 
 
 
    <!--- our js css --->
    <script language="JavaScript" src="js/angular_add_remove_row_original.js"></script>
    
   
    
    
    
    
    
</head>

<body ng-app="myapp" ng-controller="ListController">     
    <div class="container">
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
                                            <input type="text" class="form-control" ng-model="personalDetail.fname" required/></td>
                                        <td>
                                            <input type="text" class="form-control" ng-model="personalDetail.lname" required/></td>
                                        <td>
                                            <input type="email" class="form-control" ng-model="personalDetail.email" required/></td>
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
</body>

</html>

