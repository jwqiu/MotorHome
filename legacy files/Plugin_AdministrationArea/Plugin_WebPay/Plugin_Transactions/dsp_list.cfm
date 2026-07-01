<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>#CFG.PlPlural#</TITLE>
</HEAD>

<BODY>

<CFIF FindNoCase("megamall.co.nz",CGI.HTTP_HOST) EQ 0>

	<CFOUTPUT>
	<p>
	This page must be viewed from a secure connection. 
	Please <A HREF="https://www.megamall.co.nz/MotorhomeExchange/fusebox.cfm?FuseAction=#ATTRIBUTES.FuseAction#">click here</A> 
	to be transferred to the secure server.
	</p>	
	</CFOUTPUT>

<CFELSE>

<CFOUTPUT>
<TABLE WIDTH="100%" ALIGN="CENTER" BORDER="0" CELLSPACING="0" CELLPADDING="2">
	<TR>
		<!--- Search Options Selector --->
		<CFFORM ACTION="#REQUEST.Back#&#SESSION.URLToken#&CurrentPage=1">
			<TD ALIGN="RIGHT">
				<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
				<TR><TD>
				<TABLE WIDTH="100%"  CELLPADDING="0" CELLSPACING="0" BORDER="0">
					<TR><TD ALIGN="LEFT">Search :</TD><TD ALIGN="RIGHT"><CFINPUT SIZE="10" TYPE="TEXT" VALUE="#ATTRIBUTES.SearchKeyword#" NAME="SearchKeyword"></TD></TR>
				</TABLE>
				</TD></TR>
				<TR><TD>
				<TABLE WIDTH="100%"  CELLPADDING="0" CELLSPACING="0" BORDER="0">
					<TR><TD ALIGN="LEFT"><CFSELECT NAME="RowsPerPage" PASSTHROUGH="OnChange='this.form.submit()'">
					<OPTION VALUE="#ATTRIBUTES.RowsPerPage#">#ATTRIBUTES.RowsPerPage# Rows/Page</OPTION>
					<OPTION>10</OPTION>
					<OPTION>25</OPTION>
					<OPTION>50</OPTION>
					<OPTION>100</OPTION>
					<OPTION VALUE="#Q_ListQuery.RecordCount#">#Q_ListQuery.RecordCount#</OPTION>
				</CFSELECT></TD><TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" VALUE="GO" NAME="Go"  CLASS="adminButtons"></TD></TR>
				</TABLE>
				</TD></TR>
				</TABLE>				
			</TD>
		</CFFORM>
	</TR>
</TABLE>
</CFOUTPUT>

