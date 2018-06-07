// validate not blank
function isNotBlank(fld, msg) {
	str = fld.value;
    var test = /\S+/.test(str);
if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
} 
else   {fld.style.background = 'White';return true;}
}// validate not blank




// validate zip code
function isZip(fld, msg) {
	str = fld.value;
    str = str.replace(/^\s+|\s+$/g, '');   // trim leading and trailing spaces
	var pattern = /^\d{5}$|^\d{5}-\d{4}$/;
	var test = pattern.test(str);
if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate zip code


// validate phone number
function isPhone(fld, msg) {
	str = fld.value;
    str = str.replace(/[^\dxX]/g, "");
	var pattern = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate phone number


// validate positive or negative integer start
function isInteger(fld, msg) {
	str = fld.value;
    //        ignoring leading and trailing spaces
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =  /^[-+]?[0-9]+$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		alert (msg);
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate positive or negative integer end



// validate positive integer start
function isPositiveInteger(fld, msg) {
	str = fld.value;
//ignoring leading and trailing spaces
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =   /^[0-9]+$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
        alert (msg); 
		return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate positive integer end







// validate positive or negative decimal
function isFloat(fld, msg) {
	str = fld.value; 
	//ignoring leading and trailing spaces
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =   /^[-+]?[0-9]+(,[0-9]{3})*(\.[0-9]+)?$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate positive or negative decimal



// validate positive only decimal
function isPositiveFloat(fld, msg) {
	str = fld.value; 
	//ignoring leading and trailing spaces
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =  /^[0-9]+(,[0-9]{3})*(\.[0-9]+)?$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate positive only decimal


// validate currency
function isCurrency(fld, msg) {
	str = fld.value;
	//ignoring leading and trailing spaces
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =   /^\$?[0-9]+(,[0-9]{3})*(\.[0-9]{2})?$/;
	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);         
 		 return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate currency


// Validate Maximum Number of Characters is met
function v_MaxLength(fld, maxc,  msg) {
    if (fld.value.length > maxc) 
   {
	fld.style.background = '#FFFF66';
	alert (msg);     
	return false;
    } 
else   {fld.style.background = 'White';return true;}
}
// Validate Maximum Number of Characters is met


// Validate Minimum Number of Characters is met
function v_MinLength(fld, minc,  msg) {
    if (fld.value.length < minc) 
   {
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
    } 
else   {fld.style.background = 'White';return true;}
}
// Validate Minimum Number of Characters is met



// validate pulldown menu selection
function v_Pulldown(fld,  msg) {
if (fld.selectedIndex == 0)
{
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
}
else   {fld.style.background = 'White';return true;}
}
// validate pulldown menu selection



// validate email
function isEmail(fld, msg) {
	str = fld.value;
    str = str.replace(/^\s+|\s+$/g, '');

	var pattern =  /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

	var test = pattern.test(str);

if  (!test)
{
         fld.style.background = '#FFFF66';
		 alert (msg);     
         return false;
} 
else   {fld.style.background = 'White';return true;}
}
// validate email


// validate date   mm/dd/yyyy
	function isDate(fld,msg)
	{
      var str = fld.value;
      str = str.replace(/^\s+|\s+$/g, '');
      // alert ("string after replacement = " + str);
	  var re;
	  var mm;
	  var dd;
	  var yy;
	  var re = /^(\d{1,2})[\s\.\/-](\d{1,2})[\s\.\/-](\d{4})$/;
	  if (!re.test(str)) {fld.style.background = '#FFFF66';		 alert (msg);     return false;}
	  var result = str.match(re);
      // alert ("result = " + result);
	  var mm = parseFloat(result[1]);
	  var dd= parseFloat(result[2]);
	  var yy = parseFloat(result[3]);
      //alert ("month=" + mm);
      //alert ("day=" + dd);
      //alert ("year=" +yy);
      
	  if(mm < 1 || mm > 12 || yy <= 1900 || yy >= 2100)  {fld.style.background = '#FFFF66'; alert (msg); return false; }
	  
      if(mm == 2){
	          var days = ((yy % 4) == 0) ? 29 : 28;
	  }else if(mm == 4 || mm == 6 || mm == 9 || mm == 11){
	          var days = 30;
	  }else{
	          var days = 31;
	  }
	  if  (dd >= 1 && dd <= days) {fld.style.background = 'White';return true;} else {fld.style.background = '#FFFF66'; alert (msg); return false; }
	}
// validate date mm/dd/yyyy

