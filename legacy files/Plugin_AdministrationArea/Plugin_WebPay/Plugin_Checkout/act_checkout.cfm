<CFSILENT>
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		
		<CFIF ATTRIBUTES.Total EQ 0>
			<!--- The transaction is free, no need to send it thru 
				- the payment processor 
				--->
			<CFSET ATTRIBUTES.EntryErrors = "">
			
			<!--- Make a fake DPS packet --->
			<CFSET x = StructNew()>
			<CFSET x.Processor = "DPS">
			<CFSET Config = CFG.WebPay.Processor.DPS>
			<CFSET x.Config    = Config>
			<CFSET x.Amount    = ATTRIBUTES.Total>
			<CFIF NOT Len(ATTRIBUTES.entryErrors)>
				<CFLOOP LIST="AuthCode,CardName,ClientId,DateSettlement,HostDate,HostTime,PreAuthNumber,ResponseCode,ResponseText,Success,TxnRef,VersionMajor,VersionMinor,VersionRevision" INDEX="varName">
					<CFSET x[varName] = "">
				</CFLOOP>
			</CFIF>	
			<CFWDDX ACTION="CFML2WDDX" INPUT=#x# OUTPUT="ATTRIBUTES.paymentDetailsWDDX">
			
		<CFELSE>

			<!--- First make sure of the basics --->
			<CFIF NOT Len(ATTRIBUTES.Name)>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";Please enter your full name.">
			</CFIF>
			<CFIF NOT Len(ATTRIBUTES.Email)>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";Please enter your email address.">
			</CFIF>		
			<CFIF NOT Len(ATTRIBUTES.Reference)>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";No reference code supplied, please contact the web site developers.">
			</CFIF>
			
			<CFPARAM NAME="ATTRIBUTES.Processor" DEFAULT="">
			<CFIF NOT Len(ATTRIBUTES.Processor)>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors & ";You must choose a payment method and complete all details for the chosen method.">
			</CFIF>
		
			<!--- ok, if no errors yet, try and do the transaction --->
			<CFIF NOT Len(ATTRIBUTES.entryErrors)>
				<CFMODULE 	TEMPLATE="#CFG.TopLevel#" FUSEACTION="#ATTRIBUTES.Processor#_charge" 
							ATTRIBUTECOLLECTION=#ATTRIBUTES# TOTAL="#ATTRIBUTES.Total#" 
							CURRENCY="#CFG.WebShop.Currency#" />
				<CFSET ATTRIBUTES.entryErrors = CFMODULE.ATTRIBUTES.entryErrors>
				<CFSET ATTRIBUTES.paymentDetailsWDDX = CFMODULE.ATTRIBUTES.PaymentDetailsWDDX>
			</CFIF>
		
		</CFIF>
		
		<!--- if no errors we can now store in the DB --->
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<!--- Convert into NZD if necessary --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="exchangeRate" FROM="#CFG.WebShop.Currency#" TO="NZD" />
			<CFSET Total_NZD = ATTRIBUTES.Total * CFMODULE.ATTRIBUTES.ExchangeRate>
			<CFTRANSACTION>
				<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_Maxim">
					SELECT (Max(TrID) + 1) AS NxtID FROM Transactions
				</CFQUERY>
				
				<CFIF Len(Q_Maxim.NxtID)>
					<CFSET NxtID = Q_Maxim.NxtID>
				<CFELSE>
					<CFSET NxtId = 1>			
				</CFIF>
				
				<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_InsNext">
					INSERT INTO Transactions 
						(TrID, TrDateTime, TrReference, TrTotal, TrTotal_NZD, 
						 TrClientName, TrClientemail, TrFurtherDetailsWDDX, TrPaymentDetailsWDDX)
					VALUES 
						(#NxtID#, #CreateODBCDateTime(Now())#, '#ATTRIBUTES.Reference#', '#CFG.WebShop.CurrencySymbol##DecimalFormat(ATTRIBUTES.Total)# #CFG.WebShop.Currency#', #Total_NZD#, '#ATTRIBUTES.Name#', '#ATTRIBUTES.email#', '#ATTRIBUTES.FurtherDetailsWDDX#', '#ATTRIBUTES.PaymentDetailsWDDX#')
				</CFQUERY>
			</CFTRANSACTION>
		</CFIF>
		
		<!--- If still no errors, we can send emails --->
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
		<CFSCRIPT>
			function writeField(name,value,type) {
				var returnString = "";
				
				if (type eq "T") {
					returnString = name & " : " & value & chr(13) & chr(10);
				}
				if (type eq "TA") {
					returnString = name & " :" & chr(13) & chr(10) & value & chr(13) & chr(10);					
				}
				if (type eq "E") {
					returnString = name & " : " & value & chr(13) & chr(10);
				}
				if (type eq "D") {
					if (isNumeric(value)) {
						returnString = name & " : " & CFG.WebShop.CurrencySymbol & decimalFormat(value) & " " & CFG.WebShop.Currency & chr(13) & chr(10);
					} else {
						returnString = name & " : " & value & chr(13) & chr(10);
					}
				}
				return returnString;
			}
		</CFSCRIPT>
		<CFWDDX ACTION="WDDX2CFML" INPUT="#ATTRIBUTES.FurtherDetailsWDDX#" OUTPUT="FurtherDetails">
<!--- One to the administrator --->
<CFMAIL FROM="#CFG.EmailAddress#" TO="#CFG.EmailAddress#" SUBJECT="Payment Received (Ref:#ATTRIBUTES.Reference#)">
Payment of #CFG.WebShop.CurrencySymbol##DecimalFormat(ATTRIBUTES.Total)# #CFG.WebShop.Currency# with regard to reference code #ATTRIBUTES.Reference# has been processed.
<CFIF Len(FurtherDetails.FieldSet)><CFLOOP LIST="#FurtherDetails.FieldSet#" INDEX="FieldNType">#writeField(ListFirst(FieldNType, '/'), FurtherDetails[ListFirst(FieldNType, '/')], ListLast(FieldNType, '/'))#</CFLOOP></CFIF>
Your may view the transaction list at the following URL :
	#CFG.TopURL#?FuseAction=transactionsList
</CFMAIL>

<!--- One to the client --->
<CFMAIL FROM="#CFG.EmailAddress#" TO="#ATTRIBUTES.Email#" SUBJECT="Payment Receipt (Ref:#ATTRIBUTES.Reference#)">
This is a receipt of your payment details for #CFG.WebShop.CurrencySymbol##DecimalFormat(ATTRIBUTES.Total)# #CFG.WebShop.Currency# (Ref: #ATTRIBUTES.Reference#) has been processed.

Should you have any questions regarding this payment simply reply to this email or contact us :
#CFG.ContactDetails#
</CFMAIL>
		</CFIF>
		
		<!--- POST back to the notification URL if there is one --->
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			
			<CFIF Len(CFG.WebPay.NotifyURL)>
				<CFHTTP METHOD="POST" URL="#CFG.WebPay.NotifyURL#" >
					<CFHTTPPARAM TYPE="FORMFIELD" NAME="Reference" VALUE="#ATTRIBUTES.Reference#">
					<CFHTTPPARAM TYPE="FORMFIELD" NAME="Pass" VALUE="#Hash(CFG.AdminPassword)#">
				</CFHTTP>
			</CFIF>
		</CFIF>
		
		<CFIF ATTRIBUTES.Total EQ 0>

			<CFIF NOT Len(ATTRIBUTES.entryErrors)>
				<!--- All done --->
				<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=accepted&Reference=#URLEncodedFormat(ATTRIBUTES.Reference)#&NoCharge=1">
			</CFIF>
		
		<CFELSE>

			<CFIF NOT Len(ATTRIBUTES.entryErrors)>
				<!--- All done --->
				<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=accepted&Reference=#URLEncodedFormat(ATTRIBUTES.Reference)#">
			</CFIF>
	
		</CFIF>
		
		
	</CFIF>
</CFSILENT>