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
	<CFSET Local.CFG.PlPlural          = "Transactions">
	<CFSET Local.CFG.PlSingular        = "Transaction">
	<CFSET Local.CFG.PlTableName       = "Transactions">
	<CFSET Local.CFG.PlTablePrimaryKey = "TrID">
	<CFSET Local.CFG.PlTableOrderBy    = "TrDateTime">
	<CFSET Local.CFG.PlDisplayFields   = "TrDateTime,TrReference,TrTotal">
	
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
			FIELDNAME  ="TrReference"
			DISPLAYNAME="Reference Code"
			NOTE       =""
			MESSAGE    =""
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
		
	
	</CF_FIELDSET>
	
	<CF_CHILDREN CHILDREN="Caller.Local.CFG.ChildPlugins">
		
	</CF_CHILDREN>

</CFSILENT>