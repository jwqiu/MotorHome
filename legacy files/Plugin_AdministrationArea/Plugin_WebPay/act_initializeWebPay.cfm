<CFSILENT>
	
	<!--- Create tables for the web pay system, we'll CFTRY each one in case only some are present --->
	
	<!--- Transactions Table --->
		<CFTRY>
			<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_Transactions">
				CREATE TABLE Transactions
				( TrID	INTegER NOT NULL PRIMARY KEY,
				  TrDateTime DATETIME,
				  TrReference VARCHAR(50),
				  TrTotal	  VARCHAR(255),
				  TrTotal_NZD DECIMAL(9,2),
				  TrClientName VARCHAR(127),
				  TrClientEmail VARCHAR(255),
				  TrFurtherDetailsWDDX TEXT,
				  TrPaymentDetailsWDDX TEXT
				 )				  
			</CFQUERY>
		<CFCATCH TYPE="ANY">
			<!--- Ignore --->
		</CFCATCH>
		</CFTRY>
		
	
	
</CFSILENT>