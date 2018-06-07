<cfinclude template="../common/validate_arKey.cfm">
<cfinclude template="../common/myCFfunctions.cfm">



<cfquery name="addComment" datasource="#request.dsn#" dbtype="ODBC">
insert into dod_comments
(
comment_txt,
comment_by,
comment_ddate,
ar_id
)

values

(
'#toSqlText(request.comment_txt)#',
#client.staff_user_id#,
#now()#,
#request.ar_id#
)
</cfquery>


<cfquery name="updateHistory" datasource="#request.dsn#" dbtype="ODBC">
Update ar_info
set
record_history = record_history + '|A comment was added by #client.full_name# on #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"h:mm tt")#'
where arKey = '#request.arKey#'
</cfquery>

<cflocation addtoken="No" url="control.cfm?action=process_app1&arKey=#request.arKey#&#request.addtoken#">
<cfabort>



<!--- delete everything below this line --->












<cfoutput>
<div class="warning">
Your Comment was Save Successfully
</div><br>
</cfoutput>

<cfoutput>
<form action="control.cfm?action=process_app1&arKey=#request.arKey#&#request.addtoken#" method="post" name="form1" id="form1">
<input type="hidden" name="arKey" id="arKey" value="#request.arKey#">

<div align="center"><input type="submit" name="submit" id="submit" value="Back"></div>
</form>

</cfoutput>

<!--- </cfoutput> ---><!--- #client.staff_user_id# --->

<!--- SELECT TOP 1000 [comment_id]
      ,[ar_id]
      ,[comment_txt]
      ,[comment_by]
      ,[comment_ddate]
  FROM [accessprogram].[dbo].[dod_comments] --->