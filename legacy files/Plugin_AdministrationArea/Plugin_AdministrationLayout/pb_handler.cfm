<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">

	<CFCASE VALUE="administrationLayout">
		<CFPARAM NAME="REQUEST.Title" DEFAULT="Administration">
		<CFINCLUDE TEMPLATE="qry_administrationLayout.cfm">
		<CFINCLUDE TEMPLATE="dsp_administrationLayout.cfm">
		<!--- We don't want any parent layout handlers to run again --->
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="administration">
		<CFPARAM NAME="REQUEST.Title" DEFAULT="Administration">
		<CFINCLUDE TEMPLATE="dsp_administration.cfm">
		<!--- We don't want any parent layout handlers to run again --->
		<CFSET ATTRIBUTES.Layout = "administration">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="authenticate" PROCESSOR="admin"/>
	</CFCASE>
	
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>