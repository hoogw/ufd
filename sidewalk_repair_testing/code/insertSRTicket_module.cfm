
<!-- Developed by: Nathan Neumann 10/06/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfsetting showDebugOutput="Yes">
<cfsetting RequestTimeout = 3000>

<!--- <cfparam name="attributes.srNum" default="1-125267271"> ---> <!--- Sidewalk --->
<!--- <cfparam name="attributes.srNum" default="1-128304871"> ---><!--- Tree --->

<cfparam name="attributes.srNum" default="">				<!--- The passed SR Number (myLA311) --->

<cfset request.srticket_success = "Y"> 						<!--- Tells whether the insert was successful (Y/N) --->
<cfset request.srticket_err_message = ""> 					<!--- If the attempt wasn't successful, there will be an error message --->
<cfset request.srticket_srnum = ""> 						<!--- Returned SR Number from myLA311 if successful, otherwise it will return "" --->

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<!--- <cftry> --->

<!--- Setup script variables --->
<cfset queryMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/SANQueryPageSR">
<!--- Query the existing SR to get the Pertinent Information for the New Ticket --->
<cfset queryJSON = {
    "MetaData": {},
    "QueryRequest": {
        "SRNumber": "#attributes.srNum#",
        "NewQuery":"new",
        "PageSize":"10",
        "StartRowNum":"1"
    }
}>

<!---  Call the query method. --->
<cfhttp url = "#queryMethodAPI#" method = "post" timeout = "180" result = "httpQueryResp"
        proxyServer="bcproxy.ci.la.ca.us" proxyPort="8080">
  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
  <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
</cfhttp>

<!--- Validate the returned JSON data --->
<cfif !IsJSON(httpQueryResp.Filecontent)>
  <cfset request.srticket_err_message = "Something went wrong with the httpMyLA311Resp variable and cfhttp call.">
<!--- Data is valid so keep going --->
<cfelse>
  <cfset myla311Data = DeserializeJSON(httpQueryResp.Filecontent)>
  <cfif myla311Data.status.code neq "311">
        <cfset request.srticket_err_message="The max number of retries was exceeded">
  </cfif>
</cfif>

<cfif request.srticket_err_message is ""> <!--- s: Do request --->

<!--- Setup script variables --->
<cfset upsertMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/UpsertSR">
<cfif request.production is "p"><cfset upsertMethodAPI = "#request.myLA311Root#/myla311router/mylasrbe/1/UpsertSANSRWithCodes"></cfif>
<cfset updateUserID = "BOEINTEGRATION">

