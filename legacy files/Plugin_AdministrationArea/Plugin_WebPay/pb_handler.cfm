<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<CFCASE VALUE="configureWebPay">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="authenticate" PROCESSOR="admin" />
		<CFINCLUDE TEMPLATE="qry_configureWebPay.cfm">
		<CFINCLUDE TEMPLATE="act_configureWebPay.cfm">
		<CFINCLUDE TEMPLATE="dsp_configureWebPay.cfm">
		<CFSET ATTRIBUTES.Layout = "Administration">
	</CFCASE>
	<CFCASE VALUE="initializeWebPay">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="authenticate" PROCESSOR="admin" />
		<CFINCLUDE TEMPLATE="act_initializeWebPay.cfm">
		<CFINCLUDE TEMPLATE="dsp_initializeWebPay.cfm">
		<CFSET ATTRIBUTES.Layout = "Administration">
	</CFCASE>

	<CFCASE VALUE="displayHome">
		<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=checkout">
	</CFCASE>

	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>