<cfquery name="balanceNow" datasource="#request.dsn#" dbtype="datasource">
Select 
ISNULL(sum(offer_reserved_amt + offer_open_amt + offer_accepted_amt + offer_paid_amt), 0)
AS balanceNow
from srr_info
</cfquery>	

<cfset request.balanceNow =  #request.Program_allocation# - #balanceNow.balanceNow#>

<cfoutput>
#request.balanceNow#
</cfoutput>


<!--- <cfquery name="balanceNow1" datasource="#request.dsn#" dbtype="datasource">
SELECT 
sum(offer_accepted_amt) as accepted_amt
, sum(offer_reserved_amt) as reserved_amt
, sum(offer_open_amt) as open_amt
, sum (offer_paid_amt) as paid_amt

  FROM [srr].[dbo].[srr_info]
  </cfquery>	
  
<cfset request.balanceNow =  #request.Program_allocation# - (#balanceNow1.reserved_amt# + #balanceNow1.accepted_amt# + #balanceNow1.open_amt# + #balanceNow1.paid_amt#)>

<cfoutput>
#request.balanceNow#
</cfoutput> --->
