<CFSILENT>
	
	
	<CFSET VehiclesPerPage=8>
	
	<CFPARAM NAME="ATTRIBUTES.CurrentPage" DEFAULT="1">

	<CFPARAM NAME="ATTRIBUTES.SearchKeywords" DEFAULT="">

	<!--- Standard Search --->
	<CFPARAM NAME="ATTRIBUTES.CountryList" DEFAULT="">

	<!--- Advanced Search --->
	<CFPARAM NAME="ATTRIBUTES.MeCountryLink" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.MeStateLink" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.MeCityLink" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.VehicleType" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Type" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.FromDay" DEFAULT="1">
	<CFPARAM NAME="ATTRIBUTES.FromMonth" DEFAULT="1">
	<CFPARAM NAME="ATTRIBUTES.FromYear" DEFAULT="1980">
	<CFPARAM NAME="ATTRIBUTES.ToDay" DEFAULT="1">
	<CFPARAM NAME="ATTRIBUTES.ToMonth" DEFAULT="1">
	<CFPARAM NAME="ATTRIBUTES.ToYear" DEFAULT="2030">

	<!--- New ones.. Members only --->
	<CFPARAM NAME="ATTRIBUTES.LiDateAdded" DEFAULT="">

	<!--- Only members can specify to view based on the date 
		- that a listing was added
		--->
	<CFIF Len(ATTRIBUTES.LiDateAdded)>
		<!--- Members only --->
		<CFIF NOT Len(SESSION.SecurityEmail) and NOT Len(SESSION.SecurityPassword)>
			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=MemberLogin&RFA=#URLEncodedFormat(REQUEST.Back)#">
		</CFIF>
	</CFIF>
	
	<CFIF Len(ATTRIBUTES.FromYear) AND Len(ATTRIBUTES.FromMonth) AND
		Len(ATTRIBUTES.FromDay)>
		<!--- Convert FromYear,FromMonth,FromDay into a valid date object
			- Round the date down to a valid date.. 
			- in the case of 31st Feb etc.. 
			--->
		<CFSET Year = ATTRIBUTES.FromYear>
		<CFSET Month = ATTRIBUTES.FromMonth>
		<CFSET Day   = ATTRIBUTES.FromDay>
		<CFSET Date = "">
		<CFLOOP CONDITION="NOT Len(Date)"> 
		<CFTRY>
			<CFSET Date = CreateDate(Year, Month, Day)>
			<CFCATCH TYPE="Expression">
				<CFIF Day GT 0>
					<CFSET Day = Day - 1>
				<CFELSE>
					<CFIF Month GT 0>
						<CFSET Month = Month - 1>
					<CFELSE>
						<CFSET Year = Year - 1>
						<CFSET Month = 12>
					</CFIF>
					<CFSET Day = 31>
				</CFIF>
			</CFCATCH>
		</CFTRY>
		</CFLOOP>
		<CFSET FromDate=Date>
	</CFIF>

	<CFIF Len(ATTRIBUTES.ToYear) AND Len(ATTRIBUTES.ToMonth) AND
		Len(ATTRIBUTES.ToDay)>
		<!--- Convert ToYear,ToMonth,ToDay into a valid date object
			- Round the date down to a valid date.. 
			- in the case of 31st Feb etc.. 
			--->
		<CFSET Year = ATTRIBUTES.ToYear>
		<CFSET Month = ATTRIBUTES.ToMonth>
		<CFSET Day   = ATTRIBUTES.ToDay>
		<CFSET Date = "">
		<CFLOOP CONDITION="NOT Len(Date)"> 
		<CFTRY>
			<CFSET Date = CreateDate(Year, Month, Day)>
			<CFCATCH TYPE="Expression">
				<CFIF Day GT 0>
					<CFSET Day = Day - 1>
				<CFELSE>
					<CFIF Month GT 0>
						<CFSET Month = Month - 1>
					<CFELSE>
						<CFSET Year = Year - 1>
						<CFSET Month = 12>
					</CFIF>
					<CFSET Day = 31>
				</CFIF>
			</CFCATCH>
		</CFTRY>
		</CFLOOP>
		<CFSET ToDate=Date>
	</CFIF>
	
	<!--- Perform the search --->
	<CFQUERY NAME="Q_Vehicles" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings, Members, Countries, States, Cities, VehicleTypes
		WHERE MeID = LiMemberLink

			<!--- Check administrator has autorized the new listings to 
				- be displayed 
				--->
			AND LiAuthorised = 1
			
			AND #CreateODBCDate(Now())# <= LiRenewDate
		
			AND MeCountryLink = CntID
			<CFIF Len(ATTRIBUTES.CountryList)>AND MeCountryLink in (#ATTRIBUTES.CountryList#)</CFIF>
			<CFIF Len(ATTRIBUTES.MeCountryLink)>AND MeCountryLink = #ATTRIBUTES.MeCountryLink#</CFIF>

			AND MeStateLink = StID
			<CFIF Len(ATTRIBUTES.MeStateLink)>AND MeStateLink = #ATTRIBUTES.MeStateLink#</CFIF>

			AND MeCityLink = CiID
			<CFIF Len(ATTRIBUTES.MeCityLink)>AND MeCityLink = #ATTRIBUTES.MeCityLink#</CFIF>

			AND LiVehicleTypeLink = VeTyID
			<CFIF Len(ATTRIBUTES.VehicleType)>AND LiVehicleTypeLink = #ATTRIBUTES.VehicleType#</CFIF>

			<!--- Check NEW listings.. past 2 days --->
			<CFIF Len(ATTRIBUTES.LiDateAdded)>
				AND #CreateODBCDate(Now())# - LiDateAdded <= 2
			</CFIF>
			
			<!--- Check listing type --->
			<CFIF Len(ATTRIBUTES.Type)>
				<CFSWITCH EXPRESSION="#ATTRIBUTES.Type#">
					<CFCASE VALUE="E">AND LiExchange = 1</CFCASE>
					<CFCASE VALUE="R">AND LiRent = 1</CFCASE>
					<CFCASE VALUE="S">AND LiSell = 1</CFCASE>
					<CFCASE VALUE="WR">AND LiWantedToRent = 1</CFCASE>
					<CFCASE VALUE="WB">AND LiWantedToBuy = 1</CFCASE>
				</CFSWITCH>			
			</CFIF>

			<!--- Check date range --->
			<CFIF isDefined("FromDate") AND isDefined("ToDate")>
				AND (
						<!--- To and From are NULL --->
						(
								(LiFromDate IS NULL) 
							AND (LiToDate IS NULL)
						)
						OR
						<!--- To and From are within the range --->
						(
								(LiFromDate >= #CreateODBCDate(FromDate)#)
							AND	(LiToDate <= #CreateODBCDate(ToDate)#)
						)
					)
			</CFIF>
			
			<!--- Search for keywords --->
			<CFIF Len(ATTRIBUTES.SearchKeywords)>
				AND
				<CFLOOP LIST="#ATTRIBUTES.SearchKeywords#" INDEX="x" DELIMITERS=" ">
					 (
							(VeTyName like '%#x#%')
						OR	(LiMakeAndModel like '%#x#%')
						OR	(LiYear like '%#x#%')
						OR	(LiShortDescription like '%#x#%')
						OR	(LiLongDescription like '%#x#%')
						OR  (CntName like '%#x#%')
						OR  (StName like '%#x#%')
						OR  (CiName like '%#x#%')
					) AND
				</CFLOOP>
				(1=1)
			</CFIF>
			
		ORDER BY CntName, StName, CiName, LiMakeAndModel, LiYear, LiShortDescription
	</CFQUERY>

	<!--- Draw the page thru control (if required) --->
	<CFSET TotalPages=(Q_Vehicles.RecordCount+(VehiclesPerPage-1))\VehiclesPerPage>
	<CFIF ATTRIBUTES.CurrentPage GT TotalPages>
		<CFSET ATTRIBUTES.CurrentPage = TotalPages>
	</CFIF>
	<CFIF ATTRIBUTES.CurrentPage LTE 0>
		<CFSET ATTRIBUTES.CurrentPage = 1>
	</CFIF>
	<CFSET PageControl="">
	<CFIF Q_Vehicles.RecordCount GT VehiclesPerPage>
		<CFSAVECONTENT VARIABLE=PageControl>
			<CFOUTPUT>
			<table border="0" cellspacing="0" cellpadding="3">
			 	<tr>
					<!--- Draw the previous page section ---> 
					<CFIF ATTRIBUTES.CurrentPage GT 1>
					    <td><A HREF="#REQUEST.Back#&CurrentPage=#Evaluate(ATTRIBUTES.CurrentPage-1)#"><img border="0" src="Images/arrowleft.gif" width="20" height="19"></A></td>
					    <td class="text"><A HREF="#REQUEST.Back#&CurrentPage=#Evaluate(ATTRIBUTES.CurrentPage-1)#" style="text-decoration: none">previous page</A></td>
					<CFELSE>
					    <td><img src="Images/arrowleftpale.gif" width="20" height="19"></td>
					    <td class="text"><FONT COLOR="##AAAAAA">previous page</FONT></td>
					</CFIF>
					

					<!--- Draw page numbers --->					
					<td class="text"><div align="left">
					<CFLOOP FROM="1" TO="#TotalPages#" INDEX="x">
						<CFIF ATTRIBUTES.CurrentPage EQ x>
						    <strong>#x#</strong>
						<CFELSE>
							<A HREF="#REQUEST.Back#&CurrentPage=#x#" style="text-decoration: none">#x#</A>
						</CFIF>
						<CFIF TotalPages NEQ x>
							|
						</CFIF>
					</CFLOOP>
					</div></td>
					
					<!--- Draw the next page section --->
					<CFIF ATTRIBUTES.CurrentPage LT TotalPages>
					    <td class="text"><div align="right"><A HREF="#REQUEST.Back#&CurrentPage=#Evaluate(ATTRIBUTES.CurrentPage+1)#" style="text-decoration: none">next page</A></div></td>
					    <td><A HREF="#REQUEST.Back#&CurrentPage=#Evaluate(ATTRIBUTES.CurrentPage+1)#"><img src="Images/arrowright.gif" width="20" height="19" border="0"></A></td>
					<CFELSE>
					    <td class="text"><div align="right"><FONT COLOR="##AAAAAA">next page</FONT></div></td>
					    <td><img src="Images/arrowrightpale.gif" width="20" height="19" border="0"></td>
					</CFIF>
					
				</tr>
			</table>
			</CFOUTPUT>
		</CFSAVECONTENT>
	</CFIF>
	
</CFSILENT>