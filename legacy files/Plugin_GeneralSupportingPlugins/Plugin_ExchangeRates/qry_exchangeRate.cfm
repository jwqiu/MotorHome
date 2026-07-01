<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.From">
	<CFPARAM NAME="ATTRIBUTES.To">
	
	<CFLOCK SCOPE="APPLICATION" TYPE="EXCLUSIVE" TIMEOUT="10">
		<!--- First make sure that we have the application exchange rates structure --->
		<CFPARAM NAME="APPLICATION.ExchangeRates" DEFAULT=#StructNew()#>
	
		<!--- Ok, do we have this currency already ? --->
		<CFIF IsDefined("APPLICATION.ExchangeRates.#ATTRIBUTES.From#.#ATTRIBUTES.To#")>
			<!--- We have this already, just return what we know --->
			<CFSET ATTRIBUTES.ExchangeRate = APPLICATION.ExchangeRates[ATTRIBUTES.From][ATTRIBUTES.To]>
		<CFELSE>
			<!--- We don't have this yet --->
			
			<!--- Make sure we have a structure for the from currency --->
			<CFPARAM NAME="APPLICATION.ExchangeRates.#ATTRIBUTES.From#" DEFAULT=#StructNew()#>
			
			<!--- Now do the conversion --->
			<CFX_EXCHANGERATES ACTION="GET" SOURCE="#ATTRIBUTES.From#" DEST="#ATTRIBUTES.To#" VARIABLE="RATE">
			
			<!--- Save the result --->
			<CFSET APPLICATION.ExchangeRates[ATTRIBUTES.From][ATTRIBUTES.To] = RATE>
			<CFSET ATTRIBUTES.ExchangeRate = RATE>
		</CFIF>	
	</CFLOCK>	
</CFSILENT>