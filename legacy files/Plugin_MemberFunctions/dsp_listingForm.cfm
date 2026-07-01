<CFIF Q_Listings.RecordCount EQ 0>

	To edit your listing, please access the page from Edit/Renew listing in the member area.

<CFELSE>

<CFHEADER NAME="Expires" VALUE="#Now()#">

<CFIF isDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#") AND NOT Len(ATTRIBUTES.EntryErrors)>
	<CFSWITCH EXPRESSION="#ListFirst(ATTRIBUTES.Reference,'-')#">
<!---		<CFCASE VALUE="REN">
			Thank you. Your listing has been renewed.
		</CFCASE>
--->		
		<CFCASE VALUE="ADD">
			Thank you for your application. Your new listing will be 
			verified and you will receive an e-mail when it is online.
		</CFCASE>
		<CFCASE VALUE="NEW">
			Thank you for your application. Your new listing will be 
			verified and you will receive an e-mail when it is online.
		</CFCASE>
		<CFCASE VALUE="EDT">
			Thank you. Your changes have been saved.
		</CFCASE>
	</CFSWITCH>
<CFELSE>

<CFIF Len(ATTRIBUTES.EntryErrors)>
The following problems were found with the information you entered.
Please correct them and resubmit the form:
	<UL>
		<CFLOOP LIST="#ATTRIBUTES.EntryErrors#" delimiters=";" INDEX="x">
			<LI><CFOUTPUT>#x#</CFOUTPUT></LI>
		</CFLOOP>
	</UL>

</CFIF>

<CFFORM NAME="theForm" ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">

	<CFOUTPUT QUERY="Q_Listings">

		<!--- Save the listing type speific fields into "Fields" --->
		<CFSAVECONTENT VARIABLE="Fields">
			<CFIF (LiExchange EQ 1) OR (LiRent EQ 1)>
				<!--- Include Exchange/Rent Fields --->
				<CFINCLUDE TEMPLATE="inc_exchangeRentForm.cfm">

			<CFELSEIF LiSell EQ 1>
				<!--- Include Sell Fields --->
				<CFINCLUDE TEMPLATE="inc_sellForm.cfm">
			
			<CFELSEIF LiWantedToBuy EQ 1>
				<!--- Include Wanted to Buy Fields --->
				<CFINCLUDE TEMPLATE="inc_wantedToBuyForm.cfm">
		
			<CFELSEIF LiWantedToRent EQ 1>
				<!--- Include Wanted to Rent Fields --->
				<CFINCLUDE TEMPLATE="inc_wantedToRentForm.cfm">
			
			</CFIF>
		</CFSAVECONTENT>

		<!--- Display standard fields --->
		  <table width="450" border="0" cellpadding="5" cellspacing="0" class="formstylre">
		    <tr> 
		      <td colspan="3" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		          <tr> 
		            
                  <td class="text"><strong><font color="##FFFFFF">#UCase(REQUEST.Title)#</font></strong></td>
		            <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
		          </tr>
		        </table></td>
		    </tr>
		    <tr> 
		      <td width="30%" class="text"><div align="right">Select Vehicle Type</div></td>
		      <td colspan="2">

				<CFSET ID=LiID>			  
			  	<select name="LiVehicleTypeLink_#LiID#" class="formstylre">
				  	<CFLOOP QUERY="Q_VehicleTypes">
						<OPTION VALUE="#VeTyID#" #Iif(VeTyID EQ Evaluate('ATTRIBUTES.LiVehicleTypeLink_#ID#'),DE('SELECTED'),DE(''))#>#VeTyName#</OPTION>
					</CFLOOP>
		        </select>
			  
		        </td>
		    </tr>
		    <tr> 
		      <td class="text"><div align="right">Make and Model</div></td>
		      <td><CFINPUT name="LiMakeAndModel_#LiID#" type="text" class="formstylre" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiMakeAndModel_#LiID#'))#" MAXLENGTH="127" REQUIRED="YES" MESSAGE="Please enter vehcile make and model"> </td>
		      <td> year 
		        <CFINPUT name="LiYear_#LiID#" type="text" class="formstylre" size="4" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiYear_#LiID#'))#" MAXLENGTH="4" REQUIRED="NO" MESSAGE="Please enter vehicle year"></td>
		    </tr>
		    <tr> 
		      <td class="text"><div align="right">Short Description (Headline)</div></td>
		      <td colspan="2" class="text"><CFINPUT name="LiShortDescription_#LiID#" type="text" class="formstylre" size="46" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiShortDescription_#LiID#'))#" MAXLENGTH="255" REQUIRED="YES" MESSAGE="Please enter short description"></td>
		    </tr>
			
			<!--- Insert the listing type specific fields --->
			#Fields#

		</table>	
		<BR>
	</CFOUTPUT>
	
	<CFOUTPUT>
	<INPUT NAME="Reference" VALUE="#ATTRIBUTES.Reference#" TYPE="HIDDEN">	
	</CFOUTPUT>
	<BR>
	<TABLE WIDTH="450"><TR><TD>
	<DIV ALIGN="CENTER">
		<CFOUTPUT>
		<input name="Do_#ATTRIBUTES.FuseAction#" type="submit" class="formstylreCopy" value="Submit"> 
		<input name="Submit2" type="reset" class="formstylreCopy" value="Reset"> 
		</CFOUTPUT>
	</DIV>
	</TD></TR></TABLE>
	
</CFFORM>
</CFIF>
</CFIF>