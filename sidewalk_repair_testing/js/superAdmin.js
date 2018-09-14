new Vue({
  el: '#app',
  data: () => ({
    dialog: false,
	
	search: '',
	
	// show v-data-table progress bar
	//progress_bar_loading: true,
	
    headers: [
      {
        text: 'Full Name',
        align: 'left',
        sortable: true,
        value: 'full_name'
      },
      { text: 'Login Name', align: 'left', sortable: true,  value: 'name' },
      { text: 'Password',   align: 'left', sortable: true, value: 'password' },
      { text: 'Agency',  align: 'left', sortable: true, value: 'agency' },
      { text: 'Level',  align: 'left', sortable: true, value: 'level' },
	  
	  { text: 'Power',  align: 'left', sortable: true, value: 'power' },
	  { text: 'Cert',  align: 'left', sortable: true, value: 'cert' },
	  { text: 'UFD',  align: 'left', sortable: true, value: 'ufd' },
	  { text: 'Report',  align: 'left', sortable: true, value: 'report' },
	  
	  
	  
	  
	  
	  
	  
      { text: 'Actions',  align: 'left',  value: 'name', sortable: false }
    ],
	
	
    user: [],
	
	
    editedIndex: -1,
	
    editedItem: {
      full_name: '',
      name: '',
	  password: '',
      agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: ''
      
    },
	
    defaultItem: {
      full_name: '',
      name: '',
	  password: '',
      agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: ''
	  
    }
  }),

  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Add New User' : 'Edit User'
    }
  },

  watch: {
    dialog (val) {
      val || this.close()
    }
  },



  created () {
	  
	 // Use creation hooks if you need to set things up in your component both during client rendering and server rendering. 
	 // You will not have access to the DOM or the target mounting element (this.$el) inside of creation hooks 
	  
    this.initialize()
  },

  
  mounted () {
	
	//Use mounted if You need to access or modify the DOM of your component immediately before or after the initial render.
	// Do not use mounted if You need to fetch some data for your component on initialization. Use created (or created + activated for keep-alive components) for this instead, especially if you need that data during server-side rendering.
	
	//this.initialize()
  },




  methods: {
	  
	  
    initialize () {
		
	/*	
      this.user = [
        {
          full_name: 'joe hu',
          name: 'jhu',
          password: 'jhu',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        
		{},
		{}
		
       ];
		
		*/
		
		
		
		
	                 var getUser_url = url + 'cfc/sw.cfc?method=getUser&returnformat=json&queryformat=struct';
	
	                console.log(getUser_url )
					
				/*
					You can use a plethora of options for doing Ajax calls such as Axios, vue-resource or better yet the browser's built in fetch API in modern browsers. 
					You can also use jQuery via $.ajax() API, which simply wraps the XHR object in a simple to use method call 
					but it's not recommended to include the whole jQuery library for the sake of using one method.
					https://www.techiediaries.com/vuejs-ajax-http/
					
					http://updates.html5rocks.com/2015/03/introduction-to-fetch
					The Fetch API provides a JavaScript interface for accessing and manipulating parts of the HTTP pipeline, such as requests and responses. 
					It also provides a global fetch() method that provides an easy, logical way to fetch resources asynchronously across the network.
					
				*/
				
				
				    //   **********  must use self = this ************** 
					// this reference vue-app.  must pass it to self, then pass into callback function (success call back)
					var self = this;  
					
					
					
					
					// show v-data-table progress bar
					 self.progress_bar_loading = true
					 
					 
					 
					
					fetch(getUser_url)
					        .then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json();
										   
							        })
									  
							.then(function (result) {
								
								       
									   
									   
									 //------------------------ properties to lowercase ----------------------
									 
									 /* 
									     result = [{"FULL_NAME":"xXx"}, {}, {}....... {}]
									     result is upper case, must convert all properties to lowercase, 
									     result = [{"full_name":"xXx"}, {}, {}....... {}]
									     however, the value like password or number MUST remain no change. 
									 */
									 
									 // result = [{}, {}, {}....... {}]
									 	var result_lower_properties= [];
									 
									 	var arrayLength = result.length;
										
										for (var i = 0; i < arrayLength; i++) {
											
											var obj = result[i];
											var obj_lower_properties = {};
											
											for (var prop in obj) {
															  
															  //console.log(prop.toLowerCase())
															  //console.log(obj[prop])
															 
															  obj_lower_properties[prop.toLowerCase()] = obj[prop]
											}// for
											
											result_lower_properties.push(obj_lower_properties)
											
										}// for
									 
									  //----------  ENd -------------- properties to lowercase ----------------------
								
									 
									 
									 
									 
									 // must use self.user,  do not use this.user, 
									 // because here, this's scope is just the function (result).   
									 // we need this reference to vue-app, 
									 self.user = result_lower_properties  // [{}, {}, {}]  
									 
									 
									 // hide v-data-table progress bar
									self.progress_bar_loading = false
		
		}); // fetch(){}

		
       console.log(JSON.stringify(this.user));
		 
		
		
		
		
    },  // initialize {}
	
	
	
	

    editItem (item) {
      this.editedIndex = this.user.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
	  
	  
	  //console.log(this.editedItem);  // NOT visible,  must stringify, 
	  console.log(JSON.stringify(this.editedItem));
	  console.log(JSON.stringify(this.editedIndex));
	  
    },



     // ---------- delete user action icon clicked --------------
    deleteItem (item) {
		
      const index = this.user.indexOf(item)
	  
      var _delete_user_confirm = confirm('Are you sure you want to delete this user?') 
	//  var _delete_user_confirm = true
	  
	 if (_delete_user_confirm) 
	  {
		
		/*
		 be carefull, index is reference the item in vue-app.user,
		 is different with real user id (reference to database user table).
		 Do not use index value as true user id(to be deleted)
		
		*/
		
		console.log(JSON.stringify(item));
		
		console.log(index)
		this.user.splice(index, 1)
		
		  
		          // --- insert  database use fetch api, you can specify the method as post, delete, put ----
		   
					var deleteUser_url = url + 'cfc/sw.cfc?method=deleteUser&returnformat=json&queryformat=struct';
			
					console.log(deleteUser_url )
							
							
							
				// knowing bug, it failed to hide progressing bar  after delete user call barck, 			
				 // show v-data-table progress bar
				  var self = this
				// self.progress_bar_loading = true		
				   
				   
				   fetch(deleteUser_url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(item)
						  }
						).then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											console.log(result)
											
											
											
											self.progress_bar_loading = false
											
		   
		                             })
                 
                 .catch((err)=>console.error(err))
				   
				   
				  
				   // -----   end     ---- fetch  -------------------------------------
		  
		  
		  
		  
		  
	  }// if 
	  
	  
    },









    close () {
      this.dialog = false
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },



    // ---------- edit dialog save button clicked. --------------
    save () {
		
      if (this.editedIndex > -1) {
		  
		 // this is edit existing item 
		  
        Object.assign(this.user[this.editedIndex], this.editedItem)
		
		  
		   console.log(JSON.stringify(this.editedItem));
	       console.log(JSON.stringify(this.editedIndex));
		   
		   
		   
		   
		   
		   
		   // --- update edited item  in  database use fetch api, you can specify the method as post, delete, put ----
		   
		    var updateUser_url = url + 'cfc/sw.cfc?method=updateUser&returnformat=json&queryformat=struct';
	
	        console.log(updateUser_url )
					
					
		   // show v-data-table progress bar
		   var self = this
		   self.progress_bar_loading = true
		   
		   
		   
		   fetch(updateUser_url, 
				  {
       				 method: 'POST',
        			 body:JSON.stringify(this.editedItem)
                  }
				)
		        .then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				.then(function (result) {
		                                    
											console.log(result)
											
											
											
											self.progress_bar_loading = false
											
		   
		                             })
                 
                 .catch((err)=>console.error(err))
		   
		   // -----   end     ---- fetch  -------------------------------------
		   
		   
		   
		  
		
      } else {
		  
		  // this is add new item and save new item to database 
		  
        this.user.push(this.editedItem)
		
		   console.log(JSON.stringify(this.editedItem));
	       console.log(JSON.stringify(this.editedIndex));
		
		
		   
		         // --- insert  database use fetch api, you can specify the method as post, delete, put ----
		   
					var insertUser_url = url + 'cfc/sw.cfc?method=insertUser&returnformat=json&queryformat=struct';
			
					console.log(insertUser_url )
							
				   
				     // show v-data-table progress bar
					   var self = this
					   self.progress_bar_loading = true
				   
				   
				   fetch(insertUser_url, 
						  {
							 method: 'POST',
							 body:JSON.stringify(this.editedItem)
						  }
						)
						  .then(function (response) 
								   {
													  
										 // if js error here, likely it is coldfusion server output error message instead of valid json 
										 // so check coldfusion server response.
									       return response.json()
										   
							        })
									  
				           .then(function (result) {
		                                    
											console.log(result)
											
											
											
											self.progress_bar_loading = false
											
											
											// ****   bug fix  ****  when add new user, new user id only set at database, but not sync back, 
											// so only add new user need refresh the whole data table data.
											self.initialize()
		   
		                             })
                 
                 .catch((err)=>console.error(err))
				   
				   // -----   end     ---- fetch  -------------------------------------
		    
		
		
		
		
		
		
      }
      this.close()
    }
  }
})