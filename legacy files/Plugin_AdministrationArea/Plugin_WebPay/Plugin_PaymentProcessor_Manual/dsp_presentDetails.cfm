<CFOUTPUT>

 <TABLE  BORDER="0" CELLSPACING="3" CELLPADDING="0" WIDTH="100%">
	        <TR> 
	          <TD><STRONG><CFSWITCH EXPRESSION="#PaymentDetails.CardType#"><CFCASE VALUE="MCARD">MasterCard</CFCASE><CFCASE VALUE="BCARD">BankCard</CFCASE><CFCASE VALUE="AMEX">American Express</CFCASE><CFDEFAULTCASE>#PaymentDetails.CardType#</CFDEFAULTCASE></CFSWITCH></STRONG></TD>
			  <CFIF isDefined("PaymentDetails.CardCvC2")>
			  <TD ALIGN="RIGHT">CvC2 :</TD>
	          <TD ALIGN="RIGHT"><STRONG>#PaymentDetails.CardCvC2#</STRONG></TD>
			  <CFELSE>
			  <TD COLSPAN="2">&nbsp;</TD>
			  </CFIF>
	        </TR>
	        <TR>
	          <TD ALIGN="CENTER" COLSPAN="3">
			  <CFSET ATTRIBUTES.CrNumber = ReReplace(PaymentDetails.CardNumber, "[^0-9]", "", "ALL")>
			  
			  <CFIF ReFind("^([0-9]{4,4}){4,4}$", ATTRIBUTES.CrNumber)>
			  	<STRONG>#ReReplace(ATTRIBUTES.CrNumber, "([0-9]{4,4})([0-9]{4,4})([0-9]{4,4})([0-9]{4,4})", "\1 - \2 - \3 - \4")#</STRONG>
			  <CFELSE>
			  	<STRONG>#ATTRIBUTES.CrNumber#</STRONG>
			  </CFIF>
			  </TD>
	        </TR>
	
	        <TR> 
	          <TD><STRONG>#UCase(PaymentDetails.CardName)#</STRONG></TD>
			  <TD ALIGN="RIGHT">Expires :</TD>
	          <TD ALIGN="RIGHT"><STRONG>#PaymentDetails.CardExpiryMonth#/#PaymentDetails.CardExpiryYear#</STRONG></TD>
	        </TR>
	      </TABLE>
</CFOUTPUT>