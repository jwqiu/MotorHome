<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>URL</TITLE>
</HEAD>
<CFOUTPUT>
<BODY LEFTMARGIN=0 TOPMARGIN=0 BGCOLOR="##8399B1">
<TABLE WIDTH="100%" BORDER="0">
<CFFORM NAME="urlPaneForm" ACTION="#CGI.SCRIPT_NAME#" ENCTYPE="multipart/form-data">
<TR><TD ALIGN="RIGHT"> <INPUT TYPE="TEXT" SIZE="40" NAME="imageURL" VALUE="#ATTRIBUTES.URL#" ></TD>
</TR><TR><TD ALIGN="RIGHT"><INPUT TYPE="FILE" NAME="UploadFile" SIZE="1" onChange="this.form.submit()" > <INPUT TYPE="BUTTON" NAME="OKButton" VALUE="OK" STYLE="width:6em;height:24px" onClick="parent.useImage(this.form.imageURL.value)"> <INPUT TYPE="BUTTON" NAME="CAButton" VALUE="Cancel" STYLE="width:6em;height:24px" onClick="parent.cancel()"></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<TR><TD></TD></TR>

<INPUT TYPE="HIDDEN" NAME="URL" VALUE="#ATTRIBUTES.Url#">
<INPUT TYPE="HIDDEN" NAME="Path" VALUE="#ATTRIBUTES.Path#">
<INPUT TYPE="HIDDEN" NAME="FuseAction" VALUE="#ATTRIBUTES.FuseAction#">
<INPUT TYPE="HIDDEN" NAME="Do_#ATTRIBUTES.FuseAction#" VALUE="Yes">
</CFFORM>
</TABLE>
</BODY>
</CFOUTPUT>
</HTML>
