
				<CFSET Title  = "Membership">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.motorhomeexchange-sell.com:80/Content/images/headers/membership.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=Membership" ADDTOKEN="Yes">
				</CFIF>
			
