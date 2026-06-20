<CFOUTPUT>
<TABLE WIDTH="100%" BORDER="0" STYLE="border:thin black solid">
	<TR><TD COLSPAN="2" ><INPUT TYPE="CHECKBOX" NAME="Manual_Activated" VALUE="1" #IIF(ATTRIBUTES.Manual_Activated eq 1, DE('CHECKED'), DE(''))#> Manual Processing</TD></TR>
	<TR><TD VALIGN="TOP" WIDTH="30%"><STRONG>Accept</STRONG> : </TD>
		<TD><INPUT TYPE="CHECKBOX" NAME="Manual_Accept_AMEX" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_AMEX eq 1, DE('CHECKED'), DE(''))#> American Express<BR>
			<INPUT TYPE="CHECKBOX" NAME="Manual_Accept_VISA" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_VISA eq 1, DE('CHECKED'), DE(''))#> Visa<BR>
			<INPUT TYPE="CHECKBOX" NAME="Manual_Accept_MCARD" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_MCARD eq 1, DE('CHECKED'), DE(''))#> MasterCard<BR>
			<INPUT TYPE="CHECKBOX" NAME="Manual_Accept_BCARD" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_BCARD eq 1, DE('CHECKED'), DE(''))#> BankCard<BR>
			<INPUT TYPE="CHECKBOX" NAME="Manual_Accept_DISCOVER" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_DISCOVER eq 1, DE('CHECKED'), DE(''))#> Discover<BR>
			<INPUT TYPE="CHECKBOX" NAME="Manual_Accept_DINERS" VALUE="1" 
				#IIF(ATTRIBUTES.Manual_Accept_DINERS eq 1, DE('CHECKED'), DE(''))#> Diners</TD>
	</TR>
	<TR><TD VALIGN="TOP"><STRONG>Request CvC2</STRONG> : </TD>
		<TD>
			<INPUT TYPE="CHECKBOX" NAME="Manual_AskCvC2" VALUE="1" 
				   #IIF(ATTRIBUTES.Manual_AskCvC2 eq 1, DE('CHECKED'), DE(''))#>
		</TD>
	</TR>
</TABLE>
</CFOUTPUT>