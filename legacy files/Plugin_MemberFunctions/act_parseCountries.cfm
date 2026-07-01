<CFOUTPUT>
#CFG.Toplevel#
</CFOUTPUT>
This action is disabled
<!---
Dont want to run this again by mistake :)
<CFFILE ACTION="READ" FILE="#ExpandPath('countries.txt')#" VARIABLE="theFile">

<CFSET theFile = ReplaceNoCase(theFile,"country","@","ALL")>
<CFSET theFile = Replace(theFile,Chr(13)&Chr(10)&Chr(13)&Chr(10),"~","ALL")>

<CFQUERY NAME="Q_Delete" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	DELETE FROM Cities
</CFQUERY>
<CFQUERY NAME="Q_Delete" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	DELETE FROM States
</CFQUERY>
<CFQUERY NAME="Q_Delete" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
	DELETE FROM Countries
</CFQUERY>

<CFSET CurrentCountry=0>
<CFSET CurrentState=0>
<CFSET CurrentCity=0>
<CFOUTPUT>
	<CFLOOP LIST=#theFile# DELIMITERS="@" INDEX="country">
		<UL>
		<CFSET thisCountry = ListFirst(country,"~#Chr(13)##Chr(10)#")>
		<CFSET country = ListRest(country,"~#Chr(13)##Chr(10)#")>
		<b>#thisCountry#</b>
		<CFSET CurrentCountry=CurrentCountry+1>
		<CFQUERY NAME="Q_InsertCountry" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			INSERT INTO Countries
				(CntID, CntName)
			VALUES
				(#CurrentCountry#, '#Trim(thisCountry)#')
		</CFQUERY>
		
		
		<CFLOOP LIST=#country# DELIMITERS="~" INDEX="state">

			<UL>
				<CFSET thisState = ListFirst(state,"#Chr(13)##Chr(10)#")>
				<CFIF ListLen(state,"#Chr(13)##Chr(10)#") NEQ 0>
				<CFSET state = ListRest(state,"#Chr(13)##Chr(10)#")>
				<CFIF Len(Trim(thisState))>
				<i>#Trim(thisState)#</i><BR>
				<CFSET CurrentState=CurrentState+1>
				<CFQUERY NAME="Q_InsertState" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
					INSERT INTO States
						(StID, StName, StCountryLink)
					VALUES
						(#CurrentState#, '#Trim(thisState)#', #CurrentCountry#)
				</CFQUERY>
				
				<UL>
				<CFLOOP LIST=#state# DELIMITERS="#Chr(13)##Chr(10)#" INDEX="city">
					<CFIF Len(Trim(City))>
					#Trim(City)#<BR>
					<CFSET CurrentCity=CurrentCity+1>
					<CFQUERY NAME="Q_InsertCity" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
						INSERT INTO Cities
							(CiID, CiName, CiStateLink)
						VALUES
							(#CurrentCity#, '#Trim(City)#', #CurrentState#)
					</CFQUERY>

					</CFIF>
				</CFLOOP>				
				</UL>
				</CFIF>
				</CFIF>
			
			</UL>		
		
		</CFLOOP>
		</UL>
	</CFLOOP>

</CFOUTPUT>
--->