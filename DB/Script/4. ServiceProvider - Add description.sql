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
ALTER TABLE dbo.ServiceProvider
	DROP CONSTRAINT FK_Contact_ServiceProvider
GO
ALTER TABLE dbo.Contact SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ServiceProvider
	DROP CONSTRAINT FK_ServiceProviderType_ServiceProvider
GO
ALTER TABLE dbo.ServiceProviderType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ServiceProvider
	DROP CONSTRAINT FK_Department_ServiceProvider
GO
ALTER TABLE dbo.Department SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_ServiceProvider
	(
	Id bigint NOT NULL IDENTITY (1, 1),
	ContactId bigint NOT NULL,
	ServiceProviderTypeId bigint NOT NULL,
	DepartmentId bigint NOT NULL,
	Speciality nvarchar(MAX) NULL,
	Code nvarchar(50) NULL,
	Description nvarchar(255) NULL,
	AssignedToAllUsers bit NULL,
	IsReferer bit NULL,
	Active bit NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_ServiceProvider SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_ServiceProvider ON
GO
IF EXISTS(SELECT * FROM dbo.ServiceProvider)
	 EXEC('INSERT INTO dbo.Tmp_ServiceProvider (Id, ContactId, ServiceProviderTypeId, DepartmentId, Speciality, Code, AssignedToAllUsers, IsReferer, Active)
		SELECT Id, ContactId, ServiceProviderTypeId, DepartmentId, Speciality, Code, AssignedToAllUsers, IsReferer, Active FROM dbo.ServiceProvider WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_ServiceProvider OFF
GO
ALTER TABLE dbo.PatientAdmission
	DROP CONSTRAINT FK_T_PatientAdmission_T_ServiceProvider
GO
ALTER TABLE dbo.PatientAdmission
	DROP CONSTRAINT FK_T_PatientAdmission_T_ServiceProvider1
GO
ALTER TABLE dbo.Referral
	DROP CONSTRAINT FK_Referral_ServiceProvider
GO
ALTER TABLE dbo.Item
	DROP CONSTRAINT FK_Item_T_ServiceProvider
GO
ALTER TABLE dbo.ServiceProviderAppointment
	DROP CONSTRAINT FK_ServiceProviderAppointment_ServiceProvider
GO
DROP TABLE dbo.ServiceProvider
GO
EXECUTE sp_rename N'dbo.Tmp_ServiceProvider', N'ServiceProvider', 'OBJECT' 
GO
ALTER TABLE dbo.ServiceProvider ADD CONSTRAINT
	PK_T_ServiceProvider PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ServiceProvider ADD CONSTRAINT
	FK_Department_ServiceProvider FOREIGN KEY
	(
	DepartmentId
	) REFERENCES dbo.Department
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ServiceProvider ADD CONSTRAINT
	FK_ServiceProviderType_ServiceProvider FOREIGN KEY
	(
	ServiceProviderTypeId
	) REFERENCES dbo.ServiceProviderType
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
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
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ServiceProviderAppointment ADD CONSTRAINT
	FK_ServiceProviderAppointment_ServiceProvider FOREIGN KEY
	(
	ServiceProviderId
	) REFERENCES dbo.ServiceProvider
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ServiceProviderAppointment SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Item ADD CONSTRAINT
	FK_Item_T_ServiceProvider FOREIGN KEY
	(
	ServiceProviderId
	) REFERENCES dbo.ServiceProvider
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Referral ADD CONSTRAINT
	FK_Referral_ServiceProvider FOREIGN KEY
	(
	ServiceProviderId
	) REFERENCES dbo.ServiceProvider
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Referral SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PatientAdmission ADD CONSTRAINT
	FK_T_PatientAdmission_T_ServiceProvider FOREIGN KEY
	(
	ServiceProviderId
	) REFERENCES dbo.ServiceProvider
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PatientAdmission ADD CONSTRAINT
	FK_T_PatientAdmission_T_ServiceProvider1 FOREIGN KEY
	(
	RefererId
	) REFERENCES dbo.ServiceProvider
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PatientAdmission SET (LOCK_ESCALATION = TABLE)
GO
COMMIT





USE [HMS]
GO
SET IDENTITY_INSERT [dbo].[ServiceProvider] ON 

GO
INSERT [dbo].[ServiceProvider] ([Id], [ContactId], [ServiceProviderTypeId], [DepartmentId], [Speciality], [Code], [Description], [AssignedToAllUsers], [IsReferer], [Active]) VALUES (19, 149, 56, 205, N'MBBS, DDSc (UK), MDSc (USA)<br />Senior Consultant, Clinical Fellowship in Advanced Dermatology & Wound Healing (USA)', N'SP1', N'Prof. (Dr.) Brig. Gen. Faruk Ahmed (Red.) MBBS, MCPS (Clinical Pathology), FCPS (Hematology), joins SQUARE Hospital as a Consultant, Hematology. Dr. Ahmed graduated from Rajshahi Medical College and started his career as general duty medical officer in combined military hospitals under defense ministry. Then he underwent full time residential training in Clinical Pathology at Armed Forces institute of Pathology and successfully obtained a postgraduate diploma. Subsequently he achieved MCPS Degree in clinical pathology. Then he pursued FCPS degree in Hematology from Bangladesh College of Physicians and Surgeons. He also achieved advanced training on Automated Hematology in Pakistan. In his professional life, he gained a wide exposure in the field of hematology. He has special interest in Clinical & Diagnostic Hematology. Dr. Ahmed actively participated in many seminars and symposiums in home, abroad, and presented papers in his respective field. He is an examiner of FCPS in Hematology. He has published a number of articles in reputed medical journals and appreciated by the physicians. Now he is available at SQUARE Hospital for consulting patients.', NULL, 1, 1)
GO
INSERT [dbo].[ServiceProvider] ([Id], [ContactId], [ServiceProviderTypeId], [DepartmentId], [Speciality], [Code], [Description], [AssignedToAllUsers], [IsReferer], [Active]) VALUES (21, 153, 56, 205, N'MBBS, FCPS, FICS (USA)
<br />Coordinator & Senior Consultant – Paediatric Surgery & Paediatric Urology', N'SP2', N'Professor & Head Department of Surgery at BIRDEM General Hospital and Ibrahim Medical College, before joining Apollo Hospitals Dhaka. He worked at this Hospital in different capacities for last 18 years. He was trained in Ireland, Saudi Arabia, India and Japan in the field of Laparoscopic .', NULL, 1, 1)
GO
INSERT [dbo].[ServiceProvider] ([Id], [ContactId], [ServiceProviderTypeId], [DepartmentId], [Speciality], [Code], [Description], [AssignedToAllUsers], [IsReferer], [Active]) VALUES (22, 154, 56, 206, N'MBBS, FCPS, FICS (USA)
<br />Coordinator & Senior Consultant – Paediatric Surgery & Paediatric Urology', N'SP3', N'Dr. M. Akhter Hossain is a known name in cardiac surgery in Bangladesh. He  completed his Medical graduation from Dhaka Medical College in 1985. After his internship year he started his served different hospitals across the country, at different levels and obtained MS degree in cardiovascular & Thoracic surgery from NICVD and also served as Assistant Registrar, Assistant Professor for about 8 years till 2006 and achieved super specialty training in cardiovascular surgery. Then he obtained advanced training in cardiac surgery from Sri Ramachandra Medical Institute India. He then joined Lab Aid Cardiac Hospital as Senior Consultant of Cardiac Surgery. During his professional carrier he performed a large series of cardiac surgery of all categories with excellent outcome. He also performed a large number of beating heart bypass surgery, MIDCAB, Redo-bypass, Valve Replacement, Valve Repair surgery and congenital cardiac surgery. He has the credit of performing emergency bypass surgery in patient of carcinogenic shock under balloon pump support. He performed ASD, VSD, and Mitral Valve Replacement via lower ministernotomy for the first time in Bangladesh. He has also performed Aortic Valve Replacement via upper mini-strenotomy. He is regularly doing ASD Valve Replacement via right Minithoracotomy with very good Physical & cosmetic benefit. He has performed bypass surgery via left Minithoracotomy (MIDCAB). His special interest in beating heart by pass surgery and minimally invasive cardiac surgery. He is a life member of Bangladesh Cardiac society and Bangladesh association of cardiac thoracic & vascular surgery. He joins Square Hospital as an experienced Consultant of Cardiac Surgery.', NULL, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ServiceProvider] OFF
GO
SET IDENTITY_INSERT [dbo].[Appointment] ON 

GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (1, N'10:00-10:15', CAST(N'10:00:00' AS Time), CAST(N'10:15:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (2, N'10:15-10:30', CAST(N'10:15:00' AS Time), CAST(N'10:30:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (3, N'10:30-10:45', CAST(N'10:30:00' AS Time), CAST(N'10:45:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (4, N'10:45-11:00', CAST(N'10:45:00' AS Time), CAST(N'11:00:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (5, N'11:00-11:15', CAST(N'11:00:00' AS Time), CAST(N'11:15:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (6, N'11:15-11:30', CAST(N'11:15:00' AS Time), CAST(N'11:30:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (7, N'11:30-11:45', CAST(N'11:30:00' AS Time), CAST(N'11:45:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (8, N'11:45-12:00', CAST(N'11:45:00' AS Time), CAST(N'12:00:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (9, N'12:00-12:15', CAST(N'12:00:00' AS Time), CAST(N'12:15:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (10, N'12:15-12:30', CAST(N'12:15:00' AS Time), CAST(N'12:30:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (11, N'12:30-12:45', CAST(N'12:30:00' AS Time), CAST(N'12:45:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (12, N'12:45-13:00', CAST(N'12:45:00' AS Time), CAST(N'13:00:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (13, N'14:00-14:15', CAST(N'14:00:00' AS Time), CAST(N'14:15:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (14, N'14:15-14:30', CAST(N'14:15:00' AS Time), CAST(N'14:30:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (15, N'14:30-14:45', CAST(N'14:30:00' AS Time), CAST(N'14:45:00' AS Time), 1)
GO
INSERT [dbo].[Appointment] ([Id], [Name], [StartTime], [EndTime], [Active]) VALUES (16, N'14:45-15:00', CAST(N'14:45:00' AS Time), CAST(N'15:00:00' AS Time), 1)
GO
SET IDENTITY_INSERT [dbo].[Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceProviderAppointment] ON 

GO
INSERT [dbo].[ServiceProviderAppointment] ([Id], [AppointmentDate], [ServiceProviderId], [AppointmentId], [PatientId], [AppointmentAllowed], [Active]) VALUES (2, CAST(N'2016-06-16' AS Date), 21, 2, 115, 0, 1)
GO
INSERT [dbo].[ServiceProviderAppointment] ([Id], [AppointmentDate], [ServiceProviderId], [AppointmentId], [PatientId], [AppointmentAllowed], [Active]) VALUES (5, CAST(N'2016-06-17' AS Date), 22, 4, 115, 0, 1)
GO
INSERT [dbo].[ServiceProviderAppointment] ([Id], [AppointmentDate], [ServiceProviderId], [AppointmentId], [PatientId], [AppointmentAllowed], [Active]) VALUES (10, CAST(N'2016-06-19' AS Date), 21, 6, 115, 0, 1)
GO
INSERT [dbo].[ServiceProviderAppointment] ([Id], [AppointmentDate], [ServiceProviderId], [AppointmentId], [PatientId], [AppointmentAllowed], [Active]) VALUES (11, CAST(N'2016-06-19' AS Date), 21, 9, 115, 0, 1)
GO
INSERT [dbo].[ServiceProviderAppointment] ([Id], [AppointmentDate], [ServiceProviderId], [AppointmentId], [PatientId], [AppointmentAllowed], [Active]) VALUES (12, CAST(N'2016-06-19' AS Date), 21, 5, 115, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[ServiceProviderAppointment] OFF
GO
