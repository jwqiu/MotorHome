<HTML>
<BODY>
<CFOUTPUT> 
 <CFIF Len(ATTRIBUTES.entryErrors)>
  <P> <STRONG>Error :</STRONG><BR>
   Please correct the following error<CFIF ListLen(ATTRIBUTES.entryErrors, ";")>s</CFIF>and try again... 
  <UL>
   <CFLOOP LIST="#ATTRIBUTES.entryErrors#" INDEX="error">
	<LI>#Error#</LI>
   </CFLOOP>
  </UL></P>
  
 </CFIF>
 <CFSCRIPT>
	function wf_paragraphFormat(text) {
		var tempText = "";
		// Checks to see if the text matches <HTML>.....</HTML>
		// if it does, just returns the text, if it doesn't it
		// turns it into HTMLEditFormat() then
		// makes newlines into <BR> and blank lines into <P>
		if (FindNoCase("<HTML>", text)) {
			return text;
		} else {
			tempText = text;
			
			tempText = HTMLEditFormat(tempText);

			tempText = Replace(tempText, Chr(13), "", "ALL");
			tempText = ReReplaceNoCase(tempText, "#CHR(10)##CHR(10)#", "<P>", "ALL");
			tempText = ReReplaceNoCase(tempText, "#CHR(10)#", "<BR>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[B\]", "<B>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/B\]", "</B>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[UL\]", "<UL>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/UL\]", "</UL>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[LI\]", "<LI>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/LI\]", "</LI>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[A HREF=&quot;([^]]*)&quot;\]", "<A HREF=""\1"">", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/A\]", "</A>", "ALL");
			
			return tempText;
		}
	}
</CFSCRIPT>
<CFIF ATTRIBUTES.Total NEQ 0>
<TABLE WIDTH="450"><TR><TD>
 <P> This page is on a Secure SSL enabled server. All information that is passed 
  between your computer and this server is encrypted for your protection. If you 
  have any questions regarding the security of this process, please contact : 
 </P><P> #CFG.WebSiteName#<BR>
  #wf_paragraphFormat(CFG.ContactDetails)# </P><P> The Credit Card information you supply may be retained by <SPAN class="mhe">MotorhomeExchange-Sell.com</SPAN> until payment has been verified, after which time all credit card 
  details are deleted from the system for your security and privacy. </P><HR>
</CFIF>
 <SCRIPT language="JavaScript">
	// The following function is used in the onSubmit of the payment form
	// it prevents the user hitting the submit button twice
	submitOnWay = 0;
	function submitOnce() {
		if (submitOnWay == 0) {
			submitOnWay = 1;
			return true;
		} else {
			return false;
		}
	}
