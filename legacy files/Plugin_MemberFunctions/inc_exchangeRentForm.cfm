<!--- Display Exchange/Rent fields--->
<CFIF LiExchange EQ 1 AND LiRent NEQ 1>
	<CFSET Title = "Exchange">
<CFELSEIF LiExchange NEQ 1 AND LiRent EQ 1>
	<CFSET Title = "Rent">
<CFELSEIF LiExchange EQ 1 AND LiRent EQ 1>
	<CFSET Title = "Exchange AND Rent">
</CFIF>
<link href="../styles.css" rel="stylesheet" type="text/css">


<link href="../styles.css" rel="stylesheet" type="text/css">
<CFOUTPUT>
<tr> 
 <td colspan="3" class="text"> <div align="justify"><strong>Describe your 
     Vehicle</strong><br>
     I.e Ford, Eurotrans 650, motorhome 1993. 77,000 km, 4-5 berth. New flat 
     roof &quot;Aluglas body. Extra large interior and exterior storage. 
     Single and douible bed options. Shower/cassette toilet, folding handbasin. 
     Extra large 3-way fridge. Air conditioning, TV. Radio/cassette/CD Player. 
     Colour co-ordinated interior. You could include size, type, nationality 
     of vehicle, power type i.e petrol/diesel. Include extras ie bike rack, 
     awning, power steering.) <strong>Use other members pages as examples</strong><br>
   </div></td>
</tr>
<tr> 
 <td align="left" valign="top" class="text"><div align="right">YOUR DESCRIPTION 
     OF YOUR VEHICLE</div></td>
 <td colspan="2">
 	<textarea name="LiLongDescription_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiLongDescription_#LiID#'))#</textarea> 
   <br> </td>
</tr>
<tr> 
 <td colspan="3" align="left" valign="top" class="text"><div align="justify"><strong>Describe 
     your City/Town/Village/Rural Area<br>
     </strong>Include any special features of your area, i.e. mountains, 
     scenic lakes, excellent fishing rivers, great markets, ski areas. Describe 
     adjacent areas that you can drive to within a day or two. It would be 
     useful to list a couple of driving distances, i.e 6 hours drive to Central 
     Otago.</div></td>
</tr>
<tr> 
 <td align="left" valign="top" class="text"><div align="right">YOUR DESCRIPTION 
     OF YOUR AREA AND ADJACENT AREAS</div></td>
 <td colspan="2"><textarea name="LiAreaDescription_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiAreaDescription_#LiID#'))#</textarea></td>
</tr>
<tr> 
 <td colspan="3" align="left" valign="top" class="text"><div align="justify"><strong>Where 
     do you want to go?<br>
     </strong>Name the country's areas and cities that you want to visit 
     by motorhome or other vehicle. The wider the choice you can give the 
     better chances of getting an exchange/ rental opportunity</div></td>
</tr>
<tr> 
 <td align="left" valign="top" class="text"><div align="right">WHERE DO YOU 
     WANT TO GO?</div></td>
 <td colspan="2"><textarea name="LiWhereWantToGo_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiWhereWantToGo_#LiID#'))#</textarea></td>
</tr>
<tr> 
 <td colspan="3" align="left" valign="top" class="text"><strong>Dates: </strong><br>
   Tell us the day month and year that you want to exchange/rent<br>
   i.e Jan 2003- Sept 2003</td>
</tr>
<tr> 
 <td align="left" valign="top" class="text"><div align="right">Date From</div></td>
 <td colspan="2"><table border="0" cellspacing="2" cellpadding="0">
     <tr class="text"> 
	 	<CFSET ID=LiID>
            
          <td><span class="text">day</span> 
<select name="FromDay_#LiID#" class="formstylre">
				  	<CFLOOP FROM="1" TO="31" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.FromDay_#ID#'),DE('SELECTED'),DE(''))#>#x#</OPTION>
					</CFLOOP>
              </select>
			</td>
            
          <td><span class="text">month</span> 
<select name="FromMonth_#LiID#" class="formstylre">
				  	<CFLOOP FROM="1" TO="12" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.FromMonth_#ID#'),DE('SELECTED'),DE(''))#>#MonthAsString(x)#</OPTION>
					</CFLOOP>
              </select>
			</td>
            
          <td><span class="text">year</span> 
<select name="FromYear_#LiID#" class="formstylre">
				  	<CFLOOP FROM="2002" TO="2016" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.FromYear_#ID#'),DE('SELECTED'),DE(''))#>#x#</OPTION>
					</CFLOOP>
              </select>
			</td>
      </tr>
    </table></td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">Date To</div></td>
  <td colspan="2"><table border="0" cellspacing="2" cellpadding="0">
      <tr class="text"> 
            
          <td><span class="text">day</span> 
<select name="ToDay_#LiID#" class="formstylre">
				  	<CFLOOP FROM="1" TO="31" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.ToDay_#ID#'),DE('SELECTED'),DE(''))#>#x#</OPTION>
					</CFLOOP>
              </select>
			</td>
            
          <td><span class="text">month</span> 
<select name="ToMonth_#LiID#" class="formstylre">
				  	<CFLOOP FROM="1" TO="12" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.ToMonth_#ID#'),DE('SELECTED'),DE(''))#>#MonthAsString(x)#</OPTION>
					</CFLOOP>
              </select>
			</td>
            
          <td><span class="text">year</span> 
<select name="ToYear_#LiID#" class="formstylre">
				  	<CFLOOP FROM="2002" TO="2016" INDEX="x">
						<OPTION VALUE="#x#" #IIf(x EQ Evaluate('ATTRIBUTES.ToYear_#ID#'),DE('SELECTED'),DE(''))#>#x#</OPTION>
					</CFLOOP>
              </select>
			</td>
      </tr>
    </table></td>
</tr>
<tr> 
  <td colspan="3" align="left" valign="top" class="text"><strong>Personal 
    Information : </strong><br> <img src="Images/bullet.gif" width="10" height="10"> 
    The Following is optional. Often people like to exchange with others with 
    similiar backgrounds and interests</td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">Your Professions</div></td>
  <td align="left" valign="top"><textarea name="LiProfession_#LiID#" cols="30" rows="5" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiProfession_#LiID#'))#</textarea></td>
    <td class="egtext">eg. Tim is a retired doctor, Rachel is a homemaker</td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">Interests/ 
      Hobbies</div></td>
  <td align="left" valign="top"><textarea name="LiInterests_#LiID#" cols="30" rows="5" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiInterests_#LiID#'))#</textarea></td>
    <td class="egtext">eg. Tim enjoys skiing, fishing, tramping, wine-tasting, and 
      Indian cooking.<br>
    Rachel enjoys needlework, markets, tramping, indoor bowls and travelling.<br></td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">Age Range</div></td>
  <td align="left" valign="top"><CFINPUT NAME="LiAgeRange_#LiID#" type="text" class="formstylre" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiAgeRange_#LiID#'))#" MAXLENGTH="255"></td>
    <td class="egtext">eg. Rachael and I are in our mid 60's</td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">Any Other 
      Information you would like to share</div></td>
  <td align="left" valign="top"><textarea name="LiOther_#LiID#" cols="30" rows="5" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiOther_#LiID#'))#</textarea></td>
    <td class="egtext">eg. We have 3 married children in their 30s and 7 grand-children. 
      We travelled throughout Europe in a motorhome in 1993. We loved the experience. 
      We look forward to travelling again soon.</td>
</tr>
</CFOUTPUT>