<!--- <cfset upsertData = {
  "MetaData": {},
  "SRData": {
    "SRTBRow": "3",
    "SRNeighborhoodCouncilName": "GREATER WILSHIRE NC",
    "SRYCoordinate": "1852332",
    "Zipcode": "90004",
    "ListOfLa311ServiceRequestNotes": {
      "La311ServiceRequestNotes": [
        {
          "Comment": "TEST!! 3",
          "CreatedByUser": "SANSTAR",
          "CommentType": "External",
          "Notification": "N"
        }
      ]
    },
    "NewContactFirstName": "",
    "ParentSRNumber": "",
    "SRCouncilDistrictMember": "David Ryu",
    "Language": "English",
    "Latitude": "34.0818452015",
    "Longitude": "-118.327046966",
    "NewContactEmail": "",
    "HasImage": "N",
    "UpdatedByUserLogin": "SANSTAR",
    "MobilOS": "",
    "SRCommunityPoliceStationPREC": "1",
    "CreatedByUserLogin": "SANSTAR",
    "SRAddress": "600 N ROSSMORE AVE, 90004",
    "AssignTo": "108, UFD",
    "Source": "Self Service",
    "SRAreaPlanningCommissionId": "4",
    "LoginUser": "T22222",
    "Status": "Open",
    "Owner": "BSS",
    "LADWPAccountNo": "",
    "CustomerAccessNumber": "",
    "SRXCoordinate": "6462648",
    "SRTBMapGridPage": "593",
    "Priority": "Normal",
    "SRCouncilDistrictNo": "4",
    "NewContactLastName": "",
    "Anonymous": "N",
    "ListOfLa311GisLayer": {
      "La311GisLayer": [
        {
          "A_Call_No": "",
          "Area": "",
          "Day": "",
          "DirectionSuffix": "",
          "DistrictAbbr": "",
          "DistrictName": "Hollywood",
          "DistrictNumber": "108",
          "DistrictOffice": "North Central",
          "Fraction": "",
          "R_Call_No": "",
          "SectionId": "4630200",
          "ShortDay": "",
          "StreetFrom": "ARDEN PL",
          "StreetTo": "CLINTON ST",
          "StreetLightId": "",
          "StreetLightStatus": "",
          "Type": "GIS",
          "Y_Call_No": "",
          "Name": "BOE09292016170657242100",
          "CommunityPlanningArea": "Wilshire",
          "BOSRadioHolderName": "",
          "FranchiseeName": "",
          "FranchiseeZone": "",
          "HaulerPhoneNum": ""
        }
      ]
    },
    "ListOfLa311StreetTreeInspection": {
      "La311StreetTreeInspection": [
        {
          "ApprovedBy": "",
          "AssignedTo": "",
          "CompletedBy": "",
          "Contact": "",
          "ContactDate": "",
          "Crew": "",
          "DateCompleted": "",
          "InfestedTreeLocation": "Parkway",
          "InspectedBy": "",
          "InspectionDate": "",
          "InspectionType": "Tree Diseased or Infested",
          "OtherTreeWellInspectionType": "",
          "StumpRemovalLocation": "",
          "TreePlantingLocation": "",
          "TreeRemovalReason": "",
          "TreeStakeInspectionType": "",
          "TreeWellInspectionType": "",
          "Type": "Street Tree Inspection",
          "TreeRemovalLocation": "",
          "OptionalTrackingCode": "",
          "DivisionName": "Urban Forestry",
          "ContactFirstName": "Anonymous",
          "ContactLastName": "User"
        }
      ]
    },
    "Assignee": "",
    "NewContactPhone": "",
    "SRTBColumn": "F",
    "SRSuffix": "AVE",
    "SRHouseNumber": "600",
    "SRAreaPlanningCommission": "Central APC",
    "SRType": "Street Tree Inspection",
    "SRCommunityPoliceStationAPREC": "WILSHIRE",
    "SRStreetName": "ROSSMORE",
    "SRDirection": "N",
    "SRNeighborhoodCouncilId": "119"
  },
  "RequestSpecificDetail": {
    "ParentSRNumberForLink": ""
  }
}
> --->

<cfset upSertList = "SRTBRow,SRNeighborhoodCouncilName,SRYCoordinate,Zipcode,ListOfLa311ServiceRequestNotes,NewContactFirstName,ParentSRNumber,SRCouncilDistrictMember,Language,Latitude,Longitude,NewContactEmail,HasImage,UpdatedByUserLogin,MobilOS,SRCommunityPoliceStationPREC,CreatedByUserLogin,SRAddress,AssignTo,Source,SRAreaPlanningCommissionId,LoginUser,Status,Owner,LADWPAccountNo,CustomerAccessNumber,SRXCoordinate,SRTBMapGridPage,Priority,SRCouncilDistrictNo,NewContactLastName,Anonymous,ListOfLa311GisLayer,ListOfLa311StreetTreeInspection,Assignee,NewContactPhone,SRTBColumn,SRSuffix,SRHouseNumber,SRAreaPlanningCommission,SRType,SRCommunityPoliceStationAPREC,SRStreetName,SRDirection,SRNeighborhoodCouncilId">

<cfset the311Records = myla311Data.Response.ListOfServiceRequest.ServiceRequest[1]>
<cfset theGISLayers = the311Records.ListOfLa311GisLayer>

<cfset upsertData = {
  "MetaData": {},
  "SRData": {},
  "RequestSpecificDetail": {
    "ParentSRNumberForLink": "#attributes.srNum#"
  }
}
>
<!--- s: Loop through and get all the corresponding data from original request and assign to new ticket--->
<cfset arrayUpsert = listToArray(upSertList,",")>
<cfset newSRData = StructNew()>
<cfloop index="i" from="1" to="#arrayLen(arrayUpsert)#">
	<cfset v = evaluate("the311Records.#arrayUpsert[i]#")>
	<cfset setVariable("newSRData.#arrayUpsert[i]#",v)>
