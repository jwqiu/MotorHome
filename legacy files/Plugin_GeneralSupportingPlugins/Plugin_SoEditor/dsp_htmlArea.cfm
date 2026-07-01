<!---
	- Display an "HTMLArea", this is likely to be a standard text box with
	- a link to open it in a graphical editor.
	- but could be an embedded html editor.
	--->
<CFPARAM NAME="ATTRIBUTES.FormName">
<CFPARAM NAME="ATTRIBUTES.FieldName">
<CFPARAM NAME="ATTRIBUTES.ROWS" DEFAULT="10">
<CFPARAM NAME="ATTRIBUTES.COLS" DEFAULT="60">
<CFPARAM NAME="ATTRIBUTES.Width" DEFAULT="640px">
<CFPARAM NAME="ATTRIBUTES.Height" DEFAULT="480px">
<CFPARAM NAME="ATTRIBUTES.VALUE" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.Embed" DEFAULT="No">
<CFIF ATTRIBUTES.Embed>
	<CFOUTPUT>
		<CFMODULE TEMPLATE="#CFG.TopLevel#" 
			FUSEACTION="soEditor" FIELDNAME="#ATTRIBUTES.FieldName#" 
			FORMNAME="#ATTRIBUTES.FormName#"
			WIDTH="#ATTRIBUTES.Width#" HEIGHT="#ATTRIBUTES.Height#" HTMLCONTENT="#ATTRIBUTES.VALUE#"
		/>
	</CFOUTPUT>
<CFELSE>
<CFOUTPUT>
	<SMALL>
		<STRONG>Windows Internet Explorer 5+</STRONG> - <A HREF="javascript:window.open('#CGI.SCRIPT_NAME#?FuseAction=popupEditor&ReturnField=#ATTRIBUTES.FieldName#&ReturnForm=#ATTRIBUTES.FormName#', 'edit#ATTRIBUTES.FieldName#', 'width=#ATTRIBUTES.WIDTH#,height=#Evaluate(ReReplace(ATTRIBUTES.Height, "[^0-9]", '', "ALL") + 115)#px,status');void(0);">graphical editor</A> for more formatting options.<BR>
		<STRONG>Other Users</STRONG> - seperate paragraphs with blank lines, you may use
		<UL>
			<LI>`[B] some text [/B]' to make some text bold.
			<LI>`[A HREF="http://some.site.com/"] some text [/A]' to make some text a link to http://some.site.com/.
			<LI>`[UL] [LI] item number 1 [LI] item number 2 [/UL]' to make a list with 2 items
		</UL>
	</SMALL>
	<TEXTAREA NAME="#ATTRIBUTES.FieldName#" ROWS="#ATTRIBUTES.Rows#" COLS="#ATTRIBUTES.Cols#">#HTMLEditFormat(ATTRIBUTES.Value)#</TEXTAREA>
</CFOUTPUT>		
</CFIF>