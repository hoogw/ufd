<!doctype html>

<html>
<head>
	<title>days_since_last</title>
	
</head>




<body>

      
      <!--- action_type = 0: remove, 1: plant --->
      <!--- type = 1:BSS, 2: RAP 3: private 4: General Service 5: BSS dead tree  6: BSS Volunteer --->
      <!--- DELETED = 0, means not deleted, 1 means deleted --->
      
      <cfquery name="select_all_tree" datasource="#request.sqlconn2#" dbtype="ODBC" >
                         
                                    SELECT * FROM search_tree 
                                    
      </cfquery>
      
     
      
      
                         
       <cfloop query = "select_all_tree"> 
      
           <cfset _tree_id = ID>
           
          
                		                              <!---  ------------  calculate latest_water_date and days_since_last_water  ----------- --->
                                                            
                                                            
                                                               <cfquery name="check_latest_watering_date" datasource="#request.sqlconn2#">
                                                                                         
                                                                  
                                                                  SELECT max(date) as date
                                                                  FROM water
                                                                  where pk_id = #_tree_id# 
                                                                                    
                                                                     
                                                              </cfquery>
                                                              
                                                              
                                                             
                                                                  <cfif len(check_latest_watering_date.date)>
                                                                  
																	 
                                                                 
                                                                 
                                                                   
                                                                      
                                                                       <cfset _latest_water_date = check_latest_watering_date.date>
                                                                      
                                                                  
                                                                       <cfset _days_since_latest_water = Abs(DateDiff("d", _latest_water_date, DateFormat(Now())))>
                                                                      
                                                                      
                                                                       <cfquery name="update_tree_info" datasource="#request.sqlconn2#">
                                                                 
                                                                                    update search_tree
                                                                                    
                                                                                    set new_added = 0,
                                                                                        last_water_date =  '#_latest_water_date#',
                                                                                        days_since_last_water = '#_days_since_latest_water#'  
                                                                                        
                                                                                    where id = #_tree_id#
                                                                                 
                                                                                                    
                                                                                     
                                                                       </cfquery>
                                                                      
                                                                      
                                                                 </cfif> 
                                                                 
                                                             
                                                          
															
															
                                                             <!---  ---- END  ---- calculate last_water_date and days_since_last_water  --------- --->
                                                       
                                                       
                                                    
                                                    
                                                    
                                                    
                                                    
                                                       
                                                       
                                                       
                                                       
                                                       
                     
                     
      
      </cfloop>
      
      
      
    









</body>
</html>


<script>

</script>


