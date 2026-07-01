<HTML>
<HEAD><TITLE>Graphical Editor</TITLE></HEAD>
<BODY MARGINWIDTH=0 MARGINHEIGHT=0 LEFTMARGIN=0 TOPMARGIN=0 RIGHTMARGIN=0 BOTTOMMARGIN=0 onLoad="bootStrapHTML()">
<CFIF NOT IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
	<CFFORM NAME="popupForm" ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=Yes&ReturnField=#URLEncodedFormat(ATTRIBUTES.ReturnField)#&ReturnForm=#URLEncodedFormat(ATTRIBUTES.ReturnForm)#&#SESSION.URLToken#" METHOD="POST">
	<CFIF pb_serviceAvailable("soEditor")>
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="soEditor" FORM="popupForm"
			FIELD="HtmlContent" WIDTH="#ATTRIBUTES.Width#" HEIGHT="#ATTRIBUTES.Height#" 
			HTMLCONTENT="#ATTRIBUTES.HTMLContent#"/>
	<CFELSE>
		<TEXTAREA NAME="HtmlContent" STYLE="width: #ATTRIBUTES.Width#; height: #ATTRIBUTES.Height#;"><CFOUTPUT>#HTMLEditFormat(ATTRIBUTES.HTMLContent)#</CFOUTPUT></TEXTAREA>
		<INPUT TYPE="SUBMIT" VALUE="Save" NAME="Subby">
	</CFIF>
	</CFFORM>
<CFELSE>
	<CFOUTPUT>
		<SCRIPT language="JavaScript" TYPE="text/javascript">
	    <!-- 
	    	window.opener.document.#ATTRIBUTES.ReturnForm#.#ATTRIBUTES.ReturnField#.value =
				"<HTML>#JsStringFormat(ATTRIBUTES.HTMLContent)#</HTML>";
			window.close();
	    //-->
	    </SCRIPT>
	</CFOUTPUT>
</CFIF>
</BODY>
</HTML>