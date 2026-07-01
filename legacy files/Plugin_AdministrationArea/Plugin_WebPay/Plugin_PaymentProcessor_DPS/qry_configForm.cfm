<CFSILENT>

	<CFIF IsDefined("CFG.WebPay.Processor.DPS")>
		<CFSET CurrentCFG = Duplicate(CFG.WebPay.Processor.DPS)>
	<CFELSE>
		<CFSET CurrentCFG = StructNew()>
	</CFIF>
	
	<CFLOOP LIST="Activated,Accept_AMEX,Accept_VISA,Accept_MCARD,Accept_BCARD,AskCvC2,TestMode" INDEX="Field">
		<CFIF NOT IsDefined("CurrentCFG.#Field#")>
			<CFSET CurrentCFG[Field] = 0>
		</CFIF>
		<CFIF NOT IsDefined("ATTRIBUTES.DPS_#Field#")>
			<CFIF NOT IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
				<CFSET ATTRIBUTES["DPS_" & Field] = CurrentCFG[Field]>
			<CFELSE>
				<CFSET ATTRIBUTES["DPS_" & Field] = 0>
			</CFIF>
		</CFIF>
	</CFLOOP>
	
	<CFPARAM NAME="CurrentCFG.DPSAccount" DEFAULT="">
	<CFPARAM NAME="CurrentCFG.DPSPassword" DEFAULT="">
	<CFPARAM NAME="CurrentCFG.DPSCurrency" DEFAULT="NZD">
	
	<CFPARAM NAME="ATTRIBUTES.DPSAccount" DEFAULT="#CurrentCFG.DPSAccount#">
	<CFPARAM NAME="ATTRIBUTES.DPSPassword" DEFAULT="#CurrentCFG.DPSPassword#">
	<CFPARAM NAME="ATTRIBUTES.DPSCurrency" DEFAULT="#CurrentCFG.DPSCurrency#">
	
</CFSILENT>