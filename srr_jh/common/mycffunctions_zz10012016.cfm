<cfscript>
function businessDaysBetween(date1,date2) {
	date1 = dateformat(date1,"mm/dd/yyyy");
	date2 = dateformat(date2,"mm/dd/yyyy");
    var numberOfDays = 0;
    
    while (date1 LT date2) {
        date1 = dateAdd("d",1,date1);
        if(dayOfWeek(date1) GTE 2 AND dayOfWeek(date1) LTE 6) numberOfDays = incrementValue(numberOfDays);
    }

	//numberOfDays = incrementValue(numberOfDays); Sould this be used or not?
    return numberOfDays;
}
</cfscript>

<!---<Cfoutput>
#businessDaysBetween("9/1/2010","9/1/2010")#
</CFOUTPUT>--->

<!-- Adjust date to SQL server -->
<cfscript>
function toSqlDate(x) {
    if (isdate(x))
	{
	return CreateODBCDate(x);
	}
	else
	{
	return 'null';
	}
}
</cfscript>

<!-- Adjust Text to SQL server -->
<cfscript>
function toSqlText(x) {
    if (x is not '')
	{
	x = ReplaceList(x,"#chr(39)#","#chr(39)##chr(39)#");
	return x;
	}
	else
	{
	return '';
	}
}
</cfscript>

<!-- Adjust Numeric to SQL server -->
<cfscript>
function toSqlNumeric(x) {
	x = ReplaceList(x,"$","");
	x = ReplaceList(x,",","");
	x = ReplaceList(x,"%","");
    if (isnumeric(x))
	{
	return x;
	}
	else
	{
	return 'null';
	}
}
</cfscript>


<cfscript>
/**
 * Returns a random string of the specified length of either alpha, numeric or mixed-alpha-numeric characters.
 * v2, support for lower case
 * v3 - more streamlined code
 * 
 * @param Type      Type of random string to create. (Required)
 * @param Length      Length of random string to create. (Required)
 * @return Returns a string. 
 * @author Joshua Miller (josh@joshuasmiller.com) 
 * @version 2, November 4, 2003 
 */
function randString(type,ct){
 var i=1;
 var randStr="";
 var randNum="";
 var useList="";
 var alpha="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
 var secure="!,@,$,%,&,*,-,_,=,+,?,~";
 for(i=1;i LTE ct;i=i+1){  
  if(type is "alpha"){
   randNum=RandRange(1,52);
   useList=alpha;
  }else if(type is "alphanum"){
   randNum=RandRange(1,62);
   useList="#alpha#,0,1,2,3,4,5,6,7,8,9";
  }else if(type is "secure"){
   randNum=RandRange(1,73);
   useList="#alpha#,0,1,2,3,4,5,6,7,8,9,#secure#";
  }else{
   randNum=RandRange(1,10);
   useList="0,1,2,3,4,5,6,7,8,9";
  }
  
  randStr="#randStr##ListGetAt(useList,randNum)#";
 }
 return randStr;
}
</cfscript>



<cfscript>
function toFileName(x) {

	x = ReplaceNoCase(x,"$","","ALL");
	x = ReplaceNoCase(x,",","","ALL");
	x = ReplaceNoCase(x,"/","","ALL");
	x = ReplaceNoCase(x,"\","","ALL");
	x = ReplaceNoCase(x,"#chr(35)#","","ALL"); // pound sign
	x = ReplaceNoCase(x," ","_","ALL");
	x = ReplaceNoCase(x,"@","","ALL");
	x = ReplaceNoCase(x,"*","","ALL");
	x = ReplaceNoCase(x,"(","","ALL");
	x = ReplaceNoCase(x,")","","ALL");
	x = ReplaceNoCase(x,"{","","ALL");
	x = ReplaceNoCase(x,"}","","ALL");
	x = ReplaceNoCase(x,"[","","ALL");
	x = ReplaceNoCase(x,"]","","ALL");
	x = ReplaceNoCase(x,"?","","ALL");
	x = ReplaceNoCase(x,"^","","ALL");
	x = ReplaceNoCase(x,"%","","ALL");
	x = ReplaceNoCase(x,"+","","ALL");
	x = ReplaceNoCase(x,"!","","ALL");
	x = ReplaceNoCase(x,"|","","ALL");
	x = ReplaceNoCase(x,"~","","ALL");
	x = ReplaceNoCase(x,"`","","ALL");
	x = ReplaceNoCase(x,">","","ALL");
	x = ReplaceNoCase(x,"<","","ALL");
	x = ReplaceNoCase(x,":","","ALL");
	x = ReplaceNoCase(x,";","","ALL");
	
	return x;

}
</cfscript>