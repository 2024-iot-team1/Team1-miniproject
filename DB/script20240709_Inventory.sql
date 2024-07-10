USE [AutoSortingDB]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 2024-07-09 오후 5:43:35 ******/
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
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (1, 10001, 150, 300, 200, 50)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (2, 10002, 300, 400, 500, 400)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (3, 10003, 100, 200, 200, 100)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (4, 10004, 250, 350, 400, 300)
INSERT [dbo].[Inventory] ([InventoryNum], [ProductCode], [SalesRate], [Stock], [SafeStock], [Procurement]) VALUES (5, 10005, 150, 200, 300, 250)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Inventory_SalesRate]  DEFAULT ((0)) FOR [SalesRate]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([ProductCode])
REFERENCES [dbo].[Product] ([ProductCode])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
