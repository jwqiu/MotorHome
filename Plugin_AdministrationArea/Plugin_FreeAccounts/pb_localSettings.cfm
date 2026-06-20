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
	<CFSET Local.CFG.PlPlural          = "Free Accounts">
	<CFSET Local.CFG.PlSingular        = "Free Accounts">
	<CFSET Local.CFG.PlTableName       = "FreeAccounts">
	<CFSET Local.CFG.PlTablePrimaryKey = "FrAcID">
	<CFSET Local.CFG.PlTableOrderBy    = "">
	<CFSET Local.CFG.PlDisplayFields   = "FrAcID">
	
	<!--- 
		- Parent Table, each plugin may be a direct child of ONE "parent" table
		- eg Category -> Product Relationship, in Plugin_Product, Category is the
		- parent, CaID is PK and PrCategoryLink is LinkField 
	  --->  
	<CFSET Local.CFG.ParentTable           = StructNew()>
	<CFSET Local.CFG.ParentTable.Name      = "">
	<CFSET Local.CFG.ParentTable.PKField   = "">
	<CFSET Local.CFG.ParentTable.LinkField = "">
	
	<CF_FIELDSET FieldSetName="Caller.Local.CFG.Fields">
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
			FieldName  ="FrAcAmount"
			DisplayName="Free Accounts Left"
			Note       =""
			Message    ="Please enter the number of free accounts left."
			Type       ="integer"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="10"  MaxLength  ="11"
	/>
	</CF_FIELDSET>

	
	<CF_CHILDREN Children="Caller.Local.CFG.ChildPlugins">
		<!--- <CF_CHILD ChildName = "AdminBase"
				  Plural    = "Base"
				  Singular  = "Base"
				  TableName = "Test"
				  PKField   = "TeID"
				  LinkField = "TeParentLink"
		/> --->
	</CF_CHILDREN>

</CFSILENT>