<!--- Display Wanted To Rent fields --->
<CFSET Title="Wanted To Rent">
<CFOUTPUT>
<tr> 
  <td colspan="3" class="text">
    <div align="justify"> <strong>Describe the type of vehicle that you require.</strong><br>
      I.e - We would like a Ford Eurotrans 650 motorhome or similiar vehicle. 
      We require a 4-5 berth motorhome. There are 4 of us travelling together 
      initially and maybe a 5th passenger later in our holiday. We need lots 
      of storage and single and double bed options. The motorhome would need 
      to have a shower, toilet, and hand basin. We would prefer an extra large 
      3 way fridge and air conditioning. We would like power steering and 
      a bike rack. <strong>Use other members pages as examples</strong><br>
    </div></td>
</tr>
<tr> 
  <td width="30%" align="left" valign="top" class="text"><div align="right">YOUR 
      DESCRIPTION</div></td>
  <td colspan="2"><textarea name="LiLongDescription_#LiID#" cols="30" rows="4" class="formstylre">#HTMLEditFormat(Evaluate('ATTRIBUTES.LiLongDescription_#LiID#'))#</textarea> 
    <br> </td>
</tr>
</CFOUTPUT>
