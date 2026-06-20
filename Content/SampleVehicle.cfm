
				<CFSET Title  = "Sample Vehicle Contract">
				<CFSET Layout = "contentLayout">
				<CFSET TitleImage = "http://www.motorhomeexchange-sell.com:80/Content/images/headers/sample-vehicle.gif">
				<CFIF NOT IsDefined("PlugBox")>
					<CFLOCATION URL="/fusebox.cfm?FuseAction=EDITABLEPAGEInclude&PageName=SampleVehicle" ADDTOKEN="Yes">
				</CFIF>
			
