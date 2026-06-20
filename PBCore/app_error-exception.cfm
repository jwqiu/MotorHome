<CFMAIL FROM="errors@#CGI.SERVER_NAME#" TO="#Error.MailTo#" 
	SUBJECT="Bug Report From #CGI.SERVER_NAME#">
An exception has been logged on #CGI.SERVER_NAME#, another email may follow if the
user who experienced the exception files a report....

Exception Details...
-------------------------------------------------------------------------------
Date/Time          : #Error.DateTime#
Template           : #Error.Template#
QueryString        : #Error.QueryString#
Referer            : #Error.HTTPReferer#
Browser            : #Error.Browser#
Remote IP          : #Error.RemoteAddress#

Diagnostics         
--------------------
#Error.Diagnostics#

Generated Content
--------------------
#Error.GeneratedContent#
</CFMAIL>
<CFOUTPUT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>An Unexpected Error Occurred</TITLE>
<LINK REL="stylesheet" HREF="error_styles.css"></HEAD>

<BODY BGCOLOR="##FFFFFF">

<TABLE ALIGN="CENTER" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="95%">
  <TR> 
    <TD VALIGN="TOP"> 
      <H3>Unexpected error</H3>
      <BR>
      <P> An unexepected error occurred with your request. We apologize for this 
        problem and would appreciate if you could complete the form below and 
        click the submit button to send a bug report to the webmaster. </P>
      <P> Once again we thank you for your patience and assistance in this matter. 
      </P>
      
				<FORM ACTION="/PBCore/app_error_mail.cfm" METHOD="POST">
					<TABLE WIDTH="85%" ALIGN="CENTER" BORDER="0">
						<TR><TH ALIGN="LEFT">Your Name</TH><TD><INPUT NAME="Name" TYPE="TEXT" VALUE=""></TD></TR>
						<TR><TH ALIGN="LEFT">Your email Address</TH><TD><INPUT NAME="Email" TYPE="TEXT" VALUE=""></TD></TR>
						<TR><TH  ALIGN="LEFT" COLSPAN="2">Please write a brief note of what you were doing at the time this error occurred</TH></TR>
						<TR>
							<TD ALIGN="CENTER" COLSPAN="2">
								<TEXTAREA NAME="Comments" COLS="50" ROWS="5" WRAP="PHYSICAL"></TEXTAREA>
							</TD>
						</TR>
						<INPUT TYPE="HIDDEN" NAME="DateTime" VALUE="#Error.DateTime#">
						<INPUT TYPE="HIDDEN" NAME="RemoteAddress" VALUE="#Error.RemoteAddress#">
						<INPUT TYPE="HIDDEN" NAME="MailTo" VALUE="#Error.MailTo#">
					</TABLE>
					<TABLE WIDTH="85%" ALIGN="CENTER" BORDER="0">
						<TR>
							<TD ALIGN="RIGHT">
							<INPUT TYPE="SUBMIT" NAME="SUBMIT" VALUE="SUBMIT">
							</TD>
						</TR>
					</TABLE></FORM> </TD>
  </TR>
</TABLE>
<PRE>
Exception Details...
-------------------------------------------------------------------------------
Date/Time          : #Error.DateTime#
Template           : #Error.Template#
QueryString        : #Error.QueryString#
Referer            : #Error.HTTPReferer#
Browser            : #Error.Browser#
Remote IP          : #Error.RemoteAddress#

Diagnostics         
--------------------
#Error.Diagnostics#

Generated Content
--------------------
#Error.GeneratedContent#
</PRE>
</BODY>
</HTML>
</CFOUTPUT>
