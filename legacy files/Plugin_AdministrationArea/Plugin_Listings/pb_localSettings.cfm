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
	<CFSET Local.CFG.PlPlural          = "Listings">
	<CFSET Local.CFG.PlSingular        = "Listing">
	<CFSET Local.CFG.PlTableName       = "Listings">
	<CFSET Local.CFG.PlTablePrimaryKey = "LiID">
	<CFSET Local.CFG.PlTableOrderBy    = "LiMakeAndModel, LiYear">
	<CFSET Local.CFG.PlDisplayFields   = "LiMakeAndModel, LiYear, LiAuthorised">
	
	<!--- 
		- Parent Table, each plugin may be a direct child of ONE "parent" table
		- eg Category -> Product Relationship, in Plugin_Product, Category is the
		- parent, CaID is PK and PrCategoryLink is LinkField 
	  --->  
	<CFSET Local.CFG.ParentTable           = StructNew()>
	<CFSET Local.CFG.ParentTable.Name      = "Members">
	<CFSET Local.CFG.ParentTable.PKField   = "MeID">
	<CFSET Local.CFG.ParentTable.LinkField = "LiMemberLink">
	
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
			FieldName  ="LiVehicleTypeLink"
			DisplayName="Vehicle Type"
			Note       =""
			Message    ="Please select vehicle type"
			Type       ="lookup"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="128"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction ="VehicleTypesQuery"
			LinkQueryValue      ="VeTyID"
			LinkQueryDisplay    ="VeTyName"
	/>
	<CF_FIELD 	
			FieldName  ="LiMakeAndModel"
			DisplayName="Make and Model"
			Note       =""
			Message    =""
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
	<CF_FIELD 	
			FieldName  ="LiYear"
			DisplayName="Year"
			Note       =""
			Message    =""
			Type       ="integer"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="4"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiPrice"
			DisplayName="Price"
			Note       =""
			Message    =""
			Type       ="text"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="5"  Cols       ="40"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiShortDescription"
			DisplayName="Short Description of Vehicle"
			Note       =""
			Message    =""
			Type       ="text"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiLongDescription"
			DisplayName="Long Description of Vehicle"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"
	/>
	<CF_FIELD 	
			FieldName  ="LiAreaDescription"
			DisplayName="Your Area Description"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"	
	/>
	<CF_FIELD 	
			FieldName  ="LiWhereWantToGo"
			DisplayName="Where you want to go"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"	
	/>
	<CF_FIELD 	
			FieldName  ="LiProfession"
			DisplayName="Your Profession"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"	
	/>
	<CF_FIELD 	
			FieldName  ="LiInterests"
			DisplayName="Your Interests"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"	
	/>
	<CF_FIELD 	
			FieldName  ="LiOther"
			DisplayName="Other details"
			Note       =""
			Message    =""
			Type       ="memo"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Rows       ="5"  Cols       ="40"	
	/>
	<CF_FIELD 	
			FieldName  ="LiAgeRange"
			DisplayName="Your Age Range"
			Note       =""
			Message    =""
			Type       ="text"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="60"	
	/>
	<CF_FIELD 	
			FieldName  ="LiExchange"
			DisplayName="Exchange"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>
	<CF_FIELD 	
			FieldName  ="LiRent"
			DisplayName="Rent"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>
	<CF_FIELD 	
			FieldName  ="LiSell"
			DisplayName="Sell"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>
	<CF_FIELD 	
			FieldName  ="LiWantedToBuy"
			DisplayName="Wanted to Buy"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>
	<CF_FIELD 	
			FieldName  ="LiWantedToRent"
			DisplayName="Wanted to Rent"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>

	<CF_FIELD 	
			FIELDNAME  ="LiPhoto1"
			DISPLAYNAME="Photo 1"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="oldimage"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
			URL   ="#CFG.AbsoluteWEBURL#/Content/Images/Listings/"
			DIRECTORY = "Content/Images/Listings"
	/>

	<CF_FIELD 	
			FIELDNAME  ="LiPhoto2"
			DISPLAYNAME="Photo 2"
			NOTE       =""
			MESSAGE    =""
			TYPE       ="oldimage"
			REQUIRED   ="false"
			ALLOWHTML  ="false"
			VERIFY     ="false"
			UNIQUE     ="false"
			SIZE       ="30"  MAXLENGTH  ="127"
			ROWS       ="10"  COLS       ="75"	
			LINKQUERYFUSEACTION =""
			LINKQUERYVALUE      =""
			LINKQUERYDISPLAY    =""
			URL   ="#CFG.AbsoluteWEBURL#/Content/Images/Listings/"
			DIRECTORY = "Content/Images/Listings"
	/>
	

	<CF_FIELD 	
			FieldName  ="LiDateAdded"
			DisplayName="Date Modified"
			Note       =""
			Message    =""
			Type       ="date"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiRenewDate"
			DisplayName="Renew Date"
			Note       =""
			Message    =""
			Type       ="date"
			Required   ="true"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiFromDate"
			DisplayName="From Date"
			Note       =""
			Message    =""
			Type       ="date"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>
	<CF_FIELD 	
			FieldName  ="LiToDate"
			DisplayName="To Date"
			Note       =""
			Message    =""
			Type       ="date"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
			Size       ="30"  MaxLength  ="255"
			Rows       ="10"  Cols       ="75"	
			LinkQueryFuseaction =""
			LinkQueryValue      =""
			LinkQueryDisplay    =""
	/>

	<CF_FIELD 	
			FieldName  ="LiSold"
			DisplayName="Vehicle has been Sold"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
	/>

	<CF_FIELD 	
			FieldName  ="LiAuthorised"
			DisplayName="Listing is Authorised"
			Note       =""
			Message    =""
			Type       ="checkbox"
			Required   ="false"
			AllowHTML  ="false"
			Verify     ="false"
			Unique     ="false"
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