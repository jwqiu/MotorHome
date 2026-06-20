<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<!--- Example :
		- <CFCASE VALUE="helloWorld">
		-	<CFINCLUDE TEMPLATE="dsp_helloWorld.cfm">
		- </CFCASE>
		--->
	<CFCASE VALUE="newsletter">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="authenticate" PROCESSOR="admin"/>
		<CFINCLUDE TEMPLATE="qry_newsletter.cfm">
		<CFINCLUDE TEMPLATE="act_newsletter.cfm">
		<CFINCLUDE TEMPLATE="dsp_newsletter.cfm">
		<CFSET REQUEST.Title = "Send Newsletter">
		<CFSET ATTRIBUTES.Layout = "adminLayout">
	</CFCASE>
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>