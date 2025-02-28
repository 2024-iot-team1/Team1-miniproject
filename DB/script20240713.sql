USE [master]
GO
/****** Object:  Database [AutoSortingDB]    Script Date: 2024-07-13 오후 6:08:05 ******/
CREATE DATABASE [AutoSortingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AutoSortingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AutoSortingDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AutoSortingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AutoSortingDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AutoSortingDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AutoSortingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AutoSortingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AutoSortingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AutoSortingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AutoSortingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AutoSortingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [AutoSortingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AutoSortingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AutoSortingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AutoSortingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AutoSortingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AutoSortingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AutoSortingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AutoSortingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AutoSortingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AutoSortingDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AutoSortingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AutoSortingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AutoSortingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AutoSortingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AutoSortingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AutoSortingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AutoSortingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AutoSortingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [AutoSortingDB] SET  MULTI_USER 
GO
ALTER DATABASE [AutoSortingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AutoSortingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AutoSortingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AutoSortingDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AutoSortingDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AutoSortingDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AutoSortingDB', N'ON'
GO
ALTER DATABASE [AutoSortingDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [AutoSortingDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AutoSortingDB]
GO
/****** Object:  Table [dbo].[Classification]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classification](
	[ClassificationCode] [int] NOT NULL,
	[ClassificationName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Classification] PRIMARY KEY CLUSTERED 
(
	[ClassificationCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConnectLog]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectLog](
	[ConnectIdx] [int] IDENTITY(1,1) NOT NULL,
	[UserIdx] [int] NOT NULL,
	[ConnectDT] [datetime] NOT NULL,
 CONSTRAINT [PK_ConnectLog] PRIMARY KEY CLUSTERED 
(
	[ConnectIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[DeliveryNum] [int] NOT NULL,
	[OrderNum] [int] NOT NULL,
	[DeliveryStatus] [nvarchar](50) NOT NULL,
	[StartDT] [datetime] NULL,
	[CompleteDT] [datetime] NULL,
	[Destination] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED 
(
	[DeliveryNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryNum] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [int] NOT NULL,
	[SalesRate] [int] NOT NULL,
	[Stock] [int] NOT NULL,
	[SafeStock] [int] NULL,
	[Procurement] [int] NULL,
 CONSTRAINT [PK_Inventory_1] PRIMARY KEY CLUSTERED 
(
	[InventoryNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderNum] [int] NOT NULL,
	[InventoryNum] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderDT] [datetime] NOT NULL,
	[CancelOrNot] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Orders_1] PRIMARY KEY CLUSTERED 
(
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductCode] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Price] [int] NOT NULL,
	[Classification] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserIdx] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[ID] [nvarchar](50) NOT NULL,
	[PASSWORD] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStatus]    Script Date: 2024-07-13 오후 6:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStatus](
	[WorkNum] [int] IDENTITY(1,1) NOT NULL,
	[OrderNum] [int] NOT NULL,
	[DeliveryNum] [int] NOT NULL,
	[ProcessDT] [datetime] NOT NULL,
	[CompleteOrNot] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_WorkStatus] PRIMARY KEY CLUSTERED 
(
	[WorkNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (1, N'신선식품')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (2, N'가공식품')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (3, N'건강식품')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (4, N'의류')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (5, N'생활용품')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (6, N'가전제품')
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (7, N'문구')
GO
SET IDENTITY_INSERT [dbo].[ConnectLog] ON 

INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (1, 1, CAST(N'2024-07-13T17:25:26.817' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (2, 1, CAST(N'2024-07-13T17:32:29.033' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (3, 2, CAST(N'2024-07-13T17:37:50.590' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (4, 1, CAST(N'2024-07-13T17:40:29.663' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (5, 2, CAST(N'2024-07-13T17:40:52.367' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (6, 2, CAST(N'2024-07-13T17:57:04.623' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (7, 2, CAST(N'2024-07-13T18:00:00.237' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (8, 2, CAST(N'2024-07-13T18:00:25.483' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (9, 1, CAST(N'2024-07-13T18:01:43.383' AS DateTime))
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (10, 2, CAST(N'2024-07-13T18:02:29.350' AS DateTime))
SET IDENTITY_INSERT [dbo].[ConnectLog] OFF
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (1, 1112112, N'배송완료', CAST(N'2024-07-02T09:11:12.000' AS DateTime), CAST(N'2024-07-02T17:21:11.000' AS DateTime), N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (2, 1112113, N'배송중', CAST(N'2024-07-12T15:43:43.767' AS DateTime), CAST(N'2024-07-02T18:01:21.000' AS DateTime), N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3, 1112114, N'배송중', CAST(N'2024-07-13T16:54:20.130' AS DateTime), CAST(N'2024-07-02T18:39:42.000' AS DateTime), N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4, 1112115, N'배송중', CAST(N'2024-07-13T16:55:10.610' AS DateTime), NULL, N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5, 1112116, N'배송중', CAST(N'2024-07-13T16:52:31.133' AS DateTime), NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6, 1112117, N'배송중', CAST(N'2024-07-13T16:52:47.323' AS DateTime), NULL, N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7, 1112118, N'배송중', CAST(N'2024-07-13T17:02:38.720' AS DateTime), NULL, N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (8, 1112119, N'배송준비중', NULL, NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (9, 1112120, N'배송중', CAST(N'2024-07-13T17:02:21.260' AS DateTime), NULL, N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (10, 1112121, N'배송준비중', NULL, NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (11, 1112122, N'배송준비중', NULL, NULL, N'서울')
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (1, 10001, 150, 300, 200, 50)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (2, 10002, 300, 400, 500, 400)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (3, 10003, 100, 200, 200, 100)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (4, 10004, 250, 350, 400, 300)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (5, 10005, 150, 150, 300, 250)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (11, 10006, 0, 50, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112112, 1, 1, CAST(N'2024-07-01T16:00:01.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112113, 2, 2, CAST(N'2024-07-01T16:30:45.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112114, 1, 1, CAST(N'2024-07-01T16:48:11.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112115, 3, 2, CAST(N'2024-07-02T17:02:21.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112116, 4, 4, CAST(N'2021-07-02T18:11:23.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112117, 5, 2, CAST(N'2024-07-08T10:12:22.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112118, 2, 1, CAST(N'2024-07-08T11:00:04.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112119, 4, 2, CAST(N'2024-07-08T11:20:13.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112120, 2, 1, CAST(N'2024-07-09T09:01:22.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112121, 3, 1, CAST(N'2024-07-09T18:24:11.000' AS DateTime), N'N')
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (1112122, 5, 5, CAST(N'2024-07-09T20:20:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10001, N'투쁠등심 200g', 50000, 1)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10002, N'크록스', 32000, 4)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10003, N'밴딩 반바지', 28500, 4)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10004, N'5+5 타월', 37000, 5)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10005, N'비타민', 100000, 3)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10006, N'tv', 15000000, 6)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserIdx], [UserName], [ID], [PASSWORD]) VALUES (1, N'관리자', N'admin', N'admin')
INSERT [dbo].[Users] ([UserIdx], [UserName], [ID], [PASSWORD]) VALUES (2, N'user01', N'asdf', N'1234')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkStatus] ON 

INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (1, 1112120, 9, CAST(N'2024-07-13T16:48:58.817' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (2, 1112120, 9, CAST(N'2024-07-13T16:49:25.067' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (3, 1112116, 5, CAST(N'2024-07-13T16:49:37.033' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (4, 1112114, 3, CAST(N'2024-07-13T16:50:45.687' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (5, 1112114, 3, CAST(N'2024-07-13T16:51:03.883' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (6, 1112115, 4, CAST(N'2024-07-13T16:52:19.257' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (7, 1112116, 5, CAST(N'2024-07-13T16:52:31.133' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (8, 1112117, 6, CAST(N'2024-07-13T16:52:47.323' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (9, 1112114, 3, CAST(N'2024-07-13T16:53:13.443' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (10, 1112114, 3, CAST(N'2024-07-13T16:54:03.260' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (11, 1112114, 3, CAST(N'2024-07-13T16:54:20.130' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (12, 1112115, 4, CAST(N'2024-07-13T16:54:41.453' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (13, 1112115, 4, CAST(N'2024-07-13T16:55:10.610' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (14, 1112120, 9, CAST(N'2024-07-13T17:02:21.260' AS DateTime), N'Y')
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (15, 1112118, 7, CAST(N'2024-07-13T17:02:38.720' AS DateTime), N'Y')
SET IDENTITY_INSERT [dbo].[WorkStatus] OFF
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Inventory_SalesRate]  DEFAULT ((0)) FOR [SalesRate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_CancelOrNot]  DEFAULT ('N') FOR [CancelOrNot]
GO
ALTER TABLE [dbo].[ConnectLog]  WITH CHECK ADD  CONSTRAINT [FK_ConnectLog_Users] FOREIGN KEY([UserIdx])
REFERENCES [dbo].[Users] ([UserIdx])
GO
ALTER TABLE [dbo].[ConnectLog] CHECK CONSTRAINT [FK_ConnectLog_Users]
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Orders] FOREIGN KEY([OrderNum])
REFERENCES [dbo].[Orders] ([OrderNum])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Orders]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([ProductCode])
REFERENCES [dbo].[Product] ([ProductCode])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Inventory] FOREIGN KEY([InventoryNum])
REFERENCES [dbo].[Inventory] ([InventoryNum])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Inventory]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Classification] FOREIGN KEY([Classification])
REFERENCES [dbo].[Classification] ([ClassificationCode])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Classification]
GO
ALTER TABLE [dbo].[WorkStatus]  WITH CHECK ADD  CONSTRAINT [FK_WorkStatus_Delivery] FOREIGN KEY([DeliveryNum])
REFERENCES [dbo].[Delivery] ([DeliveryNum])
GO
ALTER TABLE [dbo].[WorkStatus] CHECK CONSTRAINT [FK_WorkStatus_Delivery]
GO
ALTER TABLE [dbo].[WorkStatus]  WITH CHECK ADD  CONSTRAINT [FK_WorkStatus_Orders] FOREIGN KEY([OrderNum])
REFERENCES [dbo].[Orders] ([OrderNum])
GO
ALTER TABLE [dbo].[WorkStatus] CHECK CONSTRAINT [FK_WorkStatus_Orders]
GO
USE [master]
GO
ALTER DATABASE [AutoSortingDB] SET  READ_WRITE 
GO
