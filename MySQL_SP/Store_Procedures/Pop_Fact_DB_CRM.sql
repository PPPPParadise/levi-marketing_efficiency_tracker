create
    definer = pkishlay@`%` procedure Pop_Fact_DB_CRM(IN i_Job_ID int, IN i_Country varchar(30), IN i_Year_Month_Num int,
                                                     IN i_Call_Type varchar(30))
BEGIN

    SET SQL_SAFE_UPDATES = 0;
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 0, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Stg_Fact_DB_CRM;

        INSERT INTO Stg_Fact_DB_CRM (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region,
                                     CRM_Type)
        SELECT DISTINCT DC.Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, C.Country, Region, CRM_Type
        FROM Dim_Calendar_Month DC,
             Dim_Country C,
             CRM_Member_Data
        WHERE DC.Year_Month_Num BETWEEN '201612' AND DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y%m')
        ORDER BY DC.Year_Month_Num;
        COMMIT;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        TRUNCATE TABLE Stg_Fact_DB_CRM;

        INSERT INTO Stg_Fact_DB_CRM (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region,
                                     CRM_Type)
        SELECT DISTINCT DC.Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, C.Country, Region, CRM_Type
        FROM Dim_Calendar_Month DC,
             Dim_Country C,
             CRM_Member_Data
        WHERE DC.Year_Month_Num = i_Year_Month_Num
          AND C.Country = i_Country;
        COMMIT;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 10, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_CRM
    SET Fiscal_Date =
            CONCAT(SUBSTRING(STR_TO_DATE(Year_Month_Num, '%Y%m'), 1, 7), '-01');


    UPDATE Stg_Fact_DB_CRM FDC,
        (SELECT Year_Month_Num,
                Country,
                CRM_Type,
                NewJoins,
                PreviousYr_NewJoin,
                TotalMbr,
                PreviousYr_TotalMbr,
                Revenue,
                PreviousYr_Revenue,
                MemberRevenue,
                PreviousYr_MemberRevenue,
                NewMember_Revenue,
                PreviousYr_NewMember_Revenue,
                ExistingMember_Revenue,
                PreviousYr_ExistingMember_Revenue,
                NonMember_Revenue,
                PreviousYr_NonMember_Revenue,
                NoOfTransaction,
                PreviousYr_NoOfTransaction,
                NoOfMbrTransaction,
                PreviousYr_NoOfMbrTransaction,
                NewMember_Transaction,
                PreviousYr_NewMember_Transaction,
                ExistingMember_Transaction,
                PreviousYr_ExistingMember_Transaction,
                NoOfNonMbrTransaction,
                PreviousYr_NoOfnonMbrTransaction,
                Units,
                PreviousYr_Units,
                MbrUnits,
                PreviousYr_MbrUnits,
                NewMember_Units,
                PreviousYr_NewMember_Units,
                ExistingMember_Units,
                PreviousYr_ExistingMember_Units,
                NonMbrUnits,
                PreviousYr_NonMbrUnits,
                Unsubscribed_pct,
                Attrition_pct,
                Active_Members,
                Engaged_Members,
                High_Engaged_Customers,
                Medium_Engaged_Customers,
                Low_Engaged_Customers
         FROM CRM_Member_Data) Q
    SET FDC.CRM_Type                  = Q.CRM_Type,
        FDC.New_Customer              = Q.NewJoins,
        FDC.Prev_New_Customer         = Q.PreviousYr_NewJoin,
        FDC.Total_Customer            = Q.TotalMbr,
        FDC.Prev_Total_Customer       = Q.PreviousYr_TotalMbr,
        FDC.Sellthru_Amt              = Q.Revenue,
        FDC.Prev_Sellthru_Amt         = Q.PreviousYr_Revenue,
        FDC.Mem_Sellthru              = Q.MemberRevenue,
        FDC.Prev_Mem_Sellthru         = Q.PreviousYr_MemberRevenue,
        FDC.NewMem_Sellthru           = Q.NewMember_Revenue,
        FDC.Prev_NewMem_Sellthru      = Q.PreviousYr_NewMember_Revenue,
        FDC.ExistingMem_Sellthru      = Q.ExistingMember_Revenue,
        FDC.Prev_ExistingMem_Sellthru = Q.PreviousYr_ExistingMember_Revenue,
        FDC.Non_Mem_Sellthru          = Q.NonMember_Revenue,
        FDC.Prev_Non_Mem_Sellthru     = Q.PreviousYr_NonMember_Revenue,
        FDC.No_Of_Trans               = Q.NoOfTransaction,
        FDC.Prev_No_Of_Trans          = Q.PreviousYr_NoOfTransaction,
        FDC.Mem_Trans                 = Q.NoOfMbrTransaction,
        FDC.Prev_Mem_Trans            = Q.PreviousYr_NoOfMbrTransaction,
        FDC.NewMem_Trans              = Q.NewMember_Transaction,
        FDC.Prev_NewMem_Trans         = Q.PreviousYr_NewMember_Transaction,
        FDC.ExistingMem_Trans         = Q.ExistingMember_Transaction,
        FDC.Prev_ExistingMem_Trans    = Q.PreviousYr_ExistingMember_Transaction,
        FDC.Non_Mem_Trans             = Q.NoOfNonMbrTransaction,
        FDC.Prev_Non_Mem_Trans        = Q.PreviousYr_NoOfnonMbrTransaction,
        FDC.No_Of_Units               = Q.Units,
        FDC.Prev_No_Of_Units          = Q.PreviousYr_Units,
        FDC.Mem_Units                 = Q.MbrUnits,
        FDC.Prev_Mem_Units            = Q.PreviousYr_MbrUnits,
        FDC.NewMem_Units              = Q.NewMember_Units,
        FDC.Prev_NewMem_Units         = Q.PreviousYr_NewMember_Units,
        FDC.ExistingMem_Units         = Q.ExistingMember_Units,
        FDC.Prev_ExistingMem_Units    = Q.PreviousYr_ExistingMember_Units,
        FDC.Non_Mem_Units             = Q.NonMbrUnits,
        FDC.Prev_Non_Mem_Units        = Q.PreviousYr_NonMbrUnits,
        FDC.Unsubscribed_pct          = Q.Unsubscribed_pct,
        FDC.Attrition_pct             = Q.Attrition_pct,
        FDC.Active_Members            = Q.Active_Members,
        FDC.Engaged_Members           = Q.Engaged_Members,
        FDC.High_Engaged_Customers=Q.High_Engaged_Customers,
        FDC.Medium_Engaged_Customers=Q.Medium_Engaged_Customers,
        FDC.Low_Engaged_Customers=Q.Low_Engaged_Customers
    WHERE FDC.Year_Month_Num = Q.Year_Month_Num
      AND FDC.Country = Q.Country
      AND FDC.CRM_Type = Q.CRM_Type;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 20, CURRENT_TIMESTAMP());
    # /*
