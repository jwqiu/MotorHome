<!--- Members (and new members) only --->
<CFIF NOT Len(SESSION.SecurityEmail) and NOT Len(SESSION.SecurityPassword) 
		and NOT isDefined("SESSION.NewMember")>
	<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=MemberLogin&RFA=#URLEncodedFormat(REQUEST.Back)#">
</CFIF>

<CFPARAM NAME="ATTRIBUTES.ExchangeRateCode" DEFAULT="USD">
<CFPARAM NAME="ATTRIBUTES.ExchangeYears" DEFAULT="0">
<CFPARAM NAME="ATTRIBUTES.RentYears" DEFAULT="0">
<CFPARAM NAME="ATTRIBUTES.SellYears" DEFAULT="0">
<CFPARAM NAME="ATTRIBUTES.WTBYears" DEFAULT="0">
<CFPARAM NAME="ATTRIBUTES.WTRYears" DEFAULT="0">
<CFPARAM NAME="ATTRIBUTES.ActionType" DEFAULT="NEW">

<!--- Do exchange rate look up --->
<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="exchangeRate" 
	FROM="NZD" TO="#ATTRIBUTES.ExchangeRateCode#" />
<CFSET ATTRIBUTES.ExchangeRate = CFMODULE.ATTRIBUTES.ExchangeRate>

<CFQUERY NAME="Q_FreeAccounts" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM FreeAccounts
	WHERE FrAcID = 1
</CFQUERY>

<!--- Do the prices look up --->
<CFQUERY NAME="Q_Prices" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM Prices
	WHERE PrID = 1
</CFQUERY>


<!--- Check if we're giving away any acccouts. If so, set the
	- prices to $0 --->
<CFIF Q_FreeAccounts.FrAcAmount GT 0>

	<CFSCRIPT>
		QuerySetCell(Q_Prices,"PrExRnOneYear",0);
		QuerySetCell(Q_Prices,"PrSellFirst",0);
		QuerySetCell(Q_Prices,"PrWantedBuyFirst",0);
		QuerySetCell(Q_Prices,"PrWantedRentFirst",0);
	</CFSCRIPT>
	
</CFIF>

<!--- Figure out whether the member has existing listings of various types --->
<CFSET HasExchangeRent=0>
<CFSET HasSell=0>
<CFSET HasWantedToBuy=0>
<CFSET HasWantedToRent=0>
<CFIF Len(SESSION.SecurityID)>

	<CFQUERY NAME="Q_Check" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings
		Where LiMemberLink = #SESSION.SecurityID#	
			AND LiAuthorised = 1
			AND #CreateODBCDate(Now())# <= LiRenewDate
	</CFQUERY>

	<CFLOOP QUERY="Q_Check">
		<CFIF LiExchange EQ 1><CFSET HasExchangeRent=1></CFIF>
		<CFIF LiRent EQ 1><CFSET HasExchangeRent=1></CFIF>
		<CFIF LiSell EQ 1><CFSET HasSell=1></CFIF>
		<CFIF LiWantedToBuy EQ 1><CFSET HasWantedToBuy=1></CFIF>
		<CFIF LiWantedToRent EQ 1><CFSET HasWantedToRent=1></CFIF>
	</CFLOOP>
	
</CFIF>
