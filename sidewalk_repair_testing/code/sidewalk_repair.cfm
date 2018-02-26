<cfparam name="request.fix_shapes" default="0">
<cfparam name="request.tolerance" default="0.1">

<!--- Note: In ArcMap there was a polygon, (not multipolygon) that had a dangling line that wasn't displaying in ArcMap and ArcGIS Server but wouldn't cause ArcGIS Server to bomb out. 
			Looked in ArcMap and the Shape_Area was 0 after I exported from sql server table to geodatabase feature class. So look for these also somehow. --->

<cfset ds="sidewalk_spatial">
<cfset tbl="tblGeocodingTesting">  <!--- **************************** make sure test first (Copy to test table) ********************************8 --->

<cfquery name="getRecords" datasource="#ds#">
	select ObjectID, Shape.STNumGeometries() as Num_Geometries, Shape.STGeometryType() as Shape_Type,  Shape.STAsText() as Original_Shape
    from #tbl#
    where geotype = 'pg'
    and Shape.STGeometryType() IN  ('MultiPolygon','GeometryCollection')
    order by ObjectID
</cfquery>


<cfquery name="getMultiPolygons" dbtype="query">
	select Shape_Type
    from getRecords
    where Shape_Type = 'MultiPolygon'
</cfquery>

<cfquery name="getGeometryCollections" dbtype="query">
	select Shape_Type
    from getRecords
    where Shape_Type = 'GeometryCollection'
</cfquery>

<!--- <cfdump var="#getRecords#"> --->
<!--- <cfdump var="#getMultiPolygons#">
<cfdump var="#getGeometryCollections#">
<cfabort> --->


<cfoutput>

Tolerance: #request.tolerance# <br><br>
<b>Geometry Collections:</b> #getGeometryCollections.recordcount#<br>
<b>MultiPolygons:</b> #getMultiPolygons.recordcount#<br><br>

<cfloop query="getRecords">

    <cfset Shape_Part_List="">
    <cfset bad_polygon = 0>
    
    <cfloop index="i" from="1" to="#Num_Geometries#">
    	<cfquery name="getShapePart" datasource="#ds#">
        	select Shape.STGeometryN(#i#).STArea() as Shape_Area, Shape.STGeometryN(#i#).STAsText() as Shape_Part, Shape.STGeometryN(#i#).STGeometryType() as Shape_Part_Type
            from #tbl#
            where ObjectID = #objectID#
        </cfquery>
        
        <!--- This is a geometry collection which contains a point or line and not a polygon. Skip these. --->
        <cfif getShapePart.Shape_Part_Type neq "Polygon">
			<cfset bad_polygon = 1>
            
        <!--- This is a polygon. Check for slivers which have an area smaller than specified tolerance and don't include in shape --->
        <cfelse>
        	<cfif getShapePart.Shape_Area lt request.tolerance>
                Shape Area: #getShapePart.Shape_Area#<br><br>
                <cfset bad_polygon = 1>
            <cfelse>
                <cfset Shape_Part_List = ListAppend(Shape_Part_List,getShapePart.Shape_Part,"*")>
            </cfif>
        </cfif>
	</cfloop>
    
    <cfif bad_polygon eq 1>
        
        ObjectID: #ObjectID#<br>
        Number of Geometries Before: #Num_Geometries#<br>
        Number of Geometries After: #Listlen(Shape_Part_List,"*")#<br><br>
        Original Shape: #Original_Shape#<br><br>
        #Shape_Part_List#<br><br>
        

        <!--- Polygon --->
        <cfif Listlen(Shape_Part_List,"*") eq 1>
        	<cfset sqlShapeValue="geometry::STGeomFromText('#Shape_Part_List#', 2229).MakeValid()">
            
        <!--- MultiPolygon--->
		<cfelseif ListLen(Shape_Part_List,"*") gt 1>
        	<cfset fixed_shape = ReplaceNoCase(Shape_Part_List,"*",",","all")>
        	<cfset fixed_shape="MULTIPOLYGON (" & ReplaceNoCase(fixed_shape,"POLYGON"," ","all") & ")">
            <cfset sqlShapeValue="geometry::STGeomFromText('#fixed_shape#', 2229).MakeValid()">
            
        <!--- No features, skip --->
        <cfelse>
        	<cfcontinue>
        </cfif>
        
        SQL Server Shape:<br>
        #sqlShapeValue#<br><br><br><br>
        
        <cfif request.fix_shapes eq 1>

            <cfquery name="updateGeometry" datasource="#ds#">
                update #tbl#
                set shape = #PreserveSingleQuotes(sqlShapeValue)#
                where ObjectID = #ObjectID#
            </cfquery>
            
        </cfif>
        
    </cfif>

</cfloop>

<form name="form1" id="form1" method="post">
	Tolerance:&nbsp;<input name="tolerance" id="tolerance" type="text" value="#request.tolerance#"></input><br>
    Fix Geometry:&nbsp;<input name="fix_shapes" id="fix_shapes" type="checkbox" value="1" name="fix_shapes">
    <br><br>
    <input type="submit" value="Sumbit">
</form>

</cfoutput>