#    -- Offline
# UPDATE Stg_Fact_DB_CRM A, (SELECT * FROM CRM_Member_Data WHERE CRM_Type = 'Offline') B
# 	SET -- A.Sellthru_Amt = B.Revenue,
#        A.Mem_Sellthru = B.MemberRevenue,
#        A.NewMem_Sellthru = B.NewMember_Revenue,
#        A.ExistingMem_Sellthru = B.ExistingMember_Revenue,
#    --    A.Non_Mem_Sellthru = B.NonMember_Revenue,
#    --    A.No_Of_Trans = B.NoOfTransaction,
#        A.Mem_Trans = B.NoOfMbrTransaction,
#        A.NewMem_Trans = B.NewMember_Transaction,
#        A.ExistingMem_Trans = B.ExistingMember_Transaction,
#    --   A.Non_Mem_Trans = B.NoOfNonMbrTransaction,
#     --   A.No_Of_Units = B.Units,
#        A.Mem_Units = B.MbrUnits,
#        A.NewMem_Units = B.NewMember_Units,
#        A.ExistingMem_Units = B.ExistingMember_Units,
#   --     A.Non_Mem_Units = B.NonMbrUnits,
#        A.New_Customer = B.NewJoins,
#        A.Total_Customer = B.TotalMbr
#       WHERE A.Country = B.Country AND A.Year_Month_Num = B.Year_Month_Num
#       AND A.CRM_Type = B.CRM_Type;*/
#
    UPDATE Stg_Fact_DB_CRM SF,
        (SELECT Country,
                Fiscal_Month,
                SUM(Gross_Value_without_Tax)     Sellthru_Amt,
                SUM(Transaction_Count_Reference) No_Of_Trans,
                SUM(Net_Units)                   No_Of_Units
         FROM Sellthru S,
              Dim_Customer D
         WHERE S.Customer_Code = D.Ship_to_Code
           AND S.Sales_Org = D.Sales_Org
         GROUP BY Country, Fiscal_Month) Q
    SET SF.Sellthru_Amt = Q.Sellthru_Amt,
        /*SF.No_Of_Trans = Q.No_Of_Trans,*/
        SF.No_Of_Units  = Q.No_Of_Units
    WHERE SF.Year_Month_Num = Q.Fiscal_Month
      AND SF.Country = Q.Country
      AND SF.CRM_Type = 'Offline';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_CRM SF,
        (SELECT Country, Year_Month_Num, SUM(Trans_Count) No_Of_Trans, SUM(Traffic_Count) S_Traffic_Count
         FROM Traffic S,
              Dim_Customer D
         WHERE S.Ship_to_Code = D.Ship_to_Code
           AND S.Company_Code = D.Sales_Org
         GROUP BY Country, Year_Month_Num) Q
    SET SF.No_Of_Trans   = Q.No_Of_Trans,
        SF.Traffic_Count = Q.S_Traffic_Count
    WHERE SF.Year_Month_Num = Q.Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.CRM_Type = 'Offline';


    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 40, CURRENT_TIMESTAMP());


    UPDATE Stg_Fact_DB_CRM SF,
        (SELECT Country,
                Year_Month_Num,
                Sellthru_Amt,
                Mem_Sellthru,
                No_Of_Trans,
                Mem_Trans,
                No_Of_Units,
                Mem_Units
         FROM Stg_Fact_DB_CRM
         WHERE CRM_Type = 'Offline') Q
    SET SF.Non_Mem_Sellthru = (CASE WHEN Q.Sellthru_Amt IS NULL THEN 0 ELSE Q.Sellthru_Amt END) -
                              (CASE WHEN Q.Mem_Sellthru IS NULL THEN 0 ELSE Q.Mem_Sellthru END),
        SF.Non_Mem_Trans    = (CASE WHEN Q.No_Of_Trans IS NULL THEN 0 ELSE Q.No_Of_Trans END) -
                              (CASE WHEN Q.Mem_Trans IS NULL THEN 0 ELSE Q.Mem_Trans END),
        SF.Non_Mem_Units    = (CASE WHEN Q.No_Of_Units IS NULL THEN 0 ELSE Q.No_Of_Units END) -
                              (CASE WHEN Q.Mem_Units IS NULL THEN 0 ELSE Q.Mem_Units END)
    WHERE SF.Country = Q.Country
      AND SF.Year_Month_Num = Q.Year_Month_Num
      AND SF.CRM_Type = 'Offline';

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 50, CURRENT_TIMESTAMP());
    #  /*
