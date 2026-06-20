<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		
		<!--- Make sure there are no problems --->
		<CFIF ATTRIBUTES.Manual_Activated>
			<!--- Manual is enabled, make sure that at least one card is accepted --->
			<CFSET ACardAccepted = 0>
			<CFLOOP LIST="Accept_AMEX,Accept_VISA,Accept_MCARD,Accept_BCARD,Accept_DISCOVER,Accept_DINERS" INDEX="Field">
				<CFSET ACardAccepted = ACardAccepted + Attributes["Manual_" & Field]>
			</CFLOOP>
			<CFIF NOT ACardAccepted>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";To use the manual processor you must specify at least one card to accept with that processor.">
			</CFIF>
		</CFIF>
		
		
		
		<!--- If all is ok, build a config structure and save it --->
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFSET NewCFG = StructNew()>
			<CFLOOP LIST="Activated,Accept_AMEX,Accept_VISA,Accept_MCARD,Accept_BCARD,Accept_DISCOVER,Accept_DINERS,AskCvC2" INDEX="Field">
				<CFSET NewCFG[Field] = ATTRIBUTES["Manual_" & Field]>
			</CFLOOP>
			<CFSET NewCFG.DisplayName = "Manual Credit Card Processing">
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.Processor.Manual" VALUE=#NewCFG# />
			
		</CFIF>
		
		
	</CFIF>
</CFSILENT>