USE [master]
GO
/****** Object:  Database [DELIVERY_DATABASE]    Script Date: 14/07/2025 9:33:04 PM ******/
CREATE DATABASE [DELIVERY_DATABASE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DELIVERY_DATABASE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DELIVERY_DATABASE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DELIVERY_DATABASE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DELIVERY_DATABASE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DELIVERY_DATABASE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DELIVERY_DATABASE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ARITHABORT OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET RECOVERY FULL 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET  MULTI_USER 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DELIVERY_DATABASE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DELIVERY_DATABASE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DELIVERY_DATABASE', N'ON'
GO
ALTER DATABASE [DELIVERY_DATABASE] SET QUERY_STORE = ON
GO
ALTER DATABASE [DELIVERY_DATABASE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DELIVERY_DATABASE]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
	[TotalPrice]  AS ([Quantity]*[UnitPrice]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DeliveryAddress] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Notes] [nvarchar](255) NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[CategoryId] [int] NULL,
	[IsAvailable] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 14/07/2025 9:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (1, N'Burgers')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (3, N'Desserts')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (2, N'Drinks')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 1, 1, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (2, 1, 3, 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 3, 1, 2, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 4, 1, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (5, 4, 2, 2, CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (6, 4, 3, 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (7, 5, 1, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (8, 5, 2, 2, CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (9, 7, 1, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (10, 7, 3, 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (11, 7, 6, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (12, 7, 4, 1, CAST(9.50 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [UserId], [DeliveryAddress], [PhoneNumber], [Notes], [TotalAmount], [Status], [CreatedAt]) VALUES (1, 1, N'123 Main Street, Abu Dhabi', N'+971501234567', N'Leave it at the front desk.', CAST(59.50 AS Decimal(10, 2)), N'Pending', CAST(N'2025-07-10T09:43:56.267' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [DeliveryAddress], [PhoneNumber], [Notes], [TotalAmount], [Status], [CreatedAt]) VALUES (3, 1, N'123 Street, Abu Dhabi', N'1234567890', NULL, CAST(100.00 AS Decimal(10, 2)), N'Pending', CAST(N'2025-07-10T10:43:00.667' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [DeliveryAddress], [PhoneNumber], [Notes], [TotalAmount], [Status], [CreatedAt]) VALUES (4, 1, N'Abu Dhabi, UAE', N'0569206695', N'notes here!', CAST(99.50 AS Decimal(10, 2)), N'Pending', CAST(N'2025-07-10T13:53:04.400' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [DeliveryAddress], [PhoneNumber], [Notes], [TotalAmount], [Status], [CreatedAt]) VALUES (5, 2, N'Dubai, UAE', N'123456789', NULL, CAST(69.00 AS Decimal(10, 2)), N'Pending', CAST(N'2025-07-10T13:57:19.650' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [DeliveryAddress], [PhoneNumber], [Notes], [TotalAmount], [Status], [CreatedAt]) VALUES (7, 2, N'ewfkuhhfdeou', N'24687777', N'bhfbouhfwrebfihreobfiureoqafsvbuiofreqoiphiu', CAST(83.00 AS Decimal(10, 2)), N'Pending', CAST(N'2025-07-10T14:16:41.783' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (1, N'Classic Burger', N'Juicy beef burger with cheddar cheese and lettuce.', CAST(25.00 AS Decimal(10, 2)), N'classic_burger.png', 1, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (2, N'Veggie Burger', N'Grilled veggie patty with fresh greens.', CAST(22.00 AS Decimal(10, 2)), N'veggie_burger.png', 1, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (3, N'Coca-Cola 330ml', N'Chilled Coke can.', CAST(5.50 AS Decimal(10, 2)), N'coca_cola.png', 2, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (4, N'Fresh Orange Juice', N'Cold-pressed orange juice.', CAST(9.50 AS Decimal(10, 2)), N'orange_juice.png', 2, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (5, N'Chocolate Cake', N'Slice of rich chocolate cake with frosting.', CAST(15.00 AS Decimal(10, 2)), N'chocolate_cake.png', 3, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [ProductName], [Description], [Price], [ImageUrl], [CategoryId], [IsAvailable], [CreatedAt]) VALUES (6, N'Strawberry Cheesecake', N'Classic cheesecake topped with strawberries.', CAST(18.00 AS Decimal(10, 2)), N'strawberry_cheesecake.png', 3, 1, CAST(N'2025-07-10T09:43:56.253' AS DateTime))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'Customer')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [FullName], [Email], [PasswordHash], [RoleId], [CreatedAt]) VALUES (1, N'John Doe', N'john@example.com', N'1234', 1, CAST(N'2025-07-10T09:43:56.227' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FullName], [Email], [PasswordHash], [RoleId], [CreatedAt]) VALUES (2, N'Admin User', N'admin@example.com', N'admin123', 2, CAST(N'2025-07-10T09:43:56.227' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FullName], [Email], [PasswordHash], [RoleId], [CreatedAt]) VALUES (3, N'Shaikha Alzaabi', N'shaikha@example.com', N'123', 1, CAST(N'2025-07-10T10:35:10.770' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FullName], [Email], [PasswordHash], [RoleId], [CreatedAt]) VALUES (4, N'New User', N'newuser@example.com', N'123', 1, CAST(N'2025-07-10T10:49:34.277' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__8517B2E05D6E72BD]    Script Date: 14/07/2025 9:33:05 PM ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160002DB654]    Script Date: 14/07/2025 9:33:05 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D1053493976292]    Script Date: 14/07/2025 9:33:05 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [RoleId]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
USE [master]
GO
ALTER DATABASE [DELIVERY_DATABASE] SET  READ_WRITE 
GO
