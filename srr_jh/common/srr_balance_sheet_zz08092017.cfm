<!DOCTYPE html>
<cfparam name="request.council_dist" default="all">
<html>
<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="../css/boe_main_2016_v1.css" rel="stylesheet" type="text/css">
<title>(SRR) Sidewalk Repair Rebate Program - City of Los Angeles</title>
</head>

<body>
<cfoutput>
<div class="title">Sidewalk Repair Rebate Program (SRR)</div>
<div class = "subtitle">Balance Sheet as of #dateformat(now(),"mm/dd/yyyy")# #timeformat(now(),"h:mm tt")#</div>
<!--- updated 01/23/2107  --->
<cfset request.start_balance = 6000000>
<cfset request.pcontingency = 5>

<cfset request.Council_motion_Fund_Transfer = 1180885>
<cfset request.contingency = #request.pcontingency# * #request.start_balance# / 100>
<cfset request.net_balance = #request.start_balance# - #request.contingency#>
<cfset request.Program_allocation = #request.net_balance# - #request.council_motion_fund_Transfer#>


<div style="margin-left:auto;margin-right:auto;width:80%;"><!--- updated 01/23/2017, old date 10/24/2016--->
<p>Starting Balance: $#NumberFormat(request.start_balance)# as of 1/23/2017</p>
<!--- <p>Contingency: $#NumberFormat(request.contingency)# (#request.pcontingency#% of Starting Blance)</p> --->
<p>Contingency: $#NumberFormat(request.contingency)# (#request.pcontingency#% of Original Allocation)</p>
<p>Net Starting Balance: <strong>$#NumberFormat(request.net_balance)#</strong> </p>
<p>Council Motion Fund Transfer: $#numberformat(request.council_motion_fund_transfer)# as of 01/18/2017</p>
<p>Program Allocation: <strong>$#Numberformat(request.Program_Allocation)#</strong></p>

<cfquery name="readRates" datasource="#request.dsn#" dbtype="datasource">
SELECT rate_nbr, res_cap_amt, comm_cap_amt, ddate_implemented
from rebate_rates
order by rate_nbr
</cfquery>

<cfloop query="readRates">
<p>Under Rebate Rate No. #readRates.rate_nbr#: A Reserved amount of $#NumberFormat(readRates.res_cap_amt)# (for Residential properties), or $#NumberFormat(readRates.comm_cap_amt)# (for Commercial Properties) will be assigned to an application once it is received.</strong></p>
</cfloop>


</div>



<cfoutput>
<div align="center">
<form name="Form" method="post" action="srr_balance_sheet.cfm?&council_dist=#request.council_dist#">
<div  class="warning" style="text-align:right;width:200px;margin-right:auto;margin-left:auto">Council District&nbsp;&nbsp;&nbsp;<select name="council_dist" id="council_dist"onchange="this.form.submit()">
<option value="All" <cfif #request.council_dist# is "All">Selected</cfif>>All</option>
	<option value="1" <cfif #request.council_dist# is "1">Selected</cfif>>&nbsp; 1</option>
	<option value="2"<cfif #request.council_dist# is "2">Selected</cfif>>&nbsp; 2</option>
	<option value="3" <cfif #request.council_dist# is "3">Selected</cfif>>&nbsp; 3</option>
	<option value="4" <cfif #request.council_dist# is "4">Selected</cfif>>&nbsp; 4</option>
	<option value="5"<cfif #request.council_dist# is "5">Selected</cfif>>&nbsp; 5</option>
	<option value="6"<cfif #request.council_dist# is "6">Selected</cfif>>&nbsp; 6</option>
	<option value="7"<cfif #request.council_dist# is "7">Selected</cfif>>&nbsp; 7</option>
	<option value="8"<cfif #request.council_dist# is "8">Selected</cfif>>&nbsp; 8</option>
	<option value="9"<cfif #request.council_dist# is "9">Selected</cfif>>&nbsp; 9</option>
	<option value="10"<cfif #request.council_dist# is "10">Selected</cfif>>10</option>
	<option value="11"<cfif #request.council_dist# is "11">Selected</cfif>>11</option>
	<option value="12"<cfif #request.council_dist# is "12">Selected</cfif>>12</option>
	<option value="13"<cfif #request.council_dist# is "13">Selected</cfif>>13</option>
	<option value="14"<cfif #request.council_dist# is "14">Selected</cfif>>14</option>
	<option value="15"<cfif #request.council_dist# is "15">Selected</cfif>>15</option>
	</select></div> 
	
	<noscript><input type="submit" value="Submit"></noscript>
	</div>
	</form> 
	</div>
	</cfoutput>
	
	
	
	
