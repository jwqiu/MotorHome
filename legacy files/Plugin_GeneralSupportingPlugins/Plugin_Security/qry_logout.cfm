<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Processor" >

	<!--- call the logout processor to do the work --->
	<CFMODULE TEMPLATE="#CFG.TopLevel#" 
				FuseAction="#ATTRIBUTES.Processor#processLogout" ATTRIBUTECOLLECTION=#ATTRIBUTES#/>
	
	<CFIF NOT CFMODULE.ATTRIBUTES.LoggedOut>
		<CFSET ATTRIBUTES.entryErrors = "Unable to log user out of system, please try again.">	
	</CFIF>
</CFSILENT>