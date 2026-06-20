<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFPARAM NAME="ATTRIBUTES.Processor" >
		<CFPARAM NAME="ATTRIBUTES.Username" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.password" DEFAULT="">
		
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#ATTRIBUTES.Processor#processLogin" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
		
		<CFIF NOT CFMODULE.ATTRIBUTES.Authenticated>
			<CFSET ATTRIBUTES.entryErrors = "Those credentials are not correct.  Please try again.">
		<CFELSE>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>