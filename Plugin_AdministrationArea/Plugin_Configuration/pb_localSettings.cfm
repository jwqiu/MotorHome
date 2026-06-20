<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Local Settings
    	------------------------------------------------------------------------
    	- If you want to add anything to the CFG structure, or make any
		- other local settings that apply to this directory only
		- (settings here do not filter down to children)
		- this is the place to do it.
		-
		- Anything you define in Local.CFG structure will be made available 
		- in the CFG scope.
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
	<CFSET Local.CFG.PlPlural          = "Configurations">
	<CFSET Local.CFG.PlSingular        = "Configuration">
	<CFSET Local.CFG.PlTableName       = "Configuration">
	<CFSET Local.CFG.PlTablePrimaryKey = "CoID">
	<CFSET Local.CFG.PlTableOrderBy    = "CoWebSiteName">
	<CFSET Local.CFG.PlDisplayFields   = "CoWebSiteName">
	
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
			FIELDNAME  ="CoWebSiteName"
			DISPLAYNAME="Web Site Name"
			NOTE       =""
			MESSAGE    ="Please enter the name of your web site."
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
			FIELDNAME  ="CoEmailAddress"
			DISPLAYNAME="Email Address"
			NOTE       =""
			MESSAGE    ="Please enter your primary email address."
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
	
<!---	
	<CF_FIELD 	
			FIELDNAME  ="CoBCCAddress"
			DISPLAYNAME="BCC Email Address"
			NOTE       ="Emails will be silently copied to this address."
			MESSAGE    =""
			TYPE       ="text"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="255"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>
--->	

	<CF_FIELD 	
		FIELDNAME  ="CoKeywords"
		DISPLAYNAME="Keywords"
		NOTE       ="Keywords are displayed in a hidden area of all web pages. They are used by search engines."
		MESSAGE    =""
		TYPE       ="memo"
		REQUIRED   ="false"
		ALLOWHTML  ="false"
		ROWS       ="5"  COLS       ="45"	
	/>
	
	
	<CF_FIELD 	
		FIELDNAME  ="CoDescription"
		DISPLAYNAME="Description"
		NOTE       ="The description is displayed in a hidden area of all web pages. It is used by search engines."
		MESSAGE    =""
		TYPE       ="memo"
		REQUIRED   ="false"
		ALLOWHTML  ="false"
		ROWS       ="5"  COLS       ="45"	
	/>
	
	
	<CF_FIELD 	
		FIELDNAME  ="CoContactDetails"
		DISPLAYNAME="Contact Information"
		NOTE       =""
		MESSAGE    =""
		TYPE       ="memo"
		REQUIRED   ="true"
		ALLOWHTML  ="false"
		ROWS       ="10"  COLS       ="45"	
	/>
		
	<CF_FIELD 	
			FIELDNAME  ="CoAdminUsername"
			DISPLAYNAME="Admin Username"
			NOTE       =""
			MESSAGE    ="Please choose a username."
			TYPE       ="text"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="true"
			SIZE       ="10"  MAXLENGTH  ="25"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>
	
	<CF_FIELD 	
			FIELDNAME  ="CoAdminPassword"
			DISPLAYNAME="Admin Password"
			NOTE       =""
			MESSAGE    ="Please choose a password."
			TYPE       ="password"
			REQUIRED   ="true"
			ALLOWHTML  ="false"
			VERIFY     ="true"
			UNIQUE     ="true"
			SIZE       ="10"  MAXLENGTH  ="25"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
	/>
	
	</CF_FIELDSET>
	
	<CF_CHILDREN CHILDREN="Caller.Local.CFG.ChildPlugins">
		
	</CF_CHILDREN>

</CFSILENT>