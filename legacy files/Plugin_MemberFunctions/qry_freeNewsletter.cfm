<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Name" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Email" DEFAULT="">

<!---
	<CFIF len(SESSION.SecurityEmail) AND Len(ATTRIBUTES.Email) EQ 0>
		<CFSET ATTRIBUTES.Email = SESSION.SecurityEmail>
	</CFIF>

	<CFIF len(SESSION.SecurityName) AND Len(ATTRIBUTES.Name) EQ 0>
		<CFSET ATTRIBUTES.Name = SESSION.SecurityName>
	</CFIF>
--->	

	
	<CFSET ShowSubscribe=1>
	<CFSET ShowUnsubscribe=1>
	<CFSET ShowSuccessfulUnsubscribe=0>
	<CFSET ShowSuccessfulSubscribe=0>
	
</CFSILENT>