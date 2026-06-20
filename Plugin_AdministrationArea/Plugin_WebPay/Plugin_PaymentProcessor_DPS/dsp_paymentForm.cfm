<SCRIPT language="JavaScript" TYPE="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</SCRIPT>
 <CFOUTPUT>
<TABLE BORDER="0" WIDTH="100%">
	<TR>
		<TH ALIGN="LEFT" WIDTH="33%">Type Of Credit Card :</TH>
		<TD>
		<SELECT NAME="DPS_CardType" class="formstylre">
			<CFIF IsDefined("Config.Accept_AMEX") AND Config.Accept_AMEX   >
				<OPTION VALUE="AMEX">American Express</OPTION>
			</CFIF>
			<CFIF IsDefined("Config.Accept_VISA") AND Config.Accept_VISA   >
				<OPTION VALUE="VISA">Visa</OPTION>
			</CFIF>
			<CFIF IsDefined("Config.Accept_BCARD") AND Config.Accept_BCARD >
				<OPTION VALUE="BCARD">BankCard</OPTION>
			</CFIF>
			<CFIF IsDefined("Config.Accept_MCARD") AND Config.Accept_MCARD >
				<OPTION VALUE="MCARD">MasterCard</OPTION>
			</CFIF>
		</SELECT>
		</TD>
	</TR>
	<TR>
		<TH ALIGN="LEFT">Credit Card Number :</TH>
		<TD>
			<CFINPUT TYPE="TEXT" NAME="DPS_CardNumber" VALUE=""  MESSAGE="Please enter the number on your credit card." VALIDATE="CREDITCARD" SIZE="20" class="formstylre">
		</TD>
	</TR>
	
	<TR>
		<TH ALIGN="LEFT">Expiry Date :</TH>
		<TD>
			<SELECT NAME="DPS_CardExpiryMonth" class="formstylre">
				<CFLOOP FROM="1" TO="12" INDEX="Month">
					<CFIF Len(Month) eq 1>
					<OPTION VALUE="0#Month#">0#Month#</OPTION>
					<CFELSE>
					<OPTION VALUE="#Month#">#Month#</OPTION>
					</CFIF>
				</CFLOOP>
			</SELECT>
			<SELECT NAME="DPS_CardExpiryYear" class="formstylre">
				<CFLOOP FROM="#Right(Year(Now()), 2)#" TO="#Evaluate('Right(Year(Now()), 2) + 20')#" INDEX="Year">
					<CFIF Len(Year) eq 1>
					<OPTION VALUE="0#Year#">0#Year#</OPTION>
					<CFELSE>
					<OPTION VALUE="#Year#">#Year#</OPTION>
					</CFIF>
				</CFLOOP>
			</SELECT>
		</TD>
	</TR>
	
	<TR>
		<TD ALIGN="LEFT"><STRONG>Holder Name :</STRONG></TD>
		<TD VALIGN="TOP">
			<CFINPUT TYPE="TEXT" NAME="DPS_CardName" VALUE=""  MESSAGE="Please enter the name on your credit card." SIZE="20" class="formstylre">
		</TD>
	</TR>
	
	
	<CFIF Config.AskCvC2>
	<TR>
		<TD ALIGN="LEFT"><STRONG>CvC2 :</STRONG><BR>
	 	<SMALL>(<A HREF="##" onClick="MM_openBrWindow('#CGI.SCRIPT_NAME#?FuseAction=cvc2','cvc2','scrollbars=yes,resizable=yes,width=400,height=400')">What 
	 is CvC2</A>)</SMALL></TD>
		<TD>
			<CFINPUT TYPE="TEXT" NAME="DPS_CardCvC2" VALUE="" SIZE="4" MAXLENGTH="4" MESSAGE="Please enter the CvC2 number on your credit card."  class="formstylre">
		</TD>
	</TR>
	</CFIF>
</TABLE>
</CFOUTPUT>