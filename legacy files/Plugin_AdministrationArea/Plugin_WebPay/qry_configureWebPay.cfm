<CFSILENT>
	<CFIF IsDefined("CFG.WebPay")>
		<CFSET Config = CFG.WebPay>
	<CFELSE>
		<CFSET Config = StructNew()>
	</CFIF>

	<CFPARAM NAME="Config.AcceptedURL" DEFAULT="">
	<CFPARAM NAME="Config.NotifyURL"   DEFAULT="">
	<CFPARAM NAME="Config.PaymentTitleImage"   DEFAULT="">
	<CFPARAM NAME="Config.PaymentButton"   DEFAULT="">
	<CFPARAM NAME="Config.AcceptedTitleImage"   DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.AcceptedURL" DEFAULT="#Config.AcceptedURL#">
	<CFPARAM NAME="ATTRIBUTES.NotifyURL"   DEFAULT="#Config.NotifyURL#">
	<CFPARAM NAME="ATTRIBUTES.PaymentTitleImage"   DEFAULT="#Config.PaymentTitleImage#">
	<CFPARAM NAME="ATTRIBUTES.PaymentButton"   DEFAULT="#Config.PaymentButton#">
	<CFPARAM NAME="ATTRIBUTES.AcceptedTitleImage"   DEFAULT="#Config.AcceptedTitleImage#">
	
	
	<CFIF IsDefined("CFG.WebShop")>
		<CFSET ShopConfig = CFG.WebShop>
	<CFELSE>
		<CFSET ShopConfig = StructNew()>
	</CFIF>
	
	<CFPARAM NAME="ShopConfig.Currency" DEFAULT="NZD">
	<CFPARAM NAME="ShopConfig.CurrencySymbol" DEFAULT="$">
	<CFPARAM NAME="ATTRIBUTES.Currency" DEFAULT="#ShopConfig.Currency#">
	<CFPARAM NAME="ATTRIBUTES.CurrencySymbol" DEFAULT="#ShopConfig.CurrencySymbol#">
	
</CFSILENT>