</SCRIPT>

 <CFFORM ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=Yes" METHOD="POST" ONSUBMIT="submitOnce" >

	<CFIF ATTRIBUTES.Total EQ 0>

	   <INPUT TYPE="HIDDEN" NAME="Reference" VALUE="#HTMLEditFormat(ATTRIBUTES.Reference)#">
	   <INPUT TYPE="HIDDEN" NAME="Processor" VALUE="#ActiveProcessors#">
	   <INPUT TYPE="HIDDEN" NAME="Total" VALUE="#HTMLEditFormat(ATTRIBUTES.Total)#">
	   <INPUT TYPE="HIDDEN" NAME="Note" VALUE="#HTMLEditFormat(ATTRIBUTES.Note)#">
	   <INPUT TYPE="HIDDEN" NAME="Name" VALUE="#HTMLEditFormat(ATTRIBUTES.Name)#">
	   <INPUT TYPE="HIDDEN" NAME="Email" VALUE="#HTMLEditFormat(ATTRIBUTES.Email)#">
		
		<TABLE BORDER="0" WIDTH="450"><TR><TD>
		Your listing will have no charge as part of a promotion at <SPAN CLASS="mhe">Motorhomeexchange-Sell.com</SPAN>. Please click Continue to enter your listing details.

		<P ALIGN="center">
	  		<INPUT TYPE="SUBMIT" VALUE="Continue" class="formstylre">
		</P>
		</TD></TR></TABLE>
		
	<CFELSE>
 
	  <TABLE BORDER="0" WIDTH="450">
	   <TR>
		<TH ALIGN="LEFT" WIDTH="33%">Reference :</TH><TD>#ATTRIBUTES.Reference#</TD></TR>
	   <INPUT TYPE="HIDDEN" NAME="Reference" VALUE="#HTMLEditFormat(ATTRIBUTES.Reference)#">
	   <TR>
		<TH ALIGN="LEFT">Total :</TH><TD>#CFG.WebShop.CurrencySymbol# #DecimalFormat(ATTRIBUTES.Total)# #CFG.WebShop.Currency# <CFIF Len(ATTRIBUTES.Note)>
		  (#ATTRIBUTES.Note#)</CFIF></TD></TR>
	   <INPUT TYPE="HIDDEN" NAME="Total" VALUE="#HTMLEditFormat(ATTRIBUTES.Total)#">
	   <INPUT TYPE="HIDDEN" NAME="Note" VALUE="#HTMLEditFormat(ATTRIBUTES.Note)#">
	   <TR>
		<TH ALIGN="LEFT">Your Full Name :</TH><TD><CFINPUT TYPE="TEXT" NAME="Name" VALUE="#ATTRIBUTES.Name#" REQUIRED="Yes" MESSAGE="Please enter your full name." class="formstylre"></TD>
	   </TR>
	   <TR>
		<TH ALIGN="LEFT">Your email Address :</TH><TD><CFINPUT TYPE="TEXT" NAME="Email" VALUE="#ATTRIBUTES.Email#" REQUIRED="yes" MESSAGE="Please enter a valid email address." VALIDATE="RegULAR_EXPRESSION" PATTERN="^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" class="formstylre"></TD>
	   </TR>
	  </TABLE>
	
	  <CFIF ListLen(ActiveProcessors) GT 1>
	  <P>
	  	This web site can accept payment in #ListLen(ActiveProcessors)# different ways, 
		please select your preferred method and complete the details required by that method.
	  </P>
	  <TABLE BORDER="0" WIDTH="100%">
	  	<CFLOOP LIST="#ActiveProcessors#" INDEX="Processor">
			<TR><TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="Processor" VALUE="#Processor#"> #Processor#</TH></TR>
			<TR><TD ALIGN="RIGHT"><CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="#Processor#_paymentForm" ATTRIBUTECOLLECTION=#ATTRIBUTES# /></TD></TR>
			<TR><TD><P>&nbsp;</P><P>&nbsp;</P></TD></TR>
		</CFLOOP>
	  </TABLE>
	  <CFELSE>
	  	<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="#ActiveProcessors#_paymentForm" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
	  	<INPUT TYPE="HIDDEN" NAME="Processor" VALUE="#ActiveProcessors#">
	  </CFIF>

  </CFIF>

  <CFIF ATTRIBUTES.Total NEQ 0>
  <P ALIGN="CENTER"> 
  
   <CFIF IsDefined("CFG.WebPay.PaymentButton") AND Len(CFG.WebPay.PaymentButton)>
	<INPUT TYPE="IMAGE" SRC="#CFG.WebPay.PaymentButton#" ALT="SUBMIT" >
	<CFELSE>
	<INPUT TYPE="SUBMIT" VALUE="SUBMIT" class="formstylre">
   </CFIF>
  </P>
  </CFIF>
  
  <INPUT TYPE="HIDDEN" NAME="FurtherDetailsWDDX" VALUE="#HTMLEditFormat(ATTRIBUTES.FurtherDetailsWDDX)#">
 </CFFORM>
 </TD></TR></TABLE> 
</CFOUTPUT>
</BODY>
</HTML>