</cfloop>
<cfset newSRData.ListOfLa311GisLayer = theGISLayers>
<!--- s: Loop through and get all the corresponding data from original request and assign to new ticket --->

<!--- s: Set the assigned SRData values --->
<cfset newSRData.Anonymous = "N">
<cfset newSRData.AssignTo = "108, UFD">
<cfset newSRData.CreatedByUserLogin = "#updateUserID#">
<cfset newSRData.HasImage = "N">
<cfset newSRData.Language = "English">
<cfset newSRData.Owner = "BSS">
<cfset newSRData.ParentSRNumber = "#attributes.srNum#">
<cfset newSRData.Priority = "Normal">
<cfset newSRData.Source = "Self Service">
<cfset newSRData.Status = "Open">
<cfset newSRData.SRType = "Street Tree Inspection">
<cfset newSRData.UpdatedByUserLogin = "#updateUserID#">
<cfset newSRData.NewContactEmail = ""> 	<!--- Set to "" because we don't want to send constituent an email --->
<!--- e: Set the static SRData values --->

<!--- s: Create new message --->
<cfset msgStruct = {
   "La311ServiceRequestNotes": [
     {
       "Comment": "This is a Tree Inspection Request associated with SR #attributes.srNum# (Sidewalk Rebate Request)",
       "CreatedByUser": "#updateUserID#",
       "CommentType": "External",
       "Notification": "N"
     }
   ]}>
<cfset newSRData.ListOfLa311ServiceRequestNotes = msgStruct>
<!--- e: Create new message --->

<!--- s: Create inspection structure --->
<cfset inspectStruct = {
  "La311StreetTreeInspection": [
    {
      "ApprovedBy": "",
      "AssignedTo": "",
      "CompletedBy": "",
      "Contact": "",
      "ContactDate": "",
      "Crew": "",
      "DateCompleted": "",
      "InfestedTreeLocation": "",
      "InspectedBy": "",
      "InspectionDate": "",
      "InspectionType": "Sidewalk Rebate Program",
      "OtherTreeWellInspectionType": "",
      "StumpRemovalLocation": "",
      "TreePlantingLocation": "",
      "TreeRemovalReason": "",
      "TreeStakeInspectionType": "",
      "TreeWellInspectionType": "",
      "Type": "Street Tree Inspection",
      "TreeRemovalLocation": "",
      "OptionalTrackingCode": "",
      "DivisionName": "Urban Forestry",
      "ContactFirstName": "Anonymous",
      "ContactLastName": "User"
    }
  ]}>
<cfset newSRData.ListOfLa311StreetTreeInspection = inspectStruct>
<!--- e: Create inspection structure --->

<cfset upsertData.SRData = newSRData>

<!--- <cfdump var="#the311Records#"> --->

<cfdump var="#upsertData#">
<cfabort>


<!---  Call the upsert method. --->
<cfhttp url = "#upsertMethodAPI#" method = "post" timeout = "180" result = "httpResp">
  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
  <cfhttpparam type = "body" value = "#serializeJSON(upsertData)#">
</cfhttp>

<!--- <cfdump var = "#httpResp#"> --->

<cfset jsonResponse = DeserializeJSON(httpResp.Filecontent)>
<!--- <cfdump var = "#jsonResponse#"> --->
<cfset newSRnum = jsonResponse.Response.ListOfServiceRequest.ServiceRequest[1].SRNumber>
<cfset request.srticket_srnum = newSRnum>

</cfif> <!--- e: Do request --->

<cfif request.srticket_err_message is not ""><cfset request.srticket_success = "N"></cfif>

  <!--- Catch any errors and send out an email. --->
<!--- <cfcatch type="any">
  	<h4>An unknown error occured.  An email notification has been sent out to eduardo.magos@lacity.org</h4>
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
  
<!---   <cfoutput>#request.srticket_success#<br></cfoutput>
  <cfoutput>#request.srticket_err_message#<br></cfoutput>
  <cfoutput>#request.srticket_srnum#<br></cfoutput> --->
