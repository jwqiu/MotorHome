<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<CFCASE VALUE="showPopupEditor,popupEditor">
		<CFINCLUDE TEMPLATE="qry_showPopupEditor.cfm">
		<CFINCLUDE TEMPLATE="dsp_showPopupEditor.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	<CFCASE VALUE="htmlArea">
		<CFINCLUDE TEMPLATE="dsp_htmlArea.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	<CFCASE VALUE="soEditorImage">
		<CFINCLUDE TEMPLATE="qry_soEditorImage.cfm">
		<CFINCLUDE TEMPLATE="dsp_soEditorImage.cfm">		
	</CFCASE>
	<CFCASE VALUE="soEditorImageUpload">
		<CFINCLUDE TEMPLATE="act_soEditorImageUpload.cfm">
		<CFINCLUDE TEMPLATE="dsp_soEditorImageUpload.cfm">
	</CFCASE>
	<CFCASE VALUE="soEditorHelp">
		<CFINCLUDE TEMPLATE="dsp_soEditorHelp.cfm">
	</CFCASE>
	<CFCASE VALUE="soEditor">
		<CFINCLUDE TEMPLATE="dsp_soEditor.cfm">
	</CFCASE>
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>