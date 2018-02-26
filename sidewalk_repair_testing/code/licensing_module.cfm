
<!-- Developed by: Nathan Neumann 09/15/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfparam name="attributes.license_no" default="1016000">	<!--- The passed Contractor's license number --->

<cfset request.cont_valid = "Y">				<!--- Tells whether the contractor number is valid (Y/N) --->
<cfset request.cont_err_message = "">			<!--- Will be returned with INVALID contactor number --->
<cfset request.expired = "Y">					<!--- Tells whether the contractor license is expired (Y/N) --->
<cfset request.cont_entity = "">				<!--- Contractor license entity information --->
<cfset request.cont_iss_date = "">				<!--- Contractor license issue date --->
<cfset request.cont_exp_date = "">				<!--- Contractor expire date --->
<cfset request.cont_name = "">					<!--- Contractor Name --->
<cfset request.cont_address = "">				<!--- Contractor Address --->
<cfset request.cont_city = "">					<!--- Contractor City --->
<cfset request.cont_state = "">					<!--- Contractor State --->
<cfset request.cont_zip = "">					<!--- Contractor Zipcode --->
<cfset request.cont_phone = "">					<!--- Contractor Phone Number --->
<cfset request.cont_multiclass = "N">			<!--- Tells whether there are multiple classifications listed (Y/N) --->
<cfset request.cont_class = "">					<!--- List of classifications, multiples delimited by a bar(|) --->
<cfset request.cont_link = "">					<!--- List of classifications url links (relative), multiples delimited by a bar(|) --->
<cfset request.cont_bond_filed_with = "">		<!--- Bonding Information: Who the license is filed with --->
<cfset request.cont_bond_filed_link = "">		<!--- Bonding Information: Who the license is filed with url link (relative) --->
<cfset request.cont_bond_number = "">			<!--- Bonding Information: Bond Number --->
<cfset request.cont_bond_amount = "">			<!--- Bonding Information: Bond Amount --->
<cfset request.cont_bond_eff_date = "">			<!--- Bonding Information: Bond Effective Date --->
<cfset request.cont_bond_cncl_date = "">		<!--- Bonding Information: Bond Cancellation Date --->
<cfset request.cont_bond_ind_message = "">		<!--- Bond of Qualifying Individual: Explanation Text --->
<cfset request.cont_bond_ind_eff_date = "">		<!--- Bond of Qualifying Individual: Effective Date --->
<cfset request.cont_comp_message = "">			<!--- Workers Compensation: Explanation Text --->
<cfset request.cont_comp_eff_date = "">			<!--- Workers Compensation: Effective Date --->
<cfset request.cont_comp_exp_date = "">			<!--- Workers Compensation: Expire Date --->


<cfhttp url="https://www2.cslb.ca.gov/OnlineServices/CheckLicenseII/LicenseDetail.aspx?LicNum=#attributes.license_no#" method="GET" proxyServer="bcproxy.ci.la.ca.us" proxyPort="8080"> 
<!--- <cfdump var="#cfhttp.FileContent#">  --->


<cfset arrHTML = listToArray(cfhttp.FileContent,"<")>
<cfset classLink = false>
<cfset isBondDiv = false>
<cfset isBusiDiv = false>
<cfset isIndDiv = false>
<cfset isCompDiv = false>
<cfset isIndInfo = false>
<cfset arrBusiness = arrayNew(1)>
<cfset arrBond = arrayNew(1)>
<cfset arrInd = arrayNew(1)>
<cfset arrComp = arrayNew(1)>
<cfset classification = "">
<cfset link = "">

<!--- Check to see if the request is valid --->
<cfloop index="i" from="1" to="#arrayLen(arrHTML)#">
	<cfset str = arrHTML[i]>
	<cfif find("ctl00_LeftColumnMiddle_ErrMsg",str,1)>
		<cfset request.cont_valid = "N">
		<cfset request.cont_message = right(str,len(str)-find(">",str,1))>
		<cfbreak>
	</cfif>
</cfloop>

