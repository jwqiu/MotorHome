<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFTRANSACTION>

			<!--- No errors occured, do an insert --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
				FuseAction="#CFG.PlName#Insert" />

			<CFQUERY NAME="Q_After" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				SELECT * FROM Members
				WHERE MeID = #ATTRIBUTES.LiMemberLink#
			</CFQUERY>		
				
			<!--- Set our entryErrors --->
			<CFSET ATTRIBUTES.entryErrors = CFMODULE.ATTRIBUTES.entryErrors>
			<CFSET ATTRIBUTES.errorFields = CFMODULE.ATTRIBUTES.errorFields>

			<!--- If new member is marked as authorised then send email --->
			<CFIF isDefined("ATTRIBUTES.LiAuthorised") AND (ATTRIBUTES.LiAuthorised EQ 1) AND (Len(ATTRIBUTES.EntryErrors) EQ 0)>
				<CFINCLUDE TEMPLATE="inc_newMemberEmail.cfm">
			</CFIF>
				
		</CFTRANSACTION>
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>
