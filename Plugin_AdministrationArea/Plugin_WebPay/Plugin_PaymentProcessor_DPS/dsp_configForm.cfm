<CFOUTPUT>
<TABLE WIDTH="100%" BORDER="0" STYLE="border:thin black solid">
	<TR><TD COLSPAN="2" ><INPUT TYPE="CHECKBOX" NAME="DPS_Activated" VALUE="1" #IIF(ATTRIBUTES.DPS_Activated eq 1, DE('CHECKED'), DE(''))#> DPS Online Authorization</TD></TR>
	<TR><TD WIDTH="30%"><STRONG>Account</STRONG> </TD>
		<TD><INPUT TYPE="TEXT" NAME="DPSAccount" SIZE="20" VALUE="#ATTRIBUTES.DPSAccount#"></TD>
	</TR>
	<TR><TD><STRONG>Password</STRONG> </TD>
		<TD><INPUT TYPE="PASSWORD" NAME="DPSPassword" SIZE="7" VALUE="#ATTRIBUTES.DPSPassword#"></TD>
	</TR>	
	<TR><TD><STRONG>Currency</STRONG><BR><SMALL>Using a currency other than NZD requires that you have a multi-currency account with DPS.</SMALL> </TD>
		<TD><INPUT TYPE="TEXT" NAME="DPSCurrency" SIZE="4" MAXLENGTH="3" VALUE="#ATTRIBUTES.DPSCurrency#"></TD>
	</TR>
	<TR><TD><STRONG>Test Mode</STRONG> </TD>
		<TD><INPUT TYPE="CHECKBOX" NAME="DPS_TestMode" VALUE="1" #IIF(ATTRIBUTES.DPS_TestMode eq 1, DE('CHECKED'), DE(''))#></TD>
	</TR>
	<TR><TD VALIGN="TOP"><STRONG>Accept</STRONG> </TD>
		<TD><INPUT TYPE="CHECKBOX" NAME="DPS_Accept_AMEX" VALUE="1" #IIF(ATTRIBUTES.DPS_Accept_AMEX eq 1, DE('CHECKED'), DE(''))#> American Express<BR>
			<INPUT TYPE="CHECKBOX" NAME="DPS_Accept_VISA" VALUE="1" #IIF(ATTRIBUTES.DPS_Accept_VISA eq 1, DE('CHECKED'), DE(''))#> Visa<BR>
			<INPUT TYPE="CHECKBOX" NAME="DPS_Accept_MCARD" VALUE="1" #IIF(ATTRIBUTES.DPS_Accept_MCARD eq 1, DE('CHECKED'), DE(''))#> MasterCard<BR>
			<INPUT TYPE="CHECKBOX" NAME="DPS_Accept_BCARD" VALUE="1" #IIF(ATTRIBUTES.DPS_Accept_BCARD eq 1, DE('CHECKED'), DE(''))#> BankCard</TD>
	</TR>
	<TR><TD><STRONG>Request CvC2</STRONG> </TD>
		<TD><INPUT TYPE="CHECKBOX" NAME="DPS_AskCvC2" VALUE="1" #IIF(ATTRIBUTES.DPS_AskCvC2 eq 1, DE('CHECKED'), DE(''))#>
		</TD>
	</TR>
</TABLE>
</CFOUTPUT>