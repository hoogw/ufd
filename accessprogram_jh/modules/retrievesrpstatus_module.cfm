
<!-- Developed by: Nathan Neumann 12/20/16 *** CITY OF LOS ANGELES *** 213-482-7124 *** nathan.neumann@lacity.org -->

<cfparam name="attributes.sr_no" default="">				<!--- The passed sr_number (1-382648434) --->

<cfset request.srp_has_package = "N"> 					<!--- Indicates whether the sr number has been assigned to a package (Y/N) --->	
<cfset request.srp_has_ntp = "N"> 						<!--- Indicates whether the package has been issued a notice to proceed (Y/N) --->	
<cfset request.srp_construction_started = "N"> 			<!--- Indicates whether construction has started for the sr number (Y/N) --->	
<cfset request.srp_construction_completed = "N"> 		<!--- Indicates whether construction has completed for the sr number (Y/N) --->	
<cfset request.srp_package = ""> 						<!--- The package number --->	
<cfset request.srp_ntp_date = ""> 						<!--- The notice to proceed date --->	
<cfset request.srp_construction_start_date = ""> 		<!--- The construction start date --->	
<cfset request.srp_construction_completed_date = "">	<!--- The construction completed date --->	
<cfset request.srp_status = "">							<!--- The stage of the process (Unassigned,Packaged,Notice to Proceed,Under Construction,Completed) --->	

<cfset request.srp_retrieval_success = "Y"> 			<!--- Indicates whether the request was successful or not (Y/N) --->	
<cfset request.srp_retrieval_error_message = ""> 		<!--- Message if there's an error --->	

<cfset pDS = "sidewalk_spatial">

<!--- Wrap entire scheduled task in a try/catch - send email if any errors are generated. --->
<cftry>

	<cfquery name="getSiteInfo" datasource="#pDS#">
	SELECT a.SR_Number, a.Location_No, a.Package_Group + '-' + CAST(a.Package_No AS varchar) AS Package, 
	b.Notice_To_Proceed_Date, a.Construction_Start_Date, a.Construction_Completed_Date
	FROM dbo.tblSites AS a INNER JOIN dbo.tblPackages AS b ON a.Package_No = b.Package_No AND a.Package_Group = b.Package_Group
	WHERE a.sr_number = '#attributes.sr_no#'
	</cfquery>
	
	<!--- <cfdump var="#getSiteInfo#"> --->
	
	<cfif getSiteInfo.recordcount gt 0>
		<cfset request.srp_status = "Unassigned">
		<cfloop query="getSiteInfo">
			<cfif package is not "">
				<cfset request.srp_has_package = "Y">
				<cfset request.srp_package = package>
				<cfset request.srp_status = "Packaged">		
			</cfif>
			<cfif notice_to_proceed_date is not "">
				<cfset request.srp_has_ntp = "Y">
				<cfset request.srp_ntp_date = DateFormat(notice_to_proceed_date,"mm/dd/yyyy")>
				<cfset request.srp_status = "Notice to Proceed">		
			</cfif>
			<cfif construction_start_date is not "">
				<cfset request.srp_construction_started = "Y">
				<cfset request.srp_construction_start_date = DateFormat(construction_start_date,"mm/dd/yyyy")>
				<cfset request.srp_status = "Under Construction">		
			</cfif>
			<cfif construction_completed_date is not "">
				<cfset request.srp_construction_completed = "Y">
				<cfset request.srp_construction_completed_date = DateFormat(construction_completed_date,"mm/dd/yyyy")>
				<cfset request.srp_status = "Completed">		
			</cfif>
		
		</cfloop>
		
	</cfif>
	
<cfcatch type="any">
  	<cfset request.srp_retrieval_success = "N">
	<cfset request.srp_retrieval_error_message = "Database Error."> 
</cfcatch>

</cftry>
  
<!--- <cfoutput>#request.srp_has_package#<br></cfoutput>
<cfoutput>#request.srp_has_ntp#<br></cfoutput>
<cfoutput>#request.srp_construction_started#<br></cfoutput>
<cfoutput>#request.srp_construction_completed#<br></cfoutput>
<cfoutput>#request.srp_package#<br></cfoutput>
<cfoutput>#request.srp_ntp_date#<br></cfoutput>
<cfoutput>#request.srp_construction_start_date#<br></cfoutput>
<cfoutput>#request.srp_construction_completed_date#<br></cfoutput>
<cfoutput>#request.srp_status#<br></cfoutput>
<cfoutput>#request.srp_retrieval_success#<br></cfoutput>
<cfoutput>#request.srp_retrieval_error_message#</cfoutput> --->
