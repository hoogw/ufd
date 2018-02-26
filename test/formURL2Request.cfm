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
			<cfset SetVariable("request.#thefield#" , "#evaluate("url."&"#thefield#")#")>
		</cfloop>
	</cfif>
</cfif>

<cfif isdefined("form.fieldnames")>
	<cfloop list="#form.fieldnames#" index="field">
		<cfset SetVariable("request.#field#" , "#evaluate("form."&"#field#")#")>
	</cfloop>
</cfif>


