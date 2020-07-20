create
    definer = pkishlay@`%` procedure Load_Adobe_Data()
BEGIN

    /* 
    truncate Stg_Adobe_Data
    load data local infile 'C:\\Raw_Data\\Navneeta\\Adobe_data\\AU_Report_Dec2017.csv'
    into table `Stg_Adobe_Data`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES 
        
     (@Date,@Campaign,@Channel,@Search_Keywords,@Source,@Orders,@Page_Views,@Revenue,@Total_Seconds_Spent,
     @Unique_Visitors,@Visits) 
     
    Set Transaction_Date=STR_TO_DATE(@Date,' %M %d,%Y'),
    Campaign=@Campaign,
    Adobe_Medium=@Channel,
    Keyword=@Search_Keywords,
    Adobe_Source=@Source,
    Transactions=@Orders,
    Pageviews=@Page_Views,
    Revenue=@Revenue,
    Session_Duration=@Total_Seconds_Spent,
    Users=@Unique_Visitors,
    Sessions=@Visits;
    
    
    China
    South Korea
    Australia
    India
    Japan
    
    */

    set SQL_SAFE_UPDATES = 0;
    UPDATE Stg_Adobe_Data G , Dim_Calendar C
    SET G.Year_Month_Num = C.Year_Month_Num
    WHERE G.Transaction_Date = C.Fiscal_Date;


    INSERT INTO Adobe_Data
    (Transaction_Date, Country, Year_Month_Num,
     Adobe_Source, Campaign, Adobe_Medium, Keyword, Sessions, Bounces, Session_Duration, Pageviews,
     Unique_Pageviews, Transactions, Revenue, Total_Value, Users, New_Users)
    SELECT Get_Std_Date(Transaction_Date) Trans_Date,
           'Japan'                        Country,
           Year_Month_Num,
           Adobe_Source,
           Campaign,
           Adobe_Medium,
           Substring(Keyword, 1, 500)     Keyword,
           SUM(Sessions),
           SUM(Bounces),
           SUM(Session_Duration),
           SUM(Pageviews),
           SUM(Unique_Pageviews),
           SUM(Transactions),
           SUM(Revenue),
           SUM(Total_Value),
           SUM(Users),
           SUM(New_Users)
    FROM Stg_Adobe_Data
    GROUP BY Trans_Date, Country, Adobe_Source, Campaign, Adobe_Medium, Keyword;


    UPDATE Adobe_Data A, Channel_Mapping C
    SET A.Channel = C.Adobe_Channel
    where A.Adobe_Source = C.Adobe_Source
       OR A.Adobe_Medium = C.Adobe_Medium;

    UPDATE Adobe_Data A
    SET A.Campaign_Upd = A.Campaign;

    UPDATE Adobe_Data A, GA_Adobe_Campaign_Mapping C
    SET A.Campaign_Upd = C.Campaign_Name_Upd
    WHERE A.Campaign = C.Campaign_Name;


    UPDATE Adobe_Data
    SET Campaign_Upd=REPLACE(Campaign_Upd, '\r', '');

    UPDATE Adobe_Data
    SET Campaign_Upd=TRIM(Campaign_Upd);


    UPDATE Adobe_Data AD,
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