<cfquery name="reserved" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum(offer_reserved_amt), 0) as sum_offer_reserved_amt

from srr_info

where 
prop_type = 'R'
and offer_reserved_amt > 0
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
prop_type = 'R'
and offer_open_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
prop_type = 'R'
and offer_accepted_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</cfquery>	

<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt) , 0)as sum_offer_paid_amt

from srr_info

where 
prop_type = 'R'
and offer_paid_amt > 0
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	

<cfset request.total_lots = #reserved.NbrOfLots# + #open.NbrOfLots# + #accepted.NbrOfLots# + #paid.NbrOfLots#>
<cfset request.subTotal = #reserved.sum_offer_reserved_amt# + #open.sum_offer_open_amt# + #accepted.sum_offer_accepted_amt# + #paid.sum_offer_paid_amt#>



<!--- Residential --->
<!--- <br /> --->
<br />
<div align="center">
<table class= "datatable" style="width: 80%;">
<tr>
<td  rowspan="3"><strong>Residential</strong></td>
<td  colspan="2"><strong>Reserved</strong></td>
<td colspan="2"><strong>Offers Made</strong></td>
<td colspan="2"><strong>Accepted Offers</strong></td>
<td colspan="2"><strong>Paid Offers</strong></td>
<td><strong>Subtotal</strong></td>
</tr>


<tr>
<td>No. of Lots</td>
<td>Reserved Amount</td>
<td>No. of Lots</td>
<td>Offered Amount</td>
<td>No. of Lots</td>
<td>Accepted Amount</td>
<td>No. of Lots</td>
<td>Paid Amount</td>
<!--- <td>&nbsp;</td> --->
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.total_lots# </strong> </td>
</tr>



<tr>


<td>#reserved.NbrOfLots#</td>
<td>#dollarformat(reserved.sum_offer_reserved_amt)#</td>



<td>#open.NbrOfLots#</td>
<td>#dollarformat(open.sum_offer_open_amt)#</td>


<td>#accepted.NbrOfLots#</td>
<td>#dollarformat(accepted.sum_offer_accepted_amt)#</td>



<td>#paid.NbrOfLots#</td>
<td>#dollarformat(paid.sum_offer_paid_amt)#</td>

<!--- <cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'R'
</cfquery>	 --->

<td><strong>#dollarformat(request.subTotal)#</strong></td>
</tr>
<!---</table>
</div>--->
<!--- Residential --->

<tr>
<td colspan="10">&nbsp;</td>
</tr>


<!--- Commercial --->

<!---<p>&nbsp;</p>
<div align="center">
<table class= "datatable" style="width: 80%;">--->




<cfquery name="reserved" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_reserved_amt), 0) as sum_offer_reserved_amt

from srr_info

where 
prop_type = 'C'
and offer_reserved_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
prop_type = 'C'
and offer_open_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
prop_type = 'C'
and offer_accepted_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt), 0) as sum_offer_paid_amt

from srr_info

where 
prop_type = 'C'
and offer_paid_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	


<cfset request.total_lots = #reserved.NbrOfLots# + #open.NbrOfLots# + #accepted.NbrOfLots# + #paid.NbrOfLots#>

<cfset request.subTotal = #reserved.sum_offer_reserved_amt# + #open.sum_offer_open_amt# + #accepted.sum_offer_accepted_amt# + #paid.sum_offer_paid_amt#>

<tr>
<td  rowspan="3"><strong>Commercial</strong></td>
<td  colspan="2"><strong>Reserved</strong></td>
<td colspan="2"><strong>Offers Made</strong></td>
<td colspan="2"><strong>Accepted Offers</strong></td>
<td colspan="2"><strong>Paid Offers</strong></td>
<td><strong>Subtotal</strong></td>
</tr>


<tr>
<td>No. of Lots</td>
<td>Reserved Amount</td>
<td>No. of Lots</td>
<td>Offered Amount</td>
<td>No. of Lots</td>
<td>Accepted Amount</td>
<td>No. of Lots</td>
<td>Paid Amount</td>
<!--- <td>&nbsp;</td> --->
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.total_lots# </strong> </td>
</tr>



<tr>
<td>#reserved.NbrOfLots#</td>
<td>#dollarformat(reserved.sum_offer_reserved_amt)#</td>



<td>#open.NbrOfLots#</td>
<td>#dollarformat(open.sum_offer_open_amt)#</td>


<td>#accepted.NbrOfLots#</td>
<td>#dollarformat(accepted.sum_offer_accepted_amt)#</td>



