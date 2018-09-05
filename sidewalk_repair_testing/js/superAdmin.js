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
      return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
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

  methods: {
    initialize () {
      this.user = [
        {
          full_name: 'joe hu',
          name: 'xxxxxxxxx',
          password: 'kkkkkkk',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        {
          full_name: 'nill huddsa',
          name: 'jhk',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
          full_name: '98765 uddsa',
          name: 'jhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
           full_name: 'xce34df98765 uddsa',
          name: 'dsafwjhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
		
		
		
		{
          full_name: 'joe hu',
          name: 'xxxxxxxxx',
          password: 'kkkkkkk',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        {
          full_name: 'nill huddsa',
          name: 'jhk',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
          full_name: '98765 uddsa',
          name: 'jhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
           full_name: 'xce34df98765 uddsa',
          name: 'dsafwjhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
		
		
		
		
		{
          full_name: 'joe hu',
          name: 'xxxxxxxxx',
          password: 'kkkkkkk',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        {
          full_name: 'nill huddsa',
          name: 'jhk',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
          full_name: '98765 uddsa',
          name: 'jhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
           full_name: 'xce34df98765 uddsa',
          name: 'dsafwjhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
		
		
		
		
		
		{
          full_name: 'joe hu',
          name: 'xxxxxxxxx',
          password: 'kkkkkkk',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        {
          full_name: 'nill huddsa',
          name: 'jhk',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
          full_name: '98765 uddsa',
          name: 'jhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
           full_name: 'xce34df98765 uddsa',
          name: 'dsafwjhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
		
		
		
		
		
		{
          full_name: 'joe hu',
          name: 'xxxxxxxxx',
          password: 'kkkkkkk',
          agency: 'BSS',
		  level: 1,
		  power:1,
		  cert:0,
		  ufd:0,
		  report: '.130.140.'
		  
        },
        {
          full_name: 'nill huddsa',
          name: 'jhk',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
          full_name: '98765 uddsa',
          name: 'jhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        {
           full_name: 'xce34df98765 uddsa',
          name: 'dsafwjhkdwe34',
          password: 'kkkkkkk',
          agency: 'BSS',
      level: 1,
	  power:1,
	  cert:0,
	  ufd:0,
	  report: '.130.140.'
        },
        
      ]
    },

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