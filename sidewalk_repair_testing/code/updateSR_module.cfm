
<!-- Developed by: Nathan Neumann 09/27/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfparam name="attributes.srNum" default="1-130976691">		<!--- The passed SR Number (myLA311) --->
<cfparam name="attributes.srCode" default="">				<!--- The passed SR Code to update myLA311 --->
<cfparam name="attributes.srComment" default="">			<!--- The passed SR Comment to update myLA311 --->


<cfset request.srupdate_success = "Y"> 						<!--- Tells whether the update was successful (Y/N) --->
<cfset request.srupdate_err_message = ""> 					<!--- If the attempt wasn't successful, there will be an error message --->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<!--- <cftry> --->

<!--- Setup script variables --->
<cfset queryMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/SANQueryPageSR">
<cfset upsertMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/UpsertSANSRWithCodes">
<!--- <cfset srNum = "1-125267271"> --->
<cfset updateUserID = "BOEINTEGRATION">

<cfset srReason = "">
<cfset srResolution = attributes.srCode>
<cfif isNumeric(attributes.srCode)>
	<cfset srResolution = "">
	<cfset srReason = attributes.srCode>
</cfif>

<!--- Query the existing SR to get the IntegrationID --->
<cfset queryJSON = {
    "MetaData": {},
    "QueryRequest": {
        "SRNumber": "#attributes.srNum#",
				"srType": [
					"Sidewalk Repair"
        ],
        "NewQuery":"new",
        "PageSize":"10",
        "StartRowNum":"1"
    }
}>

<!---  Call the query method. --->
<cfhttp url = "#queryMethodAPI#" method = "post" timeout = "60" result = "httpQueryResp" proxyServer="bcproxy.ci.la.ca.us" proxyPort="8080">
  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
  <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
</cfhttp>

<!--- Validate the returned JSON data --->
<cfif !IsJSON(httpQueryResp.Filecontent)>
  <cfset request.srupdate_err_message = "Something went wrong with the httpMyLA311Resp variable and cfhttp call.">
<!--- Data is valid so keep going --->
<cfelse>
  <cfset myla311Data = DeserializeJSON(httpQueryResp.Filecontent)>
  
  <!--- <cfdump var="#myla311Data#">
  <cfabort> --->

  <!--- Process the response codes and summarize the data --->
  <cfif myla311Data.status.code neq "311">
        <cfset request.srupdate_err_message="The max number of retries was exceeded">
  </cfif>

  <!--- Get the integrationID number --->
  <cfif myla311Data.Response.NumOutputObjects neq 0>
    <cfset the311Records = myla311Data.Response.ListOfServiceRequest.ServiceRequest>
    <cfset integrationID = the311Records[1].IntegrationId>
  <cfelse>
  	<cfset request.srupdate_err_message="No records to process">
  </cfif>
</cfif>

