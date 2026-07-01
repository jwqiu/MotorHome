
<CFSILENT>

	<CFIF IsDefined("CFG.WebPay.Processor.Manual")>
		<CFSET CurrentCFG = Duplicate(CFG.WebPay.Processor.Manual)>
	<CFELSE>
		<CFSET CurrentCFG = StructNew()>
	</CFIF>
	
	<CFLOOP LIST="Activated,Accept_AMEX,Accept_VISA,Accept_MCARD,Accept_BCARD,Accept_DISCOVER,Accept_DINERS,AskCvC2" INDEX="Field">
		<CFIF NOT IsDefined("CurrentCFG.#Field#")>
			<CFSET CurrentCFG[Field] = 0>
		</CFIF>
		<CFIF NOT IsDefined("ATTRIBUTES.Manual_#Field#")>
			<CFIF NOT IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
				<CFSET ATTRIBUTES["Manual_" & Field] = CurrentCFG[Field]>
			<CFELSE>
				<CFSET ATTRIBUTES["Manual_" & Field] = 0>
			</CFIF>
		</CFIF>
	</CFLOOP>
	
</CFSILENT>
