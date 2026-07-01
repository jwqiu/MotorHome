
				<CFSET Title  = "Untitled Document">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=test" ADDTOKEN="Yes">
				</CFIF>
			
