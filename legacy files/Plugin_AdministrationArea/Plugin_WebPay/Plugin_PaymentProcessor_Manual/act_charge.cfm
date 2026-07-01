<CFSILENT>
	<!--- First make sure we have the details we need --->
	<CFIF NOT (IsDefined("CFG.WebPay.Processor.Manual.Activated") AND CFG.WebPay.Processor.Manual.Activated)>
		<CFTHROW TYPE="#ATTRIBUTES.FuseAction#" 
				 DETAIL="This payment processor (#ATTRIBUTES.FuseAction#) is not activated.">
	</CFIF>
	
	<CFSET Config = CFG.WebPay.Processor.Manual>
	
	<CFPARAM NAME="ATTRIBUTES.Total"   >
						 
	<CFPARAM NAME="ATTRIBUTES.Manual_CardType"        DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Manual_CardName"        DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Manual_CardNumber"      DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Manual_CardExpiryMonth" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Manual_CardExpiryYear"  DEFAULT="">
	
	<CFIF NOT 
	(	Len(ATTRIBUTES.Manual_CardType)
	AND	Len(ATTRIBUTES.Manual_CardName)
	AND Len(ATTRIBUTES.Manual_CardNumber)
	AND Len(ATTRIBUTES.Manual_CardExpiryMonth)
	AND Len(ATTRIBUTES.Manual_CardExpiryYear)
	)>
		<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";Please supply all of your credit card details.">
	</CFIF>

	<CFIF Config.AskCvC2>
		<CFPARAM NAME="ATTRIBUTES.Manual_CardCvC2"  DEFAULT="">
		<CFIF NOT Len(ATTRIBUTES.Manual_CardCvC2)>
			<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";You must enter your CvC2 number.">
		</CFIF>
	</CFIF>
	
	<!--- If everything is ok at this point, save the details into a WDDX --->
	<CFSET x = StructNew()>
	<CFSET x.Processor = "Manual">
	<CFSET x.Config = Config>
	<CFSET x.Amount    = ATTRIBUTES.Total>
	<CFIF NOT Len(ATTRIBUTES.entryErrors)>

		<CFSET x.CardType = ATTRIBUTES.Manual_CardType>
		<CFSET x.CardName = ATTRIBUTES.Manual_CardName>
		<CFSET x.CardNumber = ATTRIBUTES.Manual_CardNumber>
		<CFSET x.CardExpiryMonth = ATTRIBUTES.Manual_CardExpiryMonth>
		<CFSET x.CardExpiryYear = ATTRIBUTES.Manual_CardExpiryYear>

		<CFIF Config.AskCvC2>
			<CFSET x.CardCvC2 = ATTRIBUTES.Manual_CardCvC2>
		</CFIF>
		

	</CFIF>	
	<CFWDDX ACTION="CFML2WDDX" INPUT=#x# OUTPUT="ATTRIBUTES.paymentDetailsWDDX">
	
</CFSILENT>