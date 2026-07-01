<CFSILENT>	
	<CFPARAM NAME="ATTRIBUTES.Reference" DEFAULT="0">
	<CFIF IsDefined("CFG.WebPay.AcceptedTitleImage") AND Len(CFG.WebPay.AcceptedTitleImage)>
		<CFSET REQUEST.TitleImage = CFG.WebPay.AcceptedTitleImage>
	</CFIF>
</CFSILENT>