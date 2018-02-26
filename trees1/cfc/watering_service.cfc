<cfcomponent output="false">

<!---
<!--- set all ajax request url with following parameters, then you don't need to add them to every URL  --->
<cfset url.returnformat="json" >
<cfset url.queryformat="struct" >
--->



 <!---   ===============  =================  save_all_current_watering_date =========================   --->
                
                     
                     <cffunction name="save_all_current_watering_date" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                    <!---
                                                Get the HTTP request body content.
                                                NOTE: We have to use toString() as an intermediary method
                                                call since the JSON packet comes across as a byte array
                                                (binary data) which needs to be turned back into a string before
                                                ColdFusion can parse it as a JSON value.
                                                        --->
                                                
                                                <cfset requestBody = toString( getHttpRequestData().content ) />
                                    
                                                    <!--- Double-check to make sure it's a JSON value. --->
                                                   
                                                   
                                                    <cfif isJSON( requestBody )>
                                                    
                                                    
                                                        <cfset json_post = deserializeJson( requestBody ) >
                                                        
                                                        
                                                        <!--- Echo back POST data.
                                                        <cfdump
                                                            var="#deserializeJSON( requestBody )#"
                                                            label="HTTP Body"
                                                            />
                                                         --->
                                                         
                                                         
                                                            
                                                          
                                                            <cfset _all_current_watering_date        = json_post>
                                                            
                
                                                     </cfif>
                                                     
                                                     
                                                     
                                                     <!---     ******   start insert into database     ******  --->     
								
										
                                             <cftransaction action="begin">
                                                <cftry>
                                                 
                                                 
                                         
                                         			<!---  -------------    insert -----------  water date -----------  --->
										 
                                         
                                                              <!---  <cfloop array="#_all_current_watering_date#" item="each_item" index="_index">    you can not use both item and index --->  
                                                              <cfloop array="#_all_current_watering_date#"  index="_index">
                                                         
                                                                            
                                                                             <cfif StructKeyExists( _index, "ID")>
                                                                                <cfset _tree_id = _index.ID>
                                                                             <cfelse>
                                                                                <cfset _tree_id = "">
                                                                            </cfif>
                                                                            
                                                     
                                                     
                                                                               <cfif StructKeyExists( _index, "Current_Water_Date")>
                                                                                <cfset _current_watering_date = _index.Current_Water_Date>
                                                                             <cfelse>
                                                                                <cfset _current_watering_date = "">
                                                                            </cfif>
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                                              <cfquery name="insert_current_watering_date" datasource="#request.sqlconn2#">
                                                                                         
                                                                                          INSERT INTO dbo.water
                                                                                                                ( 
                                                                                                                  pk_id,
                                                                                                                  date
                                                                                                         
                                                                                                                 ) 
                                                                                                                    Values 
                                                                                                                    (
                                                                                                                      #_tree_id#,
                                                                                                                      '#_current_watering_date#'
                                                                                                                    )
                                                                                         
                                                                                                            
                                                                                             
                                                                               </cfquery>
                                                                               
                                                                               
                                                                        </cfloop>       
                                                                               
                                                                               
                                                                     			<cftransaction action="commit" />
                      
																					  <!--- something happened, roll everyting back ---> 
                                                                                      <cfcatch type="any">
                                                                                     
                                                                                                                    <cftransaction action="rollback" />
                                                                                                                    
                                                                                                                     
                                                                                                                    <!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                                                    
                                                                                                                     <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                                                     
                                                                                                                     
                                                                                                                    <cfreturn _error>
                                                                                                                    <cfabort>
                                                                                                                    
                                                                                      </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                                               </cftry>
                                                            </cftransaction>            
                                                                               
                                                       
                                                       <cfset _result = "success"/>  
                                                       
                                                    <cfreturn _result>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  save_all_current_watering_date  =========================   --->










                     <!---   ===============  =================  get_last_watering_date =========================   --->
                
                     
                     <cffunction name="get_last_watering_date" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                    <!---
                                                Get the HTTP request body content.
                                                NOTE: We have to use toString() as an intermediary method
                                                call since the JSON packet comes across as a byte array
                                                (binary data) which needs to be turned back into a string before
                                                ColdFusion can parse it as a JSON value.
                                                        --->
                                                
                                                <cfset requestBody = toString( getHttpRequestData().content ) />
                                    
                                                    <!--- Double-check to make sure it's a JSON value. --->
                                                   
                                                   
                                                    <cfif isJSON( requestBody )>
                                                    
                                                    
                                                        <cfset json_post = deserializeJson( requestBody ) >
                                                        
                                                        
                                                        <!--- Echo back POST data.
                                                        <cfdump
                                                            var="#deserializeJSON( requestBody )#"
                                                            label="HTTP Body"
                                                            />
                                                         --->
                                                         
                                                         
                                                            
                                                            <cfset _tree_id        = json_post.tree_id        >
                                                           
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_last_watering_date" datasource="#request.sqlconn2#">
                                                                                         
                                                                  
                                                                  SELECT max(date) 
                                                                  FROM water
                                                                  where pk_id = #_tree_id# 
                                                                                    
                                                                     
                                                       </cfquery>
                                                       
                                                    <cfreturn select_last_watering_date>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get_last_watering_date  =========================   --->
                
                
                
                
                
                  <!---   ===============  =================  save_current_watering_date =========================   --->
                
                     
                     <cffunction name="save_current_watering_date" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                    <!---
                                                Get the HTTP request body content.
                                                NOTE: We have to use toString() as an intermediary method
                                                call since the JSON packet comes across as a byte array
                                                (binary data) which needs to be turned back into a string before
                                                ColdFusion can parse it as a JSON value.
                                                        --->
                                                
                                                <cfset requestBody = toString( getHttpRequestData().content ) />
                                    
                                                    <!--- Double-check to make sure it's a JSON value. --->
                                                   
                                                   
                                                    <cfif isJSON( requestBody )>
                                                    
                                                    
                                                        <cfset json_post = deserializeJson( requestBody ) >
                                                        
                                                        
                                                        <!--- Echo back POST data.
                                                        <cfdump
                                                            var="#deserializeJSON( requestBody )#"
                                                            label="HTTP Body"
                                                            />
                                                         --->
                                                         
                                                         
                                                            
                                                            <cfset _tree_id                      = json_post.tree_id>
                                                            <cfset _current_watering_date        = json_post.current_watering_date>
                                                            
                
                                                     </cfif>
                                                     
                                                      <cfquery name="insert_current_watering_date" datasource="#request.sqlconn2#">
                                                                 
                                                                  INSERT INTO dbo.water
                                                                                        ( 
                                                                                          pk_id,
																						  date
                                                                                 
                                                                                         ) 
                                                                                            Values 
                                                                                            (
                                                                                              #_tree_id#,
                                                                                              '#_current_watering_date#'
                                                                                            )
                                                                 
                                                                                    
                                                                     
                                                       </cfquery>
                                                       
                                                       <cfset _result = "success"/>  
                                                       
                                                    <cfreturn _result>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  save_current_watering_date  =========================   --->
                
                
                
                
                  <!---   ===============  =================  get_watering_history =========================   --->
                
                     
                     <cffunction name="get_watering_history" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                    <!---
                                                Get the HTTP request body content.
                                                NOTE: We have to use toString() as an intermediary method
                                                call since the JSON packet comes across as a byte array
                                                (binary data) which needs to be turned back into a string before
                                                ColdFusion can parse it as a JSON value.
                                                        --->
                                                
                                                <cfset requestBody = toString( getHttpRequestData().content ) />
                                    
                                                    <!--- Double-check to make sure it's a JSON value. --->
                                                   
                                                   
                                                    <cfif isJSON( requestBody )>
                                                    
                                                    
                                                        <cfset json_post = deserializeJson( requestBody ) >
                                                        
                                                        
                                                        <!--- Echo back POST data.
                                                        <cfdump
                                                            var="#deserializeJSON( requestBody )#"
                                                            label="HTTP Body"
                                                            />
                                                         --->
                                                         
                                                         
                                                            
                                                            <cfset _tree_id        = json_post.tree_id        >
                                                           
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_watering_history" datasource="#request.sqlconn2#">
                                                                                         
                                                                  
                                                                  SELECT date 
                                                                  FROM water
                                                                  where pk_id = #_tree_id# 
                                                                  order by convert(datetime, date, 101) DESC
                                                                                    
                                                                     
                                                       </cfquery>
                                                       
                                                    <cfreturn select_watering_history>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get_watering_history  =========================   --->
                
                
                
                
                
                
                
                
                
				

	
</cfcomponent>