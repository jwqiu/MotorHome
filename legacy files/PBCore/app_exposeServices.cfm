<CFSILENT>

	<!--- We absolutely require that we can get into the services structure
		- but only need to read from it, so this lock shouldn't be hard to
		- get (services is seldom exclusivly locked itself) --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.SERVICESLOCK#" TYPE="READONLY" 
	  TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#" THROWONTIMEOUT="Yes">
		<!--- If we can't get this exclusive lock, it only means that another
			- thread is already examining the services and recording them in
			- application scope, so no need to worry about it --->
		<CFLOCK NAME="#PlugBox.BoxKey#" TYPE="EXCLUSIVE" TIMEOUT="#REQUEST.PLUGBOX.OLockTimeout#" THROWONTIMEOUT="NO">
			<CFIF Not StructKeyExists(APPLICATION.PLUGBOX.Services, UCase(PlugBox.BoxKey))>
				<!---
					- Include our services
					--->		
				<CFSET APPLICATION.PLUGBOX.Services[PlugBox.BoxKey] = Duplicate(PlugBox.Provides)>
				
				<!---
					- Now ask our plugins (if any) for thier services list 
					- This list will be recieved as a WDDX structure
				  --->
				<CFDIRECTORY ACTION="LIST" DIRECTORY="#PlugBox.BoxPath#" NAME="Q_Plugins">
				
				<!--- See app_core.cfm for definition of this --->
				<CFSET RelPath = CallingPath> 
				
				<CFOUTPUT QUERY="Q_Plugins">
					<CFIF ReFind("Plugin\_", Name)>
					<!--- Ask for Services Report --->
					<CFMODULE TEMPLATE="#RelPath#/#Name#/app_runCore.cfm" FUSEACTION="Services"/>
					<CFSET PluginServices = CFMODULE.PlugBox.Provides>
					
					<!--- For ease of reference temporarily set x to a reference  --->
					<CFSET x = APPLICATION.PLUGBOX.Services[PlugBox.BoxKey]>
						
					<!--- Insert services into our own --->
					<CFLOOP LIST="#StructKeyList(PluginServices)#" INDEX="Service">
						<CFIF (NOT StructKeyExists(x, Service)) OR PluginServices[Service].Level GT x[Service].Level>
							<CFSET x[Service] = 
								pb_serviceNew(	PluginServices[Service].Comments, PluginServices[Service].Level, Name )>
						</CFIF>
					</CFLOOP>		
					</CFIF>
				</CFOUTPUT>
			</CFIF>	
		</CFLOCK>
		
		<!--- We must be able to read our services, 
			-  I've allocated 60 seconds to get the lock, now normally this should
			- aquire in milliseconds, but if you have a VERY large plugin chain and 
			- it is still being sorted out by another thread then this could time
			- out, but again, it would have to be a very large plugin chain to
			- take 60 seconds to examine it --->
		<CFLOCK NAME="#PlugBox.BoxKey#" TYPE="READONLY" TIMEOUT="60" THROWONTIMEOUT="YES">	
			<!--- Copy our services (now with children) back into the Provides structure --->
			<CFSET PlugBox.Provides = Duplicate(APPLICATION.PLUGBOX.Services[PlugBox.BoxKey])>
		</CFLOCK>
		
		<!--- If we are not being called as cfmodule put
			- our services into REQUEST.Services also --->
		<CFIF NOT IsDefined("ThisTag.ExecutionMode")>
			<CFSET REQUEST.Services = Duplicate(PlugBox.Provides)>
		</CFIF>
	</CFLOCK>
</CFSILENT>