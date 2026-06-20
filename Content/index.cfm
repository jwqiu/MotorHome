
				<CFSET Title  = "Home">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.MotorhomeExchange-Sell.com:80/Content/images/headers/welcome.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=index" ADDTOKEN="Yes">
				</CFIF>
			
