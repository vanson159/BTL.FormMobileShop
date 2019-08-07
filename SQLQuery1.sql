GO
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Proc Thêm dữ liệu vào bảng brands
-- Modified by: 
-- ===============================================
CREATE PROC  [dbo].[Proc_Insert_Brand] 
@BrandName nvarchar(255),
@BrandStatus bit
as
begin
INSERT INTO Brands 
VALUES (@BrandName,@BrandStatus)
end

-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Proc Thêm dữ liệu vào bảng Product
-- Modified by: 
-- [dbo].[Proc_Insert_Product] 
-- ===============================================
create proc [dbo].[Proc_Insert_Product] 
@ProductName nvarchar(255),
@ProductImage nvarchar(255),
@BrandID int,
@Price decimal(18,0),
@Discount float,
@ProductStatus bit
as
begin
	insert into Products (ProductName,ProductImage,BrandID,Price,Discount,ProductStatus)
	values (@ProductName,@ProductImage,@BrandID,@Price,@Discount,@ProductStatus)
end
drop proc [dbo].[Proc_Insert_Product] 

-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Select sản phẩm theo id của loại sản phẩm
-- Modified by: 
-- [dbo].[Proc_Select_ProductByCategoryID] 1
-- ===============================================
CREATE PROC [dbo].[Proc_Select_ProductByCategoryID] 
@CategoryID int
AS
BEGIN
	SELECT * FROM Products
	INNER JOIN ProductCategory ON Products.ProductID = ProductCategory.ProductID
	WHERE ProductCategory.CategoryID = @CategoryID
END
select * from Products
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Đọc dữ liệu từ bảng Product dựa vào khoảng giá và hãng
-- Modified by: [dbo].[Proc_Select_ProductByBrandAndPrice] NULL , 1 ,2000000,null
-- ===============================================
ALTER PROC [dbo].[Proc_Select_ProductByBrandAndPrice] 
@BrandID int,
@LowPrice float,
@HightPrice float
AS
BEGIN
	IF @BrandID != NULL
		SELECT * FROM Products
		INNER JOIN Brands ON Products.BrandID = Brands.BrandID
		WHERE Brands.BrandID = @BrandID AND Products.Price > @LowPrice AND Products.Price < @HightPrice
	ELSE
		SELECT * FROM Products
		WHERE  Products.Price > @LowPrice AND Products.Price < @HightPrice 
END


-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Tìm kiếm sản phẩm theo tên
-- Modified by: [dbo].[Proc_Select_ProductByKeySearch]  samsung
-- ===============================================
CREATE PROC [dbo].[Proc_Select_ProductByKeySearch] 
@KeySearch nvarchar(max)
AS
BEGIN
		SELECT * FROM Products
		WHERE Products.ProductName LIKE '%'+@KeySearch+'%'
END
select * from Products
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Select sản phẩm theo BrandID
-- Modified by: 
-- [dbo].[Proc_Select_ProductByBrandID] 2
-- ===============================================
CREATE PROC [dbo].[Proc_Select_ProductByBrandID] 
@BrandID int
AS
BEGIN
	SELECT * FROM Products
	INNER JOIN Brands ON Products.BrandID = Brands.BrandID
	WHERE Brands.BrandID = @BrandID
END
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Select sản phẩm theo ProductID
-- Modified by: 
-- [dbo].[Proc_Select_ProductByID] 2
-- ===============================================
CREATE PROC [dbo].[Proc_Select_ProductByID] 
@ProductID int
AS
BEGIN
	SELECT * FROM Products
	WHERE ProductID = @ProductID
END

-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: ADD TÀI KHOẢN
-- Modified by: 
-- [dbo].[Proc_Add_Account] 'vanson@gmail.com' ,N'Sơn Nguyễn', '1234'
-- ===============================================
ALTER PROC [dbo].[Proc_Add_Account] 
@Email varchar(100),
@Name nvarchar(100),
@Pass varchar(100)
AS
BEGIN
	INSERT INTO Account(Email,Name,Pass)
	VALUES (@Email,@Name,@Pass)
