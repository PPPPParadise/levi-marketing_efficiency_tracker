create
    definer = kchaudhary@`%` procedure Pop_Fact_DB_ECom(IN i_Job_ID int)
BEGIN
    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 0, CURRENT_TIMESTAMP());

    TRUNCATE TABLE Stg_Fact_DB_ECom_GA;
    TRUNCATE TABLE Stg_Fact_DB_ECom_AD;
    TRUNCATE TABLE Stg_Fact_DB_ECom;

    INSERT INTO Stg_Fact_DB_ECom_GA (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                     Fiscal_Month, Country, Region,
                                     Source,
                                     Medium,
                                     Channel,
                                     Campaign,
                                     Pageviews, Unique_Pageviews, Sessions,
                                     Session_Duration, Bounces, Revenue,
                                     Transactions, Users, New_Users)
        (SELECT M.Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.GA_Source IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Source END       GA_Source,
                CASE WHEN G.GA_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Medium END       GA_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign,
                SUM(Pageviews)                                                            Pageviews,
                SUM(Unique_Pageviews)                                                     Unique_Pageviews,
                SUM(Sessions)                                                             Sessions,
                SUM(Session_Duration)                                                     Session_Duration,
                SUM(Bounces)                                                              Bounces,
                SUM(Revenue)                                                              Revenue,
                SUM(Transactions)                                                         Transactions,
                SUM(Users)                                                                Users,
                SUM(New_Users)                                                            New_Users
         FROM Dim_Calendar M,
              Dim_Country C,
              GA_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m')
           AND C.Web_Analytics = 'GA'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, C.Country,
                  G.GA_Source, G.GA_Medium, G.Channel, G.Campaign_Upd);

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 10, CURRENT_TIMESTAMP());

    INSERT IGNORE INTO Stg_Fact_DB_ECom_GA (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                            Fiscal_Month, Country, Region,
                                            Source, Medium, Channel, Campaign)
        (SELECT CASE
                    WHEN SUBSTR(M.Year_Month_Num, 5, 2) = '12' THEN M.Year_Month_Num + 89
                    ELSE M.Year_Month_Num + 1 END                                         PY_Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.GA_Source IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Source END       GA_Source,
                CASE WHEN G.GA_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Medium END       GA_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign
         FROM Dim_Calendar M,
              Dim_Country C,
              GA_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m')
           AND C.Web_Analytics = 'GA'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, M.Fiscal_Quarter, M.Fiscal_Year,
                  M.Fiscal_Month, C.Country, C.Region,
                  G.GA_Source, G.GA_Medium, G.Channel, G.Campaign_Upd);

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 20, CURRENT_TIMESTAMP());

    INSERT IGNORE INTO Stg_Fact_DB_ECom_GA (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                            Fiscal_Month, Country, Region,
                                            Source, Medium, Channel, Campaign)
        (SELECT M.Year_Month_Num + 100                                                    PY_Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.GA_Source IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Source END       GA_Source,
                CASE WHEN G.GA_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.GA_Medium END       GA_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign
         FROM Dim_Calendar M,
              Dim_Country C,
              GA_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m') - 100
           AND C.Web_Analytics = 'GA'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, M.Fiscal_Quarter, M.Fiscal_Year,
                  M.Fiscal_Month, C.Country, C.Region,
                  G.GA_Source, G.GA_Medium, G.Channel, G.Campaign_Upd);

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_ECom_GA SF,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '12' THEN Year_Month_Num + 89
                    ELSE Year_Month_Num + 1 END P_Year_Month_Num,
                Country,
                Source,
                Medium,
                Campaign,
                Channel,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom_GA) Q
    SET SF.Prev_Pageviews        = Q.Pageviews,
        SF.Prev_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Sessions         = Q.Sessions,
        SF.Prev_Session_Duration = Q.Session_Duration,
        SF.Prev_Bounces          = Q.Bounces,
        SF.Prev_Revenue          = Q.Revenue,
        SF.Prev_Transactions     = Q.Transactions,
        SF.Prev_Users            = Q.Users,
        SF.Prev_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.Source = Q.Source
      AND SF.Medium = Q.Medium
      AND SF.Campaign = Q.Campaign
      AND SF.Channel = Q.Channel;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 40, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_ECom_GA SF,
        (SELECT Year_Month_Num + 100 P_Year_Month_Num,
                Country,
                Source,
                Medium,
                Campaign,
                Channel,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom_GA) Q
    SET SF.Prev_Year_Pageviews        = Q.Pageviews,
        SF.Prev_Year_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Year_Sessions         = Q.Sessions,
        SF.Prev_Year_Session_Duration = Q.Session_Duration,
        SF.Prev_Year_Bounces          = Q.Bounces,
        SF.Prev_Year_Revenue          = Q.Revenue,
        SF.Prev_Year_Transactions     = Q.Transactions,
        SF.Prev_Year_Users            = Q.Users,
        SF.Prev_Year_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.Source = Q.Source
      AND SF.Medium = Q.Medium
      AND SF.Campaign = Q.Campaign
      AND SF.Channel = Q.Channel;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 50, CURRENT_TIMESTAMP());
