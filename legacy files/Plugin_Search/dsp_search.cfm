<link href="../styles.css" rel="stylesheet" type="text/css">    <table width="450" border="0" cellpadding="5" cellspacing="0" class="formstylre">
	<CFFORM name="theForm" action="#CGI.SCRIPT_NAME#?FuseAction=Listing">
    <tr> 
      <td colspan="2" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td class="text"><strong><font color="#FFFFFF">SEARCH / VIEW LISTING</font></strong></td>
            <td width="20"><strong><img src="Images/question.gif" width="20" height="20"></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td width="30%" align="left" valign="top" class="text"> 
		<div align="right">
          <p class="text">By Country</p>
</div>
	  </td>
      <td> <table width="300" border="0" cellspacing="0" cellpadding="5">
          <TR> 
            <TD width="33%" VALIGN="TOP"> <CFOUTPUT QUERY="Q_Countries"> 
			  <INPUT TYPE="Checkbox" NAME="CountryList" VALUE="#CntID#">&nbsp;<span class="text">#Replace(CntName," ","&nbsp;","ALL")#</span><BR> <BR> <CFIF (Evaluate(CurrentRow MOD ((Q_Countries.RecordCount+2) / 3)) EQ 0) AND (CurrentRow NEQ Q_Countries.RecordCount)>
            </td>
            <TD width="33%" VALIGN="TOP"> </CFIF> </CFOUTPUT>	
            </TD>
          </TR>
          <TR class="text"> 
            <td colspan="3" class="text">Keyword 
              <input name="SearchKeywords" type="text" class="formstylre"></td>
          </tr>
          <tr class="text"> 
            <td colspan="3"> <span class="text"><font color="#FFFFFF">Keyword</font></span> 
<input name="Submit2" type="submit" class="loginbutton" value="Search"> 
            </td>
          </tr>
        </table></td>
    </tr>
    </CFFORM>
  </table>

  <BR>

  <A NAME="Advanced">
  <table width="450" border="0" cellpadding="5" cellspacing="0" class="formstylre">
    <CFFORM NAME="theOtherForm" ACTION="#CGI.SCRIPT_NAME###Advanced">
	<INPUT NAME="FuseAction" VALUE="Listing" TYPE="HIDDEN">
    <tr> 
      <td colspan="2" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td class="text"><strong><font color="#FFFFFF">ADVANCED SEARCH</font></strong></td>
            <td width="20"><strong><img src="Images/question.gif" width="20" height="20"></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td width="30%" class="text"><div align="right">Select Country</div></td>
      <td>
	  	<CFOUTPUT>
	    <select name="MeCountryLink" class="formstylre" ONCHANGE="document.theOtherForm.MeCityLink.value=0;document.theOtherForm.MeStateLink.value=0;document.theOtherForm.FuseAction.value='#ATTRIBUTES.FuseAction#';document.theOtherForm.submit();">
          <option value="">all</option>
		  <CFLOOP QUERY="Q_Countries">
				<OPTION #IIf(ATTRIBUTES.MeCountryLink EQ CntID,DE('SELECTED'),DE(''))# VALUE="#CntID#">#HTMLEditFormat(CntName)#
		  </CFLOOP>
        </select>
		</CFOUTPUT>
		
		</td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Select State/ Province</div></td>
      <td>
		<CFOUTPUT>
	  	<select name="MeStateLink" class="formstylre" ONCHANGE="document.theOtherForm.MeCityLink.value=0;document.theOtherForm.FuseAction.value='#ATTRIBUTES.FuseAction#';document.theOtherForm.submit();">
          <option VALUE="">all</option>
		  <CFLOOP QUERY="Q_States">
			<OPTION #IIf(ATTRIBUTES.MeStateLink EQ StID,DE('SELECTED'),DE(''))# VALUE="#StID#">#HTMLEditFormat(StName)#
		  </CFLOOP>
        </select>
	    </CFOUTPUT>
		  
		</td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Select City</div></td>
      <td>
	  	<select name="MeCityLink" class="formstylre">
          <option VALUE="">all</option>
		  <CFOUTPUT QUERY="Q_Cities">
			<OPTION #IIf(ATTRIBUTES.MeCityLink EQ CiID,DE('SELECTED'),DE(''))# VALUE="#CiID#">#HTMLEditFormat(CiName)#
		  </CFOUTPUT>
        </select>
	  </td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Category of Vehicle</div></td>
      <td>
	  	<CFOUTPUT>
	  	<select name="VehicleType" class="formstylre">
	  	  <option value="">all</option>
		  	<CFLOOP QUERY="Q_VehicleTypes">
				<OPTION VALUE="#VeTyID#" #Iif(VeTyID EQ ATTRIBUTES.VehicleType,DE('SELECTED'),DE(''))#>#VeTyName#</OPTION>
			</CFLOOP>
        </select>
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Type of Listing</div></td>
      <td>
	    <CFOUTPUT>
	  	<select name="Type" class="formstylre">
	  	  <option #IIf(ATTRIBUTES.Type EQ "",DE('SELECTED'),DE(''))# value="">all</option>
          <option #IIf(ATTRIBUTES.Type EQ "E",DE('SELECTED'),DE(''))# value="E">Exchange</option>
          <option #IIf(ATTRIBUTES.Type EQ "R",DE('SELECTED'),DE(''))# value="R">Rent</option>
          <option #IIf(ATTRIBUTES.Type EQ "S",DE('SELECTED'),DE(''))# value="S">Sell</option>
          <option #IIf(ATTRIBUTES.Type EQ "WB",DE('SELECTED'),DE(''))# value="WB">Wanted to Buy</option>
          <option #IIf(ATTRIBUTES.Type EQ "WR",DE('SELECTED'),DE(''))# value="WR">Wanted to Rent</option>
        </select>
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Dates from</div></td>
      <td><table border="0" cellspacing="2" cellpadding="0">
          <tr class="text"> 
            <td><span class="text">day</span> 
