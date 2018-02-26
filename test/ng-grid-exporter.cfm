<!doctype html>
<html ng-app="app">
  <head>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-touch.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-animate.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/csv.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/pdfmake.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/vfs_fonts.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/lodash.min.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/jszip.min.js"></script>
    <script src="http://ui-grid.info/docs/grunt-scripts/excel-builder.dist.js"></script>
    
   
    <script src="http://ui-grid.info/release/ui-grid.js"></script>
    <link rel="stylesheet" href="http://ui-grid.info/release/ui-grid.css" type="text/css">
   
     <!---
    <script src="js/ui-grid.info/4.0.7/ui-grid.min.js"></script>
    <link rel="stylesheet" href="js/ui-grid.info/4.0.7/ui-grid.min.css" type="text/css">
     --->
	
	
    <link rel="stylesheet" href="css/ng-grid-exporter.css" type="text/css">
  </head>
  <body>

<div ng-controller="MainCtrl">
  <div ui-grid="gridOptions" ui-grid-selection ui-grid-exporter class="grid"></div>
</div>


    <script src="js/ng-grid-exporter.js"></script>
  </body>
</html>
