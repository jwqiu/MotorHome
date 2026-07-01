<CFSILENT>
	<!--------------------------------------------------------------------------
		- Hijacker Check
		------------------------------------------------------------------------
		- Make sure that the session is valid, that is, if the user comes to a
		- a page, say from a bookmark, and includes CFID & CFTOKEN then they
		- could be hijacking somebodies session.  So we tag each session with a 
		- "sessionTag", the same value is stored in a cookie that never expires
		- if the users (requested) session contains a different sessiontag than 
		- thier cookie we clear thier cfid & cftoken to give them a new session
		- if they don't have a cookie session tag we given them one and a new
		- session.
		- Note that we only check when the user has requested a specific session
		- through CFID &/or CFTOKEN, if they don't they can't hijack a session
		- (except maybe manually setting cookies, but that's unlikely).
		-
		- Hijacking would highly likely to be unintentional and so no 
		- notificaton is sent.
		-
		- Before we do anything though we will make sure they at least have a 
		- session tag 
		----------------------------------------------------------------------->
	<CFIF NOT IsDefined("COOKIE.SessionTag")>
		<CFCOOKIE NAME="SessionTag" VALUE="#CreateUUID()#" EXPIRES="NEVER">
	</CFIF>
	
	<CFSET ClearCookies = 0>
	<CFIF IsDefined("ATTRIBUTES.CFID") or IsDefined("ATTRIBUTES.CFTOKEN")>
		<CFLOCK NAME="#REQUEST.PLUGBOX.SESSIONLOCK#" TYPE="EXCLUSIVE" 
		  TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#" THROWONTIMEOUT="YES">
			<CFIF IsDefined("SESSION.PLUGBOX.SessionTag") AND (COOKIE.SessionTag neq SESSION.PLUGBOX.SessionTag)>
				<CFSET ClearCookies = 1>
			<CFELSE>
				<CFSET SESSION.PLUGBOX.SessionTag = COOKIE.SessionTag>
			</CFIF>
		</CFLOCK>
	</CFIF>
	
	<!--- We have to drop out of silent mode now because we may need to write out 
		- a dummy page to the browser.
		--->
</CFSILENT>	
<CFIF ClearCookies>
	<!--- Remove the cftoken and cfid from cookies --->
	<CFIF IsDefined("Cookie.CFTOKEN") OR IsDefined("Cookie.CFID")>
	    <CFCOOKIE NAME="CFTOKEN" EXPIRES="NOW">
	    <CFCOOKIE NAME="CFID" EXPIRES="NOW">
	</CFIF>
	
	<!--- output the redirection page --->
	<CFOUTPUT>
	<HTML>
		<HEAD>
			<TITLE>Cookies</TITLE>
			<LINK REL="STYLESHEET" TYPE="text/css" HREF="styles.css">
		</HEAD>
		<BODY onLoad="document.forms.CookieCutter.submit()">
			<STRONG>One moment...</STRONG>	<BR>
			<P>
			Our web site has detected an incorrect cookie in your web browser.  
			So that your browsing experience on our web site is trouble free 
			we are fixing this for you right now.
			</P>
			<P>
			<SCRIPT language="JavaScript" TYPE="text/javascript">
               <!--
               	document.write("The page you requested will appear shortly.");
               //-->
            </SCRIPT>
			<FORM NAME="CookieCutter" ACTION="#CGI.SCRIPT_NAME#" METHOD="POST">
				<CFLOOP LIST="#StructKeyList(ATTRIBUTES)#" INDEX="AttKey">
					<CFIF AttKey neq "CFID"	AND AttKey neq "CFTOKEN">
						<INPUT TYPE="HIDDEN" NAME="#AttKey#" VALUE="#HTMLEditFormat(Attributes[Attkey])#">
					</CFIF>
				</CFLOOP>
				<NOSCRIPT>
					Your cookies have been repaired, and you may now 
						<INPUT TYPE="SUBMIT" NAME="PlugboxCookieCutter" VALUE="continue"> 
					into our web site, thank you for your patience.
				</NOSCRIPT>
			</FORM>
			</P>
		</BODY>
		
		</HTML>
		</CFOUTPUT>
	<CFABORT>
</CFIF>