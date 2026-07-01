<CFIF NOT Len(ATTRIBUTES.EntryErrors) AND IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.fuseAction#")>
<P>
	Your password has been emailed to you, please check your email and 
	<CFOUTPUT><A HREF="#CGI.SCRIPT_NAME#?FuseAction=return">return to the login page</A></CFOUTPUT>.
</P>
<CFELSE>
<P>
	To be reminded of your password, simply enter your username and click the
	remind me button.
</P>
<P>
<CFIF Len(ATTRIBUTES.EntryErrors)>
<STRONG>Unknown Account <CFOUTPUT>#ATTRIBUTES.Username#</CFOUTPUT></STRONG>
</CFIF>
<CFFORM ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=Yes&Processor=#ATTRIBUTES.Processor#">
<CFINPUT TYPE="TEXT" NAME="Username" VALUE="" REQUIRED="Yes" MESSAGE="Please enter a value."><INPUT TYPE="SUBMIT" NAME="SUBMIT" VALUE="Remind Me">
</CFFORM>
</P>
</CFIF>
