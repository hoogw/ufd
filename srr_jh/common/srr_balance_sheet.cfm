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
<!--- <cfset request.start_balance = #request.start_balance#>
<cfset request.pcontingency = #request.contingency#>

<!--- <cfset request.Council_motion_Fund_Transfer = 1180885> --->
<!--- <cfset request.contingency = #request.pcontingency# * #request.start_balance# / 100> --->
<cfset request.net_balance = #request.start_balance# - #request.contingency#>
<cfset request.Program_allocation = #request.net_balance# - #request.council_motion_fund_Transfer#> --->


<div style="margin-left:auto;margin-right:auto;width:80%;"><!--- updated 01/23/2017, old date 10/24/2016--->
<p>Starting Balance: <strong>$#NumberFormat(request.start_balance)#</strong> as of 7/1/2017</p>
<p>FY Allocation (2017/18): <strong>$#NumberFormat(request.fyAllocation)#</strong> as of 7/1/2017</p>
<!--- <p>Contingency: $#NumberFormat(request.contingency)# (#request.pcontingency#% of Starting Blance)</p> --->
<p>Contingency: <strong>$#NumberFormat(request.contingency)#</strong></p>
<!--- <p>Net Starting Balance: <strong>$#NumberFormat(request.net_balance)#</strong> </p>
<p>Council Motion Fund Transfer: $#numberformat(request.council_motion_fund_transfer)# as of 01/18/2017</p> --->
<p>Program Allocation: <strong>$#Numberformat(request.Program_Allocation)#</strong></p>

<cfquery name="readRates" datasource="#request.dsn#" dbtype="datasource">
SELECT rate_nbr, res_cap_amt, comm_cap_amt, ddate_implemented
from rebate_rates
order by rate_nbr
</cfquery>

<cfloop query="readRates">
<p>Under Rebate Rate No. #readRates.rate_nbr#: The rebate cap was $#NumberFormat(readRates.res_cap_amt)# (for Residential properties) and  $#NumberFormat(readRates.comm_cap_amt)# (for Commercial Properties).</strong></p>
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
	
	
	
	
<cfquery name="reserved_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfquery name="open_Rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfquery name="accepted_rate1" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 1

</cfquery>	

<cfquery name="paid_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	

<cfset request.total_lots_rate1 = #reserved_Rate1.NbrOfLots# + #open_rate1.NbrOfLots# + #accepted_rate1.NbrOfLots# + #paid_rate1.NbrOfLots#>
<cfset request.subTotal_Rate1 = #reserved_rate1.sum_offer_reserved_amt# + #open_rate1.sum_offer_open_amt# + #accepted_rate1.sum_offer_accepted_amt# + #paid_rate1.sum_offer_paid_amt#>



<!--- Residential --->
<!--- <br /> --->
<br />




<div align="center">
<div class = "subtitle" style="text-align:left;width:80%;">Rebate Applications Under Rate Number 1</div>
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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.total_lots_rate1# </strong> </td>
</tr>



<tr>


<td>#reserved_rate1.NbrOfLots#</td>
<td>#dollarformat(reserved_rate1.sum_offer_reserved_amt)#</td>



<td>#open_rate1.NbrOfLots#</td>
<td>#dollarformat(open_rate1.sum_offer_open_amt)#</td>


<td>#accepted_rate1.NbrOfLots#</td>
<td>#dollarformat(accepted_rate1.sum_offer_accepted_amt)#</td>



<td>#paid_rate1.NbrOfLots#</td>
<td>#dollarformat(paid_rate1.sum_offer_paid_amt)#</td>

<!--- <cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'R'
</cfquery>	 --->

<td><strong>#dollarformat(request.subTotal_Rate1)#</strong></td>
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




<cfquery name="reserved_comm_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfquery name="open_comm_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfquery name="accepted_comm_rate1" datasource="#request.dsn#" dbtype="datasource">
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
	and rate_nbr = 1


</cfquery>	


<cfquery name="paid_comm_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfset request.total_lots_comm_rate1 = #reserved_comm_rate1.NbrOfLots# + #open_comm_rate1.NbrOfLots# + #accepted_comm_rate1.NbrOfLots# + #paid_comm_rate1.NbrOfLots#>

<cfset request.subTotal_comm_rate1 = #reserved_comm_rate1.sum_offer_reserved_amt# + #open_comm_rate1.sum_offer_open_amt# + #accepted_comm_rate1.sum_offer_accepted_amt# + #paid_comm_rate1.sum_offer_paid_amt#>

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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.total_lots_comm_rate1# </strong> </td>
</tr>



<tr>
<td>#reserved_comm_rate1.NbrOfLots#</td>
<td>#dollarformat(reserved_comm_rate1.sum_offer_reserved_amt)#</td>




<td>#open_comm_rate1.NbrOfLots#</td>
<td>#dollarformat(open_comm_rate1.sum_offer_open_amt)#</td>


