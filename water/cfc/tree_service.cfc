<cfcomponent output="false">

<!---
<!--- set all ajax request url with following parameters, then you don't need to add them to every URL  --->
<cfset url.returnformat="json" >
<cfset url.queryformat="struct" >
--->



<!--- ##############################  Tree Edit ############################  --->


<!---   ===============  =================  mark_as_removed =========================   --->
                
                     
                     <cffunction name="mark_as_removed" access="remote" returnType="any" returnFormat="json" output="false">
                                    
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
                                                        
                                                              
                                                             <cfif StructKeyExists( json_post, "mark_as_removed")>
                                                                                 <cfset mark_as_removed_list 			= json_post.mark_as_removed >
                                                                             <cfelse>
                                                                                 <cfset mark_as_removed_list 			= [] >
                                                                            </cfif>
                                                            
                                                            
                                                     </cfif>
                                                     
                                                     
                                                                     <cfloop array="#mark_as_removed_list#"  index="_index">
                                                         
                                                                            
                                                                            <cfif StructKeyExists( _index, "removed_id")>
                                                                                <cfset _removed_id = _index.removed_id>
                                                                             <cfelse>
                                                                                <cfset _removed_id = 0>
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                           
                                                                      
                                                                                 <cfquery name="mark_as_removed" datasource="#request.sqlconn2#">
                                                                                 
                                                                                        update trees
                                                                                        set removed = 'removed'
                                                                                        where id = #_removed_id#
                                                                                 
                                                                                 </cfquery>
                                                                     
                                                                    
                                                              
                                                                     
                                                            			</cfloop>
                                                       
                                                     <!--- success  --->
                                              		<cfset _result = "marked_removed_done"/>   
                                                    <cfreturn _result>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  mark_as_removed  =========================   --->




                <!---   ===============  =================  get site_note =========================   --->
                
                     
                     <cffunction name="get_site_note" access="remote" returnType="any" returnFormat="json" output="false">
                                    
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
                                                         
                                                         
                                                            <cfset _primary_key_id = json_post.primary_key_id >
                                                            <cfset _type_id        = json_post.type_id        >
                                                            <cfset _package_no     = json_post.package_no     >
                                                            <cfset _site_id        = json_post.site_id        >
                                                            <cfset _crm_no         = json_post.crm_no         >
                                                            <cfset _rebate         = json_post.rebate         >
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_site_note" datasource="#request.sqlconn2#">
                                                                                         
                                                                  SELECT notes
                                                                  FROM main
                                                                  where id = #_primary_key_id# 
                                                                                    
                                                                     
                                                       </cfquery>
                                                       
                                                    <cfreturn select_site_note>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get Site_note  =========================   --->








				<!---   ===============  =================  get tree info  Remove Tree =========================   --->
                
                     
                     <cffunction name="getTree_remove" access="remote" returnType="any" returnFormat="json" output="false">
                                    
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
                                                         
                                                         
                                                            <cfset _primary_key_id = json_post.primary_key_id >
                                                            <cfset _type_id        = json_post.type_id        >
                                                            <cfset _package_no     = json_post.package_no     >
                                                            <cfset _site_id        = json_post.site_id        >
                                                            <cfset _crm_no         = json_post.crm_no         >
                                                            <cfset _rebate         = json_post.rebate         >
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_remove_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                  SELECT *
                                                                  FROM [UFD_Inventory].[dbo].[trees]
                                                                  where id_pkg_site = #_primary_key_id# and action = 1  and removed is null                    
                                                                                                
                                                       </cfquery>
                                                       
                                                    <cfreturn select_remove_tree>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get tree info   Remove Tree  =========================   --->




                <!---   ===============  =================  get tree info  on site replace Tree =========================   --->
                
                     
                     <cffunction name="getTree_onSite" access="remote" returnType="any" returnFormat="json" output="false">
                                    
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
                                                         
                                                         
                                                            <cfset _primary_key_id = json_post.primary_key_id >
                                                            <cfset _type_id        = json_post.type_id        >
                                                            <cfset _package_no     = json_post.package_no     >
                                                            <cfset _site_id        = json_post.site_id        >
                                                            <cfset _crm_no         = json_post.crm_no         >
                                                            <cfset _rebate         = json_post.rebate         >
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_onsite_replace_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                  SELECT *
                                                                  FROM [UFD_Inventory].[dbo].[trees]
                                                                  where id_pkg_site = #_primary_key_id# and action = 2 and removed is null                          
                                                                                                
                                                       </cfquery>
                                                       
                                                    <cfreturn select_onsite_replace_tree>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get tree info   on site replace Tree  =========================   --->



                      <!---   ===============  =================  get tree info  off site replace Tree =========================   --->
                
                     
                     <cffunction name="getTree_offSite" access="remote" returnType="any" returnFormat="json" output="false">
                                    
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
                                                         
                                                         
                                                            <cfset _primary_key_id = json_post.primary_key_id >
                                                            <cfset _type_id        = json_post.type_id        >
                                                            <cfset _package_no     = json_post.package_no     >
                                                            <cfset _site_id        = json_post.site_id        >
                                                            <cfset _crm_no         = json_post.crm_no         >
                                                            <cfset _rebate         = json_post.rebate         >
                
                                                     </cfif>
                                                     
                                                      <cfquery name="select_offsite_replace_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                  SELECT *
                                                                  FROM [UFD_Inventory].[dbo].[trees]
                                                                  where id_pkg_site = #_primary_key_id# and action = 3 and removed is null                          
                                                                                                
                                                       </cfquery>
                                                       
                                                    <cfreturn select_offsite_replace_tree>
                                            
                                        </cffunction>
                
                
                <!---   ===============  ======  End   ===========  get tree info   off site replace Tree  =========================   --->





