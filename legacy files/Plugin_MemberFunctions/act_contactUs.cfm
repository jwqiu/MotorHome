<CFIF isDefined("Do_#ATTRIBUTES.FuseAction#")>
<CFMAIL TO="#CFG.EmailAddress#" FROM="#ATTRIBUTES.Email#" SUBJECT="MotorhomeExchange-Sell.com user comment" TYPE="HTML">
<HTML>
<BODY>
<TABLE>
<TR><TD><B>Name</B></TD><TD>#ATTRIBUTES.Name#</TD></TR>
<TR><TD><B>Address</B></TD><TD>#ATTRIBUTES.Address1#</TD></TR>
<TR><TD>&nbsp;</TD><TD>#ATTRIBUTES.Address2#</TD></TR>
<TR><TD>&nbsp;</TD><TD>#ATTRIBUTES.Address3#</TD></TR>
<TR><TD><B>Country</B></TD><TD>#ATTRIBUTES.Country#</TD></TR>
<TR><TD><B>Phone</B></TD><TD>#ATTRIBUTES.Phone#</TD></TR>
<TR><TD><B>Fax</B></TD><TD>#ATTRIBUTES.Fax#</TD></TR>
<TR><TD><B>e-mail</B></TD><TD>#ATTRIBUTES.email#</TD></TR>
</TABLE>
<BR>
#Replace(HTMLEditFormat(ATTRIBUTES.Comments),"#Chr(10)#","<BR>","ALL")#
</BODY>
</HTML>
</CFMAIL>
</CFIF>