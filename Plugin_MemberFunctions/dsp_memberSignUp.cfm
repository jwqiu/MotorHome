<link href="../styles.css" rel="stylesheet" type="text/css"> 
<p class="bodystyle"><strong><font color="0066cc" size="3">GENERAL APPLICATION 
  FORM FOR EXCHANGE, RENT, BUY, SELL.<br>
  </font>The Following information will be used to create your listing.<br>
  </strong><span class="bodystyle"><br>
  <img src="Images/bullet.gif" width="10" height="10"> If you have any difficulties 
  with this application, please contact us by e-mail.<br>
  <img src="Images/bullet.gif" width="10" height="10"> If any part of your application 
  is incomplete we will e-mail you requesting more detail.<br>
  <img src="Images/bullet.gif" width="10" height="10"> Please use standard text.<br>
  <img src="Images/bullet.gif" width="10" height="10"> Be as descriptive as possible.<br>
  <img src="Images/bullet.gif" width="10" height="10"> Please <a href="mailto:admin@MotorhomeExchange-Sell.com"><font color="#FF6600">e-mail</font></a> 
  <font color="0066cc"><strong>&gt;&gt;&gt;</strong></font> us if any of your 
  details change. You will not be charged for this service.<br>
  <img src="Images/bullet.gif" width="10" height="10"> Be truthful regarding your 
  vehicle.</span><br>
  <br>
</p>
<CFIF Len(ATTRIBUTES.entryErrors) AND IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
	<TABLE WIDTH="450" BORDER="0">
		<TR>
			<TD>
				<FONT COLOR="RED">
					There was an error in the information you supplied, please correct the
					following issues and re-submit. Thank you.
				</FONT>
				<UL>
					<CFLOOP INDEX="message" LIST="#ATTRIBUTES.entryErrors#" DELIMITERS=";">
						<LI> <CFOUTPUT>#message#</CFOUTPUT>
					</CFLOOP>
				</UL>
			</TD>
		</TR>
	</TABLE>