<!--- Go ahead if valid --->
<cfif request.cont_valid is "Y">

	<cfloop index="i" from="1" to="#arrayLen(arrHTML)#">
		<cfset str = arrHTML[i]>
		
		<!--- This gets the entity date date --->
		<cfif find("ctl00_LeftColumnMiddle_Entity",str,1)>
			<cfset entity = right(str,len(str)-find(">",str,1))>
		</cfif>
		
		<!--- This gets the issued date date --->
		<cfif find("ctl00_LeftColumnMiddle_IssDt",str,1)>
			<cfset issued_dt = right(str,len(str)-find(">",str,1))>
		</cfif>
		
		<!--- This gets the expiration date --->
		<cfif find("ctl00_LeftColumnMiddle_ExpDt",str,1)>
			<cfset expiration_dt = right(str,len(str)-find(">",str,1))>
			
			<cfset arrExp = listToArray(expiration_dt,"/")>
			<cfset chk_dt = CreatedateTime(arrExp[3],arrExp[1],arrExp[2],23,59,59)>
			<cfif chk_dt gt Now()>
				<cfset request.expired = "N">
			</cfif>
			
		</cfif>
		
		<!--- This gets the classification and relative link --->
		<cfif find("ctl00_LeftColumnMiddle_ClassCellTable",str,1) gt 0><cfset classLink = true></cfif>
		<cfif find("Licensing_Classifications",str,1) AND classLink>
			<cfset arrLink = listToArray(str,"""")>
			<cfset classification = classification & "|" & right(str,len(str)-find(">",str,1))>
			<!--- <cfset classLink = false> --->
			<cfset link = link & "|" & arrLink[2]>
		</cfif>
		<cfif find("/blockquote",str,1) gt 0><cfset classLink = false></cfif>
		
		
		<!--- This gets the bond link --->
		<cfif find("ctl00_LeftColumnMiddle_BondingCellTable",str,1) gt 0><cfset isBondDiv = true></cfif>
		<cfif ucase(left(str,2)) is "A " AND isBondDiv>
			<cfset arrTmp = listToArray(str,">")>
			<cfset request.cont_bond_filed_with = trim(arrTmp[2])>
			<cfset arrTmp2 = listToArray(arrTmp[1],"'")>
			<cfif arrayLen(arrTmp2) gt 1>
				<cfset request.cont_bond_filed_link = trim(arrTmp2[2])>
			</cfif>
		</cfif>
		<cfif find("strong",str,1) AND isBondDiv>
			<cfset arrTmp = listToArray(str,">")>
			<cfset arrayAppend(arrBond,trim(arrTmp[2]))>
		</cfif>
		<cfif find("/blockquote",str,1) gt 0><cfset isBondDiv = false></cfif>
		
		<cfif find(ucase("Qualifying Individual"),ucase(str),1) gt 0><cfset isIndDiv = true></cfif>
		<cfif isIndDiv>
			<cfif find("blockquote",str,1) gt 0><cfset isIndInfo = true></cfif>
			<cfif isIndInfo>
				<cfset arrTmp = listToArray(str,">")>
				<cfif arrayLen(arrTmp) gt 1>
					<cfset arrayAppend(arrInd,trim(arrTmp[2]))>
				</cfif>
			</cfif>
		</cfif>
		<cfif find("/blockquote",str,1) gt 0><cfset isIndDiv = false><cfset isIndInfo = false></cfif>
		
		
		<!--- This gets the workers comp information --->
		<cfif isCompDiv>
			<cfset arrTmp = listToArray(str,">")>
			<cfif arrayLen(arrTmp) gt 1>
				<cfset arrayAppend(arrComp,trim(arrTmp[2]))>
			</cfif>
		</cfif>
		<cfif find("ctl00_LeftColumnMiddle_WCStatus",str,1) gt 0><cfset isCompDiv = true></cfif>
		<cfif find("/blockquote",str,1) gt 0><cfset isCompDiv = false></cfif>
		
		
		<!--- This gets the business information --->
		<cfif isBusiDiv>
			<cfif ucase(left(str,2)) is "BR">
				<cfset arrTmp = listToArray(str,">")>
				<cfif arrayLen(arrTmp) gt 1><cfset arrayAppend(arrBusiness,trim(arrTmp[2]))></cfif>
			</cfif>
		</cfif>
		<cfif find("ctl00_LeftColumnMiddle_BusInfo",str,1) gt 0><cfset isBusiDiv = true><cfset arrayAppend(arrBusiness,trim(right(str,len(str)-find(">",str,1))))></cfif>
		<cfif find("td>",str,1) gt 0><cfset isBusiDiv = false></cfif>
		
	</cfloop>
	
	<!--- s: Loop through the Business array to get separate components --->
	<cfif arrayLen(arrBusiness) gt 0>
		<cfset stopName = false>
		<cfset stopAddr = false>
		<cfset stopCity = false>
		<cfset busi = "">
		<cfloop index="i" from="1" to="#arrayLen(arrBusiness)#">
			<cfif isNumeric(left(arrBusiness[i],1))>
				<cfset stopName = true>
			</cfif>
			<cfif stopName is false>
				<cfset busi = trim(busi & " " & arrBusiness[i])>
			<cfelse>
				<cfset request.cont_name = busi>
				<cfif stopAddr is false>
					<cfset stopAddr = true>
					<cfset request.cont_address = arrBusiness[i]>
				<cfelse>
					<cfif stopCity is false>
						<cfset stopCity = true>
						<cfset arrCity = listToArray(arrBusiness[i],",")>
						<cfset request.cont_city = arrCity[1]>
						<cfset arrZip = listToArray(arrCity[2]," ")>
						<cfset request.cont_state = arrZip[1]>
						<cfset request.cont_zip = arrZip[2]>
					<cfelse>
						<cfset arrPhone = listToArray(arrBusiness[i],":")>
						<cfset request.cont_phone = arrPhone[2]>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	
	</cfif>
	<!--- e: Loop through the Business array to get separate components --->
	
	<!--- s: Loop through the Bonds array to get separate components --->
	<cfif arrayLen(arrBond) gt 0>
		<cfloop index="i" from="1" to="#arrayLen(arrBond)#">
			<cfswitch expression="#i#"> 
			    <cfcase value="2"><cfset request.cont_bond_number = trim(arrBond[i])></cfcase> 
			    <cfcase value="4"><cfset request.cont_bond_amount = trim(arrBond[i])></cfcase> 
				<cfcase value="6"><cfset request.cont_bond_eff_date = trim(arrBond[i])></cfcase> 
				<cfcase value="8"><cfset request.cont_bond_cncl_date = trim(arrBond[i])></cfcase> 
			</cfswitch> 
		</cfloop>
	</cfif>
	<cfif arrayLen(arrInd) gt 0>
		<cfloop index="i" from="1" to="#arrayLen(arrInd)#">
			<cfswitch expression="#i#"> 
			    <cfcase value="1"><cfset request.cont_bond_ind_message = trim(arrInd[i])></cfcase> 
			    <cfcase value="3"><cfset request.cont_bond_ind_eff_date = trim(arrInd[i])></cfcase> 
			</cfswitch> 
		</cfloop>
	</cfif>
	<!--- e: Loop through the Bonds array to get separate components --->
	
	<!--- s: Loop through the Workers Comp array to get separate components --->
	<cfif arrayLen(arrComp) gt 0>
		<cfloop index="i" from="1" to="#arrayLen(arrComp)#">
			<cfswitch expression="#i#">
			    <cfcase value="1"><cfset request.cont_comp_message = trim(arrComp[i])></cfcase> 
			    <cfcase value="3"><cfset request.cont_comp_eff_date = trim(arrComp[i])></cfcase> 
				<cfcase value="5"><cfset request.cont_comp_exp_date = trim(arrComp[i])></cfcase> 
			</cfswitch> 
		</cfloop>
	</cfif>
	<!--- e: Loop through the Workers Comp array to get separate components --->
	

	<cfset request.cont_entity = entity>
	<cfset request.cont_iss_date = issued_dt>
	<cfset request.cont_exp_date = expiration_dt>
	<cfif classification is not ""><cfset request.cont_class = right(classification,len(classification)-1)></cfif>
	<cfif link is not ""><cfset request.cont_link = right(link,len(link)-1)></cfif>
	<cfif arrayLen(listToArray(request.cont_class,"|")) gt 1><cfset request.cont_multiclass = "Y"></cfif>
	
</cfif>

<!--- <cfoutput>Valid: #request.cont_valid#<br></cfoutput>
<cfoutput>Error Message: #request.cont_err_message#<br></cfoutput>

<cfoutput>Business: #request.cont_name#<br></cfoutput>
<cfoutput>Address: #request.cont_address#<br></cfoutput>
<cfoutput>City: #request.cont_city#<br></cfoutput>
<cfoutput>State: #request.cont_state#<br></cfoutput>
<cfoutput>Zipcode: #request.cont_zip#<br></cfoutput>
<cfoutput>Phone: #request.cont_phone#<br></cfoutput>

<cfoutput>Entity: #request.cont_entity#<br></cfoutput>
<cfoutput>Iss_Date: #request.cont_iss_date#<br></cfoutput>
<cfoutput>Exp_Date: #request.cont_exp_date#<br></cfoutput>
<cfoutput>Class: #request.cont_class#<br></cfoutput>
<cfoutput>Link: #request.cont_link#<br></cfoutput>
<cfoutput>Expired: #request.expired#<br></cfoutput>
<cfoutput>MultiClass: #request.cont_multiclass#<br></cfoutput>

<cfoutput>Filed With: #request.cont_bond_filed_with#<br></cfoutput>
<cfoutput>Filed Link: #request.cont_bond_filed_link#<br></cfoutput>
<cfoutput>Bond Number: #request.cont_bond_number#<br></cfoutput>
<cfoutput>Bond Amount: #request.cont_bond_amount#<br></cfoutput>
<cfoutput>Bond Effective Date: #request.cont_bond_eff_date#<br></cfoutput>
<cfoutput>Bond Cancellation Date: #request.cont_bond_cncl_date#<br></cfoutput>
<cfoutput>Bond Individual Message: #request.cont_bond_ind_message#<br></cfoutput>
<cfoutput>Bond Individual Effective Date: #request.cont_bond_ind_eff_date#<br></cfoutput>

<cfoutput>WC Message: #request.cont_comp_message#<br></cfoutput>
<cfoutput>WC Effective Date: #request.cont_comp_eff_date#<br></cfoutput>
<cfoutput>WC Expire Date: #request.cont_comp_exp_date#<br></cfoutput> --->

<!--- <cfdump var="#arrComp#"> --->