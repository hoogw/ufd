<!--- *********************************************** --->
<!--- myLA311toARP.cfm                         --->
<!--- Data pulled from MyLA311                        --->
<!--- *********************************************** --->

<!-- Adjusted by: Nathan Neumann 12/7/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

<!--- Setup script variables --->
<cfset maxNumberRetries = 3>
<cfset retriesSoFar = 0>
<!--- <cfset queryMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/SANQueryPageSR"> --->
<cfset queryMethodAPI = "https://myla311test.lacity.org/myla311router/mylasrbe/1/SANQueryPageSR">
<cfset createdDateStart = DateFormat(DateAdd("h", -24, Now()),"MM/dd/yyyy") & " " & TimeFormat(DateAdd("h", -24, Now()),"HH:mm:ss")> <!--- Start date set 6 Hours before Now() --->
<cfset createdDateEnd = DateFormat(Now(),"MM/dd/yyyy") & " " & TimeFormat(Now(),"HH:mm:ss")>
<cfset newQuery = "new">
<cfset pageSize = "10">
<cfset startRowNum = "0">
<cfset lastPage = "false">
<cfset loopCount = 0>
<cfset totalRecordsReturned = 0>
<cfset myla311Records = ArrayNew(1)>
<cfset arpDS = "accessprogram"> <!--- This is the datasource for the ssr_info table --->
<cfset arpTable = "ar_info"> <!--- This is the ssr_info table --->
<cfset error_email = "nathan.neumann@lacity.org"> <!--- This is email address to get the error. Should be "essam.amarragy@lacity.org" --->

