use SupplyChain;
Go


-- === Table Customer ===== 

select * 
from [Bronze].[Customers] ;

-- ================ 1-Nulls -- ========================
select 

	sum (case when [Customer Id] is null or [Customer Id] ='' then 1 else 0 end) as blank_id,
	sum (case when [Customer Fname] is null or [Customer Fname] ='' then 1 else 0 end) as blank_Customer_Fname,
	-- there is nulls on the table of last name
	sum (case when [Customer Lname] is null or [Customer Lname] ='' then 1 else 0 end) as blank_Customer_Lname,
	
	sum (case when [Customer Segment] is null or [Customer Segment] ='' then 1 else 0 end) as blank_Customer_Segment,
	sum (case when [Customer City] is null or [Customer City] ='' then 1 else 0 end) as blank_Customer_City,
	sum (case when [Customer State] is null or [Customer State] ='' then 1 else 0 end) as blank_Customer_State,
	sum (case when [Customer Street] is null or [Customer Street] ='' then 1 else 0 end) as blank_Customer_Street,
	sum (case when [Customer Zipcode] is null or [Customer Zipcode] ='' then 1 else 0 end) as blank_Customer_Zipcode,
	sum (case when [Customer Country] is null or [Customer Country] ='' then 1 else 0 end) as blank_Customer_Country,
	sum (case when [Customer Birth Date] is null or [Customer Birth Date] ='' then 1 else 0 end) as blank_Customer_Birth_Date

from [Bronze].[Customers] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Customers] 
where TRY_CAST([Customer Id] as int ) is null ;


select * 
from [Bronze].[Customers] 
where TRY_CAST([Customer Birth Date] as Date ) is null ;

select * 
from [Bronze].[Customers] 
where TRY_CAST([Customer Zipcode] as INT ) is null ;

-- ================ 3-check range  -- ========================

select min([Customer Birth Date]) as min_date_of_birth , max([Customer Birth Date]) as max_date_of_birth
from [Bronze].[Customers] ;

-- ================ 4-inconsistent category values -- ========================

select distinct [Customer Segment] 
from [Bronze].[customers] ;

select distinct [Customer Segment] ,count(*) as CNT	 
from [Bronze].[Customers] 
group by [Customer Segment] ;

-- email & password hashing 
select distinct [Customer Email] ,[Customer Password] 
from [Bronze].[customers] ;

-- ================ 5- Duplicates IDs -- ========================
-- PRIMARY KEY 
select [Customer Id], count(*) as CNT
from [Bronze].[Customers] 
group by [Customer Id]
having count(*) >1 ;

-- ================ 6- Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Customers] ;



-- === Table Products ===== 

select * 
from [Bronze].[Products] ;

-- ================ 1-Nulls -- ========================
select 
-- there is no missing data
	sum (case when [Product Card Id] is null or [Product Card Id] ='' then 1 else 0 end) as blank_Product_CardId,
	sum (case when [Product Name] is null or [Product Name] ='' then 1 else 0 end) as blank__Product_Name,
	sum (case when [Product Price] is null or [Product Price] ='' then 1 else 0 end) as blank_Product_Price,
	sum (case when [Category Id] is null or [Category Id] ='' then 1 else 0 end) as blank_CategoryId,
	sum (case when [Department Id] is null or [Department Id] ='' then 1 else 0 end) as blank_DepartmentId,
	sum (case when [Category Name] is null or [Category Name] ='' then 1 else 0 end) as blank_Category_name,
	sum (case when [Department Name] is null or [Department Name] ='' then 1 else 0 end) as blank_Department_name

from [Bronze].[Products] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Products] 
where TRY_CAST([Product Card Id] as int ) is null ;


select * 
from [Bronze].[Products] 
where TRY_CAST([Product Price] as decimal(18,2) ) is null ;

-- ================ 4-inconsistent category values -- ========================

select distinct [Product Status] ,count(*) as CNT	 
from [Bronze].[Products] 
group by [Product Status] ;

select distinct [Category Name] ,count(*) as CNT	 
from [Bronze].[Products] 
group by [Category Name] ;

select distinct [Department Name] ,count(*) as CNT	 
from [Bronze].[Products] 
group by [Department Name] ;

-- ================ 5- Duplicates IDs -- ========================

select [Product Card Id], count(*) as CNT
from [Bronze].[Products] 
group by [Product Card Id]
having count(*) >1 ;

-- ================ 6- Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Products] ;


-- === Table Sales man  ===== 

select * 
from [Bronze].[Salesman] ;

