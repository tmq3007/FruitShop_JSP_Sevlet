-- Tạo cơ sở dữ liệu
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FruitShop')
BEGIN
    CREATE DATABASE FruitShop;
END;
GO
USE FruitShop;
GO

-- Tạo bảng Categories (Danh Mục)
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX)
);
GO

-- Tạo bảng Products (Sản Phẩm)
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    CategoryID INT,
    QuantityPerUnit NVARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    ImageURL NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- Tạo bảng Customers (Khách Hàng)
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255),
    Address NVARCHAR(255),
    City NVARCHAR(255),
    PostalCode NVARCHAR(10),
    Country NVARCHAR(255)
);
GO

-- Tạo bảng Orders (Đơn Hàng)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Tạo bảng OrderDetails (Chi Tiết Đơn Hàng)
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Tạo bảng Accounts (Tài Khoản)
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50) NOT NULL CHECK (Role IN ('Admin', 'User'))
);
GO

-- Tạo bảng Feedback (Phản Hồi)
CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    FeedbackDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Thêm dữ liệu mẫu vào bảng Categories
INSERT INTO Categories (CategoryName, Description) VALUES 
(N'Citrus', N'Các loại quả thuộc họ cam quýt'),
(N'Berries', N'Các loại quả mọng'),
(N'Tropical', N'Các loại quả nhiệt đới');
GO
insert into Categories (CategoryName, Description)
values(N'Meat', N'Các loại thịt');
go
insert into Categories (CategoryName, Description)
values(N'Vegetables', N'Các loại rau')
go


-- Thêm dữ liệu mẫu vào bảng Products
INSERT INTO Products (ProductName, CategoryID, QuantityPerUnit, UnitPrice, ImageURL) 
VALUES 
(N'Cam', 1, N'1 kg', 2.50, N'https://example.com/images/orange.jpg'),
(N'Dâu Tây', 2, N'500 gram', 3.00, N'https://example.com/images/strawberry.jpg'),
(N'Xoài', 3, N'1 kg', 4.00, N'https://example.com/images/mango.jpg');
GO
INSERT INTO Products (ProductName, CategoryID, QuantityPerUnit, UnitPrice, ImageURL) 
VALUES 
(N'Thịt Bò', 4, N'1 kg', 5.00, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhjy7RN_UOIKra4jjOMNjy8f_J9wPiSolmg&s')

GO
INSERT INTO Products (ProductName, CategoryID, QuantityPerUnit, UnitPrice, ImageURL) 
VALUES 
(N'Rau xà lách', 5, N'100 gram', 0.50, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmsFu-M5YWj9hM53t7V_tsBh8GecRUS_9DGg&s'),
(N'Rau bắp cải', 5, N'1 cái', 0.05, N'https://png.pngtree.com/png-vector/20240226/ourlarge/pngtree-green-cabbage-isolated-on-white-background-png-image_11875175.png'),
(N'Cà chua', 5, N'500 gram', 3.00, N'https://png.pngtree.com/thumb_back/fw800/background/20230727/pngtree-two-tomatoes-on-a-white-background-image_10228015.jpg'),
(N'Hoa quả khô', 3, N'500 gram', 6.00, N'https://png.pngtree.com/thumb_back/fw800/background/20221015/pngtree-dried-fruit-bowl-on-white-background-mix-space-bunch-photo-image_34248058.jpg')

GO
UPDATE Products
SET UnitPrice = 1.5
WHERE ProductName = N'Rau bắp cải';

INSERT INTO Products (ProductName, CategoryID, QuantityPerUnit, UnitPrice, ImageURL) 
VALUES 
(N'Cherry', 2, N'100 gram', 4.50, N'https://static6.depositphotos.com/1017896/598/i/450/depositphotos_5983426-stock-photo-cherries-isolated-on-white.jpg'),
(N'Mận', 2, N'500 gram', 3.00, N'https://png.pngtree.com/thumb_back/fw800/background/20221206/pngtree-plums-on-white-background-plum-fruit-isolated-photo-image_28709946.jpg'),
(N'Cà Rốt', 3, N'500 gram', 2.50, N'https://stockdep.net/files/images/27549346.jpg'),
(N'Bưởi', 1, N'1 kg', 2.00, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRRbciFq_lD2xrkuVShEx7UIodt448DjjJJw&s')

GO

-- Thêm dữ liệu mẫu vào bảng Customers
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country) 
VALUES 
(N'Nguyen Van A', N'Mr. A', N'123 Đường ABC', N'Hà Nội', N'100000', N'Vietnam'),
(N'Tran Thi B', N'Ms. B', N'456 Đường DEF', N'Hồ Chí Minh', N'700000', N'Vietnam');
GO

-- Thêm dữ liệu mẫu vào bảng Orders
INSERT INTO Orders (CustomerID, OrderDate) VALUES 
(1, '2024-05-01'),
(2, '2024-05-02');
GO

-- Thêm dữ liệu mẫu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES 
(1, 1, 10, 2.50),
(1, 2, 5, 3.00),
(2, 3, 2, 4.00);
GO

-- Thêm dữ liệu mẫu vào bảng Accounts
INSERT INTO Accounts (Username, PasswordHash, Role) VALUES 
(N'admin', HASHBYTES('SHA2_256', N'adminpassword'), N'Admin'), 
(N'user1', HASHBYTES('SHA2_256', N'user1password'), N'User');
GO

-- Thêm dữ liệu mẫu vào bảng Feedback
INSERT INTO Feedback (CustomerID, ProductID, Rating, Comment, FeedbackDate) VALUES 
(1, 1, 5, N'Rất ngon!', '2024-05-01'),
(2, 2, 4, N'Tươi và ngọt.', '2024-05-02');
GO
