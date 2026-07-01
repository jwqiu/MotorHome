<CFSILENT>
	<!--- Default log out, just delete key from session --->
	<CFSET x = StructDelete(SESSION, "#CFG.SMPrefix#", "No")>
	<CFSET ATTRIBUTES.LoggedOut = "Yes">
</CFSILENT>