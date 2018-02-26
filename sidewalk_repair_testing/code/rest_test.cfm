<!doctype html>

<html>
<head>
	<title>Empower LA Test</title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
</head>

<!--- <cfhttp url="https://www.arcgis.com/sharing/oauth2/token" method="get">
	<cfhttpparam type="URL" name="client_id" value="0Cr0WSHvv1SCbzNS" encoded="no"> 
	<cfhttpparam type="URL" name="client_secret" value="526dbda78e0a4a7ba54242bfd076762f" encoded="no"> 
	<cfhttpparam type="URL" name="grant_type" value="client_credentials" encoded="no"> 
</cfhttp>
<cfdump var="#cfhttp#">
<br> --->
<!--- <cfoutput>#cfhttp.filecontent#</cfoutput> --->

<cfset dt = Now()>
<cfset dt = dateformat(dt,"MM/DD/YYYY") & " " & timeformat(dt,"HH:mm:ss")>


<script>
var token = "";

function doTest() {

	var frm = [];
	frm.push({"name" : "client_id", "value" : "0Cr0WSHvv1SCbzNS" });
	frm.push({"name" : "client_secret", "value" : "526dbda78e0a4a7ba54242bfd076762f" });
	frm.push({"name" : "grant_type", "value" : "client_credentials" });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "https://www.arcgis.com/sharing/oauth2/token",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON($.trim(data));
	  	console.log(data);
		token = data.access_token;
		console.log(token);
		
	  }
	});

}

function doTest2() {

	var frm = [];
	frm.push({"name" : "token", "value" : token });
	frm.push({"name" : "f", "value" : "pjson" });
	//console.log(frm);
	
	$.ajax({
	  type: "POST",
	  url: "http://services.arcgis.com/04HiymDgLlsbhaV4/arcgis/rest/services/LA_Sidewalk_v2/FeatureServer",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON($.trim(data));
	  	console.log(data);
		
	  }
	});

}

function doTest3() {

	<cfoutput>
	var dt = "#dt#";
	</cfoutput>
	
	var attr = {};
	attr.OBJECTID = 4;
	attr.Download_Date = dt;
	var feat = {};
	feat.attributes = attr;
	feat = '[' + JSON.stringify(feat) + ']';
	
	//console.log(feat);
	
	var frm = [];
	frm.push({"name" : "token", "value" : token });
	frm.push({"name" : "f", "value" : "pjson" });
	frm.push({"name" : "Features", "value" : feat });
	//console.log(frm);

	
	$.ajax({
	  type: "POST",
	  url: "http://services.arcgis.com/04HiymDgLlsbhaV4/ArcGIS/rest/services/LA_Sidewalk_v2/FeatureServer/0/updateFeatures",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON($.trim(data));
	  	console.log(data);
		
	  }
	});

}

function doTest4() {

	
	
	var frm = [];
	frm.push({"name" : "token", "value" : token });
	frm.push({"name" : "f", "value" : "pjson" });
	frm.push({"name" : "where", "value" : "0=0" });
	frm.push({"name" : "outFields", "value" : "*" });
	console.log(frm);

	
	$.ajax({
	  type: "POST",
	  url: "http://services.arcgis.com/04HiymDgLlsbhaV4/ArcGIS/rest/services/LA_Sidewalk_v2/FeatureServer/0/query",
	  data: frm,
	  success: function(data) { 
	  	data = jQuery.parseJSON($.trim(data));
	  	console.log(data);
		
		/*$.each(data.fields, function( i, item ) {
  			//console.log(item.name);
			

			$.each(data.features, function( j, item2 ) {
  				//console.log(item2.attributes[item.name]);
				var frm = [];
				
				frm.push({"name" : item.name, "value" : item2.attributes[item.name] });
				

			});
			
			console.log(frm);
		}); */
		
		
		$.each(data.features, function( i, item ) {
  			//console.log(item.name);
			
			frm = [];

			$.each(data.fields, function( j, item2 ) {
  				//console.log(item2.attributes[item.name]);
				
				frm.push({"name" : item2.name, "value" : item.attributes[item2.name] });
				

			});
			
			console.log(frm);
		});
		
		
		
		
	  }
	});

}

</script>

<body>

<input onclick="doTest();return false;" style="width: 100px; height: 28px;" type="Button" value="Get Token" tabindex="2" title="Search Button" alt="Search Button" name="go" />
<br><br>
<input onclick="doTest2();return false;" style="width: 100px; height: 28px;" type="Button" value="Get Info" tabindex="2" title="Search Button" alt="Search Button" name="go" />

<br><br>
<input onclick="doTest3();return false;" style="width: 100px; height: 28px;" type="Button" value="Update Date" tabindex="2" title="Search Button" alt="Search Button" name="go" />

