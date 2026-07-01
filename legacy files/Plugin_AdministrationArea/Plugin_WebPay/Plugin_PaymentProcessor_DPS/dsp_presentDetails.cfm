<CFOUTPUT>
<TABLE WIDTH="100%">
	<TR><TH ALIGN="LEFT" WIDTH="40%">Account :</TH><TD>#PaymentDetails.Config.DPSAccount#</TD></TR>
	<CFIF IsDefined("PaymentDetails.ClientID")>
	<TR><TH ALIGN="LEFT">Client ID:</TH><TD>#PaymentDetails.ClientID#</TD></TR>
	<TR><TH ALIGN="LEFT">TxnRef :</TH><TD>#PaymentDetails.TxnRef#</TD></TR>
	</CFIF>
	<CFIF IsDefined("PaymentDetails.Amount")>
		<TR><TH ALIGN="LEFT">Total Charged :</TH><TD>#PaymentDetails.Amount# #PaymentDetails.Config.DPSCurrency#</TD></TR>
	</CFIF>
</TABLE>
</CFOUTPUT>