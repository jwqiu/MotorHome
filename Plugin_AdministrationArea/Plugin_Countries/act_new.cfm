<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFTRANSACTION>

			<!--- No errors occured, do an insert --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
				FuseAction="#CFG.PlName#Insert" />
		
			<!--- Set our entryErrors --->
			<CFSET ATTRIBUTES.entryErrors = CFMODULE.ATTRIBUTES.entryErrors>
			<CFSET ATTRIBUTES.errorFields = CFMODULE.ATTRIBUTES.errorFields>
				
		</CFTRANSACTION>
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>
