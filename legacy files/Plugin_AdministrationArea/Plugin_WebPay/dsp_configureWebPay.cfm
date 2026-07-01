<CFIF Len(ATTRIBUTES.entryErrors) AND IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
<P>
	<TABLE WIDTH="95%" BORDER="0" ALIGN="CENTER">
		<TR>
			<TD CLASS="entryErrors">
				Errors were detected in the data you entered, please correct the
				following issues and re-submit.  Nothing has been changed or added
				to the database at this point.
				<UL>
					<CFLOOP INDEX="message" LIST="#ATTRIBUTES.entryErrors#" DELIMITERS=";">
						<LI> <CFOUTPUT>#message#</CFOUTPUT>
					</CFLOOP>
				</UL>
			</TD>
		</TR>
	</TABLE>
</P>
</CFIF>

<CFFORM ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=1" NAME="theForm">
<TABLE BORDER="0" WIDTH="100%">
	<TR>
		<TD ALIGN="LEFT" VALIGN="TOP">
			<SPAN CLASS="displayName">Process URL's</SPAN>
		</TD>
		<TD ALIGN="LEFT" VALIGN="TOP">

			<TABLE WIDTH="100%" BORDER="0">
				<TR>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<SPAN CLASS="required">*</SPAN>
					</TD>
					<TH ALIGN="LEFT">Transaction Accepted URL</TH>
					<TD ALIGN="LEFT">
						<CFINPUT TYPE="TEXT" NAME="AcceptedURL" VALUE="#ATTRIBUTES.AcceptedURL#" REQUIRED="Yes" 
							MESSAGE="Please enter a URL to transfer accepted transactions to on completion.">
					</TD>
				</TR>
				<TR>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">&nbsp;
						
					</TD>
					<TH ALIGN="LEFT">Transaction Accepted Notify URL</TH>
					<TD ALIGN="LEFT">
						<CFINPUT TYPE="TEXT" NAME="NotifyURL" VALUE="#ATTRIBUTES.NotifyURL#" REQUIRED="No">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="LEFT" VALIGN="TOP">
			<SPAN CLASS="displayName">Payment Methods (Processors)</SPAN>
		</TD>
		<TD ALIGN="LEFT" VALIGN="TOP">
<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="Manual_configForm" ATTRIBUTECOLLECTION=#ATTRIBUTES# /><BR>
<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="DPS_configForm" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
		</TD>
	</TR>
	<TR>
		<TD ALIGN="LEFT" VALIGN="TOP">
			<SPAN CLASS="displayName">Graphics</SPAN>
		</TD>
		<TD ALIGN="LEFT" VALIGN="TOP">
		<P>
		<STRONG>Page Title Images</STRONG><BR>
		<TABLE BORDER="0">
			<TR><TH ALIGN="LEFT">Payment Page</TH>
			<TD><CFINPUT TYPE="text" NAME="PaymentTitleImage" SIZE="30" 
				MAXLENGTH="255" 
				REQUIRED="0"   VALUE="#ATTRIBUTES.PaymentTitleImage#" 
				/> 
				<CFIF pb_serviceAvailable("imageManager")>
					<CFMODULE TEMPLATE="#CFG.TopLevel#"  FUSEACTION="imageManagerFieldButtons" 
					FIELDNAME="PaymentTitleImage"        FORM="theForm"
					DIRECTORY="#CFG.ImagesDirectory#\"   URL="#CFG.ImagesURL#/" />
				</CFIF>
			</TD>
		   </TR>
		   <TR><TH ALIGN="LEFT">Accepted Page</TH>
			<TD><CFINPUT TYPE="text" NAME="AcceptedTitleImage" SIZE="30" 
				MAXLENGTH="255" 
				REQUIRED="0"   VALUE="#ATTRIBUTES.AcceptedTitleImage#" 
				/>
				<CFIF pb_serviceAvailable("imageManager")>
					<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="imageManagerFieldButtons" 
					FIELDNAME="AcceptedTitleImage"       FORM="theForm" 
					DIRECTORY="#CFG.ImagesDirectory#\"   URL="#CFG.ImagesURL#/" />
				</CFIF>
			</TD>
		   </TR>
		</TABLE>
		</P>
		<P>
		<STRONG>Buttons</STRONG>
		<TABLE BORDER="0">
			<TR><TH ALIGN="LEFT">Payment Button</TH>
			<TD><CFINPUT TYPE="text" NAME="PaymentButton" SIZE="30" 
				MAXLENGTH="255" 
				REQUIRED="0"   VALUE="#ATTRIBUTES.PaymentButton#" 
				/> 
				<CFIF pb_serviceAvailable("imageManager")>
					<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="imageManagerFieldButtons" 
					FIELDNAME="PaymentButton"           FORM="theForm" 
					DIRECTORY="#CFG.ImagesDirectory#\"   URL="#CFG.ImagesURL#/" />
				</CFIF>
			</TD>
		   </TR>
		</TABLE>
		</P>
		</TD>
	</TR>
	
	<CFIF NOT pb_serviceAvailable("configureWebShop")>
		<!--- As this web pay is not accompanied by a web shop, we need to 
			- ask for the currency details --->
	<TR>
		<TD ALIGN="LEFT" VALIGN="TOP">
			<SPAN CLASS="displayName">Trading Currency</SPAN>
		</TD>
		<TD ALIGN="LEFT" VALIGN="TOP">

			<TABLE WIDTH="100%" BORDER="0">
				<TR>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<SPAN CLASS="required">*</SPAN>
					</TD>
					<TH ALIGN="LEFT">Currency</TH>
					<TD ALIGN="LEFT">
						<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="currencyQuery" />
						<CFSELECT NAME="Currency" SELECTED="#ATTRIBUTES.Currency#" QUERY="CFMODULE.ATTRIBUTES.Q_ListQuery" VALUE="Code" DISPLAY="DESC"></CFSELECT>
					</TD>
				</TR>
				<TR>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">&nbsp;
						
					</TD>
					<TH ALIGN="LEFT">Currency Symbol<BR><SMALL>(e.g $, &pound;, &euro;, &yen;, &curren; ...)</SMALL></TH>
					<TD ALIGN="LEFT">
						<CFINPUT TYPE="TEXT" NAME="CurrencySymbol" VALUE="#ATTRIBUTES.CurrencySymbol#" REQUIRED="No">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	</CFIF>
	
</TABLE>

<!--- <CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="DPS_configForm"    /> --->
<P>&nbsp;</P>
<INPUT TYPE="SUBMIT" VALUE="SUBMIT" CLASS="adminButtons">
</CFFORM>
