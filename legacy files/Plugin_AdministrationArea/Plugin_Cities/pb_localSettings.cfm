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
	<CFSET Local.CFG.PlPlural          = "Cities">
	<CFSET Local.CFG.PlSingular        = "City">
	<CFSET Local.CFG.PlTableName       = "Cities">
	<CFSET Local.CFG.PlTablePrimaryKey = "CiID">
	<CFSET Local.CFG.PlTableOrderBy    = "CiName">
	<CFSET Local.CFG.PlDisplayFields   = "CiName">
	
	<!--- 
		- Parent Table, each plugin may be a direct child of ONE "parent" table
		- eg Category -> Product Relationship, in Plugin_Product, Category is the
		- parent, CaID is PK and PrCategoryLink is LinkField 
	  --->  
	<CFSET Local.CFG.ParentTable           = StructNew()>
	<CFSET Local.CFG.ParentTable.Name      = "States">
	<CFSET Local.CFG.ParentTable.PKField   = "StID">
	<CFSET Local.CFG.ParentTable.LinkField = "CiStateLink">
	
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
			FieldName  ="CiName"
			DisplayName="City Name"
			Note       =""
			Message    ="Please enter the city's name."
			Type       ="text"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="127"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	
	</CF_FIELDSET>
	
	<CF_CHILDREN Children="Caller.Local.CFG.ChildPlugins">
<!---		 <CF_CHILD ChildName = "States"
				  Plural    = "States"
				  Singular  = "State"
				  TableName = "States"
				  PKField   = "StID"
				  LinkField = "StCountryLink"
		/> --->
	</CF_CHILDREN>

</CFSILENT>