<!--- ##############################  End   Tree Edit ############################  --->











<!---   ===============  ================= ********    Search site    ************   =========================   --->


   <cffunction name="search_site" access="remote" returnType="any" returnFormat="json" output="false">
		<!--- <cfargument name="package_no" required="true">  --->
		
        
        
        <cfquery name="search_site_all" datasource="#request.sqlconn2#" dbtype="ODBC">
		 
     
             Select * from view_search_site 
       
       
		</cfquery>
        
        
       
        
		<cfreturn search_site_all>
		
	</cffunction>




<!---   ===============  ================= ********     End   ------  Search site    ************   =========================   --->






<!---   ===============  ================= ********    Search tree    ************   =========================   --->


   <cffunction name="search_tree" access="remote" returnType="any" returnFormat="json" output="false">
		 <cfquery name="search_tree_all" datasource="#request.sqlconn2#" dbtype="ODBC">
      <!---   Select * from search_tree where deleted = 0   --->
      
              Select * from vw_search_tree where deleted = 0
         </cfquery>
        <cfreturn search_tree_all>	
	</cffunction>






     <cffunction name="search_tree_by" access="remote" returnType="any" returnFormat="json" output="false">
 
          <cfargument name="dmt" required="true"> 
          <cfargument name="dlt" required="true">
          
          
          
          
          <cfif dmt GT 0 AND dlt GT 0>
                     <cfquery name="search_tree_by_dmt_dlt" datasource="#request.sqlconn2#" dbtype="ODBC">
                     Select * from vw_search_tree 
                     where deleted = 0
                     and days_since_last_water >= #dmt# 
                     and days_since_last_water <= #dlt#
                     </cfquery>
                    <cfreturn search_tree_by_dmt_dlt>	
        
          </cfif>
          
          
          
          <cfif dmt GT 0 AND dlt EQ 0>
                   
                     <cfquery name="search_tree_by_dmt_dlt" datasource="#request.sqlconn2#" dbtype="ODBC">
                     Select * from vw_search_tree 
                     where deleted = 0
                     and days_since_last_water > #dmt# 
                     
                     </cfquery>
                    <cfreturn search_tree_by_dmt_dlt>	
          
          
          </cfif>
          
          
          <cfif dmt EQ 0 AND dlt GT 0>
                   
                     <cfquery name="search_tree_by_dmt_dlt" datasource="#request.sqlconn2#" dbtype="ODBC">
                     Select * from vw_search_tree 
                     where deleted = 0
                     and days_since_last_water < #dlt# 
                     
                     </cfquery>
                    <cfreturn search_tree_by_dmt_dlt>	
          
          
          </cfif>
          
          
           <cfif dmt EQ 0 AND dlt EQ 0>
                   
                     <cfquery name="search_tree_by_dmt_dlt" datasource="#request.sqlconn2#" dbtype="ODBC">
                     Select * from vw_search_tree 
                     where deleted = 0
                    
                     
                     </cfquery>
                    <cfreturn search_tree_by_dmt_dlt>	
          
          
          </cfif>
          
          
        
	</cffunction>


<!---   ===============  ================= ********     End   ------  Search tree    ************   =========================   --->











