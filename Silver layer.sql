use SupplyChain;
GO

select * from Bronze.Customers
select * from Bronze.Products
select * from Bronze.Salesman
select * from Bronze.Orders

-- ==================================== 1. table silver customer ==================================== --
select 

	TRY_CAST([Customer Id] as bigint) as Customer_id ,
	CONCAT(TRIM([Customer Fname]), ' ', COALESCE(TRIM([Customer Lname]), '')) AS full_name,
	isnull(ltrim(rtrim( [Customer Segment])),'unknown' ) as [Customer Segment] ,
	isnull(ltrim(rtrim( [Customer City])),'unknown' ) as [Customer City] ,
	isnull(ltrim(rtrim( [Customer State])),'unknown' ) as [Customer State] ,
	isnull(ltrim(rtrim( [Customer Street])),'unknown' ) as [Customer Street] ,
	isnull(ltrim(rtrim( [Customer Zipcode])),'unknown' ) as [Customer Zipcode] ,
	isnull(ltrim(rtrim( [Customer Country])),'unknown' ) as [Customer Country],
	TRY_CAST(Latitude as decimal(9,4) )as Latitude ,
	TRY_CAST(Longitude as decimal(9,4)) as Longitude ,
	TRY_CAST([Customer Birth Date] as Date ) as [Customer Birth Date],
	DATEDIFF(YEAR, TRY_CAST([Customer Birth Date] AS DATE), GETDATE()) 
	- CASE 
		WHEN DATEADD(YEAR, DATEDIFF(YEAR, TRY_CAST([Customer Birth Date] AS DATE), GETDATE()), TRY_CAST([Customer Birth Date] AS DATE)) > GETDATE() 
		THEN 1 
		ELSE 0 
  END AS Age


into [Silver].[Customers]
from [Bronze].[Customers] ;

Alter Table [Silver].[Customers] alter column Customer_id bigint not null ;
Alter Table [Silver].[Customers] add constraint PK_silver_customer Primary key (Customer_id) ;

select top 5 *
from [Silver].[Customers] ;
 

select *
from [Silver].[Customers] ;

-- ==================================== 2. table silver Products ==================================== --

select 

	TRY_CAST([Product Card Id] as bigint) as Product_id ,
	isnull(ltrim(rtrim( [Product Name])),'unknown' ) as [Product Name] ,
	TRY_CAST([Product Price] as decimal(9,4) )as [Product Price] ,
	TRY_CAST([Category Id] as int) as [Category Id] ,
	isnull(ltrim(rtrim( [Category Name])),'unknown' ) as [Category Name] ,
	TRY_CAST([Department Id] as int) as [Department Id] ,
	isnull(ltrim(rtrim( [Department Name])),'unknown' ) as [Department Name] 

into [Silver].[Products]
from [Bronze].[Products] ;

Alter Table [Silver].[Products] alter column Product_id bigint not null ;
Alter Table [Silver].[Products] add constraint PK_silver_product Primary key (Product_id) ;

select *
from [Silver].Products ;


-- ==================================== 3. table silver Sales man ==================================== --

select 

	TRY_CAST([Salesman Id] as bigint) as [Salesman Id] ,
	CONCAT(TRIM([Salesman Fname]), ' ', COALESCE(TRIM([Salesman Lname]), '')) AS full_name,
	isnull(ltrim(rtrim( [Salesman Email])),'unknown' ) as [Salesman Email] ,
	isnull(ltrim(rtrim( Market)),'unknown' ) as Market ,
	ISNULL(NULLIF(REPLACE(LTRIM(RTRIM([Region])), '  ', ' '), ''), 'Unknown') AS Region,
	TRY_CAST([Commission Rate] as decimal(9,4) )as [Commission Rate] ,
	TRY_CAST([Hire Date] as Date ) as [Hire Date],
	DATEDIFF(YEAR, TRY_CAST(TRIM([Hire Date]) AS DATE), GETDATE()) 
    - CASE 
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, TRY_CAST(TRIM([Hire Date]) AS DATE), GETDATE()), TRY_CAST(TRIM([Hire Date]) AS DATE)) > GETDATE() 
        THEN 1 
        ELSE 0 
      END AS Years_In_Company

into [Silver].[Salesman]
from [Bronze].[Salesman] ;

