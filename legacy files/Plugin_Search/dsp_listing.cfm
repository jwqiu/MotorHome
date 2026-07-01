<CFIF Q_Vehicles.RecordCount EQ 0>
	Sorry, no listings were found that match your search criteria.
	Please try again with a different search.
<CFELSE>
<CFSET RowCount=0>
<CFOUTPUT QUERY="Q_Vehicles" GROUP="CntName" STARTROW="#Evaluate((ATTRIBUTES.CurrentPage-1) * VehiclesPerPage+1)#">
<CFIF RowCount LT VehiclesPerPage>
	<table width="500" border="0" cellpadding="0" cellspacing="0" class="formstylre">
		<tr>
			<td colspan="2" class="formtitle" style="border-bottom-width: 0px">
				<strong><font size="2">
					#HTMLEditFormat(UCase(CntName))#
				</font></strong> 
			</td>
		</tr>
		
	<CFOUTPUT GROUP="StName">
	<CFIF RowCount LT VehiclesPerPage>
		<CFOUTPUT GROUP="CiName">
		<CFIF RowCount LT VehiclesPerPage>

		 <tr> 
		 	<!--- Display the city and state --->
	    	<td width="130" valign="top" class="borderright"> 
				<table width="130" cellpadding="10" cellspacing="0" height="100%">
					<!--- Darkgray box --->	
					<tr><td height="100" class="borderlocation">
						<div align="center"><font color="##FFFFFF"><strong>
							#HTMLEditFormat(CiName)#,<BR>#HTMLEditFormat(StName)#
						</strong></font></div>			
					</td></tr>
					<!--- Empty white space --->
					<tr><td>&nbsp;</td></tr>
				</table>
			</td>
			<td valign="top">
				<table cellpadding="5" cellspacing="0" width="100%" height="100%">
				<CFOUTPUT>
				<CFIF RowCount LT VehiclesPerPage>
					<tr><td class="topline" width="100%">
						<p>
							<CFIF LiExchange EQ 1><img src="Images/exchange.gif" width="83" height="27"></CFIF>
							<CFIF LiRent EQ 1><img src="Images/rent.gif" width="62" height="27"></CFIF>
							<CFIF LiSell EQ 1><img src="Images/sell.gif" width="62" height="27"></CFIF>
							<CFIF LiWantedToBuy EQ 1><img src="Images/wantedbuy.gif" width="110" height="27"></CFIF>
							<CFIF LiWantedToRent EQ 1><img src="Images/wantedrent.gif" width="110" height="27"></CFIF>
							<img src="Images/#VeTyName#.gif" height="27">
							<br>
							<TABLE CELLPADDING="0" CELLSPACING="0"><TR><TD>
   							<strong>
								#HTMLEditFormat(UCase("#LiMakeAndModel# #LiYear#"))#
							</strong>
							</TD>
							<CFIF LiSold EQ 1>
								<TD>&nbsp;<IMG SRC="Images/sold.gif" WIDTH="45" HEIGHT="15" ALT="Sold"></TD>
							</CFIF>
							</TR></TABLE>
						</p>
					  	<p class="text">
				        	#Replace(HTMLEditFormat(LiShortDescription),"#Chr(10)#","<BR>","ALL")#
						</p>
						<!--- View Detail Link--->		
				        <table width="100" border="0" cellspacing="0" cellpadding="0"><tr><td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=ListingDetails&LiID=#LiID#&RFA=#UrlEncodedFormat(REQUEST.Back)#"><img border="0" src="Images/magglass.gif" width="20" height="20"></A></td><td class="text"><strong><A HREF="#CGI.SCRIPT_NAME#?FuseAction=ListingDetails&LiID=#LiID#&RFA=#UrlEncodedFormat(REQUEST.Back)#" style="text-decoration: none">view detail</A></strong></td></tr></table>
					</td></tr>	
					<CFSET RowCount = RowCount+1>
				</CFIF>
				</CFOUTPUT>
				</table>
			</td>
		</tr>	
		</CFIF>
		</CFOUTPUT>
	</CFIF>
	</CFOUTPUT>
</table>
</CFIF>		
</CFOUTPUT>
<br>
<CFOUTPUT>
	#PageControl#
</CFOUTPUT>
</CFIF>
