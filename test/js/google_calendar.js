
       /*
   
        We need to manually start angular as we need to
        wait for the google charting libs to be ready
		
		*/

	 
      //  step 1 :  load charts package must befor 'load ready' before angular	 
	  google.charts.load("current", {packages:["calendar"]});
	 
	 
	  //  step 2 :  this callback make sure after chart load ready, then start run angular
      google.charts.setOnLoadCallback(function () {    
														angular.bootstrap(document.body, ['water-app']);
													});
	  
	  
	 
	 
	 //  step 3 :   ========== water angular controller ================
	 
	 var app = angular.module("water-app", ["ngTouch", "angucomplete-alt", '720kb.datepicker']);
	
	    app.controller("WaterController", ['$scope', '$http', '$filter', function($scope, $http, $filter) {
											  
			 								  
				$scope.dataTable = new google.visualization.DataTable();
				 
				 $scope.dataTable.addColumn({ type: 'date', id: 'Date' });
				 
				   $scope.dataTable.addColumn({ type: 'number', id: 'Status' });
				   
				   
				 
				   
				   $scope.dataTable.addRows([
					  [ new Date(new Date()),  -1 ],   // today
					  //[ new Date('2016-12-31'),  0 ],  // 2016 year place holder
					  [ new Date('2017-01-01'),  0 ],   // 2017 year place holder
					  [ new Date('2018-01-02'),  0 ],   // 2018 year place holder
					  
					  
					  
					  [ new Date('2016-07-05'), 1 ],
					  [ new Date('2016-08-05'), 1 ],
					  [ new Date('2016-09-05'), 1 ],
					  [ new Date('2016-10-05'), 1 ],					  
					  [ new Date('2016-11-05'),  1 ],
					  
					  [ new Date('2017-02-05'), 1 ],
					  [ new Date('2017-03-05'), 1 ],
					  [ new Date('2017-04-05'), 1 ],
					  [ new Date('2017-05-05'), 1 ],
					  [ new Date('2017-06-05'), 1 ],
					  [ new Date('2017-07-05'), 1 ]
					]);
				 
				 $scope.chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
				 
				 $scope.options = {
									 title: "Watering Date",
									 height: 500,
									 
									 //legend: {position: 'none'},
									 legend: 'none',
									 
									 /*
									 noDataPattern: {
													   backgroundColor: '#c09874',
													   color: '#fcf1e7'
													 },
									 */
									 calendar: {
												  focusedCellColor: {
													stroke: '#d3362d',
													strokeOpacity: 1,
													strokeWidth: 1,
												  }
												}
								   };
				
				
				// first time draw chart
				$scope.chart.draw($scope.dataTable, $scope.options);
				
				
				       // -----    -------  click cell handler -----------------
				        google.visualization.events.addListener($scope.chart, 'select', selectHandler);
				
						function selectHandler(e) {
							
							  
							    
							   var  cell_clicked = $scope.chart.getSelection();
							   
							   
							   
							   var  date_clicked = new Date(cell_clicked[0].date + 86400000);  // issue, add 1 day(86400000 milliseconds) to get correct date, maybe need timezone UTC adjust, here is a easy fix
							 
							   var _row_index = cell_clicked[0].row;
							 
							    //console.log(date_clicked);
							 
						        //console.log(_row_index);
						       
						 
						      if (_row_index > 2 ){  // index= 0, 1, 2 is year place holder, can not be removed.
						  				
										// remove date
										
										
										
										$scope.dataTable.removeRow(cell_clicked[0].row);
										
										
						  
							  }// if
						      else {
								        
										// add date
										//console.log(date_clicked);
										$scope.dataTable.addRows([[ date_clicked, 1 ]]);
								  
							  }
						  
						  
						  console.log($scope.dataTable.getNumberOfRows());
						  $scope.chart.draw($scope.dataTable, $scope.options);
						  
						  
						}
				
				        // ----- End ---------click cell handler -----------------
				
				
				
				
				
				/*
				  //----- original code -----------
				  
							   var dataTable = new google.visualization.DataTable();
								   dataTable.addColumn({ type: 'date', id: 'Date' });
								   dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
								   dataTable.addRows([
									  [ new Date(2012, 3, 13), 37032 ],
									  [ new Date(2012, 3, 14), 38024 ],
									  [ new Date(2012, 3, 15), 38024 ],
									  [ new Date(2012, 3, 16), 38108 ],
									  [ new Date(2012, 3, 17), 38229 ],
									  // Many rows omitted for brevity.
									  [ new Date(2013, 9, 4), 38177 ],
									  [ new Date(2013, 9, 5), 38705 ],
									  [ new Date(2013, 9, 12), 38210 ],
									  [ new Date(2013, 9, 13), 38029 ],
									  [ new Date(2013, 9, 19), 38823 ],
									  [ new Date(2013, 9, 23), 38345 ],
									  [ new Date(2013, 9, 24), 38436 ],
									  [ new Date(2013, 9, 30), 38447 ]
									]);
							
								   var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
							
								   var options = {
									 title: "Red Sox Attendance",
									 height: 350,
								   };
							
								   chart.draw(dataTable, options);
								   
				    //----- original code -----------
				*/
				
				
				
				
			}]);
	 
	 
	 
      
     
	  
	 
	  
	  
	  
	  