<cfif request.srupdate_err_message is ""> <!--- Continue if no Error message --->

	<cfset upsertData = {}>
	<!--- s: Add Code Change to the SR ticket --->
	<cfif attributes.srComment is "" AND attributes.srCode is not "">
		<cfset upsertData = {
		  "MetaData": {},
		  "SRData": {
		    "SRNumber": "#attributes.srNum#",
		    "SRType": "Sidewalk Repair",
		    "IntegrationId": "#integrationID#",
		    "UpdatedByUserLogin": "#updateUserID#",
			"ListOfLa311ServiceRequestNotes":{},
			"ReasonCode": "#srReason#",
    		"ResolutionCode": "#srResolution#"
		  }
		}>
	</cfif>
	<!--- e: Add Code Change to the SR ticket --->
	
	<!--- s: Add External Comment to the SR ticket --->
	<cfif attributes.srComment is not "" AND attributes.srCode is "">
		<cfset upsertData = {
		  "MetaData": {},
		  "SRData": {
		    "SRNumber": "#attributes.srNum#",
		    "SRType": "Sidewalk Repair",
		    "IntegrationId": "#integrationID#",
		    "UpdatedByUserLogin": "#updateUserID#",
		    "ListOfLa311ServiceRequestNotes": {
		      "La311ServiceRequestNotes": [
		        {
		          "Comment": "#attributes.srComment#",
		          "CreatedByUser": "#updateUserID#",
		          "CommentType": "External",
		          "Notification": "N"
		        }
		      ]
		    }
		  }
		}>
	</cfif>
	<!--- e: Add External Comment to the SR ticket --->
	
	<!--- s: Add External Comment AND Code Change to the SR ticket --->
	<cfif attributes.srComment is not "" AND attributes.srCode is not "">
		<cfset upsertData = {
		  "MetaData": {},
		  "SRData": {
		    "SRNumber": "#attributes.srNum#",
		    "SRType": "Sidewalk Repair",
		    "IntegrationId": "#integrationID#",
		    "UpdatedByUserLogin": "#updateUserID#",
		    "ListOfLa311ServiceRequestNotes": {
		      "La311ServiceRequestNotes": [
		        {
		          "Comment": "#attributes.srComment#",
		          "CreatedByUser": "#updateUserID#",
		          "CommentType": "External",
		          "Notification": "N"
		        }
		      ]
		    },
			"ReasonCode": "#srReason#",
    		"ResolutionCode": "#srResolution#"
		  }
		}>
	</cfif>
	<!--- e: Add External Comment AND Code Change to the SR ticket --->
	
	<!--- <cfdump var="#upsertData#"> --->
	
	<!--- s: Only Add if data was actual sent --->
	<cfif StructCount(upsertData) gt 0>
		<!---  Call the upsert method. --->
		<cfhttp url = "#upsertMethodAPI#" method = "post" timeout = "60" result = "httpResp">
		  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
		  <cfhttpparam type = "body" value = "#serializeJSON(upsertData)#">
		</cfhttp>
		<!--- <cfdump var = "#httpResp#"> --->
		<cfset my311FContent = deserializeJSON(httpResp.filecontent)>
		<cfset my311Status = my311FContent.status>
		<!--- <cfdump var = "#my311FContent.status#"> --->
		<cfif my311Status.code neq "311">
			<cfset request.srupdate_err_message=my311Status.message>
		</cfif>
	<cfelse>
		<cfset request.srupdate_err_message = "No parameters were sent">
	</cfif>
	<!--- e: Only Add if data was actual sent --->

</cfif>

<cfif request.srupdate_err_message is not ""><cfset request.srupdate_success = "N"></cfif>

  <!--- Catch any errors and send out an email. --->
  <!--- <cfcatch type="any">
  	<cfset request.srupdate_err_message="An unknown error occured.  An email notification has been sent out to nathan.neumann@lacity.org">
  	<!--- Send an email on application errors. --->
  	<cfmail to="nathan.neumann@lacity.org" from="ita.csd@lacity.org" type="html"
  					subject="myla311 - #cgi.http_host# - ERROR">
  	  <table border="1" cellpadding="0">
  	   <tr>
  				<td>Comments</td>
  				<td>
  					This error was generated from the try/catch in myla311.cfm.
  				</td>
  			</tr>
  	   <tr>
  	     <td>Template</td>
  	     <td>#CGI.SERVER_NAME##CGI.SCRIPT_NAME#</td>
  	   </tr>
  	   <tr>
  	    	<td>Date/Time</td>
  	   		<td>#DateFormat(now(),"mm/dd/yyyy")#/#TimeFormat(now(),"HH:mm:ss")#</td>
  	 		</tr>
  			<tr>
  	      <td>CFCatch</td>
  	      <td><cfdump var="#cfcatch#" label="CFCatch"></td>
  	    </tr>
  	    <tr>
  	      <td>CGI Scope</td>
  	      <td><cfdump var="#CGI#" label="CGI Scope"></td>
  	    </tr>
  			<tr>
  				<td>Local variables</td>
  				<td><cfdump var="#variables#" label="Local variables"></td>
  			</tr>
  	  </table>
  	</cfmail>
  </cfcatch>

  </cftry> --->
  
 <!---  <cfoutput>#request.srupdate_success#<br></cfoutput>
  <cfoutput>#request.srupdate_err_message#<br></cfoutput> --->
