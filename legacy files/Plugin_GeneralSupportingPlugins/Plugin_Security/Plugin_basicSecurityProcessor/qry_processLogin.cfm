<CFSILENT>
	<!--- Default login processor, username & password stored in CFG --->
	<CFPARAM NAME="ATTRIBUTES.Username">
	<CFPARAM NAME="ATTRIBUTES.Password">
	<CFSET ATTRIBUTES.Authenticated = "No">
	<CFIF CFG["#CFG.SMPrefix#_Username"] eq ATTRIBUTES.Username
		AND
		  CFG["#CFG.SMPrefix#_Password"] eq ATTRIBUTES.Password >
		<CFSET SESSION[CFG.SMPrefix] = ATTRIBUTES.Username>		
		<CFSET ATTRIBUTES.Authenticated = "Yes">
	</CFIF>
</CFSILENT>