#    -- Online
# UPDATE Stg_Fact_DB_CRM A, (SELECT * FROM CRM_Member_Data WHERE CRM_Type = 'Online') B
#    SET A.Sellthru_Amt = B.Revenue,
#        A.Mem_Sellthru = B.MemberRevenue,
#        A.NewMem_Sellthru = B.NewMember_Revenue,
#        A.ExistingMem_Sellthru = B.ExistingMember_Revenue,
#        A.Non_Mem_Sellthru = B.NonMember_Revenue,
#        A.No_Of_Trans = B.NoOfTransaction,
#        A.Mem_Trans = B.NoOfMbrTransaction,
#        A.NewMem_Trans = B.NewMember_Transaction,
#        A.ExistingMem_Trans = B.ExistingMember_Transaction,
#        A.Non_Mem_Trans = B.NoOfNonMbrTransaction,
#        A.No_Of_Units = B.Units,
#        A.Mem_Units = B.MbrUnits,
#        A.NewMem_Units = B.NewMember_Units,
#        A.ExistingMem_Units = B.ExistingMember_Units,
#        A.Non_Mem_Units = B.NonMbrUnits,
#        A.New_Customer = B.NewJoins,
#        A.Total_Customer = B.TotalMbr
#       WHERE A.Country = B.Country AND A.Year_Month_Num = B.Year_Month_Num
#       AND A.CRM_Type = B.CRM_Type;
#       */
#
#
    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        UPDATE Stg_Fact_DB_CRM FDC,
            (SELECT CRM_Type, Month_Num, Country, SUM(CRM_Spend) CRM_Spend
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
             GROUP BY Month_Num, Country, CRM_Type) Q
        SET FDC.CRM_Spend = Q.CRM_Spend
        WHERE FDC.Year_Month_Num = Q.Month_Num
          AND FDC.Country = Q.Country
          and FDC.CRM_Type = Q.CRM_Type;

        UPDATE Stg_Fact_DB_CRM FDG,
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
          AND FDG.CRM_Type = 'Offline';

        UPDATE Stg_Fact_DB_CRM FDG,
            (SELECT Year_Month_Num, Country, Total_Mentions TMC
             FROM Pulsar_Sentiment PS
             WHERE PS.Brand_Name = 'Levi''s'
             GROUP BY Year_Month_Num, PS.Country) Q1
        SET FDG.Listening = Q1.TMC
        WHERE FDG.Country = Q1.Country
          AND FDG.Year_Month_Num = Q1.Year_Month_Num
          AND FDG.CRM_Type = 'Offline';


        UPDATE Stg_Fact_DB_CRM FDG,
            (SELECT Year_Month_Num,
                    Country,
                    SUM(Weibo_Likes_Levis) + SUM(Weibo_Retweet_Levis) + SUM(Weibo_Comment_Levis) AS Eng
             FROM SocialMedia_China
             GROUP BY Year_Month_Num, Country
             UNION
             SELECT Month_Num Year_Month_Num, Country, SUM(VSS_Total_Views) + SUM(Total_Engagement) AS Eng
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
             GROUP BY Month_Num, Country) Q
        SET FDG.Engagement = Q.Eng
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num
          AND FDG.CRM_Type = 'Offline';

    ELSEIF i_Call_Type = 'APPROVE' THEN

        UPDATE Stg_Fact_DB_CRM FDC,
            (SELECT CRM_Type, Month_Num, Country, SUM(CRM_Spend) CRM_Spend
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
               AND Month_Num = i_Year_Month_Num
               AND Country = i_Country
             GROUP BY Month_Num, Country, CRM_Type) Q
        SET FDC.CRM_Spend = Q.CRM_Spend
        WHERE FDC.Year_Month_Num = Q.Month_Num
          AND FDC.Country = Q.Country
          and FDC.CRM_Type = Q.CRM_Type;

        UPDATE Stg_Fact_DB_CRM FDG,
            (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) TMC
             FROM Zignal_Data_Sentiment_Breakdown ZS,
                  Dim_Calendar DC
             WHERE ZS.Start_Date = DC.Fiscal_Date
               AND ZS.Brand_Name = 'Levi''s'
               AND ZS.Start_Date >= '2017-12-01'
               AND DC.Year_Month_Num = i_Year_Month_Num
               AND ZS.Country = i_Country
             GROUP BY DC.Year_Month_Num, ZS.Country) Q
        SET FDG.Listening = Q.TMC
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num
          AND FDG.CRM_Type = 'Offline';

        UPDATE Stg_Fact_DB_CRM FDG,
            (SELECT DC.Year_Month_Num, PS.Country, Total_Mentions TMC
             FROM Pulsar_Sentiment PS,
                  Dim_Calendar DC
             WHERE PS.Year_Month_Num = DC.Year_Month_Num
               AND PS.Brand_Name = 'Levi''s'
               AND PS.Year_Month_Num = i_Year_Month_Num
               AND PS.Country = i_Country
             GROUP BY DC.Year_Month_Num, PS.Country) Q1
        SET FDG.Listening = Q1.TMC
        WHERE FDG.Country = Q1.Country
          AND FDG.Year_Month_Num = Q1.Year_Month_Num
          AND FDG.CRM_Type = 'Offline';

        UPDATE Stg_Fact_DB_CRM FDG,
            (SELECT Year_Month_Num,
                    Country,
                    SUM(Weibo_Likes_Levis) + SUM(Weibo_Retweet_Levis) + SUM(Weibo_Comment_Levis) AS Eng
             FROM SocialMedia_China
             WHERE Year_Month_Num = i_Year_Month_Num
               AND Country = i_Country
             GROUP BY Year_Month_Num, Country
             UNION
             SELECT Month_Num Year_Month_Num, Country, SUM(VSS_Total_Views) + SUM(Total_Engagement) AS Eng
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
               AND Month_Num = i_Year_Month_Num
               AND Country = i_Country
             GROUP BY Month_Num, Country) Q
        SET FDG.Engagement = Q.Eng
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num
          AND FDG.CRM_Type = 'Offline';
    END IF;


    COMMIT;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 60, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_CRM SF,
        (SELECT Country,
                Year_Month_Num + 100 P_Year_Month_Num,
                CRM_Type,
                Sellthru_Amt,
                Mem_Sellthru,
                NewMem_Sellthru,
                ExistingMem_Sellthru,
                Non_Mem_Sellthru,
                No_Of_Trans,
                Mem_Trans,
                NewMem_Trans,
                ExistingMem_Trans,
                Non_Mem_Trans,
                No_Of_Units,
                Mem_Units,
                NewMem_Units,
                ExistingMem_Units,
                Non_Mem_Units,
                New_Customer,
                Total_Customer,
                CRM_Spend,
                Listening,
                Engagement,
                Unsubscribed_pct,
                Attrition_pct,
                Active_Members,
                Engaged_Members
         FROM Stg_Fact_DB_CRM) Q
    SET SF.Prev_Sellthru_Amt         = Q.Sellthru_Amt,
        SF.Prev_Mem_Sellthru         = Q.Mem_Sellthru,
        SF.Prev_NewMem_Sellthru      = Q.NewMem_Sellthru,
        SF.Prev_ExistingMem_Sellthru = Q.ExistingMem_Sellthru,
        SF.Prev_Non_Mem_Sellthru     = Q.Non_Mem_Sellthru,
        SF.Prev_No_Of_Trans          = Q.No_Of_Trans,
        SF.Prev_Mem_Trans            = Q.Mem_Trans,
        SF.Prev_NewMem_Trans         = Q.NewMem_Trans,
        SF.Prev_ExistingMem_Trans    = Q.ExistingMem_Trans,
        SF.Prev_Non_Mem_Trans        = Q.Non_Mem_Trans,
        SF.Prev_No_Of_Units          = Q.No_Of_Units,
        SF.Prev_Mem_Units            = Q.Mem_Units,
        SF.Prev_NewMem_Units         = Q.NewMem_Units,
        SF.Prev_ExistingMem_Units    = Q.ExistingMem_Units,
        SF.Prev_Non_Mem_Units        = Q.Non_Mem_Units,
        SF.Prev_New_Customer         = Q.New_Customer,
        SF.Prev_Total_Customer       = Q.Total_Customer,
        SF.Prev_CRM_Spend            = Q.CRM_Spend,
        SF.Prev_Listening            = Q.Listening,
        SF.Prev_Engagement           = Q.Engagement,
        SF.Prev_Unsubscribed_pct     = Q.Unsubscribed_pct,
        SF.Prev_Attrition_pct        = Q.Attrition_pct,
        SF.Prev_Active_Members       = Q.Active_Members,
        SF.Prev_Engaged_Members      = Q.Engaged_Members
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.CRM_Type = Q.CRM_Type;
    COMMIT;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 70, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_CRM SFDC,
        (SELECT Year_Month_Num, Country, SUM(Sellout) Sellout, SUM(Prev_Sellout) Prev_Sellout
         FROM Fact_Sellthru_Traffic
         GROUP BY Year_Month_Num, Country) FDG
    SET SFDC.Sellout      = FDG.Sellout,
        SFDC.Prev_Sellout = FDG.Prev_Sellout
    WHERE FDG.Year_Month_Num = SFDC.Year_Month_Num
      AND FDG.Country = SFDC.Country;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 80, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Fact_DB_CRM;
        INSERT INTO Fact_DB_CRM SELECT * FROM Stg_Fact_DB_CRM;


    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Fact_DB_CRM
        WHERE Country = i_Country
          AND Year_Month_Num = i_Year_Month_Num;

        INSERT INTO Fact_DB_CRM
        SELECT *
        FROM Stg_Fact_DB_CRM
        WHERE Country = i_Country
          AND Year_Month_Num = i_Year_Month_Num;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_CRM', i_Call_Type, 90, CURRENT_TIMESTAMP());

    #     TRUNCATE TABLE Fact_DB_CRM;
# 	INSERT INTO Fact_DB_CRM SELECT * FROM Stg_Fact_DB_CRM ;

END;


