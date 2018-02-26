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
	PricingAnalysis.cfr expects the query passed into it to contain the following column names:
		Field: Bid_Item              DataType: String
		Field: UOM                   DataType: String
		Field: average               DataType: Float
		Field: high                  DataType: Float
		Field: low                   DataType: Float
		Field: Sites                 DataType: Integer
		Field: change_order          DataType: String
--->

<!--- sample query PricingAnalysis.cfm?start=2015-1-1&end=2017-1-1 --->

<cfif IsDefined("URL.start") and trim(#URL.start#) neq "" and IsDefined("URL.end") and trim(#URL.end#) neq "" >
<cfquery name="ReportQuery" datasource="sidewalk">
		 EXEC [dbo].[UnitPriceAnalysis] 
	<cfqueryparam value=#URL.start# cfsqltype="cf_sql_date">,
	<cfqueryparam value=#URL.end# cfsqltype="cf_sql_date">
</cfquery>
<cfelse>
<cfquery name="ReportQuery" datasource="sidewalk">
		 EXEC [dbo].[UnitPriceAnalysis] 
</cfquery>
</cfif>

<cfreport template="PricingAnalysis.cfr" format="pdf" query="ReportQuery"/>