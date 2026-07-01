<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
<CFIF Len(CFG.SMPRefix)>
	<CFSET Action = ReplaceNoCase(ATTRIBUTES.FuseAction, CFG.SMPrefix, "")>
<CFELSE>
	<CFSET Action = ATTRIBUTES.FuseAction>
</CFIF>
</CFSILENT>
<CFSWITCH EXPRESSION="#Action#">
	<!--- Example :
		- <CFCASE VALUE="helloWorld">
		-	<CFINCLUDE TEMPLATE="dsp_helloWorld.cfm">
		- </CFCASE>
		--->
		
	<CFCASE VALUE="login">
		<CFSET REQUEST.Title = "Please Log In">
		<CFINCLUDE TEMPLATE="qry_login.cfm">
		<CFINCLUDE TEMPLATE="dsp_login.cfm">
	</CFCASE>
	
	<CFCASE VALUE="logout">
		<CFSET REQUEST.Title = "Logged Out">
		<CFINCLUDE TEMPLATE="qry_logout.cfm">
		<CFINCLUDE TEMPLATE="dsp_logout.cfm">
	</CFCASE>
	
	<CFCASE VALUE="authenticate">
		<CFINCLUDE TEMPLATE="qry_authenticate.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
		<CFSET CFG.CacheThis = "Request">
	</CFCASE>
	
	<CFCASE VALUE="sudo">
		<CFINCLUDE TEMPLATE="qry_sudo.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="forgotPassword">
		<CFSET REQUEST.Title = "Password Reminder">
		<CFINCLUDE TEMPLATE="act_forgotPassword.cfm">
		<CFINCLUDE TEMPLATE="dsp_forgotPassword.cfm">
	</CFCASE>
	
	<CFDEFAULTCASE>
		Huh ??  <CFOUTPUT>#Replace(ATTRIBUTES.FuseAction, CFG.SMPrefix, "")#</CFOUTPUT>
	</CFDEFAULTCASE>
</CFSWITCH>