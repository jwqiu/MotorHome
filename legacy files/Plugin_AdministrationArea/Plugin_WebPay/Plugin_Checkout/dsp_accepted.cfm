<CFIF NOT isDefined("ATTRIBUTES.NoCharge")>
<P>
Your details have been recorded and will be processed as soon as possible.  Once your payment has been processed your details will be deleted from our system for your security and privacy.
</P>
</CFIF>
<CFOUTPUT>
<CFIF Len(CFG.WebPay.AcceptedURL)>
	<SCRIPT language="Javascript">
		document.write('#JSStringFormat("<P>This page will <A HREF=""#CFG.WebPay.AcceptedURL#&Reference=#URLEncodedFormat(ATTRIBUTES.Reference)#"">redirect</A> in a few seconds.</P>")#');
		window.setTimeout("document.location='#JSStringFormat("#CFG.WebPay.AcceptedURL#&Reference=#URLEncodedFormat(ATTRIBUTES.Reference)#")#'", 5000);
	</SCRIPT>
	<NOSCRIPT>
		<P>
			Your web browser does not have javascript enabled, please 
			<A HREF="#CFG.WebPay.AcceptedURL#&Reference=#URLEncodedFormat(ATTRIBUTES.Reference)#">click here</A> to continue.
		</P>
	</NOSCRIPT>
</CFIF>
</CFOUTPUT>
<!---
<CFDUMP VAR=#CFG#>
<CFDUMP VAR=#PLUGBOX#>
<CFDUMP VAR=#ATTRIBUTES#>
<CFDUMP VAR=#REQUEST#>
<CFDUMP VAR=#SESSION#>
<CFDUMP VAR=#APPLICATION#>
--->