
				<CFSET Title  = "Send Photo">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.motorhomeexchange-sell.com:80/Content/images/headers/send_photo.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=SendPhoto" ADDTOKEN="Yes">
				</CFIF>
			
