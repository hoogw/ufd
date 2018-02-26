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
<cfif session.user_level lt 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<!---
	CurbRampTracking.cfr expects the query passed into it to contain the following column names:
		Field: Ramp_No               DataType: String
		Field: Primary_Street        DataType: String
		Field: Secondary_Street      DataType: String
		Field: Intersection_Corner   DataType: String
		Field: Priority_No           DataType: Integer
		Field: Council_District      DataType: Integer
		Field: Design_Start_Date     DataType: Time Stamp
		Field: Design_Finish_Date    DataType: Time Stamp
		Field: Designed_By           DataType: String
		Field: QC_Date               DataType: Time Stamp
		Field: QC_By                 DataType: String
		Field: Construction_Completed_Date  DataType: Time Stamp
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    Ramp_No, Primary_Street, Secondary_Street, Intersection_Corner, Priority_No, Council_District, Design_Start_Date, Design_Finish_Date, Designed_By, QC_Date, QC_By, Construction_Completed_Date
	FROM      dbo.vwHDRCurbRamps
</cfquery>

<cfreport template="CurbRampTracking.cfr" format="pdf" query="MyQuery"/>