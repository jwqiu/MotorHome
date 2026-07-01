<!--- Members only --->
<CFIF NOT Len(SESSION.SecurityEmail) and NOT Len(SESSION.SecurityPassword)>
	<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=MemberLogin&RFA=#URLEncodedFormat(REQUEST.Back)#">
</CFIF>

<CFPARAM NAME="ATTRIBUTES.LiID" DEFAULT="-1">

<!--- Select the listings to display --->
<CFQUERY NAME="Q_Listings" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM Listings
	WHERE LiMemberLink = #SESSION.SecurityID#
		AND #CreateODBCDate(Now())# <= LiRenewDate
	ORDER BY LiMakeAndModel, LiID
</CFQUERY>

<CFQUERY NAME="Q_Prices" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	SELECT * FROM Prices
	WHERE PrID = 1
</CFQUERY>