<!---   ===============  =================  save tree =========================   --->


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
                                         
                                         
                                            <cfset _primary_key_id = json_post.primary_key_id >
											<cfset _type_id        = json_post.type_id        >
                                            <cfset _package_no     = json_post.package_no     >
                                            <cfset _site_id        = json_post.site_id        >
                                            <cfset _crm_no         = json_post.crm_no         >
                                            <cfset _rebate         = json_post.rebate         >
                                            
                                          
                                            
                                            
                                            
                                            <cfif StructKeyExists( json_post, "RemoveTreeList")>
                                                                                 <cfset remove_tree_list 			= json_post.RemoveTreeList >
                                                                             <cfelse>
                                                                                 <cfset remove_tree_list 			= [] >
                                                                            </cfif>
                                            
                                            
                                            <cfif StructKeyExists( json_post, "OnSiteReplaceTreeList")>
                                                                                 <cfset on_site_replace_tree_list   = json_post.OnSiteReplaceTreeList >
                                                                             <cfelse>
                                                                                 <cfset OnSiteReplaceTreeList 			= [] >
                                                                            </cfif>
                                            
                                            <cfif StructKeyExists( json_post, "OffSiteReplaceTreeList")>
                                                                                  <cfset off_site_replace_tree_list  = json_post.OffSiteReplaceTreeList >
                                                                             <cfelse>
                                                                                 <cfset OffSiteReplaceTreeList 			= [] >
                                                                            </cfif>
                                        
                                         
                                        
                                         
                                         
                                         <cfif StructKeyExists( json_post, "site_note")>
                                                                                <cfset _site_note = json_post.site_note>
                                                                             <cfelse>
                                                                                <cfset _site_note = "">
                                                                            </cfif>
                                         
                                         
                                         
                                         
                                         
							       </cfif>	 
                                         
                                         
                                         
                                       
                                    
								<!---     ******   start insert into database     ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                         
                                         			<!---  -------------    insert -----------  remove tree -----------  --->
										 
                                         
															 <cfset _test = "{'RemoveTree':[">
                                                         
                                                         
                                                           
                                                         
                                                              <!---  <cfloop array="#remove_tree_list#" item="each_item" index="_index">    you can not use both item and index --->  
                                                              <cfloop array="#remove_tree_list#"  index="_index">
                                                         
                                                                            
                                                                             <cfif StructKeyExists( _index, "tree_id")>
                                                                                <cfset _tree_id = _index.tree_id>
                                                                             <cfelse>
                                                                                <cfset _tree_id = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "location")>
                                                                                <cfset _location = _index.location>
                                                                             <cfelse>
                                                                                <cfset _location = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "note")>
                                                                                <cfset _note = _index.note>
                                                                             <cfelse>
                                                                                <cfset _note = "">
                                                                            </cfif>
                                                                        
                                                                            
                                                                            
                                                                            
                                                                          <!---  only when user choose specie, 'selectedSpecie' exist.  only when pre-define 'init_specieSelected', it exist    --->
                                                                          <!--- if "selectedSpecie" exist, means user choose the option match one of selection, --->
                                                                          <!---  else means user input does not match any one, or user did not touch/change, it is old value,  --->
                                                                          <!--- Front js,  set 'none match input value' to "init_specieSelected", if old value, already in "init_specieSelected"--->
                                                                          
                                                                            <cfif StructKeyExists( _index, "selectedSpecie")>
																					
                                                                                    <!--- pre-define init value would not create 'title' attribute, no not work  --->
                                                                                       <!--- <cfset _specie = _index.selectedSpecie.title>  --->
                                                                                    <cfset _specie = _index.selectedSpecie.originalObject.name>  
                                                                                 
																				 <cfelseif StructKeyExists( _index, "init_specieSelected")>
                                                                                    	
																						<cfset _specie = _index.init_specieSelected.name>
                                                                                
                                                                                     <cfelse>
                                                                                           <cfset _specie ="">
                                                                            </cfif>
                                                                           <!--- if just add new line, neither  'selectedSpecie' nor  'init_specieSelected' exist --->
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
                                                                           
                                                                            <cfset _test = _test & "{'_primary_key_id':" & _primary_key_id & ", '_type_id':" & _type_id & " ,'_specie': '" & _specie 
                                                                            & "' ,'_location': '" & _location & "' , '_note': '"&_note & "'},">
                                                               
                                                                   
                                                                      
                                                                                <cfif _tree_id EQ -1>
                                                                      
                                                                                         <cfquery name="insert_remove_tree" datasource="#request.sqlconn2#">
                                                                                         
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
                                                                                                      #_primary_key_id#,
                                                                                                      '#_specie#',               <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      '#_location#',
                                                                                                      1,
                                                                                                      '#_note#'
                                                                                                    )
                                                                                         
                                                                                         </cfquery>
                                                                                         
                                                                                  <cfelse>
                                                                                          
                                                                                          
                                                                                          <cfquery name="update_remove_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                                               UPDATE dbo.trees
                                                                                                SET 
                                                                                                      id_pkg_site = #_primary_key_id# ,
                                                                                                      species = '#_specie#',                  <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      location = '#_location#',
                                                                                                      action = 1 ,
                                                                                                      notes = '#_note#'
                                                                                               WHERE 
                                                                                                      id = #_tree_id#
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                                   
                                                                                   
                                                                                   
                                                                                   </cfif>
                                                                     
                                                                    
                                                              
                                                                     
                                                            			</cfloop>
                                                         
                                                              			
                                                        
                                                        
                                                        
                                                          <!--------- end ------ insert -----------  remove tree --------------    --->
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <!---  -------------    insert -----------  On Site Replace tree tree -----------  --->
										 
                                                              
															 <cfset _test_onsite = "{'on_site_replace_tree':["  >
                                                               
                                                                
                                                                
                                                             
                                                            
                                                            <cfloop array="#on_site_replace_tree_list#"  index="_index">
                                                         
                                                                            
                                                                            <cfif StructKeyExists( _index, "tree_id")>
                                                                                <cfset _tree_id = _index.tree_id>
                                                                             <cfelse>
                                                                                <cfset _tree_id = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "location")>
                                                                                <cfset _location = _index.location>
                                                                             <cfelse>
                                                                                <cfset _location = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "note")>
                                                                                <cfset _note = _index.note>
                                                                             <cfelse>
                                                                                <cfset _note = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                        
                                                                       <!---  only when user choose specie, 'selectedSpecie' exist.  only when pre-define 'init_specieSelected', it exist    --->
                                                                            <cfif StructKeyExists( _index, "selectedSpecie")>
                                                                            
																					<!--- pre-define init value would not create 'title' attribute, no not work  --->
                                                                                       <!--- <cfset _specie = _index.selectedSpecie.title>  --->
                                                                                    <cfset _specie = _index.selectedSpecie.originalObject.name>  
                                                                                 
																				 <cfelseif StructKeyExists( _index, "init_specieSelected")>
                                                                                    	
																						<cfset _specie = _index.init_specieSelected.name>
                                                                                
                                                                                     <cfelse>
                                                                                           <cfset _specie ="">
                                                                            </cfif>
                                                                           <!--- if just add new line, neither  'selectedSpecie' nor  'init_specieSelected' exist --->
                                                                           
                                                                           
                                                                           
                                                                           
                                                                            <cfif StructKeyExists( _index, "planting_date")>
                                                                                <cfset _planting_date = _index.planting_date>
                                                                             <cfelse>
                                                                                <cfset _planting_date = "1900-01-01">     <!--- null, NULL, "" failed to convert to Date --->
                                                                            </cfif>
                                                                           
                                                                           <cfif StructKeyExists( _index, "planting_date")>
                                                                                <cfset _start_watering_date = _index.planting_date>
                                                                             <cfelse>
                                                                                <cfset _start_watering_date= "1900-01-01">
                                                                            </cfif>
                                                                           
                                                                            <cfif StructKeyExists( _index, "parkway_size")>
                                                                                 <cfset _parkway_size = _index.parkway_size>
                                                                             <cfelse>
                                                                                <cfset _parkway_size = "">
                                                                            </cfif>
                                                                            
                                                                            <cfif StructKeyExists( _index, "overhead_wire")>
                                                                                <cfset _overhead_wire = _index.overhead_wire>
                                                                             <cfelse>
                                                                                <cfset _overhead_wire = "">
                                                                            </cfif>
                                                                            
                                                                            <cfif StructKeyExists( _index, "sub_position")>
                                                                               <cfset _sub_position = _index.sub_position>
                                                                             <cfelse>
                                                                                <cfset _sub_position = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "concrete_completed")>
                                                                                 <cfset _concrete_completed = _index.concrete_completed>
                                                                             <cfelse>
                                                                                <cfset _concrete_completed = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "post_inspected")>
                                                                                <cfset _post_inspected = _index.post_inspected>
                                                                             <cfelse>
                                                                                <cfset _post_inspected = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            <cfset _test_onsite = _test_onsite & "{'planting_date':" & _planting_date & ", 'parkway_size':" & _parkway_size & " ,'_specie': '" & _specie 
                                                                            & "' ,'_location': '" & _location & "' , '_note': '"&_note & "'},">
                                                         
                                                                   
                                                                       
                                                                       
                                                                        <cfif _tree_id EQ -1>
                                                                          
                                                                               <cfquery name="insert_on_site_replace_tree" datasource="#request.sqlconn2#">
                                                                                 
                                                                                       INSERT INTO dbo.trees
                                                                                        ( 
                                                                                          id_pkg_site,
                                                                                          species,
                                                                                          location,
                                                                                          
                                                                                          planting_date,
                                                                                          watering_start_date,
                                                                                          parkway_size,
                                                                                          overhead_wires,
                                                                                          sub_position,
                                                                                          spd_concrete_work_completed,
                                                                                          ufd_post_inspected,
                                                                                          
                                                                                          action,
                                                                                          notes
                                                                                 
                                                                                         ) 
                                                                                            Values 
                                                                                            (
                                                                                              #_primary_key_id#,
                                                                                              '#_specie#',               <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                              '#_location#',
                                                                                              
                                                                                              
                                                                                              '#_planting_date#',
                                                                                              '#_start_watering_date#',
                                                                                              '#_parkway_size#',
                                                                                              '#_overhead_wire#',
                                                                                              '#_sub_position#',
                                                                                              '#_concrete_completed#',
                                                                                              '#_post_inspected#',
                                                                                              
                                                                                              
                                                                                              2,
                                                                                              '#_note#'
                                                                                            )
                                                                                 
                                                                                 </cfquery>
 
 
                                                                              <cfelse>
                                                                                          
                                                                                          
                                                                                          <cfquery name="update_on_site_replace_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                                               UPDATE dbo.trees
                                                                                                SET 
                                                                                                      id_pkg_site = #_primary_key_id# ,
                                                                                                      species = '#_specie#',                  <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      location = '#_location#',
                                                                                                      
                                                                                                      planting_date = '#_planting_date#',
                                                                                                      watering_start_date = '#_start_watering_date#',
                                                                                                      parkway_size = '#_parkway_size#',
                                                                                                      overhead_wires = '#_overhead_wire#',
                                                                                                      sub_position = '#_sub_position#',
                                                                                                      spd_concrete_work_completed = '#_concrete_completed#',
                                                                                                      ufd_post_inspected =  '#_post_inspected#',
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      action = 2 ,
                                                                                                      notes = '#_note#'
                                                                                               WHERE 
                                                                                                      id = #_tree_id#
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                                   
                                                                                </cfif>
                                                                       
                                                                       
                                                                       
                                                                                 
                                                                     
                                                                     
                                                                     
                                                            			</cfloop>
                                                                        
                                                                        
                                                                        <!--------- end ------ insert -----------  On Site Replace tree tree --------------    --->
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        <!---  -------------    insert -----------  Off Site Replace tree tree -----------  --->
										 
                                                              
															 <cfset _test_offsite = "{'off_site_replace_tree':["  >
                                                               
                                                                
                                                                
                                                             
                                                            
                                                            <cfloop array="#off_site_replace_tree_list#"  index="_index">
                                                         
                                                                            
                                                                            <cfif StructKeyExists( _index, "tree_id")>
                                                                                <cfset _tree_id = _index.tree_id>
                                                                             <cfelse>
                                                                                <cfset _tree_id = "">
                                                                            </cfif>
                                                         
                                                                            
                                                                            <cfif StructKeyExists( _index, "location")>
                                                                                <cfset _location = _index.location>
                                                                             <cfelse>
                                                                                <cfset _location = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "note")>
                                                                                <cfset _note = _index.note>
                                                                             <cfelse>
                                                                                <cfset _note = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                        
                                                                       <!---  only when user choose specie, 'selectedSpecie' exist.  only when pre-define 'init_specieSelected', it exist    --->
                                                                            <cfif StructKeyExists( _index, "selectedSpecie")>
                                                                            
																					   <!--- pre-define init value would not create 'title' attribute, no not work  --->
                                                                                       <!--- <cfset _specie = _index.selectedSpecie.title>  --->
                                                                                    <cfset _specie = _index.selectedSpecie.originalObject.name>   
                                                                                 
																				 <cfelseif StructKeyExists( _index, "init_specieSelected")>
                                                                                    	
																						<cfset _specie = _index.init_specieSelected.name>
                                                                                
                                                                                     <cfelse>
                                                                                           <cfset _specie ="">
                                                                            </cfif>
                                                                           <!--- if just add new line, neither  'selectedSpecie' nor  'init_specieSelected' exist --->
                                                                           
                                                                           
                                                                           
                                                                           
                                                                            <cfif StructKeyExists( _index, "planting_date")>
                                                                                <cfset _planting_date = _index.planting_date>
                                                                             <cfelse>
                                                                                <cfset _planting_date = "1900-01-01">     <!--- null, NULL, "" failed to convert to Date --->
                                                                            </cfif>
                                                                           
                                                                           <cfif StructKeyExists( _index, "planting_date")>
                                                                                <cfset _start_watering_date = _index.planting_date>
                                                                             <cfelse>
                                                                                <cfset _start_watering_date= "1900-01-01">
                                                                            </cfif>
                                                                           
                                                                            <cfif StructKeyExists( _index, "parkway_size")>
                                                                                 <cfset _parkway_size = _index.parkway_size>
                                                                             <cfelse>
                                                                                <cfset _parkway_size = "">
                                                                            </cfif>
                                                                            
                                                                            <cfif StructKeyExists( _index, "overhead_wire")>
                                                                                <cfset _overhead_wire = _index.overhead_wire>
                                                                             <cfelse>
                                                                                <cfset _overhead_wire = "">
                                                                            </cfif>
                                                                            
                                                                            <cfif StructKeyExists( _index, "sub_position")>
                                                                               <cfset _sub_position = _index.sub_position>
                                                                             <cfelse>
                                                                                <cfset _sub_position = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "concrete_completed")>
                                                                                 <cfset _concrete_completed = _index.concrete_completed>
                                                                             <cfelse>
                                                                                <cfset _concrete_completed = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            <cfif StructKeyExists( _index, "post_inspected")>
                                                                                <cfset _post_inspected = _index.post_inspected>
                                                                             <cfelse>
                                                                                <cfset _post_inspected = "">
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            <cfset _test_offsite = _test_offsite & "{'planting_date':" & _planting_date & ", 'parkway_size':" &
																			_parkway_size & " ,'_specie': '" & _specie 
                                                                            & "' ,'_location': '" & _location & "' , '_note': '"&_note & "'},">
                                                         
                                                                   
                                                                       
                                                                                
                                                                                 
                                                                                 
                                                                           <cfif _tree_id EQ -1>
                                                                          
                                                                                    <cfquery name="insert_off_site_replace_tree" datasource="#request.sqlconn2#">
                                                                                     
                                                                                           INSERT INTO dbo.trees
                                                                                            ( 
                                                                                              id_pkg_site,
                                                                                              species,
                                                                                              location,
                                                                                              
                                                                                              planting_date,
                                                                                              watering_start_date,
                                                                                              parkway_size,
                                                                                              overhead_wires,
                                                                                              sub_position,
                                                                                              spd_concrete_work_completed,
                                                                                              ufd_post_inspected,
                                                                                              
                                                                                              action,
                                                                                              notes
                                                                                     
                                                                                             ) 
                                                                                                Values 
                                                                                                (
                                                                                                  #_primary_key_id#,
                                                                                                  '#_specie#',               <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                  '#_location#',
                                                                                                  
                                                                                                  
                                                                                                  '#_planting_date#',
                                                                                                  '#_start_watering_date#',
                                                                                                  '#_parkway_size#',
                                                                                                  '#_overhead_wire#',
                                                                                                  '#_sub_position#',
                                                                                                  '#_concrete_completed#',
                                                                                                  '#_post_inspected#',
                                                                                                  
                                                                                                  
                                                                                                  3,
                                                                                                  '#_note#'
                                                                                                )
                                                                                     
                                                                                     </cfquery>
 
 
                                                                              <cfelse>
                                                                                          
                                                                                          
                                                                                          <cfquery name="update_off_site_replace_tree" datasource="#request.sqlconn2#">
                                                                                         
                                                                                               UPDATE dbo.trees
                                                                                                SET 
                                                                                                      id_pkg_site = #_primary_key_id# ,
                                                                                                      species = '#_specie#',                  <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      location = '#_location#',
                                                                                                      
                                                                                                      planting_date = '#_planting_date#',
                                                                                                      watering_start_date = '#_start_watering_date#',
                                                                                                      parkway_size = '#_parkway_size#',
                                                                                                      overhead_wires = '#_overhead_wire#',
                                                                                                      sub_position = '#_sub_position#',
                                                                                                      spd_concrete_work_completed = '#_concrete_completed#',
                                                                                                      ufd_post_inspected =  '#_post_inspected#',
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      action = 3 ,
                                                                                                      notes = '#_note#'
                                                                                               WHERE 
                                                                                                      id = #_tree_id#
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                                   
                                                                                </cfif>
                                                                                 
                                                                                 
                                                                                 
                                                                                 
                                                                     
                                                                     
                                                                     
                                                            			</cfloop>
                                                                        
                                                                        
                                                                        <!--------- end ------ insert -----------  Off Site Replace tree tree --------------    --->
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        <!---      -------------  update  ---------  site_note -------------------   --->
                                                                        
                                                                                  
                                                                        
                                                                                       <cfquery name="update_site_note" datasource="#request.sqlconn2#" result="update_site_note">
                                            
                                                                                              UPDATE dbo.main
                                                                                              
                                                                                              SET notes = '#_site_note#'
                                                                                              
                                                                                              WHERE id = #_primary_key_id#
                                            
                                            											</cfquery>
                                                                                   
                                                                        
                                                                        <!---      -------------  update  ---------  site_note -------------------   --->
                                                                        
                                                                        
                                                                        
                                                                      
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                         
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
                                            
                                           
                                         
                                         
                                         
                                         
                                                         <!--- success  --->
                                              				<cfset _result = "success"/>  
                                                            
                                                             
                                                             
                                                             <!---
                                                             <cfset _test = REReplace(_test, ",+$", "") & "]}" />
                                                              <cfset _test = REReplace(_test, "\r\n", "")>
                                                             <!--- cfset _test_serialized_json = serializeJSON(_test) / --->
                                                             <cfreturn _test>  
                                                             --->
                                                             
                                                             
                                                              <!---
                                                             
                                                             <cfreturn _test_onsite>
                                                             
															
                                                             <cfreturn _test_offsite>
															 
                                                              --->
															  
															  
															  
                                                        <!---   <cfreturn    requestBody>  --->
                                             			 <cfreturn _result> 
                                                        
                                                                                                  
                                        
                                         
                                         
                                         
                                         
                                         
                               
                                         
                                         
                                   
                            
                           <!---   ******  End start insert into database  **********  --->   
                           
						   
						  
                             
                            
                            
                            
                                  <!---  <cfreturn json_post>  --->
                                 <!---  <cfreturn requestBody>  --->
                                <!--- <cfreturn off_site_replace_tree_list>  --->
                    
                	</cffunction>



