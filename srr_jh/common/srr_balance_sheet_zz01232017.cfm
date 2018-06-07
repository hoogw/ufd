<!DOCTYPE html>

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

<cfset request.start_balance = 6000000>
<cfset request.pcontingency = 5>

<cfset request.contingency = #request.pcontingency# * #request.start_balance# / 100>
<cfset request.net_balance = #request.start_balance# - #request.contingency#>

<div style="margin-left:auto;margin-right:auto;width:80%;">
<p>Starting Balance: $#NumberFormat(request.start_balance)# as of 10/24/2016</p>
<p>Contingency: $#NumberFormat(request.contingency)# (#request.pcontingency#% of Starting Blance)</p>
<p>Net Starting Balance: <strong>$#NumberFormat(request.net_balance)#</strong> </p>
<p>A Reserved amount of $2000 or $4000 will be assigned to an application once it is received.</strong></p>
</div>


<!--- Residential --->
<br />
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
<td>&nbsp;</td>
</tr>


<cfquery name="reserved" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum(offer_reserved_amt), 0) as sum_offer_reserved_amt

from srr_info

where 
prop_type = 'R'
and offer_reserved_amt > 0
</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
prop_type = 'R'
and offer_open_amt > 0
</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
prop_type = 'R'
and offer_accepted_amt > 0
</cfquery>	

<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt) , 0)as sum_offer_paid_amt

from srr_info

where 
prop_type = 'R'
and offer_paid_amt > 0
</cfquery>	


<cfset request.subTotal = #reserved.sum_offer_reserved_amt# + #open.sum_offer_open_amt# + #accepted.sum_offer_accepted_amt# + #paid.sum_offer_paid_amt#>

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
<td>&nbsp;</td>
</tr>


<cfquery name="reserved" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_reserved_amt), 0) as sum_offer_reserved_amt

from srr_info

where 
prop_type = 'C'
and offer_reserved_amt > 0
</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
prop_type = 'C'
and offer_open_amt > 0
</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
prop_type = 'C'
and offer_accepted_amt > 0
</cfquery>	

<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt), 0) as sum_offer_paid_amt

from srr_info

where 
prop_type = 'C'
and offer_paid_amt > 0
</cfquery>	


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

<td>#dollarformat(request.subTotal)#</td>
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
</cfquery>	


<cfquery name="open" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_open_amt), 0) as sum_offer_open_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_open_amt > 0
</cfquery>	


<cfquery name="accepted" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_accepted_amt), 0) as sum_offer_accepted_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_accepted_amt > 0
</cfquery>	

<cfquery name="paid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
, ISNULL(sum (offer_paid_amt) , 0)as sum_offer_paid_amt

from srr_info

where 
(prop_type = 'R' or prop_type = 'C')
and offer_paid_amt > 0
</cfquery>	


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
<td>&nbsp;</td>
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

<td>#dollarformat(request.subTotal)#</td>
</tr>
</table>
</div>


<p>&nbsp;</p>

<cfset request.current_balance = #request.net_balance# - #request.subTotal#>

<div style="margin-left:auto;margin-right:auto;width:80%;">
Current Balance = Net Starting Balance - Total Amount of All Reserved, Offered, Accepted and 
Paid Amounts.<br />
<br />


<p style="background:yellow;border:1px solid maroon;"><strong>Current Balance = $#NumberFormat(request.net_balance)# - $#NumberFormat(request.subTotal)# = $#NumberFormat(request.current_balance)#</strong></p>
</div>
<br>

<cfquery name="NotValid" datasource="#request.dsn#" dbtype="datasource">
Select 
count(srr_id) as NbrOfLots
from srr_info

where 
(prop_type <>  'R' and  prop_type <> 'C')
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
