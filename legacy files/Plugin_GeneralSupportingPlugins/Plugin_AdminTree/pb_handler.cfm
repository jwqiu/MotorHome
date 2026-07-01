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
	<CFCASE VALUE="adminTree">
		<CFINCLUDE TEMPLATE="dsp_adminTree.cfm">
		<CFPARAM NAME="ATTRIBUTES.Layout" DEFAULT="adminLayout">
		<CFPARAM NAME="REQUEST.Title" DEFAULT="Database Tree">
	</CFCASE>
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>