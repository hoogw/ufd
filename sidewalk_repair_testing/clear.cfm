
	<cflock timeout=20 scope="Session" type="Exclusive">
  		<cfset StructDelete(Session, "userid")>
		<cfset StructDelete(Session, "password")>
		<cfset StructDelete(Session, "agency")>
		<cfset StructDelete(Session, "user_level")>
		<cfset StructDelete(Session, "user_power")>
		<cfset StructDelete(Session, "user_num")>
		<cfset StructDelete(Session, "arrSUMAll")>
		<cfset StructDelete(Session, "arrWWUsers")>
		<cfset StructDelete(Session, "siteQuery")>
		<cfinclude template="deleteClientVariables.cfm">
	</cflock>
	