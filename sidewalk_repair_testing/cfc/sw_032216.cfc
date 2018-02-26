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
			    <cfif trim(sw_priority) is not "">Priority_No,</cfif>
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
			    <cfif trim(sw_priority) is not "">#sw_priority#,</cfif>
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
		SELECT package_no FROM tblPackages WHERE package_group = '#sw_pgroup#' AND removed is null ORDER BY package_no
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
		<cfargument name="sw_cemail" required="true">
		<cfargument name="sw_cphone" required="true">
		<cfargument name="sw_performance" required="true">
		<cfargument name="sw_payment" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_idList" required="true">
		<cfargument name="sw_remove" required="false" default="0">
		
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
			
			<cfset sw_wo = replace(sw_wo,"'","''","ALL")>
			<cfset sw_contractor = replace(sw_contractor,"'","''","ALL")>
			<cfset sw_cname = replace(sw_cname,"'","''","ALL")>
			<cfset sw_cemail = replace(sw_cemail,"'","''","ALL")>
			<cfset sw_cphone = replace(sw_cphone,"'","''","ALL")>
			<cfset sw_notes = replace(sw_notes,"'","''","ALL")>
			<cfset sw_est = replace(sw_est,",","","ALL")>
			<cfset sw_award = replace(sw_award,",","","ALL")>
			
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
			Contractor = <cfif sw_contractor is "NULL">#sw_contractor#<cfelse>'#PreserveSingleQuotes(sw_contractor)#'</cfif>,
			Contractor_name = <cfif sw_cname is "NULL">#sw_cname#<cfelse>'#PreserveSingleQuotes(sw_cname)#'</cfif>,
			Contractor_email = <cfif sw_cemail is "NULL">#sw_cemail#<cfelse>'#PreserveSingleQuotes(sw_cemail)#'</cfif>,
			Contractor_phone = <cfif sw_cphone is "NULL">#sw_cphone#<cfelse>'#PreserveSingleQuotes(sw_cphone)#'</cfif>,
			construction_manager = <cfif sw_cm is "NULL">#sw_cm#<cfelse>'#PreserveSingleQuotes(sw_cm)#'</cfif>,
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
		City_Owned_Property = #sw_cityowned#,
		Priority_No = #sw_priority#,
		Date_Logged = #sw_logdate#,
		Zip_Code = #sw_zip#,
		Curb_Ramp_Only = #sw_curbramp#,
		Design_Required = #sw_designreq#,
		Design_Start_Date = #sw_dsgnstart#,
		Design_Finish_Date = #sw_dsgnfinish#,
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
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="searchPackages" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="ps_no" required="true">
		<cfargument name="ps_group" required="true">
		<cfargument name="ps_wo" required="true">
		<cfargument name="ps_con" required="true">
		<cfargument name="ps_name" required="true">
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
		<cfargument name="ss_order" required="false" default="location_no,location_suffix">
		
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
			<cfset assbtwn = "AND (qc_date >= " & ss_qcfrm & " AND qc_date <= " & ss_qcto & ")"> 
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
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblEngineeringEstimate SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			
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
			WHERE TABLE_NAME = 'vwHDRTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRTreeRemovalInfo
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"TreeRemovalInfo")>
			<cfset spreadsheetsetActiveSheet(s,"TreeRemovalInfo")>
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

			<cfset columns = "Site,Council District,Package,Facility Name,Address,Construction Start Date,Construction Completed Date,Priority No,Type,Work Order">
			
			<cfquery name="setSearch" dbtype="query">
			SELECT location_no as site,council_district as cd, package,name as facility_name,address,construction_start_date,
			construction_completed_date,priority_no,type_desc,work_order FROM session.siteQuery
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
		SELECT * FROM dbo.tblUsers WHERE user_name = '#user#' AND user_password = '#password#'
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
			SELECT * FROM dbo.tblUsers WHERE user_name = '#user#'
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
		
		
		
		
		<cftry>
		
		
		<!--- UPDATE the first table --->
		<cfset tbl = "tblTreeSiteInfo">
		<cfquery name="chkTree" datasource="#request.sqlconn#">
		SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id#
		</cfquery>
		<cfset tree_trc = replace(tree_trc,"'","''","ALL")>
		<cfset tree_tpc = replace(tree_tpc,"'","''","ALL")>
		<cfset tree_twc = replace(tree_twc,"'","''","ALL")>
		<cfset tree_trn = replace(tree_trn,"'","''","ALL")>
		<cfif chkTree.recordcount is 0>
			
			<cfquery name="addTreeInfo" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Location_No,
			    <cfif trim(tree_trc) is not "">Tree_Removal_Contractor,</cfif>
			    <cfif trim(tree_tpc) is not "">Tree_Planting_Contractor,</cfif>
			    <cfif trim(tree_twc) is not "">Tree_Watering_Contractor,</cfif>
			    <cfif trim(tree_trn) is not "">Tree_Removal_Notes,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#sw_id#,
			    <cfif trim(tree_trc) is not "">'#PreserveSingleQuotes(tree_trc)#',</cfif>
			    <cfif trim(tree_tpc) is not "">'#PreserveSingleQuotes(tree_tpc)#',</cfif>
			    <cfif trim(tree_twc) is not "">'#PreserveSingleQuotes(tree_twc)#',</cfif>
			    <cfif trim(tree_trn) is not "">'#PreserveSingleQuotes(tree_trn)#',</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
		
		<cfelse>
		
			<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET
			Tree_Removal_Contractor = <cfif tree_trc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trc)#'</cfif>,
			Tree_Planting_Contractor = <cfif tree_tpc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_tpc)#'</cfif>,
			Tree_Watering_Contractor = <cfif tree_twc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_twc)#'</cfif>,
			Tree_Removal_Notes = <cfif tree_trn is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trn)#'</cfif>,
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
					
					<cfif trim(trpidt) is ""><cfset trpidt = "NULL"></cfif>
					<cfif trim(trtrdt) is ""><cfset trtrdt = "NULL"></cfif>
					<cfif trim(traddr) is ""><cfset traddr = "NULL"></cfif>
					<cfif trim(trspecies) is ""><cfset trspecies = "NULL"></cfif>
					
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
					
					<cfif trim(tppidt) is ""><cfset tppidt = "NULL"></cfif>
					<cfif trim(tptrdt) is ""><cfset tptrdt = "NULL"></cfif>
					<cfif trim(tpswdt) is ""><cfset tpswdt = "NULL"></cfif>
					<cfif trim(tpewdt) is ""><cfset tpewdt = "NULL"></cfif>
					<cfif trim(tpaddr) is ""><cfset tpaddr = "NULL"></cfif>
					<cfif trim(tpspecies) is ""><cfset tpspecies = "NULL"></cfif>
					
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
		<cfset arrTrees[4] = "FOUR_FEET_X_SIX_FEET_TREE_WELL_CUT_OUT_">
		
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
		TREE_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = #lt_total#,
		<cfset data.TREE_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = lt_total>
		TREE_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY = #gt_total#,
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
		
		<cfcatch>
			<cfset data.result = "- Site Update Failed: Database Error.">
		</cfcatch>	
		</cftry>
		
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
	
	
	
	
	
	
</cfcomponent>
