CREATE TABLE UserData (
	UserId BIGINT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Gender NVARCHAR(10) NOT NULL,
	ProfileImage NVARCHAR(MAX) NULL,
	UserDescription NVARCHAR(500) NULL,
	UserName NVARCHAR(20) NOT NULL UNIQUE,
	EmailAddress NVARCHAR(30) NOT NULL UNIQUE,
	PasswordHash NVARCHAR(100) NOT NULL UNIQUE,
	MobileNo INT NOT NULL UNIQUE CONSTRAINT USER_MOBILE CHECK (MobileNo BETWEEN 1000000000 AND 9999999999),
	TotalPostCount BIGINT NOT NULL,
	IsDailyPostLimitReached BIT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsOrganisation BIT NOT NULL DEFAULT 0,
	IsVerified BIT NOT NULL DEFAULT 1,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
	PincodeId BIGINT NOT NULL 
	)

ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)
ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserState FOREIGN KEY(StateId) REFERENCES States(StateId)

CREATE TABLE Post (
	PostId BIGINT IDENTITY(1,1) CONSTRAINT PK_Post PRIMARY KEY, 
	UserId BIGINT NOT NULL,
	Description TEXT NOT NULL, 
	RequirementTypeId BIGINT NOT NULL, 
	LocationName NVARCHAR(50) NOT NULL, 
	Longitude DECIMAL(12,9) NOT NULL, 
	Latitude DECIMAL(12,9) NOT NULL, 
	HelpRequiredCount INT NOT NULL,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
	ImageURL NVARCHAR(MAX) NOT NULL, 
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsClosed BIT NOT NULL DEFAULT 0,
	CloseAt DATETIME NOT NULL,
	PincodeId BIGINT NOT NULL
	)

ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_RequirementType FOREIGN KEY(RequirementTypeId) REFERENCES RequirementType(RequirementTypeId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostState FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)

CREATE TABLE Roles (
	RolePermissionID BIGINT IDENTITY(1,1) CONSTRAINT PK_Roles PRIMARY KEY,
	RoleTypeId BIGINT NOT NULL,
	UserId BIGINT NOT NULL,
	ModuleId BIGINT NOT NULL,
	IsPermissionAdd BIT NOT NULL DEFAULT 0,
	IsPermissionEdit BIT NOT NULL DEFAULT 0,
	IsPermissionView BIT NOT NULL DEFAULT 0,
	IsPermissionDelete BIT NOT NULL DEFAULT 0,
	CreatedBy NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL
	)
ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_UserIdRole FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_ModuleRole FOREIGN KEY(ModuleId) REFERENCES Module(ModuleId)
ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_RoleTypeID FOREIGN KEY(RoleTypeId) REFERENCES RoleType(RoleTypeId)


CREATE TABLE RoleType (
	RoleTypeId BIGINT IDENTITY(1,1) CONSTRAINT PK_RoleType PRIMARY KEY,
	RoleType NVARCHAR(30) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL
	)



CREATE TABLE CharityEvent (
	EventId BIGINT CONSTRAINT PK_CharityEvent PRIMARY KEY,
	EventName NVARCHAR(50) NOT NULL,
	EventDescription TEXT NOT NULL,
	EventOrganiserId BIGINT NOT NULL,
	EventStartDate DATETIME NOT NULL,
	EventEndDate DATETIME NOT NULL,
	IsVerified BIT NOT NULL DEFAULT 0,
	EventType NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsCompleted BIT NOT NULL DEFAULT 0
	)

ALTER TABLE CharityEvent WITH CHECK ADD CONSTRAINT FK_CharityUserId FOREIGN KEY(EventOrganiserId) REFERENCES UserData(UserId)


CREATE TABLE Cities (
	CityId BIGINT IDENTITY(1,1) CONSTRAINT PK_Cities PRIMARY KEY,
	StateId BIGINT NOT NULL,
	CityName NVARCHAR(50) NOT NULL
	)

ALTER TABLE Cities WITH CHECK ADD CONSTRAINT FK_Cities FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE CharityEvent ADD CityId BIGINT


CREATE TABLE States (
	StateId BIGINT IDENTITY(1,1) CONSTRAINT PK_States PRIMARY KEY,
	StateName NVARCHAR(50) NOT NULL UNIQUE,
	)



CREATE TABLE Module (
    ModuleId BIGINT IDENTITY(1,1) CONSTRAINT PK_Module PRIMARY KEY,
    ModuleName NVARCHAR(30) NOT NULL,
    ModuleType NVARCHAR(20) NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 1,
    CreatedBy NVARCHAR(50) NOT NULL, 
    CreatedAt DATETIME NOT NULL, 
    UpdatedBy NVARCHAR(50) NOT NULL, 
    UpdatedAt DATETIME NOT NULL
    )

