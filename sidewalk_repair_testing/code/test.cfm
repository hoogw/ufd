 <cfset dbs_smarts_ac = "smarts_ac">
 
 <cfquery name="getBOSPipes" datasource="#dbs_smarts_ac#" dbtype="ODBC">
        select * from mastertable where project_id <> ''
    </cfquery>
	
	
    <cfdump var="#getBOSPipes#">
	