Alter Table [Silver].[Salesman] alter column [Salesman Id] bigint not null ;
Alter Table [Silver].[Salesman] add constraint PK_silver_salesman Primary key ([Salesman Id]) ;

select *
from [Silver].[Salesman] ;

-- ==================================== 3. table silver Orders ==================================== --

SELECT distinct
    TRY_CAST(TRIM([Order Item Id]) AS BIGINT) AS Order_Item_Id,
    TRY_CAST(TRIM([Order Id]) AS BIGINT) AS Order_Id,
    TRY_CAST(TRIM([Customer Id]) AS BIGINT) AS Customer_id,
    TRY_CAST(TRIM([Product Card Id]) AS BIGINT) AS Product_id,
    TRY_CAST(TRIM([salesman_id]) AS BIGINT) AS Salesman_id,
	isnull(ltrim(rtrim( [Type])),'unknown' ) as [Type] ,
	
	TRY_CAST(TRIM([Days for shipping (real)]) AS INT) AS [Days for shipping (real)],
	TRY_CAST(TRIM([Days for shipment (scheduled)]) AS INT) AS [Days for shipment (scheduled)],

    TRY_CAST(TRIM([Benefit per order]) AS DECIMAL(12,4)) AS Benefit_Per_Order ,

	case 
			when lower(trim([Delivery Status])) in ('shipping on time','shipping  on time') then 'shipping on time'
			when lower(trim([Delivery Status])) in ('shipping canceled','shipping  canceled') then 'shipping canceled'
			when lower(trim([Delivery Status])) in ('advance  shipping','advance shipping') then 'advance shipping'
			when lower(trim([Delivery Status])) in ('late  delivery','late delivery') then 'late delivery'
	end as [Delivery Status],

	CASE TRY_CAST(TRIM([Late_delivery_risk]) AS INT)
		WHEN 1 THEN 'Late'
		WHEN 0 THEN 'Not Late'
		ELSE 'Unknown'
    END AS Late_Delivery_Status,

	case 
			when lower(trim([Market])) in ('africa','afr') then 'Africa'
			when lower(trim([Market])) in ('eu','europe') then 'Eutope'
			when lower(trim([Market])) in ('latin  america','latin america','latam') then 'LATAM'
			when lower(trim([Market])) in ('asia-pacific','apac','pacific  asia','pacific asia') then 'Pacific Asia'
			when lower(trim([Market])) in ('us  & canada','u.s.-canada','us & canada','usca','us and canada','us  and canada') then 'USCA'
	end as [Market] ,
	isnull(ltrim(rtrim( [Order Region])),'unknown' ) as [Order Region] ,
	isnull(ltrim(rtrim( [Order State])),'unknown' ) as [Order State] ,

	isnull(ltrim(rtrim( [Order Status])),'unknown' ) as [Order Status] ,
	TRY_CAST([order date (DateOrders)]as Date ) as [order date],
	TRY_CAST([shipping date (DateOrders)] as Date ) as [shipping date],

	case 
		when lower(trim([Shipping Mode])) in ('same day','same  day','same-day') then 'Same Day'
		when lower(trim([Shipping Mode])) in ('1st  class','first  class','first class','1st class') then 'First Class'
		when lower(trim([Shipping Mode])) in ('second class','2nd  class','2nd class','second  class') then 'Second Class'
		when lower(trim([Shipping Mode])) in ('standard  class','standard','standard class','std class','std  class') then 'standard class'
	end as [Shipping Mode],
	
	TRY_CAST(TRIM([Order Item Discount]) AS DECIMAL(12,4)) AS Order_Item_Discount,
    TRY_CAST(TRIM([Order Item Profit Ratio]) AS DECIMAL(12,4)) AS Order_Item_Profit_Ratio,
    TRY_CAST(TRIM([Order Item Quantity]) AS INT) AS Order_Item_Quantity,
    TRY_CAST(TRIM([Order Item Total]) AS DECIMAL(12,4)) AS Order_Item_Total

INTO [Silver].[Orders]
FROM [Bronze].[Orders];

Alter Table [Silver].[Orders] alter column Order_Item_Id bigint not null ;
Alter Table [Silver].[Orders] add constraint PK_silver_orders Primary key (Order_Item_Id) ;


select top 5 *
from [Silver].[Orders] ;
