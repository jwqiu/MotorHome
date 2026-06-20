<CFPARAM NAME="ATTRIBUTES.Reference" DEFAULT="">

<CFIF NOT Len(ATTRIBUTES.Reference)>
	<CFABORT>
</CFIF>

<CFIF ListFirst(ATTRIBUTES.Reference,"-") EQ "REN">
	<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=renewThankyou">
</CFIF>

<!--- Select all the new listings created by the member 
	- so we know which ones to edit --->
<CFQUERY NAME="Q_Listings" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM Listings
	WHERE LiUUID = '#ListRest(ATTRIBUTES.Reference,"-")#'
</CFQUERY>

<!--- Read all the values from the database --->
<CFLOOP QUERY="Q_Listings">

	<!--- Default them to the values from the database --->
	<CFLOOP LIST="#ColumnList#" INDEX="x">
		<CFPARAM NAME="ATTRIBUTES.#x#_#LiID#" DEFAULT="#Evaluate(x)#">	
	</CFLOOP>
	
	<CFIF Evaluate("ATTRIBUTES.LiMakeAndModel_#LiID#") EQ "Incomplete registration">
		<CFSET "ATTRIBUTES.LiMakeAndModel_#LiID#"="">
	</CFIF>
	
	<!--- Convert the dates into something usable --->
	<CFIF Len(LiFromDate)>
		<CFPARAM NAME="ATTRIBUTES.FromDay_#LiID#" DEFAULT="#Day(LiFromDate)#">
		<CFPARAM NAME="ATTRIBUTES.FromMonth_#LiID#" DEFAULT="#Month(LiFromDate)#">
		<CFPARAM NAME="ATTRIBUTES.FromYear_#LiID#" DEFAULT="#Year(LiFromDate)#">
	<CFELSE>
		<CFPARAM NAME="ATTRIBUTES.FromDay_#LiID#" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.FromMonth_#LiID#" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.FromYear_#LiID#" DEFAULT="">
	</CFIF>
	
	<CFIF Len(LiToDate)>
		<CFPARAM NAME="ATTRIBUTES.ToDay_#LiID#" DEFAULT="#Day(LiToDate)#">
		<CFPARAM NAME="ATTRIBUTES.ToMonth_#LiID#" DEFAULT="#Month(LiToDate)#">
		<CFPARAM NAME="ATTRIBUTES.ToYear_#LiID#" DEFAULT="#Year(LiToDate)#">
	<CFELSE>
		<CFPARAM NAME="ATTRIBUTES.ToDay_#LiID#" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.ToMonth_#LiID#" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.ToYear_#LiID#" DEFAULT="">
	</CFIF>

</CFLOOP>

<CFQUERY NAME="Q_VehicleTypes" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM VehicleTypes
	ORDER BY VeTyID
</CFQUERY>


<!---
FDCDF5F0-9522-11D6-93F50050BA8F9A8D
--->

