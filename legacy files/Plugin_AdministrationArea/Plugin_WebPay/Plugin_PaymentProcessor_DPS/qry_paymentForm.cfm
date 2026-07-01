<CFSILENT>
<!--- Make sure we are activated --->
	<CFIF NOT (IsDefined("CFG.WebPay.Processor.DPS.Activated") AND CFG.WebPay.Processor.DPS.Activated)>
		<CFTHROW TYPE="#ATTRIBUTES.FuseAction#" DETAIL="This payment processor (#ATTRIBUTES.FuseAction#) is not activated.">
	</CFIF>
	
	<CFSET Config = CFG.WebPay.Processor.DPS>
</CFSILENT>