<CFSILENT>
	<CFIF isDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#") and NOT Len(ATTRIBUTES.EntryErrors)>

		<CFMODULE TEMPLATE="#CFG.TopLevel#" Action="Start" Processor="Admin"
			FuseAction="Sudo" />

		<CFTRANSACTION>

	
		
			<!--- No errors occured, do an insert --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
				FuseAction="MembersInsert" />

			<!--- Set our entryErrors --->
			<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & CFMODULE.ATTRIBUTES.entryErrors>
			<CFSET ATTRIBUTES.errorFields = CFMODULE.ATTRIBUTES.errorFields>
				
			
		</CFTRANSACTION>

		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<!--- Remember the MeID of the new member record created
				- so that it can be flagged as paid (MeActivate) 
				- after payment is made for the listings...
				--->
			<CFSET SESSION.NewMember = CFMODULE.ATTRIBUTES[CFG.PlTablePrimaryKey]>
			<CFSET SESSION.NewMemberName = "#ATTRIBUTES.MeFormalName#">
			<CFSET SESSION.NewMemberEmail = "#ATTRIBUTES.MeEmail#">
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=AddListing" ADDTOKEN="Yes">

			<CFMODULE TEMPLATE="#CFG.TopLevel#" Action="End" Processor="Admin"
				FuseAction="Sudo" />
			
		</CFIF>

		<CFMODULE TEMPLATE="#CFG.TopLevel#" Action="End" Processor="Admin"
			FuseAction="Sudo" />
		
	</CFIF>
</CFSILENT>