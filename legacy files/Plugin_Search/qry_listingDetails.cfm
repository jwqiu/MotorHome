<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.LiID" DEFAULT="-1">

	<CFQUERY NAME="Q_Details" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings, Members, Countries, States, Cities, VehicleTypes
		WHERE LiID = #ATTRIBUTES.LiID#
			AND MeID = LiMemberLink
			AND MeCountryLink = CntID
			AND MeStateLink = StID
			AND MeCityLink = CiID
			AND LiVehicleTypeLink = VeTyID
	</CFQUERY>

<!---
	<CFQUERY NAME="Q_Images" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM VehicleImages
		WHERE VeImVehicleLink = #ATTRIBUTES.LiID#
	</CFQUERY>
--->	
	
	
</CFSILENT>

