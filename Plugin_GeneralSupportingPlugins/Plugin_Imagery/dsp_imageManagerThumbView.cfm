<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Thumbnails</title>
	<STYLE TYPE="text/css">
		td {
			font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
		}
</STYLE>
</head>

<body TOPMARGIN="0" LEFTMARGIN="0" RIGHTMARGIN="0">
<!--- <TABLE WIDTH="100%" BGCOLOR="#8399B1" TYPE="border: thin outset;">
<CFOUTPUT>
<TR><FORM><TD><INPUT TYPE="TEXT" DISABLED VALUE="#HTMLEditFormat(ATTRIBUTES.URL)#"><INPUT TYPE="BUTTON" VALUE="Upload" STYLE="width:6em"></TD></FORM></TR>
</CFOUTPUT>
</TABLE> --->
<TABLE BORDER="0" WIDTH="100%">
	<CFLOOP FROM="1" TO="#Q_Directory.RecordCount#" INDEX="Row" STEP="3">
	<TR>
		<CFSET Name = Q_Directory.Name[Row]>
		<CFSET Type = Q_Directory.Type[Row]>
		<TD ALIGN="CENTER" WIDTH="33%">
			<CFOUTPUT>
			<CFIF TYPE neq "dir">
			<TABLE WIDTH="70" HEIGHT="70" BGCOLOR="Silver" STYLE="border: thin outset;">
				<TR><TD VALIGN="MIDDLE" ALIGN="CENTER"><A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#JsStringFormat(ATTRIBUTES.URL & Name)#')"><IMG SRC="#CFG.TopURL#?FuseAction=imager&MaxDimension=64&ImageURL=#URLEncodedFormat(ATTRIBUTES.URL & Name)#&#SESSION.URLToken#" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#URLEncodedFormat(ATTRIBUTES.URL & Name)#')">#Name#</A>
			<CFELSE>
			<TABLE WIDTH="70" HEIGHT="70" BORDER="0">
			<TR><TD VALIGN="MIDDLE" ALIGN="CENTER">
			<A HREF="javascript:parent.showThumbs('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')"><IMG SRC="images/i-directory.png" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showThumbs('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')">#Name#</A>
			</CFIF>
			</CFOUTPUT>
		</TD>		
	
		<CFIF Q_Directory.RecordCount GTE Row + 1>
		<CFSET Name = Q_Directory.Name[Row + 1]>
		<CFSET Type = Q_Directory.Type[Row + 1]>
		<TD ALIGN="CENTER" WIDTH="33%">
			<CFOUTPUT>
			<CFIF TYPE neq "dir">
			<TABLE WIDTH="70" HEIGHT="70" BGCOLOR="Silver" STYLE="border: thin outset;">
				<TR><TD VALIGN="MIDDLE" ALIGN="CENTER"><A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#JsStringFormat(ATTRIBUTES.URL & Name)#')"><IMG SRC="#CFG.TopURL#?FuseAction=imager&MaxDimension=64&ImageURL=#URLEncodedFormat(ATTRIBUTES.URL & Name)#&#SESSION.URLToken#" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#URLEncodedFormat(ATTRIBUTES.URL & Name)#')">#Name#</A>
			<CFELSE>
			<TABLE WIDTH="70" HEIGHT="70" BORDER="0">
			<TR><TD VALIGN="MIDDLE" ALIGN="CENTER">
			<A HREF="javascript:parent.showThumbs('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')"><IMG SRC="images/i-directory.png" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showThumbs('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')">#Name#</A>
			</CFIF>
			</CFOUTPUT>
		</TD>
		<CFELSE>
		<TD>&nbsp;</TD>
		</CFIF>
	
		<CFIF Q_Directory.RecordCount GTE Row + 2>
		<CFSET Name = Q_Directory.Name[Row + 2]>
		<CFSET Type = Q_Directory.Type[Row + 2]>
		<TD ALIGN="CENTER" WIDTH="33%">
			<CFOUTPUT>
				<CFIF TYPE neq "dir">
			<TABLE WIDTH="70" HEIGHT="70" BGCOLOR="Silver" STYLE="border: thin outset;">
				<TR><TD VALIGN="MIDDLE" ALIGN="CENTER"><A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#JsStringFormat(ATTRIBUTES.URL & Name)#')"><IMG SRC="#CFG.TopURL#?FuseAction=imager&MaxDimension=64&ImageURL=#URLEncodedFormat(ATTRIBUTES.URL & Name)#&#SESSION.URLToken#" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path)#', '#URLEncodedFormat(ATTRIBUTES.URL & Name)#')">#Name#</A>
			<CFELSE>
			<TABLE WIDTH="70" HEIGHT="70" BORDER="0">
			<TR><TD VALIGN="MIDDLE" ALIGN="CENTER">
			<A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')"><IMG SRC="images/i-directory.png" ALT="#Name#" BORDER="0"></A><BR></TD></TR>
			</TABLE>
			<A HREF="javascript:parent.showImage('#JsStringFormat(ATTRIBUTES.Path & Name & '\')#', '#JsStringFormat(ATTRIBUTES.URL & Name & '/')#')">#Name#</A>
			</CFIF>
			</CFOUTPUT>
		</TD>
		<CFELSE>
		<TD>&nbsp;</TD>
		</CFIF>
	</TR>
	</CFLOOP>
</TABLE>
</body>
</html>
