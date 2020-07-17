create
    definer = pkishlay@`%` procedure Load_Dim_Customer()
BEGIN

    /*
    Truncate table Stg_MET_Customer;
    LOAD DATA LOCAL INFILE 'D:\\Data\\2019_September\\Customer\\AMA_Customer_20191001.txt'
        INTO TABLE Stg_MET_Customer
        FIELDS TERMINATED BY '|' 
        LINES TERMINATED BY  '\n'		
        IGNORE 1 LINES
        (@Sales_Org, @Company_Code, @Company_Name, @Sold_to_Code, @Sold_to_Name, @Ship_to_Code, @Ship_to_Name, @Business_Model_Name,
        @Channel, @Store_Type, @Global_Retail_Segment, @Region, @MD_Geography, @Country_Region, @Territory_Country, @District, @Franchise_Partner, 
        @Store_Opening_Date, @Store_Closing_Date, @Currency_Code)
        SET Sales_Org = REPLACE(@Sales_Org , '\0',''),
     Company_Code = REPLACE(@Company_Name , '\0',''),
     Company_Name = REPLACE(@Company_Code , '\0',''),
     Sold_to_Code = REPLACE(@Sold_to_Code , '\0',''),
     Sold_to_Name = REPLACE(@Sold_to_Name , '\0',''),
     Ship_to_Code = REPLACE(@Ship_to_Code , '\0',''),
     Ship_to_Name = REPLACE(@Ship_to_Name , '\0',''),
     Business_Model_Name = REPLACE(@Business_Model_Name , '\0',''),
     Channel = REPLACE(@Channel , '\0',''),
     Store_Type = REPLACE(@Store_Type , '\0',''),
     Global_Retail_Segment = REPLACE(@Global_Retail_Segment , '\0',''),
     Region = REPLACE(@Region , '\0',''),
     MD_Geography = REPLACE(@MD_Geography , '\0',''),
     Country_Region = REPLACE(@Country_Region , '\0',''),
     Territory_Country = REPLACE(@Territory_Country , '\0',''),
     District = REPLACE(@District , '\0',''),
     Franchise_Partner = REPLACE(@Franchise_Partner , '\0',''),
     Store_Opening_Date = REPLACE(@Store_Opening_Date , '\0',''),
     Store_Closing_Date = REPLACE(@Store_Closing_Date , '\0',''),
     Currency_Code = REPLACE(@Currency_Code , '\0','');
    */
    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Dim_Customer(Customer_Unique_Key, Sales_Org, Company_Code,
                             Company_Name, Sold_to_Code, Sold_to_Name,
                             Sold_to_Local_Name, Ship_to_Code, Ship_to_Name,
                             Ship_to_Local_Name, Business_Model, Business_Model_Name,
                             Channel, Store_Type, Global_Retail_Segment,
                             Region, MD_Geography, Country_Region,
                             Territory_Country, District, Franchise_Partner,
                             Store_Opening_Date, Store_Closing_Date, Currency_Code)
    SELECT CONCAT(M.Country, '_', Ship_to_Code) Customer_Unique_Key,
           S.Company_Code,
           CASE WHEN LENGTH(S.Sales_Org) = 3 THEN CONCAT('0', S.Sales_Org) ELSE S.Sales_Org END,
           M.Country,
           Sold_to_Code,
           Sold_to_Name,
           Sold_to_Local_Name,
           Ship_to_Code,
           Ship_to_Name,
           Ship_to_Local_Name,
           Business_Model,
           Business_Model_Name,
           Channel,
           Store_Type,
           Global_Retail_Segment,
           Region,
           S.MD_Geography,
           Country_Region,
           Territory_Country,
           District,
           Franchise_Partner,
           Store_Opening_Date,
           Store_Closing_Date,
           S.Currency_Code
    FROM Stg_MET_Customer S,
         Map_CompanyCode_Country M
    WHERE S.Company_Code = M.Sales_Org
    ON DUPLICATE KEY UPDATE Dim_Customer.Sales_Org             = S.Company_Code,
                            Dim_Customer.Company_Name          = S.Company_Name,
                            Dim_Customer.Sold_to_Code          = S.Sold_to_Code,
                            Dim_Customer.Sold_to_Name          = S.Sold_to_Name,
                            Dim_Customer.Sold_to_Local_Name    = S.Sold_to_Local_Name,
                            Dim_Customer.Ship_to_Name          = S.Ship_to_Name,
                            Dim_Customer.Ship_to_Local_Name    = S.Ship_to_Local_Name,
                            Dim_Customer.Business_Model        = S.Business_Model,
                            Dim_Customer.Business_Model_Name   = S.Business_Model_Name,
                            Dim_Customer.Channel               = S.Channel,
                            Dim_Customer.Store_Type            = S.Store_Type,
                            Dim_Customer.Global_Retail_Segment = S.Global_Retail_Segment,
                            Dim_Customer.Region                = S.Region,
                            Dim_Customer.MD_Geography          = S.MD_Geography,
                            Dim_Customer.Country_Region        = S.Country_Region,
                            Dim_Customer.Territory_Country     = S.Territory_Country,
                            Dim_Customer.District              = S.District,
                            Dim_Customer.Franchise_Partner     = S.Franchise_Partner,
                            Dim_Customer.Store_Opening_Date    = S.Store_Opening_Date,
                            Dim_Customer.Store_Closing_Date    = S.Store_Closing_Date,
                            Dim_Customer.Currency_Code         = S.Currency_Code;

    UPDATE Dim_Customer
    SET Channel = 'MAINLINE'
    WHERE Ship_to_Code IN ('0020014135', '0020014325', '0020015987', '0020028995');

    UPDATE Dim_Customer C,
        (select Company_Name, Ship_to_Code from Dim_Customer where Business_Model_Name = 'WHOLESALE' AND Channel = '') Q
    SET C.Channel = 'WHOLESALE'
    WHERE C.Company_Name = Q.Company_Name
      AND C.Ship_to_Code = Q.Ship_to_Code;
END;


