<cfcomponent output="false">
	
	<cffunction name="addSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_sno" required="true">
		<!--- <cfargument name="sw_sfx" required="true"> --->
		<cfargument name="sw_name" required="true">
		<cfargument name="sw_address" required="true">
		<cfargument name="sw_type" required="true">
		<cfargument name="sw_cd" required="true">
		<!--- <cfargument name="sw_assessed" required="true"> --->
		<!--- <cfargument name="sw_assessor" required="true"> --->
		<!--- <cfargument name="sw_assdate" required="true">
		<cfargument name="sw_repairs" required="true">
		<cfargument name="sw_severity" required="true"> --->
		<!--- <cfargument name="sw_qc" required="true"> --->
		<!--- <cfargument name="sw_qcdate" required="true"> --->
		<!--- <cfargument name="sw_tcon" required="true"> --->
		<!--- <cfargument name="sw_con_start" required="true">
		<cfargument name="sw_con_comp" required="true">
		<cfargument name="sw_antdate" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_loc" required="true">
		<cfargument name="sw_damage" required="true"> --->
		<cfargument name="sw_cityowned" required="true">
		<cfargument name="sw_priority" required="true">
		<cfargument name="sw_logdate" required="true">
		<cfargument name="sw_zip" required="true">
		<cfargument name="sw_curbramp" required="true">
		<!--- <cfargument name="sw_tree_notes" required="true"> --->
		
		<cfset var data = {}>
		
		<cfset tbl = "tblSites">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- Retrieve New NoteID --->
		<cfquery name="chkDuplicate" datasource="#request.sqlconn#">
		SELECT count(*) as cnt FROM #tbl# WHERE location_no = #sw_sno# <!--- AND
		<cfif sw_sfx is "">site_suffix is NULL<cfelse>site_suffix = '#sw_sfx#'</cfif> --->
		</cfquery>
		
		<cfif chkDuplicate.cnt gt 0>
			<cfset data.result = "- Site Creation Failed: Duplicate Site Number.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
			
		<cftry>
			
			<!--- <cfif sw_assdate is not "">
				<cfset arrDT = listtoarray(sw_assdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_assdate = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_qcdate is not "">
				<cfset arrDT = listtoarray(sw_qcdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_qcdate = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_antdate is not "">
				<cfset arrDT = listtoarray(sw_antdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_antdate = createODBCDate(dt)>
			</cfif> --->
			
			<cfif sw_logdate is not "">
				<cfset arrDT = listtoarray(sw_logdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_logdate = createODBCDate(dt)>
			</cfif>
			
			<!--- <cfif sw_con_start is not "">
				<cfset arrDT = listtoarray(sw_con_start,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_con_start = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_con_comp is not "">
				<cfset arrDT = listtoarray(sw_con_comp,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_con_comp = createODBCDate(dt)>
			</cfif> --->
			
			<cfset sw_name = replace(sw_name,"'","''","ALL")>
			<cfset sw_address = replace(sw_address,"'","''","ALL")>
			<!--- <cfset sw_assessor = replace(sw_assessor,"'","''","ALL")> --->
			<!--- <cfset sw_qc = replace(sw_qc,"'","''","ALL")> --->
			<!--- <cfset sw_notes = replace(sw_notes,"'","''","ALL")>
			<cfset sw_loc = replace(sw_loc,"'","''","ALL")>
			<cfset sw_damage = replace(sw_damage,"'","''","ALL")>
			<cfset sw_tree_notes = replace(sw_tree_notes,"'","''","ALL")> --->
			<!--- <cfset sw_tcon = replace(sw_tcon,",","","ALL")> --->
			
			<cfquery name="addFeature" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Location_No,
		      	<!--- <cfif trim(sw_sfx) is not "">Site_Suffix,</cfif> --->
			    <cfif trim(sw_name) is not "">Name,</cfif>
			    <cfif trim(sw_address) is not "">Address,</cfif>
			    <cfif trim(sw_type) is not "">Type,</cfif>
			    <cfif trim(sw_cd) is not "">Council_District,</cfif>
			    <!--- <cfif trim(sw_assessed) is not "">Field_Assessed,</cfif> --->
			    <!--- <cfif trim(sw_assessor) is not "">Field_Assessor,</cfif> --->
			    <!--- <cfif trim(sw_repairs) is not "">Repairs_Required,</cfif>
				<cfif trim(sw_severity) is not "">Severity_Index,</cfif>
			    <cfif trim(sw_assdate) is not "">Assessed_Date,</cfif> --->
			    <!--- <cfif trim(sw_qc) is not "">QC,</cfif> --->
			    <!--- <cfif trim(sw_qcdate) is not "">QC_Date,</cfif> --->
				<!--- <cfif trim(sw_tcon) is not "">Total_Concrete,</cfif> --->
				<!--- <cfif trim(sw_con_start) is not "">Construction_Start_Date,</cfif>
				<cfif trim(sw_con_comp) is not "">Construction_Completed_Date,</cfif>
				<cfif trim(sw_antdate) is not "">Anticipated_Completion_Date,</cfif>
			    <cfif trim(sw_notes) is not "">Notes,</cfif>
			    <cfif trim(sw_loc) is not "">Location_Description,</cfif>
			    <cfif trim(sw_damage) is not "">Damage_Description,</cfif> --->
				<!--- <cfif trim(sw_tree_desc) is not "">Tree_Removal_Description,</cfif> --->
				<cfif trim(sw_cityowned) is not "">City_Owned_Property,</cfif>
			    <!--- <cfif trim(sw_priority) is not "">Priority_No,</cfif> ---> <!--- Removed because priority number is auto generated and new sites have a null Priority --->
			    <cfif trim(sw_logdate) is not "">Date_Logged,</cfif>
			    <cfif trim(sw_zip) is not "">Zip_Code,</cfif>
				<cfif trim(sw_curbramp) is not "">Curb_Ramp_Only,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#sw_sno#,
				<!--- <cfif trim(sw_sfx) is not "">'#sw_sfx#',</cfif> --->
			    <cfif trim(sw_name) is not "">'#PreserveSingleQuotes(sw_name)#',</cfif>
			    <cfif trim(sw_address) is not "">'#PreserveSingleQuotes(sw_address)#',</cfif>
			    <cfif trim(sw_type) is not "">'#PreserveSingleQuotes(sw_type)#',</cfif>
			    <cfif trim(sw_cd) is not "">#PreserveSingleQuotes(sw_cd)#,</cfif>
			    <!--- <cfif trim(sw_assessed) is not "">#PreserveSingleQuotes(sw_assessed)#,</cfif> --->
			    <!--- <cfif trim(sw_assessor) is not "">'#PreserveSingleQuotes(sw_assessor)#',</cfif> --->
			   <!---  <cfif trim(sw_repairs) is not "">#PreserveSingleQuotes(sw_repairs)#,</cfif>
				<cfif trim(sw_severity) is not "">#PreserveSingleQuotes(sw_severity)#,</cfif>
			    <cfif trim(sw_assdate) is not "">#sw_assdate#,</cfif> --->
			    <!--- <cfif trim(sw_qc) is not "">'#PreserveSingleQuotes(sw_qc)#',</cfif> --->
			    <!--- <cfif trim(sw_qcdate) is not "">#sw_qcdate#,</cfif> --->
				<!--- <cfif trim(sw_tcon) is not "">#PreserveSingleQuotes(sw_tcon)#,</cfif> --->
				<!--- <cfif trim(sw_con_start) is not "">#PreserveSingleQuotes(sw_con_start)#,</cfif>
				<cfif trim(sw_con_comp) is not "">#PreserveSingleQuotes(sw_con_comp)#,</cfif>
				<cfif trim(sw_antdate) is not "">#sw_antdate#,</cfif>
			    <cfif trim(sw_notes) is not "">'#PreserveSingleQuotes(sw_notes)#',</cfif>
			    <cfif trim(sw_loc) is not "">'#PreserveSingleQuotes(sw_loc)#',</cfif>
			    <cfif trim(sw_damage) is not "">'#PreserveSingleQuotes(sw_damage)#',</cfif> --->
				<!--- <cfif trim(sw_tree_desc) is not "">'#PreserveSingleQuotes(sw_tree_desc)#',</cfif> --->
				<cfif trim(sw_cityowned) is not "">#sw_cityowned#,</cfif>
			    <!--- <cfif trim(sw_priority) is not "">#sw_priority#,</cfif> --->
			    <cfif trim(sw_logdate) is not "">#sw_logdate#,</cfif>
			    <cfif trim(sw_zip) is not "">#sw_zip#,</cfif>
				<cfif trim(sw_curbramp) is not "">#sw_curbramp#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
			
			<!--- <cfif sw_tree_notes is not "">
				<cfquery name="addFeature" datasource="#request.sqlconn#">		
				INSERT INTO dbo.tblTreeRemovalInfo
				( 
					Location_No,
					tree_removal_notes,
					User_ID,
					Creation_Date
				) 
				Values 
				(
					#sw_sno#,
					'#PreserveSingleQuotes(sw_tree_notes)#',
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			</cfif> --->
			
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			SELECT id FROM #tbl# WHERE location_no = #sw_sno# <!--- <cfif trim(sw_sfx) is not "">AND site_suffix = '#sw_sfx#'</cfif> --->
			</cfquery>
			
			<cfset data.id = getID.id>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Site Creation Failed: Database Error.">
		
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM #tbl# WHERE location_no = #sw_sno# <!--- <cfif trim(sw_sfx) is not "">AND site_suffix = '#sw_sfx#'</cfif> --->
			</cfquery>
			
			<!--- <cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM tblTreeRemovalInfo WHERE location_no = #sw_sno#
			</cfquery> --->
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="addPackage" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pgroup" required="true">
		<cfargument name="sw_pno" required="true">
		<cfargument name="sw_idList" required="true">
		
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Creation Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cftry>
		
			<!--- First check if Package Exists. If not, create it --->
			<cfquery name="chkExists" datasource="#request.sqlconn#">
			SELECT count(*) as cnt FROM tblPackages WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<cfif chkExists.cnt is 0>
				<cfquery name="addPackage" datasource="#request.sqlconn#">
				INSERT INTO tblPackages (
					package_no,
					package_group,
					User_ID,
					Creation_Date
				) 
				VALUES (
					#sw_pno#,
					'#sw_pgroup#',
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			<cfelse>
				<cfquery name="addPackage" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				removed = NULL,
				modified_date = #CreateODBCDateTime(Now())#,
				User_ID = #session.user_num#
				WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
				</cfquery>
			</cfif>
			
			
			<cfset arrIDs = listtoarray(sw_idList,",")>
			<cfloop index="i" from="1" to="#arrayLen(arrIDs)#">
				
				<!--- Check if it already is in a package... --->
				<cfquery name="chkExists" datasource="#request.sqlconn#">
				SELECT count(*) as cnt FROM tblSites WHERE id = #arrIDs[i]# and package_no is null AND package_group is null
				</cfquery>
				
				<cfif chkExists.cnt gt 0>
					<cfquery name="updateSite" datasource="#request.sqlconn#">
					UPDATE tblSites SET
					package_no = #sw_pno#,
					package_group = '#sw_pgroup#',
					modified_date = #CreateODBCDateTime(Now())#,
					User_ID = #session.user_num#
					WHERE id = #arrIDs[i]#
					</cfquery>
				</cfif>
				
			</cfloop>
			
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			SELECT id FROM tblPackages WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<!--- Update Package Estimates and Cost --->
			<cfquery name="getIDs" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<cfif chkExists.cnt is 0> <!--- Only do if new package --->
				<cfif getIDs.recordcount gt 0>
					<cfset str = "">
					<cfloop query="getIDs">
						<cfset str = str & location_no & ",">
					</cfloop>
					<cfset str = left(str,len(str)-1)>
					<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
					<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
					
					<cfquery name="getEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(qstr)#
					</cfquery>
					
					<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = #v#
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
					
					<cfquery name="getCEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(cqstr)#
					</cfquery>
					
					<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = #v#
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
				<cfelse>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = NULL
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
					
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = NULL
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
				</cfif>
			</cfif>
			
			<cfset data.id = getID.id>
			
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Package Creation/Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="getPackageSiteIDs" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pgroup" required="true">
		
		<cfset var data = {}>
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT package_no FROM tblPackages WHERE package_group = '#sw_pgroup#' <!--- AND removed is null ---> ORDER BY package_no
		</cfquery>
		<cfquery name="getID" datasource="#request.sqlconn#">
		SELECT max(package_no) as id FROM tblPackages WHERE package_group = '#sw_pgroup#'
		</cfquery>
		<cfif getID.id is ""><cfset swid = 1><cfelse><cfset swid = getID.id + 1></cfif>
		<cfset arrIDs = arrayNew(1)>
		<cfloop query="getIDs">
			<cfset doit = arrayAppend(arrIDs,package_no)>
		</cfloop>
		<cfset doit = arrayAppend(arrIDs,swid & "")>
		<cfset data.arrIDs = arrIDs>
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="getPackageGroup" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pno" required="true">
		
		<cfset var data = {}>
		<cfquery name="getGroup" datasource="#request.sqlconn#">
		SELECT package_group FROM tblPackages WHERE package_no = #sw_pno#
		</cfquery>
		
		<cfset data.group = ""><cfif getGroup.recordcount gt 0><cfset data.group = getGroup.package_group></cfif>
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updatePackage" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_wo" required="true">
		<cfargument name="sw_nfb" required="true">
		<cfargument name="sw_bid" required="true">
		<cfargument name="sw_co" required="true">
		<cfargument name="sw_precon" required="true">
		<cfargument name="sw_ntp" required="true">
		<cfargument name="sw_est" required="true">
		<cfargument name="sw_award" required="true">
		<cfargument name="sw_cm" required="true">
		<cfargument name="sw_contractor" required="true">
		<cfargument name="sw_cname" required="true">
		<cfargument name="sw_caddress" required="true">
		<cfargument name="sw_cemail" required="true">
		<cfargument name="sw_cphone" required="true">
		<cfargument name="sw_performance" required="true">
		<cfargument name="sw_payment" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_idList" required="true">
		<cfargument name="sw_remove" required="false" default="0">
		<cfargument name="sw_cno" required="true">
		<cfargument name="sw_fy" required="true">
		<cfargument name="sw_pstatus" required="true">
		<cfargument name="sw_eco1name" required="true">
		<cfargument name="sw_eco1phone" required="true">
		<cfargument name="sw_eco2name" required="true">
		<cfargument name="sw_eco2phone" required="true">
		<cfargument name="sw_ntea" required="true">
		<cfargument name="sw_swalk" required="true">
		<cfargument name="sw_tdn" required="true">
		<cfargument name="sw_cont" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Package Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level is not 0 AND session.user_power is not 1>
			<cfif session.user_level lt 2>
				<cfset data.result = "- Package Update Failed: You are not authorized to make edits.">
				<cfset data = serializeJSON(data)>
			    <!--- wrap --->
			    <cfif structKeyExists(arguments, "callback")>
			        <cfset data = arguments.callback & "" & data & "">
			    </cfif>
			    <cfreturn data>
				<cfabort>
			</cfif>		
		</cfif>
		
		<cftry>
		
			<!--- Set to null when needed --->
			<cfif trim(sw_wo) is ""><cfset sw_wo = "NULL"></cfif>
			<cfif trim(sw_nfb) is ""><cfset sw_nfb = "NULL"></cfif>
			<cfif trim(sw_bid) is ""><cfset sw_bid = "NULL"></cfif>
			<cfif trim(sw_co) is ""><cfset sw_co = "NULL"></cfif>
			<cfif trim(sw_precon) is ""><cfset sw_precon = "NULL"></cfif>
			<cfif trim(sw_ntp) is ""><cfset sw_ntp = "NULL"></cfif>
			<cfif trim(sw_est) is ""><cfset sw_est = "NULL"></cfif>
			<cfif trim(sw_award) is ""><cfset sw_award = "NULL"></cfif>
			<cfif trim(sw_cm) is ""><cfset sw_cm = "NULL"></cfif>
			<cfif trim(sw_contractor) is ""><cfset sw_contractor = "NULL"></cfif>
			<cfif trim(sw_cname) is ""><cfset sw_cname = "NULL"></cfif>
			<cfif trim(sw_cemail) is ""><cfset sw_cemail = "NULL"></cfif>
			<cfif trim(sw_cphone) is ""><cfset sw_cphone = "NULL"></cfif>
			<cfif trim(sw_performance) is ""><cfset sw_performance = "NULL"></cfif>
			<cfif trim(sw_payment) is ""><cfset sw_payment = "NULL"></cfif>
			<cfif trim(sw_notes) is ""><cfset sw_notes = "NULL"></cfif>
			<cfif trim(sw_caddress) is ""><cfset sw_caddress = "NULL"></cfif>
			<cfif trim(sw_cno) is ""><cfset sw_cno = "NULL"></cfif>
			<cfif trim(sw_fy) is ""><cfset sw_fy = "NULL"></cfif>
			<cfif trim(sw_pstatus) is ""><cfset sw_pstatus = "NULL"></cfif>
			<cfif trim(sw_eco1name) is ""><cfset sw_eco1name = "NULL"></cfif>
			<cfif trim(sw_eco1phone) is ""><cfset sw_eco1phone = "NULL"></cfif>
			<cfif trim(sw_eco2name) is ""><cfset sw_eco2name = "NULL"></cfif>
			<cfif trim(sw_eco2phone) is ""><cfset sw_eco2phone = "NULL"></cfif>
			<cfif trim(sw_ntea) is ""><cfset sw_ntea = "NULL"></cfif>
			<cfif trim(sw_swalk) is ""><cfset sw_swalk = "NULL"></cfif>
			<cfif trim(sw_tdn) is ""><cfset sw_tdn = "NULL"></cfif>
			<cfif trim(sw_cont) is ""><cfset sw_cont = "NULL"></cfif>
			
			<cfset sw_wo = replace(sw_wo,"'","''","ALL")>
			<cfset sw_contractor = replace(sw_contractor,"'","''","ALL")>
			<cfset sw_cname = replace(sw_cname,"'","''","ALL")>
			<cfset sw_cemail = replace(sw_cemail,"'","''","ALL")>
			<cfset sw_cphone = replace(sw_cphone,"'","''","ALL")>
			<cfset sw_notes = replace(sw_notes,"'","''","ALL")>
			<cfset sw_est = replace(sw_est,",","","ALL")>
			<cfset sw_award = replace(sw_award,",","","ALL")>
			<cfset sw_caddress = replace(sw_caddress,"'","","ALL")>
			<cfset sw_cno = replace(sw_cno,"'","","ALL")>
			<cfset sw_eco1name = replace(sw_eco1name,"'","","ALL")>
			<cfset sw_eco1phone = replace(sw_eco1phone,"'","","ALL")>
			<cfset sw_eco2name = replace(sw_eco2name,"'","","ALL")>
			<cfset sw_eco2phone = replace(sw_eco2phone,"'","","ALL")>
			<cfset sw_ntea = replace(sw_ntea,",","","ALL")>
			<cfset sw_cont = replace(sw_cont,",","","ALL")>
			
			<cfif sw_nfb is not "NULL">
				<cfset arrDT = listtoarray(sw_nfb,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_nfb = createODBCDate(dt)>
			</cfif>
			<cfif sw_bid is not "NULL">
				<cfset arrDT = listtoarray(sw_bid,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_bid = createODBCDate(dt)>
			</cfif>
			<cfif sw_co is not "NULL">
				<cfset arrDT = listtoarray(sw_co,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_co = createODBCDate(dt)>
			</cfif>
			<cfif sw_precon is not "NULL">
				<cfset arrDT = listtoarray(sw_precon,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_precon = createODBCDate(dt)>
			</cfif>
			<cfif sw_ntp is not "NULL">
				<cfset arrDT = listtoarray(sw_ntp,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_ntp = createODBCDate(dt)>
			</cfif>
			<cfif sw_swalk is not "NULL">
				<cfset arrDT = listtoarray(sw_swalk,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_swalk = createODBCDate(dt)>
			</cfif>
			<cfif sw_tdn is not "NULL">
				<cfset arrDT = listtoarray(sw_tdn,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_tdn = createODBCDate(dt)>
			</cfif>

			
			<!--- Update Package Information. --->
			<cfquery name="updatePackage" datasource="#request.sqlconn#">
			UPDATE tblPackages SET
			engineers_estimate = #sw_est#,
			work_order = <cfif sw_wo is "NULL">#sw_wo#<cfelse>'#PreserveSingleQuotes(sw_wo)#'</cfif>,
			nfb_date = #sw_nfb#,
			bids_due_date = #sw_bid#,
			construct_order_date = #sw_co#,
			precon_meeting_date = #sw_precon#,
			notice_to_proceed_date = #sw_ntp#,
			Awarded_Bid = #sw_award#,
			Contingency = #sw_cont#,
			Contractor = <cfif sw_contractor is "NULL">#sw_contractor#<cfelse>'#PreserveSingleQuotes(sw_contractor)#'</cfif>,
			Contractor_name = <cfif sw_cname is "NULL">#sw_cname#<cfelse>'#PreserveSingleQuotes(sw_cname)#'</cfif>,
			Contractor_address = <cfif sw_caddress is "NULL">#sw_caddress#<cfelse>'#PreserveSingleQuotes(sw_caddress)#'</cfif>,
			Contractor_email = <cfif sw_cemail is "NULL">#sw_cemail#<cfelse>'#PreserveSingleQuotes(sw_cemail)#'</cfif>,
			Contractor_phone = <cfif sw_cphone is "NULL">#sw_cphone#<cfelse>'#PreserveSingleQuotes(sw_cphone)#'</cfif>,
			construction_manager = <cfif sw_cm is "NULL">#sw_cm#<cfelse>'#PreserveSingleQuotes(sw_cm)#'</cfif>,
			fiscal_year = <cfif sw_fy is "NULL">#sw_fy#<cfelse>'#PreserveSingleQuotes(sw_fy)#'</cfif>,
			contract_number = <cfif sw_cno is "NULL">#sw_cno#<cfelse>'#PreserveSingleQuotes(sw_cno)#'</cfif>,
			Emergency_contact_one_name = <cfif sw_eco1name is "NULL">#sw_eco1name#<cfelse>'#PreserveSingleQuotes(sw_eco1name)#'</cfif>,
			Emergency_contact_one_phone = <cfif sw_eco1phone is "NULL">#sw_eco1phone#<cfelse>'#PreserveSingleQuotes(sw_eco1phone)#'</cfif>,
			Emergency_contact_two_name = <cfif sw_eco2name is "NULL">#sw_eco2name#<cfelse>'#PreserveSingleQuotes(sw_eco2name)#'</cfif>,
			Emergency_contact_two_phone = <cfif sw_eco2phone is "NULL">#sw_eco2phone#<cfelse>'#PreserveSingleQuotes(sw_eco2phone)#'</cfif>,
			Not_To_Exceed_Amount = #sw_ntea#,
			Site_Walk_Date = #sw_swalk#,
			Ten_Day_Notice_Date = #sw_tdn#,
			Status = #sw_pstatus#,
			performance_bond = #sw_performance#,
			payment_bond = #sw_payment#,
			notes = <cfif sw_notes is "NULL">#sw_notes#<cfelse>'#PreserveSingleQuotes(sw_notes)#'</cfif>,
			<cfif sw_remove is 1>removed = #sw_remove#,</cfif>
			modified_date = #CreateODBCDateTime(Now())#,
			User_ID = #session.user_num#
			WHERE id = #sw_id#
			</cfquery>
			
			<!--- Remove Sites --->
			<cfset data.removed = "false">
			<cfif sw_idList is not "">
				<cfset arrIDs = listtoarray(sw_idList,",")>
				<cfloop index="i" from="1" to="#arrayLen(arrIDs)#">
					
					<!--- Check if it already is in a package... --->
					<cfquery name="chkExists" datasource="#request.sqlconn#">
					SELECT count(*) as cnt FROM tblSites WHERE id = #arrIDs[i]#
					</cfquery>
					
					<cfif chkExists.cnt gt 0>
						<cfquery name="updateSite" datasource="#request.sqlconn#">
						UPDATE tblSites SET
						package_no = NULL,
						package_group = NULL,
						modified_date = #CreateODBCDateTime(Now())#,
						User_ID = #session.user_num#
						WHERE id = #arrIDs[i]#
						</cfquery>
						<cfset data.removed = "true">
					</cfif>
					
				</cfloop>
			</cfif>
			<cfif sw_remove is 1>
			
				<cfquery name="getPackage" datasource="#request.sqlconn#">
				SELECT package_no,package_group FROM tblPackages WHERE id = #sw_id#
				</cfquery>
				
				<cfquery name="updateSite" datasource="#request.sqlconn#">
				UPDATE tblSites SET
				package_no = NULL,
				package_group = NULL,
				modified_date = #CreateODBCDateTime(Now())#,
				User_ID = #session.user_num#
				WHERE package_no = #getPackage.package_no# AND package_group = '#getPackage.package_group#'
				</cfquery>
			
			</cfif>
			
			<!--- Update Package Estimates and Cost --->
			<!--- <cfquery name="getPackage" datasource="#request.sqlconn#">
			SELECT package_no as pno,package_group as pgp FROM tblPackages WHERE id = #sw_id#
			</cfquery>
			
			<cfquery name="getIDs" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
			package_group = '#getPackage.pgp#'
			</cfquery>
			
			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
				<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
				
				<cfquery name="getEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				
				<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
				<cfquery name="setEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				engineers_estimate = #v#
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
				
				<cfquery name="getCEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				
				<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
				<cfquery name="setCEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				awarded_bid = #v#
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
			<cfelse>
				<cfquery name="setEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				engineers_estimate = NULL
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
				
				<cfquery name="setCEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				awarded_bid = NULL
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
			</cfif> --->
			
			<cfset data.id = sw_id>
			
			<cfset data.remove = sw_remove>
			
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Package Creation/Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="updateSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_name" required="true">
		<cfargument name="sw_address" required="true">
		<cfargument name="sw_type" required="true">
		<cfargument name="sw_cd" required="true">
		<cfargument name="sw_assessed" required="true">
		<cfargument name="sw_assessor" required="true">
		<cfargument name="sw_assdate" required="true">
		<cfargument name="sw_repairs" required="true">
		<cfargument name="sw_severity" required="true">
		<!--- <cfargument name="sw_qc" required="true"> --->
		<cfargument name="sw_qcdate" required="true">
		<!--- <cfargument name="sw_tcon" required="true"> --->
		<cfargument name="sw_con_start" required="true">
		<cfargument name="sw_con_comp" required="true">
		<cfargument name="sw_antdate" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_loc" required="true">
		<cfargument name="sw_damage" required="true">
		<cfargument name="sw_cityowned" required="true">
		<cfargument name="sw_priority" required="true">
		<cfargument name="sw_logdate" required="true">
		<cfargument name="sw_zip" required="true">
		<!--- <cfargument name="sw_tree_desc" required="true">
		<cfargument name="sw_tree_rmv" required="true"> --->
		<!--- <cfargument name="sw_no_trees" required="true">
		<cfargument name="sw_tree_rm_date" required="true">
		<cfargument name="sw_tree_notes" required="true"> --->
		<cfargument name="sw_curbramp" required="true">
		<cfargument name="sw_designreq" required="true">
		<cfargument name="sw_dsgnstart" required="true">
		<cfargument name="sw_dsgnfinish" required="true">
		<cfargument name="sw_ait_type" required="true">
		<cfargument name="sw_costeffect" required="true">
		<cfargument name="sw_injury" required="true">
		<cfargument name="sw_disabled" required="true">
		<cfargument name="sw_complaints" required="true">
		<cfargument name="sw_excptn" required="true">	
		<cfargument name="sw_excptn_notes" required="true">
		<cfargument name="sw_pedestrian" required="true">	
		<cfargument name="do_priority" required="false" default="0">		

		<cfset tbl = "tblSites">
		<cfset tbl2 = "tblTreeRemovalInfo">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif trim(sw_type) is ""><cfset sw_type = "NULL"></cfif>
		<cfif trim(sw_cd) is ""><cfset sw_cd = "NULL"></cfif>
		<cfif trim(sw_assessed) is ""><cfset sw_assessed = "NULL"></cfif>
		<cfif trim(sw_assessor) is ""><cfset sw_assessor = "NULL"></cfif>
		<cfif trim(sw_assdate) is ""><cfset sw_assdate = "NULL"></cfif>
		<cfif trim(sw_repairs) is ""><cfset sw_repairs = "NULL"></cfif>
		<cfif trim(sw_severity) is ""><cfset sw_severity = "NULL"></cfif>
		<!--- <cfif trim(sw_qc) is ""><cfset sw_qc = "NULL"></cfif> --->
		<cfif trim(sw_qcdate) is ""><cfset sw_qcdate = "NULL"></cfif>
		<!--- <cfif trim(sw_tcon) is ""><cfset sw_tcon = "NULL"></cfif> --->
		<cfif trim(sw_con_start) is ""><cfset sw_con_start = "NULL"></cfif>
		<cfif trim(sw_con_comp) is ""><cfset sw_con_comp = "NULL"></cfif>
		<cfif trim(sw_antdate) is ""><cfset sw_antdate = "NULL"></cfif>
		<cfif trim(sw_notes) is ""><cfset sw_notes = "NULL"></cfif>
		<cfif trim(sw_loc) is ""><cfset sw_loc = "NULL"></cfif>
		<cfif trim(sw_damage) is ""><cfset sw_damage = "NULL"></cfif>
		<cfif trim(sw_cityowned) is ""><cfset sw_cityowned = "NULL"></cfif>
		<cfif trim(sw_priority) is ""><cfset sw_priority = "NULL"></cfif>
		<cfif trim(sw_logdate) is ""><cfset sw_logdate = "NULL"></cfif>
		<cfif trim(sw_zip) is ""><cfset sw_zip = "NULL"></cfif>
		<!--- <cfif trim(sw_tree_rmv) is ""><cfset sw_tree_rmv = "NULL"></cfif>
		<cfif trim(sw_tree_desc) is ""><cfset sw_tree_desc = "NULL"></cfif> --->
		<!--- <cfif trim(sw_no_trees) is ""><cfset sw_no_trees = "NULL"></cfif>
		<cfif trim(sw_tree_rm_date) is ""><cfset sw_tree_rm_date = "NULL"></cfif>
		<cfif trim(sw_tree_notes) is ""><cfset sw_tree_notes = "NULL"></cfif> --->
		<cfif trim(sw_curbramp) is ""><cfset sw_curbramp = "NULL"></cfif>
		<cfif trim(sw_designreq) is ""><cfset sw_designreq = "NULL"></cfif>
		<cfif trim(sw_dsgnstart) is ""><cfset sw_dsgnstart = "NULL"></cfif>
		<cfif trim(sw_dsgnfinish) is ""><cfset sw_dsgnfinish = "NULL"></cfif>
		<cfif trim(sw_ait_type) is ""><cfset sw_ait_type = "NULL"></cfif>
		<cfif trim(sw_costeffect) is ""><cfset sw_costeffect = "NULL"></cfif>
		<cfif trim(sw_injury) is ""><cfset sw_injury = "NULL"></cfif>
		<cfif trim(sw_disabled) is ""><cfset sw_disabled = "NULL"></cfif>
		<cfif trim(sw_complaints) is ""><cfset sw_complaints = "NULL"></cfif>
		<cfif trim(sw_pedestrian) is ""><cfset sw_pedestrian = "NULL"></cfif>	
		<cfif trim(sw_excptn) is ""><cfset sw_excptn = "NULL"></cfif>
		<cfif trim(sw_excptn_notes) is ""><cfset sw_excptn_notes = "NULL"></cfif>	
		
		<cfif sw_assdate is not "NULL">
			<cfset arrDT = listtoarray(sw_assdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_assdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_qcdate is not "NULL">
			<cfset arrDT = listtoarray(sw_qcdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_qcdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_antdate is not "NULL">
			<cfset arrDT = listtoarray(sw_antdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_antdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_logdate is not "NULL">
			<cfset arrDT = listtoarray(sw_logdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_logdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_con_start is not "NULL">
			<cfset arrDT = listtoarray(sw_con_start,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_con_start = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_con_comp is not "NULL">
			<cfset arrDT = listtoarray(sw_con_comp,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_con_comp = createODBCDate(dt)>
		</cfif>
		
		<!--- <cfif sw_tree_rm_date is not "NULL">
			<cfset arrDT = listtoarray(sw_tree_rm_date,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_tree_rm_date = createODBCDate(dt)>
		</cfif> --->
		
		<cfif sw_dsgnstart is not "NULL">
			<cfset arrDT = listtoarray(sw_dsgnstart,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_dsgnstart = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_dsgnfinish is not "NULL">
			<cfset arrDT = listtoarray(sw_dsgnfinish,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_dsgnfinish = createODBCDate(dt)>
		</cfif>
		
		<cfset sw_name = replace(sw_name,"'","''","ALL")>
		<cfset sw_address = replace(sw_address,"'","''","ALL")>
		<cfset sw_assessor = replace(sw_assessor,"'","''","ALL")>
		<!--- <cfset sw_qc = replace(sw_qc,"'","''","ALL")> --->
		<cfset sw_notes = replace(sw_notes,"'","''","ALL")>
		<cfset sw_loc = replace(sw_loc,"'","''","ALL")>
		<cfset sw_damage = replace(sw_damage,"'","''","ALL")>
		<!--- <cfset sw_tcon = replace(sw_tcon,",","","ALL")> --->
		<cfset sw_tree_notes = replace(sw_tree_notes,"'","''","ALL")>
		<cfset sw_excptn_notes = replace(sw_excptn_notes,"'","''","ALL")>
		
		<cfquery name="addFeature" datasource="#request.sqlconn#">		
		UPDATE #tbl# SET
		Name = '#PreserveSingleQuotes(sw_name)#',
		Address = '#PreserveSingleQuotes(sw_address)#',
		Type = #sw_type#,
		Council_District = #sw_cd#,
		Field_Assessed = #sw_assessed#,
		Field_Assessor = <cfif sw_assessor is "NULL">#sw_assessor#<cfelse>'#PreserveSingleQuotes(sw_assessor)#'</cfif>,
		Repairs_Required = #sw_repairs#,
		Severity_Index = #sw_severity#,
		Assessed_Date = #sw_assdate#,
		<!--- QC = <cfif sw_qc is "NULL">#sw_qc#<cfelse>'#PreserveSingleQuotes(sw_qc)#'</cfif>, --->
		QC_Date = #sw_qcdate#,
		<!--- Total_Concrete = #sw_tcon#, --->
		Construction_Start_Date = #sw_con_start#,
		Construction_Completed_Date = #sw_con_comp#,
		Anticipated_Completion_Date = #sw_antdate#,
		Notes = <cfif sw_notes is "NULL">#sw_notes#<cfelse>'#PreserveSingleQuotes(sw_notes)#'</cfif>,
		Location_Description = <cfif sw_loc is "NULL">#sw_loc#<cfelse>'#PreserveSingleQuotes(sw_loc)#'</cfif>,
		Damage_Description = <cfif sw_damage is "NULL">#sw_damage#<cfelse>'#PreserveSingleQuotes(sw_damage)#'</cfif>,
		<!--- Tree_Removed = #sw_tree_rmv#,
		Tree_Removal_Description = <cfif sw_tree_desc is "NULL">#sw_tree_desc#<cfelse>'#PreserveSingleQuotes(sw_tree_desc)#'</cfif>, --->
		ADA_Exception = #sw_excptn#,
		ADA_Exception_Notes = <cfif sw_excptn_notes is "NULL">#sw_excptn_notes#<cfelse>'#PreserveSingleQuotes(sw_excptn_notes)#'</cfif>,
		City_Owned_Property = #sw_cityowned#,
		Priority_No = #sw_priority#,
		Date_Logged = #sw_logdate#,
		Zip_Code = #sw_zip#,
		Curb_Ramp_Only = #sw_curbramp#,
		Design_Required = #sw_designreq#,
		Design_Start_Date = #sw_dsgnstart#,
		Design_Finish_Date = #sw_dsgnfinish#,
		Access_Improvement = #sw_ait_type#,
		Cost_Effective = #sw_costeffect#,
		Within_High_Injury = #sw_injury#,
		Traveled_By_Disabled = #sw_disabled#,
		Complaints_No = #sw_complaints#,
		High_Pedestrian_Traffic = #sw_pedestrian#,
		modified_date = #CreateODBCDateTime(Now())#,
		User_ID = #session.user_num#
		WHERE id = #sw_id#
		</cfquery>

		
		<cfquery name="getLocNo" datasource="#request.sqlconn#">		
		SELECT location_no FROM #tbl# WHERE id = #sw_id#
		</cfquery>
		
		<!--- <cfquery name="chkTrees" datasource="#request.sqlconn#">		
		SELECT id FROM #tbl2# WHERE location_no = #getLocNo.location_no#
		</cfquery>

		<cfif chkTrees.recordcount gt 0>
			<cfquery name="addFeature" datasource="#request.sqlconn#">		
			UPDATE #tbl2# SET
			no_trees_to_remove_per_arborist = #sw_no_trees#,
			tree_removal_notes = <cfif sw_tree_notes is "NULL">#sw_tree_notes#<cfelse>'#PreserveSingleQuotes(sw_tree_notes)#'</cfif>,
			trees_removed_date = #sw_tree_rm_date#
			<!--- modified_date = #CreateODBCDateTime(Now())#, --->
			<!--- User_ID = #session.user_num# --->
			WHERE location_no = #getLocNo.location_no#
			</cfquery>
		<cfelse>
			<cfquery name="addFeature" datasource="#request.sqlconn#">		
			INSERT INTO dbo.#tbl2#
			( 
				Location_No,
			    <cfif trim(sw_tree_rm_date) is not "NULL">trees_removed_date,</cfif>
				<cfif trim(sw_tree_notes) is not "NULL">tree_removal_notes,</cfif>
			    <cfif trim(sw_no_trees) is not "NULL">no_trees_to_remove_per_arborist,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#getLocNo.location_no#,
			    <cfif trim(sw_tree_rm_date) is not "NULL">#sw_tree_rm_date#,</cfif>
				<cfif trim(sw_tree_notes) is not "NULL">'#PreserveSingleQuotes(sw_tree_notes)#',</cfif>
			    <cfif trim(sw_no_trees) is not "NULL">#sw_no_trees#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
		
		</cfif> --->
		
		<cfset data.result = "Success">
		
		<cfif do_priority is 1>
			<cfset data.priority = updatePriority(getLocNo.location_no,tbl)>
		</cfif>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
		
		
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="updatePriority" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="loc_no" type="numeric" required="no" default="0">  
		<cfargument name="tbl" type="string" required="yes">  
		
		<cfset vw = "vwPriority">
		<cfset rv = 0>
		
		<cfquery name="getPriorities" datasource="#request.sqlconn#">		
		SELECT * FROM #vw# ORDER BY points DESC
		</cfquery>
		
		<cfset prty_no = 1><cfset pts = getPriorities.points><cfset cnt = 0>
		<cfloop query="getPriorities">
			<cfset cnt = cnt + 1>
			<cfif pts is not points>
				<cfset prty_no = cnt>
				<cfset pts = points>
			</cfif>
		
			<cfquery name="updatePriorities" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET priority_no = #prty_no# where location_no = #location_no#
			</cfquery>
			
			<cfif loc_no is location_no><cfset rv = prty_no></cfif>
			
		</cfloop>
		
		<cfquery name="getNonPriorities" datasource="#request.sqlconn#">		
		SELECT location_no FROM dbo.#tbl# 
		WHERE (location_no NOT IN (SELECT location_no FROM dbo.#vw#))
		</cfquery>
		
		<cfloop query="getNonPriorities">
			<cfquery name="updatePriorities" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET priority_no = NULL where location_no = #location_no#
			</cfquery>
		</cfloop>
		
		<cfreturn rv>  
	
	
	</cffunction>
	
	
	
	
	<cffunction name="searchPackages" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="ps_no" required="true">
		<cfargument name="ps_group" required="true">
		<cfargument name="ps_wo" required="true">
		<cfargument name="ps_con" required="true">
		<cfargument name="ps_name" required="true">
		<cfargument name="ps_fy" required="true">
		<cfargument name="ps_order" required="false" default="package_group DESC,package_no">
		
		<cfset var data = {}>
		
		<cfset ps_where = "">
		<cfif trim(ps_name) is not "">
			<cfquery name="getSites" datasource="#request.sqlconn#">
			SELECT DISTINCT package_no,package_group FROM tblSites WHERE name LIKE '%#ps_name#%' AND package_no is not null
			</cfquery>
			<cfif getSites.recordcount gt 0>
				<cfset ps_where = "AND (">
				<cfloop query="getSites">
					<cfset ps_where = ps_where & "(package_no = " & package_no & " AND package_group = '" & package_group & "') OR ">
				</cfloop>
				<cfset ps_where = trim(ps_where)>
				<cfset ps_where = left(ps_where,len(ps_where)-3) & ")">
				<cfset data.ps_where = ps_where>
			</cfif>
		</cfif>
		
		<cfquery name="getPackages" datasource="#request.sqlconn#">
		SELECT * FROM tblPackages WHERE removed is null
		<cfif ps_group is not "">AND package_group = '#ps_group#'</cfif> 
		<cfif ps_no is not "">AND package_no = #ps_no#</cfif> 
		<cfif trim(ps_wo) is not "">AND work_order LIKE '%#trim(ps_wo)#%'</cfif> 
		<cfif trim(ps_con) is not "">AND contractor LIKE '%#trim(ps_con)#%'</cfif> 
		<cfif trim(ps_fy) is not "">AND fiscal_year = '#trim(ps_fy)#'</cfif> 
		#preservesinglequotes(ps_where)#
		ORDER BY #ps_order#
		</cfquery>
	
		<cfset data.query = serializeJSON(getPackages)>
	
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="searchSites" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="ss_no" required="true">
		<!--- <cfargument name="ss_sfx" required="true"> --->
		<cfargument name="ss_pgroup" required="true">
		<cfargument name="ss_pno" required="true">
		<cfargument name="ss_type" required="true">
		<cfargument name="ss_name" required="true">
		<cfargument name="ss_address" required="true">
		<cfargument name="ss_wo" required="true">
		<cfargument name="ss_assessed" required="true">
		<!--- <cfargument name="ss_assessor" required="true"> --->
		<cfargument name="ss_assfrm" required="true">
		<cfargument name="ss_assto" required="true">
		<cfargument name="ss_qcfrm" required="true">
		<cfargument name="ss_qcto" required="true">
		<cfargument name="ss_consfrm" required="true">
		<cfargument name="ss_consto" required="true">
		<cfargument name="ss_concfrm" required="true">
		<cfargument name="ss_concto" required="true">
		<cfargument name="ss_repairs" required="true">
		<cfargument name="ss_severity" required="true">
		<!--- <cfargument name="ss_qc" required="true"> --->
		<cfargument name="ss_cd" required="true">
		<cfargument name="ss_removed" required="true">
		<cfargument name="ss_zip" required="true">
		<cfargument name="ss_curbramp" required="true">
		<cfargument name="ss_pn" required="true">
		<cfargument name="ss_keyword" required="true">
		<cfargument name="ss_hasA" required="true">
		<cfargument name="ss_hasB" required="true">
		<cfargument name="ss_assnull" required="false">
		<cfargument name="ss_qcnull" required="false">
		<cfargument name="ss_consnull" required="false">
		<cfargument name="ss_concnull" required="false">
		<cfargument name="ss_order" required="false" default="location_no,location_suffix">
		
		<cfif isdefined("ss_assnull")><cfset session.ss_assnull = 1><cfelse><cfset StructDelete(Session, "ss_assnull")></cfif>
		<cfif isdefined("ss_qcnull")><cfset session.ss_qcnull = 1><cfelse><cfset StructDelete(Session, "ss_qcnull")></cfif>
		<cfif isdefined("ss_consnull")><cfset session.ss_consnull = 1><cfelse><cfset StructDelete(Session, "ss_consnull")></cfif>
		<cfif isdefined("ss_concnull")><cfset session.ss_concnull = 1><cfelse><cfset StructDelete(Session, "ss_concnull")></cfif>
		
		
		
		<cfset var data = {}>
		
		<cfset ss_name = trim(ss_name)>
		<cfset ss_address = trim(ss_address)>
		<cfset ss_wo = trim(ss_wo)>
		<cfset ss_zip = trim(ss_zip)>
		<cfset ss_keyword = trim(ss_keyword)>
		<!--- <cfset ss_assessor = trim(ss_assessor)> --->
		<!--- <cfset ss_qc = trim(ss_qc)> --->
		
		<cfset ss_assessor = "">
		<cfset ss_qc = "">
		
		<cfif ss_assfrm is not "">
			<cfset arrDT = listtoarray(ss_assfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_assfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_assto is not "">
			<cfset arrDT = listtoarray(ss_assto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_assto = createODBCDate(dt)>
		</cfif>
		<cfif ss_qcfrm is not "">
			<cfset arrDT = listtoarray(ss_qcfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_qcfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_qcto is not "">
			<cfset arrDT = listtoarray(ss_qcto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_qcto = createODBCDate(dt)>
		</cfif>
		
		<cfset ss_constart = "">
		<cfset ss_concomplete = "">
		
		<cfif ss_consfrm is not "">
			<cfset arrDT = listtoarray(ss_consfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_consfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_consto is not "">
			<cfset arrDT = listtoarray(ss_consto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_consto = createODBCDate(dt)>
		</cfif>
		<cfif ss_concfrm is not "">
			<cfset arrDT = listtoarray(ss_concfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_concfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_concto is not "">
			<cfset arrDT = listtoarray(ss_concto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_concto = createODBCDate(dt)>
		</cfif>

		<cfif trim(ss_assfrm) is not "" AND trim(ss_assto) is ""><cfset ss_assessor = ss_assfrm></cfif>
		<cfif trim(ss_assto) is not "" AND trim(ss_assfrm) is ""><cfset ss_assessor = ss_assto></cfif>
		<cfset assbtwn = "">
		<cfif trim(ss_assfrm) is not "" AND trim(ss_assto) is not "">
			<cfset assbtwn = "AND (assessed_date >= " & ss_assfrm & " AND assessed_date <= " & ss_assto & ")"> 
		</cfif>
		
		<cfif trim(ss_qcfrm) is not "" AND trim(ss_qcto) is ""><cfset ss_qc = ss_qcfrm></cfif>
		<cfif trim(ss_qcto) is not "" AND trim(ss_qcfrm) is ""><cfset ss_qc = ss_qcto></cfif>
		<cfset qcbtwn = "">
		<cfif trim(ss_qcfrm) is not "" AND trim(ss_qcto) is not "">
			<cfset qcbtwn = "AND (qc_date >= " & ss_qcfrm & " AND qc_date <= " & ss_qcto & ")"> 
		</cfif>
		
		<cfif trim(ss_consfrm) is not "" AND trim(ss_consto) is ""><cfset ss_constart = ss_consfrm></cfif>
		<cfif trim(ss_consto) is not "" AND trim(ss_consfrm) is ""><cfset ss_constart = ss_consto></cfif>
		<cfset consbtwn = "">
		<cfif trim(ss_consfrm) is not "" AND trim(ss_consto) is not "">
			<cfset consbtwn = "AND (construction_start_date >= " & ss_consfrm & " AND construction_start_date <= " & ss_consto & ")"> 
		</cfif>
		
		<cfif trim(ss_concfrm) is not "" AND trim(ss_concto) is ""><cfset ss_concomplete = ss_concfrm></cfif>
		<cfif trim(ss_concto) is not "" AND trim(ss_concfrm) is ""><cfset ss_concomplete = ss_concto></cfif>
		<cfset concbtwn = "">
		<cfif trim(ss_concfrm) is not "" AND trim(ss_concto) is not "">
			<cfset concbtwn = "AND (construction_completed_date >= " & ss_concfrm & " AND construction_completed_date <= " & ss_concto & ")"> 
		</cfif>
		
		
		<cfquery name="getPackages" datasource="#request.sqlconn#">
		SELECT * FROM vwSites WHERE 1=1
		<cfif ss_no is not "">AND location_no = #ss_no#</cfif> 
		<!--- <cfif ss_sfx is not "">AND site_suffix = '#ss_sfx#'</cfif>  --->
		<cfif ss_pgroup is not "">
			<cfif ss_pgroup is "ALL">
				AND package_group is not NULL
			<cfelseif ss_pgroup is "NONE">
				AND package_group is NULL
			<cfelse>
				AND package_group = '#ss_pgroup#'
			</cfif>
		</cfif> 
		<cfif ss_pno is not "">AND package_no = '#ss_pno#'</cfif> 
		<cfif ss_type is not "">AND type = '#ss_type#'</cfif> 
		<cfif trim(ss_name) is not "">AND name LIKE '%#preservesinglequotes(ss_name)#%'</cfif> 
		<cfif trim(ss_address) is not "">AND address LIKE '%#preservesinglequotes(ss_address)#%'</cfif> 
		<cfif trim(ss_wo) is not "">AND work_order LIKE '%#preservesinglequotes(ss_wo)#%'</cfif> 
		<cfif ss_assessed is not "">
			<cfif ss_assessed is 1>
				AND field_assessed = #ss_assessed#
			<cfelse>
				AND (field_assessed = 0 OR field_assessed is null)
			</cfif>
		</cfif> 
		<cfif trim(ss_assessor) is not "">AND assessed_date = #preservesinglequotes(ss_assessor)#</cfif>
		<cfif trim(assbtwn) is not "">#preservesinglequotes(assbtwn)#</cfif>
		<cfif ss_repairs is not "">AND repairs_required = #ss_repairs#</cfif> 
		<cfif ss_severity is not "">AND severity_index = #ss_severity#</cfif> 
		<cfif trim(ss_qc) is not "">AND qc_date = #preservesinglequotes(ss_qc)#</cfif>
		<cfif trim(qcbtwn) is not "">#preservesinglequotes(qcbtwn)#</cfif>
		<cfif trim(ss_constart) is not "">AND construction_start_date = #preservesinglequotes(ss_constart)#</cfif>
		<cfif trim(consbtwn) is not "">#preservesinglequotes(consbtwn)#</cfif>
		<cfif trim(ss_concomplete) is not "">AND construction_completed_date = #preservesinglequotes(ss_concomplete)#</cfif>
		<cfif trim(concbtwn) is not "">#preservesinglequotes(concbtwn)#</cfif>
		<cfif ss_cd is not "">AND council_district = #ss_cd#</cfif> 
		<cfif ss_zip is not "">AND zip_code = #ss_zip#</cfif>
		<cfif ss_curbramp is not "">AND curb_ramp_only = #ss_curbramp#</cfif>
		<cfif ss_pn is not "">AND priority_no = #ss_pn#</cfif> 
		<cfif ss_keyword is not "">AND (
		notes LIKE '%#preservesinglequotes(ss_keyword)#%' OR 
		location_description LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		damage_description LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		tree_removal_notes LIKE '%#preservesinglequotes(ss_keyword)#%')	
		</cfif> 
		<cfif ss_hasA is not "">
			<cfif ss_hasA is 1>AND has_after = 1<cfelse>AND (has_after <> 1 OR has_after is NULL)</cfif>
		</cfif>
		<cfif ss_hasB is not "">
			<cfif ss_hasB is 1>AND has_before = 1<cfelse>AND (has_before <> 1 OR has_before is NULL)</cfif>
		</cfif> 
		<cfif ss_removed is not "">AND removed = #ss_removed#<cfelse>AND removed is NULL</cfif> 
		<cfif isdefined("ss_assnull")>AND assessed_date IS NULL</cfif>
		<cfif isdefined("ss_qcnull")>AND qc_date IS NULL</cfif>
		<cfif isdefined("ss_consnull")>AND construction_start_date IS NULL</cfif>
		<cfif isdefined("ss_concnull")>AND construction_completed_date IS NULL</cfif>
		ORDER BY #ss_order#
		</cfquery>
	
		<cfset data.query = serializeJSON(getPackages)>
		
		<cfset session.siteQuery = getPackages>
	
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updateEstimate" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblEngineeringEstimate SET ">
		<cfset iqstr = "INSERT INTO tblEngineeringEstimate (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfset cuqstr = "UPDATE tblContractorPricing SET CONTRACTORS_COST = " & replace(c_contractors_cost,",","","ALL") & ",">
		<cfset ciqstr = "INSERT INTO tblContractorPricing (">
		<cfset ctmp1 = "Location_No,CONTRACTORS_COST,">
		<cfset ctmp2 = "#sw_id#," & replace(c_contractors_cost,",","","ALL") & ",">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
				
			<cfif isdefined("c_#column_name#")>
				
				<cfif find("UNIT_PRICE",column_name,"1") gt 0>
					
					<cfset v = evaluate("c_#column_name#")>
					
					<cfset cuqstr = cuqstr & column_name & " = ">
					<cfif data_type is "nvarchar">
						<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
					<cfelse>
						<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
					</cfif>
					
					<cfset ctmp1 = ctmp1 & column_name & ",">
					<cfif data_type is "nvarchar">
						<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
					<cfelse>
						<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
					</cfif>
				
				</cfif>
				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		<!--- <cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr> --->
		
		<!--- <cfdump var="#sw_user#"><br><br>
		<cfdump var="#uqstr#"><br><br>
		<cfdump var="#iqstr#"><br><br>
		<cfdump var="#cuqstr#"><br><br>
		<cfdump var="#ciqstr#"><br><br> --->
		
		<cftry>
		
			<cfif sw_user is not "BSS"><!--- Added so that BSS doesn't update the Engineers Estimate --->
		
				<cfquery name="chkRecord" datasource="#request.sqlconn#">
				SELECT * FROM tblEngineeringEstimate WHERE location_no = #sw_id#
				</cfquery>
				<cfif chkRecord.recordcount gt 0>
					<cfset qstr = uqstr>
				<cfelse>
					<cfset qstr = iqstr>
				</cfif>
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				
				<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
				<cfelse><cfset fld = "creation_date"></cfif>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEngineeringEstimate SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfif>
			
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblContractorPricing WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset cqstr = cuqstr>
			<cfelse>
				<cfset cqstr = ciqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(cqstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblContractorPricing SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr>
			<cfset data.qstr = cqstr> --->
			
			
			<!--- Update Package Estimates and Cost --->
			<!--- <cfquery name="getPackage" datasource="#request.sqlconn#">
			SELECT package_no as pno,package_group as pgp FROM tblSites WHERE location_no = #sw_id#
			</cfquery>
			
			<cfif getPackage.pno is not "">
				<cfquery name="getIDs" datasource="#request.sqlconn#">
				SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
				package_group = '#getPackage.pgp#'
				</cfquery>
				<cfif getIDs.recordcount gt 0>
					<cfset str = "">
					<cfloop query="getIDs">
						<cfset str = str & location_no & ",">
					</cfloop>
					<cfset str = left(str,len(str)-1)>
					<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
					<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
					
					<cfquery name="getEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(qstr)#
					</cfquery>
					
					<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = #v#
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
					
					<cfquery name="getCEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(cqstr)#
					</cfquery>
					
					<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = #v#
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
				<cfelse>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = NULL
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
					
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = NULL
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
				</cfif>
			</cfif> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="updateADA" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblADACurbRamps' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblADACurbRamps SET ">
		<cfset iqstr = "INSERT INTO tblADACurbRamps (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & v & ",">
				</cfif>				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblADACurbRamps WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblADACurbRamps SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="deleteSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Deletion Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Deletion Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.sid = sid>
	
		<!--- <cftry> --->
		
			<cfquery name="getRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblSites WHERE id = #sid#
			</cfquery>
			
			<cfif getRecord.recordcount gt 0>
				<cfset pno = getRecord.package_no>
				<cfset pgp = getRecord.package_group>
				<cfset loc = getRecord.location_no>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblSites SET
				removed = 1,
				package_no = NULL,
				package_group = NULL,
				user_id = #session.user_num#,
				modified_date = #CreateODBCDateTime(Now())#
				WHERE id = #sid#
				</cfquery>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblGeocoding SET
				deleted = 1,
				userid = #session.user_num#,
				lastmodifieddate = #CreateODBCDateTime(Now())#
				WHERE location_no = #loc#
				</cfquery>
				
				<!--- <cfif pno is not "">
					<cfquery name="getIDs" datasource="#request.sqlconn#">
					SELECT location_no FROM tblSites WHERE package_no = #pno# AND
					package_group = '#pgp#'
					</cfquery>
					<cfif getIDs.recordcount gt 0>
						<cfset str = "">
						<cfloop query="getIDs">
							<cfset str = str & location_no & ",">
						</cfloop>
						<cfset str = left(str,len(str)-1)>
						<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
						<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
						
						<cfquery name="getEstimate" datasource="#request.sqlconn#">
						#preservesinglequotes(qstr)#
						</cfquery>
						
						<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
						<cfquery name="setEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						engineers_estimate = #v#
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
						
						<cfquery name="getCEstimate" datasource="#request.sqlconn#">
						#preservesinglequotes(cqstr)#
						</cfquery>
						
						<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
						<cfquery name="setCEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						awarded_bid = #v#
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
					<cfelse>
					
						<cfquery name="setEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						engineers_estimate = NULL
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
			
						<cfquery name="setCEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						awarded_bid = NULL
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
					</cfif>
				</cfif> --->
			
			</cfif>
		
			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	<cffunction name="restoreSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Restoration Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Restoration Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.sid = sid>
	
		<cftry>
		
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblSites SET
			removed = NULL,
			user_id = #session.user_num#,
			modified_date = #CreateODBCDateTime(Now())#
			WHERE id = #sid#
			</cfquery>
				
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	<cffunction name="downloadData" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to download.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cftry>
		
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRAssessmentTracking' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfset filename = expandPath("../downloads/SidewalkRepairProgram.xls")>
			<cfspreadsheet action="write" query="getFlds" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("AssessmentTracking","no")>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRAssessmentTracking
			</cfquery>
			
			<!--- <cfset spreadsheetCreateSheet(s,"AssessmentTracking")>
			<cfset spreadsheetRemoveSheet(s,"Sheet1")> 
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRWorkOrders' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRWorkOrders
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"WorkOrders")>
			<cfset spreadsheetsetActiveSheet(s,"WorkOrders")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwEngineeringEstimateDL1' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwEngineeringEstimateDL1
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"EngineeringEstimate1")>
			<cfset spreadsheetsetActiveSheet(s,"EngineeringEstimate1")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwEngineeringEstimateDL2' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwEngineeringEstimateDL2
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"EngineeringEstimate2")>
			<cfset spreadsheetsetActiveSheet(s,"EngineeringEstimate2")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwContractorPricingDL1' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwContractorPricingDL1
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ContractorPricing1")>
			<cfset spreadsheetsetActiveSheet(s,"ContractorPricing1")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwContractorPricingDL2' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwContractorPricingDL2
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ContractorPricing2")>
			<cfset spreadsheetsetActiveSheet(s,"ContractorPricing2")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRADACurbRamps' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRADACurbRamps
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ADACurbRamps")>
			<cfset spreadsheetsetActiveSheet(s,"ADACurbRamps")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRCurbRamps' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRCurbRamps
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"CurbRamps")>
			<cfset spreadsheetsetActiveSheet(s,"CurbRamps")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRTreeSiteInfo' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRTreeSiteInfo
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"TreeSiteInfo")>
			<cfset spreadsheetsetActiveSheet(s,"TreeSiteInfo")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRTreeList' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRTreeList
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"TreeList")>
			<cfset spreadsheetsetActiveSheet(s,"TreeList")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRQCQuantity' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRQCQuantity
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"QCQuantity")>
			<cfset spreadsheetsetActiveSheet(s,"QCQuantity")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRChangeOrders' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRChangeOrders
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ChangeOrders")>
			<cfset spreadsheetsetActiveSheet(s,"ChangeOrders")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")>
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	<cffunction name="getDefaults" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
		
		<cfquery name="Defaults" datasource="#request.sqlconn#">
		SELECT * FROM dbo.tblEstimateDefaults
		</cfquery>
		
		<cfset data.query = serializeJSON(Defaults)>
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	<cffunction name="reCalculateTotal" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_type" required="true">
	
		<cfset var data = {}>
		
		<cfquery name="getPackage" datasource="#request.sqlconn#">
		SELECT package_no as pno,package_group as pgp FROM tblPackages WHERE id = #sw_id#
		</cfquery>
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
		package_group = '#getPackage.pgp#'
		</cfquery>
		
		<cfset v = 0>
		<cfif sw_type is "ee">

			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
				
				<cfquery name="getEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				<cfset v = getEstimate.cost><cfif v is ""><cfset v = 0></cfif>
			</cfif>
		
		<cfelse>
			
			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
				
				<cfquery name="getCEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				<cfset v = getCEstimate.cost><cfif v is ""><cfset v = 0></cfif>
				
			</cfif>
			
		</cfif>
		
		<cfset data.value = numberformat(v,"999,999,999")>
		<cfif v is 0><cfset data.value = ""></cfif>
		<cfset data.result = "Success">
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	<cffunction name="updateAssessment" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<!--- <cfset uqstr = "UPDATE tblEngineeringEstimate SET COMMENTS = '" & replace(comments,"'","''","ALL") & "',"> --->
		<cfset uqstr = "UPDATE tblEngineeringEstimate SET ">
		<cfset iqstr = "INSERT INTO tblEngineeringEstimate (">
		<!--- <cfset tmp1 = "Location_No,COMMENTS,">
		<cfset tmp2 = "#sw_id#,'" & replace(comments,"'","''","ALL") & "',"> --->
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfset cuqstr = "UPDATE tblQCQuantity SET ">
		<cfset ciqstr = "INSERT INTO tblQCQuantity (">
		<cfset ctmp1 = "Location_No,">
		<cfset ctmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("ass_#column_name#")>
				<cfset v = evaluate("ass_#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
			
			<cfif isdefined("ass_q_#column_name#")>

				<cfset v = evaluate("ass_q_#column_name#")>
				
				<cfset cuqstr = cuqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset ctmp1 = ctmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		
		<cfset doQC = false><cfif isdefined("ass_q_MOBILIZATION_quantity")><cfset doQC = true></cfif>
		
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr>
		<cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr>
		<cfset data.doQC = doQC> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblEngineeringEstimate WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<!--- <cfif doQC is false> --->
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEngineeringEstimate SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			<!--- </cfif> --->
			
			<cfif doQC is true>
			
				<cfquery name="chkRecord" datasource="#request.sqlconn#">
				SELECT * FROM tblQCQuantity WHERE location_no = #sw_id#
				</cfquery>
				<cfif chkRecord.recordcount gt 0>
					<cfset cqstr = cuqstr>
				<cfelse>
					<cfset cqstr = ciqstr>
				</cfif>
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				
				<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
				<cfelse><cfset fld = "creation_date"></cfif>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblQCQuantity SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfif>
		
			<cfset data.result = "Success">
			
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateChangeOrder" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblChangeOrders' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset cuqstr = "UPDATE tblChangeOrders SET ">
		<cfset ciqstr = "INSERT INTO tblChangeOrders (">
		<cfset ctmp1 = "Location_No,">
		<cfset ctmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
			
			<cfif isdefined("cor_#column_name#")>

				<cfset v = evaluate("cor_#column_name#")>
				
				<cfset cuqstr = cuqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset ctmp1 = ctmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>

		<!--- <cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr> --->
		
		<cftry>
	
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblChangeOrders WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset cqstr = cuqstr>
			<cfelse>
				<cfset cqstr = ciqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(cqstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblChangeOrders SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>

			<cfset data.result = "Success">
			
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateTrees" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblTreeRemovalInfo SET ">
		<cfset iqstr = "INSERT INTO tblTreeRemovalInfo (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
				<cfif v is ""><cfset v = "NULL"></cfif>
				<cfif data_type is "datetime">
					<cfif v is not "NULL">
						<cfset arrDT = listtoarray(v,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset v = createODBCDate(dt)>
					</cfif>
				</cfif>
				
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & v & ",">
				</cfif>				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblTreeRemovalInfo WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblTreeRemovalInfo SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	
	<cffunction name="updateDefault" access="remote" returnType="any" returnFormat="plain" output="false">
		<!--- <cfargument name="sw_id" required="true"> --->
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to update the Estimate Default Table.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME, sort_order, sort_group
		FROM vwSortOrder WHERE column_name not like 'EXTRA%'
		ORDER BY full_sort, sort_group, sort_order 
		</cfquery>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<!--- <cftry> --->
		
			<cfloop index="i" from="1" to="#getFlds.recordcount#">
		
				<cfset field = evaluate("fieldname_#i#")>
				<cfset units = replace(evaluate("units_#i#"),"'","''","ALL")>
				<cfset price = evaluate("price_#i#")>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEstimateDefaults SET 
				units = '#units#',
				price = #price#
				WHERE fieldname = '#field#'
				</cfquery>
				
			</cfloop>

			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateContractorAll" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset tbl = "tblContractorPricing">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT package_no, package_group FROM tblSites WHERE id = #sw_id#
		</cfquery>
		
		<cfset pno = getPAckage.package_no>
		<cfset pgrp = getPAckage.package_group>
		
		<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT location_no FROM tblSites WHERE package_no = #pno# AND package_group = '#pgrp#'
		</cfquery>
		
		<cfset locs = ValueList(getSites.location_no,",")>
		<cfset arrLocs = listToArray(locs,",")>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = '#tbl#' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE #tbl# SET ">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("c_#column_name#")>
				<cfset v = evaluate("c_#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
				<cfif v is ""><cfset v = "NULL"></cfif>
				<cfif data_type is "datetime">
					<cfif v is not "NULL">
						<cfset arrDT = listtoarray(v,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset v = createODBCDate(dt)>
					</cfif>
				</cfif>
				
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		<cfset uqstr = left(uqstr,len(uqstr)-1)>
		<!--- <cfset data.uqstr = uqstr> --->
		
		<cftry>
		
			<cfloop index="i" from="1" to="#arrayLen(arrLocs)#">
		
				<cfquery name="chkExist" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT count(*) as cnt FROM #tbl# WHERE location_no = #arrLocs[i]#
				</cfquery>
				
				<cfset fld = "modified_date">			
				<cfif chkExist.cnt is 0>
					<cfset fld = "creation_date">
					<cfquery name="chkExist" datasource="#request.sqlconn#" dbtype="ODBC">
				 	INSERT INTO #tbl# (location_no,#fld#,user_id) VALUES (#arrLocs[i]#,#CreateODBCDateTime(Now())#,#session.user_num#)
					</cfquery>
				<cfelse>
					<cfquery name="updateRecord" datasource="#request.sqlconn#">
					UPDATE #tbl# SET
					user_id = #session.user_num#,
					#fld# = #CreateODBCDateTime(Now())#
					WHERE location_no = #arrLocs[i]#
					</cfquery>
				</cfif>
				
				<cfquery name="UpdatePricing" datasource="#request.sqlconn#" dbtype="ODBC">
				#uqstr# WHERE location_no = #arrLocs[i]#
				</cfquery>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblTreeRemovalInfo SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfloop>

			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="downloadSiteSearch" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- <cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to download.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif> --->
		
		<cftry>
		
			<cfset sfx = timeformat(now(),"HHmmss")>

			<cfset columns = "Site,Council District,Package,Facility Name,Address,Construction Start Date,Construction Completed Date,Priority No,Engineer's Estimate,Total Cost,Total Concrete,Type,Work Order">
			
			<cfquery name="setSearch" dbtype="query">
			SELECT location_no as site,council_district as cd, package,name as facility_name,address,construction_start_date,
			construction_completed_date,priority_no,engineers_estimate,total_cost,total_concrete,type_desc,work_order FROM session.siteQuery
			</cfquery>
			
			<cfset filename = expandPath("../downloads/SidewalkRepairSiteSearch_#sfx#.xls")>
			<cfspreadsheet action="write" query="setSearch" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("SiteSearchResults","no")>
			
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, setSearch)>
			
			<!--- <cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
			
			<cfset data.href = request.url & "downloads/SidewalkRepairSiteSearch_" & sfx & ".zip">
			
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset dir = request.dir & "\downloads">
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.xls">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.zip">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
		<cfcatch>
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	
	<cffunction name="downloadCurbSearch" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cftry>
		
			<cfset sfx = timeformat(now(),"HHmmss")>

			<cfset columns = "Curb Ramp No,Council District,Site No,Intersection Corner,Primary Street,Secondary Street,Design Finish Date,Construction Completed Date,Designed By,Priority No,Type">
			
			<cfquery name="setSearch" dbtype="query">
			SELECT ramp_no,council_district as cd, location_no as site,intersection_corner,primary_street,secondary_street,design_finish_date,construction_completed_date,
			designed_by,priority_no,type_description FROM session.curbQuery
			</cfquery>
			
			<cfset filename = expandPath("../downloads/CurbRampRepairSearch_#sfx#.xls")>
			<cfspreadsheet action="write" query="setSearch" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("CurbRampSearchResults","no")>
			
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, setSearch)>
			
			<!--- <cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
			
			<cfset data.href = request.url & "downloads/CurbRampRepairSearch_" & sfx & ".zip">
			
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset dir = request.dir & "\downloads">
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.xls">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.zip">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
		<cfcatch>
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	
	<cffunction name="doDeleteAttachment" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
	
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Delete Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
	
		<cfset f = request.PDFlocation & dir & "\" & file_name>
		<cftry>
			<cffile action="DELETE" file="#f#">
			<cfset data.response = "Success">
		<cfcatch>
			<cfset data.response = "Failed">
		</cfcatch>
		</cftry>
		<!--- <cfset data.f = f> --->

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	
	
	<cffunction name="chkLogin" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="user" required="true">
		<cfargument name="password" required="true">
	
		<cfset var data = {}>
	
		<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT * FROM dbo.tblUsers WHERE user_name = '#user#' AND user_password = '#password#' AND user_level >= 0
		</cfquery>	
		
		<cfif login_chk.recordcount gt 0>
			<cfset session.userid = login_chk.user_name>
			<cfset session.password = login_chk.user_password>
			<cfset session.agency = login_chk.user_agency>
			<cfset session.user_level = login_chk.user_level>
			<cfset session.user_power = login_chk.user_power>
			<cfset session.user_num = login_chk.user_id>
			<cfset data.response = "Success">
		<cfelse>
			<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM dbo.tblUsers WHERE user_name = '#user#' AND user_level >= 0
			</cfquery>
			<cfif login_chk.recordcount is 0>
				<cfset chk_log = "log">
			<cfelse>
				<cfset chk_log = "pass">
			</cfif>
			<cfset data.response = "Failed">
			<cfset data.chk = chk_log>
		</cfif>

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	<cffunction name="doLogoff" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
	
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
			<cfinclude template="../deleteClientVariables.cfm">
		</cflock>
		
		<cfset data.response = "Success">

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	
	
	
	<cffunction name="updateTrees2" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		
		
		
		<!--- <cftry> --->
		
		
		<!--- UPDATE the first table --->
		<cfset tbl = "tblTreeSiteInfo">
		<cfquery name="chkTree" datasource="#request.sqlconn#">
		SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id#
		</cfquery>
		<cfset tree_trc = replace(tree_trc,"'","''","ALL")>
		<cfset tree_tpc = replace(tree_tpc,"'","''","ALL")>
		<!--- <cfset tree_twc = replace(tree_twc,"'","''","ALL")> --->
		<cfset tree_trn = replace(tree_trn,"'","''","ALL")>
		<cfset tree_arbname = replace(tree_arbname,"'","''","ALL")>
		
		<cfif tree_lock is not ""><cfset tree_lock = 1></cfif>
		
		<cfif chkTree.recordcount is 0>
			
			<cfquery name="addTreeInfo" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Location_No,
			    <cfif trim(tree_trc) is not "">Tree_Removal_Contractor,</cfif>
			    <cfif trim(tree_tpc) is not "">Tree_Planting_Contractor,</cfif>
			    <!--- <cfif trim(tree_twc) is not "">Tree_Watering_Contractor,</cfif> --->
			    <cfif trim(tree_trn) is not "">Tree_Removal_Notes,</cfif>
				<cfif trim(tree_arbname) is not "">Arborist_Name,</cfif>
				<cfif trim(tree_lock) is not "">Root_Barrier_Lock,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#sw_id#,
			    <cfif trim(tree_trc) is not "">'#PreserveSingleQuotes(tree_trc)#',</cfif>
			    <cfif trim(tree_tpc) is not "">'#PreserveSingleQuotes(tree_tpc)#',</cfif>
			    <!--- <cfif trim(tree_twc) is not "">'#PreserveSingleQuotes(tree_twc)#',</cfif> --->
			    <cfif trim(tree_trn) is not "">'#PreserveSingleQuotes(tree_trn)#',</cfif>
				<cfif trim(tree_arbname) is not "">'#PreserveSingleQuotes(tree_arbname)#',</cfif>
				<cfif trim(tree_lock) is not "">#tree_lock#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
		
		<cfelse>
		
			<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET
			Tree_Removal_Contractor = <cfif tree_trc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trc)#'</cfif>,
			Tree_Planting_Contractor = <cfif tree_tpc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_tpc)#'</cfif>,
			<!--- Tree_Watering_Contractor = <cfif tree_twc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_twc)#'</cfif>, --->
			Tree_Removal_Notes = <cfif tree_trn is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trn)#'</cfif>,
			Arborist_Name = <cfif tree_arbname is "">NULL<cfelse>'#PreserveSingleQuotes(tree_arbname)#'</cfif>,
			Root_Barrier_Lock = <cfif tree_lock is "">NULL<cfelse>#tree_lock#</cfif>,
			User_ID = #session.user_num#,
			Modified_Date = #CreateODBCDateTime(Now())#
			WHERE Location_No = #sw_id#
			</cfquery>
			
		</cfif>
		
		<!--- UPDATE the second table --->
		
		<cfset tbl = "tblTreeList">
		<cfset tbl2 = "tblTreeSIRs">
		
		<cfset cnt = trees_sir_cnt>
		<cfset lt_total = 0>
		<cfset gt_total = 0>
		
		<cfloop index="i" from="1" to="#cnt#">
		
			<cfset sir = evaluate("sir_" & i)>
			<cfset sirdt = evaluate("sirdt_" & i)>
			<cfset grp = i>
			
			<cfset add_cnt = evaluate("tr_add_cnt_" & i)>
			<cfset rmv_cnt = evaluate("tr_rmv_cnt_" & i)>
			
			<cfif trim(sir) is ""><cfset sir = "NULL"></cfif>
			<cfif trim(sirdt) is ""><cfset sirdt = "NULL"></cfif>
			<cfset sir = replace(sir,"'","''","ALL")>
			
			<cfif sirdt is not "NULL">
				<cfset arrDT = listtoarray(sirdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sirdt = createODBCDate(dt)>
			</cfif>
			
			<cfif rmv_cnt gt 0>
				
				<cfloop index="j" from="1" to="#rmv_cnt#">
				
					<cfset tmp = evaluate("trdia_" & i & "_" & j)>
					<cfif tmp gt 24><cfset gt_total = gt_total + 1><cfelse><cfset lt_total = lt_total + 1></cfif>
					
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 0 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset trdia = evaluate("trdia_" & i & "_" & j)>
					<cfset trpidt = evaluate("trpidt_" & i & "_" & j)>
					<cfset trtrdt = evaluate("trtrdt_" & i & "_" & j)>
					<cfset traddr = evaluate("traddr_" & i & "_" & j)>
					<cfset trspecies = evaluate("trspecies_" & i & "_" & j)>
					<cfset trtype = evaluate("trtype_" & i & "_" & j)>
					
					<cfif trim(trpidt) is ""><cfset trpidt = "NULL"></cfif>
					<cfif trim(trtrdt) is ""><cfset trtrdt = "NULL"></cfif>
					<cfif trim(traddr) is ""><cfset traddr = "NULL"></cfif>
					<cfif trim(trspecies) is ""><cfset trspecies = "NULL"></cfif>
					<cfif trim(trtype) is ""><cfset trtype = "NULL"></cfif>
					
					<cfset traddr = replace(traddr,"'","''","ALL")>
					<cfset trspecies = ucase(replace(trspecies,"'","''","ALL"))>
					
					<cfif trpidt is not "NULL">
						<cfset arrDT = listtoarray(trpidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpidt = createODBCDate(dt)>
					</cfif>
					<cfif trtrdt is not "NULL">
						<cfset arrDT = listtoarray(trtrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trtrdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
						    <cfif trim(trdia) is not "NULL">Tree_Size,</cfif>
						    <cfif trim(trpidt) is not "NULL">Permit_Issuance_Date,</cfif>
							<cfif trim(trtrdt) is not "NULL">Tree_Removal_Date,</cfif>
						    <cfif trim(traddr) is not "NULL">Address,</cfif>
						    <cfif trim(trspecies) is not "NULL">Species,</cfif>
							<cfif trim(trtype) is not "NULL">Type,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
						    <cfif trim(trdia) is not "NULL">#trdia#,</cfif>
						    <cfif trim(trpidt) is not "NULL">#trpidt#,</cfif>
							<cfif trim(trtrdt) is not "NULL">#trtrdt#,</cfif>
						    <cfif trim(traddr) is not "NULL">'#PreserveSingleQuotes(traddr)#',</cfif>
						    <cfif trim(trspecies) is not "NULL">'#PreserveSingleQuotes(trspecies)#',</cfif>
							<cfif trim(trtype) is not "NULL">#trtype#,</cfif>
							0,
							0,
							#session.user_num#,
							#CreateODBCDateTime(Now())#
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Size = <cfif trdia is "NULL">NULL<cfelse>#trdia#</cfif>,
						Permit_Issuance_Date = <cfif trpidt is "NULL">NULL<cfelse>#trpidt#</cfif>,
						Tree_Removal_Date = <cfif trtrdt is "NULL">NULL<cfelse>#trtrdt#</cfif>,
						Address = <cfif traddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(traddr)#'</cfif>,
						Species = <cfif trspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trspecies)#'</cfif>,
						Type = <cfif trtype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trtype)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 0 AND Deleted <> 1
						</cfquery>
					
					</cfif>

				</cfloop>
				
			</cfif>
			
			
			<cfif add_cnt gt 0>
				
				<cfloop index="j" from="1" to="#add_cnt#">
				
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 1 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset tpdia = evaluate("tpdia_" & i & "_" & j)>
					<cfset tppidt = evaluate("tppidt_" & i & "_" & j)>
					<cfset tptrdt = evaluate("tptrdt_" & i & "_" & j)>
					<cfset tpswdt = evaluate("tpswdt_" & i & "_" & j)>
					<cfset tpewdt = evaluate("tpewdt_" & i & "_" & j)>
					<cfset tpaddr = evaluate("tpaddr_" & i & "_" & j)>
					<cfset tpspecies = evaluate("tpspecies_" & i & "_" & j)>
					<cfset tptype = evaluate("tptype_" & i & "_" & j)>
					
					<cfif trim(tppidt) is ""><cfset tppidt = "NULL"></cfif>
					<cfif trim(tptrdt) is ""><cfset tptrdt = "NULL"></cfif>
					<cfif trim(tpswdt) is ""><cfset tpswdt = "NULL"></cfif>
					<cfif trim(tpewdt) is ""><cfset tpewdt = "NULL"></cfif>
					<cfif trim(tpaddr) is ""><cfset tpaddr = "NULL"></cfif>
					<cfif trim(tpspecies) is ""><cfset tpspecies = "NULL"></cfif>
					<cfif trim(tptype) is ""><cfset tptype = "NULL"></cfif>
					
					<cfset tpaddr = replace(tpaddr,"'","''","ALL")>
					<cfset tpspecies = ucase(replace(tpspecies,"'","''","ALL"))>
					
					<cfif tppidt is not "NULL">
						<cfset arrDT = listtoarray(tppidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tppidt = createODBCDate(dt)>
					</cfif>
					<cfif tptrdt is not "NULL">
						<cfset arrDT = listtoarray(tptrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tptrdt = createODBCDate(dt)>
					</cfif>
					<cfif tpswdt is not "NULL">
						<cfset arrDT = listtoarray(tpswdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tpswdt = createODBCDate(dt)>
					</cfif>
					<cfif tpewdt is not "NULL">
						<cfset arrDT = listtoarray(tpewdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tpewdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
						    <cfif trim(tpdia) is not "NULL">Tree_Box_Size,</cfif>
						    <cfif trim(tppidt) is not "NULL">Permit_Issuance_Date,</cfif>
							<cfif trim(tptrdt) is not "NULL">Tree_Planting_Date,</cfif>
							<cfif trim(tpswdt) is not "NULL">Start_Watering_Date,</cfif>
							<cfif trim(tpewdt) is not "NULL">End_Watering_Date,</cfif>
						    <cfif trim(tpaddr) is not "NULL">Address,</cfif>
						    <cfif trim(tpspecies) is not "NULL">Species,</cfif>
							<cfif trim(tptype) is not "NULL">Type,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
						    <cfif trim(tpdia) is not "NULL">#tpdia#,</cfif>
						    <cfif trim(tppidt) is not "NULL">#tppidt#,</cfif>
							<cfif trim(tptrdt) is not "NULL">#tptrdt#,</cfif>
							<cfif trim(tpswdt) is not "NULL">#tpswdt#,</cfif>
							<cfif trim(tpewdt) is not "NULL">#tpewdt#,</cfif>
						    <cfif trim(tpaddr) is not "NULL">'#PreserveSingleQuotes(tpaddr)#',</cfif>
						    <cfif trim(tpspecies) is not "NULL">'#PreserveSingleQuotes(tpspecies)#',</cfif>
							<cfif trim(tptype) is not "NULL">#tptype#,</cfif>
							1,
							0,
							#session.user_num#,
							#CreateODBCDateTime(Now())#
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Box_Size = <cfif tpdia is "NULL">NULL<cfelse>#tpdia#</cfif>,
						Permit_Issuance_Date = <cfif tppidt is "NULL">NULL<cfelse>#tppidt#</cfif>,
						Tree_Planting_Date = <cfif tptrdt is "NULL">NULL<cfelse>#tptrdt#</cfif>,
						Start_Watering_Date = <cfif tpswdt is "NULL">NULL<cfelse>#tpswdt#</cfif>,
						End_Watering_Date = <cfif tpewdt is "NULL">NULL<cfelse>#tpewdt#</cfif>,
						Address = <cfif tpaddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpaddr)#'</cfif>,
						Species = <cfif tpspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpspecies)#'</cfif>,
						Type = <cfif tptype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tptype)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 1 AND Deleted <> 1
						</cfquery>
					
					</cfif>

				</cfloop>
				
			</cfif>
			
			<!--- Delete From treeList table --->
			<cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #add_cnt# AND action_type = 1 AND Deleted <> 1
			</cfquery>
			<cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #rmv_cnt# AND action_type = 0 AND Deleted <> 1
			</cfquery>
			
			
			<!--- Add to SIR Table --->
			<cfquery name="chkSIR" datasource="#request.sqlconn#">
			SELECT * FROM dbo.#tbl2# WHERE location_no = #sw_id# AND group_no = #i# AND deleted <> 1
			</cfquery>
			
			<cfif chkSIR.recordcount is 0>
			
				<cfquery name="addSIR" datasource="#request.sqlconn#">
				INSERT INTO dbo.#tbl2#
				( 
					Location_No,
					Group_No,
				    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
				    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
					Deleted,
					User_ID,
					Creation_Date
				) 
				Values 
				(
					#sw_id#,
					#grp#,
				    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
				    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
					0,
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			
			<cfelse>
			
				<cfquery name="updateSIR" datasource="#request.sqlconn#">
				UPDATE dbo.#tbl2# SET
				SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
				SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
				User_ID = #session.user_num#,
				Modified_Date = #CreateODBCDateTime(Now())#
				WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Deleted <> 1
				</cfquery>
				
			</cfif>
			
			
			
		</cfloop>
		
		<!--- Delete From SIR and treeList tables --->
		<cfquery name="delTree" datasource="#request.sqlconn#">
		UPDATE dbo.#tbl2# SET deleted = 1
		WHERE location_no = #sw_id# AND group_no > #cnt# AND Deleted <> 1
		</cfquery>
		<cfquery name="delTree" datasource="#request.sqlconn#">
		UPDATE dbo.#tbl# SET deleted = 1
		WHERE location_no = #sw_id# AND group_no = #i# AND Deleted <> 1
		</cfquery>
		
	
		<!--- <cfdump var="#lt_total#"><br>
		<cfdump var="#gt_total#"><br> --->
		
		<!--- UPDATE the third table --->
		<cfset tbl = "tblEngineeringEstimate">
		<cfquery name="chkTree" datasource="#request.sqlconn#">
		SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id#
		</cfquery>
		
		<cfset arrTrees = arrayNew(1)>
		<cfset arrTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___">
		<cfset arrTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE___">
		<cfset arrTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER_">
		<cfset arrTrees[4] = "EXISTING_STUMP_REMOVAL_">
		<cfset arrTrees[5] = "FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_">
		<cfset arrTrees[6] = "WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH_">
		
		<cfif chkTree.recordcount is 0>
		
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME, sort_order, sort_group
			FROM vwSortOrder
			ORDER BY full_sort, sort_group, sort_order
			</cfquery>
			
			<cfset qstr = "INSERT INTO dbo.#tbl# (Location_No,">
			<cfset wstr = " VALUES (#sw_id#,">
			<cfloop query="getFlds">
			
				<cfset fld = replace(column_name,"_UNITS","","ALL")>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				
				<cfset qstr = qstr & "#fld#_UNITS,#fld#_QUANTITY,#fld#_UNIT_PRICE,">
				
				<cfset u=evaluate("getDefault.UNITS")>
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>	
				
				<cfset wstr = wstr & "'#u#',0,#p#,">
			
			</cfloop>
		
			<!--- <cfdump var="#qstr#">
			<cfdump var="#wstr#"> --->
			
			<cfset qstr = qstr & "Creation_Date)">
			<cfset wstr = wstr & "#CreateODBCDateTime(Now())#)">
			<cfset qstr = qstr & wstr>
		
			<cfquery name="addTreeInfo" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
		
		</cfif>
		
		<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
		UPDATE dbo.#tbl# SET
		TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = #lt_total#,
		<cfset data.TREE_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = lt_total>
		TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY = #gt_total#,
		<cfset data.TREE_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY = gt_total>
		<cfloop index="i" from="1" to="#arrayLen(arrTrees)#">
			<cfset v = evaluate("tree_#arrTrees[i]#UNITS")>
			#arrTrees[i]#UNITS = '#v#',
			<cfset v = trim(evaluate("tree_#arrTrees[i]#QUANTITY"))>
			<cfset data[arrTrees[i] & "QUANTITY"] = v>
			#arrTrees[i]#QUANTITY = <cfif v is "">0<cfelse>#v#</cfif>,
		</cfloop>
		User_ID = #session.user_num#,
		Modified_Date = #CreateODBCDateTime(Now())#
		WHERE Location_No = #sw_id#
		</cfquery>
		
		<cfset data.result = "Success">
		
		<!--- <cfcatch>
			<cfset data.result = "- Site Update Failed: Database Error.">
		</cfcatch>	
		</cftry> --->
		
		<!--- <cfdump var="#arguments#"> --->
		<!--- <cfdump var="#data#">
		<cfabort> --->

		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="addCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="cr_no" required="true">
		<cfargument name="cr_primary" required="true">
		<cfargument name="cr_type" required="true">
		<cfargument name="cr_secondary" required="true">
		<cfargument name="cr_cd" required="true">
		<cfargument name="cr_zip" required="true">
		<cfargument name="cr_corner" required="true">
		<cfargument name="cr_priority" required="true">
		<cfargument name="cr_logdate" required="true">
		<cfargument name="cr_assessed" required="true">
		<cfargument name="cr_existing" required="true">
		<cfargument name="cr_compliant" required="true">
		<cfargument name="cr_applicable" required="true">
		<cfargument name="cr_repairs" required="true">
		<cfargument name="cr_design" required="true">
		<cfargument name="cr_design_sdt" required="true">
		<cfargument name="cr_design_fdt" required="true">
		<cfargument name="cr_designby" required="true">
		<cfargument name="cr_assessed_dt" required="true">
		<cfargument name="cr_assessedby" required="true">
		<cfargument name="cr_dotcoord" required="true">
		<cfargument name="cr_con_cdt" required="true">
		<cfargument name="cr_utility" required="true">
		<cfargument name="cr_minor" required="true">
		<cfargument name="cr_notes" required="true">
		<cfargument name="cr_sno" required="true">
		<cfargument name="cr_excptn_notes" required="true">
		
		<cfif isdefined("cr_bsl") is false><cfset cr_bsl = ""><cfelse><cfset cr_bsl = 1></cfif>
		<cfif isdefined("cr_dwp") is false><cfset cr_dwp = ""><cfelse><cfset cr_dwp = 1></cfif>
		<cfif isdefined("cr_bos") is false><cfset cr_bos = ""><cfelse><cfset cr_bos = 1></cfif>
		<cfif isdefined("cr_dot") is false><cfset cr_dot = ""><cfelse><cfset cr_dot = 1></cfif>
		<cfif isdefined("cr_other") is false><cfset cr_other = ""></cfif>
		<cfif isdefined("cr_truncate") is false><cfset cr_truncate = ""><cfelse><cfset cr_truncate = 1></cfif>
		<cfif isdefined("cr_lip") is false><cfset cr_lip = ""><cfelse><cfset cr_lip = 1></cfif>
		<cfif isdefined("cr_scoring") is false><cfset cr_scoring = ""><cfelse><cfset cr_scoring = 1></cfif>
		<cfif isdefined("cr_excptn") is false><cfset cr_excptn = ""><cfelse><cfset cr_excptn = 1></cfif>

		<cfset var data = {}>
		
		<cfset tbl = "tblCurbRamps">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Curb Ramp Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- Retrieve New NoteID --->
		<cfquery name="chkDuplicate" datasource="#request.sqlconn#">
		SELECT count(*) as cnt FROM #tbl# WHERE ramp_no = #cr_no#
		</cfquery>
		
		<cfif chkDuplicate.cnt gt 0>
			<!--- Retrieve Highest Ramp Number --->
			<cfquery name="getMax" datasource="#request.sqlconn#">
			SELECT (max(ramp_no)+1) as num FROM #tbl#
			</cfquery>
			<!--- <cfset data.result = "- Curb Ramp Creation Failed: Duplicate Curb Ramp Number.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort> --->
			<cfset cr_no = getMax.num>
		</cfif>
			
		<cftry>
			
			<cfif cr_logdate is not "">
				<cfset arrDT = listtoarray(cr_logdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_logdate = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_design_sdt is not "">
				<cfset arrDT = listtoarray(cr_design_sdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_design_sdt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_design_fdt is not "">
				<cfset arrDT = listtoarray(cr_design_fdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_design_fdt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_assessed_dt is not "">
				<cfset arrDT = listtoarray(cr_assessed_dt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_assessed_dt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_con_cdt is not "">
				<cfset arrDT = listtoarray(cr_con_cdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_con_cdt = createODBCDate(dt)>
			</cfif>

			<cfset cr_primary = replace(cr_primary,"'","''","ALL")>
			<cfset cr_secondary = replace(cr_secondary,"'","''","ALL")>
			<cfset cr_corner = replace(cr_corner,"'","''","ALL")>
			<cfset cr_designby = replace(cr_designby,"'","''","ALL")>
			<cfset cr_assessedby = replace(cr_assessedby,"'","''","ALL")>
			<cfset cr_other = replace(cr_other,"'","''","ALL")>
			<cfset cr_notes = replace(cr_notes,"'","''","ALL")>
			<cfset cr_excptn_notes = replace(cr_excptn_notes,"'","''","ALL")>
			
			<cfquery name="addFeature" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Ramp_No,
			    <cfif trim(cr_primary) is not "">Primary_Street,</cfif>
			    <cfif trim(cr_type) is not "">Type,</cfif>
			    <cfif trim(cr_secondary) is not "">Secondary_Street,</cfif>
			    <cfif trim(cr_cd) is not "">Council_District,</cfif>
				<cfif trim(cr_zip) is not "">Zip_Code,</cfif>
				<cfif trim(cr_corner) is not "">Intersection_Corner,</cfif>
				<cfif trim(cr_priority) is not "">Priority_No,</cfif>
				<cfif trim(cr_logdate) is not "">Date_Logged,</cfif>
				<cfif trim(cr_assessed) is not "">Field_Assessed,</cfif>
				<cfif trim(cr_existing) is not "">Existing_Ramp,</cfif>
				<cfif trim(cr_compliant) is not "">ADA_Compliant,</cfif>
				<cfif trim(cr_applicable) is not "">Standard_Plan_Applicable,</cfif>
				<cfif trim(cr_repairs) is not "">Repairs_Required,</cfif>
				<cfif trim(cr_design) is not "">Design_Required,</cfif>
				<cfif trim(cr_design_sdt) is not "">Design_Start_Date,</cfif>
				<cfif trim(cr_design_fdt) is not "">Design_Finish_Date,</cfif>
				<cfif trim(cr_designby) is not "">Designed_By,</cfif>
				<cfif trim(cr_assessed_dt) is not "">Assessed_Date,</cfif>
				<cfif trim(cr_assessedby) is not "">Assessed_By,</cfif>
				<cfif trim(cr_dotcoord) is not "">DOT_Coordination,</cfif>
				<cfif trim(cr_con_cdt) is not "">Construction_Completed_Date,</cfif>
				<cfif trim(cr_utility) is not "">Utility_Conflict,</cfif>
				<cfif trim(cr_bsl) is not "">BSL_Conflict,</cfif>
				<cfif trim(cr_dwp) is not "">DWP_Conflict,</cfif>
				<cfif trim(cr_bos) is not "">BOS_Conflict,</cfif>
				<cfif trim(cr_dot) is not "">DOT_Conflict,</cfif>
				<cfif trim(cr_other) is not "">Other_Conflict,</cfif>
				<cfif trim(cr_minor) is not "">Minor_Repair_Only,</cfif>
				<cfif trim(cr_truncate) is not "">Add_Truncated_Domes,</cfif>
				<cfif trim(cr_lip) is not "">Lip_Grind,</cfif>
				<cfif trim(cr_scoring) is not "">Add_Scoring_Lines,</cfif>
				<cfif trim(cr_notes) is not "">Notes,</cfif>
				<cfif trim(cr_excptn) is not "">ADA_Exception,</cfif>
				<cfif trim(cr_excptn_notes) is not "">ADA_Exception_Notes,</cfif>
				<cfif trim(cr_sno) is not "">Location_No,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#cr_no#,
				<cfif trim(cr_primary) is not "">'#PreserveSingleQuotes(cr_primary)#',</cfif>
			    <cfif trim(cr_type) is not "">#cr_type#,</cfif>
			    <cfif trim(cr_secondary) is not "">'#PreserveSingleQuotes(cr_secondary)#',</cfif>
			    <cfif trim(cr_cd) is not "">#cr_cd#,</cfif>
				<cfif trim(cr_zip) is not "">#cr_zip#,</cfif>
				<cfif trim(cr_corner) is not "">'#PreserveSingleQuotes(cr_corner)#',</cfif>
				<cfif trim(cr_priority) is not "">#cr_priority#,</cfif>
				<cfif trim(cr_logdate) is not "">#cr_logdate#,</cfif>
				<cfif trim(cr_assessed) is not "">#cr_assessed#,</cfif>
				<cfif trim(cr_existing) is not "">#cr_existing#,</cfif>
				<cfif trim(cr_compliant) is not "">#cr_compliant#,</cfif>
				<cfif trim(cr_applicable) is not "">#cr_applicable#,</cfif>
				<cfif trim(cr_repairs) is not "">#cr_repairs#,</cfif>
				<cfif trim(cr_design) is not "">#cr_design#,</cfif>
				<cfif trim(cr_design_sdt) is not "">#cr_design_sdt#,</cfif>
				<cfif trim(cr_design_fdt) is not "">#cr_design_fdt#,</cfif>
				<cfif trim(cr_designby) is not "">'#PreserveSingleQuotes(cr_designby)#',</cfif>
				<cfif trim(cr_assessed_dt) is not "">#cr_assessed_dt#,</cfif>
				<cfif trim(cr_assessedby) is not "">'#PreserveSingleQuotes(cr_assessedby)#',</cfif>
				<cfif trim(cr_dotcoord) is not "">#cr_dotcoord#,</cfif>
				<cfif trim(cr_con_cdt) is not "">#cr_con_cdt#,</cfif>
				<cfif trim(cr_utility) is not "">#cr_utility#,</cfif>
				<cfif trim(cr_bsl) is not "">#cr_bsl#,</cfif>
				<cfif trim(cr_dwp) is not "">#cr_dwp#,</cfif>
				<cfif trim(cr_bos) is not "">#cr_bos#,</cfif>
				<cfif trim(cr_dot) is not "">#cr_dot#,</cfif>
				<cfif trim(cr_other) is not "">'#PreserveSingleQuotes(cr_other)#',</cfif>
				<cfif trim(cr_minor) is not "">#cr_minor#,</cfif>
				<cfif trim(cr_truncate) is not "">#cr_truncate#,</cfif>
				<cfif trim(cr_lip) is not "">#cr_lip#,</cfif>
				<cfif trim(cr_scoring) is not "">#cr_scoring#,</cfif>
				<cfif trim(cr_notes) is not "">'#PreserveSingleQuotes(cr_notes)#',</cfif>
				<cfif trim(cr_excptn) is not "">#cr_excptn#,</cfif>
				<cfif trim(cr_excptn_notes) is not "">'#PreserveSingleQuotes(cr_excptn_notes)#',</cfif>
				<cfif trim(cr_sno) is not "">#cr_sno#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>

			<cfset data.id = cr_no>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Site Creation Failed: Database Error.">
		
			<!--- Remove the ID of record --->
			<!--- <cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM #tbl# WHERE ramp_no = #cr_no#
			</cfquery> --->
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updateCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="cr_no" required="true">
		<cfargument name="cr_primary" required="true">
		<cfargument name="cr_type" required="true">
		<cfargument name="cr_secondary" required="true">
		<cfargument name="cr_cd" required="true">
		<cfargument name="cr_zip" required="true">
		<cfargument name="cr_corner" required="true">
		<cfargument name="cr_priority" required="true">
		<cfargument name="cr_logdate" required="true">
		<cfargument name="cr_assessed" required="true">
		<cfargument name="cr_existing" required="true">
		<cfargument name="cr_compliant" required="true">
		<cfargument name="cr_applicable" required="true">
		<cfargument name="cr_repairs" required="true">
		<cfargument name="cr_design" required="true">
		<cfargument name="cr_design_sdt" required="true">
		<cfargument name="cr_design_fdt" required="true">
		<cfargument name="cr_designby" required="true">
		<cfargument name="cr_assessed_dt" required="true">
		<cfargument name="cr_assessedby" required="true">
		<cfargument name="cr_qc_dt" required="true">
		<cfargument name="cr_qcby" required="true">
		<cfargument name="cr_dotcoord" required="true">
		<cfargument name="cr_con_cdt" required="true">
		<cfargument name="cr_totalcost" required="true">
		<cfargument name="cr_utility" required="true">
		<cfargument name="cr_minor" required="true">
		<cfargument name="cr_notes" required="true">
		<cfargument name="cr_sno" required="true">
		<cfargument name="cr_excptn_notes" required="true">
		
		<cfif isdefined("cr_bsl") is false><cfset cr_bsl = ""><cfelse><cfset cr_bsl = 1></cfif>
		<cfif isdefined("cr_dwp") is false><cfset cr_dwp = ""><cfelse><cfset cr_dwp = 1></cfif>
		<cfif isdefined("cr_bos") is false><cfset cr_bos = ""><cfelse><cfset cr_bos = 1></cfif>
		<cfif isdefined("cr_dot") is false><cfset cr_dot = ""><cfelse><cfset cr_dot = 1></cfif>
		<cfif isdefined("cr_other") is false><cfset cr_other = ""></cfif>
		<cfif isdefined("cr_truncate") is false><cfset cr_truncate = ""><cfelse><cfset cr_truncate = 1></cfif>
		<cfif isdefined("cr_lip") is false><cfset cr_lip = ""><cfelse><cfset cr_lip = 1></cfif>
		<cfif isdefined("cr_scoring") is false><cfset cr_scoring = ""><cfelse><cfset cr_scoring = 1></cfif>
		<cfif isdefined("cr_excptn") is false><cfset cr_excptn = ""><cfelse><cfset cr_excptn = 1></cfif>
		

		<cfset var data = {}>
		<cfset tbl = "tblCurbRamps">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Curb Ramp Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif cr_logdate is not "">
			<cfset arrDT = listtoarray(cr_logdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_logdate = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_design_sdt is not "">
			<cfset arrDT = listtoarray(cr_design_sdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_design_sdt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_design_fdt is not "">
			<cfset arrDT = listtoarray(cr_design_fdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_design_fdt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_assessed_dt is not "">
			<cfset arrDT = listtoarray(cr_assessed_dt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_assessed_dt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_qc_dt is not "">
			<cfset arrDT = listtoarray(cr_qc_dt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_qc_dt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_con_cdt is not "">
			<cfset arrDT = listtoarray(cr_con_cdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_con_cdt = createODBCDate(dt)>
		</cfif>
		
		<cfif trim(cr_primary) is ""><cfset cr_primary = "NULL"></cfif>
		<cfif trim(cr_type) is ""><cfset cr_type = "NULL"></cfif>
		<cfif trim(cr_secondary) is ""><cfset cr_secondary = "NULL"></cfif>
		<cfif trim(cr_cd) is ""><cfset cr_cd = "NULL"></cfif>
		<cfif trim(cr_zip) is ""><cfset cr_zip = "NULL"></cfif>
		<cfif trim(cr_corner) is ""><cfset cr_corner = "NULL"></cfif>
		<cfif trim(cr_priority) is ""><cfset cr_priority = "NULL"></cfif>
		<cfif trim(cr_logdate) is ""><cfset cr_logdate = "NULL"></cfif>
		<cfif trim(cr_assessed) is ""><cfset cr_assessed = "NULL"></cfif>
		<cfif trim(cr_existing) is ""><cfset cr_existing = "NULL"></cfif>
		<cfif trim(cr_compliant) is ""><cfset cr_compliant = "NULL"></cfif>
		<cfif trim(cr_applicable) is ""><cfset cr_applicable = "NULL"></cfif>
		<cfif trim(cr_repairs) is ""><cfset cr_repairs = "NULL"></cfif>
		<cfif trim(cr_design) is ""><cfset cr_design = "NULL"></cfif>
		<cfif trim(cr_design_sdt) is ""><cfset cr_design_sdt = "NULL"></cfif>
		<cfif trim(cr_design_fdt) is ""><cfset cr_design_fdt = "NULL"></cfif>
		<cfif trim(cr_designby) is ""><cfset cr_designby = "NULL"></cfif>
		<cfif trim(cr_assessed_dt) is ""><cfset cr_assessed_dt = "NULL"></cfif>
		<cfif trim(cr_assessedby) is ""><cfset cr_assessedby = "NULL"></cfif>
		<cfif trim(cr_qc_dt) is ""><cfset cr_qc_dt = "NULL"></cfif>
		<cfif trim(cr_qcby) is ""><cfset cr_qcby = "NULL"></cfif>
		<cfif trim(cr_dotcoord) is ""><cfset cr_dotcoord = "NULL"></cfif>
		<cfif trim(cr_con_cdt) is ""><cfset cr_con_cdt = "NULL"></cfif>
		<cfif trim(cr_totalcost) is ""><cfset cr_totalcost = "NULL"></cfif>
		<cfif trim(cr_utility) is ""><cfset cr_utility = "NULL"></cfif>
		<cfif trim(cr_minor) is ""><cfset cr_minor = "NULL"></cfif>
		<cfif trim(cr_notes) is ""><cfset cr_notes = "NULL"></cfif>
		<cfif trim(cr_sno) is ""><cfset cr_sno = "NULL"></cfif>
		<cfif trim(cr_bsl) is ""><cfset cr_bsl = "NULL"></cfif>
		<cfif trim(cr_dwp) is ""><cfset cr_dwp = "NULL"></cfif>
		<cfif trim(cr_bos) is ""><cfset cr_bos = "NULL"></cfif>
		<cfif trim(cr_dot) is ""><cfset cr_dot = "NULL"></cfif>
		<cfif trim(cr_other) is ""><cfset cr_other = "NULL"></cfif>
		<cfif trim(cr_truncate) is ""><cfset cr_truncate = "NULL"></cfif>
		<cfif trim(cr_lip) is ""><cfset cr_lip = "NULL"></cfif>
		<cfif trim(cr_scoring) is ""><cfset cr_scoring = "NULL"></cfif>
		<cfif trim(cr_excptn) is ""><cfset cr_excptn = "NULL"></cfif>
		<cfif trim(cr_excptn_notes) is ""><cfset cr_excptn_notes = "NULL"></cfif>
		
		<cfset cr_primary = replace(cr_primary,"'","''","ALL")>
		<cfset cr_secondary = replace(cr_secondary,"'","''","ALL")>
		<cfset cr_corner = replace(cr_corner,"'","''","ALL")>
		<cfset cr_designby = replace(cr_designby,"'","''","ALL")>
		<cfset cr_assessedby = replace(cr_assessedby,"'","''","ALL")>
		<cfset cr_qcby = replace(cr_qcby,"'","''","ALL")>
		<cfset cr_other = replace(cr_other,"'","''","ALL")>
		<cfset cr_notes = replace(cr_notes,"'","''","ALL")>
		<cfset cr_excptn_notes = replace(cr_excptn_notes,"'","''","ALL")>
		
			
		<cftry>
		
			<cfquery name="UpdateFeature" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET
			Primary_Street = '#PreserveSingleQuotes(cr_primary)#',
			Secondary_Street = <cfif cr_secondary is "NULL">#cr_secondary#<cfelse>'#PreserveSingleQuotes(cr_secondary)#'</cfif>,
			Type = #cr_type#,
			Council_District = #cr_cd#,
			Zip_Code = #cr_zip#,
			Intersection_Corner = <cfif cr_corner is "NULL">#cr_corner#<cfelse>'#PreserveSingleQuotes(cr_corner)#'</cfif>,
			Priority_No = #cr_priority#,
			Date_Logged = #cr_logdate#,
			Field_Assessed = #cr_assessed#,
			Existing_Ramp = #cr_existing#,
			ADA_Compliant = #cr_compliant#,
			Standard_Plan_Applicable = #cr_applicable#,
			Repairs_Required = #cr_repairs#,
			Design_Required = #cr_design#,
			Design_Start_Date = #cr_design_sdt#,
			Design_Finish_Date = #cr_design_fdt#,
			Designed_By = <cfif cr_designby is "NULL">#cr_designby#<cfelse>'#PreserveSingleQuotes(cr_designby)#'</cfif>,
			Assessed_Date = #cr_assessed_dt#,
			Assessed_By = <cfif cr_assessedby is "NULL">#cr_assessedby#<cfelse>'#PreserveSingleQuotes(cr_assessedby)#'</cfif>,
			QC_Date = #cr_qc_dt#,
			QC_By = <cfif cr_qcby is "NULL">#cr_qcby#<cfelse>'#PreserveSingleQuotes(cr_qcby)#'</cfif>,
			DOT_Coordination = #cr_dotcoord#,
			Construction_Completed_Date = #cr_con_cdt#,
			Total_Cost = #cr_totalcost#,
			Utility_Conflict = #cr_utility#,
			BSL_Conflict = #cr_bsl#,
			DWP_Conflict = #cr_dwp#,
			BOS_Conflict = #cr_bos#,
			DOT_Conflict = #cr_dot#,
			Other_Conflict = <cfif cr_other is "NULL">#cr_other#<cfelse>'#PreserveSingleQuotes(cr_other)#'</cfif>,
			Minor_Repair_Only = #cr_minor#,
			Add_Truncated_Domes = #cr_truncate#,
			Lip_Grind = #cr_lip#,
			Add_Scoring_Lines = #cr_scoring#,
			Notes = <cfif cr_notes is "NULL">#cr_notes#<cfelse>'#PreserveSingleQuotes(cr_notes)#'</cfif>,
			ADA_Exception = #cr_excptn#,
			ADA_Exception_Notes = <cfif cr_excptn_notes is "NULL">#cr_excptn_notes#<cfelse>'#PreserveSingleQuotes(cr_excptn_notes)#'</cfif>,
			Location_No = #cr_sno#,
			modified_date = #CreateODBCDateTime(Now())#,
			User_ID = #session.user_num#
			WHERE ramp_no = #cr_no#
			</cfquery>
		
			<cfset data.id = cr_no>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Curb Ramp Update Failed: Database Error.">
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="searchCurbRamps" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="scr_no" required="true">
		<cfargument name="scr_sno" required="true">
		<cfargument name="scr_pgroup" required="true">
		<cfargument name="scr_pno" required="true">
		<cfargument name="scr_type" required="true">
		<cfargument name="scr_primary" required="true">
		<cfargument name="scr_secondary" required="true">
		<cfargument name="scr_zip" required="true">
		<cfargument name="scr_assessed" required="true">
		<cfargument name="scr_repairs" required="true">
		<cfargument name="scr_design" required="true">
		<cfargument name="scr_applicable" required="true">
		<cfargument name="scr_utility" required="true">
		<cfargument name="scr_minor" required="true">
		<cfargument name="scr_corner" required="true">
		<cfargument name="scr_priority" required="true">
		<cfargument name="scr_cd" required="true">
		<cfargument name="scr_dsdfrm" required="true">
		<cfargument name="scr_dsdto" required="true">
		<cfargument name="scr_dfdfrm" required="true">
		<cfargument name="scr_dfdto" required="true">
		<cfargument name="scr_assfrm" required="true">
		<cfargument name="scr_assto" required="true">
		<cfargument name="scr_ccdfrm" required="true">
		<cfargument name="scr_ccdto" required="true">
		<cfargument name="scr_dsdnull" required="false">
		<cfargument name="scr_dfdnull" required="false">
		<cfargument name="scr_assnull" required="false">
		<cfargument name="scr_ccdnull" required="false">
		<cfargument name="scr_order" required="false" default="ramp_no,location_no">
		
		<cfif isdefined("scr_dsdnull")><cfset session.scr_dsdnull = 1><cfelse><cfset StructDelete(Session, "scr_dsdnull")></cfif>
		<cfif isdefined("scr_dfdnull")><cfset session.scr_dfdnull = 1><cfelse><cfset StructDelete(Session, "scr_dfdnull")></cfif>
		<cfif isdefined("scr_assnull")><cfset session.scr_assnull = 1><cfelse><cfset StructDelete(Session, "scr_assnull")></cfif>
		<cfif isdefined("scr_ccdnull")><cfset session.scr_ccdnull = 1><cfelse><cfset StructDelete(Session, "scr_ccdnull")></cfif>
		
		<!--- <cfdump var="#arguments#">
		<cfabort> --->
		
		<cfset var data = {}>
		
		<cfset scr_primary = trim(scr_primary)>
		<cfset scr_secondary = trim(scr_secondary)>
		<cfset scr_zip = trim(scr_zip)>
		
		<cfset scr_dsgnstart = "">
		<cfset scr_dsgnfinish = "">
		
		<cfif scr_dsdfrm is not "">
			<cfset arrDT = listtoarray(scr_dsdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dsdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_dsdto is not "">
			<cfset arrDT = listtoarray(scr_dsdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dsdto = createODBCDate(dt)>
		</cfif>
		<cfif scr_dfdfrm is not "">
			<cfset arrDT = listtoarray(scr_dfdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dfdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_dfdto is not "">
			<cfset arrDT = listtoarray(scr_dfdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dfdto = createODBCDate(dt)>
		</cfif>
		
		<cfset scr_assessor = "">
		<cfset scr_concomplete = "">
		
		<cfif scr_assfrm is not "">
			<cfset arrDT = listtoarray(scr_assfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_assfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_assto is not "">
			<cfset arrDT = listtoarray(scr_assto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_assto = createODBCDate(dt)>
		</cfif>
		<cfif scr_ccdfrm is not "">
			<cfset arrDT = listtoarray(scr_ccdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_ccdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_ccdto is not "">
			<cfset arrDT = listtoarray(scr_ccdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_ccdto = createODBCDate(dt)>
		</cfif>
		
		<cfif trim(scr_dsdfrm) is not "" AND trim(scr_dsdto) is ""><cfset scr_dsgnstart = scr_dsdfrm></cfif>
		<cfif trim(scr_dsdto) is not "" AND trim(scr_dsdfrm) is ""><cfset scr_dsgnstart = scr_dsdto></cfif>
		<cfset dsdbtwn = "">
		<cfif trim(scr_dsdfrm) is not "" AND trim(scr_dsdto) is not "">
			<cfset dsdbtwn = "AND (design_start_date >= " & scr_dsdfrm & " AND design_start_date <= " & scr_dsdto & ")"> 
		</cfif>
		<cfif trim(scr_dsdfrm) is "" AND trim(scr_dsdto) is not "">
			<cfset scr_dsgnstart = "">
			<cfset dsdbtwn = "AND design_start_date <= " & scr_dsdto> 
		</cfif>
		
		<cfif trim(scr_dfdfrm) is not "" AND trim(scr_dfdto) is ""><cfset scr_dsgnfinish = scr_dfdfrm></cfif>
		<cfif trim(scr_dfdto) is not "" AND trim(scr_dfdfrm) is ""><cfset scr_dsgnfinish = scr_dfdto></cfif>
		<cfset dfdbtwn = "">
		<cfif trim(scr_dfdfrm) is not "" AND trim(scr_dfdto) is not "">
			<cfset dfdbtwn = "AND (design_finish_date >= " & scr_dfdfrm & " AND design_finish_date <= " & scr_dfdto & ")"> 
		</cfif>	
		<cfif trim(scr_dfdfrm) is "" AND trim(scr_dfdto) is not "">
			<cfset scr_dsgnfinish = "">
			<cfset dfdbtwn = "AND design_finish_date <= " & scr_dfdto> 
		</cfif>

		<cfif trim(scr_assfrm) is not "" AND trim(scr_assto) is ""><cfset scr_assessor = scr_assfrm></cfif>
		<cfif trim(scr_assto) is not "" AND trim(scr_assfrm) is ""><cfset scr_assessor = scr_assto></cfif>
		<cfset assbtwn = "">
		<cfif trim(scr_assfrm) is not "" AND trim(scr_assto) is not "">
			<cfset assbtwn = "AND (assessed_date >= " & scr_assfrm & " AND assessed_date <= " & scr_assto & ")"> 
		</cfif>
		<cfif trim(scr_assfrm) is "" AND trim(scr_assto) is not "">
			<cfset scr_assessor = "">
			<cfset assbtwn = "AND  assessed_date <= " & scr_assto> 
		</cfif>
		
		<cfif trim(scr_ccdfrm) is not "" AND trim(scr_ccdto) is ""><cfset scr_concomplete = scr_ccdfrm></cfif>
		<cfif trim(scr_ccdto) is not "" AND trim(scr_ccdfrm) is ""><cfset scr_concomplete = scr_ccdto></cfif>
		<cfset concbtwn = "">
		<cfif trim(scr_ccdfrm) is not "" AND trim(scr_ccdto) is not "">
			<cfset concbtwn = "AND (construction_completed_date >= " & scr_ccdfrm & " AND construction_completed_date <= " & scr_ccdto & ")"> 
		</cfif>
		<cfif trim(scr_ccdfrm) is "" AND trim(scr_ccdto) is not "">
			<cfset scr_concomplete = "">
			<cfset concbtwn = "AND construction_completed_date <= " & scr_ccdto> 
		</cfif>
	
		
		<cfquery name="getCurbRamps" datasource="#request.sqlconn#">
		SELECT * FROM vwCurbRamps WHERE 1=1
		<cfif scr_no is not "">AND ramp_no = #scr_no#</cfif> 
		<cfif scr_sno is not "">AND location_no = #scr_sno#</cfif> 
		<cfif scr_pgroup is not "">
			<cfif scr_pgroup is "ALL">
				AND package_group is not NULL
			<cfelseif scr_pgroup is "NONE">
				AND package_group is NULL
			<cfelse>
				AND package_group = '#scr_pgroup#'
			</cfif>
		</cfif> 
		<cfif scr_pno is not "">AND package_no = '#scr_pno#'</cfif> 
		<cfif scr_type is not "">AND type = '#scr_type#'</cfif> 
		<cfif trim(scr_primary) is not "">AND primary_street LIKE '%#preservesinglequotes(scr_primary)#%'</cfif> 
		<cfif trim(scr_secondary) is not "">AND secondary_street LIKE '%#preservesinglequotes(scr_secondary)#%'</cfif> 
		<cfif scr_zip is not "">AND zip_code = #scr_zip#</cfif>
		<cfif scr_assessed is not "">
			<cfif scr_assessed is 1>
				AND field_assessed = #scr_assessed#
			<cfelse>
				AND (field_assessed = 0 OR field_assessed is null)
			</cfif>
		</cfif> 
		<cfif scr_repairs is not "">AND repairs_required = #scr_repairs#</cfif> 
		<cfif scr_design is not "">AND design_required = #scr_design#</cfif> 
		<cfif scr_applicable is not "">AND standard_plan_applicable = #scr_applicable#</cfif> 
		<cfif scr_utility is not "">AND utility_conflict = #scr_utility#</cfif> 
		<cfif scr_minor is not "">AND minor_repair_only = #scr_minor#</cfif> 
		<cfif trim(scr_corner) is not "">AND intersection_corner = '#preservesinglequotes(scr_corner)#'</cfif>
		<cfif scr_priority is not "">AND priority_no = #scr_priority#</cfif> 
		<cfif scr_cd is not "">AND council_district = #scr_cd#</cfif> 
		<cfif trim(scr_dsgnstart) is not "">AND design_start_date = #preservesinglequotes(scr_dsgnstart)#</cfif>
		<cfif trim(dsdbtwn) is not "">#preservesinglequotes(dsdbtwn)#</cfif>
		<cfif trim(scr_dsgnfinish) is not "">AND design_finish_date = #preservesinglequotes(scr_dsgnfinish)#</cfif>
		<cfif trim(dfdbtwn) is not "">#preservesinglequotes(dfdbtwn)#</cfif>
		<cfif trim(scr_assessor) is not "">AND assessed_date = #preservesinglequotes(scr_assessor)#</cfif>
		<cfif trim(assbtwn) is not "">#preservesinglequotes(assbtwn)#</cfif>
		<cfif trim(scr_concomplete) is not "">AND construction_completed_date = #preservesinglequotes(scr_concomplete)#</cfif>
		<cfif trim(concbtwn) is not "">#preservesinglequotes(concbtwn)#</cfif>
		<cfif isdefined("scr_dsdnull")>AND design_start_date IS NULL</cfif>
		<cfif isdefined("scr_dfdnull")>AND design_finish_date IS NULL</cfif>
		<cfif isdefined("scr_assnull")>AND assessed_date IS NULL</cfif>
		<cfif isdefined("scr_ccdnull")>AND construction_completed_date IS NULL</cfif>
		ORDER BY #scr_order#
		</cfquery>
	
		<cfset data.query = serializeJSON(getCurbRamps)>
		
		<cfset session.curbQuery = getCurbRamps>
	
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="updatePriorityDefault" access="remote" returnType="any" returnFormat="plain" output="false">
		<!--- <cfargument name="sw_id" required="true"> --->
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to update the Estimate Default Table.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cfquery name="getKeys" datasource="#request.sqlconn#">
		SELECT id FROM tblPriorityRanks
		</cfquery>
		
		<!--- <cftry> --->
		
			<cfloop query="getKeys">
		
				<cfset points = evaluate("points_#getKeys.id#")>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblPriorityRanks SET 
				points = #points#
				WHERE id = #getKeys.id#
				</cfquery>
				
			</cfloop>

			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset tbl = "tblSites">
		<cfset data.priority = updatePriority(0,tbl)>
		
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	
	
</cfcomponent>
