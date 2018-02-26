<!doctype html>

<html>
<head>
	<title>angular_ajax</title>

                         
						<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
                         <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.4/angular-touch.min.js"></script>
                        
                         <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
                       
                        
                       
                        
                        
                        
                        <!---   angucomplete-alt auto complete    --->
                            <script language="JavaScript" src="js/angucomplete-alt.min.js"></script>
                            <script language="JavaScript" src="js/species.js"></script>  
                         
                         
                         
                         
                            <!---   720kb/angular-datepicker    --->
                            <link href="css/angular-datepicker.css" rel="stylesheet" type="text/css" />
                            <script src="js/angular-datepicker.js"></script>
                            
                            <link rel="stylesheet" type="text/css" href="css/angular_add_remove_row.css">
                            
                            
                            
                       
                            
                            
                            
                            
                            
                             <script language="JavaScript" src="js/angular_ajax.js"></script>  
    
    </head>

<body> 
    
    
    
    
   
  
    
    
    
    
    

     <div ng-app="myApp" class="container">
 
             
             
            
 
 

 
 
 
 
 
 
 
 
 
  
                                        







 									<div class="container" ng-controller="ListController" >
                                    
                                     <input type="button" class="btn btn-primary pull-right" value="post_to_server" ng-click="save();" >
                                      
                                      
                                      <br>
                                      
                                      server_response_back_result:
                                           <pre id='return_json'>
                                           </pre>
                                      
                                     		 {{server_response}}  
                                    
                                    
                                               <!-- For each type of HTTP method, output the echoed result. 
                                                    <div ng-repeat="dump in cfdumps">
                                                
                                                       
                                                
                                                        <div ng-bind-html="dump.html">
                                                            
                                                        </div>
                                                
                                                    </div>
                                        
                                                -->
                                        
                                    
                                       <br>
                                       
                                       
                                       
                                       
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <form id="form0">
                                                                <table class="table table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th><input type="checkbox" ng-model="selectedAll" ng-click="checkAll();" /></th>
                                                                            <th>No.</th>
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
                                                                                
                                                                                
                                                                                
                                                                                <!---   required field 
																				
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.fname" required/></td>
                                                                                <td>
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.lname" required/></td>
                                                                                <td>
                                                                                    <input type="email" class="form-control" ng-model="personalDetail.email" required/></td>
                                                                                    --->
                                                                                    
                                                                                  <td>    
                                                                                    <input type="text"  value="{{$index +1}}" class="form-control" disabled/></td>   
                                                                                    
                                                                                <td>    
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.fname" /></td>
                                                                                <td>
                                                                                    <input type="text" class="form-control" ng-model="personalDetail.lname" /></td>
                                                                                <td>
                                                                                    <input type="email" class="form-control" ng-model="personalDetail.email" /></td>
                                                                                    
                                                                                         
                                                                                
                                                                            <td>
                                                                                <select ng-model="personalDetail.method" ng-options="item for item in tts">
                                                                                </select>
                                                                             </td>
                                                                             
                                                                             
                                                                              <td>
                                                                              
                                                                                  <div class="padded-row">
                                                                                      <div  angucomplete-alt id="ex1" placeholder="Search species" 
                                                                                      maxlength="50" pause="100" selected-object="personalDetail.specieSelected" 
                                                                                      local-data="species_local_list" search-fields="name" title-field="name" 
                                                                                      minlength="1" input-class="form-control form-control-small" match-class="highlight"
                                                                                      initial-value="personalDetail.init_specieSelected">
                                                                                      
                                                                                        
                                                                                      </div>
                                                                                    </div>
                                                                              
                                                                              </td>
                                                                              
                                                                              
                                                                              
                                                                                      <td>
                                                                                      		<datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                  
                                                                                              			<input ng-model="personalDetail.date" type="text"  ng-change="date_changed(personalDetail)" />
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
                                        
 ============================================================================================
 
 
 
                                        <div ng-controller="ctrl">
											
											
										Datepicker:
                                                                                            <datepicker date-format="MM/dd/yyyy" date-typer="true">
                                                                                                  
                                                                                              			<input ng-model="alltree.mydate" type="text"/>
                                                                                            </datepicker>
                                                                                            <div ng-show="ctrl.error">{{ctrl.error_message}}</div>
                                        </div>
                                        
                                        
                                        
                                        

                   </div>  <!--- ng-app myApp   --->


</body>
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


</html>



