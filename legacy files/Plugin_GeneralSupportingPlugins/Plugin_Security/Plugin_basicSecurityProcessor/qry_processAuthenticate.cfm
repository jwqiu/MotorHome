<CFSILENT>
	
	<!--- Default authentication, check to see if somebody is logged in
		- via this security manager, unless sudo is one or more --->
	<CFPARAM NAME="REQUEST.#CFG.SMPrefix#_SUDO" DEFAULT="0">
	<CFSET ATTRIBUTES.Authenticated = "No">
	
	<CFIF REQUEST["#CFG.SMPrefix#_SUDO"] GTE 1>
		<CFSET ATTRIBUTES.Authenticated = "Yes">
	</CFIF>
	
	<CFIF IsDefined("SESSION.#CFG.SMPrefix#")>
		<CFSET ATTRIBUTES.Authenticated = "Yes">
	</CFIF>
	
</CFSILENT>