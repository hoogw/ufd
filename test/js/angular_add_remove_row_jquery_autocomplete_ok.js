  
 $(document).ready(function() { 
             
			 
			 
			 /* =============  temp ======== */
				
				var countries = {
    "AD": "Andorra",
    "A2": "Andorra Test",
    "AE": "United Arab Emirates",
    "AF": "Afghanistan",
    "AG": "Antigua and Barbuda",
    "AI": "Anguilla",
    "AL": "Albania",
    "AM": "Armenia",
    "AN": "Netherlands Antilles",
    "AO": "Angola",
    "AQ": "Antarctica",
    "AR": "Argentina",
    "AS": "American Samoa",
    "AT": "Austria",
    "AU": "Australia",
    "AW": "Aruba",
    "AX": "\u00c5land Islands",
    "AZ": "Azerbaijan",
    "BA": "Bosnia and Herzegovina",
    "BB": "Barbados",
    "BD": "Bangladesh",
    "BE": "Belgium",
    "BF": "Burkina Faso",
    "BG": "Bulgaria",
    "BH": "Bahrain",
    "BI": "Burundi",
    "BJ": "Benin",
    "BL": "Saint Barth\u00e9lemy",
    "BM": "Bermuda",
    "BN": "Brunei",
    "BO": "Bolivia",
    "BQ": "British Antarctic Territory",
    "BR": "Brazil",
    "BS": "Bahamas",
    "BT": "Bhutan",
    "BV": "Bouvet Island",
    "BW": "Botswana",
    "BY": "Belarus",
    "BZ": "Belize",
    "CA": "Canada",
    "CC": "Cocos [Keeling] Islands",
    "CD": "Congo - Kinshasa",
    "CF": "Central African Republic",
    "CG": "Congo - Brazzaville",
    "CH": "Switzerland",
    "CI": "C\u00f4te d\u2019Ivoire",
    "CK": "Cook Islands",
    "CL": "Chile",
    "CM": "Cameroon",
    "CN": "China",
    "CO": "Colombia",
    "CR": "Costa Rica",
    "CS": "Serbia and Montenegro",
    "CT": "Canton and Enderbury Islands",
    "CU": "Cuba",
    "CV": "Cape Verde",
    "CX": "Christmas Island",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DD": "East Germany",
    "DE": "Germany",
    "DJ": "Djibouti",
    "DK": "Denmark",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "DZ": "Algeria",
    "EC": "Ecuador",
    "EE": "Estonia",
    "EG": "Egypt",
    "EH": "Western Sahara",
    "ER": "Eritrea",
    "ES": "Spain",
    "ET": "Ethiopia",
    "FI": "Finland",
    "FJ": "Fiji",
    "FK": "Falkland Islands",
    "FM": "Micronesia",
    "FO": "Faroe Islands",
    "FQ": "French Southern and Antarctic Territories",
    "FR": "France",
    "FX": "Metropolitan France",
    "GA": "Gabon",
    "GB": "United Kingdom",
    "GD": "Grenada",
    "GE": "Georgia",
    "GF": "French Guiana",
    "GG": "Guernsey",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GL": "Greenland",
    "GM": "Gambia",
    "GN": "Guinea",
    "GP": "Guadeloupe",
    "GQ": "Equatorial Guinea",
    "GR": "Greece",
    "GS": "South Georgia and the South Sandwich Islands",
    "GT": "Guatemala",
    "GU": "Guam",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HK": "Hong Kong SAR China",
    "HM": "Heard Island and McDonald Islands",
    "HN": "Honduras",
    "HR": "Croatia",
    "HT": "Haiti",
    "HU": "Hungary",
    "ID": "Indonesia",
    "IE": "Ireland",
    "IL": "Israel",
    "IM": "Isle of Man",
    "IN": "India",
    "IO": "British Indian Ocean Territory",
    "IQ": "Iraq",
    "IR": "Iran",
    "IS": "Iceland",
    "IT": "Italy",
    "JE": "Jersey",
    "JM": "Jamaica",
    "JO": "Jordan",
    "JP": "Japan",
    "JT": "Johnston Island",
    "KE": "Kenya",
    "KG": "Kyrgyzstan",
    "KH": "Cambodia",
    "KI": "Kiribati",
    "KM": "Comoros",
    "KN": "Saint Kitts and Nevis",
    "KP": "North Korea",
    "KR": "South Korea",
    "KW": "Kuwait",
    "KY": "Cayman Islands",
    "KZ": "Kazakhstan",
    "LA": "Laos",
    "LB": "Lebanon",
    "LC": "Saint Lucia",
    "LI": "Liechtenstein",
    "LK": "Sri Lanka",
    "LR": "Liberia",
    "LS": "Lesotho",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "LV": "Latvia",
    "LY": "Libya",
    "MA": "Morocco",
    "MC": "Monaco",
    "MD": "Moldova",
    "ME": "Montenegro",
    "MF": "Saint Martin",
    "MG": "Madagascar",
    "MH": "Marshall Islands",
    "MI": "Midway Islands",
    "MK": "Macedonia",
    "ML": "Mali",
    "MM": "Myanmar [Burma]",
    "MN": "Mongolia",
    "MO": "Macau SAR China",
    "MP": "Northern Mariana Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MS": "Montserrat",
    "MT": "Malta",
    "MU": "Mauritius",
    "MV": "Maldives",
    "MW": "Malawi",
    "MX": "Mexico",
    "MY": "Malaysia",
    "MZ": "Mozambique",
    "NA": "Namibia",
    "NC": "New Caledonia",
    "NE": "Niger",
    "NF": "Norfolk Island",
    "NG": "Nigeria",
    "NI": "Nicaragua",
    "NL": "Netherlands",
    "NO": "Norway",
    "NP": "Nepal",
    "NQ": "Dronning Maud Land",
    "NR": "Nauru",
    "NT": "Neutral Zone",
    "NU": "Niue",
    "NZ": "New Zealand",
    "OM": "Oman",
    "PA": "Panama",
    "PC": "Pacific Islands Trust Territory",
    "PE": "Peru",
    "PF": "French Polynesia",
    "PG": "Papua New Guinea",
    "PH": "Philippines",
    "PK": "Pakistan",
    "PL": "Poland",
    "PM": "Saint Pierre and Miquelon",
    "PN": "Pitcairn Islands",
    "PR": "Puerto Rico",
    "PS": "Palestinian Territories",
    "PT": "Portugal",
    "PU": "U.S. Miscellaneous Pacific Islands",
    "PW": "Palau",
    "PY": "Paraguay",
    "PZ": "Panama Canal Zone",
    "QA": "Qatar",
    "RE": "R\u00e9union",
    "RO": "Romania",
    "RS": "Serbia",
    "RU": "Russia",
    "RW": "Rwanda",
    "SA": "Saudi Arabia",
    "SB": "Solomon Islands",
    "SC": "Seychelles",
    "SD": "Sudan",
    "SE": "Sweden",
    "SG": "Singapore",
    "SH": "Saint Helena",
    "SI": "Slovenia",
    "SJ": "Svalbard and Jan Mayen",
    "SK": "Slovakia",
    "SL": "Sierra Leone",
    "SM": "San Marino",
    "SN": "Senegal",
    "SO": "Somalia",
    "SR": "Suriname",
    "ST": "S\u00e3o Tom\u00e9 and Pr\u00edncipe",
    "SU": "Union of Soviet Socialist Republics",
    "SV": "El Salvador",
    "SY": "Syria",
    "SZ": "Swaziland",
    "TC": "Turks and Caicos Islands",
    "TD": "Chad",
    "TF": "French Southern Territories",
    "TG": "Togo",
    "TH": "Thailand",
    "TJ": "Tajikistan",
    "TK": "Tokelau",
    "TL": "Timor-Leste",
    "TM": "Turkmenistan",
    "TN": "Tunisia",
    "TO": "Tonga",
    "TR": "Turkey",
    "TT": "Trinidad and Tobago",
    "TV": "Tuvalu",
    "TW": "Taiwan",
    "TZ": "Tanzania",
    "UA": "Ukraine",
    "UG": "Uganda",
    "UM": "U.S. Minor Outlying Islands",
    "US": "United States",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VA": "Vatican City",
    "VC": "Saint Vincent and the Grenadines",
    "VD": "North Vietnam",
    "VE": "Venezuela",
    "VG": "British Virgin Islands",
    "VI": "U.S. Virgin Islands",
    "VN": "Vietnam",
    "VU": "Vanuatu",
    "WF": "Wallis and Futuna",
    "WK": "Wake Island",
    "WS": "Samoa",
    "YD": "People's Democratic Republic of Yemen",
    "YE": "Yemen",
    "YT": "Mayotte",
    "ZA": "South Africa",
    "ZM": "Zambia",
    "ZW": "Zimbabwe",
    "ZZ": "Unknown or Invalid Region"
}
			 
			 var countriesArray = $.map(countries, function (value, key) { return { value: value, data: key }; });
			 /*
					  var countries = [
						{ value: 'Andorra', data: 'AD' },
						// ...
						{ value: 'Zimbabwe', data: 'ZZ' }
					];
				*/
				
				
				
				
				
				// Setup jQuery ajax mock:
					$.mockjax({
						url: '*',
						responseTime: 2000,
						response: function (settings) {
							var query = settings.data.query,
								queryLowerCase = query.toLowerCase(),
								re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi'),
								suggestions = $.grep(countriesArray, function (country) {
									 // return country.value.toLowerCase().indexOf(queryLowerCase) === 0;
									return re.test(country.value);
								}),
								response = {
									query: query,
									suggestions: suggestions
								};
				
							this.responseText = JSON.stringify(response);
						}
					});
				
					// Initialize ajax autocomplete:
					$('#autocomplete-ajax').autocomplete({
						// serviceUrl: '/autosuggest/service/url',
						lookup: countriesArray,
						lookupFilter: function(suggestion, originalQuery, queryLowerCase) {
							var re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
							return re.test(suggestion.value);
						},
						onSelect: function(suggestion) {
							$('#selction-ajax').html('You selected: ' + suggestion.value + ', ' + suggestion.data);
						},
						onHint: function (hint) {
							$('#autocomplete-ajax-x').val(hint);
						},
						onInvalidateSelection: function() {
							$('#selction-ajax').html('You selected: none');
						}
					});
				
				
				
				//       .........        simple   auto complete    ............
				
												var countries = [
								   { value: 'Andorra', data: 'AD' },
								   // ...
								   { value: 'Zimbabwe', data: 'ZZ' }
								];
								
								$('#autocomplete').autocomplete({
									lookup: countries,
									onSelect: function (suggestion) {
										alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
									}
								});
				
				
				
				
				//       .........    End     simple   auto complete    ............
					
					
  });   // doc ready
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
       // +++++++++++++++++++++++++++++++++  angular  ++++++++++++++++++++++++++++++++
  
         var app = angular.module("myapp", []);   
   				// var app = angular.module("myapp", ["ngTouch", "angucomplete-alt"]);
				 //var app = angular.module('app', ["angucomplete-alt"]);
	
	
				app.controller("ListController", ['$scope', function($scope) {
																	 
					$scope.personalDetails = [
						{
							'fname':'Muhammed',
							'lname':'Shanid',
							'email':'shanid@shanid.com'
						},
						{
							'fname':'John',
							'lname':'Abraham',
							'email':'john@john.com'
						},
						{
							'fname':'Roy',
							'lname':'Mathew',
							'email':'roy@roy.com'
						}];
					
					
					$scope.tts = ["Emil", "Tobias", "Linus"];
					
						$scope.addNew = function(personalDetail){
							$scope.personalDetails.push({ 
								'fname': "", 
								'lname': "",
								'email': "",
							});
						};
					
						$scope.remove = function(){
							var newDataList=[];
							$scope.selectedAll = false;
							angular.forEach($scope.personalDetails, function(selected){
								if(!selected.selected){
									newDataList.push(selected);
								}
							}); 
							$scope.personalDetails = newDataList;
						};
					
					$scope.checkAll = function () {
						if (!$scope.selectedAll) {
							$scope.selectedAll = true;
						} else {
							$scope.selectedAll = false;
						}
						angular.forEach($scope.personalDetails, function(personalDetail) {
							personalDetail.selected = $scope.selectedAll;
						});
					};    
					
					
					
					
					// ----------------------------- auto complete  --------------------------------------------------
					
					
					
					     
					
					
					
					// -------------------------       End     --------------     auto complete          --------------------------------------------------
					
					
					
					
					
					
					
					
					
					
				}]);// app controller
    
	
	
	              //**********************************************************************
				  
				  app.controller("ListController2", ['$scope', function($scope) {
																	 
					$scope.personalDetails2 = [
						{
							'fname':'o9',
							'lname':'o0',
							'email':'shanid@shanid.com'
						},
						{
							'fname':'o8',
							'lname':'o8',
							'email':'john@john.com'
						},
						{
							'fname':'o7',
							'lname':'o8',
							'email':'roy@roy.com'
						}];
					
						$scope.addNew = function(personalDetail2){
							$scope.personalDetails2.push({ 
								'fname': "", 
								'lname': "",
								'email': "",
							});
						};
					
						$scope.remove = function(){
							var newDataList=[];
							$scope.selectedAll = false;
							angular.forEach($scope.personalDetails2, function(selected){
								if(!selected.selected){
									newDataList.push(selected);
								}
							}); 
							$scope.personalDetails2 = newDataList;
						};
					
					$scope.checkAll = function () {
						if (!$scope.selectedAll) {
							$scope.selectedAll = true;
						} else {
							$scope.selectedAll = false;
						}
						angular.forEach($scope.personalDetails2, function(personalDetail2) {
							personalDetail2.selected = $scope.selectedAll;
						});
					};    
					
					
				}]);// app controller
	
	
	
	
	
	
	
	
	
	
	
	
	
	