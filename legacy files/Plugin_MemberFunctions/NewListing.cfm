<CFTRANSACTION>
	<!--- Get new primary key --->
	<CFQUERY NAME="Q_MaxID" DATASOURCE="#ATTRIBUTES.CFG.DS#" CONNECTSTRING="#ATTRIBUTES.CFG.CONNECTSTRING#" DBTYPE="#ATTRIBUTES.CFG.DBTYPE#">
		SELECT MAX(LiID) as MaxID FROM Listings
	</CFQUERY>	
	<CFIF Len(Q_MaxID.MaxID)>
		<CFSET MaxID=Evaluate(Q_MaxID.MaxID+1)>
	<CFELSE>
		<CFSET MaxID=1>
	</CFIF>

	<!--- Add the empty unpaid lisiting --->
	<CFQUERY NAME="Q_DoUnsubscribe" DATASOURCE="#ATTRIBUTES.CFG.DS#" CONNECTSTRING="#ATTRIBUTES.CFG.CONNECTSTRING#" DBTYPE="#ATTRIBUTES.CFG.DBTYPE#">
		INSERT INTO Listings
			(LiID, LiPaid, LiAuthorised, LiMemberLink, LiUUID, LiMakeAndModel,
				LiDateAdded, 
				LiRenewDate,
			#ATTRIBUTES.Types#
			)
		VALUES
			(#MaxID#, 0, 0, #ATTRIBUTES.ID#, '#ATTRIBUTES.Reference#', 'Incomplete registration',
				#CreateODBCDate(Now())#, 
				#CreateODBCDate(DateAdd("yyyy",ATTRIBUTES.Years,Now()))#
			<CFLOOP FROM="1" TO="#ListLen(ATTRIBUTES.Types)#" INDEX="x">
				,1
			</CFLOOP>
			)
	</CFQUERY>		
</CFTRANSACTION>
