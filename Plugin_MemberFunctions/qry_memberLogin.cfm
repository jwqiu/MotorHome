<CFPARAM NAME="ATTRIBUTES.Email" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.Password" DEFAULT="">

<CFIF Len(ATTRIBUTES.Email) AND Len(ATTRIBUTES.Password)>
	<CFQUERY NAME="Q_PasswordCheck" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Members
		WHERE MeEmail like '#ATTRIBUTES.Email#'
			AND MePassword like '#ATTRIBUTES.Password#'
	</CFQUERY>
	
	<!--- Correct login --->
	<CFIF Q_PasswordCheck.RecordCount EQ 1>

		<CFQUERY NAME="Q_Activated" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
			SELECT * FROM Members,Listings
			WHERE MeID = #Q_PasswordCheck.MeID#
				AND MeActivate = 1
				AND MeID = LiMemberLink
				AND LiAuthorised = 1
		<!--- If u need a current listing then after the listing 	
			- expires, a new account would need to be created to add
			- new listings
			-	AND #CreateODBCDate(Now())# <= LiRenewDate
			--->
		</CFQUERY>

		<CFIF Q_Activated.RecordCount GTE 1>
			<CFSET SESSION.SecurityID = Q_PasswordCheck.MeID>
			<CFSET SESSION.SecurityEmail = Q_PasswordCheck.MeEmail>
			<CFSET SESSION.SecurityName = Q_PasswordCheck.MeFormalName>
			<CFSET SESSION.SecurityPassword = Q_PasswordCheck.MePassword>

			<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=Return">
		<CFELSE>

			<CFSET ATTRIBUTES.EntryErrors = ";Your account is not active. You must have current authorised listings to login.">
		
		</CFIF>

	<CFELSE>

		<CFSET ATTRIBUTES.EntryErrors = ";The supplied e-mail or password was incorrect.">
	
	</CFIF>
</CFIF>
