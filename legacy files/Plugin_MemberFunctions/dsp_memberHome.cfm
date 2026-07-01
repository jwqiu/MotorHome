<CFOUTPUT>
Dear #SESSION.SecurityName# welcome to the Members Only Area.<BR><BR>

In this area you can:

<UL>
<LI><A style="text-decoration: none" HREF="#CGI.SCRIPT_NAME#?FuseAction=EditRenewListing">Edit/Renew your details/listing</A></LI>
<LI><A style="text-decoration: none" HREF="#CGI.SCRIPT_NAME#?FuseAction=AddListing&ActionType=ADD">Add a listing</A></LI>
<LI><A style="text-decoration: none" HREF="Content/SampleVehicle.cfm">View Sample Vehicle Contract</LI>
<LI><A style="text-decoration: none" HREF="#CGI.SCRIPT_NAME#?FuseAction=Listing&LiDateAdded=1">View new listings</A></LI>
<LI><A style="text-decoration: none" HREF="Content/SendPhoto.cfm">Send photo</A></LI>
<LI><A style="text-decoration: none" HREF="#CGI.SCRIPT_NAME#?FuseAction=MemberLogout">Logout</A></LI>
</UL>

Enjoy your motorhome exchange holidays/ all the best with renting, selling and buying. <BR><BR>

Best regards,<BR><BR>
Penny Silva<BR>
#CFG.emailAddress#<BR>
#Replace(CFG.ContactDetails,Chr(13),"<BR>","ALL")#
</CFOUTPUT>