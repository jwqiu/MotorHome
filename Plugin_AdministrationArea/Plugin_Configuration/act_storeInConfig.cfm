<CFSILENT>
	<!--- 
		- Take a key, and a value (which can be any CF structure/query/array/simple value)
		- the key should be in dot notation, eg Layouts.whojimme
		---->
	<CFPARAM NAME="ATTRIBUTES.Key"  >
	<CFPARAM NAME="ATTRIBUTES.Value">

	<!--- Make sure at least two keys are given --->
	<CFIF NOT ListLen(ATTRIBUTES.Key, ".") gte 2>
		<CFTHROW DETAIL="To store a field in configuration table you must provide a minimum of 2 keys." TYPE="storeField">
	</CFIF>
	
	<!--- First grab first section of key --->
	<CFSET FieldName = "Co" & ListFirst(ATTRIBUTES.Key, ".") & "WDDX">
	
	<!--- Find out if the column is defined in the DB --->
	<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_ConfigTable">
		SELECT * FROM Configuration
		WHERE CoID = 1
	</CFQUERY>
	
	<CFIF NOT ListFindNoCase(Q_ConfigTable.ColumnList, FieldName)>
		<!--- The field does not exist --->
		<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_AddField">
			ALTER TABLE Configuration
			ADD #FieldName# TEXT
		</CFQUERY>
		<CFSET TopStruct = StructNew()>
	<CFELSE>
		<!--- the field exists retrieve existing values --->
		<CFIF IsWDDX(Q_ConfigTable[FieldName][1])>
			<CFWDDX ACTION="WDDX2CFML" INPUT="#Q_ConfigTable[FieldName][1]#" OUTPUT="TopStruct">
		<CFELSE>
			<CFSET TopStruct = StructNew()>
		</CFIF>
	</CFIF>
	
	<!--- Ok, now work our way up through the key making sure we have structs for everything --->
	<CFSET Follower = TopStruct>
	<CFSET Count = 1>
	<CFLOOP LIST="#ListRest(ATTRIBUTES.Key, '.')#" INDEX="ComponentKey" DELIMITERS=".">
		<CFIF Count LT (ListLen(ATTRIBUTES.Key, '.') - 1)>
			<CFIF NOT StructKeyExists(Follower, UCase(ComponentKey))>
				<CFSET Follower[ComponentKey] = StructNew()>
			</CFIF>
			<CFSET Follower = Follower[ComponentKey]>
				
		<CFELSE>
			
			<CFSET Follower[ComponentKey] = ATTRIBUTES.Value>
		</CFIF>
		<CFSET Count = Count + 1>
	</CFLOOP>
				
	<!--- Now WDDX the structure --->
	<CFWDDX INPUT=#TopStruct# OUTPUT="TopStructWDDX" ACTION="CFML2WDDX">
	
	<!--- Put it into the config table --->
	<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_UpdValue">
		UPDATE Configuration
		SET #FieldName# = '#TopStructWDDX#';
	</CFQUERY>
	
	<!--- Done, remember to do a force CFG reload ! --->

</CFSILENT>