<td>#paid.NbrOfLots#</td>
<td>#dollarformat(paid.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->




<td><strong>#dollarformat(request.subTotal)#</strong></td>
</tr>
<!---</table>
</div>
<p>&nbsp;</p>--->



<tr>
<td colspan="10">&nbsp;</td>
</tr>

<!--- Total of Commercial and Residential --->
<cfquery name="reserved" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum(offer_reserved_amt), 0) as sum_offer_reserved_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_reserved_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_open_amt > 0

 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_accepted_amt > 0
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	

</cfquery>	

<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt) , 0)as sum_offer_paid_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_paid_amt > 0


 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	
</cfquery>

	
<cfset request.T_total_lots = #reserved.NbrOfLots# + #open.NbrOfLots# + #accepted.NbrOfLots# + #paid.NbrOfLots#>


<cfset request.subTotal = #reserved.sum_offer_reserved_amt# + #open.sum_offer_open_amt# + #accepted.sum_offer_accepted_amt# + #paid.sum_offer_paid_amt#>


<!---<div align="center">
<table class= "datatable" style="width: 80%;">--->
<tr>
<td  rowspan="3"><strong>Total</strong></td>
<td  colspan="2"><strong>Reserved</strong></td>
<td colspan="2"><strong>Offers Made</strong></td>
<td colspan="2"><strong>Accepted Offers</strong></td>
<td colspan="2"><strong>Paid Offers</strong></td>
<td><strong>Subtotal</strong></td>
</tr>


<tr>
<td>No. of Lots</td>
<td>Reserved Amount</td>
<td>No. of Lots</td>
<td>Offered Amount</td>
<td>No. of Lots</td>
<td>Accepted Amount</td>
<td>No. of Lots</td>
<td>Paid Amount</td>
<!--- <td>&nbsp;</td> --->
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.T_total_lots# </strong> </td>
</tr>


<tr>
<td>#reserved.NbrOfLots#</td>
<td>#dollarformat(reserved.sum_offer_reserved_amt)#</td>



<td>#open.NbrOfLots#</td>
<td>#dollarformat(open.sum_offer_open_amt)#</td>


<td>#accepted.NbrOfLots#</td>
<td>#dollarformat(accepted.sum_offer_accepted_amt)#</td>



<td>#paid.NbrOfLots#</td>
<td>#dollarformat(paid.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->


<cfset request.subTotal = #reserved.sum_offer_reserved_amt# + #open.sum_offer_open_amt# + #accepted.sum_offer_accepted_amt# + #paid.sum_offer_paid_amt#>

<td><strong>#dollarformat(request.subTotal)#</strong></td>
</tr>
</table>
</div>


<p>&nbsp;</p>

<cfif #request.council_dist# is "ALL">

<cfset request.current_balance = #request.net_balance# - #request.subTotal#>
<cfset request.Prog_allocation_balance = #request.Program_allocation# - #request.subtotal#>

<div style="margin-left:auto;margin-right:auto;width:80%;">
Current Balance = Program Allocation - Total Amount of All Reserved, Offered, Accepted and 
Paid Amounts.<br />
<br />


<p style="background:yellow;border:1px solid maroon;"><strong>Current Balance = $#NumberFormat(request.program_allocation)# - $#NumberFormat(request.subTotal)# = $#NumberFormat(request.Prog_allocation_balance)#</strong></p>
</div>
<br>
</cfif>


<cfquery name="NotValid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
from srr_info

where 
(prop_type <>  'R' and  prop_type <> 'C')
 <cfif #request.council_dist# is not "All">
and dbo.srr_info.council_dist = #request.council_dist#
</cfif>	


</cfquery>	

<cfif #notValid.NbrOfLots# gt 0>
<div style="margin-left:auto;margin-right:auto;width:80%;border:1px solid gray; border-radius:7px;padding:10px;">
<strong>Notes:</strong>
There are #notValid.NbrOfLots# lots that were not included in the above calculations because the lot could not be classified as residential or commercial.
</div>
</cfif>
</cfoutput>

</body>

</html>






<!--- <div style="margin-left:auto;margin-right:auto;width:80%;">
Current Balance = Net Starting Balance - Total Amount of All Reserved, Offered, Accepted and 
Paid Amounts.<br />
<br />


<p style="background:yellow;border:1px solid maroon;"><strong>Current Balance = $#NumberFormat(request.net_balance)# - $#NumberFormat(request.subTotal)# = $#NumberFormat(request.current_balance)#</strong></p>
</div>
<br> --->