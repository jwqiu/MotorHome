<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFTRANSACTION>
			
			<CFQUERY NAME="Q_Before" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				SELECT * FROM Listings
				WHERE LiID = #ATTRIBUTES.LiID#
			</CFQUERY>			
			
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
					FuseAction="#CFG.PlName#Update"  />

			<CFQUERY NAME="Q_After" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				SELECT * FROM Listings, Members
				WHERE LiID = #ATTRIBUTES.LiID#
					AND MeID = LiMemberLink
			</CFQUERY>		

			<!--- Set our entryErrors --->
			<CFSET ATTRIBUTES.entryErrors = CFMODULE.ATTRIBUTES.entryErrors>
			<CFSET ATTRIBUTES.errorFields = CFMODULE.ATTRIBUTES.errorFields>
			
			<!--- If it wasn't authorised.. and now it is.. then send email
				- to the member saying your listing is online.. etc etc.. --->
			<CFIF (((Q_Before.RecordCount EQ 0) AND (Q_After.LiAuthorised EQ 1)) 
				OR ((Q_Before.LiAuthorised NEQ 1) AND (Q_After.LiAuthorised EQ 1)))
				AND (Len(ATTRIBUTES.EntryErrors) EQ 0)
			>
				
				<CFINCLUDE TEMPLATE="inc_newMemberEmail.cfm">
			
			</CFIF>
			
		</CFTRANSACTION>
		
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>
