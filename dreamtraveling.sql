USE [master]
GO
/****** Object:  Database [TheDreamTraveling]    Script Date: 6/22/2020 2:06:47 AM ******/
CREATE DATABASE [TheDreamTraveling]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TheDreamTraveling', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TheDreamTraveling.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TheDreamTraveling_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TheDreamTraveling_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TheDreamTraveling] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TheDreamTraveling].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TheDreamTraveling] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET ARITHABORT OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TheDreamTraveling] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TheDreamTraveling] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TheDreamTraveling] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TheDreamTraveling] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TheDreamTraveling] SET  MULTI_USER 
GO
ALTER DATABASE [TheDreamTraveling] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TheDreamTraveling] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TheDreamTraveling] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TheDreamTraveling] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TheDreamTraveling] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TheDreamTraveling] SET QUERY_STORE = OFF
GO
USE [TheDreamTraveling]
GO
/****** Object:  Table [dbo].[tbl_Booking]    Script Date: 6/22/2020 2:06:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Booking](
	[bookingID] [int] IDENTITY(1,1) NOT NULL,
	[totalPrice] [float] NULL,
	[userID] [varchar](50) NULL,
	[discountID] [varchar](20) NULL,
	[orderDateTime] [datetime] NULL,
	[expiryDateTime] [datetime] NULL,
	[statusID] [int] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BookingDetail]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BookingDetail](
	[detailID] [int] IDENTITY(1,1) NOT NULL,
	[tourID] [int] NULL,
	[bookingID] [int] NULL,
	[priceOfTour] [int] NULL,
	[amount] [int] NULL,
 CONSTRAINT [PK_BookingDetail_1] PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Discount]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Discount](
	[discountID] [varchar](20) NOT NULL,
	[discount] [varchar](50) NULL,
	[expiryDate] [date] NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[discountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Role]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Role](
	[roleID] [int] NOT NULL,
	[roleName] [varchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Status]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Status](
	[statusID] [int] NOT NULL,
	[statusName] [varchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Tour]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Tour](
	[tourID] [int] IDENTITY(1,1) NOT NULL,
	[tourName] [varchar](50) NULL,
	[image] [varchar](50) NULL,
	[price] [int] NULL,
	[fromDate] [date] NULL,
	[toDate] [date] NULL,
	[place] [varchar](50) NULL,
	[statusID] [int] NULL,
	[amount] [int] NULL,
	[dateImport] [date] NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[tourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 6/22/2020 2:06:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_User](
	[userID] [varchar](50) NOT NULL,
	[password] [varchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[roleID] [int] NULL,
	[facebookID] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_Booking] ON 

INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (1, 10000, N'user', N'0', CAST(N'2020-06-11T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (2, 8000, N'user', N'0', CAST(N'2020-06-11T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (3, 7000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (4, 9000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (5, 9000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (6, 8000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (8, 2000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (9, 3000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (10, 20000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (11, 30000, N'user', N'0', CAST(N'2020-06-12T00:00:00.000' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
INSERT [dbo].[tbl_Booking] ([bookingID], [totalPrice], [userID], [discountID], [orderDateTime], [expiryDateTime], [statusID]) VALUES (12, 12000, N'user', N'0', CAST(N'2020-06-12T23:18:46.813' AS DateTime), CAST(N'2020-06-13T23:50:35.000' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[tbl_Booking] OFF
SET IDENTITY_INSERT [dbo].[tbl_BookingDetail] ON 

INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (1, 7, 3, 10000, 5)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (2, 6, 4, 6000, 3)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (3, 7, 5, 4000, 2)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (4, 6, 6, 8000, 4)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (5, 7, 6, 2000, 1)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (6, 7, 8, 2000, 1)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (7, 2, 9, 3000, 1)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (8, 7, 10, 20000, 10)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (9, 2, 11, 30000, 10)
INSERT [dbo].[tbl_BookingDetail] ([detailID], [tourID], [bookingID], [priceOfTour], [amount]) VALUES (10, 2, 12, 12000, 4)
SET IDENTITY_INSERT [dbo].[tbl_BookingDetail] OFF
INSERT [dbo].[tbl_Discount] ([discountID], [discount], [expiryDate]) VALUES (N'0', N'Do not use discount codes', CAST(N'2200-07-09' AS Date))
INSERT [dbo].[tbl_Discount] ([discountID], [discount], [expiryDate]) VALUES (N'10', N'discount 10%', CAST(N'2020-07-09' AS Date))
INSERT [dbo].[tbl_Discount] ([discountID], [discount], [expiryDate]) VALUES (N'20', N'discount20%', CAST(N'2020-07-09' AS Date))
INSERT [dbo].[tbl_Discount] ([discountID], [discount], [expiryDate]) VALUES (N'30', N'discount30%', CAST(N'2020-07-09' AS Date))
INSERT [dbo].[tbl_Role] ([roleID], [roleName]) VALUES (1, N'admin')
INSERT [dbo].[tbl_Role] ([roleID], [roleName]) VALUES (2, N'user')
INSERT [dbo].[tbl_Status] ([statusID], [statusName]) VALUES (1, N'active')
INSERT [dbo].[tbl_Status] ([statusID], [statusName]) VALUES (2, N'expiry')
INSERT [dbo].[tbl_Status] ([statusID], [statusName]) VALUES (3, N'pending')
INSERT [dbo].[tbl_Status] ([statusID], [statusName]) VALUES (4, N'paid')
SET IDENTITY_INSERT [dbo].[tbl_Tour] ON 

INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (1, N'Thien Nhien', N'phuquoc.jpg', 2000, CAST(N'2020-07-14' AS Date), CAST(N'2020-07-24' AS Date), N'Phu Quoc', 1, 8, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (2, N'Hoang Da', N'phuquoc2.jpg', 3000, CAST(N'2020-07-15' AS Date), CAST(N'2020-07-25' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (3, N'Phu Quoc', N'phuquoc3.jpg', 2000, CAST(N'2020-07-16' AS Date), CAST(N'2020-07-25' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (4, N'Phu Quoc 3', N'phuquoc4.jpg', 2000, CAST(N'2020-07-17' AS Date), CAST(N'2020-07-27' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (5, N'Phu Quoc 4', N'phuquoc5.jpg', 2000, CAST(N'2020-07-13' AS Date), CAST(N'2020-07-17' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (6, N'Phu Quoc 5', N'phuquoc6.jpg', 2000, CAST(N'2020-07-12' AS Date), CAST(N'2020-07-19' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (7, N'Phu Quoc 6', N'phuquoc7.jpg', 2000, CAST(N'2020-07-11' AS Date), CAST(N'2020-07-21' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (8, N'Phu Quoc 8', N'phuquoc8.jpg', 2000, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-15' AS Date), N'Phu Quoc', 1, 9, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (9, N'Phu Quoc 7', N'phuquoc9.jpg', 2000, CAST(N'2020-07-20' AS Date), CAST(N'2020-07-24' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (10, N'Phu Quoc 9', N'phuquoc8.jpg', 2000, CAST(N'2020-07-21' AS Date), CAST(N'2020-07-29' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (11, N'Bien Phu Quoc', N'phuquoc2.jpg', 3000, CAST(N'2020-07-22' AS Date), CAST(N'2020-07-30' AS Date), N'Phu Quoc', 1, 5, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (12, N'Phu Quoc 10', N'phuquoc6.jpg', 2000, CAST(N'2020-08-15' AS Date), CAST(N'2020-09-03' AS Date), N'Phu Quoc', 1, 9, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (15, N'Phu Quoc 21', N'phuquoc5.jpg', 2000, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-08' AS Date), N'Phu Quoc', 1, 0, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (16, N'Phu Quoc 14', N'phuquoc8.jpg', 2000, CAST(N'2020-07-03' AS Date), CAST(N'2020-07-08' AS Date), N'Phu Quoc', 1, 0, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (17, N'Phu Quoc 15', N'phuquoc7.jpg', 2000, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-08' AS Date), N'Phu Quoc', 1, 3, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (18, N'Phu Quoc 16', N'phuquoc9.jpg', 2000, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-09' AS Date), N'Phu Quoc', 1, 0, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (19, N'Phu Quoc 17', N'phuquoc6.jpg', 2000, CAST(N'2020-07-06' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 5, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (20, N'Phu Quoc 18', N'phuquoc6.jpg', 2000, CAST(N'2020-07-07' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (21, N'Phu Quoc 19', N'phuquoc9.jpg', 2000, CAST(N'2020-07-08' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (22, N'Phu Quoc 20', N'phuquoc8.jpg', 2000, CAST(N'2020-07-09' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 6, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (23, N'Phu Quoc 22', N'phuquoc7.jpg', 2000, CAST(N'2020-08-01' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 9, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (24, N'Phu Quoc 23', N'phuquoc6.jpg', 2000, CAST(N'2020-08-02' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (25, N'Phu Quoc 24', N'phuquoc5.jpg', 2000, CAST(N'2020-08-03' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 9, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (26, N'Phu Quoc 25', N'phuquoc4.jpg', 2000, CAST(N'2020-08-04' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (27, N'Phu Quoc 26', N'phuquoc.jpg', 2000, CAST(N'2020-08-05' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (28, N'Phu Quoc 27', N'phuquoc3.jpg', 2000, CAST(N'2020-08-06' AS Date), CAST(N'2020-08-08' AS Date), N'Phu Quoc', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (29, N'Bien xanh', N'vungtau.jpg', 3000, CAST(N'2020-08-08' AS Date), CAST(N'2020-08-24' AS Date), N'Vung Tau', 1, 10, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (31, N'Thien Duong Sapa', N'itthoi.png', 1234, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-11' AS Date), N'Sapa', 1, 105, CAST(N'2020-06-06' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (35, N'Sapaaa', N'anhtest.jpg', 1234, CAST(N'2020-06-27' AS Date), CAST(N'2020-06-29' AS Date), N'Sapa', 1, 103, CAST(N'2020-06-19' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (36, N'Sapaaa', N'anhtest.jpg', 1234, CAST(N'2020-06-27' AS Date), CAST(N'2020-06-30' AS Date), N'Sapa', 1, 119, CAST(N'2020-06-20' AS Date))
INSERT [dbo].[tbl_Tour] ([tourID], [tourName], [image], [price], [fromDate], [toDate], [place], [statusID], [amount], [dateImport]) VALUES (37, N'Sapa ', N'abbc.png', 2000, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-27' AS Date), N'Sapa', 1, 100, CAST(N'2020-06-22' AS Date))
SET IDENTITY_INSERT [dbo].[tbl_Tour] OFF
INSERT [dbo].[tbl_User] ([userID], [password], [name], [roleID], [facebookID]) VALUES (N'admin', N'1', N'NguyenNST', 1, NULL)
INSERT [dbo].[tbl_User] ([userID], [password], [name], [roleID], [facebookID]) VALUES (N'nguyennst', N'1', N'Nguyen NST', 2, NULL)
INSERT [dbo].[tbl_User] ([userID], [password], [name], [roleID], [facebookID]) VALUES (N'user', N'1', N'UserDemo', 2, NULL)
ALTER TABLE [dbo].[tbl_Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_User] FOREIGN KEY([userID])
REFERENCES [dbo].[tbl_User] ([userID])
GO
ALTER TABLE [dbo].[tbl_Booking] CHECK CONSTRAINT [FK_Booking_User]
GO
ALTER TABLE [dbo].[tbl_Booking]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Booking_tbl_DiscountOfUser] FOREIGN KEY([discountID])
REFERENCES [dbo].[tbl_Discount] ([discountID])
GO
ALTER TABLE [dbo].[tbl_Booking] CHECK CONSTRAINT [FK_tbl_Booking_tbl_DiscountOfUser]
GO
ALTER TABLE [dbo].[tbl_Booking]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Booking_tbl_Status] FOREIGN KEY([statusID])
REFERENCES [dbo].[tbl_Status] ([statusID])
GO
ALTER TABLE [dbo].[tbl_Booking] CHECK CONSTRAINT [FK_tbl_Booking_tbl_Status]
GO
ALTER TABLE [dbo].[tbl_BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Booking] FOREIGN KEY([bookingID])
REFERENCES [dbo].[tbl_Booking] ([bookingID])
GO
ALTER TABLE [dbo].[tbl_BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Booking]
GO
ALTER TABLE [dbo].[tbl_BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Tour] FOREIGN KEY([tourID])
REFERENCES [dbo].[tbl_Tour] ([tourID])
GO
ALTER TABLE [dbo].[tbl_BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Tour]
GO
ALTER TABLE [dbo].[tbl_Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_Status] FOREIGN KEY([statusID])
REFERENCES [dbo].[tbl_Status] ([statusID])
GO
ALTER TABLE [dbo].[tbl_Tour] CHECK CONSTRAINT [FK_Tour_Status]
GO
ALTER TABLE [dbo].[tbl_User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([roleID])
REFERENCES [dbo].[tbl_Role] ([roleID])
GO
ALTER TABLE [dbo].[tbl_User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [TheDreamTraveling] SET  READ_WRITE 
GO
