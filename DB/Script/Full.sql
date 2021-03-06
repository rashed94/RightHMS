USE [HMS]
GO
ALTER TABLE [dbo].[ServiceProvider] DROP CONSTRAINT [FK_ServiceProviderType_ServiceProvider]
GO
ALTER TABLE [dbo].[ServiceProvider] DROP CONSTRAINT [FK_Department_ServiceProvider]
GO
ALTER TABLE [dbo].[ServiceProvider] DROP CONSTRAINT [FK_Contact_ServiceProvider]
GO
ALTER TABLE [dbo].[Refund] DROP CONSTRAINT [FK_T_Refund_T_PatientInvoice]
GO
ALTER TABLE [dbo].[ReceiptPayment] DROP CONSTRAINT [FK_T_ReceiptPayment_T_Payment]
GO
ALTER TABLE [dbo].[ReceiptPayment] DROP CONSTRAINT [FK_T_ReceiptPayment_T_Item]
GO
ALTER TABLE [dbo].[Payment] DROP CONSTRAINT [FK_T_Payment_T_PaymentType]
GO
ALTER TABLE [dbo].[Payment] DROP CONSTRAINT [FK_T_Payment_T_Patient]
GO
ALTER TABLE [dbo].[PatientService] DROP CONSTRAINT [FK_T_PatientService_T_PatientInvoice]
GO
ALTER TABLE [dbo].[PatientService] DROP CONSTRAINT [FK_T_PatientService_T_Patient]
GO
ALTER TABLE [dbo].[PatientService] DROP CONSTRAINT [FK_T_PatientService_T_Item]
GO
ALTER TABLE [dbo].[PatientInvoice] DROP CONSTRAINT [FK_T_PatientInvoice_T_InvoiceStatus]
GO
ALTER TABLE [dbo].[PatientInvoice] DROP CONSTRAINT [FK_Patient_T_PatientInvoice]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider1]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [FK_T_PatientAdmission_T_Department]
GO
ALTER TABLE [dbo].[Membership] DROP CONSTRAINT [FK_Membership_T_Patient]
GO
ALTER TABLE [dbo].[ItemReorder] DROP CONSTRAINT [FK_Item_T_ItemReorder]
GO
ALTER TABLE [dbo].[ItemDefaults] DROP CONSTRAINT [FK_Item_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults] DROP CONSTRAINT [FK_DrugFrequency_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults] DROP CONSTRAINT [FK_DrugDosage_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults] DROP CONSTRAINT [FK_DrugAdministration_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemCategory] DROP CONSTRAINT [FK_ItemCategory_T_MedicalType]
GO
ALTER TABLE [dbo].[Item_ItemGroup] DROP CONSTRAINT [FK_Item_T_ItemGroup]
GO
ALTER TABLE [dbo].[Item_ItemGroup] DROP CONSTRAINT [FK_Item_T_Item]
GO
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [FK_Item_T_ServiceProvider]
GO
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [FK_Item_T_MedicalType]
GO
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [FK_Item_T_MeasurementUnit]
GO
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [FK_Item_T_ItemType]
GO
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [FK_Item_T_ItemCategory]
GO
ALTER TABLE [dbo].[InvoicePayment] DROP CONSTRAINT [FK_T_InvoicePayment_T_Payment]
GO
ALTER TABLE [dbo].[InvoicePayment] DROP CONSTRAINT [FK_T_InvoicePayment_T_PatientInvoice1]
GO
ALTER TABLE [dbo].[Inventory] DROP CONSTRAINT [FK_Store_T_Store]
GO
ALTER TABLE [dbo].[Inventory] DROP CONSTRAINT [FK_Item1_T_Item]
GO
ALTER TABLE [dbo].[BedOccupancy] DROP CONSTRAINT [FK_Item_T_BedOccupancy]
GO
ALTER TABLE [dbo].[Refund] DROP CONSTRAINT [DF_Refund_Active]
GO
ALTER TABLE [dbo].[ReceiptPayment] DROP CONSTRAINT [DF_ReceiptPayment_Active]
GO
ALTER TABLE [dbo].[Payment] DROP CONSTRAINT [DF_Payment_Active]
GO
ALTER TABLE [dbo].[PatientService] DROP CONSTRAINT [DF_PatientService_Active]
GO
ALTER TABLE [dbo].[PatientInvoice] DROP CONSTRAINT [DF_PatientInvoice_Active]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [DF_T_PatientAdmission_Active]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [DF_T_PatientAdmission_AdmissionDate]
GO
ALTER TABLE [dbo].[PatientAdmission] DROP CONSTRAINT [DF_PatientAdmission_Id]
GO
ALTER TABLE [dbo].[Membership] DROP CONSTRAINT [DF_Membership_Active]
GO
ALTER TABLE [dbo].[ItemReorder] DROP CONSTRAINT [DF_ItemReorder_Active]
GO
ALTER TABLE [dbo].[ItemGroup] DROP CONSTRAINT [DF_ItemGroup_Active]
GO
ALTER TABLE [dbo].[ItemDefaults] DROP CONSTRAINT [DF_ItemDefaults_Active]
GO
ALTER TABLE [dbo].[Item_ItemGroup] DROP CONSTRAINT [DF_Item_ItemGroup_Active]
GO
ALTER TABLE [dbo].[InvoiceStatus] DROP CONSTRAINT [DF_T_InvoiceStatus_Active]
GO
ALTER TABLE [dbo].[InvoicePayment] DROP CONSTRAINT [DF_T_InvoicePayment_Active]
GO
ALTER TABLE [dbo].[Inventory] DROP CONSTRAINT [DF_Inventory_Active]
GO
ALTER TABLE [dbo].[DrugFrequency] DROP CONSTRAINT [DF_DrugFrequency_Active]
GO
ALTER TABLE [dbo].[DrugDosage] DROP CONSTRAINT [DF_DrugDosage_Active]
GO
ALTER TABLE [dbo].[DrugAdministration] DROP CONSTRAINT [DF_DrugAdministration_Active]
GO
/****** Object:  Index [UK_Code]    Script Date: 5/1/2016 11:40:00 PM ******/
ALTER TABLE [dbo].[Item] DROP CONSTRAINT [UK_Code]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Store]
GO
/****** Object:  Table [dbo].[ServiceProviderType]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ServiceProviderType]
GO
/****** Object:  Table [dbo].[ServiceProvider]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ServiceProvider]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Refund]
GO
/****** Object:  Table [dbo].[ReceiptPayment]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ReceiptPayment]
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[PaymentType]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Payment]
GO
/****** Object:  Table [dbo].[PatientService]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[PatientService]
GO
/****** Object:  Table [dbo].[PatientInvoice]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[PatientInvoice]
GO
/****** Object:  Table [dbo].[PatientAdmission]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[PatientAdmission]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Patient]
GO
/****** Object:  Table [dbo].[Membership]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Membership]
GO
/****** Object:  Table [dbo].[MedicalType]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[MedicalType]
GO
/****** Object:  Table [dbo].[MeasurementUnit]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[MeasurementUnit]
GO
/****** Object:  Table [dbo].[ItemType]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ItemType]
GO
/****** Object:  Table [dbo].[ItemReorder]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ItemReorder]
GO
/****** Object:  Table [dbo].[ItemGroup]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ItemGroup]
GO
/****** Object:  Table [dbo].[ItemDefaults]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ItemDefaults]
GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[ItemCategory]
GO
/****** Object:  Table [dbo].[Item_ItemGroup]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Item_ItemGroup]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Item]
GO
/****** Object:  Table [dbo].[InvoiceStatus]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[InvoiceStatus]
GO
/****** Object:  Table [dbo].[InvoicePayment]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[InvoicePayment]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Inventory]
GO
/****** Object:  Table [dbo].[DrugFrequency]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[DrugFrequency]
GO
/****** Object:  Table [dbo].[DrugDosage]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[DrugDosage]
GO
/****** Object:  Table [dbo].[DrugAdministration]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[DrugAdministration]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Department]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Contacts]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[Contact]
GO
/****** Object:  Table [dbo].[BedOccupancy]    Script Date: 5/1/2016 11:40:00 PM ******/
DROP TABLE [dbo].[BedOccupancy]
GO
/****** Object:  Table [dbo].[BedOccupancy]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BedOccupancy](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[Occupied] [bit] NULL,
	[UserId] [bigint] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_T_BedOccupancy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Street] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Zip] [nvarchar](6) NULL,
	[Country] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Fax] [nvarchar](50) NULL,
	[WebSite] [nvarchar](max) NULL,
	[Photo] [image] NULL,
	[IsCompany] [bit] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Contact_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contacts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Street] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[Zip] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Fax] [nvarchar](max) NULL,
	[WebSite] [nvarchar](max) NULL,
	[Photo] [varbinary](max) NULL,
	[IsCompany] [bit] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_dbo.Contacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Department_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DrugAdministration]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrugAdministration](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_DrugAdministration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DrugDosage]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrugDosage](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_DrugDosage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DrugFrequency]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrugFrequency](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_DrugFrequency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[StoreID] [bigint] NOT NULL,
	[Stock] [int] NULL,
	[BuyPrice] [decimal](18, 0) NULL,
	[BuyDate] [datetime] NULL,
	[ExpireDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_Inventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoicePayment]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoicePayment](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[InvoiceId] [bigint] NOT NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[PaymentID] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_InvoicePayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceStatus]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceStatus](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_InvoiceStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[GenericName] [nvarchar](200) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[ItemTypeId] [bigint] NOT NULL,
	[MedicalTypeId] [bigint] NOT NULL,
	[ItemCategoryId] [bigint] NOT NULL,
	[MeasurementUnitId] [bigint] NOT NULL,
	[SalePrice] [decimal](18, 0) NOT NULL,
	[BuyPrice] [decimal](18, 0) NOT NULL,
	[ServiceProviderId] [bigint] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Item_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item_ItemGroup]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item_ItemGroup](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[ItemGroupID] [bigint] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_Item_ItemGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCategory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[MedicalTypeId] [bigint] NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_ItemCategory_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_ItemCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemDefaults]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemDefaults](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[DosageId] [bigint] NULL,
	[AdministrationId] [bigint] NULL,
	[FrequencyId] [bigint] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_ItemDefaults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemGroup]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemGroup](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_ItemGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemReorder]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemReorder](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ReorderLevel] [int] NOT NULL,
	[ShelfName] [nvarchar](200) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_ItemReorder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemType]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_ItemType_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_ItemType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MeasurementUnit]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasurementUnit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_MeasurementUnit_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_MeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MedicalType]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_MedicalType_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_MedicalType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Membership]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membership](
	[Id] [bigint] NOT NULL,
	[PatiendId] [bigint] NOT NULL,
	[ValidityPeriod] [nvarchar](20) NOT NULL,
	[AnnualFee] [decimal](18, 0) NOT NULL,
	[HealthBook] [bit] NULL,
	[EntryDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patient]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Gender] [bit] NOT NULL,
	[BloodGroup] [nvarchar](5) NULL,
	[FatherName] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[NationalId] [nvarchar](50) NULL,
	[Occupation] [nvarchar](50) NULL,
	[Street] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Zip] [nvarchar](6) NULL,
	[Country] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Photo] [image] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Patient_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_Patient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientAdmission]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientAdmission](
	[Id] [bigint] NOT NULL,
	[PatientId] [bigint] NOT NULL,
	[AdmissionDate] [datetime] NOT NULL,
	[DischargeDate] [datetime] NULL,
	[ServiceProviderId] [bigint] NULL,
	[RefererId] [bigint] NULL,
	[DepartmentId] [bigint] NULL,
	[Notes] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_PatientAdmission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientInvoice]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientInvoice](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[DueDate] [datetime] NULL,
	[UserId] [bigint] NULL,
	[StatusId] [bigint] NOT NULL,
	[TotalAmount] [decimal](18, 0) NOT NULL,
	[TotalDiscount] [decimal](18, 0) NULL,
	[ItemDiscount] [decimal](18, 0) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_PatientInvoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientService]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientService](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientId] [bigint] NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[InvoiceId] [bigint] NULL,
	[ServiceListPrice] [decimal](18, 0) NOT NULL,
	[ServiceActualPrice] [decimal](18, 0) NOT NULL,
	[ServiceQuantity] [int] NOT NULL,
	[ServiceDate] [datetime] NOT NULL,
	[UserId] [bigint] NULL,
	[Discount] [decimal](18, 0) NULL,
	[Refund] [bit] NULL,
	[Billed] [bit] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_PatientService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[DeductionAmount] [decimal](18, 0) NULL,
	[PaymentTypeId] [bigint] NOT NULL,
	[PatientID] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentType](
	[Id] [bigint] IDENTITY(101,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_PaymentType_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_T_PaymentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReceiptPayment]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptPayment](
	[Id] [bigint] NOT NULL,
	[PaymentId] [bigint] NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[SalePrice] [decimal](18, 0) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_ReceiptPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Refund]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[InvoiceID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ApprovedUserID] [bigint] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_T_Refund] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceProvider]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProvider](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ContactId] [bigint] NOT NULL,
	[ServiceProviderTypeId] [bigint] NOT NULL,
	[DepartmentId] [bigint] NOT NULL,
	[Speciality] [nvarchar](100) NULL,
	[Code] [nvarchar](50) NULL,
	[AssignedToAllUsers] [bit] NULL,
	[IsReferer] [bit] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_T_ServiceProvider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceProviderType]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProviderType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_T_ServiceProviderType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 5/1/2016 11:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_T_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [PhoneNumber], [Street], [City], [Zip], [Country], [Email], [Fax], [WebSite], [Photo], [IsCompany], [Active]) VALUES (146, N'Muzahidul', N'Islam', N'01833353657', NULL, N'Dhaka', NULL, NULL, N'mailmuzahid@gmail.com', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [PhoneNumber], [Street], [City], [Zip], [Country], [Email], [Fax], [WebSite], [Photo], [IsCompany], [Active]) VALUES (147, N'Rashidul', N'Alam', N'017xxxxxxx', NULL, N'Dhaka', NULL, NULL, N'rashed94@gmail.com', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [PhoneNumber], [Street], [City], [Zip], [Country], [Email], [Fax], [WebSite], [Photo], [IsCompany], [Active]) VALUES (148, N'Kashpia', N'Naharin', N'0171xxxxxx', NULL, N'Feni', NULL, NULL, N'kashpia@gmail.com', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Contact] OFF
SET IDENTITY_INSERT [dbo].[Contacts] ON 

INSERT [dbo].[Contacts] ([Id], [FirstName], [LastName], [PhoneNumber], [Street], [City], [Zip], [Country], [Email], [Fax], [WebSite], [Photo], [IsCompany], [Active]) VALUES (1, N'Muzahidul Islam', NULL, N'01833353657', NULL, N'Dhaka', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Contacts] ([Id], [FirstName], [LastName], [PhoneNumber], [Street], [City], [Zip], [Country], [Email], [Fax], [WebSite], [Photo], [IsCompany], [Active]) VALUES (2, N'Muzahidul Islam', NULL, N'01833353657', NULL, N'Dhaka', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Contacts] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (192, N'ENT', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (193, N'Dermatology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (194, N'Cosmetology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (195, N'Diabetology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (196, N'Gastroentrology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (197, N'Medicine', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (198, N'Nephrology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (199, N'Neurology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (200, N'Nutririon & Dietetics', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (201, N'Gynecology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (202, N'Oncology', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (203, N'Paediatrics', 1)
INSERT [dbo].[Department] ([Id], [Name], [Active]) VALUES (204, N'Urology', 1)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([Id], [Name], [GenericName], [Code], [ItemTypeId], [MedicalTypeId], [ItemCategoryId], [MeasurementUnitId], [SalePrice], [BuyPrice], [ServiceProviderId], [Active]) VALUES (111, N'Napa Extend', N'Paracetamol', N'P001', 29, 55, 35, 54, CAST(15 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, 1)
SET IDENTITY_INSERT [dbo].[Item] OFF
SET IDENTITY_INSERT [dbo].[ItemCategory] ON 

INSERT [dbo].[ItemCategory] ([Id], [Name], [MedicalTypeId], [Active]) VALUES (35, N'CAT-1', 55, 1)
INSERT [dbo].[ItemCategory] ([Id], [Name], [MedicalTypeId], [Active]) VALUES (36, N'Anti-Inflammatory', 55, 1)
INSERT [dbo].[ItemCategory] ([Id], [Name], [MedicalTypeId], [Active]) VALUES (37, N'Antihistamine', 55, 1)
SET IDENTITY_INSERT [dbo].[ItemCategory] OFF
SET IDENTITY_INSERT [dbo].[ItemType] ON 

INSERT [dbo].[ItemType] ([Id], [Name], [Active]) VALUES (29, N'Inventory', 1)
INSERT [dbo].[ItemType] ([Id], [Name], [Active]) VALUES (30, N'Service', 1)
SET IDENTITY_INSERT [dbo].[ItemType] OFF
SET IDENTITY_INSERT [dbo].[MeasurementUnit] ON 

INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Active]) VALUES (54, N'Box', 1)
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Active]) VALUES (55, N'File', 1)
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Active]) VALUES (56, N'Inch', 1)
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Active]) VALUES (57, N'Kg', 1)
SET IDENTITY_INSERT [dbo].[MeasurementUnit] OFF
SET IDENTITY_INSERT [dbo].[MedicalType] ON 

INSERT [dbo].[MedicalType] ([Id], [Name], [Active]) VALUES (55, N'Drug', 1)
INSERT [dbo].[MedicalType] ([Id], [Name], [Active]) VALUES (56, N'Treatment', 1)
INSERT [dbo].[MedicalType] ([Id], [Name], [Active]) VALUES (57, N'Laboratory Test', 1)
INSERT [dbo].[MedicalType] ([Id], [Name], [Active]) VALUES (58, N'Surgery', 1)
INSERT [dbo].[MedicalType] ([Id], [Name], [Active]) VALUES (59, N'Inpatient Accomodation', 1)
SET IDENTITY_INSERT [dbo].[MedicalType] OFF
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([Id], [FirstName], [LastName], [PhoneNumber], [Gender], [BloodGroup], [FatherName], [DOB], [NationalId], [Occupation], [Street], [City], [Zip], [Country], [Email], [Photo], [Active]) VALUES (111, N'Masum', N'Ahammed', N'01713738465', 1, N'O+', N'ABC Ahammed', CAST(N'1980-06-21 00:00:00.000' AS DateTime), N'269321844923', N'Service', N'Mohammadia Housing Society', N'Dhaka', N'1207', N'Bangladesh', N'masum.ahammed@gmail.com', NULL, 1)
SET IDENTITY_INSERT [dbo].[Patient] OFF
SET IDENTITY_INSERT [dbo].[PaymentType] ON 

INSERT [dbo].[PaymentType] ([Id], [Name], [Active]) VALUES (101, N'Invoice', 1)
INSERT [dbo].[PaymentType] ([Id], [Name], [Active]) VALUES (102, N'Receipt', 1)
INSERT [dbo].[PaymentType] ([Id], [Name], [Active]) VALUES (103, N'Advance', 1)
SET IDENTITY_INSERT [dbo].[PaymentType] OFF
SET IDENTITY_INSERT [dbo].[ServiceProvider] ON 

INSERT [dbo].[ServiceProvider] ([Id], [ContactId], [ServiceProviderTypeId], [DepartmentId], [Speciality], [Code], [AssignedToAllUsers], [IsReferer], [Active]) VALUES (18, 146, 52, 192, N'Paediatritian', N'SP1', NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[ServiceProvider] OFF
SET IDENTITY_INSERT [dbo].[ServiceProviderType] ON 

INSERT [dbo].[ServiceProviderType] ([Id], [Name], [Active]) VALUES (52, N'Doctor', 1)
INSERT [dbo].[ServiceProviderType] ([Id], [Name], [Active]) VALUES (53, N'Surgeon', 1)
INSERT [dbo].[ServiceProviderType] ([Id], [Name], [Active]) VALUES (54, N'Anesthetist', 1)
INSERT [dbo].[ServiceProviderType] ([Id], [Name], [Active]) VALUES (55, N'Nurse', 1)
SET IDENTITY_INSERT [dbo].[ServiceProviderType] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Code]    Script Date: 5/1/2016 11:40:00 PM ******/
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [UK_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DrugAdministration] ADD  CONSTRAINT [DF_DrugAdministration_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[DrugDosage] ADD  CONSTRAINT [DF_DrugDosage_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[DrugFrequency] ADD  CONSTRAINT [DF_DrugFrequency_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Inventory_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[InvoicePayment] ADD  CONSTRAINT [DF_T_InvoicePayment_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[InvoiceStatus] ADD  CONSTRAINT [DF_T_InvoiceStatus_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Item_ItemGroup] ADD  CONSTRAINT [DF_Item_ItemGroup_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[ItemDefaults] ADD  CONSTRAINT [DF_ItemDefaults_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[ItemGroup] ADD  CONSTRAINT [DF_ItemGroup_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[ItemReorder] ADD  CONSTRAINT [DF_ItemReorder_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Membership] ADD  CONSTRAINT [DF_Membership_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientAdmission] ADD  CONSTRAINT [DF_PatientAdmission_Id]  DEFAULT ((0)) FOR [Id]
GO
ALTER TABLE [dbo].[PatientAdmission] ADD  CONSTRAINT [DF_T_PatientAdmission_AdmissionDate]  DEFAULT (getdate()) FOR [AdmissionDate]
GO
ALTER TABLE [dbo].[PatientAdmission] ADD  CONSTRAINT [DF_T_PatientAdmission_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientInvoice] ADD  CONSTRAINT [DF_PatientInvoice_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientService] ADD  CONSTRAINT [DF_PatientService_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[ReceiptPayment] ADD  CONSTRAINT [DF_ReceiptPayment_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Refund] ADD  CONSTRAINT [DF_Refund_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[BedOccupancy]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_BedOccupancy] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[BedOccupancy] CHECK CONSTRAINT [FK_Item_T_BedOccupancy]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Item1_T_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Item1_T_Item]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Store_T_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([Id])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Store_T_Store]
GO
ALTER TABLE [dbo].[InvoicePayment]  WITH CHECK ADD  CONSTRAINT [FK_T_InvoicePayment_T_PatientInvoice1] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[PatientInvoice] ([Id])
GO
ALTER TABLE [dbo].[InvoicePayment] CHECK CONSTRAINT [FK_T_InvoicePayment_T_PatientInvoice1]
GO
ALTER TABLE [dbo].[InvoicePayment]  WITH CHECK ADD  CONSTRAINT [FK_T_InvoicePayment_T_Payment] FOREIGN KEY([PaymentID])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[InvoicePayment] CHECK CONSTRAINT [FK_T_InvoicePayment_T_Payment]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ItemCategory] FOREIGN KEY([ItemCategoryId])
REFERENCES [dbo].[ItemCategory] ([Id])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_T_ItemCategory]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ItemType] FOREIGN KEY([ItemTypeId])
REFERENCES [dbo].[ItemType] ([Id])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_T_ItemType]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_MeasurementUnit] FOREIGN KEY([MeasurementUnitId])
REFERENCES [dbo].[MeasurementUnit] ([Id])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_T_MeasurementUnit]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_MedicalType] FOREIGN KEY([MedicalTypeId])
REFERENCES [dbo].[MedicalType] ([Id])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_T_MedicalType]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ServiceProvider] FOREIGN KEY([ServiceProviderId])
REFERENCES [dbo].[ServiceProvider] ([Id])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_T_ServiceProvider]
GO
ALTER TABLE [dbo].[Item_ItemGroup]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[Item_ItemGroup] CHECK CONSTRAINT [FK_Item_T_Item]
GO
ALTER TABLE [dbo].[Item_ItemGroup]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ItemGroup] FOREIGN KEY([ItemGroupID])
REFERENCES [dbo].[ItemGroup] ([Id])
GO
ALTER TABLE [dbo].[Item_ItemGroup] CHECK CONSTRAINT [FK_Item_T_ItemGroup]
GO
ALTER TABLE [dbo].[ItemCategory]  WITH CHECK ADD  CONSTRAINT [FK_ItemCategory_T_MedicalType] FOREIGN KEY([MedicalTypeId])
REFERENCES [dbo].[MedicalType] ([Id])
GO
ALTER TABLE [dbo].[ItemCategory] CHECK CONSTRAINT [FK_ItemCategory_T_MedicalType]
GO
ALTER TABLE [dbo].[ItemDefaults]  WITH CHECK ADD  CONSTRAINT [FK_DrugAdministration_T_ItemDefaults] FOREIGN KEY([AdministrationId])
REFERENCES [dbo].[DrugAdministration] ([Id])
GO
ALTER TABLE [dbo].[ItemDefaults] CHECK CONSTRAINT [FK_DrugAdministration_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults]  WITH CHECK ADD  CONSTRAINT [FK_DrugDosage_T_ItemDefaults] FOREIGN KEY([DosageId])
REFERENCES [dbo].[DrugDosage] ([Id])
GO
ALTER TABLE [dbo].[ItemDefaults] CHECK CONSTRAINT [FK_DrugDosage_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults]  WITH CHECK ADD  CONSTRAINT [FK_DrugFrequency_T_ItemDefaults] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[DrugFrequency] ([Id])
GO
ALTER TABLE [dbo].[ItemDefaults] CHECK CONSTRAINT [FK_DrugFrequency_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemDefaults]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ItemDefaults] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[ItemDefaults] CHECK CONSTRAINT [FK_Item_T_ItemDefaults]
GO
ALTER TABLE [dbo].[ItemReorder]  WITH CHECK ADD  CONSTRAINT [FK_Item_T_ItemReorder] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[ItemReorder] CHECK CONSTRAINT [FK_Item_T_ItemReorder]
GO
ALTER TABLE [dbo].[Membership]  WITH CHECK ADD  CONSTRAINT [FK_Membership_T_Patient] FOREIGN KEY([PatiendId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Membership] CHECK CONSTRAINT [FK_Membership_T_Patient]
GO
ALTER TABLE [dbo].[PatientAdmission]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientAdmission_T_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[PatientAdmission] CHECK CONSTRAINT [FK_T_PatientAdmission_T_Department]
GO
ALTER TABLE [dbo].[PatientAdmission]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider] FOREIGN KEY([ServiceProviderId])
REFERENCES [dbo].[ServiceProvider] ([Id])
GO
ALTER TABLE [dbo].[PatientAdmission] CHECK CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider]
GO
ALTER TABLE [dbo].[PatientAdmission]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider1] FOREIGN KEY([RefererId])
REFERENCES [dbo].[ServiceProvider] ([Id])
GO
ALTER TABLE [dbo].[PatientAdmission] CHECK CONSTRAINT [FK_T_PatientAdmission_T_ServiceProvider1]
GO
ALTER TABLE [dbo].[PatientInvoice]  WITH CHECK ADD  CONSTRAINT [FK_Patient_T_PatientInvoice] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientInvoice] CHECK CONSTRAINT [FK_Patient_T_PatientInvoice]
GO
ALTER TABLE [dbo].[PatientInvoice]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientInvoice_T_InvoiceStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[InvoiceStatus] ([Id])
GO
ALTER TABLE [dbo].[PatientInvoice] CHECK CONSTRAINT [FK_T_PatientInvoice_T_InvoiceStatus]
GO
ALTER TABLE [dbo].[PatientService]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientService_T_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[PatientService] CHECK CONSTRAINT [FK_T_PatientService_T_Item]
GO
ALTER TABLE [dbo].[PatientService]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientService_T_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientService] CHECK CONSTRAINT [FK_T_PatientService_T_Patient]
GO
ALTER TABLE [dbo].[PatientService]  WITH CHECK ADD  CONSTRAINT [FK_T_PatientService_T_PatientInvoice] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[PatientInvoice] ([Id])
GO
ALTER TABLE [dbo].[PatientService] CHECK CONSTRAINT [FK_T_PatientService_T_PatientInvoice]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_T_Payment_T_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_T_Payment_T_Patient]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_T_Payment_T_PaymentType] FOREIGN KEY([PaymentTypeId])
REFERENCES [dbo].[PaymentType] ([Id])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_T_Payment_T_PaymentType]
GO
ALTER TABLE [dbo].[ReceiptPayment]  WITH CHECK ADD  CONSTRAINT [FK_T_ReceiptPayment_T_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([Id])
GO
ALTER TABLE [dbo].[ReceiptPayment] CHECK CONSTRAINT [FK_T_ReceiptPayment_T_Item]
GO
ALTER TABLE [dbo].[ReceiptPayment]  WITH CHECK ADD  CONSTRAINT [FK_T_ReceiptPayment_T_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[ReceiptPayment] CHECK CONSTRAINT [FK_T_ReceiptPayment_T_Payment]
GO
ALTER TABLE [dbo].[Refund]  WITH CHECK ADD  CONSTRAINT [FK_T_Refund_T_PatientInvoice] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[PatientInvoice] ([Id])
GO
ALTER TABLE [dbo].[Refund] CHECK CONSTRAINT [FK_T_Refund_T_PatientInvoice]
GO
ALTER TABLE [dbo].[ServiceProvider]  WITH CHECK ADD  CONSTRAINT [FK_Contact_ServiceProvider] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[ServiceProvider] CHECK CONSTRAINT [FK_Contact_ServiceProvider]
GO
ALTER TABLE [dbo].[ServiceProvider]  WITH CHECK ADD  CONSTRAINT [FK_Department_ServiceProvider] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[ServiceProvider] CHECK CONSTRAINT [FK_Department_ServiceProvider]
GO
ALTER TABLE [dbo].[ServiceProvider]  WITH CHECK ADD  CONSTRAINT [FK_ServiceProviderType_ServiceProvider] FOREIGN KEY([ServiceProviderTypeId])
REFERENCES [dbo].[ServiceProviderType] ([Id])
GO
ALTER TABLE [dbo].[ServiceProvider] CHECK CONSTRAINT [FK_ServiceProviderType_ServiceProvider]
GO
