<CFIF isDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>

	<CFLOOP QUERY="Q_Listings">
		<CFIF Len(Evaluate("ATTRIBUTES.LiYear_#LiID#")) AND NOT isNumeric(Evaluate("ATTRIBUTES.LiYear_#LiID#"))>
			<CFSET ATTRIBUTES.EntryErrors = ATTRIBUTES.EntryErrors&"The year must be a number">
		</CFIF>

		<CFIF NOT Len(Evaluate("ATTRIBUTES.LiLongDescription_#LiID#"))>
			<CFSET ATTRIBUTES.EntryErrors = ATTRIBUTES.EntryErrors&";Please supply a description of vehicle">
		</CFIF>

	</CFLOOP>

	<CFIF NOT Len(ATTRIBUTES.EntryErrors)>
		<CFLOOP QUERY="Q_Listings">
	
			<CFIF Len(Evaluate("ATTRIBUTES.FromYear_#LiID#")) AND 
					Len(Evaluate("ATTRIBUTES.FromMonth_#LiID#")) AND
					Len(Evaluate("ATTRIBUTES.FromDay_#LiID#"))>
				<!--- Convert FromYear,FromMonth,FromDay into a valid date object
					- Round the date down to a valid date.. 
					- in the case of 31st Feb etc.. 
					--->
				<CFSET Year = Evaluate("ATTRIBUTES.FromYear_#LiID#")>
				<CFSET Month = Evaluate("ATTRIBUTES.FromMonth_#LiID#")>
				<CFSET Day   = Evaluate("ATTRIBUTES.FromDay_#LiID#")>
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
			
			<CFIF Len(Evaluate("ATTRIBUTES.ToYear_#LiID#")) AND 
					Len(Evaluate("ATTRIBUTES.ToMonth_#LiID#")) AND
					Len(Evaluate("ATTRIBUTES.ToDay_#LiID#"))>
				<!--- Convert FromYear,FromMonth,FromDay into a valid date object
					- Round the date down to a valid date.. 
					- in the case of 31st Feb etc.. 
					--->
				<CFSET Year = Evaluate("ATTRIBUTES.ToYear_#LiID#")>
				<CFSET Month = Evaluate("ATTRIBUTES.ToMonth_#LiID#")>
				<CFSET Day   = Evaluate("ATTRIBUTES.ToDay_#LiID#")>
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
	
			<CFSET TheYear = Evaluate("ATTRIBUTES.LiYear_#LiID#")>
			<CFIF NOT Len(TheYear)>
				<CFSET TheYear = "NULL">
			</CFIF>
	
			<CFQUERY NAME="Q_Update" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				UPDATE Listings
				SET 
					LiVehicleTypeLink	= #Evaluate("ATTRIBUTES.LiVehicleTypeLink_#LiID#")#,
					LiYear 				= #TheYear#,
					LiMakeAndModel 		= '#Replace(Evaluate("ATTRIBUTES.LiMakeAndModel_#LiID#"),"'","''","ALL")#',
					LiShortDescription 	= '#Replace(Evaluate("ATTRIBUTES.LiShortDescription_#LiID#"),"'","''","ALL")#',
					LiLongDescription 	= '#Replace(Evaluate("ATTRIBUTES.LiLongDescription_#LiID#"),"'","''","ALL")#',
					LiPrice 			= '#Replace(Evaluate("ATTRIBUTES.LiPrice_#LiID#"),"'","''","ALL")#',
					LiAreaDescription 	= '#Replace(Evaluate("ATTRIBUTES.LiAreaDescription_#LiID#"),"'","''","ALL")#',
					LiWhereWantToGo 	= '#Replace(Evaluate("ATTRIBUTES.LiWhereWantToGo_#LiID#"),"'","''","ALL")#',
					LiProfession	 	= '#Replace(Evaluate("ATTRIBUTES.LiProfession_#LiID#"),"'","''","ALL")#',
					LiInterests		 	= '#Replace(Evaluate("ATTRIBUTES.LiInterests_#LiID#"),"'","''","ALL")#',
					LiAgeRange		 	= '#Replace(Evaluate("ATTRIBUTES.LiAgeRange_#LiID#"),"'","''","ALL")#',
					LiOther		 		= '#Replace(Evaluate("ATTRIBUTES.LiOther_#LiID#"),"'","''","ALL")#',
					<CFIF isDefined("FromDate")>
						LiFromDate			= #CreateODBCDate(FromDate)#,
					</CFIF>
					<CFIF isDefined("ToDate")>
						LiToDate			= #CreateODBCDate(ToDate)#,
					</CFIF>
	<!---Date modified not date added --->
					LiDateAdded	= #CreateODBCDateTime(Now())#,
					LiUUID = NULL
				WHERE LiID = #LiID#
			</CFQUERY>
			
			<!--- Send email to administrator informing it a new
				listing has been created --->
			<CFIF (ListFirst(ATTRIBUTES.Reference,"-") EQ "ADD")
				OR (ListFirst(ATTRIBUTES.Reference,"-") EQ "NEW")>
				
<CFMAIL FROM="#CFG.EmailAddress#" TO="#CFG.EmailAddress#" SUBJECT="A new vehicle listing has been created">
There is a new vehicle listing waiting for you to authorise.

You may view the vehicle listing at the following URL:
#CFG.AbsoluteWebURL#/fusebox.cfm?FuseAction=ListingsEdit&LiID=#LiID#
				
To authorise the listing, please tick the "Listing is Authorised" box and click "Submit". After the listing is authorised, the member will be sent an introductory e-mail informing them their listing is now online.
</CFMAIL>
				
			</CFIF>
			
		</CFLOOP>
	</CFIF>	
	
</CFIF>