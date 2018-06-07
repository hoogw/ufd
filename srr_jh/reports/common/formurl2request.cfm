<cftry>
<cfif isdefined("cgi.query_string")>
<cfif cgi.query_string is not "">

<cfparam name="thefieldnames" default="">
<cfparam name="loopcounter" default="1">

<cfloop list="#cgi.query_string#" delimiters="&" index="Item">
<cfset findequal = "#find("=","#item#",1)#">
<cfset URLName = "#removechars("#item#","#findequal#","#len(item)#")#">
<cfif loopcounter is 1>
<cfset thefieldnames = "#thefieldnames#" & "#URLNAME#">
<cfelse>
<cfset thefieldnames = "#thefieldnames#" & ",#URLNAME#">
</cfif>
<cfset loopcounter = loopcounter+1>
</cfloop>


<cfloop list="#thefieldnames#" index="thefield">
	<cfset SetVariable("request.#thefield#" , "#trim(evaluate("url."&"#thefield#"))#")>
</cfloop>


</cfif>
</cfif>





<cfif isdefined("form.fieldnames")>
<cfloop list="#form.fieldnames#" index="field">
<cfset SetVariable("request.#field#" , "#trim(evaluate("form."&"#field#"))#")>
</cfloop>
</cfif>
<cfcatch>
<div align="center"><br><br><span style="color:#B40404;font-size:1.2em;">An Error was Encountered!!<br><br>
The Site Administrator was Notified of This Error.</span></div>
<cfabort>
</cfcatch>
</cftry>


