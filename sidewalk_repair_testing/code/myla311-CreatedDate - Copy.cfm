<!--- *********************************************** --->
<!--- myla311-CreatedDate.cfm                         --->
<!--- Data pulled from MyLA311                        --->
<!--- *********************************************** --->
<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

<!--- Setup script variables --->
<cfset maxNumberRetries = 3>
<cfset retriesSoFar = 0>
<cfset queryMethodAPI = "https://myla311test.lacity.org/myla311router/mylasrbe/1/SANQueryPageSR">
<cfset createdDateStart = "08/21/2016 00:00:00">
<cfset createdDateEnd = "08/22/2016 23:59:59">
<cfset newQuery = "new">
<cfset pageSize = "10">
<cfset startRowNum = "0">
<cfset lastPage = "false">
<cfset loopCount = 0>
<cfset totalRecordsReturned = 0>
<cfset myla311Records = ArrayNew(1)>

<!--- Get timestamp to record the start time of this script --->
<cfset scriptStartTime = now()>
<!--- Set a variable for the tab character... --->
<!--- <cfset tab = chr(9)> --->
<cfset tab = ",">

<!--- Setup an empty query to populate with the returned records. --->
<cfset qry_myLA311 = queryNew("srNumber,createdDate,updatedDate,actionTaken,owner,srType,status,source,mobilos,anonymous,
															assignTo,serviceDate,closedDate,reasonCode,resolutionCode,addressVerified,srApproximateAddress,
															srAddress,srHouseNumber,srDirection,srStreetName,srSuffix,zipcode,
															latitude,longitude,srTBMapGridPage,srTBColumn,srTBRow,srAreaPlanningCommission,
															srCouncilDistrictNo,srCouncilDistrictMember,srNeighborhoodCouncilID,
															srNeighborhoodCouncilName,srCommunityPoliceStationAPREC",
															"VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,
															VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,
															VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,
															VarChar,VarChar,VarChar,VarChar,VarChar")>

<!--- Setup the header row for the csv file... --->
<cfset Str = "">
<cfset Str = 'SRNumber' & tab	& 'CreatedDate'	& tab  & 'UpdatedDate' & tab  & 'ActionTaken' & tab	& 'Owner' & tab
				& 'RequestType' & tab	& 'Status' & tab	& 'RequestSource' & tab	& 'MobileOS' & tab	& 'Anonymous' & tab
				& 'AssignTo' & tab & 'ServiceDate' & tab
				& 'ClosedDate' & tab & 'ReasonCode' & tab & 'ResolutionCode' & tab & 'AddressVerified' & tab
				& 'ApproximateAddress' & tab & 'Address' & tab & 'HouseNumber' & tab & 'Direction' & tab
				& 'StreetName' & tab & 'Suffix' & tab & 'ZipCode' & tab & 'Latitude' & tab & 'Longitude' & tab & 'TBMPage' & tab
				& 'TBMColumn' & tab & 'TBMRow' & tab & 'APC' & tab & 'CD' & tab & 'CDMember' & tab & 'NC' & tab & 'NCName' & tab
				& 'PolicePrecinct'>

<!--- Create the base CSV files for each SR Type --->
<cffile action="write" output="#Str#" file="#expandPath('./myla311-CreatedDate.csv')#" addnewline="yes">

<!--- The query method requires pagination since many records may be returned --->
<!--- Use a conditional loop to call the web service as many times as needed to return all the data --->
<h1>Starting the script...</h1>
<h3><cfoutput>Processing records between #createdDateStart# and #createdDateEnd#</h3></cfoutput><cfflush>
<cfloop condition="lastPage eq 'false'">
	<p>
	<cfif retriesSoFar eq 0>
		<cfset loopCount = loopCount + 1>
  		<strong>Loop: <cfoutput>#loopCount# |</cfoutput></strong>
	<cfelse>
		<strong><cfoutput>Retry #retriesSoFar# for loop #loopCount#. |</cfoutput></strong>
  	</cfif>
  <!--- Setup the JSON request. --->
  <cfset queryJSON = {
      "MetaData": {},
      "QueryRequest": {
          "createdSince":"#createdDateStart#",
					"createdTill":"#createdDateEnd#",
					"srType": [
						"Sidewalk Repair"
          ],
					"SortBy": "Created Date",
					"SortOrder": "DESC",
          "NewQuery":"#newQuery#",
          "PageSize":"#pageSize#",
          "StartRowNum":"#startRowNum#"
      }
  }>

<!--- <cfdump var = "#queryJSON#"><cfdump var = "#lastUpdatedTimestamp#"><cfabort showerror="yep"> --->
  <!---  Call the query method. --->
  <cfhttp url = "#queryMethodAPI#" method = "post" timeout = "60" result = "httpMyLA311Resp">
    <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
    <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
  </cfhttp>

<!--- <cfdump var = "#httpMyLA311Resp#">
<cfset data = deserializeJSON(httpMyLA311Resp.Filecontent) />
<cfset data = data.response.ListOfServiceRequest.ServiceRequest>
<cfdump var = "#data#">
<cfabort> --->

  <!---  Check the response codes --->
  <cfif !IsDefined("httpMyLA311Resp.Responseheader.Status_Code")>
  	<cfthrow message="There is no status code.">
  </cfif>
  <cfswitch expression="#httpMyLA311Resp.Responseheader.Status_Code#">
  	<cfcase value="503">
  		<cfthrow message="Your call failed and returned an HTTP status of 503. That means: Service unavailable. An internal problem prevented us from returning data to you.">
  	</cfcase>
  	<cfcase value="403">
  		<cfthrow message="Your call failed and returned an HTTP status of 403. That means: Forbidden. You do not have permission to access this resource, or are over your rate limit.">
  	</cfcase>
  	<cfcase value="400">
  		<cfthrow message="Your call failed  and returned an HTTP status of 400.  That means: Bad request. The parameters passed to the service did not match as expected. The exact error is returned in the XML response.">
  	</cfcase>
  	<cfcase value="200">
  		<!--- Good response, do nothing. --->
  	</cfcase>
  	<cfdefaultcase>
  		<cfthrow message="Your call returned an unexpected HTTP status of: #httpMyLA311Resp.responseHeader.status_code#">
  	</cfdefaultcase>
  </cfswitch>

  <!--- Validate the returned JSON data --->
  <cfif !IsJSON(httpMyLA311Resp.Filecontent)>
    <h1>Something went wrong.</h1>
		<cfthrow message = "Something went wrong with the httpMyLA311Resp variable and cfhttp call.">
  <!--- Data is valid so keep going --->
  <cfelse>
    <cfset myla311Data = DeserializeJSON(httpMyLA311Resp.Filecontent)>
    <!--- Store the raw json that was returned.--->
		<cffile action="write" output="#httpMyLA311Resp.Filecontent#" file="#expandPath('./raw.json')#" addnewline="yes">

    <!--- Process the response codes and summarize the data --->
    <cfif myla311Data.status.code neq "311">
		<!-- Retry up to three times, sleeping for 1000 ms between retries. --->
		<cfif retriesSoFar lt maxNumberRetriesMyLA311>
			<cfset retriesSoFar = retriesSoFar + 1>
			</p>
			<cfscript>
				sleep(1000);
			</cfscript>
			<cfcontinue>
		<cfelse>
      		<h1>Something went wrong with the JSON request</h1>
      	  <cfthrow message="The max number of retries was exceeded">
		</cfif>
    <cfelse>
		<cfset retriesSoFar = 0>
      <cfset totalRecordsReturned = totalRecordsReturned + myla311Data.Response.NumOutputObjects>
      <cfoutput>
      	Records returned for this page: <strong>#myla311Data.Response.NumOutputObjects#</strong> | Total Records Processed: <strong>#totalRecordsReturned#</strong> | Last Page: <strong>#myla311Data.Response.LastPage#</strong>
      </cfoutput>
    </cfif>

    <!--- Now let's handle the actual records --->
    <cfif myla311Data.Response.NumOutputObjects neq 0>
      <cfset the311Records = myla311Data.Response.ListOfServiceRequest.ServiceRequest>
	  <cfdump var = "#the311Records#">

      <cfloop array="#the311Records#" index="i">
				<cfset formattedCreatedDate = trim(DateFormat(i.CreatedDate, "yyyy-mm-dd")&" "&TimeFormat(i.CreatedDate, "HH:mm:ss"))>
				<cfset formattedUpdatedDate = trim(DateFormat(i.UpdatedDate, "yyyy-mm-dd")&" "&TimeFormat(i.UpdatedDate, "HH:mm:ss"))>
				<cfset formattedServiceDate = trim(DateFormat(i.ServiceDate, "yyyy-mm-dd")&" "&TimeFormat(i.ServiceDate, "HH:mm:ss"))>
				<cfset formattedClosedDate = trim(DateFormat(i.ClosedDate, "yyyy-mm-dd")&" "&TimeFormat(i.ClosedDate, "HH:mm:ss"))>
				<cfset cleanedSRAddress = trim(i.SRAddress)>
        <!--- Populate the query structure with the data returned in the JSON feed --->
        <cfset queryAddRow(qry_myLA311,1)>
    		<cfset querySetCell(qry_myLA311,"srNumber",i.SRNumber)>
				<cfset querySetCell(qry_myLA311,"createdDate",formattedCreatedDate)>
				<cfset querySetCell(qry_myLA311,"updatedDate",formattedUpdatedDate)>
				<cfset querySetCell(qry_myLA311,"actionTaken",i.ActionTaken)>
				<cfset querySetCell(qry_myLA311,"owner",i.Owner)>
				<cfset querySetCell(qry_myLA311,"srType",i.SRType)>
				<cfset querySetCell(qry_myLA311,"status",i.Status)>
				<cfset querySetCell(qry_myLA311,"source",i.Source)>
				<cfset querySetCell(qry_myLA311,"mobilos",i.MobilOS)>
    		<cfset querySetCell(qry_myLA311,"anonymous",i.Anonymous)>
				<cfset querySetCell(qry_myLA311,"assignTo",i.AssignTo)>
				<cfset querySetCell(qry_myLA311,"serviceDate",formattedServiceDate)>
				<cfset querySetCell(qry_myLA311,"closedDate",formattedClosedDate)>
				<cfset querySetCell(qry_myLA311,"reasonCode",i.ReasonCode)>
				<cfset querySetCell(qry_myLA311,"resolutionCode",i.ResolutionCode)>
				<cfset querySetCell(qry_myLA311,"addressVerified",i.AddressVerified)>
        <cfset querySetCell(qry_myLA311,"srApproximateAddress",i.SRApproximateAddress)>
				<cfset querySetCell(qry_myLA311,"srAddress",cleanedSRAddress)>
				<cfset querySetCell(qry_myLA311,"srHouseNumber",i.SRHouseNumber)>
				<cfset querySetCell(qry_myLA311,"srDirection",i.SRDirection)>
				<cfset querySetCell(qry_myLA311,"srStreetName",i.SRStreetName)>
				<cfset querySetCell(qry_myLA311,"srSuffix",i.SRSuffix)>
				<cfset querySetCell(qry_myLA311,"zipcode",i.Zipcode)>
				<cfset querySetCell(qry_myLA311,"latitude",i.Latitude)>
    		<cfset querySetCell(qry_myLA311,"longitude",i.Longitude)>
    		<cfset querySetCell(qry_myLA311,"srTBMapGridPage",i.SRTBMapGridPage)>
    		<cfset querySetCell(qry_myLA311,"srTBColumn",i.SRTBColumn)>
    		<cfset querySetCell(qry_myLA311,"srTBRow",i.SRTBRow)>
        <cfset querySetCell(qry_myLA311,"srAreaPlanningCommission",i.SRAreaPlanningCommission)>
    		<cfset querySetCell(qry_myLA311,"srCouncilDistrictNo",i.SRCouncilDistrictNo)>
				<cfset querySetCell(qry_myLA311,"srCouncilDistrictMember",i.SRCouncilDistrictMember)>
        <cfset querySetCell(qry_myLA311,"srNeighborhoodCouncilID",i.SRNeighborhoodCouncilId)>
    		<cfset querySetCell(qry_myLA311,"srNeighborhoodCouncilName",i.SRNeighborhoodCouncilName)>
    		<cfset querySetCell(qry_myLA311,"srCommunityPoliceStationAPREC",i.SRCommunityPoliceStationAPREC)>
      </cfloop>
    <cfelse>
      <h2>No records to process.</h2>
    </cfif>

    <!--- Update the JSON request variables in case another loop is required. --->
		<cfset lastPage = myla311Data.Response.LastPage>
    <cfset startRowNum =  startRowNum + pageSize>
		<cfset newQuery = "false">

  </cfif>
  </p><cfflush>
	<cfscript>
		sleep(1000);
	</cfscript>
</cfloop>

<!--- Now that we've gathered all the data from the service let's review the results. --->
<cfloop query="qry_myLA311">
  <cfset Str = "">
  <cfset Str = Str
    & chr(34)&qry_myLA311.srNumber&chr(34) & tab
    & chr(34)&qry_myLA311.createdDate&chr(34) & tab
    & chr(34)&qry_myLA311.updatedDate&chr(34) & tab
    & chr(34)&qry_myLA311.actionTaken&chr(34) & tab
		& chr(34)&qry_myLA311.owner&chr(34) & tab
		& chr(34)&qry_myLA311.srType&chr(34) & tab
    & chr(34)&qry_myLA311.status&chr(34) & tab
    & chr(34)&qry_myLA311.source&chr(34) & tab
    & chr(34)&qry_myLA311.mobilos&chr(34) & tab
    & chr(34)&qry_myLA311.anonymous&chr(34) & tab
		& chr(34)&qry_myLA311.assignTo&chr(34) & tab
		& chr(34)&qry_myLA311.serviceDate&chr(34) & tab
    & chr(34)&qry_myLA311.closedDate&chr(34) & tab
		& chr(34)&qry_myLA311.reasonCode&chr(34) & tab
		& chr(34)&qry_myLA311.resolutionCode&chr(34) & tab
		& chr(34)&qry_myLA311.addressVerified&chr(34) & tab
    & chr(34)&qry_myLA311.srApproximateAddress&chr(34) & tab
    & chr(34)&qry_myLA311.srAddress&chr(34) & tab
    & chr(34)&qry_myLA311.srHouseNumber&chr(34) & tab
    & chr(34)&qry_myLA311.srDirection&chr(34) & tab
    & chr(34)&qry_myLA311.srStreetName&chr(34) & tab
		& chr(34)&qry_myLA311.srSuffix&chr(34) & tab
    & chr(34)&qry_myLA311.zipcode&chr(34) & tab
    & chr(34)&qry_myLA311.latitude&chr(34) & tab
    & chr(34)&qry_myLA311.longitude&chr(34) & tab
    & chr(34)&qry_myLA311.srTBMapGridPage&chr(34) & tab
    & chr(34)&qry_myLA311.srTBColumn&chr(34) & tab
    & chr(34)&qry_myLA311.srTBRow&chr(34) & tab
    & chr(34)&qry_myLA311.srAreaPlanningCommission&chr(34) & tab
    & chr(34)&qry_myLA311.srCouncilDistrictNo&chr(34) & tab
		& chr(34)&qry_myLA311.srCouncilDistrictMember&chr(34) & tab
		& chr(34)&qry_myLA311.srNeighborhoodCouncilID&chr(34) & tab
		& chr(34)&qry_myLA311.srNeighborhoodCouncilName&chr(34) & tab
    & chr(34)&qry_myLA311.srCommunityPoliceStationAPREC&chr(34)>

  <!--- Append a new row with the record information. --->
  <cffile action="append" output="#Str#" file="#expandPath('./myla311-CreatedDate.csv')#" addnewline="yes">

</cfloop>

<cfset scriptEndTime = now()>
<cfoutput>
<h1>Overall Summary</h1>
<h3>All new/updated records between: #createdDateStart# and #createdDateEnd#</h3>
<h3>Total Records Returned by JSON: #totalRecordsReturned#</h3>
<h3>
  Start: #DateFormat(scriptStartTime,"mm-dd-yyyy")# #TimeFormat(scriptStartTime,"h:mm:ss tt")#<br/>
  Finish: #DateFormat(scriptEndTime,"mm-dd-yyyy")# #TimeFormat(scriptEndTime,"h:mm:ss tt")#<br/>
	Running Time (min): #DateDiff("n", scriptStartTime, scriptEndTime)#
</h3>
</cfoutput>

<!--- Catch any errors and send out an email. --->
<cfcatch type="any">
		<h4>An unknown error occured.  An email notification has been sent out to eduardo.magos@lacity.org</h4>
	<!--- Send an email on application errors. --->
	<cfmail to="eduardo.magos@lacity.org" from="eduardo.magos@lacity.org" type="html"
					subject="myla311 - #cgi.http_host# - ERROR">
	  <table border="1" cellpadding="0">
	   <tr>
				<td>Comments</td>
				<td>
					This error was generated from the try/catch.
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
