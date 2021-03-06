/*
   Friday, June 17, 201612:11:33 AM
   User: 
   Server: EARTH\SQLEXPRESS
   Database: HMS
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Contact
	DROP CONSTRAINT DF_Contact_Gender
GO
ALTER TABLE dbo.Contact
	DROP CONSTRAINT DF_Contact_Active
GO
CREATE TABLE dbo.Tmp_Contact
	(
	Id bigint NOT NULL IDENTITY (101, 1),
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NULL,
	PhoneNumber nvarchar(20) NOT NULL,
	Street nvarchar(50) NULL,
	Gender bit NOT NULL,
	City nvarchar(50) NULL,
	Zip nvarchar(6) NULL,
	Country nvarchar(50) NULL,
	Email nvarchar(100) NULL,
	Fax nvarchar(50) NULL,
	WebSite nvarchar(MAX) NULL,
	Photo nvarchar(255) NULL,
	IsCompany bit NULL,
	Active bit NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Contact SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_Contact ADD CONSTRAINT
	DF_Contact_Gender DEFAULT ((0)) FOR Gender
GO
ALTER TABLE dbo.Tmp_Contact ADD CONSTRAINT
	DF_Contact_Active DEFAULT ((0)) FOR Active
GO
SET IDENTITY_INSERT dbo.Tmp_Contact ON
GO
IF EXISTS(SELECT * FROM dbo.Contact)
	 EXEC('INSERT INTO dbo.Tmp_Contact (Id, FirstName, LastName, PhoneNumber, Street, Gender, City, Zip, Country, Email, Fax, WebSite, IsCompany, Active)
		SELECT Id, FirstName, LastName, PhoneNumber, Street, Gender, City, Zip, Country, Email, Fax, WebSite, IsCompany, Active FROM dbo.Contact WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Contact OFF
GO
ALTER TABLE dbo.ServiceProvider
	DROP CONSTRAINT FK_Contact_ServiceProvider
GO
ALTER TABLE dbo.[User]
	DROP CONSTRAINT FK_User_Contact
GO
DROP TABLE dbo.Contact
GO
EXECUTE sp_rename N'dbo.Tmp_Contact', N'Contact', 'OBJECT' 
GO
ALTER TABLE dbo.Contact ADD CONSTRAINT
	PK_T_Contact PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.[User] ADD CONSTRAINT
	FK_User_Contact FOREIGN KEY
	(
	ContactId
	) REFERENCES dbo.Contact
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ServiceProvider ADD CONSTRAINT
	FK_Contact_ServiceProvider FOREIGN KEY
	(
	ContactId
	) REFERENCES dbo.Contact
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ServiceProvider SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