<!---   ===============  end  =================  save tree =========================   --->













<!---   ------------------------- Insert into main table  ----------------------------------    --->


<cffunction name="addTreeSite" access="remote" returnType="any" returnFormat="json" output="false">
<!---  <cffunction name="addTreeSite" access="remote" returnType="any" returnFormat="plain" output="false">   --->
		
        <cfargument name="sw_type" required="false">
        <cfargument name="sw_pkg_no" required="false">
		<cfargument name="sw_site_no" required="false">
		
		
		<cfargument name="sw_cd" required="false">
		
		<cfargument name="sw_rebate" required="false">
		<cfargument name="sw_crm" required="false">
		
		
		
		
		
		
		<cfif isdefined("session.userid") is false>
            <cfset _result = "login Expired, please login ">
		    <cfreturn _result>
			<cfabort>
		</cfif>
		
		
        
        
        
        
        
        
        
        
		
						<!---       ---------  sql parameter ----------          --->
                        <cfif len(trim(sw_type))>
                                   <cfset _program_type = sw_type>
                           <cfelse>
                                   <cfset _program_type = 0>
                        </cfif>
                        
                        <cfif len(trim(sw_pkg_no))>
                                   <cfset _boe_bid_package = sw_pkg_no>
                           <cfelse>
                                   <cfset _boe_bid_package = 0>
                        </cfif>
                        
                        
                        <cfif len(trim(sw_site_no))>
                                   <cfset  _boe_site = sw_site_no >
                           <cfelse>
                                   <cfset  _boe_site = 0>
                        </cfif>
                        
                        
                        <cfif len(trim(sw_cd))>
                                   <cfset _cd =sw_cd >
                           <cfelse>
                                   <cfset  _cd = 0>
                        </cfif>
                        
                        
                        <cfif len(trim(sw_rebate))>
                                   <cfset _rebate =sw_rebate >
                           <cfelse>
                                   <cfset  _rebate = 0>
                        </cfif>
                        
                        <cfif len(trim(sw_crm))>
                                   <cfset  _crm_number =sw_crm >
                           <cfelse>
                                     <cfset  _crm_number =sw_crm >
                        </cfif>
                        
                        
                        
                                
                          <!---  End     ---------   sql parameter ----------          ---> 
           
												
                                                
                    
                                
                                
                           <!---       ---------  check duplicat record ----------          --->     
                                
                                <!--- check BSS, BOE by site pacakge no. --->
                                <cfif _program_type NEQ 3>
                                      
                                              <cfquery name="check_duplicate_tree_site" datasource="#request.sqlconn2#" result="check_duplicate_result">
                                                    
                                                            select count(*) as _count from main
                                                            where       
                                                                       program_type = #_program_type# and
                                                                        boe_bid_package = #_boe_bid_package#  and  
                                                                        boe_site = #_boe_site#
                                              </cfquery>
                                              
                                              
                                                        
                                                 <cfif check_duplicate_tree_site._count gt 0> 
                                                       
                                                        <cfset _result = "Site already exist">
                                                        <cfreturn _result>
                                                        <cfabort> 
                                                 </cfif>  
                                             
                                </cfif>
                                
                                
                                
                                
                                 <!--- check Rebate by CRM no. --->
                                <cfif _program_type EQ 3>
                                                     
                                                      <cfquery name="check_duplicate_tree_site2" datasource="#request.sqlconn2#" result="check_duplicate_result2">
                                                    
                                                            select count(*) as _count from main
                                                            where       
                                                                       crm_number = '#_crm_number#'  <!--- this column is varchar(), MUST use single quote, otherwise will sql error --->
                                              </cfquery>
                                              
                                              
                                                        
                                                 <cfif check_duplicate_tree_site2._count gt 0> 
                                                       
                                                        <cfset _result = "Site already exist">
                                                        <cfreturn _result>
                                                        <cfabort> 
                                                 </cfif>  
                                
                                
                                </cfif>
                                             
                                                                
            
                          <!---       --------- End  ---  check duplicat record ----------          --->    
            
         
            
            
            
                                <!---       ---------  insert ----------          --->    
                                        <cftry>
                                            <cfquery name="add_tree_site" datasource="#request.sqlconn2#" result="insert_main_result">
                                            
                                                  INSERT INTO dbo.main
                                                                            (
                                                                                program_type
                                                                              
                                                                               ,boe_bid_package
                                                                               ,boe_site
                                                                               ,cd
                                                                               ,rebate
                                                                               ,crm_number
                                                                                 
                                                                             
                                                                             )
                                                                             
                                                   OUTPUT Inserted.id   <!---  get the inserted primary key id  --->                          
                                                                             
                                                                             
                                                                VALUES
                                                                               (
                                                                                    #_program_type#    <!---  program type is int, 1,2,3 NOT string !--->
                                                                                 
                                                                                   ,#_boe_bid_package#
                                                                                   ,#_boe_site#
                                                                                   ,#_cd#
                                                                                   ,'#_rebate#'
                                                                                   ,'#_crm_number#'    <!--- this column is varchar(), MUST use single quote, otherwise will sql error --->
                                                                            
																			   
                                                                               )
                                            
                                            
                                            </cfquery>
                                            
                                            <cfcatch type="database" >
                                                    <!--- Code to handle a database exception --->
                                                    <cfset _result = "Failed">
                                                     
                                                    <cfreturn _result>
                                                    <cfabort>
                                                    
                                                </cfcatch>	 
                                                <cfcatch type="any">
                                                    <!--- Code to handle all other exceptions --->
                                                    
                                                    <cfset _result = "Failed">
                                                 <!---    <cfset _result = _program_type >   --->
                                                    <cfreturn _result>
                                                    <cfabort>
                                                    
                                                </cfcatch>
                                            
                                        </cftry>
                                        
                                        
                                             <!--- success return inserted primary key id, not real site id,   --->
                                              <cfset _result = add_tree_site.id>  
                                              
                                            <!--- success return inserted real site id, not the primary key id   --->
                                            <!---  <cfset _result = #_boe_site#>  --->
                                               
                                               
                                             <cfreturn _result>
                                            
                                            
                                       <!---      End  ---------  insert ----------          --->        
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
		
	</cffunction>




