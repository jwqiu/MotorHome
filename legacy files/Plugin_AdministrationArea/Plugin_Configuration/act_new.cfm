<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFTRANSACTION>
			<!--- Attempt to do the update --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES# FUSEACTION="#CFG.PlName#Update"  />
			
			<!--- Clean away some problem attributes --->
			<CFSCRIPT>
				StructDelete(CFMODULE.ATTRIBUTES, "FuseAction", "Yes");
				StructDelete(CFMODULE.ATTRIBUTES, "Layout", "Yes");
			</CFSCRIPT>
			
			<!--- Set their (validated) attributes to our attributes 
				- this grabs entryErrors and errorFields as well --->
			<CFSET RC = StructAppend(ATTRIBUTES, CFMODULE.ATTRIBUTES, "Yes")>	
			
		</CFTRANSACTION>
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return&ForceCFGReload=1" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>
