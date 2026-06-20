<CFPARAM NAME="ATTRIBUTES.FieldName" DEFAULT="HtmlContent">
<CFIF IsDefined("ATTRIBUTES.Form")>
	<CFSET ATTRIBUTES.FormName = ATTRIBUTES.Form>
</CFIF>
<CFPARAM NAME="ATTRIBUTES.FormName"  >
<CFSAVECONTENT VARIABLE="editor">
	<CFMODULE TEMPLATE="siteobjects/soeditor/lite/soeditor_lite.cfm" 
		FORM="#ATTRIBUTES.FormName#" FIELD="#ATTRIBUTES.FieldName#" SCRIPTPATH="#CFG.soScriptPath#" 
		WIDTH="#ATTRIBUTES.Width#" HEIGHT="#ATTRIBUTES.Height#"
		HTML="#ATTRIBUTES.HtmlContent#">
</CFSAVECONTENT>
<CFSAVECONTENT VARIABLE="HTMLHEAD">
<CFOUTPUT>
<script language="javascript">
// Fix to openHelp for plugBox system
function openHelp() {
parent.showModalDialog("#CGI.SCRIPT_NAME#?FuseAction=soEditorHelp&new=true&save=true&cut=true&copy=true&paste=true&delete=true&find=true&undo=true&redo=true&hr=true&image=true&link=true&unlink=true&spellcheck=false&help=true&align=true&list=true&unindent=true&indent=true&fontdialog=true&format=true&font=true&size=true&bold=true&italic=true&underline=true&superscript=true&subscript=true&fgcolor=true&bgcolor=true&tables=true&insertcell=true&deletecell=true&insertrow=true&deleterow=true&insertcolumn=true&deletecolumn=true&splitcell=true&mergecell=true&cellprop=true&htmledit=true&borders=true&details=true",null,"dialogWidth:250px; dialogHeight:300px;help:0;status:no;");  
}
</script>
</CFOUTPUT>
</CFSAVECONTENT>
<CFHTMLHEAD text="#HTMLHEAD#">
<TABLE bgcolor="#d4d0c8" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR><TD><CFOUTPUT>#editor#</CFOUTPUT></TD></TR>
</TABLE>