<!---     not  use, can delete 

<cffunction name="addTreeSite_rebate" access="remote" returnType="any" returnFormat="plain" output="false">
		
       
		
		<cfargument name="sw_rebate" required="false">
		<cfargument name="sw_crm" required="true">
		
		
		
		
		
		
		<cfif isdefined("session.userid") is false>
            <cfset _result = "login Expired, please login ">
		    <cfreturn _result>
			<cfabort>
		</cfif>
		
		
        
        
        
        
        
        
        
        
		
						<!---       ---------  sql parameter ----------          --->
                        
                        
                        
                        <cfif len(trim(sw_cd))>
                                   <cfset _cd =sw_cd >
                           <cfelse>
                                   <cfset  _cd = 0>
                        </cfif>
                        
                        
                        <cfif len(trim(sw_rebate))>
                                   <cfset _rebate =sw_rebate >
                           <cfelse>
                                   <cfset  _rebate = 0>
                        </cfif>
                        
                        <cfif len(trim(sw_crm))>
                                   <cfset  _crm_number =sw_crm >
                           <cfelse>
                                     <cfset  _crm_number =sw_crm >
                        </cfif>
                        
                        
                        
                                
                          <!---  End     ---------   sql parameter ----------          ---> 
           
												
                                                
                      
                                
                                
                           <!---       ---------  check duplicat record ----------          --->     
                                
                                      
                                
                                 
                                             <cfquery name="check_duplicate_tree_site_rebate" datasource="#request.sqlconn2#" result="check_duplicate_result_rebate">
                                                    
                                                            select count(*) as _count from main
                                                            where   crm_number =  '#_crm_number#'   
                                              </cfquery>
                                              
                                              
                                                        
                                                 <cfif check_duplicate_tree_site_rebate._count gt 0> 
                                                       
                                                        <cfset _result = "Rebate already exist">
                                                        <cfreturn _result>
                                                        <cfabort> 
                                                 </cfif>  
                                 
                                 
                                 
                                  
                                             
                                             
                                             
                                                                
            
                          <!---       --------- End  ---  check duplicat record ----------          --->    
            
            
            
            
            
            
                                <!---       ---------  insert ----------          --->    
                                        <cftry>
                                            <cfquery name="add_tree_site_rebate" datasource="#request.sqlconn2#" result="insert_main_result_rebate">
                                            
                                                  INSERT INTO dbo.main
                                                                            (
                                                                                
                                                                                cd
                                                                               ,rebate
                                                                               ,crm_number
                                                                              
                                                                             
                                                                             )
                                                                             
                                                   OUTPUT Inserted.id   <!---  get the inserted primary key id  --->                          
                                                                             
                                                                             
                                                                VALUES
                                                                               (
                                                                                   
                                                                                   #_cd#
                                                                                   ,#_rebate#
                                                                                   ,'#_crm_number#'    <!--- this column is varchar(), MUST use single quote, otherwise will sql error --->
                                                                               
                                                                               )
                                            
                                            
                                            </cfquery>
                                            
                                            <cfcatch type="database" >
                                                    <!--- Code to handle a database exception --->
                                                    <cfset _result = "Failed">
                                                    <cfreturn _result>
                                                    <cfabort>
                                                    
                                                </cfcatch>	 
                                                <cfcatch type="any">
                                                    <!--- Code to handle all other exceptions --->
                                                    
                                                    <cfset _result = "Failed">
                                                    <cfreturn _result>
                                                    <cfabort>
                                                    
                                                </cfcatch>
                                            
                                        </cftry>
                                        
                                        
                                             <!--- success return inserted primary key id, not real site id,   --->
                                              <cfset _result = add_tree_site_rebate.id>  
                                              
                                            <!--- success return inserted real site id, not the primary key id   --->
                                            <!---  <cfset _result = #_boe_site#>  --->
                                               
                                               
                                             <cfreturn _result>
                                            
                                            
                                       <!---      End  ---------  insert ----------          --->        
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
		
	</cffunction>


 --->    


