<CFSILENT>
	<!--------------------------------------------------------------------------
		- Back Stack :
		------------------------------------------------------------------------
		- it's often useful to be able to have a URL on hand that will
		- effectivly duplicate the current request.  For example,
		- if a request is made, but the user is required to login, we can 
		- present the login form and when the user has logged in use the 
		- URL we created for the original request to send the user off to 
		- do the request again. 
		----------------------------------------------------------------------->
	<CFLOCK NAME="#REQUEST.PLUGBOX.SESSIONLOCK#" TYPE="EXCLUSIVE" 
	  THROWONTIMEOUT="Yes" TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#">
		<CFPARAM NAME="SESSION.PLUGBOX.BackStack" DEFAULT="#ArrayNew(1)#">
		<CFIF IsDefined("ATTRIBUTES.BackStructure") and Len(ATTRIBUTES.BackStructure)>
			<!--- We need to go "back" to a given request --->
			<CFIF ATTRIBUTES.BackStructure GT ArrayLen(SESSION.PLUGBOX.BackStack)>
				<!--- but the requested attributes do not exist, so just go somewhere sensible --->
				<CFLOCATION URL="#CGI.SCRIPT_NAME#" ADDTOKEN="Yes">
			<CFELSE>
				<!--- Otherwise we append the saved attributes to the attributes structure
					- not permitting any to be overwritten, this allows a URL or FORM
					- supplied attribute to over-ride any in the original request --->
				<CFSET returnVal = StructAppend(ATTRIBUTES, SESSION.PLUGBOX.BackStack[ATTRIBUTES.BackStructure], "No")>
				<!--- Pop this backstructure and all above off the stack --->
				<CFLOOP CONDITION="ArrayLen(SESSION.PLUGBOX.BackStack) GTE ATTRIBUTES.BackStructure">
					<CFSET x = ArrayDeleteAt(SESSION.PLUGBOX.BackStack, ATTRIBUTES.BackStructure)>
				</CFLOOP>
				<!--- Clean Up --->
				<CFSET x = StructDelete(ATTRIBUTES, "BackStructure")>
			</CFIF>
		</CFIF>
		
		<!--- Now save the current attributes structure into the back stack --->
		<CFSCRIPT>
			Temp = Duplicate(ATTRIBUTES);
			StructDelete(Temp, "CFID", "No");	// Delete ID & TOKEN, these could screw stuff up
			StructDelete(Temp, "CFTOKEN", "No");
			SESSION.PLUGBOX.BackStack[ArrayLen(SESSION.PLUGBOX.BackStack) + 1] = Temp;
			REQUEST.Back = "#CGI.SCRIPT_NAME#?BackStructure=#ArrayLen(SESSION.PLUGBOX.BackStack)#";
		</CFSCRIPT>
	</CFLOCK>
	
</CFSILENT>