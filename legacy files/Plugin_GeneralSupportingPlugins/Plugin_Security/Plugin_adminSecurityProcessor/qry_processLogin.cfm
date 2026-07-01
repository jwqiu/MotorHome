<CFSILENT>
	<!--- Default login processor, username & password stored in CFG --->
	<CFPARAM NAME="ATTRIBUTES.Username">
	<CFPARAM NAME="ATTRIBUTES.Password">
	<CFSET ATTRIBUTES.Authenticated = "No">
	<CFIF CFG["AdminUsername"] eq ATTRIBUTES.Username
		AND
		  CFG["AdminPassword"] eq ATTRIBUTES.Password >
		<CFSET SESSION[CFG.SMPrefix] = ATTRIBUTES.Username>		
		<CFSET ATTRIBUTES.Authenticated = "Yes">
	<CFELSEIF IsDefined("CFG.ImediaUsername") AND IsDefined("CFG.ImediaPassword")>
		<CFIF CFG["ImediaUsername"] eq ATTRIBUTES.Username
			AND
			  CFG["ImediaPassword"] eq ATTRIBUTES.Password
		>
			<CFSET SESSION[CFG.SMPrefix] = ATTRIBUTES.Username>		
			<CFSET ATTRIBUTES.Authenticated = "Yes">
		</CFIF>
	</CFIF>
</CFSILENT>