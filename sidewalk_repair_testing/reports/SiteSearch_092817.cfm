<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=6");
	</script>
	<cfabort>
</cfif>
<!--- <cfif session.user_level lt 2>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif> --->
</cfoutput>

<!---
	SiteSearch.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           				DataType: Integer
		Field: Name                  				DataType: String
		Field: Type                  				DataType: String
		Field: Address        		 				DataType: String
		Field: Construction_Start_Date  			DataType: Time Stamp
		Field: Construction_Completed_Date  		DataType: Time Stamp
		Field: Package               				DataType: String
		Field: Priority_No             				DataType: Integer
		Field: Work_Order             				DataType: String
--->

<cfquery name="ReportQuery" dbtype="query">
SELECT location_no,council_district,package,name,address,construction_start_date,
construction_completed_date,priority_no,engineers_estimate,total_cost,total_concrete,type_desc as type,work_order FROM session.siteQuery
</cfquery>

<cfreport template="SiteSearch.cfr" format="pdf" query="ReportQuery"/>