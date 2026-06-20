CREATE SCHEMA AUTHORIZATION [MOTORHOMEEXC-COM]

CREATE TABLE Configuration (
	CoID INTEGER NOT NULL,
	CoWebSiteName	VARCHAR(127),
	CoEmailAddress	VARCHAR(255),
	CoBCCAddress	VARCHAR(255),
	CoKeywords	TEXT,
	CoDescription	TEXT,
	CoAdminUsername	VARCHAR(25),
	CoAdminPassword	VARCHAR(25),
	CoContactDetails	TEXT,
	PRIMARY KEY (CoID)
)

CREATE TABLE Members (
	MeID INTEGER NOT NULL,
	MeInformalName	VARCHAR(255),
	MeFormalName	VARCHAR(255),
	MeAddress	VARCHAR(127),
	MeCountryLink	INTEGER,
	MeStateLink	INTEGER,
	MeCityLink	INTEGER,
	MeZipCode	VARCHAR(127),
	MeAirport VARCHAR(127),
	MeWorkPhone	VARCHAR(25),
	MeHomePhone VARCHAR(25),
	MeFax		VARCHAR(25),
	MeEmail		VARCHAR(255),
	MePassword	VARCHAR(10),
	MeHeardFrom	VARCHAR(127),
	MeHeardField	VARCHAR(127),
	MeActivate	BIT,
	MeMailingList	BIT,
	PRIMARY KEY (MeID)
)

CREATE TABLE Listings (
	LiID	INTEGER NOT NULL,
	LiVehicleTypeLink	INTEGER,
	LiMakeAndModel	VARCHAR(127),
	LiYear	INTEGER,
	LiShortDescription	VARCHAR(255),
	LiLongDescription	TEXT,
	LiPrice	VARCHAR(255),
	LiAreaDescription	TEXT,
	LiWhereWantToGo		TEXT,
	LiExchange	BIT,
	LiRent	BIT,
	LiSell	BIT,
	LiWantedToBuy	BIT,
	LiWantedToRent	BIT,
	LiProfession	TEXT,
	LiInterests	TEXT,
	LiAgeRange	TEXT,
	LiOther	TEXT,
	LiMemberLink	INTEGER,
	LiDateAdded	DATETIME,
	LiRenewDate	DATETIME,
	LiFromDate	DATETIME,
	LiToDate	DATETIME,
	LiAuthorised	BIT,
	LiPaid	BIT,
	LiPhoto1	VARCHAR(127),
	LiPhoto2	VARCHAR(127),
	LiUUID	VARCHAR(40),
	PRIMARY KEY (LiID)
)

CREATE TABLE VehicleTypes (
	VeTyID	INTEGER NOT NULL,
	VeTyName	VARCHAR(127) NOT NULL,
	PRIMARY KEY (VeTyID)
)

CREATE TABLE Countries (
	CntID	INTEGER NOT NULL,
	CntName	VARCHAR(127) NOT NULL,
	PRIMARY KEY (CntID)
)

CREATE TABLE States (
	StID	INTEGER NOT NULL,
	StName	VARCHAR(127) NOT NULL,
	StCountryLink	INTEGER NOT NULL,
	PRIMARY KEY (StID)
)

CREATE TABLE Cities (
	CiID	INTEGER NOT NULL,
	CiName	VARCHAR(127) NOT NULL,
	CiStateLink	INTEGER NOT NULL,
	PRIMARY KEY(CiID)
)

CREATE TABLE NewsletterMembers (
	NeMeID	INTEGER NOT NULL,
	NeMeName	VARCHAR(127),
	NeMeEmail	VARCHAR(255),
	PRIMARY KEY(NeMeID)
)

CREATE TABLE Prices (
	PrID	INTEGER NOT NULL,
	PrExRnOneYear	DECIMAL(9,2),
	PrExRnThreeYears	DECIMAL(9,2),
	PrExRnSixYears	DECIMAL(9,2),
	PrExRnAdd	DECIMAL(9,2),
	PrSellFirst			DECIMAL(9,2),
	PrSellAdd			DECIMAL(9,2),
	PrWantedBuyFirst	DECIMAL(9,2),
	PrWantedBuyAdd		DECIMAL(9,2),
	PrWantedRentFirst	DECIMAL(9,2),
	PrWantedRentAdd		DECIMAL(9,2),
	PRIMARY KEY(PrID)
)

CREATE TABLE FreeAccounts (
	FrAcID 		INTEGER,
	FrAcAmount 	INTEGER,
	PRIMARY KEY	(FrAcID)
)