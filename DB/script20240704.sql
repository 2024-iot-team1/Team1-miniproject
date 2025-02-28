
/****** Object:  Table [dbo].[Delivery]    Script Date: 2024-07-04 오전 11:40:40 ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 2024-07-04 오전 11:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryNum] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Orders]    Script Date: 2024-07-04 오전 11:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderNum] [int] NOT NULL,
	[InventoryNum] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderDT] [datetime] NOT NULL,
 CONSTRAINT [PK_Orders_1] PRIMARY KEY CLUSTERED 
(
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2024-07-04 오전 11:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductCode] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Price] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2024-07-04 오전 11:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserIdx] [int] NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[PASSWORD] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStatus]    Script Date: 2024-07-04 오전 11:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStatus](
	[WorkNum] [int] NOT NULL,
	[OrderNum] [int] NOT NULL,
	[DeliveryNum] [int] NOT NULL,
	[ProcessDT] [datetime] NOT NULL,
	[CompleteOrNot] [int] NOT NULL,
 CONSTRAINT [PK_WorkStatus] PRIMARY KEY CLUSTERED 
(
	[WorkNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (1, 1112112, N'배송완료', CAST(N'2024-07-02T09:11:12.000' AS DateTime), CAST(N'2024-07-02T17:21:11.000' AS DateTime), N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (2, 1112113, N'배송완료', CAST(N'2024-07-02T10:12:33.000' AS DateTime), CAST(N'2024-07-02T18:01:21.000' AS DateTime), N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (3, 1112114, N'배송완료', CAST(N'2024-07-02T10:40:25.000' AS DateTime), CAST(N'2024-07-02T18:39:42.000' AS DateTime), N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (4, 1112115, N'배송중', CAST(N'2024-07-03T11:23:17.000' AS DateTime), NULL, N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (5, 1112116, N'배송중', CAST(N'2024-07-03T13:46:43.000' AS DateTime), NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (6, 1112117, N'배송준비중', NULL, NULL, N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (7, 1112118, N'배송준비중', NULL, NULL, N'서울')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (8, 1112119, N'배송준비중', NULL, NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (9, 1112120, N'배송준비중', NULL, NULL, N'대구')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (10, 1112121, N'배송준비중', NULL, NULL, N'부산')
INSERT [dbo].[Delivery] ([DeliveryNum], [OrderNum], [DeliveryStatus], [StartDT], [CompleteDT], [Destination]) VALUES (11, 1112122, N'배송준비중', NULL, NULL, N'서울')
GO
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (1, 10001, 150, 300, 200, 50)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (2, 10002, 300, 400, 500, 400)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (3, 10003, 100, 200, 200, 100)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (4, 10004, 250, 350, 400, 300)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (5, 10005, 150, 200, 300, 250)
GO
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112112, 1, 1, CAST(N'2024-07-01T16:00:01.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112113, 2, 2, CAST(N'2024-07-01T16:30:45.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112114, 1, 1, CAST(N'2024-07-01T16:48:11.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112115, 3, 2, CAST(N'2024-07-02T17:02:21.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112116, 4, 4, CAST(N'2021-07-02T18:11:23.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112117, 5, 2, CAST(N'2024-07-08T10:12:22.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112118, 2, 1, CAST(N'2024-07-08T11:00:04.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112119, 4, 2, CAST(N'2024-07-08T11:20:13.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112120, 2, 1, CAST(N'2024-07-09T09:01:22.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112121, 3, 1, CAST(N'2024-07-09T18:24:11.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderNum], [InventoryNum], [Quantity], [OrderDT]) VALUES (1112122, 5, 5, CAST(N'2024-07-09T20:20:12.000' AS DateTime))
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price]) VALUES (10001, N'투쁠등심 200g', 50000)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price]) VALUES (10002, N'크록스', 32000)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price]) VALUES (10003, N'밴딩 반바지', 28500)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price]) VALUES (10004, N'5+5 타월', 37000)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [Price]) VALUES (10005, N'멀티비타민', 120000)
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
