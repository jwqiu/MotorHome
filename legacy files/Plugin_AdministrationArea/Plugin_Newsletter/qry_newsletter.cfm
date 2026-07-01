<CFSILENT>	
	<CFPARAM NAME="ATTRIBUTES.Body" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Subject" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.SendToGeneral" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.SendToLists" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.SendToGroups" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.SendTo" DEFAULT="Both">

	<!--- Find who to send newsletter to --->
	<CFQUERY NAME="Q_FreeMembers" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT DISTINCT NeMeName as Name, NeMeemail as email
		FROM NewsletterMembers
		WHERE (0=1)
			<!--- Free newsletter members --->
			<CFIF (ATTRIBUTES.SendTo EQ "Free") OR (ATTRIBUTES.SendTo EQ "Both")>
				OR (1 = 1)
			</CFIF> 
	</CFQUERY>

	<CFQUERY NAME="Q_PayingMembers" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT DISTINCT MeFormalName as Name, Meemail as email
		FROM Members
		WHERE (0=1)
			<!--- Free newsletter members --->
			<CFIF (ATTRIBUTES.SendTo EQ "Paying") OR (ATTRIBUTES.SendTo EQ "Both")>
				OR ((1 = 1) AND (MeActivate = 1))
			</CFIF> 

	</CFQUERY>

	<CFQUERY NAME="Q_Members" DBTYPE="QUERY">
		SELECT * FROM Q_FreeMembers
		UNION
		SELECT * FROM Q_PayingMembers
	</CFQUERY>
	

<!---
	<!--- Find who to send newsletter to (big kludgy version) --->
	<CFTRANSACTION>
	
		<CFQUERY NAME="Q_FromGeneral" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT MeFirstName, MeLastName, Meemail, MePassword INTO NewsletterRecipientsGeneral
			FROM Members
			WHERE (0=1)
			<CFIF len(ATTRIBUTES.SendToGeneral)>
				OR MemailingList = 1
			</CFIF>
		</CFQUERY>
	
		<!--- Bring in members from selected Mailing Lists --->	
		<CFIF len(ATTRIBUTES.SendToLists)>
			<CFQUERY NAME="Q_FromMailingLists" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				SELECT MeFirstName, MeLastName, Meemail, MePassword 
				INTO NewsletterRecipientsMailingLists
				FROM Members,MemberMailingLists
				WHERE MeMaLiMailingListLink IN (#ATTRIBUTES.SendToLists#)
					AND MeMaLiMemberLink = MeID
			</CFQUERY>
		</CFIF>
		
		<!--- Bring in members from selected Groups --->
		<CFIF len(ATTRIBUTES.SendToGroups)>
			<CFQUERY NAME="Q_FromMemberGroups" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
				SELECT MeFirstName, MeLastName, Meemail, MePassword 
				INTO NewsletterRecipientsMemberGroups
				FROM Members,MemberMemberGroups
				WHERE MeMegrpMemberGroupLink IN (#ATTRIBUTES.SendToGroups#)
					AND MeMegrpMemberLink = MeID
			</CFQUERY>				
		</CFIF>

		<CFQUERY NAME="Q_Members" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT DISTINCT MeFirstName, MeLastName, Meemail, MePassword 
			FROM NewsletterRecipientsGeneral
			<CFIF len(ATTRIBUTES.SendToGroups)>
				UNION
				SELECT DISTINCT MeFirstName, MeLastName, Meemail, MePassword 
				FROM NewsletterRecipientsMemberGroups
			</CFIF>
			<CFIF len(ATTRIBUTES.SendToLists)>
				UNION
				SELECT DISTINCT MeFirstName, MeLastName, Meemail, MePassword 
				FROM NewsletterRecipientsMailingLists
			</CFIF>
		</CFQUERY>

		<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			DROP TABLE NewsletterRecipientsGeneral
		</CFQUERY>

		<CFIF len(ATTRIBUTES.SendToLists)>
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">DROP TABLE NewsletterRecipientsMailingLists</CFQUERY>
		</CFIF>
		
		<CFIF len(ATTRIBUTES.SendToGroups)>
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">DROP TABLE NewsletterRecipientsMemberGroups</CFQUERY>
		</CFIF>

	</CFTRANSACTION>
--->
	
<!---
	<!--- WebNewsletter --->
	<CFIF pb_ServiceAvailable("MailingListsList")>
		<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_MailingLists">
			SELECT * FROM MailingLists
			ORDER BY MaLiName
		</CFQUERY>
	</CFIF>

	<!--- WebMember --->
	<CFIF pb_ServiceAvailable("MemberGroupsList")>
		<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_MemberGroups">
			SELECT * FROM MemberGroups
			ORDER BY MegrpName
		</CFQUERY>
	</CFIF>
--->	

</CFSILENT>