<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFPARAM NAME="ATTRIBUTES.Processor" >
		<CFPARAM NAME="ATTRIBUTES.Username" DEFAULT="">
		
		<!--- Call the forgot password processor to do the work --->
		<CFMODULE TEMPLATE="#CFG.TopLevel#" 
				FuseAction="#ATTRIBUTES.Processor#processForgotPassword" 
				ATTRIBUTECOLLECTION=#ATTRIBUTES# />
		
		<CFIF NOT CFMODULE.ATTRIBUTES.PasswordSent>
			<CFSET ATTRIBUTES.entryErrors = "Unable to find that account.  Please try again.">
		</CFIF>
	</CFIF>
</CFSILENT>