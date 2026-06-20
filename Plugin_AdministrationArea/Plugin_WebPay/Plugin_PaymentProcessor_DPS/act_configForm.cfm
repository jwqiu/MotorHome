<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
	
		<!--- Validate the variables, setting attributes.entryErrors as necessary --->
		<CFIF Len(ATTRIBUTES.DPS_Activated) AND ATTRIBUTES.DPS_Activated>
			<CFIF NOT Len(ATTRIBUTES.DPSAccount)>
				<CFSET 
					ATTRIBUTES.entryErrors = 
					ATTRIBUTES.entryErrors & ";To use the DPS processor you must enter your DPS Account ID.">
			<CFELSEIF NOT Len(ATTRIBUTES.DPSCurrency)>
				<CFSET ATTRIBUTES.entryErrors = 
					   ATTRIBUTES.entryErrors & ";You must specify a currency to use for DPS transactions, use NZD if you are unsure.">
			<CFELSE>
				<CFIF (NOT IsNumeric(ATTRIBUTES.DPSAccount)) AND (Not Len(ATTRIBUTES.DPSPassword))>
					<CFSET 
						ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";Please enter your DPS Password.">
				<CFELSEIF IsNumeric(ATTRIBUTES.DPSAccount) AND  Len(ATTRIBUTES.DPSPassword)>
					<CFSET 
						ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";To use a numerical DPS Account you must not use a DPS password.">
				</CFIF>
			</CFIF>
		</CFIF>
		
		<!--- If all is ok, build a config structure and save it --->
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFSET NewCFG = StructNew()>
			<CFLOOP LIST="Activated,Accept_AMEX,Accept_VISA,Accept_MCARD,Accept_BCARD,AskCvC2,TestMode" INDEX="Field">
				<CFSET NewCFG[Field] = ATTRIBUTES["DPS_" & Field]>
			</CFLOOP>
			
			<CFSET NewCFG.DPSAccount  = ATTRIBUTES.DPSAccount>

			<CFSET NewCFG.DPSAccount  = ATTRIBUTES.DPSAccount>
			<CFSET NewCFG.DPSCurrency = ATTRIBUTES.DPSCurrency>
			<CFSET NewCFG.DPSPassword = ATTRIBUTES.DPSPassword>
			<CFSET NewCFG.DisplayName = "Online Credit Card Processing">
			
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.Processor.DPS" VALUE=#NewCFG# />
			
		</CFIF>
		
		
	</CFIF>
</CFSILENT>