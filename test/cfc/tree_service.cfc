<cfcomponent output="false">

                <cffunction name="save_tree" access="remote" returnType="any" returnFormat="json" output="false">
                    
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
                                         
                                         <cfset remove_tree_list = json_post.RemoveTreeList >
                                         <cfset on_site_replace_tree_list = json_post.OnSiteReplaceTreeList >
                                         <cfset off_site_replace_tree_list = json_post.OffSiteReplaceTreeList >
                                         
                                         
                                         
                                         
                                         <!---  -------------    insert -----------  remove tree --------------    
                                            <cfloop array="#remove_tree_list#">
                                         
                                                     <cfquery name="insert_remove_tree" datasource="#request.sqlconn#">
                                                     
                                                           INSERT INTO dbo.trees
			                                                ( 
                                                              id_pkg_site,
                                                              species,
                                                              location,
                                                              action,
                                                              notes
                                                     
                                                             ) 
                                                                Values 
                                                                (
                                                                  
                                                                
                                                                )
                                                     
                                                     </cfquery>
                                               
                                            </cfloop>
                                         
                                         
                                         
                                         
                                          --------- end ------ insert -----------  remove tree --------------    --->
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                    </cfif>
                            
                            
                                  <cfreturn json_post>
                                 <!---  <cfreturn requestBody>  --->
                                <!--- <cfreturn off_site_replace_tree_list>  --->
                    
                </cffunction>
    
    
    
    
    
    
    
    
    
	
</cfcomponent>