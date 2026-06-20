<!--- Display Wanted To Buy fields --->
<CFSET Title="Wanted To Buy">


<CFOUTPUT>
<tr> 
  <td colspan="3" class="text"> <div align="justify"><strong>Describe the type 
        of vehicle that you require.</strong><br>
      I.e Ford Eurotrans 650 motor home or similiar vehicle. Medium mileage, 
      prefer mid 1990's. Need a 4-5 berth. A large interior is required. We 
      require double and single bed options. Shower/ cassette toilet/ hand 
      basin<strong>. </strong>Would prefer extra large 3-way fridge, air conditioning, 
      modern decor, power steering, bike rack, awning<strong>. Use other members 
      pages as examples</strong><br>
    </div></td>
</tr>
<tr> 
  <td width="30%" align="left" valign="top" class="text">
	<div align="right">YOUR DESCRIPTION</div>
  </td>
  <td colspan="2">
	<textarea name="LiLongDescription_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiLongDescription_#LiID#'))#</textarea> 
    <br>
  </td>
</tr>
<tr> 
  <td colspan="3" align="left" valign="top" class="text"><div align="justify"><strong>Price<br>
      </strong>I.e. We are willing to pay up to NZ$55,000 for a motorhome 
      that fits the above criteria.<br>
      <img src="Images/bullet.gif" width="10" height="10"> This is optional. 
      You may wish to disclose this information once contact with potential 
      sellers has been made.<br>
    </div></td>
</tr>
<tr> 
  <td align="left" valign="top" class="text"><div align="right">PRICE</div></td>
  <td colspan="2" align="left" valign="top"><CFINPUT name="LiPrice_#LiID#" type="text" class="formstylre" maxlength="255" value="#HTMLEditFormat(Evaluate('ATTRIBUTES.LiPrice_#LiID#'))#"></td>
</tr>
</CFOUTPUT>