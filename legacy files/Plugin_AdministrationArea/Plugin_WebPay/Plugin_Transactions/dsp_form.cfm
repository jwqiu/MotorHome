
	<CFSAVECONTENT VARIABLE="HTMLHEAD">
		<SCRIPT language="Javascript">
		<!--
			function _PB_onError(form_object, input_object, object_value, error_message)
		    {
				alert(error_message);
				input_object.focus()
		       	return false;	
		    }
		//-->
		</SCRIPT>
		<STYLE TYPE="text/css">
			.required { color : red }
			.displayName { font-weight : bold }
			.note { font-size : smaller }
			.errorField {
				background : LightSkyBlue;
			}
</STYLE>
	</CFSAVECONTENT>
	<CFHTMLHEAD TEXT="#HTMLHEAD#">

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
	<CFLOOP QUERY="CFG.Fields">
		<CFSET ErrorMessage = "">
		<CFIF Len(Message)>
			<CFSET ErrorMessage = Message>
		<CFELSEIF Required>
			<CFSET ErrorMessage = DisplayName & " is required.">
		</CFIF>
		
		<CFSET Value = Attributes[FieldName]>
		<CFIF Value eq CFG.pb_null>
			<CFSET Value = "">
		</CFIF>
		
		<CFIF Verify>
			<CFSET Value_V = Attributes[FieldName & '_V']>
			<CFIF Value_V eq CFG.pb_null>
				<CFSET Value_V = "">
			</CFIF>
		</CFIF>
		<CFSWITCH EXPRESSION="#Type#">
					
			<CFCASE VALUE="text,password">
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP" WIDTH="30%">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="#Type#" NAME="#FieldName#" SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="#ErrorMessage#" 
							REQUIRED="#Required#" VALUE="#Value#" 
							ONERROR="_PB_onError"/>
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="#Type#"      NAME="#FieldName#_V"     SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="Please verify #DisplayName#." 
							REQUIRED="#Required#"   VALUE="#Value_V#" 
							ONERROR="_PB_onError"/>
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
		
			<CFCASE VALUE="integer,float,money,percent">
				<CFSET ValidateType = Type>
				<CFSET PreFix = "">
				<CFSET PostFix = "">
				<CFIF Type eq "money">
					<CFSET ValidateType = "float">
					<CFSET PreFix = "$">
				</CFIF>
				<CFIF Type eq "percent">
					<CFSET ValidateType = "float">
					<CFSET PostFix = "%">
				</CFIF>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						#PreFix#<CFINPUT TYPE="text" NAME="#FieldName#" SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="#ErrorMessage#\nOnly (#type#) numbers are permitted in this field." 
							REQUIRED="#Required#" VALUE="#Value#" 
							ONERROR="_PB_onError" VALIDATE="#ValidateType#"/>#PostFix#
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						#PreFix#<CFINPUT TYPE="text"      NAME="#FieldName#_V"     SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="Please verify #DisplayName#." 
							REQUIRED="#Required#"   VALUE="#Value_V#" 
							ONERROR="_PB_onError" />#PostFix#
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
		
			<CFCASE VALUE="date">
				<CFIF IsDate(Value)>
					<CFSET DateVal = DateFormat(Value, CFG.pb_lsDateFormatString)>
				<CFELSE>
					<CFSET DateVal = Value>
				</CFIF>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="text" NAME="#FieldName#" SIZE="10" 
							MAXLENGTH="10" MESSAGE="#ErrorMessage#\nEnsure the date is in #CFG.pb_lsDateFormatString# format." 
							REQUIRED="#Required#" VALUE="#DateVal#" 
							ONERROR="_PB_onError" VALIDATE="#CFG.pb_lsDateValidator#"/> #CFG.pb_lsDateFormatString#
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFIF IsDate(Value_V)>
					<CFSET DateVal = DateFormat(Value_V, CFG.pb_lsDateFormatString)>
				<CFELSE>
					<CFSET DateVal = Value_V>
				</CFIF>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="text"      NAME="#FieldName#_V"     SIZE="10" 
							MAXLENGTH="10" MESSAGE="Please verify #DisplayName#." 
							REQUIRED="#Required#"   VALUE="#DateVal#" 
							ONERROR="_PB_onError"/> #CFG.pb_lsDateFormatString#
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="checkbox,boolean">
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="checkbox" NAME="#FieldName#" MESSAGE="#ErrorMessage#" 
							REQUIRED="#Required#" VALUE="1" CHECKED="#IIF(Value eq 1, DE('Yes'), DE('No'))#" 
							ONERROR="_PB_onError"/>
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="checkbox"  NAME="#FieldName#_V" MESSAGE="#ErrorMessage#" 
							REQUIRED="#Required#" VALUE="1" CHECKED="#IIF(Value_V eq 1, DE('Yes'), DE('No'))#" 
							ONERROR="_PB_onError"/>
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="lookup,multilookup">
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SELECT NAME="#FieldName#" #IIF(type eq "multilookup", DE('MULTIPLE SIZE="#Size#"'), DE(''))#>
							<CFIF NOT Required and not type eq "multilookup"><OPTION VALUE="" #IIF(NOT Len(Value), DE('SELECTED'), DE(''))#>&nbsp;</OPTION></CFIF>
							<CFSET Q_Lookup = Lookups[FieldName]>
							<CFSET SelVal   = Value>
							<CFSET ValField = LinkQueryValue>
							<CFSET DisField = LinkQueryDisplay>
							<CFLOOP QUERY="Q_Lookup">
								<OPTION VALUE="#Evaluate(ValField)#" #IIF(ListFind(SelVal, Evaluate(ValField)), DE('selected'), DE(''))#>#HTMLEditFormat(Evaluate(DisField))#</OPTION>
							</CFLOOP>
						</SELECT>
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SELECT NAME="#FieldName#_V" #IIF(type eq "multilookup", DE('MULTIPLE SIZE="#Size#"'), DE(''))#>
							<CFIF NOT Required and not type eq "multilookup"><OPTION VALUE="" #IIF(NOT Len(Value_V), DE('SELECTED'), DE(''))#>&nbsp;</OPTION></CFIF>
							<CFSET Q_Lookup = Lookups[FieldName & '_V']>
							<CFSET SelVal   = Value_V>
							<CFSET ValField = LinkQueryValue>
							<CFSET DisField = LinkQueryDisplay>
							<CFLOOP QUERY="Q_Lookup">
								<OPTION VALUE="#Evaluate(ValField)#" #IIF(ListFind(SelVal, Evaluate(ValField)), DE('selected'), DE(''))#>#HTMLEditFormat(Evaluate(DisField))#</OPTION>
							</CFLOOP>
						</SELECT>
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="memo">
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFIF AllowHTML>
						<SMALL>
							<STRONG>Windows Internet Explorer 5+</STRONG> - <A HREF="javascript:htmlEdit('#FieldName#')">graphical editor</A> for more formatting options.<BR>
							<STRONG>Other Users</STRONG> - seperate paragraphs with blank lines, you may use
							<UL>
								<LI>`[B] some text [/B]' to make some text bold.
								<LI>`[A HREF="http://some.site.com/"] some text [/A]' to make some text a link to http://some.site.com/.
								<LI>`[UL] [LI] item number 1 [LI] item number 2 [/UL]' to make a list with 2 items
							</UL>
						</SMALL>
						</CFIF>
						<TEXTAREA NAME="#FieldName#" ROWS="#Rows#" COLS="#Cols#">#HTMLEditFormat(Value)#</TEXTAREA>
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFIF AllowHTML>
						<SMALL>
							<STRONG>Windows Internet Explorer 5+</STRONG> - <A HREF="javascript:htmlEdit('#FieldName#_V')">graphical editor</A> for more formatting options.<BR>
							<STRONG>Other Users</STRONG> - seperate paragraphs with blank lines, you may use
							<UL>
								<LI>`[B] some text [/B]' to make some text bold.
								<LI>`[A HREF="http://some.site.com/"] some text [/A]' to make some text a link to http://some.site.com/.
								<LI>`[UL] [LI] item number 1 [LI] item number 2 [/UL]' to make a list with 2 items
							</UL>
						</SMALL>
						</CFIF>
						<TEXTAREA NAME="#FieldName#_V" ROWS="#Rows#" COLS="#Cols#">#HTMLEditFormat(Value_V)#</TEXTAREA>
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="image">
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">#DisplayName#</SPAN>
						<CFIF Len(Note)><BR><SPAN CLASS="note">#Note#</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="text" NAME="#FieldName#" SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="#ErrorMessage#" 
							REQUIRED="#Required#"   VALUE="#Value#" 
							ONERROR="_PB_onError"/> 
						<CFIF pb_serviceAvailable("imageManager")>
							<CFSAVECONTENT VARIABLE="HTMLHEAD">
								<SCRIPT language="JavaScript" TYPE="text/javascript">
                                <!--
                                	function #FieldName#_saveImage(url) {
										getFormField('#FieldName#').value = url;
									}
                                //-->
                                </SCRIPT>
							</CFSAVECONTENT>
							<CFHTMLHEAD TEXT="#HTMLHEAD#">
							<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imager&ImageURL=' + escape(getFormField('#FieldName#').value) + '&#SESSION.URLToken#', 'imageView', 'width=320,height=240,scrollbars=yes');void(0)"><IMG SRC="images/b-view.gif" BORDER="0" ALT="View Image"></A>
							<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imageManager&RootPath=#URLEncodedFormat(Directory)#&RootURL=#URLEncodedFormat(URL)#&SaveFunction=#FieldName#_saveImage&#SESSION.URLToken#', 'imageManager_#FieldName#', 'width=590,height=320');void(0)"><IMG SRC="images/b-browse.gif" BORDER="0" ALT="Browse/Upload Images"></A>
						   <A HREF="javascript:void(0);" onClick="getFormField('#FieldName#').value = '';void(0)"><IMG SRC="images/b-clear.gif" ALT="Clear Image" BORDER="0"></A>
						</CFIF>
					</TD>
				</TR>
				</CFOUTPUT>
				<CFIF Verify>
				<CFOUTPUT>
				<TR #IIF(ListFind(ATTRIBUTES.errorFields, FieldName & "_V"), DE('CLASS="errorField"'), DE(''))#>
					<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
						<CFIF Required><SPAN CLASS="required">*</SPAN></CFIF>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<SPAN CLASS="displayName">Verify #DisplayName#</SPAN>
					</TD>
					<TD ALIGN="LEFT" VALIGN="TOP">
						<CFINPUT TYPE="text" NAME="#FieldName#_V" SIZE="#Size#" 
							MAXLENGTH="#MaxLength#" MESSAGE="#ErrorMessage#" 
							REQUIRED="#Required#"   VALUE="#Value_V#" 
							ONERROR="_PB_onError"/> 
						<CFIF pb_serviceAvailable("imageManager")>
							<CFSAVECONTENT VARIABLE="HTMLHEAD">
								<SCRIPT language="JavaScript" TYPE="text/javascript">
                                <!--
                                	function #FieldName#_V_saveImage(url) {
										getFormField('#FieldName#_V').value = url;
									}
                                //-->
                                </SCRIPT>
							</CFSAVECONTENT>
							<CFHTMLHEAD TEXT="#HTMLHEAD#">
							<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imager&ImageURL=' + escape(getFormField('#FieldName#_V').value) + '&#SESSION.URLToken#', 'imageView', 'width=320,height=240,scrollbars=yes');void(0)"><IMG SRC="images/b-view.gif" BORDER="0" ALT="View Image"></A>
							<A HREF="javascript:void(0);" onClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imageManager&RootPath=#URLEncodedFormat(Directory)#&RootURL=#URLEncodedFormat(URL)#&SaveFunction=#FieldName#_V_saveImage&#SESSION.URLToken#', 'imageManager_#FieldName#', 'width=590,height=320');void(0)"><IMG SRC="images/b-browse.gif" BORDER="0" ALT="Browse/Upload Images"></A>
						   <A HREF="javascript:void(0);" onClick="getFormField('#FieldName#_V').value = '';void(0)"><IMG SRC="images/b-clear.gif" ALT="Clear Image" BORDER="0"></A>
						</CFIF>
					</TD>
				</TR>
				</CFOUTPUT>
				</CFIF>
			</CFCASE>
			<CFDEFAULTCASE>	
			
				<CFSWITCH EXPRESSION="#FieldName#">
					<CFCASE VALUE="CoPaymentProcessorWddx">
						<CFWDDX ACTION="WDDX2CFML" INPUT="#Value#" OUTPUT="PaymentStruct">
						<CFOUTPUT>
						<TR>
							<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
								<SPAN CLASS="required">*</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">
								<SPAN CLASS="displayName">Payment Processor</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">
								<CF_NOTEBOOK SELECTOR="#FieldName#">
									<CF_TAB TITLE="Manual" 
										SELECTED="#IIF(PaymentStruct.Processor eq 'Manual', DE('Yes'), DE('No'))#" 
										ADDRADIO="1">
										No configuration necessary for manual transactions.
									</CF_TAB>
									<CF_TAB TITLE="DPS" 
										SELECTED="#IIF(PaymentStruct.Processor eq 'DPS', DE('Yes'), DE('No'))#" 
										ADDRADIO="1">
										<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="DPS_configForm" 
												  WDDX="#Value#"/>
									</CF_TAB>
								</CF_NOTEBOOK>
							</TD>
						</TR>
						</CFOUTPUT>
						
					</CFCASE>
					
					<CFCASE VALUE="CoProcessWDDX">
						<CFIF NOT isWDDX(Value)>
							<CFSET ProcessStruct = StructNew()>
						<CFELSE>
							<CFWDDX ACTION="WDDX2CFML" INPUT="#Value#" OUTPUT="ProcessStruct">
						</CFIF>
						<CFPARAM NAME="ProcessStruct.AcceptedURL" DEFAULT="">
						<CFPARAM NAME="ProcessStruct.NotifyURL"   DEFAULT="">
						<CFOUTPUT>
						<INPUT TYPE="HIDDEN" NAME="#FieldName#" VALUE="...">
						<TR>
							<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
								<SPAN CLASS="required">*</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">
								<SPAN CLASS="displayName">Process Details</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">

								<TABLE WIDTH="100%" BORDER="0">
									<TR>
										<TH ALIGN="LEFT">Transaction Accepted URL</TH>
										<TD ALIGN="LEFT">
											<CFINPUT TYPE="TEXT" NAME="AcceptedURL" VALUE="#ProcessStruct.AcceptedURL#" REQUIRED="Yes" MESSAGE="Please enter a URL to transfer accepted transactions to on completion.">
										</TD>
									</TR>
									<TR>
										<TH ALIGN="LEFT">Transaction Accepted Notify URL</TH>
										<TD ALIGN="LEFT">
											<CFINPUT TYPE="TEXT" NAME="NotifyURL" VALUE="#ProcessStruct.NotifyURL#" REQUIRED="No">
										</TD>
									</TR>
								</TABLE>

							</TD>
						</TR>
						</CFOUTPUT>	
					</CFCASE>
					
					<CFCASE VALUE="CoLayoutWDDX">
						<CFIF NOT isWDDX(Value)>
							<CFSET LayoutStruct = StructNew()>
						<CFELSE>
							<CFWDDX ACTION="WDDX2CFML" INPUT="#Value#" OUTPUT="LayoutStruct">
						</CFIF>
						<CFPARAM NAME="LayoutStruct.Layout" DEFAULT="">
						<CFPARAM NAME="LayoutStruct.PaymentTitleImage"   DEFAULT="">
						<CFPARAM NAME="LayoutStruct.AcceptedTitleImage"  DEFAULT="">
						<CFPARAM NAME="LayoutStruct.PaymentButton"       DEFAULT="">
						<CFOUTPUT><INPUT TYPE="HIDDEN" NAME="#FieldName#" VALUE="..."></CFOUTPUT>
						<TR>
							<TD WIDTH="5" ALIGN="CENTER" VALIGN="TOP">
								<SPAN CLASS="required">*</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">
								<SPAN CLASS="displayName">Layout &amp; Graphics</SPAN>
							</TD>
							<TD ALIGN="LEFT" VALIGN="TOP">
							<P>
							<STRONG>Page Title Images</STRONG><BR>
							<TABLE BORDER="0">
								<TR><TH ALIGN="LEFT">Payment Page</TH>
								<TD><CFINPUT TYPE="text" NAME="PaymentTitleImage" SIZE="30" 
									MAXLENGTH="255" 
									REQUIRED="0"   VALUE="#LayoutStruct.PaymentTitleImage#" 
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
									REQUIRED="0"   VALUE="#LayoutStruct.AcceptedTitleImage#" 
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
									REQUIRED="0"   VALUE="#LayoutStruct.PaymentButton#" 
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
							<P>
							<STRONG>Page Layout</STRONG><BR>
							<SMALL>You may enter the HTML for your page layout here, or use the <A HREF="javascript:htmlEdit('Layout')">graphical editor</A>.  Enter the text "{{TitleImage}}" without the quotes in the location you would like the page title image to appear, and the text "{{PageContent}}" in the location you would like the page content (eg the credit card form) to appear.</SMALL>
							<BR>
							<TEXTAREA COLS="40" ROWS="10" NAME="Layout"><CFOUTPUT>#LayoutStruct.Layout#</CFOUTPUT></TEXTAREA>
							</P>
							</TD>
						</TR>
					</CFCASE>
					
				</CFSWITCH>
			
				
			</CFDEFAULTCASE>
		</CFSWITCH>
	</CFLOOP>
	<CFOUTPUT><INPUT TYPE="HIDDEN" NAME="Do_#ATTRIBUTES.FuseAction#" VALUE="ReEdit"></CFOUTPUT>
	
</TABLE>