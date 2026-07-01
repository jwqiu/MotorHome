<CFPARAM NAME="ATTRIBUTES.FieldName">
<CFPARAM NAME="ATTRIBUTES.Directory">
<CFPARAM NAME="ATTRIBUTES.URL">
<CFPARAM NAME="ATTRIBUTES.Form" DEFAULT="">
<!--- Work out the form name --->
<CFIF NOT Len(ATTRIBUTES.Form)>
	<CFSET cfForm = GetBaseTagData("CFFORM")>
	<CFSET ATTRIBUTES.Form = cfForm.ATTRIBUTES.Name>
</CFIF>
<CFSAVECONTENT VARIABLE="HTMLHEAD">
<CFOUTPUT>
	<SCRIPT language="JavaScript" TYPE="text/javascript">
	<!--
		function #ATTRIBUTES.FieldName#_saveImage(url) {
			document.forms.#ATTRIBUTES.Form#.#ATTRIBUTES.FieldName#.value = url;
		}
	//-->
	</SCRIPT>
</CFOUTPUT>
</CFSAVECONTENT>
<CFHTMLHEAD TEXT="#HTMLHEAD#">

<!--- Check the given directory exists on the server --->
<CFTRY>
	<CFIF not DirectoryExists(ATTRIBUTES.Directory)>
		<CFDIRECTORY ACTION="Create" DIRECTORY="#ATTRIBUTES.Directory#">
	</CFIF>
	<CFCATCH TYPE="ANY">
	</CFCATCH>
</CFTRY>

<CFOUTPUT>
<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imager&ImageURL=' + escape(document.forms.#ATTRIBUTES.Form#.#ATTRIBUTES.FieldName#.value) + '&#SESSION.URLToken#', 'imageView', 'width=320,height=240,scrollbars=yes');void(0)"><IMG SRC="images/b-view.gif" BORDER="0" ALT="View Image"></A>
<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imageManager&RootPath=#URLEncodedFormat(ATTRIBUTES.Directory)#&RootURL=#URLEncodedFormat(ATTRIBUTES.URL)#&SaveFunction=#ATTRIBUTES.FieldName#_saveImage&#SESSION.URLToken#', 'imageManager_#ATTRIBUTES.FieldName#', 'width=590,height=320');void(0)"><IMG SRC="images/b-browse.gif" BORDER="0" ALT="Browse/Upload Images"></A>
<A HREF="javascript:void(0);" onClick="document.forms.#ATTRIBUTES.Form#.#ATTRIBUTES.FieldName#.value = '';void(0)"><IMG SRC="images/b-clear.gif" ALT="Clear Image" BORDER="0"></A>
</CFOUTPUT>