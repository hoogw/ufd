<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=5");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 3>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=7&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>


<!DOCTYPE html>

	<html>
		<head>
			<title>Sidewalk Repair Program - Super Admin</title>




			<link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons' rel="stylesheet">
  			<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
            
            <script src="https://cdn.jsdelivr.net/npm/babel-polyfill/dist/polyfill.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.js"></script>  
          

			<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
            
           
            
            
            
            
            
            <script  src="../js/superAdmin.js" type="text/javascript" defer></script>    <!---  must use 'defer' to make it run last, after babel-polyfill completed  --->
            
            
            
            
            <style>
				  [v-cloak] {
					display: none;
				  }
			</style>
            
            
            
            
            
            </head>
            
            


<cfquery name="getLogins" datasource="#request.sqlconn#" dbtype="ODBC">
SELECT * FROM dbo.tblUsers WHERE user_id NOT IN (1,50)
</cfquery>

<cfoutput>

<body>



    <div id="app">
        <v-app id="inspire">
        
       
   
         <!--- bug fix, you must Hiding template before it is rendered  by add v-cloak 
         
         <div id="app">
              <div v-cloak>
                Hello {{ name }}
              </div>
            </div>
            
            <style>
              [v-cloak] {
                display: none;
              }
            </style>
         
		 --->
		 
         
    <div v-cloak>
    
    
     
      <v-toolbar flat color="white">
     
      <!---
      <v-toolbar flat color="rgb(231,242,252)">
       --->
      
      
      <!---
            <v-toolbar-title>Super Admin</v-toolbar-title>
            <v-divider
              class="mx-2"
              inset
              vertical
            ></v-divider>
			
	--->		
			
            
           		 <v-text-field
                              v-model="search"
                              append-icon="search"
                              label="Search"
                              single-line
                              hide-details
        		></v-text-field>
        
            <v-spacer></v-spacer>
            
            
            <v-dialog v-model="dialog" max-width="500px">
        
               <!---
						<v-btn  slot="activator" color="primary" dark class="mb-2">Add New User</v-btn>
						
						rgb(59,106,151)
						#3b6a97  //  hex color code must conver to rgb, because # will cause cold fusion failure !!!!
						
						here is how to convert 
						https://www.rapidtables.com/convert/color/hex-to-rgb.html
				
				
				--->
                
                
                <v-btn  slot="activator" color="rgb(59,106,151)" dark class="mb-2">Add New User</v-btn>
          
          		<v-card>
                        <v-card-title>
                          <span class="headline">{{ formTitle }}</span>
                        </v-card-title>
  
  
            			<v-card-text>
            
              					<v-container grid-list-md>
              
                                        <v-layout wrap>
                                        
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.full_name" label="full_name"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.name" label="name"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.password" label="password"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.agency" label="agency"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.level" label="level"></v-text-field>
                                                          </v-flex>
                                                          
                                                          
                                                          
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.power" label="power"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.cert" label="cert"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.ufd" label="ufd"></v-text-field>
                                                          </v-flex>
                                                          <v-flex xs12 sm6 md4>
                                                            <v-text-field v-model="editedItem.report" label="report"></v-text-field>
                                                          </v-flex>
                                          
                                          
                                          
                                          
                                        </v-layout>
              					</v-container>
              
           					 </v-card-text>
                             
                             
                             
  
                                <v-card-actions>
                                  <v-spacer></v-spacer>
                                  <v-btn color="blue darken-1" flat @click.native="close">Cancel</v-btn>
                                  <v-btn color="blue darken-1" flat @click.native="save">Save</v-btn>
                                </v-card-actions>
                                
                                
                                
          				</v-card>
          
        		</v-dialog>
        
      </v-toolbar>
      
      
      
      
              <v-data-table
                :headers="headers"
                :items="user"
              
                :loading="progress_bar_loading"    <!--- ----- progressing bar indicator --------- true: show ---------- false: hide  --->
                
                
                :search="search"
               <!---  hide-actions  --->      <!--- ----- hide/show  pagination -------------  --->
                class="elevation-1"
                
                
              >
            
					
                    
                    <v-progress-linear slot="progress"  indeterminate></v-progress-linear>
              
                                    <template slot="items" slot-scope="props" >
                                      <td>{{ props.item.full_name }}</td>
                                      <td class="text-xs-left">{{ props.item.name }}</td>
                                      <td class="text-xs-left">{{ props.item.password }}</td>
                                      <td class="text-xs-left">{{ props.item.agency }}</td>
                                      <td class="text-xs-left">{{ props.item.level }}</td>
                                      
                                      
                                      <td class="text-xs-left">{{ props.item.power }}</td>
                                      <td class="text-xs-left">{{ props.item.cert }}</td>
                                      <td class="text-xs-left">{{ props.item.ufd }}</td>
                                      <td class="text-xs-left">{{ props.item.report }}</td>
                                      
                                      
                                      
                                      <td class="justify-center layout px-0">
                                        <v-icon
                                          small
                                          class="mr-2"
                                          @click="editItem(props.item)"
                                        >
                                          edit
                                        </v-icon>
                                        <v-icon
                                          small
                                          @click="deleteItem(props.item)"
                                        >
                                          delete
                                        </v-icon>
                                      </td>
                                    </template>
                                    
                                    
                                    <template slot="no-data">
                                      <v-btn color="primary" @click="initialize">Reset</v-btn>
                                    </template>
                
                
                                     
                                        
                
                
                                    <v-alert slot="no-results" :value="true" color="error" icon="warning">
                                      Your search for "{{ search }}" found no results.
                                    </v-alert>
                
              </v-data-table>
      
      
      
    </div>
    

    
              
              
              
            </v-app>
          </div>
    
    
	
      </body>
</cfoutput>








<script>

		<cfoutput>
		var url = "#request.url#";
		</cfoutput>
		
		
		
		
		

</script>




 

</html>


            

				

	


