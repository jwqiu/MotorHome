<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.ReturnForm">
	<CFPARAM NAME="ATTRIBUTES.ReturnField">
	<!---
		-<CFPARAM NAME="ATTRIBUTES.HtmlContent">
		- if HtmlContent is not provided, we will get the content
		- from the ReturnField instead
		--->
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFSAVECONTENT VARIABLE="x">
			<CFOUTPUT>
			<SCRIPT language="Javascript">
				function bootStrapHTML() {
					return true;
				}
			</SCRIPT>
			</CFOUTPUT>
		</CFSAVECONTENT>
	<CFELSEIF NOT IsDefined("ATTRIBUTES.HtmlContent")>
		<CFSET ATTRIBUTES.HtmlContent = "Loading...">
		<CFSAVECONTENT VARIABLE="x">
			<CFOUTPUT>
			<SCRIPT language="Javascript">
				function bootStrapHTML() {
					soEditor.setHTML(window.opener.document.#ATTRIBUTES.ReturnForm#.#ATTRIBUTES.ReturnField#.value);
					return true;
				}
			</SCRIPT>
			</CFOUTPUT>
		</CFSAVECONTENT>
	<CFELSE>
		<CFSET ATTRIBUTES.HtmlContent = "Loading...">
		<CFSAVECONTENT VARIABLE="x">
			<CFOUTPUT>
			<SCRIPT language="Javascript">
				function bootStrapHTML() {
					soEditor.setHTML('#JSStringFormat(ATTRIBUTES.HtmlContent)#');
					return true;
				}
			</SCRIPT>
			</CFOUTPUT>
		</CFSAVECONTENT>
	</CFIF>
	<CFHTMLHEAD TEXT="#x#">
	
	<CFSET RelativeHere = ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, "")>
	<CFSET RelativeHere = Replace(RelativeHere, "\", "/")>
	
	<CFSET soScriptPath = RelativeHere & "siteobjects/soeditor/lite/">
	
</CFSILENT>