CREATE TABLE Organisation (
    OrganisationId BIGINT IDENTITY(1,1) CONSTRAINT PK_Organisation PRIMARY KEY,
    OrganisationUserId BIGINT NOT NULL,
    OrganisationName NVARCHAR(50) NOT NULL,
    OrganisationAddress NVARCHAR(MAX) NOT NULL,
    OrganisationContactNo INT NOT NULL UNIQUE CONSTRAINT ORGANISATION_MOBILE CHECK (OrganisationContactNo BETWEEN 1000000000 AND 9999999999),
    OrganisationLogoURL NVARCHAR(MAX) NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    CreatedBy NVARCHAR(50) NOT NULL, 
    CreatedAt DATETIME NOT NULL, 
    UpdatedBy NVARCHAR(50) NOT NULL, 
    UpdatedAt DATETIME NOT NULL
    )

ALTER TABLE Organisation WITH CHECK ADD CONSTRAINT FK_OrgUser FOREIGN KEY(OrganisationUserId) REFERENCES UserData(UserId)


CREATE TABLE RequirementType (
    RequirementTypeId BIGINT IDENTITY(1,1) CONSTRAINT PK_Contro PRIMARY KEY,
    RequirementTypeName NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
    CreatedAt DATETIME NOT NULL, 
    UpdatedBy NVARCHAR(50) NOT NULL, 
    UpdatedAt DATETIME NOT NULL
    ) 
CREATE TABLE Volunteer (
    VolunteerId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Volunteer PRIMARY KEY,
    VolunteerUserId BIGINT NOT NULL,
	OrganisationId BIGINT NOT NULL,
	IsVerified BIT NOT NULL DEFAULT 0,
    CreatedBy NVARCHAR(50) NOT NULL, 
    CreatedAt DATETIME NOT NULL, 
    UpdatedBy NVARCHAR(50) NOT NULL, 
    UpdatedAt DATETIME NOT NULL
    )

ALTER TABLE Volunteer WITH CHECK ADD CONSTRAINT FK_Volunteer FOREIGN KEY(VolunteerUserId) REFERENCES UserData(UserId)
ALTER TABLE Volunteer WITH CHECK ADD CONSTRAINT FK_VolunteerOrg FOREIGN KEY(OrganisationId) REFERENCES Organisation(OrganisationId)

CREATE TABLE ClusterLocations (
    ClusterLocationId BIGINT IDENTITY(1,1) CONSTRAINT PK_Cluster PRIMARY KEY,
	UserId BIGINT NOT NULL,
	PostId BIGINT NOT NULL,
	RequirementTypeId BIGINT NOT NULL,
    Locations NVARCHAR(50) NOT NULL,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
    PeopleCount BIGINT NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    CreatedBy NVARCHAR(50) NOT NULL, 
    CreatedAt DATETIME NOT NULL, 
    UpdatedBy NVARCHAR(50) NOT NULL, 
    UpdatedAt DATETIME NOT NULL,
	PincodeId BIGINT NOT NULL
    )

ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterPostId FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterControId FOREIGN KEY(RequirementTypeId) REFERENCES RequirementType(RequirementTypeId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterState FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)

CREATE TABLE Urgency (
    UrgencyId BIGINT IDENTITY(1,1) CONSTRAINT PK_Urgent PRIMARY KEY,
    PostId BIGINT NOT NULL,
    UserId BIGINT NOT NULL
    )
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT FK_UrgentPost FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT FK_UrgentUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT UK_UrgencyUser UNIQUE(PostId,UserId)

CREATE TABLE Spam (
    SpamId BIGINT IDENTITY(1,1) CONSTRAINT PK_Spam PRIMARY KEY,
    PostId BIGINT NOT NULL,
    UserId BIGINT NOT NULL
    ) 
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT FK_SpamPost FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT FK_SpamUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT UK_SpamUser UNIQUE(PostId,UserId)


CREATE TABLE OTP (
	OtpNo BIGINT IDENTITY(1,1) CONSTRAINT PK_OTP PRIMARY KEY,
	OTP INT NOT NULL,
	UserId BIGINT NOT NULL ,
    CreatedAt DATETIME NOT NULL
	)

ALTER TABLE OTP WITH CHECK ADD CONSTRAINT FK_OtpUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE OTP WITH CHECK ADD CONSTRAINT UK_OTPUserId UNIQUE(UserId)



CREATE TABLE Pincode(
	PincodeId BIGINT IDENTITY(1,1) CONSTRAINT PK_PC PRIMARY KEY,
	PostOfficeName VARCHAR(100),
	Pincode INT NOT NULL,
	CityId BIGINT NOT NULL,
	District VARCHAR(100),
	StateId BIGINT NOT NULL
	) 
ALTER TABLE Pincode WITH CHECK ADD CONSTRAINT FK_PincodeCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE Pincode WITH CHECK ADD CONSTRAINT FK_PincodeState FOREIGN KEY(StateId) REFERENCES States(StateId)