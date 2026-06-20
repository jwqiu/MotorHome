
				<CFSET Title  = "Success Stories">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.motorhomeexchange-sell.com:80/Content/images/headers/success_stories.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=SuccessStories" ADDTOKEN="Yes">
				</CFIF>
			