END

SELECT * FROM Account
Delete Account 
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Login tài khoản (Login)
-- Modified by: 
-- [dbo].[Proc_Login_Account] 'vanson@gmail.com' , '1234', null
-- ===============================================
ALTER PROC [dbo].[Proc_Login_Account] 
@Email varchar(100),
@Pass varchar(100),
@Name nvarchar(100) OUTPUT
AS
BEGIN
	SELECT * FROM Account
	WHERE Account.Email = @Email AND Account.Pass =@Pass
	SELECT  @Name= Account.Name from Account
	WHERE Account.Email=@Email
END
select * from Account
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: ADD đơn hàng vào bảng Order 
-- Modified by: 
-- [dbo].[Proc_Add_Orders]  12 , 16 , null, 1 ,0
-- ===============================================
alter PROC [dbo].[Proc_Add_Orders] 
@AccountID int,
@ProductID int,
@OrdersDetailD int,
@Amount int,
@OrderState bit
AS
BEGIN
	INSERT INTO Orders(AccountID,ProductID,OrdersDetailD,Amount,OrderState)
	VALUES (@AccountID,@ProductID,@OrdersDetailD,@Amount,@OrderState)
END
SELECT * FROM Orders
SElect * from Products
delete Orders

-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: ADD đơn hàng vào bảng Order 
-- Modified by: 
-- [dbo].[Proc_Select_ProductInOrders]  4
-- ===============================================
ALTER PROC [dbo].[Proc_Select_ProductInOrders] 
@AccountID int
AS
BEGIN 
	SELECT Products.ProductID,Products.ProductName,Products.ProductImage,  (Products.Price-(Products.Price*(Products.Discount/100))) as 'ProductPrice'  , Orders.Amount 
	FROM Products
	INNER JOIN  Orders ON  Orders.ProductID = Products.ProductID 
	WHERE Orders.AccountID=@AccountID AND Orders.OrderState=0
	GROUP BY  Products.ProductID,Products.ProductName,Products.ProductImage,Orders.Amount,Products.Price,Products.Discount
END
drop proc [dbo].[Proc_Select_ProductInOrders] 
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Xóa sản phẩm trong đơn hàng , dựa vào ID của sản phẩm và Account
-- Modified by: 
-- [dbo].[Proc_Delete_Orders]  1 , 30 
-- ===============================================
CREATE PROC [dbo].[Proc_Delete_Orders] 
@AccountID int,
@ProductID int
AS
BEGIN
	DELETE Orders
	WHERE Orders.AccountID = @AccountID AND Orders.ProductID = @ProductID 
END
Select * from Orders
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Cập nhật số lượng sản phẩm trong giỏ hàng dựa vào AccountID và ProductID
-- Modified by: 
-- [dbo].[Proc_Update_Orders]  1 , 15 , 100
-- ===============================================
CREATE PROC [dbo].[Proc_Update_Orders] 
@AccountID int,
@ProductID int,
@Amount int
AS
BEGIN
	UPDATE Orders
	SET Amount = @Amount
	WHERE Orders.AccountID = @AccountID AND Orders.ProductID = @ProductID 
END
-- ===============================================
-- Author: NVSON
-- Create date: 30/7/2019
-- Descripttion: Thêm chi tiết đơn hàng sau đó update đơn hàng có chi tiết đơn hàng này dựa vào AccountID 
--				(Chi tiết đơn hàng được tạo ra khi người dùng xác nhận đặt hàng)
-- Modified by: 
 [dbo].[Proc_Add_OrdersDetail] 4,2, N'Hoàng Văn Quân' , 'quanhoang98@gmail.com' , N'0364735568',null,N'Sóc Sơn - Hà Nội'
