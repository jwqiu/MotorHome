<CFSILENT>
	<!--- Make sure we are activated --->
	<CFIF NOT (IsDefined("CFG.WebPay.Processor.Manual.Activated") AND CFG.WebPay.Processor.Manual.Activated)>
		<CFTHROW TYPE="#ATTRIBUTES.FuseAction#" DETAIL="This payment processor (#ATTRIBUTES.FuseAction#) is not activated.">
	</CFIF>
	
	<CFSET Config = CFG.WebPay.Processor.Manual>
	
</CFSILENT>