<br><br>
<input onclick="doTest4();return false;" style="width: 100px; height: 28px;" type="Button" value="Query Data" tabindex="2" title="Search Button" alt="Search Button" name="go" />
<br><br>

<!--- RETRIEVE THE TOKEN --->
<cfhttp url="https://www.arcgis.com/sharing/oauth2/token" proxyserver="bcproxy.ci.la.ca.us" proxyport="8080" method="post">
	<cfhttpparam type="formfield" name="client_id" value="0Cr0WSHvv1SCbzNS" encoded="yes"> 
	<cfhttpparam type="formfield" name="client_secret" value="526dbda78e0a4a7ba54242bfd076762f" encoded="yes"> 
	<cfhttpparam type="formfield" name="grant_type" value="client_credentials" encoded="yes"> 
</cfhttp>
<!--- <cfdump var="#cfhttp#"> --->

<cfset data =  DeserializeJSON(cfhttp.filecontent)>
<cfset tkn = data.access_token>


<!--- <cfdump var="#data#"> --->

<cfset arrLyrs = arrayNew(1)>
<cfset arrLyrs[1] = "tbl_ArcLocations">
<cfset arrLyrs[2] = "tbl_ArcCurbRamp">
<cfset arrLyrs[3] = "tbl_ArcSidewalkRepair">
<cfset arrLyrs[4] = "tbl_ArcCurbRepair">
<cfset arrLyrs[5] = "tbl_ArcFeatures">
<cfset arrLyrs[6] = "NULL">
<cfset arrLyrs[7] = "tbl_ArcTreeLandscape">
<cfset arrLyrs[8] = "tbl_ArcMiscellaneous">
<cfset arrLyrs[9] = "tbl_ArcSiteCharacteristics">
<cfset arrLyrs[10] = "tbl_ArcUtility">