-- ===============================================
ALTER PROC [dbo].[Proc_Add_OrdersDetail] 
@AcountID int,
@OrdersDetailID int,
@CustomerName nvarchar(255),
@CustomerEmail varchar(100),
@PhoneNumber nvarchar(20),
@TimeOrder datetime,
@Address nvarchar(max)
AS
BEGIN
	INSERT INTO OrdersDetail(OrderDetailID,CustomerName,CustomerEmail,PhoneNumber,TimeOrder,Address)
	VALUES (@OrdersDetailID,@CustomerName,@CustomerEmail,@PhoneNumber,@TimeOrder,@Address)
	UPDATE Orders
	SET Orders.OrdersDetailD = @OrdersDetailID, Orders.OrderState = 1
	WHERE Orders.AccountID = @AcountID
END
DELETE OrdersDetail
select * from Orders
select * from OrdersDetail
--============================== PHẦN THÊM DỮ LIỆU VÀO CÁC BẢNG =======================
-- Thêm hãng điện thoại 

 [dbo].[Proc_Insert_Brand] N'Samsung', 1
 [dbo].[Proc_Insert_Brand] N'Iphone', 2
 [dbo].[Proc_Insert_Brand] N'Oppo', 3
 [dbo].[Proc_Insert_Brand] N'Huawei', 4
 [dbo].[Proc_Insert_Brand] N'Xiaomi', 5
 [dbo].[Proc_Insert_Brand] N'VSmart', 6
 [dbo].[Proc_Insert_Brand] N'Nokia', 7
-- Thêm dữ liệu vào bảng phân loại
	INSERT INTO Categories (CategoryName,CategoryStatus)
	VALUES (N'ĐIỆN THOẠI HOT NHẤT',1),
			(N'ĐIỆN THOẠI MỚI RA MẮT',1),
			(N'ĐIỆN THOẠI NHIẾP ẢNH',1)
	select * from Categories
--  Thêm dữ liệu vào bảng loại sản phẩm
	INSERT INTO ProductCategory(CategoryID,ProductID)
	VALUES (1,1),
			(1,8),
			(1,12),
			(1,32),
			(1,7),
			(1,9),
			(1,59),
			(1,45),
			(2,4),
			(2,13),
			(2,21),
			(2,23),
			(2,16),
			(2,22),
			(2,11),
			(2,18),
			(3,6),
			(3,15),
			(3,24),
			(3,25),
			(3,14),
			(3,31),
			(3,60),
			(3,54)
SELECT * FROM ProductCategory
SELECT * FROM Products
--Thêm dữ liệu điện thoại Huawei
[dbo].[Proc_Insert_Product] N'Huawei P30 Pro',N'/Content/image/huawei/mate_20.jpg', 4,22990000 ,5.25,1 
[dbo].[Proc_Insert_Product] N'Huawei Mate 20 Pro',N'/Content/image/huawei/p30_pro.jpg', 4,15990000 ,0,1 
[dbo].[Proc_Insert_Product] N'Huawei P30',N'/Content/image/huawei/p30.jpg', 4,16990000 ,0,1 
[dbo].[Proc_Insert_Product] N'Huawei P30 Lite',N'/Content/image/huawei/p30_lite.jpg', 4,6690000 ,0,1
[dbo].[Proc_Insert_Product] N'Huawei Nova 3i',N'/Content/image/huawei/nova_3i.jpg', 4, 5990000,0,1
[dbo].[Proc_Insert_Product] N'Huawei Y9 (2019)',N'/Content/image/huawei/y9.jpg', 4,4990000,0,1
[dbo].[Proc_Insert_Product] N'Huawei Y7 Pro (2019)',N'/Content/image/huawei/y7_2019.jpg', 4,3400000,0,1
[dbo].[Proc_Insert_Product] N'Huawei Y7 Pro 2018',N'/Content/image/huawei/y7_2018.jpg', 4,3200000,5,1

