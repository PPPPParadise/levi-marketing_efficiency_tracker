create
    definer = pkishlay@`%` procedure Load_GA_Data()
BEGIN

    /*
    Truncate table Stg_GA_Data;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\PK.csv'
    into table `Stg_GA_Data`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\SG.csv'
    into table `Stg_GA_Data`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\HK.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\ID.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\MY.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\PH.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\SA.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    
    load data local infile 'D:\\Data\\2020_April\\GA\\TW.txt'
    into table `Stg_GA_Data`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines;
    */
    UPDATE Stg_GA_Data G , Dim_Calendar C
    SET G.Year_Month_Num = C.Year_Month_Num
    WHERE G.Transaction_Date = C.Fiscal_Date;

    INSERT INTO GA_Data(Transaction_Date, Country, Year_Month_Num, GA_Source, Campaign, GA_Medium, Keyword,
                        Sessions, Bounces, Session_Duration, Pageviews, Unique_Pageviews, Transactions, Revenue,
                        Total_Value,
                        Users, New_Users)
    SELECT STR_TO_DATE(Transaction_Date, '%Y-%m-%d'),
           CASE
               WHEN Country = '78138833' then 'Malaysia'
               WHEN Country = '8960133' then 'South Africa'
               WHEN Country = '136309319' then 'Philippines'
               WHEN Country = '140245287' then 'Indonesia'
               WHEN Country = '141304301' then 'Hong Kong'
               WHEN Country = '147353541' then 'Taiwan'
               WHEN Country = '136097832' then 'Singapore'
               WHEN Country = '191540786' then 'Pakistan'
               ELSE 'NA'
               END Country_name,
           Year_Month_Num,
           GA_Source,
           Campaign,
           GA_Medium,
           Keyword,
           REPLACE(Sessions, ',', ''),
           REPLACE(Bounces, ',', ''),
           Session_Duration,
           Pageviews,
           REPLACE(Unique_Pageviews, ',', ''),
           Transactions,
           REPLACE(REPLACE(Revenue, '$', ''), '%', ''),
           REPLACE(REPLACE(Total_Value, '$', ''), '%', ''),
           REPLACE(Users, ',', ''),
           REPLACE(New_Users, ',', '')
    FROM Stg_GA_Data

    ON DUPLICATE KEY UPDATE GA_Data.Sessions     = Stg_GA_Data.Sessions,
                            GA_Data.Bounces      = Stg_GA_Data.Bounces,
                            GA_Data.Pageviews    = Stg_GA_Data.Pageviews,
                            GA_Data.Transactions = Stg_GA_Data.Transactions,
                            GA_Data.Revenue      = Stg_GA_Data.Revenue;

    UPDATE GA_Data A, Channel_Mapping C
    SET A.Channel = C.GA_Channel
    where A.GA_Medium = C.GA_Medium;

    Update GA_Data G
    SET G.Campaign_Upd = G.Campaign;

    Update GA_Data G, GA_Adobe_Campaign_Mapping C
    Set G.Campaign_Upd = C.Campaign_Name_Upd
    where G.Campaign = C.Campaign_Name;

    UPDATE GA_Data
    SET Campaign_Upd=Replace(Campaign_Upd, '\r', '');

    UPDATE GA_Data
    SET Campaign_Upd=Trim(Campaign_Upd);

    UPDATE GA_Data AD,
        Dim_Calendar C,
        GA_Adobe_Campaign_H1_H2 H
    SET AD.Campaign_Upd = CASE
                              WHEN C.Fiscal_Month IN ('Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May') AND
                                   INSTR(Campaign_Upd, 'H1') = 0 THEN CONCAT(AD.Campaign_Upd, ' H1')
                              WHEN C.Fiscal_Month IN ('Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov') AND
                                   INSTR(Campaign_Upd, 'H2') = 0 THEN CONCAT(AD.Campaign_Upd, ' H2')
        END
    WHERE AD.Transaction_Date = C.Fiscal_Date
      AND TRIM(UPPER(AD.Campaign_Upd)) = TRIM(UPPER(H.Campaign_Name));


END;


