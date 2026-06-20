<CFPARAM NAME="ATTRIBUTES.Reference" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.Pass" DEFAULT="">

<CFIF (ATTRIBUTES.Pass EQ Hash(CFG.AdminPassword)) AND Len(ATTRIBUTES.Reference)>
	
	<CFSET ActionType=ListFirst(ATTRIBUTES.Reference,"-")>

	<CFIF (ActionType EQ "NEW") OR (ActionType EQ "ADD")>
		<!--- NEW MEMBER --->

		<!--- Mark all listings with the supplied UUID as paid --->	
		<CFQUERY NAME="Q_MarkListingsAsPaid" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			UPDATE Listings
			SET LiPaid = 1
			WHERE LiUUID = '#ListRest(ATTRIBUTES.Reference,"-")#'
		</CFQUERY>

		<!--- Get the MeID of the member who created the listings --->	
		<CFQUERY NAME="Q_MemberLink" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT LiMemberLink FROM Listings
			WHERE LiUUID = '#ListRest(ATTRIBUTES.Reference,"-")#'
		</CFQUERY>

		<!--- Mark the member with the listings as Paid/Activated --->
		<CFQUERY NAME="Q_MarkMemberAsPaid" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			UPDATE Members 
			SET MeActivate = 1
			WHERE MeID = #Q_MemberLink.LiMemberLink#
		</CFQUERY>
	<CFELSE>
		<!--- RENEW LISTING --->

		<!--- Get details of the listing --->	
		<CFQUERY NAME="Q_Details" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT * FROM Listings
			WHERE LiUUID = '#ListRest(ATTRIBUTES.Reference,"-")#'
		</CFQUERY>
		
		<CFQUERY NAME="Q_Update" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			UPDATE Listings
			SET LiRenewDate = #CreateODBCDate(DateAdd("yyyy",1,Q_Details.LiRenewDate))#,
				LiUUID = NULL
			WHERE LiID = #Q_Details.LiID#
		</CFQUERY>
	
	</CFIF>

</CFIF>