update Products
set Display = N'6.47 inches, 2340 x 1080 Pixel',FrontCamera=N'32.0Mp',RearCamera=N'	40Mp (khẩu độ f/1.8)',RAM=N'8G',Memory='256 GB',CPU=N'HUAWEI Kirin 980, Octa-Core',Battery=N'4200 mAh',OS=N'Android™ 9.0 + EMUI 9.1',GPU=N'Mali G76 720MHz'
where BrandID = 4

--Thêm dữ liệu điện thoại Iphone
[dbo].[Proc_Insert_Product] N'Iphone XS Max 64GB',N'/Content/image/iphone/iphoneXS.jpg', 2,29990000 ,6,1
[dbo].[Proc_Insert_Product] N'Iphone XS Max 256GB',N'/Content/image/iphone/iphoneXS.jpg', 2,35990000,0,1
[dbo].[Proc_Insert_Product] N'Iphone XS Max 512GB',N'/Content/image/iphone/iphoneXS.jpg', 2,39990000,10,1
[dbo].[Proc_Insert_Product] N'Iphone XS 64GB',N'/Content/image/iphone/iphoneXS.jpg', 2,26990000,0,1

[dbo].[Proc_Insert_Product] N'Iphone XS 512GB',N'/Content/image/iphone/iphoneXS.jpg', 2,37990000,0,1
[dbo].[Proc_Insert_Product] N'Iphone XR 64GB',N'/Content/image/iphone/iphoneXR.jpg', 2,17990000,5,1
[dbo].[Proc_Insert_Product] N'Iphone XR 128GB',N'/Content/image/iphone/iphoneXR.jpg', 2,21990000,0,1
[dbo].[Proc_Insert_Product] N'Iphone X 64GB',N'/Content/image/iphone/iphoneX.jpg', 2,20990000,0,1

[dbo].[Proc_Insert_Product] N'Iphone 8 Plus 64GB',N'/Content/image/iphone/iphone8.jpg', 2,1999000,0,1
[dbo].[Proc_Insert_Product] N'Iphone 8 64GB',N'/Content/image/iphone/iphone8.jpg', 2,6990000,13,1
[dbo].[Proc_Insert_Product] N'Iphone 7 Plus 32GB',N'/Content/image/iphone/iphone7.jpg', 2,2490000,0,1
[dbo].[Proc_Insert_Product] N'Iphone 7 32GB',N'/Content/image/iphone/iphone7.jpg', 2,24990000,0,1

update Products
set Display = N'6.1 inchs, 828 x 1792 Pixels',FrontCamera=N'7.0 MP',RearCamera=N'12.0 MP',RAM=N'3G',Memory='256 GB',CPU=N'Apple A12 Bionic, 6',Battery=N'4200 mAh',OS=N'iOS 12',GPU=N'Apple GPU 4 nhân'
where BrandID = 2

--Thêm dữ liệu điện thoại nokia
[dbo].[Proc_Insert_Product] N'Nokia 8.1 ',N'/Content/image/nokia/8.1plus.jpg', 7,6990000,0,1
[dbo].[Proc_Insert_Product] N'Nokia 6.1 Plus ',N'/Content/image/nokia/6.1plus.jpg', 7,4490000,0,1
[dbo].[Proc_Insert_Product] N'Nokia 5.1 Plus',N'/Content/image/nokia/5.1plus.jpg', 7,3290000,0,1
[dbo].[Proc_Insert_Product] N'Nokia 3.1 Plus 32G',N'/Content/image/nokia/3.1plus32g.jpg', 7,2490000,10,1

