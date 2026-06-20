<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		
		<!--- Ensure that we have some stuff --->
		<CFIF NOT Len(ATTRIBUTES.AcceptedURL)>
			<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";You must specify an Accepted URL.">
		</CFIF>
		
		<CFIF NOT pb_serviceAvailable("configureWebShop")>
			<CFIF NOT (Len(ATTRIBUTES.Currency) AND Len(ATTRIBUTES.CurrencySymbol))>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";You must specify your currency and currency symbol.">
			</CFIF>
		</CFIF>
		
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="Manual_configForm" 
			DO_MANUAL_CONFIGFORM="Yes" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
		<CFSET ATTRIBUTES.EntryErrors = CFMODULE.ATTRIBUTES.entryErrors>
		
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="DPS_configForm" 
			DO_DPS_CONFIGFORM="Yes" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
		<CFSET ATTRIBUTES.EntryErrors = CFMODULE.ATTRIBUTES.entryErrors>
		
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.AcceptedURL" 
				VALUE="#ATTRIBUTES.AcceptedURL#"/>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.NotifyURL" 
				VALUE="#ATTRIBUTES.NotifyURL#"  />
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.PaymentTitleImage" 
				VALUE="#ATTRIBUTES.PaymentTitleImage#"  />
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.PaymentButton" 
				VALUE="#ATTRIBUTES.PaymentButton#"  />
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebPay.AcceptedTitleImage" 
				VALUE="#ATTRIBUTES.AcceptedTitleImage#"  />
			<CFIF NOT pb_serviceAvailable("configureWebShop")>
				<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebShop.Currency" 
					VALUE="#ATTRIBUTES.Currency#"  />
				<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="storeInConfig" KEY="WebShop.CurrencySymbol" 
					VALUE="#ATTRIBUTES.CurrencySymbol#"  />
			</CFIF>	
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=administration&ForceCFGReload=1" >
		</CFIF>
	</CFIF>
</CFSILENT>