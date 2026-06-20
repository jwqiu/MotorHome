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
	<CFCASE VALUE="imageManager">
		<CFINCLUDE TEMPLATE="qry_imageManager.cfm">
		<CFINCLUDE TEMPLATE="dsp_imageManager.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imageManagerTree">
		<CFINCLUDE TEMPLATE="qry_imageManagerTree.cfm">
		<CFINCLUDE TEMPLATE="dsp_imageManagerTree.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imageManagerTreeData">
		<CFINCLUDE TEMPLATE="qry_imageManagerTreeData.cfm">
		<CFINCLUDE TEMPLATE="dsp_imageManagerTreeData.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imageManagerURLPane">
		<CFINCLUDE TEMPLATE="qry_imageManagerURLPane.cfm">
		<CFINCLUDE TEMPLATE="dsp_imageManagerURLPane.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imageManagerThumbView">
		<CFINCLUDE TEMPLATE="qry_imageManagerThumbView.cfm">
		<CFINCLUDE TEMPLATE="dsp_imageManagerThumbView.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imager">
		<CFINCLUDE TEMPLATE="qry_imager.cfm">
	</CFCASE>
	
	<CFCASE VALUE="imageManagerFieldButtons">
		<CFINCLUDE TEMPLATE="dsp_imageManagerFieldButtons.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>