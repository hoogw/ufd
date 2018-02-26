<!doctype html>
<html ng-app="Demo">
<head>
    <meta charset="utf-8" />

    <title>
        Parsing AngularJS Request Data On The Server Using ColdFusion
    </title>
</head>
<body ng-controller="DemoController">

    <h1>
        Parsing AngularJS Request Data On The Server Using ColdFusion
    </h1>

    <!-- For each type of HTTP method, output the echoed result. -->
    <div ng-repeat="dump in cfdumps">

        <h3>
            {{ dump.method }}
        </h3>

        <div ng-bind-html="dump.html">
            <!-- To be populated with the CFDump from the server. -->
        </div>

    </div>


    <!-- Initialize scripts. -->
   
   <!---   version 1.6.4 has bug on selectall check box      
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
                         <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
    
     --->
     
    <!---    --->
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.4/angular.min.js"></script>  
   
    
    
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>

     <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>   
   
   
   
   
    <script type="text/javascript">
        // Define the module for our AngularJS application.
        var app = angular.module( "Demo", [] );
        // -------------------------------------------------- //
        // -------------------------------------------------- //
        // I control the main demo.
        app.controller(
            "DemoController", ['$scope', '$http', function($scope, $http) {
                // I hold the data-dumps of the FORM scope from the server-side.
                $scope.cfdumps = [];
                // Make an HTTP request for each type of verb.
                //angular.forEach( [ "get", "post", "put", "delete" ], makeRequest );
				
				
				//  GET does not have a body, body has data, GET only have header with parameter
				//angular.forEach( [  "post", "put", "delete" ], makeRequest );
				angular.forEach( [  "post"], makeRequest );
				
                // ---
                // PRIVATE METHODS.
                // ---
                // I post data to the API using the given method type.
                function makeRequest( method ) {
                    // AngularJS will try to work with ANY type of data that you pass
                    // in the "data" property. However, I try to ALWAYS pass an object
                    // with key-value pairs as I find that this makes the data easier
                    // to consume on the server.
					
					    var post_data = 
												{

															  RemoveTreeList: [
																				{
																					'count':5,
																					'location':'uuuuuuu',
																					'note':'SHAMEL ASH',
																					
																					'init_specieSelected':{'code':'','name':'ACACIA9999 SPECIES'}
																					
																				},
																				{
																					'count':2,
																					'location':'iiiiiiiiii',
																					'note':'CAMPHOR TREE',
																					'init_specieSelected':{'code':'','name':'xxxxxxxxCIES'}
																				},
																				{
																					'count':1,
																					'location':'ppppppp',
																					'note':'PECAN',
																					'init_specieSelected':{'code':'','name':'1111111111111'}
																				}],
																				
															  OnSiteReplaceTreeList :[
																				{
																					'count':'2',
																					'location':'ppooppoioi',
																					'planting_date':'08/999/20117',
																					'overhead_wire':'No',
																					'note':'3333333333333333333333333',
																					'init_specieSelected':{'code':'','name':'999877655'}
																				},
																				{
																					'count':'8',
																					'location':'errertertrew',
																					'planting_date':'08/089997',
																					'overhead_wire':'',
																					'note':'ttttttttttttttttttttttt',
																					'init_specieSelected':{'code':'','name':'gyhbyrvv'}
																				},
																				{
																					'count':'4',
																					'location':'rtytrhrehtr',
																					'planting_date':'08999/20117',
																					'overhead_wire':'No',
																					'note':'hhhhhhhhhhhhhhhhhhhhhhhhhhh',
																					'init_specieSelected':{'code':'','name':'90890890gjhgff'}
																				}],
									
															OffSiteReplaceTreeList  :[
																				{
																					'count':'7',
																					'location':'5',
																					'planting_date':'08/08999/20117',
																					'overhead_wire':'Yes',
																					'note':'hhhhhhhhhhhhhhhhhhhh',
																					'init_specieSelected':{'code':'','name':'uunh8776890'}
																				},
																				{
																					'count':'9',
																					'location':'87987juy',
																					'planting_date':'08765/08999/20117',
																					'overhead_wire':'No',
																					'note':'uuuuuuuuuuuuuuuuuuuuuuuuuuuuu',
																					'init_specieSelected':{'code':'','name':'<>TYTRG'}
																				},
																				{
																					'count':'8',
																					'location':'56756u65tydghtd',
																					'planting_date':'08/08999/2011',
																					'overhead_wire':'',
																					'note':'5555555555555555555555555',
																					'init_specieSelected':{'code':'','name':'$^&^gghdsa'}
																				}]
									
													};							
					
					      
					
					
					
					
					
										var request = {
											method: method,
											//url: "http://78boe99prod/ufd/test/cfc/tree_service1.cfm",
											url: "http://78boe99prod/ufd/test/cfc/tree_service.cfc?method=save_tree",
											data: post_data
										};
										// Store the data-dump of the FORM scope.
										//$http(request).success(      // for angular 1.2.x
							            $http(request).then(    // for angular 1.6.x
																	function successCallback( _response ) {
																		$scope.cfdumps.push({
																			method: method.toUpperCase(),
																			//html: _response    // for angular 1.2.x
																			html: _response.data  // for angular 1.6.x
																		});//push
																	}, // success
																	
																	function errorCallback(){
																	}
																	
										);// then
					
					
                                  }// make request
          }]);// app Controller
        // -------------------------------------------------- //
        // -------------------------------------------------- //
        // I override the "expected" $sanitize service to simply allow the HTML to be
        // output for the current demo.
        // --
        // NOTE: Do not use this version in production!! This is for development only.
        app.value(
            "$sanitize",
            function( html ) {
                return( html );
            }
        );
    </script>

</body>
</html>