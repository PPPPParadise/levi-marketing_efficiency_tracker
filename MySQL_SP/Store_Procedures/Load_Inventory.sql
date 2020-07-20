create
    definer = pkishlay@`%` procedure Load_Inventory()
BEGIN
    /*
    truncate table Stg_Inventory
    
    load data local infile 'D:\\Data\\Inventory\\AMA_Inventory_WKLY_20190805.txt'
    into table Stg_Inventory
    fields terminated by '|'
    lines terminated by '\n'
    ignore 1 lines
    (@Affiliate,@Sales_Org,@Customer_Code,@Product_Code,@Stock_Category,@Fiscal_Month,@Fiscal_Week,@On_Hand_QTY)
    set
    `Affiliate`=@Affiliate,        
    `Sales_Org`=@Sales_Org,        
    `Customer_Code`=@Customer_Code,    
    `Product_Code`=replace(@Product_Code,'-','')  ,   
    `Stock_Category`=@Stock_Category ,  
    `Fiscal_Month`=concat(substring(@Fiscal_Month,1,4),substring(@Fiscal_Month,6,2))    , 
    `Fiscal_Week`=@Fiscal_Week      ,
    `On_Hand_QTY`=@On_Hand_QTY;
    
    */

    insert into Inventory(Affiliate, Sales_Org, Country, Customer_Code, Product_Code, Stock_Category, Fiscal_Month,
                          Fiscal_Week, On_Hand_QTY)
    select S.Affiliate,
           S.Sales_Org,
           M.Country,
           S.Customer_Code,
           S.Product_Code,
           S.Stock_Category,
           (SELECT CASE WHEN SUBSTR(Fiscal_Month, 5, 2) = '01' THEN Fiscal_Month - 89 ELSE S.Fiscal_Month - 1 END),
           S.Fiscal_Week,
           S.On_Hand_QTY
    from Stg_Inventory as S
             inner join Map_CompanyCode_Country as M
                        on S.Sales_Org = M.Sales_Org
    where Fiscal_Week = (select max(Fiscal_Week) from Stg_Inventory);

END;


