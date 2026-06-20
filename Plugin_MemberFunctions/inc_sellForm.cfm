<!--- Display Sell fields --->
<CFSET Title="Sell">
<CFOUTPUT>
<tr> 
  <td colspan="3" class="text"> <div align="left"> <strong>Describe your Vehicle</strong><br>
      I.e Ford, Eurotrans 650, motorhome 1993. 77,000 km, 4-5 berth. New flat 
      roof &quot;Aluglas body. Extra large interior and exterior storage. 
      Single and douible bed options. Shower/cassette toilet, folding handbasin. 
      Extra large 3-way fridge. Air conditioning, TV. Radio/cassette/ CD Player. 
      Colour co-ordinated interior. You could include size, type, nationality 
      of vehicle, power type i.e petrol/diesel. Include extras ie bike rack, 
      awning, power steering. <strong>Use other members pages as examples</strong><br>
    </div></td>
</tr>
<tr> 
  <td width="30%" align="left" valign="top" class="text"><div align="right">YOUR 
      DESCRIPTION OF YOUR VEHICLE</div></td>
  <td colspan="2"><textarea name="LiLongDescription_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiLongDescription_#LiID#'))#</textarea> 
    <br> </td>
</tr>
<tr> 
  <td colspan="3" align="left" valign="top" class="text"><strong>How much 
    money do you want for your Vehicle</strong><br>
    <img src="Images/bullet.gif" width="10" height="10"> This is optional. 
    You may wish to disclose this information once contact with potential 
    buyers has been made. <br>
    <img src="Images/bullet.gif" width="10" height="10"> Please list in your 
    country's currency i.e US $50,000</td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">PRICE</div></td>
  <td colspan="2" align="left" valign="top"><CFINPUT name="LiPrice_#LiID#" type="text" class="formstylre" maxlength="255" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiPrice_#LiID#'))#"></td>
</tr>
</CFOUTPUT>