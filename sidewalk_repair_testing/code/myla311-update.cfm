<!--- *********************************************** --->
<!--- MyLA311-update.cfm                              --->
<!--- Data updates to MyLA311                         --->
<!--- *********************************************** --->


<cfparam name="attributes.srNum" default="1-125267271">
<cfparam name="attributes.srCode" default="01">
<cfparam name="attributes.srComment" default="Here is a test">

<cfset request.srupdate_err_message = ""> 


<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

<!--- Setup script variables --->
<cfset queryMethodAPI = "https://myla311test.lacity.org/myla311router/mylasrbe/1/SANQueryPageSR">
<cfset upsertMethodAPI = "https://myla311test.lacity.org/myla311router/mylasrbe/1/UpsertSR">
<!--- <cfset srNum = "1-125267271"> --->
<cfset updateUserID = "ITACID311">

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
<cfhttp url = "#queryMethodAPI#" method = "post" timeout = "60" result = "httpQueryResp"
        proxyServer="bcproxy.ci.la.ca.us" proxyPort="8080">
  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
  <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
</cfhttp>

<!--- Validate the returned JSON data --->
<cfif !IsJSON(httpQueryResp.Filecontent)>
  <h1>Something went wrong.</h1>
  <cfset request.srupdate_err_message = "Something went wrong with the httpMyLA311Resp variable and cfhttp call.">
<!--- Data is valid so keep going --->
<cfelse>
  <cfset myla311Data = DeserializeJSON(httpQueryResp.Filecontent)>
  
  <!--- <cfdump var="#myla311Data#">
  <cfabort> --->

  <!--- Process the response codes and summarize the data --->
  <cfif myla311Data.status.code neq "311">
    <h1>Something went wrong with the JSON request</h1>
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

<cfset upsertData = {
  "MetaData": {},
  "SRData": {
    "SRNumber": "#srNum#",
    "SRType": "Sidewalk Repair",
    "IntegrationId": "#integrationID#",
    "UpdatedByUserLogin": "#updateUserID#",
    "ListOfLa311ServiceRequestNotes": {
      "La311ServiceRequestNotes": [
        {
          "Comment": "Testing the upsert by adding a new comment. ##1",
          "CreatedByUser": "#updateUserID#",
          "CommentType": "External",
          "Notification": "N"
        }
      ]
    }
  }
}>

<!---  Call the upsert method. --->
<cfhttp url = "#upsertMethodAPI#" method = "post" timeout = "60" result = "httpResp"
        >
  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
  <cfhttpparam type = "body" value = "#serializeJSON(upsertData)#">
</cfhttp>

<cfdump var = "#httpResp#">


  <!--- Catch any errors and send out an email. --->
  <cfcatch type="any">
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

  </cftry>
