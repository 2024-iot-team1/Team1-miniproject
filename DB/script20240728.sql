/****** Object:  Table [dbo].[Classification]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[ConnectLog]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[Delivery]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
/****** Object:  Table [dbo].[WorkStatus]    Script Date: 2024-07-28 오후 5:32:58 ******/
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
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (2, N'가공식품')
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (3, N'건강식품')
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (4, N'의류')
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (5, N'생활용품')
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (6, N'가전제품')
GO
INSERT [dbo].[Classification] ([ClassificationCode], [ClassificationName]) VALUES (7, N'문구')
GO
SET IDENTITY_INSERT [dbo].[ConnectLog] ON 
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (1, 1, CAST(N'2024-07-28T17:01:45.917' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (2, 1, CAST(N'2024-07-28T17:16:58.670' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (3, 1, CAST(N'2024-07-28T17:18:47.130' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (4, 1, CAST(N'2024-07-28T17:23:58.020' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (5, 1, CAST(N'2024-07-28T17:25:29.733' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (6, 1, CAST(N'2024-07-28T17:25:53.020' AS DateTime))
GO
INSERT [dbo].[ConnectLog] ([ConnectIdx], [UserIdx], [ConnectDT]) VALUES (7, 1, CAST(N'2024-07-28T17:27:55.063' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ConnectLog] OFF
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000001, 2024030101, N'배송완료', CAST(N'2024-03-01T10:00:00.000' AS DateTime), CAST(N'2024-03-02T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000002, 2024030102, N'배송완료', CAST(N'2024-03-02T11:00:00.000' AS DateTime), CAST(N'2024-03-03T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000003, 2024030103, N'배송완료', CAST(N'2024-03-03T12:00:00.000' AS DateTime), CAST(N'2024-03-04T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000004, 2024030104, N'배송완료', CAST(N'2024-03-04T13:00:00.000' AS DateTime), CAST(N'2024-03-05T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000005, 2024030105, N'배송완료', CAST(N'2024-03-05T14:00:00.000' AS DateTime), CAST(N'2024-03-06T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000006, 2024030106, N'배송완료', CAST(N'2024-03-06T15:00:00.000' AS DateTime), CAST(N'2024-03-07T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000007, 2024030107, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000008, 2024030108, N'배송완료', CAST(N'2024-03-08T17:00:00.000' AS DateTime), CAST(N'2024-03-09T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000009, 2024030109, N'배송완료', CAST(N'2024-03-09T18:00:00.000' AS DateTime), CAST(N'2024-03-10T23:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000010, 2024030110, N'배송완료', CAST(N'2024-03-10T19:00:00.000' AS DateTime), CAST(N'2024-03-11T10:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000011, 2024030111, N'배송완료', CAST(N'2024-03-11T20:00:00.000' AS DateTime), CAST(N'2024-03-12T11:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000012, 2024030112, N'배송완료', CAST(N'2024-03-12T21:00:00.000' AS DateTime), CAST(N'2024-03-13T12:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000013, 2024030113, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000014, 2024030114, N'배송완료', CAST(N'2024-03-14T23:00:00.000' AS DateTime), CAST(N'2024-03-15T14:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000015, 2024030115, N'배송완료', CAST(N'2024-03-15T09:00:00.000' AS DateTime), CAST(N'2024-03-16T15:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000016, 2024030116, N'배송완료', CAST(N'2024-03-16T10:00:00.000' AS DateTime), CAST(N'2024-03-17T16:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000017, 2024030117, N'배송완료', CAST(N'2024-03-17T11:00:00.000' AS DateTime), CAST(N'2024-03-18T17:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000018, 2024030118, N'배송완료', CAST(N'2024-03-18T12:00:00.000' AS DateTime), CAST(N'2024-03-19T18:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000019, 2024030119, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000020, 2024030120, N'배송완료', CAST(N'2024-03-20T14:00:00.000' AS DateTime), CAST(N'2024-03-21T20:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000021, 2024030121, N'배송완료', CAST(N'2024-03-21T15:00:00.000' AS DateTime), CAST(N'2024-03-22T21:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000022, 2024030122, N'배송완료', CAST(N'2024-03-22T16:00:00.000' AS DateTime), CAST(N'2024-03-23T22:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000023, 2024030123, N'배송완료', CAST(N'2024-03-23T17:00:00.000' AS DateTime), CAST(N'2024-03-24T23:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000024, 2024030124, N'배송완료', CAST(N'2024-03-24T18:00:00.000' AS DateTime), CAST(N'2024-03-25T10:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000025, 2024030125, N'배송완료', CAST(N'2024-03-25T19:00:00.000' AS DateTime), CAST(N'2024-03-26T11:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000026, 2024030126, N'배송완료', CAST(N'2024-03-26T20:00:00.000' AS DateTime), CAST(N'2024-03-27T12:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000027, 2024030127, N'배송완료', CAST(N'2024-03-27T21:00:00.000' AS DateTime), CAST(N'2024-03-28T13:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000028, 2024030128, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000029, 2024030129, N'배송완료', CAST(N'2024-03-29T23:00:00.000' AS DateTime), CAST(N'2024-03-30T15:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000030, 2024030130, N'배송완료', CAST(N'2024-03-30T09:00:00.000' AS DateTime), CAST(N'2024-03-31T16:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000031, 2024030131, N'배송완료', CAST(N'2024-03-31T10:00:00.000' AS DateTime), CAST(N'2024-04-01T17:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000032, 2024030132, N'배송완료', CAST(N'2024-03-31T11:00:00.000' AS DateTime), CAST(N'2024-04-01T18:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000033, 2024030133, N'배송완료', CAST(N'2024-03-31T12:00:00.000' AS DateTime), CAST(N'2024-04-01T19:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000034, 2024030134, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000035, 2024030135, N'배송완료', CAST(N'2024-03-31T14:00:00.000' AS DateTime), CAST(N'2024-04-01T21:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000036, 2024030136, N'배송완료', CAST(N'2024-03-31T15:00:00.000' AS DateTime), CAST(N'2024-04-01T22:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000037, 2024030137, N'배송완료', CAST(N'2024-03-31T16:00:00.000' AS DateTime), CAST(N'2024-04-01T23:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000038, 2024030138, N'배송완료', CAST(N'2024-03-31T17:00:00.000' AS DateTime), CAST(N'2024-04-01T10:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000039, 2024030139, N'배송완료', CAST(N'2024-03-31T18:00:00.000' AS DateTime), CAST(N'2024-04-01T11:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000040, 2024030140, N'배송완료', CAST(N'2024-03-31T19:00:00.000' AS DateTime), CAST(N'2024-04-01T12:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000041, 2024030141, N'배송완료', CAST(N'2024-03-31T20:00:00.000' AS DateTime), CAST(N'2024-04-01T13:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000042, 2024030142, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000043, 2024030143, N'배송완료', CAST(N'2024-03-31T22:00:00.000' AS DateTime), CAST(N'2024-04-01T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000044, 2024030144, N'배송완료', CAST(N'2024-03-31T23:00:00.000' AS DateTime), CAST(N'2024-04-01T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000045, 2024030145, N'배송완료', CAST(N'2024-03-31T09:00:00.000' AS DateTime), CAST(N'2024-04-01T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000046, 2024030146, N'배송완료', CAST(N'2024-03-31T10:00:00.000' AS DateTime), CAST(N'2024-04-01T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000047, 2024030147, N'배송완료', CAST(N'2024-03-31T11:00:00.000' AS DateTime), CAST(N'2024-04-01T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000048, 2024030148, N'배송완료', CAST(N'2024-03-31T12:00:00.000' AS DateTime), CAST(N'2024-04-01T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000049, 2024030149, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3000050, 2024030150, N'배송완료', CAST(N'2024-03-31T14:00:00.000' AS DateTime), CAST(N'2024-04-01T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000001, 2024040101, N'배송완료', CAST(N'2024-04-01T10:00:00.000' AS DateTime), CAST(N'2024-04-02T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000002, 2024040102, N'배송완료', CAST(N'2024-04-02T11:00:00.000' AS DateTime), CAST(N'2024-04-03T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000003, 2024040103, N'배송완료', CAST(N'2024-04-03T12:00:00.000' AS DateTime), CAST(N'2024-04-04T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000004, 2024040104, N'배송완료', CAST(N'2024-04-04T13:00:00.000' AS DateTime), CAST(N'2024-04-05T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000005, 2024040105, N'배송완료', CAST(N'2024-04-05T14:00:00.000' AS DateTime), CAST(N'2024-04-06T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000006, 2024040106, N'배송완료', CAST(N'2024-04-06T15:00:00.000' AS DateTime), CAST(N'2024-04-07T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000007, 2024040107, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000008, 2024040108, N'배송완료', CAST(N'2024-04-08T17:00:00.000' AS DateTime), CAST(N'2024-04-09T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000009, 2024040109, N'배송완료', CAST(N'2024-04-09T18:00:00.000' AS DateTime), CAST(N'2024-04-10T23:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000010, 2024040110, N'배송완료', CAST(N'2024-04-10T19:00:00.000' AS DateTime), CAST(N'2024-04-11T10:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000011, 2024040111, N'배송완료', CAST(N'2024-04-11T20:00:00.000' AS DateTime), CAST(N'2024-04-12T11:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000012, 2024040112, N'배송완료', CAST(N'2024-04-12T21:00:00.000' AS DateTime), CAST(N'2024-04-13T12:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000013, 2024040113, N'배송완료', CAST(N'2024-04-13T22:00:00.000' AS DateTime), CAST(N'2024-04-14T13:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000014, 2024040114, N'배송완료', CAST(N'2024-04-14T23:00:00.000' AS DateTime), CAST(N'2024-04-15T14:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000015, 2024040115, N'배송완료', CAST(N'2024-04-15T09:00:00.000' AS DateTime), CAST(N'2024-04-16T15:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000016, 2024040116, N'배송완료', CAST(N'2024-04-16T10:00:00.000' AS DateTime), CAST(N'2024-04-17T16:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000017, 2024040117, N'배송완료', CAST(N'2024-04-17T11:00:00.000' AS DateTime), CAST(N'2024-04-18T17:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000018, 2024040118, N'배송완료', CAST(N'2024-04-18T12:00:00.000' AS DateTime), CAST(N'2024-04-19T18:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000019, 2024040119, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000020, 2024040120, N'배송완료', CAST(N'2024-04-20T14:00:00.000' AS DateTime), CAST(N'2024-04-21T20:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000021, 2024040121, N'배송완료', CAST(N'2024-04-21T15:00:00.000' AS DateTime), CAST(N'2024-04-22T21:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000022, 2024040122, N'배송완료', CAST(N'2024-04-22T16:00:00.000' AS DateTime), CAST(N'2024-04-23T22:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000023, 2024040123, N'배송완료', CAST(N'2024-04-23T17:00:00.000' AS DateTime), CAST(N'2024-04-24T23:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000024, 2024040124, N'배송완료', CAST(N'2024-04-24T18:00:00.000' AS DateTime), CAST(N'2024-04-25T10:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000025, 2024040125, N'배송완료', CAST(N'2024-04-25T19:00:00.000' AS DateTime), CAST(N'2024-04-26T11:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000026, 2024040126, N'배송완료', CAST(N'2024-04-26T20:00:00.000' AS DateTime), CAST(N'2024-04-27T12:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000027, 2024040127, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000028, 2024040128, N'배송완료', CAST(N'2024-04-28T22:00:00.000' AS DateTime), CAST(N'2024-04-29T14:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000029, 2024040129, N'배송완료', CAST(N'2024-04-29T23:00:00.000' AS DateTime), CAST(N'2024-04-30T15:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000030, 2024040130, N'배송완료', CAST(N'2024-04-30T09:00:00.000' AS DateTime), CAST(N'2024-05-01T16:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000031, 2024040131, N'배송완료', CAST(N'2024-04-30T10:00:00.000' AS DateTime), CAST(N'2024-05-01T17:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000032, 2024040132, N'배송완료', CAST(N'2024-04-30T11:00:00.000' AS DateTime), CAST(N'2024-05-01T18:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000033, 2024040133, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000034, 2024040134, N'배송완료', CAST(N'2024-04-30T13:00:00.000' AS DateTime), CAST(N'2024-05-01T20:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000035, 2024040135, N'배송완료', CAST(N'2024-04-30T14:00:00.000' AS DateTime), CAST(N'2024-05-01T21:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000036, 2024040136, N'배송완료', CAST(N'2024-04-30T15:00:00.000' AS DateTime), CAST(N'2024-05-01T22:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000037, 2024040137, N'배송완료', CAST(N'2024-04-30T16:00:00.000' AS DateTime), CAST(N'2024-05-01T23:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000038, 2024040138, N'배송완료', CAST(N'2024-04-30T17:00:00.000' AS DateTime), CAST(N'2024-05-01T10:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000039, 2024040139, N'배송완료', CAST(N'2024-04-30T18:00:00.000' AS DateTime), CAST(N'2024-05-01T11:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000040, 2024040140, N'배송완료', CAST(N'2024-04-30T19:00:00.000' AS DateTime), CAST(N'2024-05-01T12:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000041, 2024040141, N'배송완료', CAST(N'2024-04-30T20:00:00.000' AS DateTime), CAST(N'2024-05-01T13:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000042, 2024040142, N'배송완료', CAST(N'2024-04-30T21:00:00.000' AS DateTime), CAST(N'2024-05-01T14:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000043, 2024040143, N'배송완료', CAST(N'2024-04-30T22:00:00.000' AS DateTime), CAST(N'2024-05-01T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000044, 2024040144, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000045, 2024040145, N'배송완료', CAST(N'2024-04-30T09:00:00.000' AS DateTime), CAST(N'2024-05-01T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000046, 2024040146, N'배송완료', CAST(N'2024-04-30T10:00:00.000' AS DateTime), CAST(N'2024-05-01T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000047, 2024040147, N'배송완료', CAST(N'2024-04-30T11:00:00.000' AS DateTime), CAST(N'2024-05-01T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000048, 2024040148, N'배송완료', CAST(N'2024-04-30T12:00:00.000' AS DateTime), CAST(N'2024-05-01T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000049, 2024040149, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4000050, 2024040150, N'배송완료', CAST(N'2024-04-30T14:00:00.000' AS DateTime), CAST(N'2024-05-01T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000001, 2024050101, N'배송완료', CAST(N'2024-05-01T10:00:00.000' AS DateTime), CAST(N'2024-05-02T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000002, 2024050102, N'배송완료', CAST(N'2024-05-02T11:00:00.000' AS DateTime), CAST(N'2024-05-03T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000003, 2024050103, N'배송완료', CAST(N'2024-05-03T12:00:00.000' AS DateTime), CAST(N'2024-05-04T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000004, 2024050104, N'배송완료', CAST(N'2024-05-04T13:00:00.000' AS DateTime), CAST(N'2024-05-05T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000005, 2024050105, N'배송완료', CAST(N'2024-05-05T14:00:00.000' AS DateTime), CAST(N'2024-05-06T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000006, 2024050106, N'배송완료', CAST(N'2024-05-06T15:00:00.000' AS DateTime), CAST(N'2024-05-07T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000007, 2024050107, N'배송완료', CAST(N'2024-05-07T16:00:00.000' AS DateTime), CAST(N'2024-05-08T21:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000008, 2024050108, N'배송완료', CAST(N'2024-05-08T17:00:00.000' AS DateTime), CAST(N'2024-05-09T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000009, 2024050109, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000010, 2024050110, N'배송완료', CAST(N'2024-05-10T19:00:00.000' AS DateTime), CAST(N'2024-05-11T10:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000011, 2024050111, N'배송완료', CAST(N'2024-05-11T20:00:00.000' AS DateTime), CAST(N'2024-05-12T11:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000012, 2024050112, N'배송완료', CAST(N'2024-05-12T21:00:00.000' AS DateTime), CAST(N'2024-05-13T12:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000013, 2024050113, N'배송완료', CAST(N'2024-05-13T22:00:00.000' AS DateTime), CAST(N'2024-05-14T13:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000014, 2024050114, N'배송완료', CAST(N'2024-05-13T22:00:00.000' AS DateTime), CAST(N'2024-05-14T13:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000015, 2024050115, N'배송완료', CAST(N'2024-05-15T09:00:00.000' AS DateTime), CAST(N'2024-05-16T15:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000016, 2024050116, N'배송완료', CAST(N'2024-05-16T10:00:00.000' AS DateTime), CAST(N'2024-05-17T16:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000017, 2024050117, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000018, 2024050118, N'배송완료', CAST(N'2024-05-18T12:00:00.000' AS DateTime), CAST(N'2024-05-19T18:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000019, 2024050119, N'배송완료', CAST(N'2024-05-19T13:00:00.000' AS DateTime), CAST(N'2024-05-20T19:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000020, 2024050120, N'배송완료', CAST(N'2024-05-20T14:00:00.000' AS DateTime), CAST(N'2024-05-21T20:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000021, 2024050121, N'배송완료', CAST(N'2024-05-20T14:00:00.000' AS DateTime), CAST(N'2024-05-21T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000022, 2024050122, N'배송완료', CAST(N'2024-05-22T16:00:00.000' AS DateTime), CAST(N'2024-05-23T22:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000023, 2024050123, N'배송완료', CAST(N'2024-05-23T17:00:00.000' AS DateTime), CAST(N'2024-05-24T23:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000024, 2024050124, N'배송완료', CAST(N'2024-05-24T18:00:00.000' AS DateTime), CAST(N'2024-05-25T10:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000025, 2024050125, N'배송완료', CAST(N'2024-05-25T19:00:00.000' AS DateTime), CAST(N'2024-05-26T11:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000026, 2024050126, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000027, 2024050127, N'배송완료', CAST(N'2024-05-27T21:00:00.000' AS DateTime), CAST(N'2024-05-28T13:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000028, 2024050128, N'배송완료', CAST(N'2024-05-28T22:00:00.000' AS DateTime), CAST(N'2024-05-29T14:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000029, 2024050129, N'배송완료', CAST(N'2024-05-28T22:00:00.000' AS DateTime), CAST(N'2024-05-29T14:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000030, 2024050130, N'배송완료', CAST(N'2024-05-30T09:00:00.000' AS DateTime), CAST(N'2024-05-31T16:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000031, 2024050131, N'배송완료', CAST(N'2024-05-31T10:00:00.000' AS DateTime), CAST(N'2024-06-01T17:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000032, 2024050132, N'배송완료', CAST(N'2024-05-31T11:00:00.000' AS DateTime), CAST(N'2024-06-01T18:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000033, 2024050133, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000034, 2024050134, N'배송완료', CAST(N'2024-05-31T13:00:00.000' AS DateTime), CAST(N'2024-06-01T20:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000035, 2024050135, N'배송완료', CAST(N'2024-05-31T14:00:00.000' AS DateTime), CAST(N'2024-06-01T21:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000036, 2024050136, N'배송완료', CAST(N'2024-05-31T15:00:00.000' AS DateTime), CAST(N'2024-06-01T22:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000037, 2024050137, N'배송완료', CAST(N'2024-05-31T15:00:00.000' AS DateTime), CAST(N'2024-06-01T22:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000038, 2024050138, N'배송완료', CAST(N'2024-05-31T17:00:00.000' AS DateTime), CAST(N'2024-06-01T10:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000039, 2024050139, N'배송완료', CAST(N'2024-05-31T18:00:00.000' AS DateTime), CAST(N'2024-06-01T11:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000040, 2024050140, N'배송완료', CAST(N'2024-05-31T19:00:00.000' AS DateTime), CAST(N'2024-06-01T12:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000041, 2024050141, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000042, 2024050142, N'배송완료', CAST(N'2024-05-31T21:00:00.000' AS DateTime), CAST(N'2024-06-01T14:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000043, 2024050143, N'배송완료', CAST(N'2024-05-31T22:00:00.000' AS DateTime), CAST(N'2024-06-01T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000044, 2024050144, N'배송완료', CAST(N'2024-05-31T23:00:00.000' AS DateTime), CAST(N'2024-06-01T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000045, 2024050145, N'배송완료', CAST(N'2024-05-31T23:00:00.000' AS DateTime), CAST(N'2024-06-01T16:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000046, 2024050146, N'배송완료', CAST(N'2024-05-31T10:00:00.000' AS DateTime), CAST(N'2024-06-01T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000047, 2024050147, N'배송완료', CAST(N'2024-05-31T11:00:00.000' AS DateTime), CAST(N'2024-06-01T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000048, 2024050148, N'배송완료', CAST(N'2024-05-31T12:00:00.000' AS DateTime), CAST(N'2024-06-01T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000049, 2024050149, N'배송완료', CAST(N'2024-05-31T13:00:00.000' AS DateTime), CAST(N'2024-06-01T21:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5000050, 2024050150, N'배송완료', CAST(N'2024-05-31T14:00:00.000' AS DateTime), CAST(N'2024-06-01T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000001, 2024060101, N'배송완료', CAST(N'2024-06-01T10:00:00.000' AS DateTime), CAST(N'2024-06-02T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000002, 2024060102, N'배송완료', CAST(N'2024-06-02T11:00:00.000' AS DateTime), CAST(N'2024-06-03T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000003, 2024060103, N'배송완료', CAST(N'2024-06-03T12:00:00.000' AS DateTime), CAST(N'2024-06-04T17:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000004, 2024060104, N'배송완료', CAST(N'2024-06-04T13:00:00.000' AS DateTime), CAST(N'2024-06-05T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000005, 2024060105, N'배송완료', CAST(N'2024-06-05T14:00:00.000' AS DateTime), CAST(N'2024-06-06T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000006, 2024060106, N'배송완료', CAST(N'2024-06-06T15:00:00.000' AS DateTime), CAST(N'2024-06-07T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000007, 2024060107, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000008, 2024060108, N'배송완료', CAST(N'2024-06-08T17:00:00.000' AS DateTime), CAST(N'2024-06-09T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000009, 2024060109, N'배송완료', CAST(N'2024-06-09T18:00:00.000' AS DateTime), CAST(N'2024-06-10T23:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000010, 2024060110, N'배송완료', CAST(N'2024-06-10T19:00:00.000' AS DateTime), CAST(N'2024-06-11T10:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000011, 2024060111, N'배송완료', CAST(N'2024-06-11T20:00:00.000' AS DateTime), CAST(N'2024-06-12T11:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000012, 2024060112, N'배송완료', CAST(N'2024-06-12T21:00:00.000' AS DateTime), CAST(N'2024-06-13T12:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000013, 2024060113, N'배송완료', CAST(N'2024-06-13T22:00:00.000' AS DateTime), CAST(N'2024-06-14T13:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000014, 2024060114, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000015, 2024060115, N'배송완료', CAST(N'2024-06-15T09:00:00.000' AS DateTime), CAST(N'2024-06-16T15:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000016, 2024060116, N'배송완료', CAST(N'2024-06-16T10:00:00.000' AS DateTime), CAST(N'2024-06-17T16:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000017, 2024060117, N'배송완료', CAST(N'2024-06-17T11:00:00.000' AS DateTime), CAST(N'2024-06-18T17:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000018, 2024060118, N'배송완료', CAST(N'2024-06-18T12:00:00.000' AS DateTime), CAST(N'2024-06-19T18:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000019, 2024060119, N'배송완료', CAST(N'2024-06-19T13:00:00.000' AS DateTime), CAST(N'2024-06-20T19:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000020, 2024060120, N'배송완료', CAST(N'2024-06-20T14:00:00.000' AS DateTime), CAST(N'2024-06-21T20:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000021, 2024060121, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000022, 2024060122, N'배송완료', CAST(N'2024-06-22T16:00:00.000' AS DateTime), CAST(N'2024-06-23T22:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000023, 2024060123, N'배송완료', CAST(N'2024-06-23T17:00:00.000' AS DateTime), CAST(N'2024-06-24T23:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000024, 2024060124, N'배송완료', CAST(N'2024-06-24T18:00:00.000' AS DateTime), CAST(N'2024-06-25T10:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000025, 2024060125, N'배송완료', CAST(N'2024-06-25T19:00:00.000' AS DateTime), CAST(N'2024-06-26T11:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000026, 2024060126, N'배송완료', CAST(N'2024-06-26T20:00:00.000' AS DateTime), CAST(N'2024-06-27T12:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000027, 2024060127, N'배송완료', CAST(N'2024-06-27T21:00:00.000' AS DateTime), CAST(N'2024-06-28T13:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000028, 2024060128, N'배송완료', CAST(N'2024-06-28T22:00:00.000' AS DateTime), CAST(N'2024-06-29T14:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000029, 2024060129, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000030, 2024060130, N'배송완료', CAST(N'2024-06-30T09:00:00.000' AS DateTime), CAST(N'2024-07-01T16:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000031, 2024060131, N'배송완료', CAST(N'2024-06-30T10:00:00.000' AS DateTime), CAST(N'2024-07-01T17:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000032, 2024060132, N'배송완료', CAST(N'2024-06-30T11:00:00.000' AS DateTime), CAST(N'2024-07-01T18:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000033, 2024060133, N'배송완료', CAST(N'2024-06-30T12:00:00.000' AS DateTime), CAST(N'2024-07-01T19:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000034, 2024060134, N'배송완료', CAST(N'2024-06-30T13:00:00.000' AS DateTime), CAST(N'2024-07-01T20:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000035, 2024060135, N'배송완료', CAST(N'2024-06-30T14:00:00.000' AS DateTime), CAST(N'2024-07-01T21:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000036, 2024060136, N'배송완료', CAST(N'2024-06-30T15:00:00.000' AS DateTime), CAST(N'2024-07-01T22:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000037, 2024060137, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000038, 2024060138, N'배송완료', CAST(N'2024-06-30T17:00:00.000' AS DateTime), CAST(N'2024-07-01T10:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000039, 2024060139, N'배송완료', CAST(N'2024-06-30T18:00:00.000' AS DateTime), CAST(N'2024-07-01T11:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000040, 2024060140, N'배송완료', CAST(N'2024-06-30T19:00:00.000' AS DateTime), CAST(N'2024-07-01T12:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000041, 2024060141, N'배송완료', CAST(N'2024-06-30T20:00:00.000' AS DateTime), CAST(N'2024-07-01T13:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000042, 2024060142, N'배송완료', CAST(N'2024-06-30T21:00:00.000' AS DateTime), CAST(N'2024-07-01T14:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000043, 2024060143, N'배송완료', CAST(N'2024-06-30T22:00:00.000' AS DateTime), CAST(N'2024-07-01T15:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000044, 2024060144, N'배송완료', CAST(N'2024-06-30T23:00:00.000' AS DateTime), CAST(N'2024-07-01T16:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000045, 2024060145, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000046, 2024060146, N'배송완료', CAST(N'2024-06-30T10:00:00.000' AS DateTime), CAST(N'2024-07-01T18:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000047, 2024060147, N'배송완료', CAST(N'2024-06-30T11:00:00.000' AS DateTime), CAST(N'2024-07-01T19:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000048, 2024060148, N'배송완료', CAST(N'2024-06-30T12:00:00.000' AS DateTime), CAST(N'2024-07-01T20:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000049, 2024060149, N'배송완료', CAST(N'2024-06-30T13:00:00.000' AS DateTime), CAST(N'2024-07-01T21:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6000050, 2024060150, N'배송완료', CAST(N'2024-06-30T14:00:00.000' AS DateTime), CAST(N'2024-07-01T22:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000001, 2024070101, N'배송완료', CAST(N'2024-07-01T11:23:00.000' AS DateTime), CAST(N'2024-07-02T15:40:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000002, 2024070102, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000003, 2024070103, N'배송완료', CAST(N'2024-07-03T14:09:00.000' AS DateTime), CAST(N'2024-07-04T19:30:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000004, 2024070104, N'배송완료', CAST(N'2024-07-04T12:51:00.000' AS DateTime), CAST(N'2024-07-05T20:12:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000005, 2024070105, N'배송완료', CAST(N'2024-07-05T10:22:00.000' AS DateTime), CAST(N'2024-07-06T21:48:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000006, 2024070106, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000007, 2024070107, N'배송취소', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000008, 2024070108, N'배송완료', CAST(N'2024-07-08T17:03:00.000' AS DateTime), CAST(N'2024-07-09T23:30:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000009, 2024070109, N'배송완료', CAST(N'2024-07-09T10:45:00.000' AS DateTime), CAST(N'2024-07-10T21:12:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000010, 2024070110, N'배송완료', CAST(N'2024-07-10T16:17:00.000' AS DateTime), CAST(N'2024-07-11T12:50:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000011, 2024070111, N'배송완료', CAST(N'2024-07-11T19:20:00.000' AS DateTime), CAST(N'2024-07-12T09:45:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000012, 2024070112, N'배송완료', CAST(N'2024-07-12T21:05:00.000' AS DateTime), CAST(N'2024-07-13T14:12:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000013, 2024070113, N'배송완료', CAST(N'2024-07-13T22:50:00.000' AS DateTime), CAST(N'2024-07-14T13:45:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000014, 2024070114, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000015, 2024070115, N'배송완료', CAST(N'2024-07-15T09:10:00.000' AS DateTime), CAST(N'2024-07-16T16:20:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000016, 2024070116, N'배송완료', CAST(N'2024-07-16T10:35:00.000' AS DateTime), CAST(N'2024-07-17T17:50:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000017, 2024070117, N'배송완료', CAST(N'2024-07-17T12:27:00.000' AS DateTime), CAST(N'2024-07-18T18:40:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000018, 2024070118, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000019, 2024070119, N'배송완료', CAST(N'2024-07-19T14:10:00.000' AS DateTime), CAST(N'2024-07-20T20:30:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000020, 2024070120, N'배송완료', CAST(N'2024-07-23T15:22:00.000' AS DateTime), CAST(N'2024-07-24T21:12:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000021, 2024070121, N'배송완료', CAST(N'2024-07-23T16:18:00.000' AS DateTime), CAST(N'2024-07-24T22:05:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000022, 2024070122, N'배송완료', CAST(N'2024-07-23T17:50:00.000' AS DateTime), CAST(N'2024-07-24T23:15:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000023, 2024070123, N'배송완료', CAST(N'2024-07-23T08:30:00.000' AS DateTime), CAST(N'2024-07-24T00:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000024, 2024070124, N'배송완료', CAST(N'2024-07-24T00:00:00.000' AS DateTime), CAST(N'2024-07-25T00:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000025, 2024070125, N'배송완료', CAST(N'2024-07-24T00:00:00.000' AS DateTime), CAST(N'2024-07-26T00:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000026, 2024070126, N'배송취소', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000027, 2024070127, N'배송중', CAST(N'2024-07-25T00:00:00.000' AS DateTime), CAST(N'2024-07-26T00:00:00.000' AS DateTime), N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000028, 2024070128, N'배송중', CAST(N'2024-07-25T00:00:00.000' AS DateTime), CAST(N'2024-07-26T00:00:00.000' AS DateTime), N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000029, 2024070129, N'배송중', CAST(N'2024-07-25T00:00:00.000' AS DateTime), CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000030, 2024070130, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000031, 2024070131, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000032, 2024070132, N'배송준비중', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000033, 2024070133, N'배송준비중', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000034, 2024070134, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000035, 2024070135, N'배송중', CAST(N'2024-07-27T00:00:00.000' AS DateTime), NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000036, 2024070136, N'배송중', CAST(N'2024-07-27T00:00:00.000' AS DateTime), NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000037, 2024070137, N'배송중', CAST(N'2024-07-27T00:00:00.000' AS DateTime), NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000038, 2024070138, N'배송중', CAST(N'2024-07-27T00:00:00.000' AS DateTime), NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000039, 2024070139, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000040, 2024070140, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000041, 2024070141, N'배송준비중', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000042, 2024070142, N'배송준비중', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000043, 2024070143, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000044, 2024070144, N'배송준비중', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000045, 2024070145, N'배송취소', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000046, 2024070146, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000047, 2024070147, N'배송준비중', NULL, NULL, N'부산')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000048, 2024070148, N'배송준비중', NULL, NULL, N'대구')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000049, 2024070149, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7000050, 2024070150, N'배송준비중', NULL, NULL, N'부산')
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (1, 10001, 508, 1000, 200, 300)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (2, 10002, 300, 800, 150, 200)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (3, 10003, 200, 600, 100, 150)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (4, 10004, 400, 900, 180, 250)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (5, 10005, 350, 850, 170, 220)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (6, 10006, 450, 950, 190, 270)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (7, 20001, 1000, 5000, 800, 1000)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (8, 20002, 800, 4000, 700, 900)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (9, 20003, 600, 3000, 600, 800)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (10, 20004, 1200, 5500, 850, 1100)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (11, 20005, 900, 4500, 750, 950)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (12, 20006, 700, 3500, 650, 850)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (13, 30001, 200, 1000, 100, 150)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (14, 30002, 150, 800, 80, 120)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (15, 30003, 100, 600, 60, 100)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (16, 30004, 180, 900, 90, 140)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (17, 30005, 250, 1200, 120, 180)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (18, 40001, 300, 1500, 200, 250)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (19, 40002, 200, 1200, 180, 220)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (20, 40003, 100, 800, 160, 210)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (21, 40004, 400, 1800, 220, 270)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (22, 40005, 350, 1700, 210, 260)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (23, 40006, 500, 2000, 230, 280)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (24, 40007, 250, 1400, 190, 240)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (25, 50001, 600, 3000, 400, 500)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (26, 50002, 500, 2500, 350, 450)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (27, 50003, 400, 2000, 300, 400)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (28, 50004, 700, 3500, 450, 550)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (29, 50005, 800, 4000, 500, 600)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (30, 50006, 900, 4500, 550, 650)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (31, 60001, 50, 200, 30, 50)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (32, 60002, 40, 180, 28, 48)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (33, 60003, 30, 150, 25, 45)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (34, 60004, 60, 220, 35, 55)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (35, 60005, 70, 250, 40, 60)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (36, 60006, 80, 280, 45, 65)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (37, 70001, 2000, 10000, 1500, 2000)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (38, 70002, 1500, 8000, 1200, 1700)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (39, 70003, 1000, 6000, 900, 1400)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (40, 70004, 1800, 9000, 1400, 1900)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (41, 70005, 1700, 8500, 1300, 1800)
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (42, 70006, 1600, 8000, 1250, 1750)
GO
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030101, 12, 30, CAST(N'2024-03-01T03:21:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030102, 22, 15, CAST(N'2024-03-01T08:34:47.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030103, 35, 28, CAST(N'2024-03-01T12:57:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030104, 8, 25, CAST(N'2024-03-01T17:03:58.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030105, 21, 22, CAST(N'2024-03-01T22:48:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030106, 27, 18, CAST(N'2024-03-02T04:10:25.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030107, 32, 30, CAST(N'2024-03-02T09:45:32.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030108, 14, 20, CAST(N'2024-03-02T15:12:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030109, 18, 25, CAST(N'2024-03-02T20:23:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030110, 7, 22, CAST(N'2024-03-03T03:01:56.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030111, 29, 24, CAST(N'2024-03-03T09:11:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030112, 11, 28, CAST(N'2024-03-03T14:02:14.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030113, 25, 30, CAST(N'2024-03-03T20:41:58.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030114, 24, 22, CAST(N'2024-03-04T02:53:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030115, 8, 20, CAST(N'2024-03-04T08:22:09.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030116, 19, 28, CAST(N'2024-03-04T14:43:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030117, 32, 24, CAST(N'2024-03-04T20:30:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030118, 16, 30, CAST(N'2024-03-05T03:41:21.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030119, 35, 22, CAST(N'2024-03-05T08:52:50.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030120, 27, 25, CAST(N'2024-03-05T13:15:31.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030121, 21, 30, CAST(N'2024-03-05T19:10:03.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030122, 14, 20, CAST(N'2024-03-06T02:25:14.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030123, 7, 22, CAST(N'2024-03-06T07:12:03.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030124, 29, 18, CAST(N'2024-03-06T12:45:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030125, 18, 25, CAST(N'2024-03-06T18:33:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030126, 11, 30, CAST(N'2024-03-07T03:09:18.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030127, 8, 22, CAST(N'2024-03-07T08:57:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030128, 21, 28, CAST(N'2024-03-07T13:30:25.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030129, 25, 20, CAST(N'2024-03-07T19:20:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030130, 32, 24, CAST(N'2024-03-08T03:11:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030131, 27, 30, CAST(N'2024-03-08T08:41:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030132, 7, 20, CAST(N'2024-03-08T13:50:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030133, 19, 22, CAST(N'2024-03-08T20:03:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030134, 35, 25, CAST(N'2024-03-09T03:33:40.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030135, 14, 28, CAST(N'2024-03-09T09:04:17.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030136, 21, 30, CAST(N'2024-03-09T14:21:28.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030137, 32, 22, CAST(N'2024-03-09T19:18:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030138, 27, 20, CAST(N'2024-03-10T04:15:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030139, 8, 25, CAST(N'2024-03-10T09:25:31.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030140, 35, 30, CAST(N'2024-03-10T14:45:20.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030141, 25, 22, CAST(N'2024-03-10T20:03:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030142, 11, 20, CAST(N'2024-03-11T02:55:14.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030143, 21, 30, CAST(N'2024-03-11T08:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030144, 32, 25, CAST(N'2024-03-11T13:43:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030145, 14, 22, CAST(N'2024-03-11T19:15:27.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030146, 8, 30, CAST(N'2024-03-12T03:45:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030147, 27, 20, CAST(N'2024-03-12T08:55:17.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030148, 35, 24, CAST(N'2024-03-12T14:32:20.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030149, 19, 25, CAST(N'2024-03-12T20:43:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024030150, 32, 30, CAST(N'2024-03-13T03:14:27.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040101, 7, 25, CAST(N'2024-04-01T02:30:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040102, 18, 30, CAST(N'2024-04-01T08:21:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040103, 22, 20, CAST(N'2024-04-01T14:05:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040104, 35, 22, CAST(N'2024-04-01T19:02:23.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040105, 27, 24, CAST(N'2024-04-02T03:33:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040106, 14, 30, CAST(N'2024-04-02T08:20:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040107, 32, 28, CAST(N'2024-04-02T14:11:12.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040108, 19, 20, CAST(N'2024-04-02T19:32:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040109, 21, 25, CAST(N'2024-04-03T03:14:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040110, 35, 30, CAST(N'2024-04-03T08:20:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040111, 8, 20, CAST(N'2024-04-03T13:45:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040112, 24, 25, CAST(N'2024-04-03T19:32:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040113, 27, 30, CAST(N'2024-04-04T02:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040114, 32, 20, CAST(N'2024-04-04T08:15:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040115, 14, 25, CAST(N'2024-04-04T13:42:21.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040116, 21, 30, CAST(N'2024-04-04T20:01:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040117, 35, 20, CAST(N'2024-04-05T03:35:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040118, 27, 24, CAST(N'2024-04-05T09:20:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040119, 14, 22, CAST(N'2024-04-05T14:00:05.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040120, 19, 20, CAST(N'2024-04-05T18:33:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040121, 24, 25, CAST(N'2024-04-06T03:14:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040122, 31, 20, CAST(N'2024-04-06T08:11:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040123, 28, 30, CAST(N'2024-04-06T13:32:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040124, 12, 22, CAST(N'2024-04-06T20:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040125, 29, 24, CAST(N'2024-04-07T04:12:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040126, 35, 30, CAST(N'2024-04-07T09:05:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040127, 22, 28, CAST(N'2024-04-07T14:20:30.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040128, 18, 20, CAST(N'2024-04-07T20:00:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040129, 33, 24, CAST(N'2024-04-08T03:45:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040130, 15, 22, CAST(N'2024-04-08T08:20:05.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040131, 24, 25, CAST(N'2024-04-08T14:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040132, 21, 20, CAST(N'2024-04-08T19:43:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040133, 26, 30, CAST(N'2024-04-09T02:55:15.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040134, 29, 28, CAST(N'2024-04-09T09:21:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040135, 12, 22, CAST(N'2024-04-09T14:45:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040136, 18, 25, CAST(N'2024-04-09T21:12:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040137, 33, 30, CAST(N'2024-04-10T03:55:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040138, 25, 22, CAST(N'2024-04-10T09:05:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040139, 22, 20, CAST(N'2024-04-10T14:30:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040140, 28, 24, CAST(N'2024-04-10T20:25:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040141, 18, 30, CAST(N'2024-04-11T03:22:43.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040142, 14, 25, CAST(N'2024-04-11T09:55:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040143, 19, 28, CAST(N'2024-04-11T15:44:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040144, 12, 22, CAST(N'2024-04-11T21:33:50.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040145, 27, 30, CAST(N'2024-04-12T04:22:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040146, 33, 20, CAST(N'2024-04-12T09:10:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040147, 24, 28, CAST(N'2024-04-12T14:35:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040148, 18, 22, CAST(N'2024-04-12T20:10:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040149, 30, 30, CAST(N'2024-04-13T03:05:22.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024040150, 22, 24, CAST(N'2024-04-13T09:40:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050101, 12, 28, CAST(N'2024-05-01T01:12:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050102, 35, 20, CAST(N'2024-05-01T07:45:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050103, 27, 25, CAST(N'2024-05-01T12:32:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050104, 22, 20, CAST(N'2024-05-01T18:01:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050105, 18, 28, CAST(N'2024-05-02T03:15:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050106, 32, 30, CAST(N'2024-05-02T08:35:20.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050107, 14, 20, CAST(N'2024-05-02T14:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050108, 21, 25, CAST(N'2024-05-02T20:11:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050109, 8, 22, CAST(N'2024-05-03T04:55:12.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050110, 27, 24, CAST(N'2024-05-03T09:05:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050111, 35, 22, CAST(N'2024-05-03T14:22:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050112, 19, 25, CAST(N'2024-05-03T20:00:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050113, 8, 30, CAST(N'2024-05-04T03:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050114, 22, 20, CAST(N'2024-05-04T09:34:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050115, 14, 25, CAST(N'2024-05-04T15:01:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050116, 32, 30, CAST(N'2024-05-04T20:44:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050117, 27, 22, CAST(N'2024-05-05T02:30:12.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050118, 18, 20, CAST(N'2024-05-05T09:12:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050119, 21, 24, CAST(N'2024-05-05T14:50:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050120, 35, 25, CAST(N'2024-05-05T20:21:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050121, 27, 30, CAST(N'2024-05-06T03:32:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050122, 14, 20, CAST(N'2024-05-06T09:25:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050123, 32, 28, CAST(N'2024-05-06T14:45:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050124, 21, 22, CAST(N'2024-05-06T20:12:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050125, 18, 30, CAST(N'2024-05-07T02:55:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050126, 35, 24, CAST(N'2024-05-07T09:30:10.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050127, 22, 20, CAST(N'2024-05-07T15:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050128, 8, 30, CAST(N'2024-05-07T20:22:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050129, 27, 22, CAST(N'2024-05-08T03:44:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050130, 14, 20, CAST(N'2024-05-08T09:10:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050131, 35, 25, CAST(N'2024-05-08T14:33:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050132, 18, 22, CAST(N'2024-05-08T19:12:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050133, 32, 30, CAST(N'2024-05-09T03:27:12.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050134, 21, 25, CAST(N'2024-05-09T09:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050135, 27, 20, CAST(N'2024-05-09T15:30:50.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050136, 22, 30, CAST(N'2024-05-09T20:10:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050137, 8, 22, CAST(N'2024-05-10T03:45:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050138, 14, 20, CAST(N'2024-05-10T09:15:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050139, 35, 28, CAST(N'2024-05-10T14:22:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050140, 27, 24, CAST(N'2024-05-10T19:00:20.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050141, 21, 30, CAST(N'2024-05-11T03:33:10.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050142, 18, 22, CAST(N'2024-05-11T09:40:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050143, 22, 25, CAST(N'2024-05-11T14:32:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050144, 8, 30, CAST(N'2024-05-11T20:45:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050145, 35, 20, CAST(N'2024-05-12T04:21:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050146, 27, 22, CAST(N'2024-05-12T09:11:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050147, 32, 28, CAST(N'2024-05-12T14:35:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050148, 21, 30, CAST(N'2024-05-12T20:00:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050149, 14, 25, CAST(N'2024-05-13T03:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024050150, 8, 30, CAST(N'2024-05-13T09:11:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060101, 18, 30, CAST(N'2024-06-01T02:31:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060102, 7, 25, CAST(N'2024-06-01T08:21:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060103, 22, 20, CAST(N'2024-06-01T13:00:25.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060104, 27, 22, CAST(N'2024-06-01T19:12:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060105, 35, 30, CAST(N'2024-06-02T03:11:45.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060106, 14, 28, CAST(N'2024-06-02T08:31:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060107, 21, 20, CAST(N'2024-06-02T14:10:30.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060108, 8, 24, CAST(N'2024-06-02T20:22:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060109, 27, 30, CAST(N'2024-06-03T03:45:25.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060110, 18, 22, CAST(N'2024-06-03T08:01:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060111, 32, 20, CAST(N'2024-06-03T13:23:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060112, 35, 24, CAST(N'2024-06-03T19:00:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060113, 21, 28, CAST(N'2024-06-04T02:55:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060114, 8, 25, CAST(N'2024-06-04T09:10:30.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060115, 14, 30, CAST(N'2024-06-04T15:22:50.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060116, 27, 20, CAST(N'2024-06-04T20:01:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060117, 35, 28, CAST(N'2024-06-05T03:44:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060118, 22, 20, CAST(N'2024-06-05T08:35:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060119, 21, 25, CAST(N'2024-06-05T14:20:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060120, 18, 30, CAST(N'2024-06-05T19:12:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060121, 32, 20, CAST(N'2024-06-06T03:22:12.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060122, 14, 24, CAST(N'2024-06-06T09:01:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060123, 27, 25, CAST(N'2024-06-06T14:43:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060124, 35, 22, CAST(N'2024-06-06T19:22:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060125, 8, 30, CAST(N'2024-06-07T04:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060126, 21, 20, CAST(N'2024-06-07T09:20:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060127, 18, 28, CAST(N'2024-06-07T15:01:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060128, 32, 22, CAST(N'2024-06-07T20:33:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060129, 35, 30, CAST(N'2024-06-08T03:12:22.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060130, 14, 25, CAST(N'2024-06-08T09:33:40.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060131, 27, 22, CAST(N'2024-06-08T14:25:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060132, 21, 30, CAST(N'2024-06-08T19:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060133, 8, 20, CAST(N'2024-06-09T03:30:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060134, 35, 30, CAST(N'2024-06-09T09:05:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060135, 18, 24, CAST(N'2024-06-09T15:22:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060136, 22, 25, CAST(N'2024-06-09T20:01:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060137, 32, 20, CAST(N'2024-06-10T03:30:30.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060138, 27, 28, CAST(N'2024-06-10T09:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060139, 35, 25, CAST(N'2024-06-10T14:15:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060140, 21, 20, CAST(N'2024-06-10T20:22:50.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060141, 18, 30, CAST(N'2024-06-11T03:44:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060142, 8, 25, CAST(N'2024-06-11T09:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060143, 22, 24, CAST(N'2024-06-11T15:12:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060144, 32, 28, CAST(N'2024-06-11T20:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060145, 27, 30, CAST(N'2024-06-12T03:22:15.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060146, 21, 22, CAST(N'2024-06-12T09:32:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060147, 35, 24, CAST(N'2024-06-12T15:11:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060148, 18, 20, CAST(N'2024-06-12T20:20:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060149, 8, 30, CAST(N'2024-06-13T04:11:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024060150, 32, 28, CAST(N'2024-06-13T09:05:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070101, 35, 20, CAST(N'2024-07-01T01:22:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070102, 27, 22, CAST(N'2024-07-01T07:33:12.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070103, 21, 25, CAST(N'2024-07-01T12:10:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070104, 18, 28, CAST(N'2024-07-01T18:45:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070105, 22, 30, CAST(N'2024-07-02T02:11:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070106, 8, 22, CAST(N'2024-07-02T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070107, 14, 25, CAST(N'2024-07-02T14:45:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070108, 35, 24, CAST(N'2024-07-02T20:11:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070109, 18, 20, CAST(N'2024-07-03T03:30:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070110, 32, 30, CAST(N'2024-07-03T09:12:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070111, 21, 22, CAST(N'2024-07-03T14:55:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070112, 27, 24, CAST(N'2024-07-03T20:10:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070113, 22, 30, CAST(N'2024-07-04T02:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070114, 8, 20, CAST(N'2024-07-04T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070115, 35, 28, CAST(N'2024-07-04T14:12:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070116, 18, 30, CAST(N'2024-07-04T19:11:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070117, 32, 22, CAST(N'2024-07-05T03:44:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070118, 27, 20, CAST(N'2024-07-05T09:05:22.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070119, 21, 25, CAST(N'2024-07-05T14:22:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070120, 14, 30, CAST(N'2024-07-05T20:00:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070121, 8, 24, CAST(N'2024-07-06T03:22:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070122, 18, 22, CAST(N'2024-07-06T09:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070123, 35, 30, CAST(N'2024-07-06T15:11:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070124, 32, 20, CAST(N'2024-07-06T20:12:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070125, 21, 28, CAST(N'2024-07-07T04:22:55.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070126, 27, 24, CAST(N'2024-07-07T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070127, 18, 25, CAST(N'2024-07-07T14:22:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070128, 8, 30, CAST(N'2024-07-07T19:10:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070129, 35, 22, CAST(N'2024-07-08T03:00:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070130, 21, 20, CAST(N'2024-07-08T09:11:22.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070131, 32, 25, CAST(N'2024-07-08T15:00:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070132, 27, 28, CAST(N'2024-07-08T20:22:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070133, 18, 30, CAST(N'2024-07-09T00:00:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070134, 22, 24, CAST(N'2024-07-09T09:55:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070135, 35, 20, CAST(N'2024-07-09T15:22:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070136, 27, 22, CAST(N'2024-07-09T20:00:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070137, 18, 20, CAST(N'2024-07-10T03:22:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070138, 32, 30, CAST(N'2024-07-10T09:10:15.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070139, 21, 24, CAST(N'2024-07-10T14:00:22.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070140, 35, 30, CAST(N'2024-07-10T20:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070141, 27, 28, CAST(N'2024-07-11T03:11:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070142, 18, 22, CAST(N'2024-07-11T09:20:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070143, 22, 25, CAST(N'2024-07-11T14:33:30.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070144, 8, 20, CAST(N'2024-07-11T19:22:10.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070145, 32, 30, CAST(N'2024-07-12T04:22:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070146, 21, 20, CAST(N'2024-07-12T09:12:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070147, 27, 22, CAST(N'2024-07-12T15:22:33.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070148, 35, 28, CAST(N'2024-07-12T20:01:22.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070149, 18, 25, CAST(N'2024-07-13T03:10:00.000' AS DateTime), N'N')
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT], [CancelOrNot]) VALUES (2024070150, 22, 24, CAST(N'2024-07-13T09:45:11.000' AS DateTime), N'N')
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10001, N'신선한 사과', 3000, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10002, N'유기농 오렌지', 4500, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10003, N'싱싱한 배', 5000, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10004, N'유기농 토마토', 4000, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10005, N'유기농 딸기', 6000, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (10006, N'신선한 블루베리', 7000, 1)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20001, N'라면', 1500, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20002, N'과자', 2000, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20003, N'통조림 참치', 3500, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20004, N'즉석밥', 1200, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20005, N'스팸', 5000, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (20006, N'초콜릿', 3000, 2)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (30001, N'비타민C', 10000, 3)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (30002, N'오메가3', 15000, 3)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (30003, N'프로바이오틱스', 20000, 3)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (30004, N'칼슘 영양제', 12000, 3)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (30005, N'홍삼 농축액', 25000, 3)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40001, N'반팔 티셔츠', 15000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40002, N'청바지', 30000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40003, N'패딩 점퍼', 80000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40004, N'운동화', 60000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40005, N'모자', 10000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40006, N'양말', 5000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (40007, N'가죽 장갑', 25000, 4)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50001, N'주방 세제', 3000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50002, N'화장지', 5000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50003, N'샴푸', 8000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50004, N'세탁 세제', 6000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50005, N'수세미', 2000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (50006, N'칫솔', 1000, 5)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60001, N'냉장고', 1000000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60002, N'세탁기', 800000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60003, N'전자레인지', 150000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60004, N'청소기', 200000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60005, N'에어컨', 1200000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (60006, N'TV', 900000, 6)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70001, N'볼펜', 1000, 7)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70002, N'연필', 500, 7)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70003, N'노트', 2000, 7)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70004, N'파일', 1500, 7)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70005, N'형광펜', 800, 7)
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price], [Classification]) VALUES (70006, N'자', 1000, 7)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserIdx], [UserName], [ID], [PASSWORD]) VALUES (1, N'admin', N'admin', N'admin')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkStatus] ON 
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (1, 2024070124, 7000024, CAST(N'2024-07-24T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (3, 2024070125, 7000025, CAST(N'2024-07-24T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (5, 2024070127, 7000027, CAST(N'2024-07-25T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (6, 2024070128, 7000028, CAST(N'2024-07-25T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (7, 2024070129, 7000029, CAST(N'2024-07-25T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (8, 2024070135, 7000035, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (9, 2024070136, 7000036, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (11, 2024070137, 7000037, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (12, 2024070138, 7000038, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (15, 2024070142, 7000042, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (16, 2024070145, 7000045, CAST(N'2024-07-27T00:00:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (17, 2024070120, 7000020, CAST(N'2024-07-23T15:22:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (18, 2024070121, 7000021, CAST(N'2024-07-23T16:18:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (19, 2024070122, 7000022, CAST(N'2024-07-23T17:50:00.000' AS DateTime), N'Y')
GO
INSERT [dbo].[WorkStatus] ([WorkNum], [OrderNum], [DeliveryNum], [ProcessDT], [CompleteOrNot]) VALUES (20, 2024070123, 7000023, CAST(N'2024-07-23T08:30:00.000' AS DateTime), N'Y')
GO
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
