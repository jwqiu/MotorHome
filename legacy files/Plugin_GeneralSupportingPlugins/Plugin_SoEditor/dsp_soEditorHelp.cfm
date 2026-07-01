<CFSAVECONTENT VARIABLE="HelpText">
<CFINCLUDE TEMPLATE="siteobjects/soeditor/lite/help.cfm">
</CFSAVECONTENT>
<CFOUTPUT>
	#ReplaceNoCase(HelpText, "Src=""icons", "Src=""#CFG.soScriptPath#/icons", "ALL")#
</CFOUTPUT>