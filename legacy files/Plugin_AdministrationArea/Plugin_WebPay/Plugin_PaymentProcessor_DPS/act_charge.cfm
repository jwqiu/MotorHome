<CFSILENT>
	<!--- First make sure we have the details we need --->
	<CFIF NOT (IsDefined("CFG.WebPay.Processor.DPS.Activated") AND CFG.WebPay.Processor.DPS.Activated)>
		<CFTHROW TYPE="#ATTRIBUTES.FuseAction#" 
				 DETAIL="This payment processor (#ATTRIBUTES.FuseAction#) is not activated.">
	</CFIF>
	
	<CFSET Config = CFG.WebPay.Processor.DPS>
	
	<CFPARAM NAME="ATTRIBUTES.Total"   >
	<CFPARAM NAME="ATTRIBUTES.Currency" DEFAULT="#Config.DPSCurrency#"> 
					<!--- If this isn't the same as the processor's designated currency
						- a conversion will be done first --->						 
	<CFPARAM NAME="ATTRIBUTES.DPS_CardType"        DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.DPS_CardName"        DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.DPS_CardNumber"      DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.DPS_CardExpiryMonth" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.DPS_CardExpiryYear"  DEFAULT="">
	
	<CFIF NOT 
	(	Len(ATTRIBUTES.DPS_CardType)
	AND	Len(ATTRIBUTES.DPS_CardName)
	AND Len(ATTRIBUTES.DPS_CardNumber)
	AND Len(ATTRIBUTES.DPS_CardExpiryMonth)
	AND Len(ATTRIBUTES.DPS_CardExpiryYear)
	)>
		<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";Please supply all of your credit card details.">
	</CFIF>
	
	
	
	<CFIF Config.AskCvC2>
		<CFPARAM NAME="ATTRIBUTES.DPS_CardCvC2"  DEFAULT="">
		<CFIF NOT Len(ATTRIBUTES.DPS_CardCvC2)>
			<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";You must enter your CvC2 number.">
		</CFIF>
	</CFIF>
	
	<!--- Ok, if no errors have occured yet, we can do a transaction --->
	<CFOBJECT ACTION="CREATE" CLASS="DPSAUTH.DpsAuthCtrl" TYPE="COM" NAME="DPSAUTH" >

	<!--- Load the com object --->
	<CFSET DPSAUTH.TxnType        = "P">
	<CFSET DPSAUTH.ClientType     = "W">
	<CFIF ATTRIBUTES.Currency neq Config.DPSCurrency>
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="exchangeRate" 
				  FROM="#ATTRIBUTES.Currency#" TO="#Config.DPSCurrency#" />
		<CFSET ATTRIBUTES.Amount = decimalFormat(ATTRIBUTES.Total * CFMODULE.ATTRIBUTES.exchangeRate)>
	<CFELSE>
		<CFSET ATTRIBUTES.Amount = decimalFormat(ATTRIBUTES.Total)>
	</CFIF>
	<CFSET DPSAUTH.Amount = ReReplace(ATTRIBUTES.Amount, "[^0-9.]", "", "ALL")>
	<CFSET DPSAUTH.Currency = Config.DPSCurrency>
	<CFSET DPSAUTH.ReceiptEmailAddress = "#ATTRIBUTES.Email#">
		
		
	<CFIF Config.TestMode>
		<!--- We must do a "test mode" transaction --->
		<!--- If a password is supplied, presume account is a username instead of account --->
		<CFIF NOT Len(Config.DPSPassword)>
			<CFSET DPSAUTH.Account        = "9997">
		<CFELSE>
			<CFSET DPSAUTH.Username       = "Digiweb_Dev">
			<CFSET DPSAUTH.Password       = "testonly">
		</CFIF>
	<CFELSE>
		<!--- a full on transaction --->
		<!--- If a password is supplied, presume account is a username instead of account --->
		<CFIF NOT Len(Config.DPSPassword)>
			<CFSET DPSAUTH.Account        = "#Config.DPSAccount#">
		<CFELSE>
			<CFSET DPSAUTH.Username       = "#Config.DPSAccount#">
			<CFSET DPSAUTH.Password       = "#Config.DPSPassword#">
		</CFIF>
	</CFIF>	
	
	<CFSET DPSAUTH.DateExpiry     = "#ATTRIBUTES.DPS_CardExpiryMonth##ATTRIBUTES.DPS_CardExpiryYear#">
	<CFSET DPSAUTH.CardHolderName = "#ATTRIBUTES.DPS_CardName#">
	<CFSET DPSAUTH.CardNumber     = "#ReReplace(ATTRIBUTES.DPS_CardNumber, '[^0-9]', '', 'ALL')#">
	<CFIF Config.AskCvC2>
		<CFSET DPSAUTH.Cvc2       = "#Left(TRIM(ATTRIBUTES.DPS_CardCvC2), 4)#">
	</CFIF>
	
	<!--- Run the authorisation --->
	<CFSET DPSAUTH.DoAuthorize()>

	<!--- Check for an exception based error --->
	<CFIF DPSAUTH.StatusNeeded>
		<!--- Have to loop to find out if fail/success --->
		<CFLOOP CONDITION="DPSAUTH.StatusNeeded">
			<CFSET DPSAUTH.DoDelay()>
			<CFSET DPSAUTH.ClientID = DPSAUTH.ClientID>
			<CFSET DPSAUTH.TxnRef   = DPSAUTH.TxnRef>
			<CFSET DPSAUTH.DoStatus()>
		</CFLOOP>
	</CFIF>
	
	<!--- If it fails, mark the error --->
	<CFIF  NOT DPSAUTH.Success>
		<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors 
			& ";The system was unable to charge your card #CFG.WebShop.CurrencySymbol##decimalFormat(ATTRIBUTES.Total)# #CFG.WebShop.Currency#, the specific error was : (#DPSAuth.ResponseCode#) #DPSAuth.ResponseText#.">
	</CFIF>
	
	<!--- If everything is ok at this point, save the details into a WDDX --->
	<CFSET x = StructNew()>
	<CFSET x.Processor = "DPS">
	<CFSET x.Config    = Config>
	<CFSET x.Amount    = ATTRIBUTES.Amount>
	<CFIF NOT Len(ATTRIBUTES.entryErrors)>
		<CFLOOP LIST="AuthCode,CardName,ClientId,DateSettlement,HostDate,HostTime,PreAuthNumber,ResponseCode,ResponseText,Success,TxnRef,VersionMajor,VersionMinor,VersionRevision" INDEX="varName">
			<CFSET x[varName] = Evaluate("DPSAUTH.#varName#")>
		</CFLOOP>
	</CFIF>	
	<CFWDDX ACTION="CFML2WDDX" INPUT=#x# OUTPUT="ATTRIBUTES.paymentDetailsWDDX">
	
</CFSILENT>