[dbo].[Proc_Insert_Product] N'Nokia 3.1 Plus 16G',N'/Content/image/nokia/3.1plus.jpg', 7,2290000,0,1
[dbo].[Proc_Insert_Product] N'Nokia 3.2 32G ',N'/Content/image/nokia/3.2_3G.jpg', 7,3690000,20,1
[dbo].[Proc_Insert_Product] N'Nokia 3.2 16G ',N'/Content/image/nokia/3.2_2G.jpg', 7,2990000,0,1
[dbo].[Proc_Insert_Product] N'Nokia 2.2 16G',N'/Content/image/nokia/2.2_2g.jpg', 7,2090000,0,1

update Products
set Display = N'6.1 inchs, 828 x 1792 Pixels',FrontCamera=N'8.0 MP',RearCamera=N'13.0 MP',RAM=N'2G',Memory='16 GB',CPU=N'MediaTek MT6762, 8, 2 GHz',Battery=N'3500 mAh',OS=N'Android 8',GPU=N'PowerVR GE8320'
where BrandID = 7

--Thêm dữ liệu điện thoại opppo
[dbo].[Proc_Insert_Product] N'Oppo F11 Pro',N'/Content/image/oppo/f11-pro.jpg', 3,8490000,0,1
[dbo].[Proc_Insert_Product] N'Oppo F11 Pro 128G',N'/Content/image/oppo/f11-pro128.jpg', 3,8490000,0,1
[dbo].[Proc_Insert_Product] N'Oppo Reno',N'/Content/image/oppo/reno.jpg', 3,12990000,0,1
[dbo].[Proc_Insert_Product] N'Oppo Reno 10x Zoom',N'/Content/image/oppo/reno10x.jpg', 3,20990000,30,1

[dbo].[Proc_Insert_Product] N'Oppo A9x',N'/Content/image/oppo/a9x.jpg', 3,1290000,0,1
[dbo].[Proc_Insert_Product] N'Oppo A3s',N'/Content/image/oppo/a3s.jpg', 3,2990000,0,1
[dbo].[Proc_Insert_Product] N'Oppo A1k',N'/Content/image/oppo/a1k.jpg', 3,3190000,0,1
[dbo].[Proc_Insert_Product] N'Oppo A3s 32G',N'/Content/image/oppo/a3s32.jpg', 3,790000,0,1

[dbo].[Proc_Insert_Product] N'Oppo A5s',N'/Content/image/oppo/a5s.jpg', 3,3990000,0,1
[dbo].[Proc_Insert_Product] N'Oppo A7',N'/Content/image/oppo/a7.jpg', 3,5490000,0,1
[dbo].[Proc_Insert_Product] N'Oppo F9',N'/Content/image/oppo/f9.jpg', 3,6490000,0,1
[dbo].[Proc_Insert_Product] N'Oppo F11',N'/Content/image/oppo/f11.jpg', 3,7290000,0,1


update Products
set Display = N'6.6 inches, 1080 x 2340 Pixels',FrontCamera=N'16.0 MP',RearCamera=N'48.0 MP',RAM=N'8G',Memory='256 GB',CPU=N'Qualcomm® SnapdragonTM 855, 8, 2.8 GHz',Battery=N'4650 mAh',OS=N'Android 9',GPU=N'Adreno 640'
where BrandID = 3

--Thêm dữ liệu điện thoại samsung
[dbo].[Proc_Insert_Product] N'Samsung Galaxy A80',N'/Content/image/samsung/sa80.jpg', 1,14990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S10+ 1TB',N'/Content/image/samsung/s10plus.jpg', 1,23990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S10+ 512TB',N'/Content/image/samsung/s10plus.jpg', 1,28990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S10+ 128GB',N'/Content/image/samsung/s10plus.jpg', 1,22990000,0,1

[dbo].[Proc_Insert_Product] N'Samsung Note 9 128GB',N'/Content/image/samsung/note9.jpg', 1,19990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S10',N'/Content/image/samsung/s10.jpg', 1,20990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S9+ ',N'/Content/image/samsung/s9plus.jpg', 1,17990000,10,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S9',N'/Content/image/samsung/s9.jpg', 1,16490000,0,1

