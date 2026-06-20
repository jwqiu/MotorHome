<CFOUTPUT>
<SCRIPT LANGUAGE="Javascript">

		<CFINCLUDE TEMPLATE="/CFIDE/scripts/wddx.js">

		function toCurrency (value, currency) {
		var is_neg=false 
		if(isNaN(value)) {alert("The value is not a number")}
		else{
		if(!currency) currency="";
		var newValue = "" + Math.round (eval(value) * 100)
		if (newValue.charAt(0) =="-") is_neg=true;
		if(is_neg){newValue=newValue.substring(1)};
		while (newValue.length <= 2) {newValue = "0" + newValue}
		var dp = newValue.length - 2;
		newValue= currency+newValue.substring(0,dp) + "." + newValue.substring(dp,newValue.length);
		if (is_neg){newValue= "-"+newValue}
		return newValue
		}
		}
		
		
		function setTotal() {
			document.theForm.Total.value = toCurrency(getExchangePrice()+
				getRentPrice()+getSellPrice()+getWTBPrice()+getWTRPrice());
				document.theForm.ForeignEstimate.value = toCurrency((getExchangePrice()+
					getRentPrice()+getSellPrice()+getWTBPrice()+getWTRPrice())*#ATTRIBUTES.ExchangeRate#)+" #ATTRIBUTES.ExchangeRateCode#";
		}

		function getExchangePrice() {
			<CFIF HasExchangeRent EQ 0>
				switch (document.theForm.ExchangeYears.value) {
					case "0" : return 0;
					case "1" : return #Q_Prices.PrExRnOneYear#;
					case "3" : return #Q_Prices.PrExRnThreeYears#;
					case "6" : return #Q_Prices.PrExRnSixYears#;
				}
			<CFELSE>
				switch (document.theForm.ExchangeYears.value) {
					case "0" : return 0;
					case "1" : return #Q_Prices.PrExRnAdd#;
					case "3" : return 3*#Q_Prices.PrExRnAdd#;
					case "6" : return 6*#Q_Prices.PrExRnAdd#;
				}
			</CFIF>
		}

		function getRentPrice() {
			<CFIF HasExchangeRent EQ 0>
				switch (document.theForm.RentYears.value) {
					case "0" : return 0;
					case "1" : return #Q_Prices.PrExRnOneYear#;
					case "3" : return #Q_Prices.PrExRnThreeYears#;
					case "6" : return #Q_Prices.PrExRnSixYears#;
				}
			<CFELSE>
				switch (document.theForm.RentYears.value) {
					case "0" : return 0;
					case "1" : return #Q_Prices.PrExRnAdd#;
					case "3" : return 3*#Q_Prices.PrExRnAdd#;
					case "6" : return 6*#Q_Prices.PrExRnAdd#;
				}
			</CFIF>
		}

		function getSellPrice() {
			<CFIF HasSell EQ 0>
				return document.theForm.SellYears.value*#Q_Prices.PrSellFirst#;
			<CFELSE>
				return document.theForm.SellYears.value*#Q_Prices.PrSellAdd#;
			</CFIF>		
		}
		
		function getWTBPrice() {
			<CFIF HasWantedToBuy EQ 0>
				return document.theForm.WTBYears.value*#Q_Prices.PrWantedBuyFirst#;
			<CFELSE>
				return document.theForm.WTBYears.value*#Q_Prices.PrWantedBuyAdd#;
			</CFIF>
		}

		function getWTRPrice() {
			<CFIF HasWantedToRent EQ 0>
				return document.theForm.WTRYears.value*#Q_Prices.PrWantedRentFirst#;
			<CFELSE>
				return document.theForm.WTRYears.value*#Q_Prices.PrWantedRentAdd#;
			</CFIF>
		}
</SCRIPT>
</CFOUTPUT>
<link href="../styles.css" rel="stylesheet" type="text/css">

<CFIF Len(ATTRIBUTES.EntryErrors)>
There was an error with your selection:<BR><BR>
<CFOUTPUT><LI>#ATTRIBUTES.EntryErrors#</LI></CFOUTPUT>
</CFIF>

<CFFORM name="theForm" ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
	<CFOUTPUT>
		<INPUT TYPE="HIDDEN" NAME="ActionType" VALUE="#ATTRIBUTES.ActionType#">
	</CFOUTPUT>
  <table width="450" border="0" cellpadding="5" cellspacing="0" class="formstylre">
<tr> 
      <td colspan="4" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td class="text"><strong><font color="#FFFFFF">NEW LISTING / ADD LISTING</font></strong></td>
            <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td colspan="4">
	    Please click on the category that you wish to choose<br> 
        <br> <img src="Images/bullet.gif" width="10" height="10"> You may choose 
        more than one category<br> <img src="Images/bullet.gif" width="10" height="10"> 
        Your Listing can appear under both exchange and rental sections at no 
        additional cost<br> <br> </td>
    </tr>
    <tr> 
      <td> <div align="right">
          <p class="text">EXCHANGE</p>
</div></td>
      <td>
	  	<CFOUTPUT>
	  	<select name="ExchangeYears" class="formstylre" ONCHANGE="ExchangePriceField.innerHTML='$NZ&nbsp;'+getExchangePrice();setTotal();">
	      <option #IIf(ATTRIBUTES.ExchangeYears EQ "0",DE('SELECTED'),DE(''))# value="0">Please Select</option>
          <option #IIf(ATTRIBUTES.ExchangeYears EQ "1",DE('SELECTED'),DE(''))# value="1">1 Year</option>
          <option #IIf(ATTRIBUTES.ExchangeYears EQ "3",DE('SELECTED'),DE(''))# value="3">3 Years</option>
          <option #IIf(ATTRIBUTES.ExchangeYears EQ "6",DE('SELECTED'),DE(''))# value="6">6 Years</option>
        </select>
		</CFOUTPUT>
      </td>
	  <td ID="ExchangePrice" WIDTH="50">
  	   $NZ&nbsp;0
	  </td>
      <td>
	  	<CFOUTPUT>
		  	<input #IIf(isDefined("ATTRIBUTES.ListUnderRent"),DE('CHECKED'),DE(''))# type="checkbox" name="ListUnderRent" value="1"> <span class="egtext">
		    List&nbsp;Under&nbsp;Rent</span>
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td> <div align="right" class="text">RENT</div></td>
      <td>
  	  	<CFOUTPUT>
	  	<select name="RentYears" class="formstylre" ONCHANGE="RentPriceField.innerHTML='$NZ&nbsp;'+getRentPrice();setTotal();">
	      <option #IIf(ATTRIBUTES.RentYears EQ "0",DE('SELECTED'),DE(''))# value="0">Please Select</option>
          <option #IIf(ATTRIBUTES.RentYears EQ "1",DE('SELECTED'),DE(''))# value="1">1 Year</option>
          <option #IIf(ATTRIBUTES.RentYears EQ "3",DE('SELECTED'),DE(''))# value="3">3 Years</option>
          <option #IIf(ATTRIBUTES.RentYears EQ "6",DE('SELECTED'),DE(''))# value="6">6 Years</option>
        </select>
		</CFOUTPUT>
        </td>
	  <td ID="RentPrice" WIDTH="50">
  	   $NZ&nbsp;0
	  </td>
      <td>
		<CFOUTPUT>
		  	<input #IIf(isDefined("ATTRIBUTES.ListUnderExchange"),DE('CHECKED'),DE(''))# type="checkbox" name="ListUnderExchange" value="1"> <span class="egtext">
		  	List&nbsp;Under&nbsp;Exchange</span>
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td class="text"> 
<div align="right">SELL</div></td>
      <td colspan="1">
  	  	<CFOUTPUT>
	    <select name="SellYears" class="formstylre" ONCHANGE="SellPriceField.innerHTML='$NZ&nbsp;'+getSellPrice();setTotal();">
	      <option #IIf(ATTRIBUTES.SellYears EQ "0",DE('SELECTED'),DE(''))# value="0">Please Select</option>
          <option #IIf(ATTRIBUTES.SellYears EQ "1",DE('SELECTED'),DE(''))# value="1">1 Year</option>
        </select>
		</CFOUTPUT>
      </td>
      <td colspan="2" ID="SellPrice" WIDTH="50">
  	   $NZ&nbsp;0
	  </td>
    </tr>
    <tr> 
      <td class="text"> 
<div align="right">WANTED TO BUY</div></td>
      <td colspan="1">
  	  	<CFOUTPUT>
	  	<select name="WTBYears" class="formstylre" ONCHANGE="WTBPriceField.innerHTML='$NZ&nbsp;'+getWTBPrice();setTotal();">
	      <option #IIf(ATTRIBUTES.WTBYears EQ "0",DE('SELECTED'),DE(''))# value="0">Please Select</option>
          <option #IIf(ATTRIBUTES.WTBYears EQ "1",DE('SELECTED'),DE(''))# value="1">1 Year</option>
        </select>
		</CFOUTPUT>
      </td>
      <td colspan="2" ID="WTBPrice" WIDTH="50">
  	   $NZ&nbsp;0
	  </td>
    </tr>
    <tr> 
      <td class="text"> 
<div align="right">WANTED TO RENT</div></td>
      <td>
	  	<CFOUTPUT>
	  	<select name="WTRYears" class="formstylre" ONCHANGE="WTRPriceField.innerHTML='$NZ&nbsp;'+getWTRPrice();setTotal();">
	      <option #IIf(ATTRIBUTES.WTRYears EQ "0",DE('SELECTED'),DE(''))# value="0">Please Select</option>
          <option #IIf(ATTRIBUTES.WTRYears EQ "1",DE('SELECTED'),DE(''))# value="1">1 Year</option>
        </select>
		</CFOUTPUT>
      </td>
      <td colspan="2" ID="WTRPrice" WIDTH="50">
  	   $NZ&nbsp;0
	  </td>
    </tr>
    <tr> 
      <td class="text">
<div align="right">Select Currency </div></td>
      <td colspan="2">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="currencyQuery" />
		<CFQUERY NAME="Q_ExchangeRates" DBTYPE="QUERY">
			SELECT * FROM CFMODULE.ATTRIBUTES.Q_ListQuery
			ORDER BY Desc
		</CFQUERY>
		<CFOUTPUT>
			<SELECT NAME="ExchangeRateCode" class="formstylre" ONCHANGE="document.theForm.submit();">
				<CFLOOP QUERY="Q_ExchangeRates">
					<OPTION #IIf(ATTRIBUTES.ExchangeRateCode EQ Code,DE('SELECTED'),DE(''))# VALUE="#Code#">#Desc#</OPTION>			
				</CFLOOP>
			</SELECT>
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td class="text">
<div align="right"><strong>TOTAL</strong></div></td>
      <td><strong> $NZ <INPUT TYPE="text" value="0.00" NAME="Total" class="formstylre" size="6"></strong></td>
      <td colspan="2"><strong> </strong><INPUT NAME="ForeignEstimate" VALUE="0.00 USD" TYPE="TEXT" SIZE="10" CLASS="formstylre">
        <span class="text">(approx)</span></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td colspan="2"><p> 
	      <CFOUTPUT>
          	<input name="Do_#ATTRIBUTES.FuseAction#" type="submit" class="formstylreCopy" value="Continue" ONCLICK="setTotal();if (document.theForm.ExchangeYears.value+document.theForm.RentYears.value+document.theForm.SellYears.value+document.theForm.WTBYears.value+document.theForm.WTRYears.value == 0) { alert('Please select one or more listings'); return false; }">
		  </CFOUTPUT>
          <br>
          <br>
        </p></td>
    </tr>
  </table>
</CFFORM>

<SCRIPT>
		ExchangePriceField = document.getElementById("ExchangePrice");
		RentPriceField = document.getElementById("RentPrice");
		SellPriceField = document.getElementById("SellPrice");
		WTRPriceField = document.getElementById("WTRPrice");
		WTBPriceField = document.getElementById("WTBPrice");
		
		ExchangePriceField.innerHTML='$NZ&nbsp;'+getExchangePrice();		
		RentPriceField.innerHTML='$NZ&nbsp;'+getRentPrice();
		SellPriceField.innerHTML='$NZ&nbsp;'+getSellPrice();
		WTBPriceField.innerHTML='$NZ&nbsp;'+getWTBPrice();
		WTRPriceField.innerHTML='$NZ&nbsp;'+getWTRPrice();
		setTotal();
</SCRIPT>

