<cfinclude template="../common/validate_srrKey.cfm">
<cfinclude template="../common/getSrrID.cfm">
<cfinclude template="../common/myCFfunctions.cfm">

<cfset request.comment_txt = ReplaceList("#request.comment_txt#","#chr(39)#","#chr(39)##chr(39)#")>

<cfquery name="addComment" datasource="#request.dsn#" dbtype="ODBC">
insert into bca_comments
(
comment_txt,
comment_by,
comment_ddate,
srr_id
)

values

(
'#request.comment_txt#',
#client.staff_user_id#,
#now()#,
#request.srr_id#
)
</cfquery>

<cflocation addtoken="No" url="list_comments.cfm?srrKey=#request.srrKey#&#request.addtoken#">

