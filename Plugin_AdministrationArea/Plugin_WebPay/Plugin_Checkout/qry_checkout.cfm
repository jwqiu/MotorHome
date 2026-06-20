<CFSILENT>
	
	<CFIF IsDefined("CFG.WebPay.PaymentTitleImage") AND Len(CFG.WebPay.PaymentTitleImage)>
		<CFSET REQUEST.TitleImage = CFG.WebPay.PaymentTitleImage>
	</CFIF>
	
	<CFPARAM NAME="ATTRIBUTES.Note" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Total" DEFAULT="0">
	<CFPARAM NAME="ATTRIBUTES.Reference" DEFAULT="#DateFormat( Now(),"yyyymmdd")#-#TimeFormat( Now(), "HHmmss")#-#RandRange(0, 100)#">
	<CFPARAM NAME="ATTRIBUTES.Name" DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.Email" DEFAULT="">
	
	<CFIF NOT IsDefined("ATTRIBUTES.FurtherDetailsWDDX")>
		<CFPARAM NAME="ATTRIBUTES.ExtraFields" DEFAULT="">  
		<CFSET FurtherDetails = StructNew()>
		<CFSET FurtherDetails.FieldSet = ATTRIBUTES.ExtraFields>
		<CFLOOP LIST="#ATTRIBUTES.ExtraFields#" INDEX="FieldAndType">
			<CFIF IsDefined("ATTRIBUTES.#ListFirst(FieldAndType, '/')#")>
				<CFSET FurtherDetails[ListFirst(FieldAndType, "/")] = ATTRIBUTES[ListFirst(FieldAndType, "/")]>
			</CFIF>
		</CFLOOP>
		<CFWDDX INPUT=#FurtherDetails# OUTPUT="ATTRIBUTES.FurtherDetailsWDDX" ACTION="CFML2WDDX">
	</CFIF>
	
	<!--- Find out if we have more than one active payment processor --->
	<CFSET ActiveProcessors = "">
	
	<CFLOOP LIST="#StructKeyList(CFG.WebPay.Processor)#" INDEX="Processor">
		
		<CFIF IsDefined("CFG.WebPay.Processor.#Processor#.Activated") AND CFG.WebPay.Processor[Processor].Activated>
			
			<CFSET ActiveProcessors = ListAppend(ActiveProcessors, Processor)>
		</CFIF>
	</CFLOOP>
	
	
	
</CFSILENT>