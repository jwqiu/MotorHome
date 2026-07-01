<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Local Settings
    	------------------------------------------------------------------------
    	- If you want to add anything to the CFG structure, or make any
		- other local settings that apply to this directory only
		- (settings here do not filter down to children)
		- this is the place to do it.
		-
		- The PlugBox spec defines some local settings for you...
		- CFG.OurDirectory    : 
		-		absolute path to the current directory
		- CFG.RelativeAppRoot :
		-		relative path to the root application directory 
		-		(where Application.cfm lives)
		- CFG.RelativeWebRoot :
		-		relative path to the root web directory 
		-		(where the initial fusebox.cfm/index.cfm file you requested lives)
		- CFG.CustomTags      :
		-		relative path to the directory _Tags in the root application 
		-		directory (use it for referencing custom tags !)
    	----------------------------------------------------------------------->
		
	<!--- <CFSET Local.CFG.Example = "An Example !"> --->
	<CFSET Local.CFG.PlName            = ListLast(ListLast(ReReplace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\\|/$", ""), "\/"),"_")>
	<CFSET Local.CFG.PlPlural          = "Members">
	<CFSET Local.CFG.PlSingular        = "Member">
	<CFSET Local.CFG.PlTableName       = "Members">
	<CFSET Local.CFG.PlTablePrimaryKey = "MeID">
	<CFSET Local.CFG.PlTableOrderBy    = "MeFormalName">
	<CFSET Local.CFG.PlDisplayFields   = "MeFormalName">
	
	<!--- 
		- Parent Table, each plugin may be a direct child of ONE "parent" table
		- eg Category -> Product Relationship, in Plugin_Product, Category is the
		- parent, CaID is PK and PrCategoryLink is LinkField 
	  --->  
	<CFSET Local.CFG.ParentTable           = StructNew()>
	<CFSET Local.CFG.ParentTable.Name      = "">
	<CFSET Local.CFG.ParentTable.PKField   = "">
	<CFSET Local.CFG.ParentTable.LinkField = "">
	
	<CF_FIELDSET FIELDSETNAME="Caller.Local.CFG.Fields">
	<!---
	<CF_FIELD	FieldName  ="Name In Database"
				DisplayName="Name To Display"
				Note       ="A note about the field."
				Type       ="text"/"password"/"date"/"checkbox"/"integer"/"float"/"money"/"percent"/"lookup"/"memo"/...
				Required   ="Yes"/"No"
				AllowHTML  ="Yes"/"No"
				Verify     ="Yes"/"No"
				Unique     ="Yes"/"No"
				Message    ="An error message."
				Size       = displayed size of field 
				MaxLength  = maximum length for data
				Rows       = rows for textareas
				Cols       = cols for textareas
				LinkQueryFuseaction = fuseaction to get query for lookup
				LinkQueryValue      = value field for lookup
				LinkQueryDisplay    = display field for lookup
	/>
	--->
	
	<CF_FIELD 	
			FIELDNAME  ="MeInformalName"
			DISPLAYNAME="Informal Name"
			NOTE       =""
			MESSAGE    ="Please enter the member's informal name."
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>
	
	<CF_FIELD 	
			FIELDNAME  ="MeFormalName"
			DISPLAYNAME="Formal Name"
			NOTE       =""
			MESSAGE    ="Please enter the member's formal name."
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeAddress"
			DISPLAYNAME="Address"
			NOTE       =""
			MESSAGE    ="Please enter the member's address"
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeCountryLink"
			DISPLAYNAME="Country"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="lookup"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION ="CountriesQuery"
			LINKQUERYVALUE      ="CntID"
			LINKQUERYDISPLAY    ="CntName"
	/> 

	<CF_FIELD 	
			FIELDNAME  ="MeStateLink"
			DISPLAYNAME="State"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="lookup"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION ="StatesQuery"
			LINKQUERYVALUE      ="StID"
			LINKQUERYDISPLAY    ="StName"
	/> 

	<CF_FIELD 	
			FIELDNAME  ="MeCityLink"
			DISPLAYNAME="City"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="lookup"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION ="CitiesQuery"
			LINKQUERYVALUE      ="CiID"
			LINKQUERYDISPLAY    ="CiName"
	/> 
	
	<CF_FIELD 	
			FIELDNAME  ="MeZipCode"
			DISPLAYNAME="Zip/Postal Code"
			NOTE       =""
			MESSAGE    ="Please enter the member's zip code"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeAirport"
			DISPLAYNAME="Nearest Airport"
			NOTE       =""
			MESSAGE    ="Please enter the member's nearest airport"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeWorkPhone"
			DISPLAYNAME="Work Phone"
			NOTE       =""
			MESSAGE    ="Please enter the member's work phone"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="20"  MAXLENGTH  ="25"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeHomePhone"
			DISPLAYNAME="Home Phone"
			NOTE       =""
			MESSAGE    ="Please enter the member's home phone"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="20"  MAXLENGTH  ="25"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeFax"
			DISPLAYNAME="Fax"
			NOTE       =""
			MESSAGE    ="Please enter the member's fax number"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="20"  MAXLENGTH  ="25"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeEmail"
			DISPLAYNAME="Email"
			NOTE       =""
			MESSAGE    ="Please enter the member's e-mail address"
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="true"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MePassword"
			DISPLAYNAME="Password"
			NOTE       =""
			MESSAGE    ="Please enter the member's password"
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="true"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="10"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeHeardFrom"
			DISPLAYNAME="Heard From"
			NOTE       =""
			MESSAGE    ="Please enter the where the member heard about MotorhomeExchange-Sell.com"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeHeardField"
			DISPLAYNAME="Heard From Details"
			NOTE       =""
			MESSAGE    ="Please enter the details of where the member heard about MotorhomeExchange-Sell.com"
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>

	<CF_FIELD 	
			FIELDNAME  ="MeActivate"
			DISPLAYNAME="Activate Account"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="checkbox"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>


	
	
	</CF_FIELDSET>
	
	<CF_CHILDREN CHILDREN="Caller.Local.CFG.ChildPlugins">
		<!--- <CF_CHILD ChildName = "AdminBase"
				  Plural    = "Base"
				  Singular  = "Base"
				  TableName = "Test"
				  PKField   = "TeID"
				  LinkField = "TeParentLink"
		/> --->
	</CF_CHILDREN>

	
</CFSILENT>