<select name="FromDay" class="formstylre">
				<CFOUTPUT>
				  	<CFLOOP FROM="1" TO="31" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.FromDay,DE('SELECTED'),DE(''))#>#x#</OPTION>
					</CFLOOP>
				</CFOUTPUT>
              </select>
			</td>
            <td><span class="text">month </span> <select name="FromMonth" class="formstylre">
                <CFOUTPUT> 
                  <CFLOOP FROM="1" TO="12" INDEX="x">
                    <OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.FromMonth,DE('SELECTED'),DE(''))#>#MonthAsString(x)#</OPTION>
                  </CFLOOP>
                </CFOUTPUT> </select>
			</td>
            <td><span class="text">year </span> <select name="FromYear" class="formstylre">
                <CFOUTPUT> 
                  <CFLOOP FROM="2002" TO="2016" INDEX="x">
                    <OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.FromYear,DE('SELECTED'),DE(''))#>#x#</OPTION>
                  </CFLOOP>
                </CFOUTPUT> </select>
			</td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Dates to</div></td>
      <td><table border="0" cellspacing="2" cellpadding="0">
          <tr class="text"> 
            <td><span class="text">day </span> <select name="ToDay" class="formstylre">
                <CFOUTPUT> 
                  <CFLOOP FROM="1" TO="31" INDEX="x">
                    <OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.ToDay,DE('SELECTED'),DE(''))#>#x#</OPTION>
                  </CFLOOP>
                </CFOUTPUT> </select>
			</td>
            <td><span class="text">month </span> <select name="ToMonth" class="formstylre">
                <CFOUTPUT> 
                  <CFLOOP FROM="1" TO="12" INDEX="x">
                    <OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.ToMonth,DE('SELECTED'),DE(''))#>#MonthAsString(x)#</OPTION>
                  </CFLOOP>
                </CFOUTPUT> </select>
			</td>
            <td><span class="text">year </span> <select name="ToYear" class="formstylre">
                <CFOUTPUT> 
                  <CFLOOP FROM="2002" TO="2016" INDEX="x">
                    <OPTION VALUE="#x#" #IIf(x EQ ATTRIBUTES.ToYear,DE('SELECTED'),DE(''))#>#x#</OPTION>
                  </CFLOOP>
                </CFOUTPUT> </select>
			</td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class="text"><div align="right">Keyword</div></td>
      <td>
	  	<CFOUTPUT>
		  	<input name="SearchKeywords" type="text" class="formstylre" value="#ATTRIBUTES.SearchKeywords#">
		</CFOUTPUT>
	  </td>
    </tr>
    <tr> 
      <td class="text">&nbsp;</td>
      <td><input name="Submit" type="submit" class="loginbutton" value="Search"> 
        <br> <br> </td>
    </tr>
    <tr> 
      <td colspan="2"> <font color="#FF6600">
        <CFIF Len(SESSION.SecurityEmail)>
          <CFOUTPUT> </CFOUTPUT>
        </CFIF>
        </font>
        <CFIF Len(SESSION.SecurityEmail)>
          <CFOUTPUT><a href="#CGI.SCRIPT_NAME#?FuseAction=Listing&LiDateAdded=1" class="text"> 
            <font color="##FF6600"><strong>Click here<font size="2"> </font></strong></font></a> 
          </CFOUTPUT> <font size="2"><span class="text"> <strong><font color="0066cc">&gt;&gt;&gt;</font></strong> 
          to view new listings</span></font> 
        </CFIF>
	  </td>
    </tr>
    </CFFORM>
  </table>
  </A>
