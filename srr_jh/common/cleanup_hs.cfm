<cfif not isdefined("request.hs")>
Invalid Access
<cfabort>
</cfif>

<cfset request.hs=ReplaceNoCase("#request.hs#","-","","ALL")> 
<cfset request.hs=ReplaceNoCase("#request.hs#",".","","ALL")> 

<cfset request.hs=ReplaceNoCase("#request.hs#","    "," ","ALL")>  
<cfset request.hs=ReplaceNoCase("#request.hs#","   "," ","ALL")>
<cfset request.hs=ReplaceNoCase("#request.hs#","  "," ","ALL")> 

<cfif #right(request.hs, 3)# is " al">
<cfset request.hs=ReplaceNoCase("#request.hs#"," al","","ALL")> 
</cfif>

<cfif #right(request.hs, 6)# is " alley">
<cfset request.hs=ReplaceNoCase("#request.hs#"," alley","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " av">
<cfset request.hs=ReplaceNoCase("#request.hs#"," av","","ALL")> 
</cfif>

<cfif #right(request.hs, 4)# is " ave">
<cfset request.hs=ReplaceNoCase("#request.hs#"," ave","","ALL")> 
</cfif>

<cfif #right(request.hs, 7)# is " avenue">
<cfset request.hs=ReplaceNoCase("#request.hs#"," avenue","","ALL")> 
</cfif>

<cfif #right(request.hs, 5)# is " blvd">
<cfset request.hs=ReplaceNoCase("#request.hs#"," blvd","","ALL")> 
</cfif>

<cfif #right(request.hs, 10)# is " boulevard">
<cfset request.hs=ReplaceNoCase("#request.hs#"," boulevard","","ALL")> 
</cfif>

<cfif #right(request.hs, 4)# is " cir">
<cfset request.hs=ReplaceNoCase("#request.hs#"," cir","","ALL")> 
</cfif>


<cfif #right(request.hs, 3)# is " ck">
<cfset request.hs=ReplaceNoCase("#request.hs#"," ck","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " cl">
<cfset request.hs=ReplaceNoCase("#request.hs#"," cl","","ALL")> 
</cfif>



<cfif #right(request.hs, 5)# is " cove">
<cfset request.hs=ReplaceNoCase("#request.hs#"," cove","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " cres">
<cfset request.hs=ReplaceNoCase("#request.hs#"," cres","","ALL")> 
</cfif>

<cfif #right(request.hs, 4)# is " cny">
<cfset request.hs=ReplaceNoCase("#request.hs#"," cny","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " ct">
<cfset request.hs=ReplaceNoCase("#request.hs#"," ct","","ALL")> 
</cfif>

<cfif #right(request.hs, 4)# is " hwy">
<cfset request.hs=ReplaceNoCase("#request.hs#"," hwy","","ALL")> 
</cfif>

<cfif #right(request.hs, 5)# is " pkwy">
<cfset request.hs=ReplaceNoCase("#request.hs#"," pkwy","","ALL")> 
</cfif>


<cfif #right(request.hs, 3)# is " st">
<cfset request.hs=ReplaceNoCase("#request.hs#"," st","","ALL")> 
</cfif>


<cfif #right(request.hs, 7)# is " street">
<cfset request.hs=ReplaceNoCase("#request.hs#"," street","","ALL")> 
</cfif>

<cfif #right(request.hs, 7)# is " circle">
<cfset request.hs=ReplaceNoCase("#request.hs#"," circle","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " dr">
<cfset request.hs=ReplaceNoCase("#request.hs#"," dr","","ALL")> 
</cfif>

<cfif #right(request.hs, 6)# is " drive">
<cfset request.hs=ReplaceNoCase("#request.hs#"," drive","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " pl">
<cfset request.hs=ReplaceNoCase("#request.hs#"," pl","","ALL")> 
</cfif>

<cfif #right(request.hs, 5)# is " place">
<cfset request.hs=ReplaceNoCase("#request.hs#"," place","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " rd">
<cfset request.hs=ReplaceNoCase("#request.hs#"," rd","","ALL")> 
</cfif>

<cfif #right(request.hs, 5)# is " road">
<cfset request.hs=ReplaceNoCase("#request.hs#"," road","","ALL")> 
</cfif>

<cfif #right(request.hs, 3)# is " ln">
<cfset request.hs=ReplaceNoCase("#request.hs#"," ln","","ALL")> 
</cfif>

<cfif #right(request.hs, 5)# is " lane">
<cfset request.hs=ReplaceNoCase("#request.hs#"," lane","","ALL")> 
</cfif>