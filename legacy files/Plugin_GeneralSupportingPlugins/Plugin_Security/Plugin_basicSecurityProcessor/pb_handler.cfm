<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ReplaceNoCase(ATTRIBUTES.FuseAction, CFG.SMPrefix, "")#">
	<!--- Example :
		- <CFCASE VALUE="helloWorld">
		-	<CFINCLUDE TEMPLATE="dsp_helloWorld.cfm">
		- </CFCASE>
		--->

	<CFCASE VALUE="processLogin">
		<CFINCLUDE TEMPLATE="qry_processLogin.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="processLogout">
		<CFINCLUDE TEMPLATE="qry_processLogout.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="processAuthenticate">
		<CFINCLUDE TEMPLATE="qry_processAuthenticate.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="processSudo">
		<CFINCLUDE TEMPLATE="qry_processSudo.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="processForgotPassword">
		<CFINCLUDE TEMPLATE="qry_processForgotPassword.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
		
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>