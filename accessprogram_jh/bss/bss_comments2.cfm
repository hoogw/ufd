<cfinclude template="../common/validate_arKey.cfm">




<cfset request.comment_txt = ReplaceList("#request.comment_txt#","#chr(39)#","#chr(39)##chr(39)#")>




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
'#request.comment_txt#',
#client.staff_user_id#,
#now()#,
#request.ar_id#
)
</cfquery>
<!--- <cfoutput> --->



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