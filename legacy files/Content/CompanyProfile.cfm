
				<CFSET Title  = "Company Profile">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.motorhomeexchange-sell.com:80/Content/images/headers/comp_profile.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=CompanyProfile" ADDTOKEN="Yes">
				</CFIF>
			
