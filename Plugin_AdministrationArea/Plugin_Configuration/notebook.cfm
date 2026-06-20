	<CFPARAM NAME="REQUEST.noteBookOpened"      DEFAULT="0">
	<CFPARAM NAME="ATTRIBUTES.NoteBook"         DEFAULT="NB#REQUEST.noteBookOpened#">
	<CFPARAM NAME="ATTRIBUTES.Selector"         DEFAULT="NBR#REQUEST.noteBookOpened#">
	<CFPARAM NAME="ATTRIBUTES.Class"            DEFAULT="noteBook">
	<CFPARAM NAME="ATTRIBUTES.Width"            DEFAULT="100%">
	<CFPARAM NAME="ATTRIBUTES.CellPadding"      DEFAULT="2">
	<CFPARAM NAME="ATTRIBUTES.CellSpacing"      DEFAULT="0">
	<CFPARAM NAME="ATTRIBUTES.activeTabClass"   DEFAULT="activeTab">
	<CFPARAM NAME="ATTRIBUTES.inactiveTabClass" DEFAULT="inactiveTab">
	<CFPARAM NAME="ATTRIBUTES.spacerTabClass"    DEFAULT="spacerTab">
	<CFPARAM NAME="ATTRIBUTES.bodyClass"        DEFAULT="noteBookBody">
	<CFIF NOT thisTag.hasendtag>
		<CFTHROW TYPE="CUSTTAG" MESSAGE="OI GIMME AN END TAG !">
	</CFIF>
	
	<CFIF thisTag.executionMode eq "start">
		<CFIF NOT REQUEST.noteBookOpened>
			<!--- Output the common stuff we need in the header --->
			<CFSAVECONTENT VARIABLE="headContent">
				<STYLE TYPE="TEXT/CSS">
					td.activeTab {
						font-family: Verdana, Arial, Helvetica, sans-serif;
						color: #000000;
						background-color: #CCCCCC;
						border-top-width: 1px;
						border-right-width: 1px;
						border-bottom-width: 1px;
						border-left-width: 1px;
						border-top-style: solid;
						border-right-style: none;
						border-bottom-style: none;
						border-left-style: solid;
						border-top-color: #000000;
						border-right-color: #000000;
						border-bottom-color: #000000;
						border-left-color: #000000;
					}
					
					td.inactiveTab {
						font-family: Verdana, Arial, Helvetica, sans-serif;
						color: #000000;
						background-color: #999999;
						border-top: 1px solid #000000;
						border-right: 1px none #000000;
						border-bottom: 1px solid #000000;
						border-left: 1px solid #000000;
					}
					
					td.noteBookBody {
						border-top-width: 1px;
						border-right-width: 1px;
						border-bottom-width: 1px;
						border-left-width: 1px;
						border-top-style: none;
						border-right-style: solid;
						border-bottom-style: solid;
						border-left-style: solid;
						border-top-color: #000000;
						border-right-color: #000000;
						border-bottom-color: #000000;
						border-left-color: #000000;
						background-color: #CCCCCC;
					}
					
					td.spacerTab {
						border-top-width: 1px;
						border-right-width: 1px;
						border-bottom-width: 1px;
						border-left-width: 1px;
						border-top-style: none;
						border-right-style: none;
						border-bottom-style: solid;
						border-left-style: solid;
						border-top-color: #000000;
						border-right-color: #000000;
						border-bottom-color: #000000;
						border-left-color: #000000;
					}
				</STYLE>
				<SCRIPT>
					<!--
					 function noteBook(
							name, tableClass, 
							tableWidth, tablePadding, tableSpacing, 
							activeTabClass, inactiveTabClass, spacerTabClass, bodyTabClass
						) {
							this.name = name;
							this.activeTabClass = activeTabClass;
							this.inactiveTabClass = inactiveTabClass;
							this.spacerTabClass = spacerTabClass;
							this.bodyTabClass = bodyTabClass;
							this.tableClass = tableClass;
							this.tableWidth = tableWidth;
							this.tablePadding = tablePadding;
							this.tableSpacing = tableSpacing;
										
							this.tabs = [];
							this.activeTab = null;
							
							this.addTab = addTab;
							this.writeNoteBook = writeNoteBook;
										
						}
						
						function addTab(title, content) {
							var tabName = this.name + "_tab_" + this.tabs.length;
							this.tabs[this.tabs.length] = new Object();
							this.tabs[this.tabs.length - 1].name = tabName;
							this.tabs[this.tabs.length - 1].noteBook = this;
							this.tabs[this.tabs.length - 1].title = title;
							this.tabs[this.tabs.length - 1].content = content;
							this.tabs[this.tabs.length - 1].show    = showTab;
						}
						
						function showTab() {							
							if (this.noteBook.activeTab) {
								document.getElementById(this.noteBook.activeTab).className = this.noteBook.inactiveTabClass;
							} 
							document.getElementById(this.name).className = this.noteBook.activeTabClass;
							document.getElementById(this.noteBook.name).innerHTML = this.content;
							this.noteBook.activeTab = this.name;
						}
						
						function writeNoteBook() {
							document.write('<TABLE CLASS="' + this.tableClass + '" WIDTH="' + this.tableWidth + '" CELLPADDING="' + this.tablePadding + '" CELLSPACING="' + this.tableSpacing + '">');
							document.write('<TR>');
							for (x = 0; x < this.tabs.length; x++) {
							 document.write('<TD CLASS="' + this.inactiveTabClass + '" ID="' + this.tabs[x].name + '" OnClick="' + this.name + '.tabs[' + x + '].show()">' + this.tabs[x].title + '</TD>');
							}
							document.write('<TD CLASS="' + this.spacerTabClass + '" >&nbsp;</TD></TR><TR><TD ID="' + this.name + '" class="' + this.bodyTabClass + '" COLSPAN="' + (this.tabs.length + 1) + '"></TD></TR></TABLE>');
						}	
					//-->
				</SCRIPT>
				 
				<SCRIPT language="JavaScript">
					<!--
					/* SafeWindowOnload from javascript.com, allows easy use of multiple onloads... */
					
					// Browser Detection
					isMac = (navigator.appVersion.indexOf("Mac")!=-1) ? true : false;
					NS4 = (document.layers) ? true : false;
					IEmac = ((document.all)&&(isMac)) ? true : false;
					IE4plus = (document.all) ? true : false;
					IE4 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 4.")!=-1)) ? true : false;
					IE5 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 5.")!=-1)) ? true : false;
					ver4 = (NS4 || IE4plus) ? true : false;
					NS6 = (!document.layers) && (navigator.userAgent.indexOf('Netscape')!=-1)?true:false;
					
					// Body onload utility (supports multiple onload functions)
					var gSafeOnload = new Array();
					function SafeAddOnload(f)
					{
						if (IEmac && IE4)  // IE 4.5 blows out on testing window.onload
						{
							window.onload = SafeOnload;
							gSafeOnload[gSafeOnload.length] = f;
						}
						else if  (window.onload)
						{
							if (window.onload != SafeOnload)
							{
								gSafeOnload[0] = window.onload;
								window.onload = SafeOnload;
							}		
							gSafeOnload[gSafeOnload.length] = f;
						}
						else
							window.onload = f;
					}
					function SafeOnload()
					{
						for (var i=0;i<gSafeOnload.length;i++)
							gSafeOnload[i]();
					}
					
					// Call the following with your function as the argument
					// SafeAddOnload(yourfunctioname);
					//-->
				</SCRIPT>
			</CFSAVECONTENT>
			<CFHTMLHEAD TEXT="#headContent#">
		</CFIF>
		<CFSET REQUEST.noteBookOpened = REQUEST.noteBookOpened + 1>
		<CFELSE>
			<!--- Take the "tabs" we were given and built a notebook from them --->
			<CFSET thisTag.generatedContent = "">
			<CFSET selectedTab = 0>
				<CFOUTPUT>
					<SCRIPT language="Javascript">
					<!--
						// Make a new noteBook widget
						#ATTRIBUTES.NoteBook# = new noteBook('#ATTRIBUTES.NoteBook#', '#ATTRIBUTES.CLASS#', '#ATTRIBUTES.Width#', '#ATTRIBUTES.CellPadding#', '#ATTRIBUTES.CellSpacing#', '#ATTRIBUTES.ActiveTabClass#', '#ATTRIBUTES.inactiveTabClass#', '#ATTRIBUTES.spacerTabClass#', '#ATTRIBUTES.bodyClass#');
						
						// Add some tabs to it
						<CFLOOP INDEX="i" FROM="1" TO=#arrayLen(thisTag.tabs)#>
							<CFIF thisTag.tabs[i].selected>
								<CFSET SelectedTab = i - 1>
							</CFIF>
							#ATTRIBUTES.NoteBook#.addTab('#JsStringFormat(thisTag.tabs[i].title)#', '#JsStringFormat(thisTag.tabs[i].content)#');
						</CFLOOP>
						
						// Write it out to the document
						#ATTRIBUTES.NoteBook#.writeNoteBook();
						
						// Make a function to initialize it to the correct page
						function #ATTRIBUTES.NoteBook#_init() {
							#ATTRIBUTES.NoteBook#.tabs[#SelectedTab#].show();
						}
						
						// Add that function to the onload event.
						SafeAddOnload(#ATTRIBUTES.NoteBook#_init);
					//-->
					</SCRIPT>
				</CFOUTPUT>
	</CFIF>