-- ================ 1-Nulls -- ========================
select 
--  there is no missing values

	sum (case when [Salesman Id] is null or [Salesman Id] ='' then 1 else 0 end) as blank_Salesman_Id,
	sum (case when [Salesman Fname] is null or [Salesman Fname] ='' then 1 else 0 end) as blank__Salesman_Fname,
	sum (case when [Salesman Lname] is null or [Salesman Lname] ='' then 1 else 0 end) as blank__Salesman_Lname,
	sum (case when [Salesman Email] is null or [Salesman Email] ='' then 1 else 0 end) as blank_Salesman_Email,
	sum (case when Market is null or Market ='' then 1 else 0 end) as blank_Market,
	sum (case when Region is null or Region ='' then 1 else 0 end) as blank_Region,
	sum (case when [Hire Date] is null or [Hire Date] ='' then 1 else 0 end) as blank_Hire_Date,
	sum (case when [Commission Rate] is null or [Commission Rate] ='' then 1 else 0 end) as blank_Commission_Rate

from [Bronze].[Salesman] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Salesman] 
where TRY_CAST([Salesman Id] as int ) is null ;


select * 
from [Bronze].[Salesman] 
where TRY_CAST([Commission Rate] as decimal(18,2) ) is null ;

select * 
from [Bronze].[Salesman] 
where TRY_CAST([Hire Date] as Date ) is null ;


-- ================ 4-inconsistent category values -- ========================

select distinct Market ,count(*) as CNT	 
from [Bronze].[Salesman] 
group by Market ;

select distinct Region ,count(*) as CNT	 
from [Bronze].[Salesman] 
group by Region ;


-- ================ 5- Duplicates IDs -- ========================

select [Salesman Id], count(*) as CNT
from [Bronze].[Salesman] 
group by [Salesman Id]
having count(*) >1 ;

-- ================ 6- Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Salesman] ;


-- === Table Orders === 

select * 
from [Bronze].[Orders] ;

-- ================ 1-Nulls -- ========================

select 

	sum (case when [Order Id] is null or [Order Id] ='' then 1 else 0 end) as blank_Order_Id,
	sum (case when [Order Item Id] is null or [Order Item Id] ='' then 1 else 0 end) as blank_Order_Item_Id,
	sum (case when [Customer Id] is null or [Customer Id] ='' then 1 else 0 end) as blank_Customer_Id,
	sum (case when [Product Card Id] is null or [Product Card Id] ='' then 1 else 0 end) as blank_Product_Card_Id,
	sum (case when [Type] is null or [Type] ='' then 1 else 0 end) as blank_Type,
	sum (case when [Days for shipping (real)] is null or [Days for shipping (real)] ='' then 1 else 0 end) as blank_Days_for_shipping_real,
	sum (case when [Days for shipment (scheduled)] is null or [Days for shipment (scheduled)] ='' then 1 else 0 end) as blank_Days_for_shipment_scheduled,
	SUM(CASE WHEN [Benefit per order] IS NULL OR [Benefit per order] = '' THEN 1 ELSE 0 END) AS blank_Benefit_per_order,
	SUM(CASE WHEN [Delivery Status] IS NULL OR [Delivery Status] = '' THEN 1 ELSE 0 END) AS blank_Delivery_Status,
    SUM(CASE WHEN [Late_delivery_risk] IS NULL OR[Late_delivery_risk] = '' THEN 1 ELSE 0 END) AS blank_Late_delivery_risk,
    SUM(CASE WHEN [Market] IS NULL OR [Market] = '' THEN 1 ELSE 0 END) AS blank_Market,
    SUM(CASE WHEN [Order Region] IS NULL OR [Order Region] = '' THEN 1 ELSE 0 END) AS blank_Order_Region,
    SUM(CASE WHEN [Order State] IS NULL OR [Order State] = '' THEN 1 ELSE 0 END) AS blank_Order_State,
    SUM(CASE WHEN [Order Status] IS NULL OR [Order Status] = '' THEN 1 ELSE 0 END) AS blank_Order_Status,
    -- there is large number of nullon the column of zipcode 
	SUM(CASE WHEN [Order Zipcode] IS NULL OR [Order Zipcode] = '' THEN 1 ELSE 0 END) AS blank_Order_Zipcode,
    SUM(CASE WHEN [order date (DateOrders)] IS NULL OR [order date (DateOrders)]= '' THEN 1 ELSE 0 END) AS blank_order_date,
    SUM(CASE WHEN [shipping date (DateOrders)] IS NULL OR [shipping date (DateOrders)]= '' THEN 1 ELSE 0 END) AS blank_shipping_date,
    SUM(CASE WHEN [Shipping Mode] IS NULL OR [Shipping Mode]= '' THEN 1 ELSE 0 END) AS blank_Shipping_Mode,
    SUM(CASE WHEN [Order Item Discount] IS NULL OR [Order Item Discount]= '' THEN 1 ELSE 0 END) AS blank_Order_Item_Discount,
    SUM(CASE WHEN [Order Item Profit Ratio] IS NULL OR [Order Item Profit Ratio] = '' THEN 1 ELSE 0 END) AS blank_Order_Item_Profit_Ratio,
    SUM(CASE WHEN [Order Item Quantity] IS NULL OR[Order Item Quantity]= '' THEN 1 ELSE 0 END) AS blank_Order_Item_Quantity,
    SUM(CASE WHEN [Order Item Total] IS NULL OR [Order Item Total]= '' THEN 1 ELSE 0 END) AS blank_Order_Item_Total,
    SUM(CASE WHEN [salesman_id] IS NULL OR [salesman_id] = '' THEN 1 ELSE 0 END) AS blank_salesman_id

