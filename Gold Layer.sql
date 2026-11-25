use SupplyChain;
GO

-- ==================================== Gold Dimension Date  ==================================== --
create table [Gold].[DimDate] 
(
	Date_key int not null primary key ,
	Full_date Date not null ,
	[Year] int not null ,
	[Quarter] int not null ,
	[Month] int not null ,
	Month_name varchar(20) not null ,
	[Day] int not null ,
	Day_name varchar(20) not null ,
	Is_weekend bit not null 
);
Go


Declare @Start_Date      Date, 
		@End_Date        Date, 
		@Current_Date    Date ; 

SELECT 
    @Start_Date = MIN(CAST([order date] AS DATE)),
    @End_Date = MAX(CAST([shipping date] AS DATE))
FROM Silver.Orders;


SET @Current_Date = @Start_Date;

WHILE @Current_Date <= @End_Date
BEGIN
    INSERT INTO [Gold].[DimDate] (
        Date_key,
        Full_date,
        [Year],
        [Quarter],
        [Month],
        Month_name,
        [Day],
        Day_name,
        Is_weekend
    )
    VALUES (
        CAST(FORMAT(@Current_Date, 'yyyyMMdd') AS INT),
        @Current_Date,
        YEAR(@Current_Date),
        DATEPART(QUARTER, @Current_Date),
        MONTH(@Current_Date),
        DATENAME(MONTH, @Current_Date),
        DAY(@Current_Date),
        DATENAME(WEEKDAY, @Current_Date),
        CASE WHEN DATENAME(WEEKDAY, @Current_Date) IN ('Friday', 'Saturday') THEN 1 ELSE 0 END
    );

    SET @Current_Date = DATEADD(DAY, 1, @Current_Date);
END ;
Go


select *
from Gold.DimDate


-- ==================================== Gold DimCustomer  ==================================== --

select * 
into [Gold].[DimCustomer]
from [Silver].[customers] ;

Alter Table [Gold].[DimCustomer] alter column Customer_id bigint not null ;
Alter Table [Gold].[DimCustomer] add constraint PK_Gold_DimCustomer Primary key (Customer_id) ;

select top 5 *
from [Gold].[DimCustomer] ;


-- ==================================== Gold DimProduct  ==================================== --

select * 
into [Gold].[DimProducts]
from [Silver].[Products]

Alter Table [Gold].[DimProducts] alter column Product_id bigint not null ;
Alter Table [Gold].[DimProducts] add constraint PK_Gold_DimProduct Primary key (Product_id) ;

select top 5 *
from [Gold].[DimProducts] ;

-- ==================================== Gold Dim Sales man  ==================================== --

select * 
into [Gold].[DimSalesman]
from [Silver].[Salesman]

Alter Table [Gold].[DimSalesman] alter column [Salesman Id] bigint not null ;
Alter Table [Gold].[DimSalesman] add constraint PK_Gold_DimSalesman Primary key ([Salesman Id]) ;

select top 5 *
from [Gold].[DimSalesman] ;

-- ==================================== Gold DimOrders  ==================================== --

SELECT 
    Order_Item_Id,
    Order_Id,
    Customer_id,
    Product_id,
    Salesman_id,
    CAST(FORMAT([order date], 'yyyyMMdd') AS INT)    AS Order_Date_Key,
    CAST(FORMAT([shipping date], 'yyyyMMdd') AS INT) AS Shipping_Date_Key,
    [Type],
    [Order Status],
    [Shipping Mode],
    [Delivery Status],
    Late_Delivery_Status,
    REPLACE([Market], 'Eutope', 'Europe') AS Market,
    [Order Region],
    [Order State],
    [order date],
    [shipping date],
    [Days for shipping (real)],
    [Days for shipment (scheduled)],
    ([Days for shipping (real)] - [Days for shipment (scheduled)]) AS Shipping_Delay_Days,
    Order_Item_Quantity,
    Order_Item_Total,
    Order_Item_Discount,
    Order_Item_Profit_Ratio,
    Benefit_Per_Order
INTO [Gold].[DimOrders]
FROM [Silver].[Orders];


-- Primary Key
ALTER TABLE [Gold].[DimOrders] ALTER COLUMN Order_Item_Id BIGINT NOT NULL;
ALTER TABLE [Gold].[DimOrders] ADD CONSTRAINT PK_Gold_DimOrders PRIMARY KEY (Order_Item_Id);


-- Foreign Keys
ALTER TABLE [Gold].[DimOrders]
    ADD CONSTRAINT FK_DimOrders_Customer     FOREIGN KEY (Customer_id)       REFERENCES [Gold].[DimCustomer](Customer_id),
        CONSTRAINT FK_DimOrders_Product      FOREIGN KEY (Product_id)        REFERENCES [Gold].[DimProducts](Product_id),
        CONSTRAINT FK_DimOrders_Salesman     FOREIGN KEY (Salesman_id)       REFERENCES [Gold].[DimSalesman]([Salesman Id]),
        CONSTRAINT FK_DimOrders_OrderDate    FOREIGN KEY (Order_Date_Key)    REFERENCES [Gold].[DimDate](Date_key),
        CONSTRAINT FK_DimOrders_ShippingDate FOREIGN KEY (Shipping_Date_Key) REFERENCES [Gold].[DimDate](Date_key);

-- ==================================== Indexes  ==================================== --

CREATE INDEX IX_DimOrders_CustomerId        ON [Gold].[DimOrders] (Customer_id);
CREATE INDEX IX_DimOrders_ProductId         ON [Gold].[DimOrders] (Product_id);
CREATE INDEX IX_DimOrders_SalesmanId        ON [Gold].[DimOrders] (Salesman_id);
CREATE INDEX IX_DimOrders_OrderDateKey      ON [Gold].[DimOrders] (Order_Date_Key);
CREATE INDEX IX_DimOrders_ShippingDateKey   ON [Gold].[DimOrders] (Shipping_Date_Key);
 