<!---   --------------     Get Program Type ---------------   --->

	<cffunction name="get_program_type" access="remote" returnType="any" returnFormat="json" output="false">
		
		

                    <cfquery name="query_get_all_program_type" datasource="#request.sqlconn2#" dbtype="ODBC">
                    
                     SELECT id, type FROM program_type ORDER BY id   
                    </cfquery>



		<cfreturn query_get_all_program_type>
		
	</cffunction>




<!---   -------------------------  get_cd_by_site  ----------------------------------    --->




<cffunction name="get_cd_by_site" access="remote" returnType="any" returnFormat="json" output="false">
		<cfargument name="site_no" required="true">
		
        
        
        <cfquery name="query_cd_by_site" datasource="#request.sqlconn#" dbtype="ODBC">
		 
     
             Select COUNCIL_DISTRICT from tblSites where ID = '#site_no#' 
       
       
		</cfquery>
        
        
       
        
		<cfreturn query_cd_by_site>
		
	</cffunction>












<!---   -------------------------  get site by package  ----------------------------------    --->


<cffunction name="get_site_by_package" access="remote" returnType="any" returnFormat="json" output="false">
		<cfargument name="package_no" required="true">
		
        
        
        <cfquery name="query_site_by_package" datasource="#request.sqlconn#" dbtype="ODBC">
		 
     
             Select ID, LOCATION_NO from tblSites where PACKAGE_NO = '#package_no#' 
       
       
		</cfquery>
        
        
       
        
		<cfreturn query_site_by_package>
		
	</cffunction>












<!---     -------------- get package by program type   -----------------                  --->


<cffunction name="get_package_by_program_type" access="remote" returnType="any" returnFormat="json" output="false">
		<cfargument name="program_type" required="true">
		
        
        
        <cfquery name="query_package_by_group" datasource="#request.sqlconn#" dbtype="ODBC">
		 
        <!--- Select PACKAGE_NO from tblPackages where PACKAGE_GROUP = 'BOE' --->
       Select PACKAGE_NO from tblPackages where PACKAGE_GROUP = '#program_type#' 
       <!---      Select * from tblPackages  --->
            
		</cfquery>
        
        
       
        
		<cfreturn query_package_by_group>
		
	</cffunction>








	
</cfcomponent>
