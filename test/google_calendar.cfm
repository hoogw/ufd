<html>
  <head>
  
    
    <!---   version 1.6.4 has bug on selectall check box   --->
	
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
	
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
     
     
     <!---   720kb/angular-datepicker    --->
 	<link href="css/angular-datepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/angular-datepicker.js"></script>
    <script src="js/moment.min.js"></script>
    
    
    <!---   angucomplete-alt auto complete    --->
    <script language="JavaScript" src="js/angucomplete-alt.min.js"></script>
    <script language="JavaScript" src="js/species.js"></script>  
     <link href="css/angucomplete-alt.css" rel="stylesheet" type="text/css" />
     
	 
     
     <script src="js/google_calendar.js"></script>
     
	
    
   
  
  </head>
  <!--- <body ng-app="water-app">      --->
  <!---  must remove ng-app='water-app', otherwise chart will not load, ng-app bootstraps the element with the app,However, since we’re already doing that in our controller code (angular.bootstrap(document.body, ['myApp']);) --->
  
    <body>
    
      <div ng-controller="WaterController">
  
          <div id="calendar_basic" style="width: 1000px; height: 350px;"></div>
    
      </div>
  </body>
</html>