</CFIF>
<BR>
<CFFORM name="theForm" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
  <table width="450" border="0" cellpadding="5" cellspacing="0" class="formstylre">
    <tr valign="middle"> 
      <td colspan="3" class="formtitle"><strong> </strong> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td class="text"><strong><font color="#FFFFFF">APPLICATION FORM</font></strong> 
            </td>
            <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="30%" class="text"> 
        <div align="right">Informal Name</div>
      </td>
      <td> 
        <CFINPUT name="MeInformalName" type="text" class="formstylre" maxlength="255"
			REQUIRED="Yes" Message="Please enter your informal name" VALUE="#HTMLEditFormat(ATTRIBUTES.MeInformalName)#">
      </td>
      <td class="egtext">eg. Tim and Rachel Brown</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Formal Name</div>
      </td>
      <td> 
        <CFINPUT name="MeFormalName" type="text" class="formstylre" maxlength="255"
			REQUIRED="Yes" Message="Please enter your formal name" VALUE="#HTMLEditFormat(ATTRIBUTES.MeFormalName)#">
      </td>
      <td class="egtext">eg. Mr and Mrs Brown</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Address</div>
      </td>
      <td> 
        <CFINPUT name="MeAddress" type="text" class="formstylre" maxlength="127"
			REQUIRED="Yes" Message="Please enter your address" VALUE="#HTMLEditFormat(ATTRIBUTES.MeAddress)#">
      </td>
      <td class="egtext">eg. 32b Smith Street</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Country</div>
      </td>
      <td> 
        <CFQUERY NAME="Q_Countries" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
        SELECT * FROM COUNTRIES ORDER BY CntName 
        </CFQUERY>
        <SELECT name="MeCountryLink" class="formstylre" ONCHANGE="document.theForm.MeCityLink.value=0;document.theForm.MeStateLink.value=0;document.theForm.submit();">
          <option VALUE="">Select Country</option>
          <CFOUTPUT QUERY="Q_Countries"> 
            <OPTION #IIf(ATTRIBUTES.MeCountryLink EQ CntID,DE('SELECTED'),DE(''))# VALUE="#CntID#">#HTMLEditFormat(CntName)#</OPTION>
          </CFOUTPUT> 
        </select>
      </td>
      <td class="egtext">Scroll to Select Your Country</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">State/Province</div>
      </td>
      <td> 
        <CFQUERY NAME="Q_States" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
        SELECT * FROM States WHERE StCountryLink = 
        <CFIF len(ATTRIBUTES.MeCountryLink) EQ 0>
        -1 
        <CFELSE>
        #ATTRIBUTES.MeCountryLink# 
        </CFIF>
        ORDER BY StName 
        </CFQUERY>
        <select name="MeStateLink" class="formstylre" ONCHANGE="document.theForm.MeCityLink.value=0;document.theForm.submit();">
          <option VALUE="">Select State/ Province</option>
          <CFOUTPUT QUERY="Q_States"> 
            <OPTION #IIf(ATTRIBUTES.MeStateLink EQ StID,DE('SELECTED'),DE(''))# VALUE="#StID#">#HTMLEditFormat(StName)#</OPTION>
          </CFOUTPUT> 
        </select>
      </td>
      <td class="egtext">Scroll to Select Your County or Local Area.</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">City</div>
      </td>
      <td> 
        <CFQUERY NAME="Q_Cities" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
        SELECT * FROM Cities WHERE CiStateLink = 
        <CFIF len(ATTRIBUTES.MeStateLink) EQ 0>
        -1 
        <CFELSE>
        #ATTRIBUTES.MeStateLink# 
        </CFIF>
        ORDER BY CiName 
        </CFQUERY>
        <select name="MeCityLink" class="formstylre">
          <option VALUE="">Select City</option>
          <CFOUTPUT QUERY="Q_Cities"> 
            <OPTION #IIf(ATTRIBUTES.MeCityLink EQ CiID,DE('SELECTED'),DE(''))# VALUE="#CiID#">#HTMLEditFormat(CiName)#</OPTION>
          </CFOUTPUT> 
        </select>
      </td>
      <td class="egtext">Scroll to Select Your City</td>
    </tr>
    <tr> 
      <td class="text">&nbsp;</td>
      <td colspan="2"><b><font size="1">If you find that your Country, State/Province 
        or City is NOT present please inform us by e-mailing us at <a href="mailto:admin@motorhomeexchange-sell.com">admin@motorhomeexchange-sell.com</a>. 
        We will add it/them and notify you.</font></b></td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Zip/Postal Code</div>
      </td>
      <td> 
        <CFINPUT name="MeZipCode" type="text" class="formstylre" maxlength="127" VALUE="#HTMLEditFormat(ATTRIBUTES.MeZipCode)#">
      </td>
      <td class="egtext">If applicable</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Nearest Airport</div>
      </td>
      <td> 
        <CFINPUT name="MeAirport" type="text" class="formstylre" maxlength="127" VALUE="#HTMLEditFormat(ATTRIBUTES.MeAirport)#">
      </td>
      <td class="egtext">eg. Christchurch, New Zealand</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Work Phone</div>
      </td>
      <td> 
        <CFINPUT name="MeWorkPhone" type="text" class="formstylre" maxlength="25" VALUE="#HTMLEditFormat(ATTRIBUTES.MeWorkPhone)#">
      </td>
      <td class="egtext">Use Code eg. 00 64 3 then local number.</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Home Phone</div>
      </td>
      <td> 
        <CFINPUT name="MeHomePhone" type="text" class="formstylre" maxlength="25" VALUE="#HTMLEditFormat(ATTRIBUTES.MeHomePhone)#">
      </td>
      <td class="egtext">Use Code eg. 00 64 3 then local number.</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Fax</div>
      </td>
      <td> 
        <CFINPUT name="MeFax" type="text" class="formstylre" maxlength="25" VALUE="#HTMLEditFormat(ATTRIBUTES.MeFax)#">
      </td>
      <td class="egtext">Use Code eg. 00 64 3 then local number.</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right"></div>
      </td>
      <td>&nbsp;</td>
      <td class="egtext">&nbsp;</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">e-mail</div>
      </td>
      <td> 
        <CFINPUT name="MeEmail" type="text" class="formstylre" maxlength="255"
			REQUIRED="Yes" MESSAGE="Please enter your e-mail address"  VALUE="#HTMLEditFormat(ATTRIBUTES.MeEmail)#">
      </td>
      <td class="egtext">This will become your <strong>Motorhome Exchange-sell.com</strong> 
        user name </td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Password</div>
      </td>
      <td> 
        <CFINPUT name="MePassword" type="password" class="formstylre" maxlength="10"
			REQUIRED="Yes" MESSAGE="Please enter your password" VALUE="#HTMLEditFormat(ATTRIBUTES.MePassword)#">
      </td>
      <td class="egtext">6-10 Alpha-numeric characters eg tomcat1</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Confirm Password</div>
      </td>
      <td> 
        <CFINPUT name="MePassword_V" type="password" class="formstylre" maxlength="10"
			REQUIRED="Yes" MESSAGE="Please confirm your password" VALUE="#HTMLEditFormat(ATTRIBUTES.MePassword_V)#">
      </td>
      <td class="egtext">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3" class="bodystyle"><strong>How did you hear about <SPAN CLASS="bodystyle">MotorhomeExchange-Sell.com</SPAN>? 
        </strong><br>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> <CFOUTPUT> 
          <input name="MeHeardFrom" type="RADIO" value="Friend" #IIf("Friend" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
        </CFOUTPUT> <span class="text"> A friend who is currently a member (Use 
        their e-mail address and they will recieve 6 months free membership. Please 
        check with them first). </span></td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Friends E-mail </div>
      </td>
      <td class="text"> <CFOUTPUT> 
          <INPUT name="MeHeardField" type="text" class="formstylre" MAXLENGTH="127" #IIf("Friend" EQ ATTRIBUTES.MeHeardFrom,DE('VALUE="#HTMLEditFormat(ATTRIBUTES.MeHeardField)#"'),DE(''))#>
        </CFOUTPUT> </td>
      <td class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3" class="text"> 
        <div align="left"> <CFOUTPUT> 
            <input type="RADIO" name="MeHeardFrom" value="Internet" #IIf("Internet" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
          </CFOUTPUT> While using the Internet</div>
      </td>
    </tr>
    <tr> 
      <td colspan="3" class="text"> <CFOUTPUT> 
          <input type="RADIO" name="MeHeardFrom" value="Flyer from rally or event" #IIf("Flyer from rally or event" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
        </CFOUTPUT> A flyer from a rally or event (Please quote the code on the 
        flyer)</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Code of Flyer </div>
      </td>
      <td class="text"><CFOUTPUT> 
          <INPUT name="MeHeardField" type="text" class="formstylre" MAXLENGTH="127" #IIf("Flyer from rally or event" EQ ATTRIBUTES.MeHeardFrom,DE('VALUE="#HTMLEditFormat(ATTRIBUTES.MeHeardField)#"'),DE(''))#>
        </CFOUTPUT></td>
      <td class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3" class="text"> <CFOUTPUT> 
          <input type="RADIO" name="MeHeardFrom" value="Advertisement" #IIf("Advertisement" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
        </CFOUTPUT> An Advertisement (Please quote the publication)</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Publication</div>
      </td>
      <td class="text"><CFOUTPUT> 
          <INPUT name="MeHeardField" type="text" class="formstylre" MAXLENGTH="127" #IIf("Advertisement" EQ ATTRIBUTES.MeHeardFrom,DE('VALUE="#HTMLEditFormat(ATTRIBUTES.MeHeardField)#"'),DE(''))#>
        </CFOUTPUT></td>
      <td class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3" class="text"> <CFOUTPUT> 
          <input type="RADIO" name="MeHeardFrom" value="Article" #IIf("Article" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
        </CFOUTPUT> An Article (Please quote the publication)</td>
    </tr>
    <tr> 
      <td class="text"> 
        <div align="right">Publication</div>
      </td>
      <td class="text"><CFOUTPUT> 
          <INPUT name="MeHeardField" type="text" class="formstylre" MAXLENGTH="127" #IIf("Article" EQ ATTRIBUTES.MeHeardFrom,DE('VALUE="#HTMLEditFormat(ATTRIBUTES.MeHeardField)#"'),DE(''))#>
        </CFOUTPUT></td>
      <td class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td class="text"> <CFOUTPUT> 
          <input type="RADIO" name="MeHeardFrom" value="Other" #IIf("Other" EQ ATTRIBUTES.MeHeardFrom,DE('CHECKED'),DE(''))#>
        </CFOUTPUT> Other</td>
      <td colspan="2" class="text"><CFOUTPUT> 
          <INPUT name="MeHeardField" type="text" class="formstylre" MAXLENGTH="127" #IIf("Other" EQ ATTRIBUTES.MeHeardFrom,DE('VALUE="#HTMLEditFormat(ATTRIBUTES.MeHeardField)#"'),DE(''))#>
        </CFOUTPUT></td>
    </tr>
    <tr> 
      <td class="text">&nbsp;</td>
      <td colspan="2" class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td class="text" colspan="3"> 
        <DIV ALIGN="center"> 
          <INPUT name="TermsOfUse" VALUE="1" TYPE="checkbox" REQUIRED="Yes" Message="You must agree to the Terms of Use to become a member">
          I have read the Terms of Use page and agree to all conditions listed.<BR>
          <A HREF="Content/TermsOfUse.cfm" TARGET="_BLANK">Click here</A> <font color="0066cc"><strong>&gt;&gt;&gt; 
          </strong></font>to view Terms of Use. </DIV>
      </td>
    </tr>
    <tr> 
      <td class="text">&nbsp;</td>
      <td colspan="2" class="text">&nbsp;</td>
    </tr>
    <tr> 
      <td class="text">&nbsp;</td>
      <td colspan="2" class="text"> <CFOUTPUT> 
          <input name="Do_#ATTRIBUTES.FuseAction#" type="submit" class="formstylreCopy" value="Submit ">
        </CFOUTPUT> 
        <input name="Submit2" type="reset" class="formstylreCopy" value="Reset ">
      </td>
    </tr>
  </table>
</CFFORM>
<CFSETTING showdebugoutput="yes">