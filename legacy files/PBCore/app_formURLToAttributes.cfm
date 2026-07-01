<CFSILENT>
	<!--------------------------------------------------------------------------
		- formURLToAttributes
		------------------------------------------------------------------------
		- This file appends the FORM and URL scopes to the ATTRIBUTES scope
		- 
		- Originally in the fusebox standard this was a big hefty custom tag
		- but fusebox 3 reduced it to a couple of lines.  I have done the same
		- here, with the slight addition of Trim()ing the attributes, this is 
		- necessary to provide easy interfacing with Macintosh Internet Explorer
		- users, because IE sends a Carrige Return on the end of every form 
		- field (Microsoft, what were you thinking).
		----------------------------------------------------------------------->

		<CFPARAM NAME="ATTRIBUTES" DEFAULT="#StructNew()#">
		<CFPARAM NAME="URL" 	   DEFAULT="#StructNew()#">
		<CFPARAM NAME="FORM"       DEFAULT="#StructNew()#">
		<CFSET returnVal = StructAppend(ATTRIBUTES, URL, "No")>
		<CFSET returnVal = StructAppend(ATTRIBUTES, FORM, "No")>
		
		<CFLOOP LIST="#StructKeyList(ATTRIBUTES)#" INDEX="Key">
			<CFSET ATTRIBUTES[Key] = Trim(Attributes[Key])>
		</CFLOOP>
</CFSILENT>