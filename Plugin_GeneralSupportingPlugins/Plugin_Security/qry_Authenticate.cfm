<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Processor">

	<!--- Call the authentication processor to find out if the current
		- user is authenticated --->
	<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#ATTRIBUTES.Processor#processAuthenticate" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
	
	<CFIF NOT CFMODULE.ATTRIBUTES.Authenticated>
		<CFPARAM NAME="ATTRIBUTES.LoginOnFail" DEFAULT="Yes">
		<CFIF ATTRIBUTES.LoginOnFail>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=#CFG.SMPrefix#Login&Processor=#ATTRIBUTES.Processor#&RFA=#REQUEST.Back#" ADDTOKEN="Yes">
		</CFIF>
	</CFIF>
</CFSILENT>