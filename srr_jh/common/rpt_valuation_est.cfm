<cfmodule template="../common/header.cfm">		

<cfinclude template="myCFfunctions.cfm">

<cfparam name="request.srr_status_cd" default="all">

<cfparam name="request.prop_type" default="all">

<CFQUERY NAME="stats1" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT 
count(srr_id) as nbr_of_apps
      , min([valuation_est]) as min_value
	  , max (valuation_est) as max_value
	  , avg(valuation_est) as ave_value
	  , sum(valuation_est) as sum_value

  FROM [srr].[dbo].[srr_info]
WHERE
    (1=1)
  
  
<!---   where valuation_est > 0 --->
  
    <cfif #request.srr_status_cd# is not "all">
  and
  srr_status_cd = '#request.srr_status_cd#'
  </cfif>
  
<cfif #request.prop_type# is not "all">
  and
  prop_type = '#request.prop_type#'
  </cfif>

</CFQUERY> 

<CFQUERY NAME="stats2" DATASOURCE="#REQUEST.DSN#" DBTYPE="ODBC">
SELECT 
valuation_est

  FROM [srr].[dbo].[srr_info]

  where 
  (1=1)
  
<!---   valuation_est > 0 --->
  
  <cfif #request.srr_status_cd# is not "all">
  and
  srr_status_cd = '#request.srr_status_cd#'
  </cfif>
  
  <cfif #request.prop_type# is not "all">
  and
  prop_type = '#request.prop_type#'
  </cfif>
  
 
</CFQUERY> 

<cfquery name="SrrStatus" datasource="#request.dsn#" dbtype="datasource">
SELECT [srr_status_cd]
      ,[srr_status_desc]
      ,[reason_code_311]
      ,[resolution_code_311]
      ,[reason_code_txt_311]
      ,[resolution_code_txt_311]
      ,[sr_status_311]
      ,[agency]
      ,[srr_list_order]
      ,[suspend]
      ,[zz_reason_code_comment_311]
      ,[endStatus]
  FROM [srr].[dbo].[srr_status]
  ORDER BY srr_status_desc
</cfquery>

<cfset myList = #valueList(stats2.valuation_est)#>


<cfoutput>
<div class="subtitle">Rebate Valuation (Statistics)</div>
<div style="text-align:center;">

<body>
<div style="text-align:left;width:800px; margin-left:auto;margin-right:auto;">
<div align="left" style="width:100%; padding-bottom:10px;">
<form>
Status: &nbsp;&nbsp;<select name="srr_status_cd" id="srr_status_cd">
	<option value="all" <cfif #request.srr_status_cd# is "all">SELECTED</cfif>>All</option>
	<cfloop query="srrStatus">
	<option value="#SrrStatus.srr_status_cd#" <cfif #request.srr_status_cd# is #srrStatus.srr_status_cd#>SELECTED</cfif>>#srrStatus.srr_status_desc#</option>
	</cfloop>
	</select>&nbsp;
	<br>
	Property Type: &nbsp;&nbsp;<select name="prop_type" id="prop_type">
	<option value="all" <cfif #request.prop_type# is "all">SELECTED</cfif>>All</option>
	<option value="r" <cfif #request.prop_type# is "r">SELECTED</cfif>>Residential</option>
	<option value="c" <cfif #request.prop_type# is "c">SELECTED</cfif>>Commercial</option>
	</select>
	&nbsp;&nbsp;&nbsp;
<input type="submit" name="submit" value=" Refresh "  class="submit" style="padding:3px;">
</form>
</div>
</div>

<table border="1"  class = "formtable" style = "width:850px;">
<tr>
	<td>Number of Applications</td>
	<td><span class="data">#stats1.nbr_of_apps#</span></td>
</tr>

<tr>
	<td>Minimum Rebate Valuation</td>
	<td><span class="data">#dollarformat(stats1.min_value)#</span></td>
</tr>
<tr>
	<td>Maximum Rebate Valuation</td>
	<td><span class="data">#dollarformat(stats1.max_value)#</span></td>
</tr>
<tr>
	<td>Average Rebate Valuation</td>
	<td><span class="data">#dollarformat(stats1.ave_value)#</span></td>
</tr>
<tr>
	<td>Median Rebate Valuation</td>
	<td><cfif #myList# is not ""><span class="data">#dollarformat(median(myList))#</span></cfif></td>
</tr>

<tr>
	<td>Total of all Rebate Valuations</td>
	<td><span class="data">#dollarformat(stats1.sum_value)#</span></td>
</tr>
</table>
</div>
</cfoutput>

<cfinclude template="footer.cfm">