/* Adobe Code Starts Here */

    INSERT INTO Stg_Fact_DB_ECom_AD (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                     Fiscal_Month, Country, Region,
                                     Source,
                                     Medium,
                                     Channel,
                                     Campaign,
                                     Pageviews, Unique_Pageviews, Sessions,
                                     Session_Duration, Bounces, Revenue,
                                     Transactions, Users, New_Users)
        (SELECT M.Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.Adobe_Source IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Source END Adobe_Source,
                CASE WHEN G.Adobe_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Medium END Adobe_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign,
                SUM(Pageviews)                                                            Pageviews,
                SUM(Unique_Pageviews)                                                     Unique_Pageviews,
                SUM(Sessions)                                                             Sessions,
                SUM(Session_Duration)                                                     Session_Duration,
                SUM(Bounces)                                                              Bounces,
                SUM(Revenue)                                                              Revenue,
                SUM(Transactions)                                                         Transactions,
                SUM(Users)                                                                Users,
                SUM(New_Users)                                                            New_Users
         FROM Dim_Calendar M,
              Dim_Country C,
              Adobe_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m')
           AND C.Web_Analytics = 'Adobe'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, M.Fiscal_Quarter, M.Fiscal_Year,
                  M.Fiscal_Month, C.Country, C.Region,
                  G.Adobe_Source, G.Adobe_Medium, G.Channel, G.Campaign_Upd)
    ON DUPLICATE KEY UPDATE Pageviews        = Pageviews,
                            Unique_Pageviews = Unique_Pageviews,
                            Sessions         = Sessions,
                            Session_Duration = Session_Duration,
                            Bounces          = Bounces,
                            Revenue          = Revenue,
                            Transactions     = Transactions,
                            Users            = Users,
                            New_Users        = New_Users;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 60, CURRENT_TIMESTAMP());

    INSERT IGNORE INTO Stg_Fact_DB_ECom_AD (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                            Fiscal_Month, Country, Region,
                                            Source, Medium, Channel, Campaign)
        (SELECT CASE
                    WHEN SUBSTR(M.Year_Month_Num, 5, 2) = '12' THEN M.Year_Month_Num + 89
                    ELSE M.Year_Month_Num + 1 END                                         PY_Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.Adobe_Source IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Source END Adobe_Source,
                CASE WHEN G.Adobe_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Medium END Adobe_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign
         FROM Dim_Calendar M,
              Dim_Country C,
              Adobe_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m')
           AND C.Web_Analytics = 'Adobe'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, M.Fiscal_Quarter, M.Fiscal_Year,
                  M.Fiscal_Month, C.Country, C.Region,
                  G.Adobe_Source, G.Adobe_Medium, G.Channel, G.Campaign_Upd);

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 70, CURRENT_TIMESTAMP());

    INSERT IGNORE INTO Stg_Fact_DB_ECom_AD (Year_Month_Num, Fiscal_Quarter, Fiscal_Year,
                                            Fiscal_Month, Country, Region,
                                            Source, Medium, Channel, Campaign)
        (SELECT M.Year_Month_Num + 100                                                    PY_Year_Month_Num,
                M.Fiscal_Quarter,
                M.Fiscal_Year,
                M.Fiscal_Month,
                C.Country,
                C.Region,
                CASE WHEN G.Adobe_Source IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Source END Adobe_Source,
                CASE WHEN G.Adobe_Medium IS NULL THEN 'XXXXXXXXX' ELSE G.Adobe_Medium END Adobe_Medium,
                CASE WHEN G.Channel IS NULL THEN 'XXXXXXXXX' ELSE G.Channel END           Channel,
                CASE WHEN G.Campaign_Upd IS NULL THEN 'XXXXXXXXX' ELSE G.Campaign_Upd END Campaign
         FROM Dim_Calendar M,
              Dim_Country C,
              Adobe_Data G
         WHERE M.Year_Month_Num < DATE_FORMAT(NOW(), '%Y%m') - 100
           AND C.Web_Analytics = 'Adobe'
           AND G.Transaction_Date = M.Fiscal_Date
           AND C.Country = G.Country
         GROUP BY M.Year_Month_Num, M.Fiscal_Quarter, M.Fiscal_Year,
                  M.Fiscal_Month, C.Country, C.Region,
                  G.Adobe_Source, G.Adobe_Medium, G.Channel, G.Campaign_Upd);

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 80, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_ECom_AD SF,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '12' THEN Year_Month_Num + 89
                    ELSE Year_Month_Num + 1 END P_Year_Month_Num,
                Country,
                Source,
                Medium,
                Campaign,
                Channel,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom_AD) Q
    SET SF.Prev_Pageviews        = Q.Pageviews,
        SF.Prev_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Sessions         = Q.Sessions,
        SF.Prev_Session_Duration = Q.Session_Duration,
        SF.Prev_Bounces          = Q.Bounces,
        SF.Prev_Revenue          = Q.Revenue,
        SF.Prev_Transactions     = Q.Transactions,
        SF.Prev_Users            = Q.Users,
        SF.Prev_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.Source = Q.Source
      AND SF.Medium = Q.Medium
      AND SF.Campaign = Q.Campaign
      AND SF.Channel = Q.Channel;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 90, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_ECom_AD SF,
        (SELECT Year_Month_Num + 100 P_Year_Month_Num,
                Country,
                Source,
                Medium,
                Campaign,
                Channel,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom_AD) Q
    SET SF.Prev_Year_Pageviews        = Q.Pageviews,
        SF.Prev_Year_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Year_Sessions         = Q.Sessions,
        SF.Prev_Year_Session_Duration = Q.Session_Duration,
        SF.Prev_Year_Bounces          = Q.Bounces,
        SF.Prev_Year_Revenue          = Q.Revenue,
        SF.Prev_Year_Transactions     = Q.Transactions,
        SF.Prev_Year_Users            = Q.Users,
        SF.Prev_Year_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.Source = Q.Source
      AND SF.Medium = Q.Medium
      AND SF.Campaign = Q.Campaign
      AND SF.Channel = Q.Channel;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 100, CURRENT_TIMESTAMP());

    /* Insert to Staging table from GA and Adobe */

    INSERT INTO Stg_Fact_DB_ECom
    (Year_Month_Num, Fiscal_Year, Fiscal_Quarter,
     Fiscal_Month, Fiscal_Date, Country,
     Region, Source, Medium,
     Channel, Campaign, Pageviews,
     Prev_Pageviews, Prev_Year_Pageviews, Unique_Pageviews,
     Prev_Unique_Pageviews, Prev_Year_Unique_Pageviews, Sessions,
     Prev_Sessions, Prev_Year_Sessions, Session_Duration,
     Prev_Session_Duration, Prev_Year_Session_Duration, Bounces,
     Prev_Bounces, Prev_Year_Bounces, Revenue,
     Prev_Revenue, Prev_Year_Revenue, Transactions,
     Prev_Transactions, Prev_Year_Transactions, Users,
     Prev_Users, Prev_Year_Users, New_Users,
     Prev_New_Users, Prev_Year_New_Users)
    SELECT Year_Month_Num,
           Fiscal_Year,
           Fiscal_Quarter,
           Fiscal_Month,
           Fiscal_Date,
           Country,
           Region,
           REPLACE(Source, 'XXXXXXXXX', ' '),
           REPLACE(Medium, 'XXXXXXXXX', ' '),
           REPLACE(Channel, 'XXXXXXXXX', ' '),
           REPLACE(Campaign, 'XXXXXXXXX', ' '),
           Pageviews,
           Prev_Pageviews,
           Prev_Year_Pageviews,
           Unique_Pageviews,
           Prev_Unique_Pageviews,
           Prev_Year_Unique_Pageviews,
           Sessions,
           Prev_Sessions,
           Prev_Year_Sessions,
           Session_Duration,
           Prev_Session_Duration,
           Prev_Year_Session_Duration,
           Bounces,
           Prev_Bounces,
           Prev_Year_Bounces,
           Revenue,
           Prev_Revenue,
           Prev_Year_Revenue,
           Transactions,
           Prev_Transactions,
           Prev_Year_Transactions,
           Users,
           Prev_Users,
           Prev_Year_Users,
           New_Users,
           Prev_New_Users,
           Prev_Year_New_Users
    FROM Stg_Fact_DB_ECom_GA;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 110, CURRENT_TIMESTAMP());

    INSERT INTO Stg_Fact_DB_ECom
    (Year_Month_Num, Fiscal_Year, Fiscal_Quarter,
     Fiscal_Month, Fiscal_Date, Country,
     Region, Source, Medium,
     Channel, Campaign, Pageviews,
     Prev_Pageviews, Prev_Year_Pageviews, Unique_Pageviews,
     Prev_Unique_Pageviews, Prev_Year_Unique_Pageviews, Sessions,
     Prev_Sessions, Prev_Year_Sessions, Session_Duration,
     Prev_Session_Duration, Prev_Year_Session_Duration, Bounces,
     Prev_Bounces, Prev_Year_Bounces, Revenue,
     Prev_Revenue, Prev_Year_Revenue, Transactions,
     Prev_Transactions, Prev_Year_Transactions, Users,
     Prev_Users, Prev_Year_Users, New_Users,
     Prev_New_Users, Prev_Year_New_Users)
    SELECT Year_Month_Num,
           Fiscal_Year,
           Fiscal_Quarter,
           Fiscal_Month,
           Fiscal_Date,
           Country,
           Region,
           REPLACE(Source, 'XXXXXXXXX', ' '),
           REPLACE(Medium, 'XXXXXXXXX', ' '),
           REPLACE(Channel, 'XXXXXXXXX', ' '),
           REPLACE(Campaign, 'XXXXXXXXX', ' '),
           Pageviews,
           Prev_Pageviews,
           Prev_Year_Pageviews,
           Unique_Pageviews,
           Prev_Unique_Pageviews,
           Prev_Year_Unique_Pageviews,
           Sessions,
           Prev_Sessions,
           Prev_Year_Sessions,
           Session_Duration,
           Prev_Session_Duration,
           Prev_Year_Session_Duration,
           Bounces,
           Prev_Bounces,
           Prev_Year_Bounces,
           Revenue,
           Prev_Revenue,
           Prev_Year_Revenue,
           Transactions,
           Prev_Transactions,
           Prev_Year_Transactions,
           Users,
           Prev_Users,
           Prev_Year_Users,
           New_Users,
           Prev_New_Users,
           Prev_Year_New_Users
    FROM Stg_Fact_DB_ECom_AD;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 120, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_ECom E, Dim_Calendar_Month C
    SET E.Fiscal_Year    = C.Fiscal_Year,
        E.Fiscal_Quarter = C.Fiscal_Quarter,
        E.Fiscal_Month   = C.Fiscal_Month,
        E.Fiscal_Date    = CONCAT(SUBSTRING(STR_TO_DATE(C.Year_Month_Num, '%Y%m'), 1, 7), '-01')
    WHERE E.Year_Month_Num = C.Year_Month_Num;

    UPDATE Stg_Fact_DB_ECom S,ECom_Campaign_Mapping E
    SET S.Campaign = E.Campaign_New
    WHERE S.Campaign = E.Campaign_Old;
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 130, CURRENT_TIMESTAMP());

    INSERT INTO Fact_DB_Search_Keyword (Year_Month_Num, Country, Keyword, Count_Keyword)
    SELECT *
    FROM (SELECT Year_Month_Num,
                 Country,
                 Keyword,
                 COUNT(1) Cnt_Keyword
          FROM GA_Data
          WHERE UPPER(Keyword) NOT LIKE UPPER('(not %')
            AND Keyword NOT LIKE '%+?%'
          GROUP BY Year_Month_Num, Country, Keyword
          UNION ALL
          SELECT Year_Month_Num,
                 Country,
                 Keyword,
                 COUNT(1) Cnt_Keyword
          FROM Adobe_Data
          WHERE Keyword <> ''
            AND Keyword NOT LIKE '%??%'
            AND UPPER(Keyword) NOT LIKE 'NO VALUE%'
          GROUP BY Year_Month_Num, Country, Keyword) Q1
    WHERE Q1.Year_Month_Num IS NOT NULL
    ON DUPLICATE KEY UPDATE Fact_DB_Search_Keyword.Count_Keyword = Cnt_Keyword;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 140, CURRENT_TIMESTAMP());

    TRUNCATE TABLE Fact_DB_ECom;
    INSERT INTO Fact_DB_ECom SELECT * FROM Stg_Fact_DB_ECom;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_ECom', NULL, 150, CURRENT_TIMESTAMP());
END;