<td>#accepted_comm_rate1.NbrOfLots#</td>
<td>#dollarformat(accepted_comm_rate1.sum_offer_accepted_amt)#</td>



<td>#paid_comm_rate1.NbrOfLots#</td>
<td>#dollarformat(paid_comm_rate1.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->




<td><strong>#dollarformat(request.subTotal_comm_rate1)#</strong></td>
</tr>
<!---</table>
</div>
<p>&nbsp;</p>--->




<tr>
<td colspan="10">&nbsp;</td>
</tr>



<!--- Total of Commercial and Residential --->
<cfquery name="reserved_comm_res_rate1" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 1

</cfquery>	


<cfquery name="open_comm_res_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	


<cfquery name="accepted_comm_res_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1

</cfquery>	

<cfquery name="paid_comm_res_rate1" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 1


</cfquery>

	
<cfset request.T_total_lots_comm_res_rate1 = #reserved_comm_res_rate1.NbrOfLots# + #open_comm_res_rate1.NbrOfLots# + #accepted_comm_res_rate1.NbrOfLots# + #paid_comm_res_rate1.NbrOfLots#>


<cfset request.subTotal_comm_res_rate1 = #reserved_comm_res_rate1.sum_offer_reserved_amt# + #open_comm_res_rate1.sum_offer_open_amt# + #accepted_comm_res_rate1.sum_offer_accepted_amt# + #paid_comm_res_rate1.sum_offer_paid_amt#>


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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.T_total_lots_comm_res_rate1# </strong> </td>
</tr>


<tr>
<td>#reserved_comm_res_rate1.NbrOfLots#</td>
<td>#dollarformat(reserved_comm_res_rate1.sum_offer_reserved_amt)#</td>



<td>#open_comm_res_rate1.NbrOfLots#</td>
<td>#dollarformat(open_comm_res_rate1.sum_offer_open_amt)#</td>


<td>#accepted_comm_res_rate1.NbrOfLots#</td>
<td>#dollarformat(accepted_comm_res_rate1.sum_offer_accepted_amt)#</td>



<td>#paid_comm_res_rate1.NbrOfLots#</td>
<td>#dollarformat(paid_comm_res_rate1.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->


<cfset request.subTotal_comm_res_rate1 = #reserved_comm_res_rate1.sum_offer_reserved_amt# + #open_comm_res_rate1.sum_offer_open_amt# + #accepted_comm_res_rate1.sum_offer_accepted_amt# + #paid_comm_res_rate1.sum_offer_paid_amt#>

<td><strong>#dollarformat(request.subTotal_comm_res_rate1)#</strong></td>
</tr>
</table>
</div>


<p>&nbsp;</p>

<!--- <cfif #request.council_dist# is "ALL">

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
 --->
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

<!--- Rate NBR 2 --->


<!---
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
	
	---->



<cfoutput>
<!---  <div align="center"> --->
	
	
<cfquery name="res_reserved_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	


<cfquery name="Res_open_rate2" datasource="#request.dsn#" dbtype="datasource">
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
 and rate_nbr = 2
</cfquery>	


<cfquery name="Res_accepted_rate2" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 2
</cfquery>	

<cfquery name="Res_paid_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	

<cfset request.Res_total_lots_rate2 = #res_reserved_rate2.NbrOfLots# + #res_open_rate2.NbrOfLots# + #res_accepted_rate2.NbrOfLots# + #res_paid_rate2.NbrOfLots#>
<cfset request.Res_subTotal_rate2 = #Res_reserved_rate2.sum_offer_reserved_amt# + #res_open_rate2.sum_offer_open_amt# + #res_accepted_rate2.sum_offer_accepted_amt# + #Res_paid_rate2.sum_offer_paid_amt#>



<!--- Residential --->
<!--- <br /> --->
<br />







<!--- <div align="center"> --->
<div class = "subtitle" style="text-align:left;width:80%;">Rebate Applications Under Rate Number 2</div>
<table class= "datatable" style="width: 80%;">
<!--- <TR>
<th colspan="13"><!--- Rebate Rate No. 2 ---></th>
</TR> --->



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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.Res_total_lots_rate2# </strong> </td>
</tr>



<tr>


<td>#res_reserved_rate2.NbrOfLots#</td>
<td>#dollarformat(res_reserved_rate2.sum_offer_reserved_amt)#</td>



<td>#res_open_rate2.NbrOfLots#</td>
<td>#dollarformat(res_open_rate2.sum_offer_open_amt)#</td>


<td>#res_accepted_rate2.NbrOfLots#</td>
<td>#dollarformat(res_accepted_rate2.sum_offer_accepted_amt)#</td>



<td>#res_paid_rate2.NbrOfLots#</td>
<td>#dollarformat(res_paid_rate2.sum_offer_paid_amt)#</td>

<!--- <cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'R'
</cfquery>	 --->

<td><strong>#dollarformat(request.Res_subTotal_rate2)#</strong></td>
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




