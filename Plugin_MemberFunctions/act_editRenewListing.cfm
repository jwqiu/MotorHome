<CFIF isDefined("ATTRIBUTES.Do_Edit")>

	<CFSET UUID=CreateUUID()>
			
	<CFQUERY NAME="Q_AddUUID" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		UPDATE Listings
		SET LiUUID = '#UUID#'
		WHERE LiMemberLink = #SESSION.SecurityID#
			AND LiID = #ATTRIBUTES.LiID#
	</CFQUERY>
			
	<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=ListingForm&Reference=#UrlEncodedFormat('EDT-#UUID#')#">

<CFELSEIF isDefined("ATTRIBUTES.Do_Renew")>

	<CFSET UUID=CreateUUID()>
			
	<CFQUERY NAME="Q_AddUUID" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		UPDATE Listings
		SET LiUUID = '#UUID#'
		WHERE LiMemberLink = #SESSION.SecurityID#
			AND LiID = #ATTRIBUTES.LiID#
	</CFQUERY>

	<CFQUERY NAME="Q_Details" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings
		WHERE LiID = #ATTRIBUTES.LiID#
	</CFQUERY>
	
	<CFIF (Q_Details.LiExchange EQ 1) OR (Q_Details.LiRent EQ 1)>
		<CFSET TotalPrice = Q_Prices.PrExRnAdd>			
	<CFELSEIF (Q_Details.LiSell EQ 1)>
		<CFSET TotalPrice = Q_Prices.PrSellAdd>			
	<CFELSEIF (Q_Details.LiWantedToBuy EQ 1)>
		<CFSET TotalPrice = Q_Prices.PrWantedBuyAdd>			
	<CFELSEIF (Q_Details.LiWantedToRent EQ 1)>
		<CFSET TotalPrice = Q_Prices.PrWantedRentAdd>			
	</CFIF>
	
	<CFLOCATION URL="https://www.megamall.co.nz/MotorhomeExchange/fusebox.cfm?FuseAction=checkout&Reference=#URLEncodedFormat('REN-#UUID#')#&Name=#URLEncodedFormat(SESSION.SecurityName)#&Email=#UrlEncodedFormat(SESSION.SecurityEmail)#&Total=#URLEncodedFormat(TotalPrice)#" ADDTOKEN="No">

</CFIF>