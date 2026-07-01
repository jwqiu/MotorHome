<CFFORM NAME="theForm" method="post" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
  <table width="450" border="0" cellpadding="5" cellspacing="0">
    <tr> 
      <td class="text"> 
        <div align="center">Please select your listing from the drop down menu 
          below:</div>
      </td>
    </tr>
    <tr> 
      <td align="left" valign="top" class="text"> 
        <div align="center"> 
			<CFOUTPUT>
				<select name="LiID" class="formstylre">
					<CFLOOP QUERY="Q_Listings">
						<option value="#LiID#">#LiMakeAndModel# - #LiYear# (Listing expires #DateFormat(LiRenewDate,"d-mmm-yyyy")#)</option>
					</CFLOOP>
				</select>
			</CFOUTPUT>
        </div>
      </td>
    </tr>
    <tr> 
      <td align="left" valign="top" class="text"> 
        <div align="center"> 
          <p><br>
		  	<CFOUTPUT>
			  	<INPUT NAME="Do_Edit" VALUE="  Edit  " TYPE="SUBMIT" SRC="Images/but-edit_listing.gif" width="76" height="22" class="formstylreCopy"> 
				<img src="Images/holder.gif" width="10" height="10">
				<INPUT NAME="Do_Renew" VALUE="Renew" TYPE="SUBMIT" SRC="Images/but-renew_listing.gif" width="94" height="22" class="formstylreCopy"><br>
			</CFOUTPUT>
          </p>
          </div>
      </td>
    </tr>
	<CFOUTPUT>
	<tr>
		<td align="left" valign="top" class="text">
			<DIV ALIGN="CENTER">
			Listing renewal prices (per year, in New Zealand dollars)
				<table><tr><td>Exchange/Rent</td><td>$#Q_Prices.PrExRnAdd#</td></tr>
				<tr><td>Sell</td><td>$#Q_Prices.PrSellAdd#</td></tr>
				<tr><td>Wanted to Buy</td><td>$#Q_Prices.PrWantedBuyAdd#</td></tr>
				<tr><td>Wanted to Rent</td><td>$#Q_Prices.PrWantedRentAdd#</td></tr></table>
				</DIV>
		</td>
	</tr>
	</CFOUTPUT>
  </table>
</CFFORM>