<!--- Get timestamp to record the start time of this script --->
<cfset scriptStartTime = now()>
<!--- Set a variable for the tab character... --->
<!--- <cfset tab = chr(9)> --->
<cfset tab = ",">

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
  <cfhttp url = "#queryMethodAPI#" method = "post" timeout = "120" result = "httpMyLA311Resp">
    <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
    <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
  </cfhttp>

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
		<!--- <cffile action="write" output="#httpMyLA311Resp.Filecontent#" file="#expandPath('./raw.json')#" addnewline="yes"> --->

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
	  <cfabort>
	  
      <cfloop array="#the311Records#" index="i">
	  
	  		<!--- <cfdump var = "#i#"> --->
	  
			<cfset srCreatedDate = CreateODBCDateTime(i.CreatedDate)>
			<cfset srCleanedAddress = trim(replace(replace(i.SRAddress,",","","ALL"),i.Zipcode,"","ALL"))>
			<cfset srZip = i.Zipcode>
			<cfset srHN = i.SRHouseNumber>
			<cfset srDir = i.SRDirection>
			<cfset srStrNm = i.SRStreetName>
			<cfset srSfx = i.SRSuffix>
			<cfset srUnit = i.SRUnitNumber>
			<cfset srNo = i.SRNumber>
			<cfset srCD = i.SRCouncilDistrictNo>
			<cfset srTBM = i.SRTBMapGridPage & " " & i.SRTBColumn & i.SRTBRow>
			<cfset srX = i.SRXCoordinate>
			<cfset srY = i.SRYCoordinate>
			<cfset lat = i.Latitude>
			<cfset lon = i.Longitude>
			
			<!--- s: New Contact and Existing Contact Info is stored in different fields, so check the data --->
			<cfset srFirstName = i.NewContactFirstName><cfif srFirstName is ""><cfset srFirstName = i.LA311CreatedByFirstName></cfif>
			<cfset srLastName = i.NewContactLastName><cfif srLastName is ""><cfset srLastName = i.LA311CreatedByLastName></cfif>
			<cfset srEmail = i.NewContactEmail><cfif srEmail is ""><cfset srEmail = i.Email></cfif>
			<cfset srPhone = i.NewContactPhone><cfif srPhone is ""><cfset srPhone = i.HomePhone></cfif>
			<!--- e: New Contact and Existing Contact Info is stored in different fields, so check the data --->
			
			<!--- s: Grab the comments, if any --->
			<cfset the311Comments = i.ListOfLa311ServiceRequestNotes.La311ServiceRequestNotes>
			<!--- <cfdump var = "#the311Comments#"> --->
			
			<cfset srCmts = ""><cfset srACmts = ""><cfset srECmts = "">
			<cfif arrayLen(the311Comments) gt 0>
				<cfloop array="#the311Comments#" index="j">
					<cfif j.CommentType is "External">
						<cfset srECmts = j.Comment>
					<cfelseif j.CommentType is "SidewalkAccess Description">
						<cfset srACmts = j.Comment>
					<cfelse>
						<cfset srCmts = j.Comment>
					</cfif>
				</cfloop>
				<!--- <cfif srECmts is not "" AND srACmts is not ""><cfset srCmts = srACmts & " / " & srECmts></cfif> --->
			</cfif>
			<!--- e: Grab the comments, if any --->
			
			
			<!--- s: Grab the GIS data, if any --->
			<cfset theGISData = i.ListOfLa311GisLayer.La311GisLayer>
			<cfset srFromSt = ucase(trim(theGISData[1].StreetFrom))>
			<cfset srToSt = ucase(trim(theGISData[1].StreetTo))>
			<cfset srSectionID = ucase(trim(theGISData[1].SectionId))>
			
			<!--- s: Get the owned_by_type --->
			<cfset srType = ""><cfset srBarrier = ""><cfset srMethod = ""><cfset srMyEmail = ""><cfset srMyTTY = ""><cfset srMyPhone = ""><cfset srMyVideo = ""><cfset srMobility = "">
			<cfset srMAddress = ""><cfset srMUnit = ""><cfset srMCity = ""><cfset srMState = ""><cfset srMZip = "">
			<cfif StructCount(i.ListOfLa311SidewalkAccess) gt 0>
				<cfset the311SidewalkAccess = i.ListOfLa311SidewalkAccess.La311SidewalkAccess>
				<cfset srType = ucase(trim(the311SidewalkAccess[1].Type))>
				<cfset srBarrier = ucase(trim(the311SidewalkAccess[1].AccessBarrierType))>
				<cfset srMethod = ucase(trim(the311SidewalkAccess[1].CommunicationMethod))>
				<cfset srMyEmail = ucase(trim(the311SidewalkAccess[1].EmailAddress))>
				<cfset srMyTTY = ucase(trim(the311SidewalkAccess[1].TTYNumber))>
				<cfset srMyPhone = ucase(trim(the311SidewalkAccess[1].TelephoneNumber))>
				<cfset srMyVideo = ucase(trim(the311SidewalkAccess[1].VideoContactNumber))>
				<cfset srMobility = ucase(trim(the311SidewalkAccess[1].MobilityDisability))>
				<cfset srMAddress = ucase(trim(the311SidewalkAccess[1].StreetAddress))>
				<cfset srMUnit = ucase(trim(the311SidewalkAccess[1].UnitNumber))>
				<cfset srMCity = ucase(trim(the311SidewalkAccess[1].City))>
				<cfset srMState = ucase(trim(the311SidewalkAccess[1].State))>
				<cfset srMZip = ucase(trim(the311SidewalkAccess[1].ZIP))>
				<cfif srMobility is not "">
					<cfif ucase(left(srMobility,6)) is "I AM A">
						<cfset srMobility = "Person">
					<cfelse>
						<cfset srMobility = "On Behalf">
					</cfif>
				</cfif>
				<cfif srEmail is ""><cfset srEmail = srMyEmail></cfif>
				<cfif srMUnit is not ""><cfset srMUnit = "Unit " & srMUnit></cfif>
			</cfif>
			<!--- e: Get the owned_by_type --->
			
			<!--- s: Grab the uploaded files, if any --->
			<cfset srFiles = "">
			<!--- <cfdump var = "#StructCount(i.ListOfLa311SrPhotoId)#"> --->
			<cfif StructCount(i.ListOfLa311SrPhotoId) gt 0>
				<cfset the311FileURLs = i.ListOfLa311SrPhotoId.La311SrPhotoId>
				<cfif arrayLen(the311FileURLs) gt 0>
					<cfloop array="#the311FileURLs#" index="j">
						<cfif srFiles is ""><cfset srFiles = j.PhotoLocation>
						<cfelse><cfset srFiles = srFiles & "|" & j.PhotoLocation>
						</cfif>
					</cfloop>
				</cfif>
			</cfif>
			<!--- e: Grab the uploaded files, if any --->

			<!--- s: Replace all varchar with double single quotes to prevent insert errors --->
			<cfset srCleanedAddress = replace(srCleanedAddress,"'","''","ALL")>
			<cfset srStrNm = replace(srStrNm,"'","''","ALL")>
			<cfset srUnit = replace(srUnit,"'","''","ALL")>
			<cfset srName = replace(srFirstName,"'","''","ALL") & " " & replace(srLastName,"'","''","ALL")>
			<cfset srEmail = replace(srEmail,"'","''","ALL")>
			<cfset srPhone = replace(srPhone,"'","''","ALL")>
			<cfset srCmts = replace(srCmts,"'","''","ALL")>
			<cfset srECmts = replace(srECmts,"'","''","ALL")>
			<cfset srACmts = replace(srACmts,"'","''","ALL")>
			<cfset srFiles = replace(srFiles,"'","''","ALL")>
			<cfset srMyEmail = replace(srMyEmail,"'","''","ALL")>
			<cfset srMyTTY = replace(srMyTTY,"'","''","ALL")>
			<cfset srMyPhone = replace(srMyPhone,"'","''","ALL")>
			<cfset srMyVideo = replace(srMyVideo,"'","''","ALL")>
			<cfset srFromSt = replace(srFromSt,"'","''","ALL")>
			<cfset srToSt = replace(srToSt,"'","''","ALL")>
			<cfset srMAddress = replace(srMAddress,"'","''","ALL")>
			<cfset srMUnit = replace(srMUnit,"'","''","ALL")>
			<cfset srMCity = replace(srMCity,"'","''","ALL")>
			<cfset srMState = replace(srMState,"'","''","ALL")>
			<cfset srMZip = replace(srMZip,"'","''","ALL")>
			<!--- e: Replace all varchar with double single quotes to prevent insert errors --->
			
			
			<!--- <cfoutput><br>#srCreatedDate# #srFirstName# #srLastName# #srEmail# #srPhone# #srCleanedAddress# #srZip#</cfoutput>
			<cfoutput><br>#srHN# #srStrNm# #srNo# #srCD# #srTBM#</cfoutput>
			<cfoutput><br>#srCmts#</cfoutput> --->
			
			
			<!--- s: Filter added to make sure only Incentive program requests are added --->
				<!--- "BSS" should be changed to "BOE" when ready --->
				<!--- "Anonymous" is so no anonymous user gets in. This will not be allowed in myLA311 but this is an extra check --->
				<!--- Check if Status is "Open" as well. I'm not sure this is needed --->
				<!--- May need to add a filter for "type" under  the311Records.ListOfLa311SidewalkRepair.La311SidewalkRepair --->
			<cfif i.Owner is "BOE" AND ucase(srFirstName) is not "ANONYMOUS" AND ucase(i.Status) is "OPEN" AND srType is "SIDEWALK ACCESS"> 	
			
				<!--- <cfdump var = "#i#"> --->
			
				<!--- s: Check if request already exists in the database and add if not there --->
				<cfquery name="checkRecords" datasource="#arpDS#">
				SELECT count(*) as cnt FROM #arpTable# WHERE sr_number = '#srNo#'
				</cfquery>
	
				<cfif checkRecords.cnt is 0>
					<!--- s: Insert Records into the srr_info table --->
					<cfquery name="insertRecords" datasource="#arpDS#">
					INSERT INTO #arpTable# (
						[ddate_submitted],
						[sr_number],
						[app_name_nn],
						[app_address1_nn],
						[app_state_nn],
						[app_zip_nn],
						[app_phone_nn],
						[app_email_nn],
						[job_address],
						[zip_cd],
						[unit_range],
						[hse_nbr],
						[hse_dir_cd],
						[str_nm],
						[str_sfx_cd],
						<cfif trim(srFromSt) is not "">[from_st],</cfif>
						<cfif trim(srToSt) is not "">[to_st],</cfif>
						<cfif trim(srSectionID) is not "">[section_id],</cfif>
						<cfif trim(srX) is not "">[x_coord],</cfif>
      					<cfif trim(srY) is not "">[y_coord],</cfif>
      					<cfif trim(lon) is not "">[longitude],</cfif>
      					<cfif trim(lat) is not "">[latitude],</cfif>
						<cfif trim(srFiles) is not "">[sr_attachments],</cfif>
						[tbm_grid],
						[council_dist],
						<cfif trim(srCmts) is not "">[sr_location_comments],</cfif>
						<cfif trim(srACmts) is not "">[sr_access_comments],</cfif>
						<cfif trim(srECmts) is not "">[sr_app_comments],</cfif>
      					<cfif trim(srMyEmail) is not "">[sr_email],</cfif>
      					<cfif trim(srMyTTY) is not "">[sr_tty_number],</cfif>
      					<cfif trim(srMyPhone) is not "">[sr_phone],</cfif>
      					<cfif trim(srMyVideo) is not "">[sr_video_phone],</cfif>
						<cfif trim(srMAddress) is not "">[mailing_address1],</cfif>
      					<cfif trim(srMUnit) is not "">[mailing_address2],</cfif>
      					<cfif trim(srMCity) is not "">[mailing_city],</cfif>
      					<cfif trim(srMState) is not "">[mailing_state],</cfif>
      					<cfif trim(srMZip) is not "">[mailing_zip],</cfif>
						[sr_access_barrier_type],
						[sr_communication_method],
						[sr_mobility_disability]<!--- ,
						[address_verified] --->
					)
					Values (
						#srCreatedDate#,
						'#srNo#',
						'#preservesinglequotes(srName)#',
						'#preservesinglequotes(srCleanedAddress)#',
						'CA',
						'#srZip#',
						'#preservesinglequotes(srPhone)#',
						'#preservesinglequotes(srEmail)#',
						'#preservesinglequotes(srCleanedAddress)#',
						'#srZip#',
						'#preservesinglequotes(srUnit)#',
						'#srHN#',
						'#srDir#',
						'#srStrNm#',
						'#srSfx#',
						<cfif trim(srFromSt) is not "">'#srFromSt#',</cfif>
						<cfif trim(srToSt) is not "">'#srToSt#',</cfif>
						<cfif trim(srSectionID) is not "">'#srSectionID#',</cfif>
						<cfif trim(srX) is not "">#srX#,</cfif>
						<cfif trim(srY) is not "">#srY#,</cfif>
						<cfif trim(lon) is not "">#lon#,</cfif>
						<cfif trim(lat) is not "">#lat#,</cfif>
						<cfif trim(srFiles) is not "">'#preservesinglequotes(srFiles)#',</cfif>
						'#trim(srTBM)#',
						'#srCD#',
						<cfif trim(srCmts) is not "">'#preservesinglequotes(srCmts)#',</cfif>
						<cfif trim(srACmts) is not "">'#preservesinglequotes(srACmts)#',</cfif>
						<cfif trim(srECmts) is not "">'#preservesinglequotes(srECmts)#',</cfif>
						<cfif trim(srMyEmail) is not "">'#preservesinglequotes(srMyEmail)#',</cfif>
      					<cfif trim(srMyTTY) is not "">'#preservesinglequotes(srMyTTY)#',</cfif>
      					<cfif trim(srMyPhone) is not "">'#preservesinglequotes(srMyPhone)#',</cfif>
      					<cfif trim(srMyVideo) is not "">'#preservesinglequotes(srMyVideo)#',</cfif>
						<cfif trim(srMAddress) is not "">'#preservesinglequotes(srMAddress)#',</cfif>
      					<cfif trim(srMUnit) is not "">'#preservesinglequotes(srMUnit)#',</cfif>
      					<cfif trim(srMCity) is not "">'#preservesinglequotes(srMCity)#',</cfif>
      					<cfif trim(srMState) is not "">'#preservesinglequotes(srMState)#',</cfif>
      					<cfif trim(srMZip) is not "">'#preservesinglequotes(srMZip)#',</cfif>
						'#srBarrier#',
						'#srMethod#',						
						'#srMobility#'<!--- ,
						0 --->
					)
					</cfquery>
					<!--- e: Insert Records into the srr_info table --->
				
				</cfif>
				<!--- e: Check if request already exists in the database and add if not there --->
		
			</cfif> <!--- e: Filter added to make sure only Incentive program requests are added --->
			
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
		<h4>An unknown error occured.  An email notification has been sent out to nathan.neumann@lacity.org</h4>
	<!--- Send an email on application errors. --->
	<cfmail to="#error_email#" from="#error_email#" type="html"
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


<!-- The following line was added by Essam to trigger another script. -->
<!--- <cfmodule template="ar_script_run_after_download_from311.cfm"> --->