<CFIF Q_ListQuery.RecordCount>
	<TABLE WIDTH="100%" ALIGN="CENTER" BORDER="0" CELLSPACING="0" CELLPADDING="2">
		<CFOUTPUT QUERY="Q_ListQuery" STARTROW="#IM_STARTROW#" MAXROWS="#IM_MAXROW#">
			<CFWDDX ACTION="WDDX2CFML" INPUT="#TrPaymentDetailsWDDX#" OUTPUT="PaymentDetails">
			<CFWDDX ACTION="WDDX2CFML" INPUT="#TrFurtherDetailsWDDX#" OUTPUT="FurtherDetails">
			<CFPARAM NAME="FurtherDetails.FieldSet" DEFAULT="">
			<CFSAVECONTENT VARIABLE="FurtherDetails_Txt">
				<CFIF Len(FurtherDetails.FieldSet)>
					<TABLE BORDER="0" WIDTH="100%">
						<CFLOOP LIST="#FurtherDetails.FieldSet#" INDEX="FieldAndType">
							<CFIF IsDefined("FurtherDetails.#ListFirst(FieldAndType, '/')#")>
								<CFSWITCH EXPRESSION="#ListLast(FieldAndType, '/')#">
									<CFCASE VALUE="T,TA">
										<TR>
											<TH ALIGN="LEFT" VALIGN="TOP" WIDTH="10%">#ListFirst(FieldAndType, '/')# :</TH>
											<TD>#FurtherDetails[ListFirst(FieldAndType, '/')]#</TD>
										</TR>
									</CFCASE>
									<CFCASE VALUE="E">
										<TR>
											<TH ALIGN="LEFT" VALIGN="TOP" WIDTH="10%">#ListFirst(FieldAndType, '/')# :</TH>
											<TD><A HREF="mailto:#FurtherDetails[ListFirst(FieldAndType, '/')]#">#FurtherDetails[ListFirst(FieldAndType, '/')]#</A></TD>
										</TR>
									</CFCASE>
									<CFCASE VALUE="D">
										<TR>
											<TH ALIGN="LEFT" VALIGN="TOP" WIDTH="10%">#ListFirst(FieldAndType, '/')# :</TH>
											<TD>
												<CFIF IsNumeric(FurtherDetails[ListFirst(FieldAndType, '/')])>
													#CFG.CurrencySymbol##DecimalFormat(FurtherDetails[ListFirst(FieldAndType, '/')])# #CFG.Currency#
												<CFELSE>
												#FurtherDetails[ListFirst(FieldAndType, '/')]#
												</CFIF>
											</TD>
										</TR>
									</CFCASE>
								</CFSWITCH>
							</CFIF>
						</CFLOOP>
					</TABLE>
				</CFIF>				
			</CFSAVECONTENT>
			<TR >
			<TD COLSPAN="3">&nbsp;

			</TD>
			</TR>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
				<TH ALIGN="LEFT">Time &amp; Date :</TH>
				<TD>#TimeFormat(TrDateTime, "HH:mm:ss")# #DateFormat(TrDateTime, "dd/mm/yyyy")#</TD>
				<TD ROWSPAN="5" STYLE="border:1px solid gray">
					<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="#PaymentDetails.Processor#_presentDetails" PAYMENTDETAILSWDDX="#TrPaymentDetailsWDDX#"/>
					<!--- Process details here --->
				</TD>
				<TD ROWSPAN="5" VALIGN="TOP" ALIGN="RIGHT" BGCOLOR="WHITE"><A HREF="#CGI.SCRIPT_NAME#?FuseAction=#CFG.PlName#Delete&TrID=#TrID#&RFA=#URLEncodedFormat(REQUEST.Back)#"><IMG SRC="images/b-delete.jpg" ALT="Delete" BORDER="0"></A><BR>
				<CFIF Len(FurtherDetails.FieldSet)>
				<SCRIPT>
					divShown#TrID# = false;
					function toggle#TrID#() {
						if (! divShown#TrID#) {
							document.getElementById("Div#TrID#").innerHTML = '#JsStringFormat(FurtherDetails_Txt)#';
							divShown#TrID# = true;
						} else {
							document.getElementById("Div#TrID#").innerHTML = '';
							divShown#TrID# = false;
						}
					}
				</SCRIPT>
				<A HREF="javascript:toggle#TrID#();void(0);"><IMG SRC="images/b-details.jpg" BORDER="0" ALT="Show/Hide Extra Details"></A>
				</CFIF></TD>	
			</TR>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
				<TH ALIGN="LEFT">Reference :</TH>
				<TD>#TrReference#</TD>
			</TR>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
				<TH ALIGN="LEFT">Client Name :</TH>
				<TD>#TrClientName#</TD>
			</TR>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
				<TH ALIGN="LEFT">Client email :</TH>
				<TD>#TrClientemail#</TD>
			</TR>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
				<TH ALIGN="LEFT">Total :</TH>
				<TD>#TrTotal#</TD>
			</TR>
			<TR >
			<TD COLSPAN="3">
			<DIV ID="Div#TrID#"></DIV>
			</TD>
			</TR>
		</CFOUTPUT>
	</TABLE>
</CFIF>

<!--- Next, Previous & Page Number Links --->
<DIV ALIGN="CENTER"><CFOUTPUT>#IM_PAGETHRU#</CFOUTPUT></DIV>

<!--- Supporting Javascript Functions --->
<CFOUTPUT>
<SCRIPT language="Javascript">
<!--
	function confirmDelete(URL) {
		if ( confirm("Are you sure you want to delete this record ?") ) {
			document.location=URL;
		}
	}
	
	function jumper(selectList) {
		urlAppend = selectList.options[selectList.selectedIndex].value;
		selectList.form.reset();
		document.location = urlAppend;
	}
//-->
</SCRIPT>
</CFOUTPUT>
</CFIF>

</BODY>
</HTML>