<cfloop index="a" from="1" to="#arrayLen(arrLyrs)#">

	<cfif arrLyrs[a] is not "NULL">

		<!--- RETRIEVE INFORMATION FROM THE TABLE (Locations) --->
		<cfhttp url="http://services.arcgis.com/04HiymDgLlsbhaV4/ArcGIS/rest/services/LA_Sidewalk_v2/FeatureServer/#a-1#/query"
		proxyserver="bcproxy.ci.la.ca.us" proxyport="8080" method="post">
			<cfhttpparam type="formfield" name="token" value="#tkn#" encoded="yes"> 
			<cfhttpparam type="formfield" name="f" value="pjson" encoded="yes"> 
			<cfhttpparam type="formfield" name="where" value="0=0" encoded="yes"> 
			<cfhttpparam type="formfield" name="outFields" value="*" encoded="yes"> 
		</cfhttp>
		<!--- <cfdump var="#cfhttp#"> --->
		
		<cfset data =  DeserializeJSON(cfhttp.filecontent)>
		
		<!--- <cfdump var="#data#"> --->
		
		<cfset flds = data.fields>
		<cfset recs = data.features>
		
		<cfset geotype = "">
		<cfif isdefined("data.geometryType")>
			<cfset geo = data.geometryType>
			<cfif geo is "esriGeometryPoint"><cfset geotype = "pt">
			<cfelseif geo is "esriGeometryPolygon"><cfset geotype = "pg">
			<cfelse><cfset geotype = "pl"></cfif>
		</cfif>
		
		<cfset tbl = arrLyrs[a]>
		
		<cfquery name="clearTable" datasource="#request.sqlconn#">
		TRUNCATE TABLE #tbl#
		</cfquery>
		
		<cfset arrFlds = arrayNew(1)>
		<cfset istr = "INSERT INTO #tbl# (">
		<cfloop index="i" from="1" to="#arrayLen(flds)#">
			<cfset item = flds[i]>
			<cfset nm = item.name>
			<cfif nm is "Curb_Legnth"><cfset nm = "Curb_Length"></cfif>
			<cfif nm is "TemporaryDrainageIntetProtectio"><cfset nm = "TemporaryDrainageIntetProtection"></cfif>
			<cfif nm is "Location_ID"><cfset nm = "Location_No"></cfif>
			<cfset istr = istr & nm & ",">
			<cfset arrFlds[i][1] = item.name>
			<cfset arrFlds[i][2] = item.type>
		</cfloop>
		<cfif geotype is not "">
			<cfset istr = left(istr,len(istr)-1) & ",Shape) VALUES (">
		<cfelse>
			<cfset istr = left(istr,len(istr)-1) & ") VALUES (">
		</cfif>
		
		<cfloop index="i" from="1" to="#arrayLen(recs)#">
			<cfset item = recs[i]>
			<cfset attrs = item.attributes>
			<cfif geotype is not "">
				<cfset geom = item.geometry>
				<!--- <cfdump var="#geom#"> --->
			</cfif>
			<!--- <cfdump var="#attrs#"> --->
			
			<cfset qstr = "">
			<cfloop index="j" from="1" to="#arrayLen(arrFlds)#">
				<cftry>
					<cfset v = evaluate("attrs." & arrFlds[j][1])>
					<cfif arrFlds[j][2] is "esriFieldTypeString" OR arrFlds[j][2] is "esriFieldTypeGlobalID"
					OR arrFlds[j][2] is "esriFieldTypeGUID">
						<cfset v = "'" & replace(v,"'","''","ALL") & "'">
					<cfelseif arrFlds[j][2] is "esriFieldTypeDate">
						<cfset v = DateAdd("s", v/1000, "January 1 1970 00:00")> 			
						<!--- <cfset v = DateAdd("s", v/1000, DateConvert("utc2Local", "January 1 1970 00:00"))> 	 --->
					</cfif>
				<cfcatch>
					<cfset v = "NULL">
				</cfcatch>
				</cftry>
				<!--- <cfdump var="#v#"><br> --->
				
				<cfset qstr = qstr & v & ",">
			</cfloop>
			
			<cfif geotype is not "">
				<cfset geoms = "{""geometryType"":""#geo#"",""geometries"":[#SerializeJSON(geom)#]}">
				<!--- <cfdump var="#geoms#"> --->
			
				<!--- GET reprojected geometry --->
				<cfhttp  result="getgeo" url="http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer/project"
				proxyserver="bcproxy.ci.la.ca.us" proxyport="8080" method="post">
					<cfhttpparam type="formfield" name="f" value="pjson" encoded="yes"> 
					<cfhttpparam type="formfield" name="inSR" value="102100" encoded="yes"> 
					<cfhttpparam type="formfield" name="outSR" value="2229" encoded="yes"> 
					<cfhttpparam type="formfield" name="geometries" value=#geoms# encoded="yes"> 
				</cfhttp>
				<!--- <br><cfdump var="#getgeo.Filecontent#"><br> --->
				
				
				<cfset newgeo = DeserializeJSON(getgeo.filecontent)>
				<cfset newgeo = newgeo.geometries[1]>
				<!--- <cfdump var="#newgeo#"> --->
			</cfif>
			
			<cfswitch expression="#geotype#">
				<cfcase value="pt">
					<cfset coords = (newgeo.x+3.66) & " " & (newgeo.y+1.78)>
					<cfset shapeValue="geometry::STGeomFromText('POINT(#coords#)', 4326)">
				</cfcase>
				<cfcase value="pl">
					<cfset coords = "">
					<cfset newgeo = newgeo.paths[1]>
					<!--- <cfdump var="#newgeo#"> --->
					<cfloop index="m" from="1" to="#arrayLen(newgeo)#">
						<cfset coords = coords & (newgeo[m][1]+3.66) & " " & (newgeo[m][2]+1.78) & ",">
					</cfloop>
					<cfset coords = left(coords,len(coords)-1)>
					<!--- <cfdump var="#coords#"> --->
					<cfset shapeValue="geometry::STGeomFromText('LINESTRING(#coords#)', 4326).MakeValid()">
				</cfcase>
				<cfcase value="pg">
					<cfset coords = "">
					<cfset newgeo = newgeo.rings[1]>
					<!--- <cfdump var="#newgeo#"> --->
					<cfloop index="m" from="1" to="#arrayLen(newgeo)#">
						<cfset coords = coords & (newgeo[m][1]+3.66) & " " & (newgeo[m][2]+1.78) & ",">
					</cfloop>
					<cfset coords = left(coords,len(coords)-1)>
					<!--- <cfdump var="#coords#"> --->
					<cfset shapeValue="geometry::STGeomFromText('POLYGON((#coords#))', 4326).MakeValid()">
				</cfcase>
			</cfswitch>
			
			<cfif geotype is not "">
				<!--- <br><cfdump var="#shapeValue#"> --->
				<cfset qstr = istr & left(qstr,len(qstr)-1) & "," & shapeValue & ")">
			<cfelse>
				<cfset qstr = istr & left(qstr,len(qstr)-1) & ")">
			</cfif>
			<!--- <cfdump var="#qstr#"> --->
			
			
			<cfquery name="addRecords" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
		</cfloop>
		
		<cfoutput>#tbl# - #TimeFormat(Now(),"hh:mm:ss")#<br></cfoutput>

	</cfif>

</cfloop>
<!--- 
<br><br>
<cfdump var="#geotype#"><br>
<cfdump var="#istr#">
<cfdump var="#arrFlds#">
<cfdump var="#recs#"> --->

<!--- <cfdump var="#flds#">
<cfdump var="#recs#"> --->

</body>
</html>
