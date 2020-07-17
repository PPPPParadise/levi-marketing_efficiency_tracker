create
    definer = kchaudhary@`%` procedure Pop_Fact_Sellthru_Traffic(IN i_Job_ID int, IN i_Country varchar(30),
                                                                 IN i_Year_Month_Num int, IN i_Call_Type varchar(30))
BEGIN
    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 0, CURRENT_TIMESTAMP());

    IF i_Country = 'ALL' AND i_Year_Month_Num = 0 AND i_Call_Type = 'ALL' THEN

        TRUNCATE TABLE Stg_Fact_Sellthru_Traffic;
        INSERT INTO Stg_Fact_Sellthru_Traffic (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country,
                                               Region, Channel)
        SELECT DISTINCT Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region, Channel
        FROM Dim_Calendar_Month,
             Dim_Country,
             Dim_Channel
        WHERE Year_Month_Num BETWEEN '201612' AND DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y%m')
        ORDER BY Year_Month_Num;
    ELSE

        TRUNCATE TABLE Stg_Fact_Sellthru_Traffic;

        INSERT INTO Stg_Fact_Sellthru_Traffic (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country,
                                               Region, Channel)
        SELECT DISTINCT Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region, Channel
        FROM Dim_Calendar_Month,
             Dim_Country,
             Dim_Channel
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country
        ORDER BY Year_Month_Num;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 10, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic
    SET Fiscal_Date = CONCAT(SUBSTRING(STR_TO_DATE(Year_Month_Num, '%Y%m'), 1, 7), '-01');


    IF i_Country = 'ALL' AND i_Year_Month_Num = 0 THEN

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT Country,
                    Fiscal_Month,
                    D.Channel,
                    CAST(SUM(Gross_Value_Without_Tax) AS DECIMAL(18, 2))                                  Sellout,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      D.Channel != 'ONLINE' THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      D.Channel != 'ONLINE' THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp,
                    CAST(SUM(CASE
                                 WHEN Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Promo,
                    CAST(SUM(CASE
                                 WHEN Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp_Non_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp_Non_Promo,
                    CAST(SUM(CASE
                                 WHEN S.Promotional_Transaction = 'Y' AND D.Channel = 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           ECom_Promo,
                    CAST(SUM(CASE
                                 WHEN S.Promotional_Transaction = 'N' AND D.Channel = 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           ECom_Non_Promo,
                    SUM(CASE WHEN S.Is_Traffic_Counter = 'Y' THEN Transaction_Count_Reference ELSE 0 END) No_Of_Trans,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                 D.Channel != 'ONLINE' AND S.Is_Traffic_Counter = 'Y' THEN 1
                            ELSE 0 END)                                                                   Trans_Comp_Stores,
                    SUM(CASE WHEN D.Channel = 'ONLINE' THEN 1 ELSE 0 END)                                 Trans_Online_Stores,
                    COUNT(DISTINCT Customer_Code)                                                         Total_Stores
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
             GROUP BY Country, Fiscal_Month, D.Channel) Q
        SET FDG.Sellout             = Q.Sellout,
            FDG.Comp                = Q.Comp,
            FDG.Non_Comp            = Q.Non_Comp,
            FDG.Promo               = Q.Promo,
            FDG.Non_Promo           = Q.Non_Promo,
            FDG.Comp_Promo          = Q.Comp_Promo,
            FDG.Non_Comp_Promo      = Q.Non_Comp_Promo,
            FDG.Comp_Non_Promo      = Q.Comp_Non_Promo,
            FDG.Non_Comp_Non_Promo  = Q.Non_Comp_Non_Promo,
            FDG.ECom_Promo          = Q.ECom_Promo,
            FDG.ECom_Non_Promo      = Q.ECom_Non_Promo,
            FDG.No_Of_Trans         = Q.No_Of_Trans,
            FDG.Trans_Comp_Stores   = Q.Trans_Comp_Stores,
            FDG.Trans_Online_Stores = Q.Trans_Online_Stores,
            FDG.Total_Stores=Q.Total_Stores
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Channel = Q.Channel;

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT I.Country, I.Fiscal_Month, D.Channel, SUM(On_Hand_QTY) S_On_Hand_Qty
             FROM Inventory I,
                  Dim_Customer D
             WHERE I.Customer_Code = D.Ship_to_Code
               AND I.Sales_Org = D.Sales_Org
             GROUP BY I.Country, I.Fiscal_Month, D.Channel) Q
        SET FDG.On_Hand_Qty = Q.S_On_Hand_Qty
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Channel = Q.Channel;

    ELSE

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT Country,
                    Fiscal_Month,
                    D.Channel,
                    CAST(SUM(Gross_Value_Without_Tax) AS DECIMAL(18, 2))                                  Sellout,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      D.Channel != 'ONLINE' THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      D.Channel != 'ONLINE' THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp,
                    CAST(SUM(CASE
                                 WHEN Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Promo,
                    CAST(SUM(CASE
                                 WHEN Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      Promotional_Transaction = 'Y' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                      Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Comp_Non_Promo,
                    CAST(SUM(CASE
                                 WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= Fiscal_Month AND
                                      Promotional_Transaction = 'N' AND D.Channel != 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           Non_Comp_Non_Promo,
                    CAST(SUM(CASE
                                 WHEN S.Promotional_Transaction = 'Y' AND D.Channel = 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           ECom_Promo,
                    CAST(SUM(CASE
                                 WHEN S.Promotional_Transaction = 'N' AND D.Channel = 'ONLINE'
                                     THEN S.Gross_Value_without_Tax
                                 ELSE 0 END) AS DECIMAL(18, 2))                                           ECom_Non_Promo,
                    SUM(CASE WHEN S.Is_Traffic_Counter = 'Y' THEN Transaction_Count_Reference ELSE 0 END) No_Of_Trans,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < Fiscal_Month AND
                                 D.Channel != 'ONLINE' AND S.Is_Traffic_Counter = 'Y' THEN 1
                            ELSE 0 END)                                                                   Trans_Comp_Stores,
                    SUM(CASE WHEN D.Channel = 'ONLINE' THEN 1 ELSE 0 END)                                 Trans_Online_Stores,
                    COUNT(DISTINCT Customer_Code)                                                         Total_Stores
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
               AND Fiscal_Month = i_Year_Month_Num
               AND Country = i_Country
             GROUP BY Country, Fiscal_Month, D.Channel) Q
        SET FDG.Sellout             = Q.Sellout,
            FDG.Comp                = Q.Comp,
            FDG.Non_Comp            = Q.Non_Comp,
            FDG.Promo               = Q.Promo,
            FDG.Non_Promo           = Q.Non_Promo,
            FDG.Comp_Promo          = Q.Comp_Promo,
            FDG.Non_Comp_Promo      = Q.Non_Comp_Promo,
            FDG.Comp_Non_Promo      = Q.Comp_Non_Promo,
            FDG.Non_Comp_Non_Promo  = Q.Non_Comp_Non_Promo,
            FDG.ECom_Promo          = Q.ECom_Promo,
            FDG.ECom_Non_Promo      = Q.ECom_Non_Promo,
            FDG.No_Of_Trans         = Q.No_Of_Trans,
            FDG.Trans_Comp_Stores   = Q.Trans_Comp_Stores,
            FDG.Trans_Online_Stores = Q.Trans_Online_Stores,
            FDG.Total_Stores=Q.Total_Stores
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Channel = Q.Channel;

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT I.Country, I.Fiscal_Month, D.Channel, SUM(On_Hand_QTY) S_On_Hand_Qty
             FROM Inventory I,
                  Dim_Customer D
             WHERE I.Customer_Code = D.Ship_to_Code
               AND I.Sales_Org = D.Sales_Org
               AND I.Fiscal_Month = i_Year_Month_Num
               AND I.Country = i_Country
             GROUP BY I.Country, I.Fiscal_Month, D.Channel) Q
        SET FDG.On_Hand_Qty = Q.S_On_Hand_Qty
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Channel = Q.Channel;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 20, CURRENT_TIMESTAMP());

    IF i_Country = 'ALL' AND i_Year_Month_Num = 0 THEN
        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT T.Country,
                    T.Year_Month_Num,
                    D.Channel,
                    SUM(Traffic_Count)                                                  Traffic_Count,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < DC.Year_Month_Num AND
                                 D.Channel != 'ONLINE' THEN Traffic_Count
                            ELSE 0 END)                                                 Comp,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= DC.Year_Month_Num AND
                                 D.Channel != 'ONLINE' THEN Traffic_Count
                            ELSE 0 END)                                                 Non_Comp,
                    COUNT(DISTINCT CASE WHEN Traffic_Count > 0 THEN T.Ship_to_Code END) Total_Traffic_Counter_Stores
             FROM Traffic T,
                  Dim_Calendar DC,
                  Dim_Customer D
             WHERE T.Traffic_Date = DC.Fiscal_Date
               AND T.Ship_to_Code = D.Ship_to_Code
               AND T.Country = D.Company_Name
             GROUP BY T.Country, DC.Year_Month_Num, D.Channel) Q
        SET Traffic                          = Q.Traffic_Count,
            FDG.Traffic_Comp                 = Q.Comp,
            FDG.Traffic_Comp_Non_Comp        = Q.Non_Comp,
            FDG.Total_Traffic_Counter_Stores = Q.Total_Traffic_Counter_Stores
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num
          AND FDG.Channel = Q.Channel;
    ELSE
        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT T.Country,
                    T.Year_Month_Num,
                    D.Channel,
                    SUM(Traffic_Count)                                                  Traffic_Count,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 < DC.Year_Month_Num AND
                                 D.Channel != 'ONLINE' THEN Traffic_Count
                            ELSE 0 END)                                                 Comp,
                    SUM(CASE
                            WHEN DATE_FORMAT(D.Store_Opening_Date, '%Y%m') + 100 >= DC.Year_Month_Num AND
                                 D.Channel != 'ONLINE' THEN Traffic_Count
                            ELSE 0 END)                                                 Non_Comp,
                    COUNT(DISTINCT CASE WHEN Traffic_Count > 0 THEN T.Ship_to_Code END) Total_Traffic_Counter_Stores
             FROM Traffic T,
                  Dim_Calendar DC,
                  Dim_Customer D
             WHERE T.Traffic_Date = DC.Fiscal_Date
               AND T.Ship_to_Code = D.Ship_to_Code
               AND T.Country = D.Company_Name
               AND T.Country = i_Country
               AND T.Year_Month_Num = i_Year_Month_Num
             GROUP BY T.Country, DC.Year_Month_Num, D.Channel) Q
        SET Traffic                          = Q.Traffic_Count,
            FDG.Traffic_Comp                 = Q.Comp,
            FDG.Traffic_Comp_Non_Comp        = Q.Non_Comp,
            FDG.Total_Traffic_Counter_Stores = Q.Total_Traffic_Counter_Stores
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num
          AND FDG.Channel = Q.Channel;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT GD.Country, DC.Year_Month_Num, SUM(Users) S_Users
         FROM GA_Data GD,
              Dim_Calendar DC
         WHERE GD.Transaction_Date = DC.Fiscal_Date
         GROUP BY Country, Year_Month_Num) Q
    SET FDG.Traffic = Q.S_Users
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'ONLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 40, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT AD.Country, DC.Year_Month_Num, SUM(Users) S_Users
         FROM Adobe_Data AD,
              Dim_Calendar DC
         WHERE AD.Transaction_Date = DC.Fiscal_Date
         GROUP BY Country, Year_Month_Num) Q
    SET FDG.Traffic = Q.S_Users
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'ONLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 50, CURRENT_TIMESTAMP());

    IF i_Call_Type = 'SUBMIT' THEN /* Irrespective of approved or not  */

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT Country,
                    Month_Num,
                    SUM(TV_Spend + Print_Spend + Radio_Spend + OOH_spend + Digital_Spend + CRM_Spend + PR_Spend +
                        Cinema_Spend + Others_campaign_Spend + SE_Spend + VSS_Spend + Marketplace_Spend) Tot_Spend
             FROM MKT_Template_Spend
             GROUP BY Country, Month_Num) Q
        SET FDG.Spend = Q.Tot_Spend
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Month_Num
          AND FDG.Channel = 'MAINLINE';
    ELSE

        UPDATE Stg_Fact_Sellthru_Traffic FDG,
            (SELECT Country,
                    Month_Num,
                    SUM(TV_Spend + Print_Spend + Radio_Spend + OOH_spend + Digital_Spend + CRM_Spend + PR_Spend +
                        Cinema_Spend + Others_campaign_Spend + SE_Spend + VSS_Spend + Marketplace_Spend) Tot_Spend
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
             GROUP BY Country, Month_Num) Q
        SET FDG.Spend = Q.Tot_Spend
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Month_Num
          AND FDG.Channel = 'MAINLINE';
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 60, CURRENT_TIMESTAMP());


    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT Year_Month_Num,
                Country,
                SUM(Facebook_Reactions) + SUM(Facebook_Comments) + SUM(Facebook_Shares) + SUM(Twitter_Retweets) +
                SUM(Twitter_Favorites)
                    + SUM(Instagram_Likes) + SUM(Instagram_Comments) AS SM
         FROM MKT_Template_Social
         GROUP BY Year_Month_Num, Country) MTC
    SET FDG.Engagement = MTC.SM
    WHERE FDG.Country = MTC.Country
      AND FDG.Year_Month_Num = MTC.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 70, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT Month_Num, Country, SUM(VSS_Total_Views) AS Views
         FROM MKT_Template_Spend
         GROUP BY Month_Num, Country) MTS
    SET FDG.VSS_Views = MTS.Views
    WHERE FDG.Country = MTS.Country
      AND FDG.Year_Month_Num = MTS.Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 80, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (Select Country,
                Year_Month_Num,
                SUM(CASE WHEN VSS_Views IS NULL THEN 0 ELSE VSS_Views END)   AS Views,
                SUM(CASE WHEN Engagement IS NULL THEN 0 ELSE Engagement END) AS SM
         FROM Stg_Fact_Sellthru_Traffic
         WHERE Channel = 'MAINLINE'
         GROUP BY Country, Year_Month_Num) Q
    SET FDG.SM_Engagement = Q.Views + Q.SM
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 90, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT SMC.Year_Month_Num, SMC.Country, (SMC.Weibo + MTS.Views + MTS.Eng) AS Engagement
         FROM (SELECT Year_Month_Num,
                      Country,
                      SUM(Weibo_Likes_Levis) + SUM(Weibo_Retweet_Levis) + SUM(Weibo_Comment_Levis) AS Weibo
               FROM SocialMedia_China
               GROUP BY Year_Month_Num, Country) AS SMC
                  INNER JOIN
              (Select Month_Num, Country, SUM(VSS_Total_Views) AS Views, SUM(Total_Engagement) AS Eng
               FROM MKT_Template_Spend
               GROUP BY Month_Num, Country) AS MTS
         WHERE SMC.Year_Month_Num = MTS.Month_Num
           AND SMC.Country = MTS.Country
         GROUP BY Year_Month_Num, SMC.Country) Q
    SET FDG.SM_Engagement = Q.Engagement
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 100, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDC,
        (SELECT Year_Month_Num, Country, SUM(NewJoins) S_NewJoins, SUM(MemberRevenue) S_MemberRevenue
         FROM CRM_Member_Data
         GROUP BY Year_Month_Num, Country) Q
    SET FDC.Acquisition  = Q.S_NewJoins,
        FDC.Mem_Sellthru = Q.S_MemberRevenue
    WHERE FDC.Year_Month_Num = Q.Year_Month_Num
      AND FDC.Country = Q.Country
      AND FDC.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 110, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) TMC
         FROM Zignal_Data_Sentiment_Breakdown ZS,
              Dim_Calendar DC
         WHERE ZS.Start_Date = DC.Fiscal_Date
           AND ZS.Brand_Name = 'Levi''s'
           AND ZS.Start_Date >= '2017-12-01'
         GROUP BY DC.Year_Month_Num, ZS.Country) Q
    SET FDG.Listening = Q.TMC
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT Year_Month_Num, Country, Total_Mentions TMC
         FROM Pulsar_Sentiment PS
         WHERE PS.Brand_Name = 'Levi''s'
         GROUP BY Year_Month_Num, Country) Q1
    SET FDG.Listening = Q1.TMC
    WHERE FDG.Country = Q1.Country
      AND FDG.Year_Month_Num = Q1.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 120, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT Country, Year_Month_Num, Weibo_Buzz
         FROM Stg_Fact_DB_Social_China1
         WHERE Competitor = 'Levi''s') Q
    SET FDG.Listening = Q.Weibo_Buzz
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Year_Month_Num
      AND FDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 130, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic SFDG,
        (SELECT Country, Year_Month_Num, AVG(Levis) as Levis
         FROM Organic_Search
         GROUP BY Country, Year_Month_Num) OS
    SET SFDG.Levis_Organic_Search = OS.Levis
    WHERE SFDG.Country = OS.Country
      AND SFDG.Year_Month_Num = OS.Year_Month_Num
      AND SFDG.Channel = 'MAINLINE';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 140, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Sellthru_Traffic FDG,
        (SELECT Country,
                Year_Month_Num + 100  Prev_Fiscal_Month,
                Channel,
                Sellout               Prev_Sellout,
                Comp                  Prev_Comp,
                Non_Comp              Prev_Non_Comp,
                Promo                 Prev_Promo,
                Non_Promo             Prev_Non_Promo,
                ECom_Promo            Prev_ECom_Promo,
                ECom_Non_Promo        Prev_ECom_Non_Promo,
                Comp_Promo            Prev_Comp_Promo,
                Non_Comp_Promo        Prev_Non_Comp_Promo,
                Comp_Non_Promo        Prev_Comp_Non_Promo,
                Non_Comp_Non_Promo    Prev_Non_Comp_Non_Promo,
                Traffic               Prev_Traffic,
                Traffic_Comp_Non_Comp Prev_Traffic_Comp_Non_Comp,
                Traffic_Comp          Prev_Traffic_Comp,
                No_Of_Trans           Prev_No_Of_Trans,
                Trans_Comp_Stores     Prev_Trans_Comp_Stores,
                Trans_Online_Stores   Prev_Trans_Online_Stores,
                Spend                 Prev_Spend,
                SM_Engagement         Prev_SM_Engagement,
                Acquisition           Prev_Acquisition,
                Mem_Sellthru          Prev_Mem_Sellthru,
                Listening             Prev_Listening,
                On_Hand_Qty           Prev_On_Hand_Qty,
                Levis_Organic_Search  Prev_Levis_Organic_Search
         FROM Stg_Fact_Sellthru_Traffic) Q
    SET FDG.Prev_Sellout               = Q.Prev_Sellout,
        FDG.Prev_Comp                  = Q.Prev_Comp,
        FDG.Prev_Non_Comp              = Q.Prev_Non_Comp,
        FDG.Prev_Promo                 = Q.Prev_Promo,
        FDG.Prev_Non_Promo             = Q.Prev_Non_Promo,
        FDG.Prev_ECom_Promo            = Q.Prev_ECom_Promo,
        FDG.Prev_ECom_Non_Promo        = Q.Prev_ECom_Non_Promo,
        FDG.Prev_Comp_Promo            = Q.Prev_Comp_Promo,
        FDG.Prev_Non_Comp_Promo        = Q.Prev_Non_Comp_Promo,
        FDG.Prev_Comp_Non_Promo        = Q.Prev_Comp_Non_Promo,
        FDG.Prev_Non_Comp_Non_Promo    = Q.Prev_Non_Comp_Non_Promo,
        FDG.Prev_Traffic               = Q.Prev_Traffic,
        FDG.Prev_Traffic_Comp_Non_Comp = Q.Prev_Traffic_Comp_Non_Comp,
        FDG.Prev_Traffic_Comp          = Q.Prev_Traffic_Comp,
        FDG.Prev_No_Of_Trans           = Q.Prev_No_Of_Trans,
        FDG.Prev_Trans_Comp_Stores     = Q.Prev_Trans_Comp_Stores,
        FDG.Prev_Trans_Online_Stores   = Q.Prev_Trans_Online_Stores,
        FDG.Prev_Spend                 = Q.Prev_Spend,
        FDG.Prev_SM_Engagement         = Q.Prev_SM_Engagement,
        FDG.Prev_Acquisition           = Q.Prev_Acquisition,
        FDG.Prev_Mem_Sellthru          = Q.Prev_Mem_Sellthru,
        FDG.Prev_Listening             = Q.Prev_Listening,
        FDG.Prev_On_Hand_Qty           = Q.Prev_On_Hand_Qty,
        FDG.Prev_Levis_Organic_Search  = Q.Prev_Levis_Organic_Search
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month
      AND FDG.Channel = Q.Channel;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 150, CURRENT_TIMESTAMP());

    IF i_Country = 'ALL' AND i_Year_Month_Num = 0 THEN

        TRUNCATE TABLE Fact_Sellthru_Traffic;
        INSERT INTO Fact_Sellthru_Traffic
        SELECT *
        FROM Stg_Fact_Sellthru_Traffic;


    ELSEIF i_Call_Type = 'SUBMIT' THEN

        DELETE
        FROM InPro_Fact_Sellthru_Traffic
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

        INSERT INTO InPro_Fact_Sellthru_Traffic
        SELECT *
        FROM Stg_Fact_Sellthru_Traffic
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Fact_Sellthru_Traffic
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

        INSERT INTO Fact_Sellthru_Traffic
        SELECT *
        FROM Stg_Fact_Sellthru_Traffic
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Sellthru_Traffic', i_Call_Type, 160, CURRENT_TIMESTAMP());

END;