<cfquery name="Comm_reserved_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	


<cfquery name="Comm_open_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	


<cfquery name="comm_accepted_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	


<cfquery name="comm_paid_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	


<cfset request.comm_total_lots_rate2 = #comm_reserved_Rate2.NbrOfLots# + #comm_open_rate2.NbrOfLots# + #comm_accepted_rate2.NbrOfLots# + #comm_paid_Rate2.NbrOfLots#>

<cfset request.comm_subTotal_rate2 = #comm_reserved_Rate2.sum_offer_reserved_amt# + #comm_open_rate2.sum_offer_open_amt# + #comm_accepted_rate2.sum_offer_accepted_amt# + #comm_paid_rate2.sum_offer_paid_amt#>

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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.comm_total_lots_rate2# </strong> </td>
</tr>



<tr>
<td>#comm_reserved_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_reserved_rate2.sum_offer_reserved_amt)#</td>



<td>#comm_open_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_open_rate2.sum_offer_open_amt)#</td>


<td>#comm_accepted_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_accepted_rate2.sum_offer_accepted_amt)#</td>



<td>#comm_paid_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_paid_rate2.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->




<td><strong>#dollarformat(request.comm_subTotal_rate2)#</strong></td>
</tr>
<!---</table>
</div>
<p>&nbsp;</p>--->



<tr>
<td colspan="10">&nbsp;</td>
</tr>

<!--- Total of Commercial and Residential --->
<cfquery name="comm_res_reserved_rate2" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 2
</cfquery>	


<cfquery name="comm_res_open_rate2" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 2
</cfquery>	


<cfquery name="comm_res_accepted_rate2" datasource="#request.dsn#" dbtype="datasource">
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
and rate_nbr = 2
</cfquery>	

<cfquery name="comm_res_paid_rate2" datasource="#request.dsn#" dbtype="datasource">
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

and rate_nbr = 2
</cfquery>

	
<cfset request.comm_res_T_total_lots_rate2 = #comm_Res_reserved_rate2.NbrOfLots# + #comm_res_open_rate2.NbrOfLots# + #comm_res_accepted_rate2.NbrOfLots# + #comm_res_paid_rate2.NbrOfLots#>


<cfset request.comm_res_subTotal_rate2 = #comm_res_reserved_rate2.sum_offer_reserved_amt# + #comm_res_open_rate2.sum_offer_open_amt# + #comm_res_accepted_rate2.sum_offer_accepted_amt# + #comm_res_paid_rate2.sum_offer_paid_amt#>


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
<td valign="top" nowrap>No. of Lots:<BR><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #request.comm_res_T_total_lots_rate2# </strong> </td>
</tr>


<tr>
<td>#comm_res_reserved_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_res_reserved_Rate2.sum_offer_reserved_amt)#</td>



<td>#comm_res_open_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_res_open_rate2.sum_offer_open_amt)#</td>


<td>#comm_res_accepted_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_res_accepted_rate2.sum_offer_accepted_amt)#</td>



<td>#comm_res_paid_rate2.NbrOfLots#</td>
<td>#dollarformat(comm_res_paid_rate2.sum_offer_paid_amt)#</td>

<!---<cfquery name="subTotal" datasource="#request.dsn#" dbtype="datasource">
Select 
(Sum(offer_reserved_amt) + SUM(offer_open_amt) + SUM(offer_accepted_amt) + SUM(offer_paid_amt)) as subTotal

from srr_info

where 
prop_type = 'C'
</cfquery>	--->


<cfset request.comm_res_subTotal_rate2 = #comm_res_reserved_rate2.sum_offer_reserved_amt# + #comm_res_open_Rate2.sum_offer_open_amt# + #comm_res_accepted_rate2.sum_offer_accepted_amt# + #comm_res_paid_rate2.sum_offer_paid_amt#>

<td><strong>#dollarformat(request.comm_res_subTotal_rate2)#</strong></td>
</tr>
</table>
<!--- </div> --->


<p>&nbsp;</p>





</cfoutput>


<Cfset request.subtotal_rt1_rt2 =  #request.subTotal_comm_res_rate1#+#request.comm_res_subtotal_rate2# >









































<p>&nbsp;</p>

 <cfif #request.council_dist# is "ALL">

<cfset request.current_balance = #request.net_balance# - #request.subTotal_rt1_rt2#>
<cfset request.Prog_allocation_balance = #request.Program_allocation# - #request.subTotal_rt1_rt2#>

<div style="margin-left:auto;margin-right:auto;width:80%;">
Current Balance = Program Allocation - Total Amount of All Reserved, Offered, Accepted and 
Paid Amounts.<br />
<br />


<p style="background:yellow;border:1px solid maroon;"><strong>Current Balance = $#NumberFormat(request.program_allocation)# - $#NumberFormat(request.subTotal_rt1_rt2)# = $#NumberFormat(request.Prog_allocation_balance)#</strong></p>
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