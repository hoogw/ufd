





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


<!--- This function will return the client file name before uploading the file --->
<cffunction name="getClientFileName" returntype="string" output="false" hint="">
	<cfargument name="fieldName" required="true" type="string" hint="Name of the Form field" />

	<cfset var tmpPartsArray = Form.getPartsArray() />

	<cfif IsDefined("tmpPartsArray")>
		<cfloop array="#tmpPartsArray#" index="local.tmpPart">
			<cfif local.tmpPart.isFile() AND local.tmpPart.getName() EQ arguments.fieldName> 
				<cfreturn local.tmpPart.getFileName() />
			</cfif>
		</cfloop>
	</cfif>
	
	<cfreturn "" />
</cffunction>
<!--- This function will return the client file name before uploading the file --->
<!--- Use the following to call the function
<cfset theClientFilename = getClientFileName("FILENAME")> --->


<!--- getRandonNumber Function --->
<cffunction name="getRandomNumber" returntype="string" output="false" hint="">
	<cfset r=#rand()# * 100000000>
	<cfset r=#int(r)#>
	<cfset x=#randomize(r)#>
	<cfset random_nbr=#rand()#>
	<cfset random_nbr=#random_nbr#*100000000>
	<cfset random_nbr=#int(random_nbr)#>
	<cfreturn random_nbr />
</cffunction>


<!--- getFileName Function returns the full filename and extension --->
<cffunction name="getFileName" returntype="string" output="false" hint="">
<cfargument name="xFileName" required="true" type="string" hint="Name of the form FileName" />
<cfset theClientFilename = getClientFileName(Arguments.xFileName)>

<cfset request.theClientFilename=#toFileName(theClientFilename)#>

<cfset Position = Find(".", Reverse(#request.theClientFilename#))>
<cfset request.fileNameOnly = Left(#request.theClientFilename#, Len(#request.theClientFilename#)- #Position#)>
<cfset request.extension = Right(#request.theClientFilename#, (#Position#-1))>

<cfset file_nbr = getRandomNumber()>
<cfset request.file_name = #request.fileNameOnly#&"_"&#file_nbr#&"."&#request.extension#>

<cfreturn request.file_name>

</cffunction>


<!--- getFileExt Function --->
<cffunction name="getFileExt" returntype="string" output="false" hint="">
<cfargument name="xFileName" required="true" type="string" hint="Name of the form FileName" />
<cfset theClientFilename = getClientFileName(Arguments.xFileName)>

<cfset request.theClientFilename=#toFileName(theClientFilename)#>

<cfset Position = Find(".", Reverse(#request.theClientFilename#))>
<cfset request.extension = Right(#request.theClientFilename#, (#Position#-1))>

<cfreturn request.extension>

</cffunction>

<!--- Cap the First Character of Every Word --->
<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
	
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />
	
	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>