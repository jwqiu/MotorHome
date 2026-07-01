<CFIF isDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>

	<CFIF Q_FreeAccounts.FrAcAmount GT 0>
		<CFSET Total = 0>
		<CFSET Total = Total+ATTRIBUTES.ExchangeYears>
		<CFSET Total = Total+ATTRIBUTES.RentYears>
		<CFSET Total = Total+ATTRIBUTES.SellYears>
		<CFSET Total = Total+ATTRIBUTES.WTBYears>
		<CFSET Total = Total+ATTRIBUTES.WTRYears>
		<CFIF Total GT 1>
			<CFSET ATTRIBUTES.EntryErrors = "For free membership, please only select a single listing type for one year.">
		</CFIF>
	</CFIF>

	<CFIF NOT Len(ATTRIBUTES.EntryErrors)>
		
		<CFSET Reference = CreateUUID()>
		
		<!--- Figure out if the listing is for a new member 
			- or an existing member and get the MeID
			--->
		<CFSCRIPT>
			NewMember = 0;
			if (len(SESSION.SecurityID)) {
				MeID = SESSION.SecurityID;
				Name = SESSION.SecurityName;
				Email = SESSION.SecurityEmail;
			} else if (isDefined("SESSION.NewMember")) {
				MeID = SESSION.NewMember;
				Name = SESSION.NewMemberName;
				Email = SESSION.NewMemberEmail;
				NewMember = 1;
			}
		</CFSCRIPT>
	
		<CFSET TotalPrice = 0>
		
		<!--- Insert an empty Exchange listing --->
		<CFIF ATTRIBUTES.ExchangeYears GT 0>
			<CFIF isDefined("ATTRIBUTES.ListUnderRent")>
				<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
					TYPES="LiExchange, LiRent" YEARS="#ATTRIBUTES.ExchangeYears#">
			<CFELSE>
				<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
					TYPES="LiExchange" YEARS="#ATTRIBUTES.ExchangeYears#">
			</CFIF>
			<!--- Calculate price --->
			<CFSCRIPT>
				if (HasExchangeRent EQ 0) {
					switch (ATTRIBUTES.ExchangeYears) {
						case 1: {	TotalPrice = TotalPrice+Q_Prices.PrExRnOneYear;
						break; }
						case 3: {	TotalPrice = TotalPrice+Q_Prices.PrExRnThreeYears;
						break; }
						case 6: {	TotalPrice = TotalPrice+Q_Prices.PrExRnSixYears;
						break; }
					}
				} else {
					switch (ATTRIBUTES.ExchangeYears) {
						case 1: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd;
						break; }
						case 3: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd*3;
						break; }
						case 6: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd*6;
						break; }
					}
				}
			</CFSCRIPT>
		</CFIF>
	
		<!--- Insert an empty Rent listing --->
		<CFIF ATTRIBUTES.RentYears GT 0>
			<CFIF isDefined("ATTRIBUTES.ListUnderExchange")>
				<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
					TYPES="LiRent, LiExchange" YEARS="#ATTRIBUTES.RentYears#">
			<CFELSE>
				<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
					TYPES="LiRent" YEARS="#ATTRIBUTES.RentYears#">
			</CFIF>
			<!--- Calculate price --->
			<CFSCRIPT>
				if (HasExchangeRent EQ 0) {
					switch (ATTRIBUTES.RentYears) {
						case 1: {	TotalPrice = TotalPrice+Q_Prices.PrExRnOneYear;
						break; }
						case 3: {	TotalPrice = TotalPrice+Q_Prices.PrExRnThreeYears;
						break; }
						case 6: {	TotalPrice = TotalPrice+Q_Prices.PrExRnSixYears;
						break; }
					}
				} else {
					switch (ATTRIBUTES.RentYears) {
						case 1: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd;
						break; }
						case 3: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd*3;
						break; }
						case 6: {	TotalPrice = TotalPrice+Q_Prices.PrExRnAdd*6;
						break; }
					}
				}
			</CFSCRIPT>
		</CFIF>
	
		<!--- Insert an empty Sell listing --->
		<CFIF ATTRIBUTES.SellYears GT 0>
			<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
				TYPES="LiSell" YEARS="#ATTRIBUTES.SellYears#">
			<!--- Calculate price --->
			<CFSCRIPT>
				if (HasSell EQ 0) {
					TotalPrice = TotalPrice+Q_Prices.PrSellFirst;
				} else {
					TotalPrice = TotalPrice+Q_Prices.PrSellAdd;
				}
			</CFSCRIPT>
		</CFIF>
	
		<!--- Insert an empty Wanted To Rent listing --->
		<CFIF ATTRIBUTES.WTRYears GT 0>
			<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
				TYPES="LiWantedToRent" YEARS="#ATTRIBUTES.WTRYears#">
			<!--- Calculate price --->
			<CFSCRIPT>
				if (HasWantedToRent EQ 0) {
					TotalPrice = TotalPrice+Q_Prices.PrWantedRentFirst;
				} else {
					TotalPrice = TotalPrice+Q_Prices.PrWantedRentAdd;
				}
			</CFSCRIPT>
		</CFIF>
	
		<!--- Insert an empty Wanted To Buy listing --->
		<CFIF ATTRIBUTES.WTBYears GT 0>
			<CFMODULE TEMPLATE="NewListing.cfm" CFG=#CFG# ID="#MeID#" REFERENCE="#Reference#"
				TYPES="LiWantedToBuy" YEARS="#ATTRIBUTES.WTBYears#">
			<!--- Calculate price --->
			<CFSCRIPT>
				if (HasWantedToRent EQ 0) {
					TotalPrice = TotalPrice+Q_Prices.PrWantedBuyFirst;
				} else {
					TotalPrice = TotalPrice+Q_Prices.PrWantedBuyAdd;
				}
			</CFSCRIPT>
		</CFIF>
	
		<CFLOCATION URL="https://www.megamall.co.nz/MotorhomeExchange/fusebox.cfm?FuseAction=checkout&Reference=#URLEncodedFormat('#ActionType#-#Reference#')#&Name=#URLEncodedFormat(Name)#&Email=#UrlEncodedFormat(Email)#&Total=#URLEncodedFormat(TotalPrice)#" ADDTOKEN="No">
	</CFIF>
	
</CFIF>