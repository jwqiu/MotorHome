<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ReplaceNoCase(ATTRIBUTES.FuseAction, CFG.PlName, "")#">
	<!--- Example :
		- <CFCASE VALUE="helloWorld">
		-	<CFINCLUDE TEMPLATE="dsp_helloWorld.cfm">
		- </CFCASE>
		--->
	<CFCASE VALUE="Initialize">
		<CFINCLUDE TEMPLATE="act_initialize.cfm">
	</CFCASE>

	<CFCASE VALUE="DisplayHome">
		<CFLOCATION URL="#ListDeleteAt(CGI.SCRIPT_NAME,ListLen(CGI.SCRIPT_NAME,"/\"),"/\")#/Content/index.cfm">
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>