from [Bronze].[Orders] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Id] as int ) is null ;


select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Item Id] as int ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Days for shipping (real)] as int ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Days for shipment (scheduled)] as int ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([order date (DateOrders)] as date ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([shipping date (DateOrders)] as date ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Item Discount] as decimal(18,2) ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Item Profit Ratio] as decimal(18,2) ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Item Total] as decimal(18,2) ) is null ;

select * 
from [Bronze].[Orders] 
where TRY_CAST([Order Item Quantity] as int ) is null ;

-- ================ 4-inconsistent category values -- ========================

select distinct [type] ,count(*) as CNT	 
from [Bronze].[Orders] 
group by [type] ;

select distinct lower(trim([type])) 
from [Bronze].[Orders] ;

select distinct 
		case 
			when lower(trim([Delivery Status])) in ('shipping on time','shipping  on time') then 'shipping on time'
			when lower(trim([Delivery Status])) in ('shipping canceled','shipping  canceled') then 'shipping canceled'
			when lower(trim([Delivery Status])) in ('advance  shipping','advance shipping') then 'advance shipping'
			when lower(trim([Delivery Status])) in ('late  delivery','late delivery') then 'late delivery'
		end as [Delivery Status]
from [Bronze].[Orders] ;

select distinct lower(trim([Market])) 
from [Bronze].[Orders] ;


select distinct 
		case 
			when lower(trim([Market])) in ('africa','afr') then 'Africa'
			when lower(trim([Market])) in ('eu','europe') then 'Eutope'
			when lower(trim([Market])) in ('latin  america','latin america','latam') then 'LATAM'
			when lower(trim([Market])) in ('asia-pacific','apac','pacific  asia','pacific asia') then 'Pacific Asia'
			when lower(trim([Market])) in ('us  & canada','u.s.-canada','us & canada','usca','us and canada','us  and canada') then 'USCA'
		end as [Market]
from [Bronze].[Orders] ;

select distinct lower(trim([Order Status])) 
from [Bronze].[Orders] ;



----------------------------------------------------------
----------------------------------------------------------
select distinct lower(trim([Order Region])) 
from [Bronze].[Orders] ;

-------------------------------------------------------
SELECT DISTINCT 
   LOWER(TRIM([Order State])) AS Cleaned_State
FROM [Bronze].[Orders]
ORDER BY Cleaned_State;

-------------------------------------------------------

select distinct lower(trim([Order Status])) 
from [Bronze].[Orders] ;

select distinct lower(trim([Shipping Mode])) 
from [Bronze].[Orders] ;

select distinct 
		case 
			when lower(trim([Shipping Mode])) in ('same day','same  day','same-day') then 'Same Day'
			when lower(trim([Shipping Mode])) in ('1st  class','first  class','first class','1st class') then 'First Class'
			when lower(trim([Shipping Mode])) in ('second class','2nd  class','2nd class','second  class') then 'Second Class'
			when lower(trim([Shipping Mode])) in ('standard  class','standard','standard class','std class','std  class') then 'standard class'
		end as [Shipping Mode]
from [Bronze].[Orders] ;

-- ================ 5- Duplicates IDs -- ========================

select [Order Item Id], count(*) as CNT
from [Bronze].[Orders] 
group by [Order Item Id]
having count(*) >1 ;


select [Order Item Id], count(*) as CNT
from [Bronze].[Orders] 
group by [Order Item Id] ,[Order Id]
having count(*) >1 ;

-- ================ 6- Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Orders] ;