[dbo].[Proc_Insert_Product] N'Samsung Galaxy S8+',N'/Content/image/samsung/s8plus.jpg', 1,14490000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy S10e',N'/Content/image/samsung/s10e.jpg', 1,15990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy A9 2018',N'/Content/image/samsung/a9.jpg', 1,8990000,0,1
[dbo].[Proc_Insert_Product] N'Samsung Galaxy A70',N'/Content/image/samsung/sa70.jpg', 1,9290000,0,1

update Products
set Display = N'6.1 inches, 1440 x 3040 pixels',FrontCamera=N'10.0 MP',RearCamera=N'16.0 MP',RAM=N'8G',Memory='128 GB',CPU=N'Exynos 9820 8 nhân 64-bit',Battery=N'3650 mAh',OS=N'Android 9',GPU=N'Mali-G76 MP12'
where BrandID = 1

--Thêm dữ liệu điện thoại vsmart
[dbo].[Proc_Insert_Product] N'VSmart Active 1+',N'/Content/image/vsmart/activeplus.jpg', 6,5790000,0,1
[dbo].[Proc_Insert_Product] N'VSmart Active 1',N'/Content/image/vsmart/active1.jpg', 6,3990000,0,1
[dbo].[Proc_Insert_Product] N'VSmart Joy 1+',N'/Content/image/vsmart/joy1plus.jpg', 6,2990000,0,1
[dbo].[Proc_Insert_Product] N'VSmart Joy 1',N'/Content/image/vsmart/joy1.jpg', 6,1990000,0,1

update Products
set Display = N'5.65 inches, 1080 x 2160 Pixels',FrontCamera=N'8.0 MP',RearCamera=N'12.0 MP',RAM=N'4G',Memory='64 GB',CPU=N'Qualcomm Snapdragon 660',Battery=N'3100 mAh',OS=N'Android 8.1',GPU=N'Adreno 512'
where BrandID = 6 

--Thêm dữ liệu điện thoại  xiaomi
[dbo].[Proc_Insert_Product] N'Xiaomi Mi 9',N'/Content/image/xiaomi/mi_9.jpg', 5,11990000,10,1
[dbo].[Proc_Insert_Product] N'Xiaomi Mi 9 SE',N'/Content/image/xiaomi/mi9_se.jpg', 5,8490000,0,1
[dbo].[Proc_Insert_Product] N'Xiaomi F1',N'/Content/image/xiaomi/f1.jpg', 5,7999000,0,1
[dbo].[Proc_Insert_Product] N'Xiaomi Mi 8 Lite',N'/Content/image/xiaomi/mi8.jpg', 5,9490000,5,1

[dbo].[Proc_Insert_Product] N'Xiaomi Mi 9T 128GB',N'/Content/image/xiaomi/mi_9t128.jpg', 5,8999000,0,1
[dbo].[Proc_Insert_Product] N'Xiaomi Mi 9T 64G',N'/Content/image/xiaomi/mi_9t.jpg', 5,5999000,3,1
[dbo].[Proc_Insert_Product] N'Xiaomi A3 64GB',N'/Content/image/xiaomi/mi_a3.jpg', 5,3990000,0,1
[dbo].[Proc_Insert_Product] N'Xiaomi Redmi 7A',N'/Content/image/xiaomi/7a.jpg', 5,3690000,8,1

update Products
set Display = N'5.97 inches, 1080 x 2340 Pixels',FrontCamera=N'20.0 MP',RearCamera=N'48.0 MP',RAM=N'6G',Memory='64 GB',CPU=N'Snap dragon 712, 8, 2.3Ghz',Battery=N'3100 mAh',OS=N'Android 9',GPU=N'Adreno 616'
where BrandID = 5




SELECT * FROM Brands
select * from Products
select * from Categories
select * from ProductCategory
delete from Brands
