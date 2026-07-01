<CFSILENT>
	<CFIF isDefined("ATTRIBUTES.Do_Subscribe")>

		<CFTRANSACTION>

		<!--- Check supplied email and password --->
		<CFQUERY NAME="Q_CheckLogin" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT * FROM NewsletterMembers
			WHERE NeMeEmail like '#ATTRIBUTES.Email#'
		</CFQUERY>		

		<CFIF Q_CheckLogin.RecordCount NEQ 0>
		
			<CFSET ATTRIBUTES.EntryErrors = ATTRIBUTES.EntryErrors &
				";The supplied e-mail is already subscribed to the free newsletter.">
			<CFSET ShowUnsubscribe=0>

		<CFELSE>

				<!--- Get new primary key --->
				<CFQUERY NAME="Q_MaxID" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
					SELECT MAX(NeMeID) as MaxID FROM NewsletterMembers
				</CFQUERY>	

				<CFIF Len(Q_MaxID.MaxID)>
					<CFSET MaxID=Evaluate(Q_MaxID.MaxID+1)>
				<CFELSE>
					<CFSET MaxID=1>
				</CFIF>
				
		
				<!--- Add the user to the mailing list --->
				<CFQUERY NAME="Q_DoUnsubscribe" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
					INSERT INTO NewsletterMembers
						(NeMeID, NeMeName, NeMeEmail)
					VALUES
						(#MaxID#, '#ATTRIBUTES.Name#', '#ATTRIBUTES.Email#')
				</CFQUERY>		
				<CFSET ShowSubscribe=0>
				<CFSET ShowUnsubscribe=0>
				<CFSET ShowSuccessfulSubscribe=1>
	
		</CFIF>

		</CFTRANSACTION>	

	<CFELSEIF isDefined("ATTRIBUTES.Do_Unsubscribe")>
	
		<CFTRANSACTION>
		<!--- Check supplied email --->
		<CFQUERY NAME="Q_CheckLogin" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT * FROM NewsletterMembers
			WHERE NeMeEmail like '#ATTRIBUTES.Email#'
		</CFQUERY>		

		<CFIF Q_CheckLogin.RecordCount NEQ 1>
		
			<CFSET ATTRIBUTES.EntryErrors = ATTRIBUTES.EntryErrors &
				";The supplied e-mail address was not subscribed to the free newsletter.">
			<CFSET ShowSubscribe=0>

		<CFELSE>

			<!--- Remove the user from the mailing list --->
			<CFQUERY NAME="Q_DoUnsubscribe" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				DELETE FROM NewsletterMembers
				WHERE NeMeID = #Q_CheckLogin.NeMeID#
			</CFQUERY>		

			<CFSET ShowSubscribe=0>
			<CFSET ShowUnsubscribe=0>
			<CFSET ShowSuccessfulUnsubscribe=1>
							
		</CFIF>

		</CFTRANSACTION>
	
	</CFIF>

</CFSILENT>