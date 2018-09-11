new Vue({
  el: '#app',
  data: () => ({
    dialog: false,
	
	search: '',
	
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
	  report: '.130.140.'
      
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
	  report: '.130.140.'
	  
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
    this.initialize()
  },

  
  mounted () {
	
	this.getData()
  },


  methods: {
	  
	  getData() {
		  
		 
		 
		
	                 var getUser_url = url + 'cfc/sw.cfc?method=getUser&returnformat=json&queryformat=struct';
	
	                console.log(getUser_url )
					
				/*
					You can use a plethora of options for doing Ajax calls such as Axios, vue-resource or better yet the browser's built in fetch API in modern browsers. 
					You can also use jQuery via $.ajax() API, which simply wraps the XHR object in a simple to use method call 
					but it's not recommended to include the whole jQuery library for the sake of using one method.
					
					
					http://updates.html5rocks.com/2015/03/introduction-to-fetch
					The Fetch API provides a JavaScript interface for accessing and manipulating parts of the HTTP pipeline, such as requests and responses. 
					It also provides a global fetch() method that provides an easy, logical way to fetch resources asynchronously across the network.
					
				*/
				
				
				    //   **********  must use self = this ************** 
					// this reference vue-app.  must pass it to self, then pass into callback function (success call back)
					var self = this;  
					
					
					fetch(getUser_url).then(function (response) {
									return response.json();
							}).then(function (result) {
								
								       
									   
									   
									 //------------------------ properties to lowercase ----------------------
									 // result is upper case, must convert all properties to lowercase, 
									 // however, the value like password or number MUST remain no change. 
									
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
									 self.user = result_lower_properties;  // [{}, {}, {}]  
									 
									 
							
		
		}); // fetch(){}

		
       console.log(this.user);
		 
		 
	  }, 
	  
	  
	  
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
		
    },  // initialize {}
	
	
	
	

    editItem (item) {
      this.editedIndex = this.user.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
    },

    deleteItem (item) {
      const index = this.user.indexOf(item)
      confirm('Are you sure you want to delete this user?') && this.user.splice(index, 1)
    },

    close () {
      this.dialog = false
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },

    save () {
      if (this.editedIndex > -1) {
        Object.assign(this.user[this.editedIndex], this.editedItem)
      } else {
        this.user.push(this.editedItem)
      }
      this.close()
    }
  }
})