create
    definer = gilbert@`%` procedure Pop_Campaign_Performance(IN i_Job_ID int, IN i_Country varchar(30),
                                                             IN i_Year_Month_Num int, IN i_Call_Type varchar(30))
BEGIN

    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 0, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Stg_Campaign_Performance;

        INSERT INTO Stg_Campaign_Performance(Country, Campaign_Name, Fiscal_Year,
                                             Campaign_Start_Month, Campaign_End_Month, Type_of_Campaign,
                                             Region)
        SELECT MTS.Country,
               TRIM(MTS.Campaign_Name_Upd),
               DC.Fiscal_Year,
               MIN(MTS.Month_Num) AS Start_Month,
               MAX(MTS.Month_Num) AS End_Month,
               TRIM(Type_of_Campaign_Upd),
               Region
        FROM MKT_Template_Spend MTS,
             Dim_Calendar DC,
             Dim_Country C
        WHERE MTS.Month_Num = DC.Year_Month_Num
          AND MTS.Country = C.Country
          AND MTS.Process_Flag = 'Y'
        GROUP BY MTS.Country, MTS.Campaign_Name_Upd, DC.Fiscal_Year, MTS.Type_of_Campaign_Upd;

    ELSEIF i_Call_Type = 'SUBMIT' THEN

        TRUNCATE TABLE Stg_Campaign_Performance;

        INSERT INTO Stg_Campaign_Performance(Country, Campaign_Name, Fiscal_Year,
                                             Campaign_Start_Month, Campaign_End_Month, Type_of_Campaign,
                                             Region)
        SELECT *
        FROM (SELECT MTS.Country,
                     TRIM(MTS.Campaign_Name_Upd),
                     DC.Fiscal_Year,
                     MIN(MTS.Month_Num) AS Start_Month,
                     MAX(MTS.Month_Num) AS End_Month,
                     TRIM(Type_of_Campaign_Upd),
                     Region
              FROM MKT_Template_Spend MTS,
                   Dim_Calendar DC,
                   Dim_Country C
              WHERE MTS.Month_Num = DC.Year_Month_Num
                AND MTS.Country = C.Country
              GROUP BY MTS.Country, MTS.Campaign_Name_Upd, DC.Fiscal_Year, MTS.Type_of_Campaign_Upd) Q
        WHERE Q.Country = i_Country
          AND Q.Start_Month = i_Year_Month_Num;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        TRUNCATE TABLE Stg_Campaign_Performance;

        INSERT INTO Stg_Campaign_Performance(Country, Campaign_Name, Fiscal_Year,
                                             Campaign_Start_Month, Campaign_End_Month, Type_of_Campaign,
                                             Region)
        SELECT *
        FROM (SELECT MTS.Country,
                     TRIM(MTS.Campaign_Name_Upd),
                     DC.Fiscal_Year,
                     MIN(MTS.Month_Num) AS Start_Month,
                     MAX(MTS.Month_Num) AS End_Month,
                     TRIM(Type_of_Campaign_Upd),
                     Region
              FROM MKT_Template_Spend MTS,
                   Dim_Calendar DC,
                   Dim_Country C
              WHERE MTS.Month_Num = DC.Year_Month_Num
                AND MTS.Country = C.Country
                AND MTS.Process_Flag = 'Y'
              GROUP BY MTS.Country, MTS.Campaign_Name_Upd, DC.Fiscal_Year, MTS.Type_of_Campaign_Upd) Q
        WHERE Q.Country = i_Country
          AND Q.Start_Month = i_Year_Month_Num;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 10, CURRENT_TIMESTAMP());

    IF i_Call_Type = 'SUBMIT' THEN /* Irrespective of approved or not  */
        UPDATE Stg_Campaign_Performance CP,
            (SELECT Campaign_Name_Upd,
                    Country,
                    Fiscal_Year,
                    MIN(MTS.Campaign_Start_Date) AS Campaign_Start_Date,
                    MAX(MTS.Campaign_End_Date)   AS Campaign_End_Date
             FROM (SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(TV_Campaig_Start_Date) AS Campaign_Start_Date,
                          MAX(TV_Campaign_End_Date)  AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE TV_Campaig_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Print_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Print_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Print_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Radio_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Radio_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Radio_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(OOH_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(OOH_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE OOH_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Digital_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Digital_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Digital_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(CRM_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(CRM_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE CRM_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(PR_Start_Date) AS Campaign_Start_Date,
                          MAX(PR_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE PR_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Cinema_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Cinema_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Cinema_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Others_campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Others_campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Others_campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(SE_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(SE_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE SE_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(VSS_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(VSS_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE VSS_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Marketplace_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Marketplace_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Marketplace_Campaign_Start_Date != '0000-00-00'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year) MTS
             GROUP BY Campaign_Name_Upd, Country, Fiscal_Year) Q
        SET CP.Campaign_Start_Date = Q.Campaign_Start_Date,
            CP.Campaign_End_Date   = Q.Campaign_End_Date
        WHERE CP.Country = Q.Country
          AND CP.Campaign_name = Q.Campaign_Name_Upd
          AND CP.Fiscal_Year = Q.Fiscal_Year;
    ELSE
        UPDATE Stg_Campaign_Performance CP,
            (SELECT Campaign_Name_Upd,
                    Country,
                    Fiscal_Year,
                    MIN(MTS.Campaign_Start_Date) AS Campaign_Start_Date,
                    MAX(MTS.Campaign_End_Date)   AS Campaign_End_Date
             FROM (SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(TV_Campaig_Start_Date) AS Campaign_Start_Date,
                          MAX(TV_Campaign_End_Date)  AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE TV_Campaig_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Print_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Print_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Print_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Radio_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Radio_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Radio_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(OOH_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(OOH_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE OOH_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Digital_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Digital_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Digital_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(CRM_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(CRM_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE CRM_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(PR_Start_Date) AS Campaign_Start_Date,
                          MAX(PR_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE PR_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Cinema_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Cinema_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Cinema_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Others_campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Others_campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Others_campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(SE_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(SE_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE SE_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(VSS_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(VSS_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE VSS_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year
                   UNION
                   SELECT Campaign_Name_Upd,
                          Country,
                          Fiscal_Year,
                          MIN(Marketplace_Campaign_Start_Date) AS Campaign_Start_Date,
                          MAX(Marketplace_Campaign_End_Date)   AS Campaign_End_Date
                   FROM MKT_Template_Spend
                   WHERE Marketplace_Campaign_Start_Date != '0000-00-00'
                     AND Process_Flag = 'Y'
                   GROUP BY Campaign_Name_Upd, Country, Fiscal_Year) MTS
             GROUP BY Campaign_Name_Upd, Country, Fiscal_Year) Q
        SET CP.Campaign_Start_Date = Q.Campaign_Start_Date,
            CP.Campaign_End_Date   = Q.Campaign_End_Date
        WHERE CP.Country = Q.Country
          AND CP.Campaign_name = Q.Campaign_Name_Upd
          AND CP.Fiscal_Year = Q.Fiscal_Year;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 20, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT P.Campaign_name,
                P.Country,
                P.Fiscal_Year,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                SUM(Comp)              C_Sellout,
                SUM(Traffic_Comp)      C_Traffic_Comp,
                SUM(Prev_Traffic_Comp) C_Prev_Traffic_Comp,
                SUM(No_Of_Trans)       S_Qty_Sold,
                SUM(On_Hand_Qty)       S_On_Hand_Qty
         FROM Fact_Sellthru_Traffic G,
              Stg_Campaign_Performance P
         WHERE G.Country = P.Country
           AND G.Year_Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
         GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
    SET CP.Campaign_Sellout                = Q.C_Sellout,
        CP.Campaign_Traffic_Comp           = Q.C_Traffic_Comp,
        CP.Prev_Year_Campaign_Traffic_Comp = Q.C_Prev_Traffic_Comp,
        CP.Qty_Sold                        = Q.S_Qty_Sold,
        CP.Qty_On_Hand                     = Q.S_On_Hand_Qty
    WHERE CP.Campaign_name = Q.Campaign_name
      AND CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CD.Campaign_name,
                CD.Country,
                CD.Fiscal_Year,
                CD.Campaign_Start_Month,
                CD.Campaign_End_Month,
                SUM(G.Comp)        C_Sellout,
                SUM(G.No_Of_Trans) S_Qty_Sold,
                SUM(G.On_Hand_Qty) S_On_Hand_Qty,
                SUM(Traffic_Comp)  C_Traffic_Comp
         FROM Fact_Sellthru_Traffic G,
              (SELECT CP1.Country,
                      CP1.Fiscal_Year,
                      CP1.Campaign_name,
                      CP1.Campaign_Start_Month,
                      CP1.Campaign_End_Month,
                      CASE
                          WHEN CP2.Campaign_Start_Month IS NOT NULL THEN CP2.Campaign_Start_Month
                          ELSE CP1.Campaign_Start_Month - 100 END AS F_Campaign_Start_Month,
                      CASE
                          WHEN CP2.Campaign_End_Month IS NOT NULL THEN CP2.Campaign_End_Month
                          ELSE CP1.Campaign_End_Month - 100 END   AS F_Campaign_End_Date
               FROM Stg_Campaign_Performance CP1
                        LEFT JOIN Stg_Campaign_Performance CP2
                                  ON CP1.Country = CP2.Country AND
                                     CP1.Fiscal_Year = CP2.Fiscal_Year + 1 AND
                                     CP1.Campaign_name = CP2.Campaign_name) CD
         WHERE G.Country = CD.Country
           AND G.Year_Month_Num BETWEEN CD.F_Campaign_Start_Month AND CD.F_Campaign_End_Date
         GROUP BY CD.Campaign_name, CD.Country, CD.Fiscal_Year, CD.Campaign_Start_Month, CD.Campaign_End_Month) Q
    SET CP.Prev_Year_Campaign_Sellout      = Q.C_Sellout,
        CP.Prev_Year_Qty_Sold              = Q.S_Qty_Sold,
        CP.Prev_Year_Qty_On_Hand           = Q.S_On_Hand_Qty,
        CP.Prev_Year_Campaign_Traffic_Comp = Q.C_Traffic_Comp
    WHERE CP.Campaign_name = Q.Campaign_name
      AND CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 40, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '12' THEN Year_Month_Num + 89
                    ELSE Year_Month_Num + 1 END P_Year_Month_Num,
                Country,
                Fiscal_Year,
                SUM(Comp)                       Sellout,
                SUM(Traffic_Comp)               C_Traffic_Comp,
                SUM(Prev_Traffic_Comp)          C_Prev_Traffic_Comp,
                SUM(No_Of_Trans)                S_Qty_Sold,
                SUM(On_Hand_Qty)                S_On_Hand_Qty
         FROM Fact_Sellthru_Traffic
         GROUP BY P_Year_Month_Num, Country, Fiscal_Year) Q
    SET Prev_Month_Sellout                   = Q.Sellout,
        CP.Prev_Month_Traffic_Comp           = Q.C_Traffic_Comp,
        CP.Prev_Year_Prev_Month_Traffic_Comp = Q.C_Prev_Traffic_Comp,
        CP.Prev_Month_Qty_Sold               = Q.S_Qty_Sold,
        CP.Prev_Month_Qty_On_Hand            = Q.S_On_Hand_Qty
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.P_Year_Month_Num;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 50, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CD.Campaign_name,
                CD.Country,
                CD.Fiscal_Year,
                CD.Campaign_Start_Month,
                CD.Campaign_End_Month,
                SUM(Comp)         Sellout,
                SUM(No_Of_Trans)  S_Qty_Sold,
                SUM(On_Hand_Qty)  S_On_Hand_Qty,
                SUM(Traffic_Comp) C_Traffic_Comp
         FROM Fact_Sellthru_Traffic G,
              (SELECT CP1.Country,
                      CP1.Fiscal_Year,
                      CP1.Campaign_name,
                      CP1.Campaign_Start_Month,
                      CP1.Campaign_End_Month,
                      CASE
                          WHEN CP2.Campaign_Start_Month IS NOT NULL THEN CP2.Campaign_Start_Month
                          ELSE CP1.Campaign_Start_Month - 100 END AS F_Campaign_Start_Month,
                      CASE
                          WHEN CP2.Campaign_End_Month IS NOT NULL THEN CP2.Campaign_End_Month
                          ELSE CP1.Campaign_End_Month - 100 END   AS F_Campaign_End_Date
               FROM Stg_Campaign_Performance CP1
                        LEFT JOIN Stg_Campaign_Performance CP2
                                  ON CP1.Country = CP2.Country AND
                                     CP1.Fiscal_Year = CP2.Fiscal_Year + 1 AND
                                     CP1.Campaign_name = CP2.Campaign_name) CD
         WHERE G.Country = CD.Country
           AND G.Year_Month_Num = CASE
                                      WHEN SUBSTR(CD.F_Campaign_Start_Month, 5, 2) = '01'
                                          THEN CD.F_Campaign_Start_Month - 89
                                      ELSE CD.F_Campaign_Start_Month - 1 END
         GROUP BY CD.Campaign_name, CD.Country, CD.Fiscal_Year, CD.Campaign_Start_Month, CD.Campaign_End_Month) Q
    SET Prev_Year_Prev_Month_Sellout         = Q.Sellout,
        CP.Prev_Year_Prev_Month_Qty_Sold     = Q.S_Qty_Sold,
        CP.Prev_Year_Prev_Month_Qty_On_Hand  = Q.S_On_Hand_Qty,
        CP.Prev_Year_Prev_Month_Traffic_Comp = Q.C_Traffic_Comp
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 60, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '01' THEN Year_Month_Num - 89
                    ELSE Year_Month_Num - 1 END N_Year_Month_Num,
                Country,
                Fiscal_Year,
                SUM(Comp)                       Sellout,
                SUM(Traffic_Comp)               C_Traffic_Comp,
                SUM(Prev_Traffic_Comp)          C_Prev_Traffic_Comp,
                SUM(No_Of_Trans)                S_Qty_Sold,
                SUM(On_Hand_Qty)                S_On_Hand_Qty
         FROM Fact_Sellthru_Traffic
         GROUP BY N_Year_Month_Num, Country, Fiscal_Year) Q
    SET Next_Month_Sellout          = Q.Sellout,
        CP.Next_Month_STraffic_Comp = Q.C_Traffic_Comp,
        CP.Next_Month_Qty_Sold      = Q.S_Qty_Sold,
        CP.Next_Month_Qty_On_Hand   = Q.S_On_Hand_Qty
    WHERE CP.Country = Q.Country
      AND CP.Campaign_End_Month = Q.N_Year_Month_Num;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 70, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CD.Campaign_name,
                CD.Country,
                CD.Fiscal_Year,
                CD.Campaign_Start_Month,
                CD.Campaign_End_Month,
                SUM(Comp)         Sellout,
                SUM(No_Of_Trans)  S_Qty_Sold,
                SUM(On_Hand_Qty)  S_On_Hand_Qty,
                SUM(Traffic_Comp) C_Traffic_Comp
         FROM Fact_Sellthru_Traffic G,
              (SELECT CP1.Country,
                      CP1.Fiscal_Year,
                      CP1.Campaign_name,
                      CP1.Campaign_Start_Month,
                      CP1.Campaign_End_Month,
                      CASE
                          WHEN CP2.Campaign_Start_Month IS NOT NULL THEN CP2.Campaign_Start_Month
                          ELSE CP1.Campaign_Start_Month - 100 END AS F_Campaign_Start_Month,
                      CASE
                          WHEN CP2.Campaign_End_Month IS NOT NULL THEN CP2.Campaign_End_Month
                          ELSE CP1.Campaign_End_Month - 100 END   AS F_Campaign_End_Date
               FROM Stg_Campaign_Performance CP1
                        LEFT JOIN Stg_Campaign_Performance CP2
                                  ON CP1.Country = CP2.Country AND
                                     CP1.Fiscal_Year = CP2.Fiscal_Year + 1 AND
                                     CP1.Campaign_name = CP2.Campaign_name) CD
         WHERE G.Country = CD.Country
           AND G.Year_Month_Num = CASE
                                      WHEN SUBSTR(CD.F_Campaign_End_Date, 5, 2) = '12' THEN CD.F_Campaign_End_Date + 89
                                      ELSE CD.F_Campaign_End_Date + 1 END
         GROUP BY CD.Campaign_name, CD.Country, CD.Fiscal_Year, CD.Campaign_Start_Month, CD.Campaign_End_Month) Q
    SET Prev_Year_Next_Month_Sellout         = Q.Sellout,
        CP.Prev_Year_Next_Month_Qty_Sold     = Q.S_Qty_Sold,
        CP.Prev_Year_Next_Month_Qty_On_Hand  = Q.S_On_Hand_Qty,
        CP.Prev_Year_Next_Month_Traffic_Comp = Q.C_Traffic_Comp
    WHERE CP.Country = Q.Country
      AND CP.Campaign_End_Month = Q.Campaign_End_Month
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 80, CURRENT_TIMESTAMP());

    /* Irrespective of approved or not  */

    /*IF i_Call_Type = 'SUBMIT' THEN      
      
          UPDATE Stg_Campaign_Performance CP,
                  (SELECT G.Campaign_Name_Upd, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month,           
                      SUM(CASE WHEN Total_Engagement IS NULL THEN 0 ELSE Total_Engagement END) + SUM(CASE WHEN VSS_Total_Views IS NULL THEN 0 ELSE VSS_Total_Views END) C_Brand_Engagement,
                      SUM(Total_Clicks) + SUM(SE_Total_Clicks) + SUM(VSS_Total_Clicks) + SUM(Ad_Clicks) Clicks
                  FROM MKT_Template_Spend G , Stg_Campaign_Performance P
                  WHERE G.Country = P.Country 
                      AND G.Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
                      AND G.Campaign_Name_Upd = P.Campaign_name
                  GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
              SET  CP.Brand_Engagement = Q.C_Brand_Engagement,
                  CP.Clicks = Q.Clicks
              WHERE CP.Campaign_name = Q.Campaign_Name_Upd AND 
                  CP.Country = Q.Country AND 
                  CP.Campaign_Start_Month = Q.Campaign_Start_Month AND
                  CP.Campaign_End_Month = Q.Campaign_End_Month; 
      ELSE
      
          UPDATE Stg_Campaign_Performance CP,
                  (SELECT G.Campaign_Name_Upd, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month,           
                      SUM(CASE WHEN Total_Engagement IS NULL THEN 0 ELSE Total_Engagement END) + SUM(CASE WHEN VSS_Total_Views IS NULL THEN 0 ELSE VSS_Total_Views END) C_Brand_Engagement,
                      SUM(Total_Clicks) + SUM(SE_Total_Clicks) + SUM(VSS_Total_Clicks) + SUM(Ad_Clicks) Clicks
                  FROM MKT_Template_Spend G , Stg_Campaign_Performance P
                  WHERE G.Country = P.Country 
                      AND G.Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
                      AND G.Campaign_Name_Upd = P.Campaign_name
                      AND G.Process_Flag = 'Y'
                  GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
              SET  CP.Brand_Engagement = Q.C_Brand_Engagement,
                  CP.Clicks = Q.Clicks
              WHERE CP.Campaign_name = Q.Campaign_Name_Upd AND 
                  CP.Country = Q.Country AND 
                  CP.Campaign_Start_Month = Q.Campaign_Start_Month AND
                  CP.Campaign_End_Month = Q.Campaign_End_Month;
      END IF; */

    IF i_Call_Type = 'SUBMIT' THEN

        UPDATE Stg_Campaign_Performance CP,
            (SELECT G.Campaign_Name_Upd,
                    P.Country,
                    P.Fiscal_Year,
                    P.Campaign_Start_Month,
                    P.Campaign_End_Month,
                    SUM(CASE WHEN Total_Engagement IS NULL THEN 0 ELSE Total_Engagement END) +
                    SUM(CASE WHEN VSS_Total_Views IS NULL THEN 0 ELSE VSS_Total_Views END)            C_Brand_Engagement,
                    SUM(Total_Clicks) + SUM(SE_Total_Clicks) + SUM(VSS_Total_Clicks) + SUM(Ad_Clicks) Clicks,
                    Sum(Actual_Spend)                                                                 Campaign_Spend
             FROM MKT_Template_Spend G,
                  Stg_Campaign_Performance P
             WHERE G.Country = P.Country
               AND G.Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
               AND G.Campaign_Name_Upd = P.Campaign_name
             GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
        SET CP.Brand_Engagement = Q.C_Brand_Engagement,
            CP.Clicks           = Q.Clicks,
            CP.Campaign_Spend=Q.Campaign_Spend
        WHERE CP.Campaign_name = Q.Campaign_Name_Upd
          AND CP.Country = Q.Country
          AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
          AND CP.Campaign_End_Month = Q.Campaign_End_Month;
    ELSE

        UPDATE Stg_Campaign_Performance CP,
            (SELECT G.Campaign_Name_Upd,
                    P.Country,
                    P.Fiscal_Year,
                    P.Campaign_Start_Month,
                    P.Campaign_End_Month,
                    SUM(CASE WHEN Total_Engagement IS NULL THEN 0 ELSE Total_Engagement END) +
                    SUM(CASE WHEN VSS_Total_Views IS NULL THEN 0 ELSE VSS_Total_Views END)            C_Brand_Engagement,
                    SUM(Total_Clicks) + SUM(SE_Total_Clicks) + SUM(VSS_Total_Clicks) + SUM(Ad_Clicks) Clicks,
                    Sum(Actual_Spend)                                                                 Campaign_Spend
             FROM MKT_Template_Spend G,
                  Stg_Campaign_Performance P
             WHERE G.Country = P.Country
               AND G.Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
               AND G.Campaign_Name_Upd = P.Campaign_name
               AND G.Process_Flag = 'Y'
             GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
        SET CP.Brand_Engagement = Q.C_Brand_Engagement,
            CP.Clicks           = Q.Clicks,
            CP.Campaign_Spend=Q.Campaign_Spend
        WHERE CP.Campaign_name = Q.Campaign_Name_Upd
          AND CP.Country = Q.Country
          AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
          AND CP.Campaign_End_Month = Q.Campaign_End_Month;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 90, CURRENT_TIMESTAMP());

/*	UPDATE Stg_Campaign_Performance CP,
			(SELECT MTS.Campaign_Name_Upd, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month,           
					SUM(CASE WHEN Total_Engagement IS NULL THEN 0 ELSE Total_Engagement END) + SUM(CASE WHEN VSS_Total_Views IS NULL THEN 0 ELSE VSS_Total_Views END) C_Brand_Engagement,
					SUM(Total_Clicks) + SUM(SE_Total_Clicks) + SUM(VSS_Total_Clicks) + SUM(Ad_Clicks) Clicks
				FROM MKT_Template_Spend MTS, 
                (SELECT CP1.Country, CP1.Fiscal_Year, CP2.Campaign_Start_Month, CP2.Campaign_End_Month, CP1.Campaign_name,
							CP2.Campaign_Start_Date, CP2.Campaign_End_Date
					FROM Stg_Campaign_Performance CP1,
								Stg_Campaign_Performance CP2
							WHERE CP1.Country = CP2.Country AND 
								CP1.Fiscal_Year = CP2.Fiscal_Year +1  AND
								CP1.Campaign_name = CP2.Campaign_name) P
				WHERE MTS.Country = P.Country AND
					MTS.Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month AND 
					MTS.Campaign_Name_Upd = P.Campaign_name        
				GROUP BY MTS.Country,  P.Campaign_Start_Month, P.Campaign_End_Month, MTS.Campaign_Name_Upd) Q
		SET  CP.Prev_Year_Brand_Engagement = Q.C_Brand_Engagement,
         CP.Prev_Clicks = Q.Clicks 
		WHERE CP.Campaign_name = Q.Campaign_Name_Upd AND 
			CP.Country = Q.Country AND 
			CP.Campaign_Start_Month = Q.Campaign_Start_Month AND
			CP.Campaign_End_Month = Q.Campaign_End_Month; */

    UPDATE Stg_Campaign_Performance CP,
        (SELECT Country,
                Campaign_name,
                Fiscal_Year + 1       P_Fiscal_Year,
                SUM(Brand_Engagement) S_Brand_Engagement,
                SUM(Clicks)           S_Clicks,
                Sum(Campaign_Spend)   P_Campaign_Spend
         FROM Stg_Campaign_Performance
         GROUP BY Country, Campaign_name, P_Fiscal_Year) Q
    SET CP.Prev_Year_Brand_Engagement = Q.S_Brand_Engagement,
        CP.Prev_Clicks                = Q.S_Clicks,
        CP.Prev_Campaign_Spend=Q.P_Campaign_Spend
    WHERE CP.Campaign_name = Q.Campaign_name
      AND CP.Country = Q.Country
      AND CP.Fiscal_Year = Q.P_Fiscal_Year;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 100, CURRENT_TIMESTAMP());

    /*UPDATE Stg_Campaign_Performance CP,
         (SELECT  Country, Campaign_name, Fiscal_Year + 1 P_Fiscal_Year, 
         SUM(Brand_Engagement) S_Brand_Engagement, SUM(Clicks) S_Clicks
             FROM Stg_Campaign_Performance
             GROUP BY Country, Campaign_name, P_Fiscal_Year) Q
     SET  CP.Prev_Year_Brand_Engagement = Q.S_Brand_Engagement,
      CP.Prev_Clicks = Q.S_Clicks 
     WHERE CP.Campaign_name = Q.Campaign_name AND 
         CP.Country = Q.Country AND 
         CP.Fiscal_Year = Q.P_Fiscal_Year*/

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Campaign_Start_Month, 5, 2) = '12' THEN Campaign_Start_Month + 89
                    ELSE Campaign_Start_Month + 1 END P_Year_Month_Num,
                Country,
                Fiscal_Year,
                Clicks
         FROM Fact_Campaign_Performance) Q
    SET Prev_Month_Clicks = Q.Clicks
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.P_Year_Month_Num;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 110, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Campaign_End_Month, 5, 2) = '01' THEN Campaign_End_Month - 89
                    ELSE Campaign_End_Month - 1 END N_Year_Month_Num,
                Country,
                Fiscal_Year,
                Clicks
         FROM Fact_Campaign_Performance) Q
    SET Next_Month_Clicks = Q.Clicks
    WHERE CP.Country = Q.Country
      AND CP.Campaign_End_Month = Q.N_Year_Month_Num;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 120, CURRENT_TIMESTAMP());
-- --------------------------Product Sellout ----------------

    UPDATE Stg_Campaign_Performance CP,
        (SELECT P.Campaign_name,
                P.Country,
                P.Fiscal_Year,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                SUM(Product_Sellout) AS P_Sellout
         FROM Fact_DB_Campaign_Product S,
              Stg_Campaign_Performance P
         WHERE S.Country = P.Country
           AND S.Fiscal_Month_Num BETWEEN P.Campaign_Start_Month AND P.Campaign_End_Month
           AND S.Campaign_name = P.Campaign_name
         GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
    SET CP.Product_Campaign_Sellout = Q.P_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 130, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT P.Campaign_name,
                P.Country,
                P.Fiscal_Year,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                SUM(Product_Sellout) AS P_Sellout
         FROM Fact_DB_Campaign_Product S,
              Stg_Campaign_Performance P
         WHERE S.Country = P.Country
           AND P.Campaign_name = S.Campaign_name
           AND S.Fiscal_Month_Num BETWEEN P.Campaign_Start_Month - 100 AND P.Campaign_End_Month - 100
         GROUP BY P.Campaign_name, P.Country, P.Fiscal_Year, P.Campaign_Start_Month, P.Campaign_End_Month) Q
    SET CP.Prev_Year_Product_Campaign_Sellout = Q.P_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 140, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Fiscal_Month_Num, 5, 2) = '12' THEN Fiscal_Month_Num + 89
                    ELSE Fiscal_Month_Num + 1 END P_Year_Month_Num,
                Country,
                Campaign_name,
                SUM(Product_Sellout)              Som_Product_Sellout
         FROM Fact_DB_Campaign_Product
         GROUP BY Country, P_Year_Month_Num, Campaign_name) Q
    SET CP.Prev_Month_Product_Campaign_Sellout = Q.Som_Product_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.P_Year_Month_Num
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 150, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT (CASE
                     WHEN SUBSTR(Fiscal_Month_Num, 5, 2) = '12' THEN Fiscal_Month_Num + 89
                     ELSE Fiscal_Month_Num + 1 END) P_Year_Month_Num,
                Country,
                Campaign_name,
                SUM(Prev_Product_Sellout)           Sum_Prev_Product_Sellout
         FROM Fact_DB_Campaign_Product
         GROUP BY Country, P_Year_Month_Num, Campaign_name) Q
    SET CP.Prev_Year_Prev_Month_Product_Campaign_Sellout = Q.Sum_Prev_Product_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.P_Year_Month_Num
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 160, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT CASE
                    WHEN SUBSTR(Fiscal_Month_Num, 5, 2) = '01' THEN Fiscal_Month_Num - 89
                    ELSE Fiscal_Month_Num - 1 END N_Year_Month_Num,
                Country,
                Campaign_name,
                SUM(Product_Sellout)              Sum_Product_Sellout
         FROM Fact_DB_Campaign_Product
         GROUP BY Country, N_Year_Month_Num, Campaign_name) Q
    SET CP.Next_Month_Product_Campaign_Sellout = Q.Sum_Product_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_End_Month = Q.N_Year_Month_Num
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 170, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT (CASE
                     WHEN SUBSTR(Fiscal_Month_Num, 5, 2) = '01' THEN Fiscal_Month_Num - 89
                     ELSE Fiscal_Month_Num - 1 END) N_Year_Month_Num,
                Country,
                Campaign_name,
                SUM(Prev_Product_Sellout)           Sum_Prev_Product_Sellout
         FROM Fact_DB_Campaign_Product
         GROUP BY Country, N_Year_Month_Num, Campaign_name) Q
    SET CP.Prev_Year_Next_Month_Product_Campaign_Sellout = Q.Sum_Prev_Product_Sellout
    WHERE CP.Country = Q.Country
      AND CP.Campaign_End_Month = Q.N_Year_Month_Num
      AND CP.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 180, CURRENT_TIMESTAMP());

/*UPDATE  Stg_Campaign_Performance CP,
	(SELECT  GA.Country, GA.Year_Month_Num, GA.Campaign_Upd, SUM(Pageviews) Sum_Pageview
		FROM GA_Data GA
		GROUP BY GA.Country, GA.Year_Month_Num, GA.Campaign_Upd)Q
	SET CP.Website_Traffic = Q.Sum_Pageview
    WHERE CP.Country = Q.Country AND
		CP.Campaign_Start_Month = Q.Year_Month_Num  AND
		CP.Campaign_name = Q.Campaign_Upd;
        
UPDATE  Stg_Campaign_Performance CP,
	(SELECT  AD.Country, AD.Year_Month_Num, AD.Campaign_Upd, SUM(Pageviews) Sum_Pageview
		FROM Adobe_Data AD
		GROUP BY AD.Country, AD.Year_Month_Num, AD.Campaign_Upd)Q
	SET CP.Website_Traffic = Q.Sum_Pageview
    WHERE CP.Country = Q.Country AND
		CP.Campaign_Start_Month = Q.Year_Month_Num  AND
		CP.Campaign_name = Q.Campaign_Upd;
        
UPDATE  Stg_Campaign_Performance CP, 
	(SELECT  Country, Campaign_Start_Month +100 Prev_Month, Campaign_name, Website_Traffic
		FROM Stg_Campaign_Performance )Q
	SET CP.Prev_Year_Website_Traffic = Q.Website_Traffic
    WHERE CP.Country = Q.Country AND
		CP.Campaign_Start_Month = Q.Prev_Month  AND
		CP.Campaign_name = Q.Campaign_name;    */


    UPDATE Stg_Campaign_Performance CP,
        (SELECT GA.Country,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                GA.Campaign_Upd,
                SUM(Users)       Sum_Traffic,
                SUM(GA.Sessions) Sum_Sessions
         FROM GA_Data GA,
              Stg_Campaign_Performance P
         WHERE GA.Country = P.Country
           AND P.Fiscal_Year > 2018
           and GA.Transaction_Date BETWEEN P.Campaign_Start_Date AND P.Campaign_End_Date
           AND GA.Campaign_Upd = P.Campaign_name
         GROUP BY GA.Country, P.Campaign_Start_Month, P.Campaign_End_Month, GA.Campaign_Upd
         UNION
         SELECT AD.Country,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                AD.Campaign_Upd,
                SUM(Users)       Sum_Traffic,
                SUM(AD.Sessions) Sum_Sessions
         FROM Adobe_Data AD,
              Stg_Campaign_Performance P
         WHERE AD.Country = P.Country
           AND P.Fiscal_Year > 2018
           and AD.Transaction_Date BETWEEN P.Campaign_Start_Date AND P.Campaign_End_Date
           AND AD.Campaign_Upd = P.Campaign_name
         GROUP BY AD.Country, P.Campaign_Start_Month, P.Campaign_End_Month, AD.Campaign_Upd) Q
    SET CP.Website_Traffic = Q.Sum_Traffic,
        CP.Sessions        = Q.Sum_Sessions
    WHERE CP.Campaign_name = Q.Campaign_Upd
      AND CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 190, CURRENT_TIMESTAMP());

    UPDATE Stg_Campaign_Performance CP,
        (SELECT GA.Country,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                GA.Campaign_Upd,
                SUM(Users)       Sum_Traffic,
                SUM(GA.Sessions) Sum_Sessions
         FROM GA_Data GA,
              (SELECT CP1.Country,
                      CP1.Fiscal_Year,
                      CP1.Campaign_Start_Month,
                      CP1.Campaign_End_Month,
                      CP1.Campaign_name,
                      CP2.Campaign_Start_Date,
                      CP2.Campaign_End_Date
               FROM Stg_Campaign_Performance CP1,
                    Stg_Campaign_Performance CP2
               WHERE CP1.Country = CP2.Country
                 AND CP1.Fiscal_Year = CP2.Fiscal_Year + 1
                 AND CP1.Campaign_name = CP2.Campaign_name) P
         WHERE GA.Country = P.Country
           AND P.Fiscal_Year > 2018
           and GA.Transaction_Date BETWEEN P.Campaign_Start_Date AND P.Campaign_End_Date
           AND GA.Campaign_Upd = P.Campaign_name
         GROUP BY GA.Country, P.Campaign_Start_Month, P.Campaign_End_Month, GA.Campaign
         UNION
         SELECT AD.Country,
                P.Campaign_Start_Month,
                P.Campaign_End_Month,
                AD.Campaign_Upd,
                SUM(Users)       Sum_Traffic,
                SUM(AD.Sessions) Sum_Sessions
         FROM Adobe_Data AD,
              (SELECT CP1.Country,
                      CP1.Fiscal_Year,
                      CP1.Campaign_Start_Month,
                      CP1.Campaign_End_Month,
                      CP1.Campaign_name,
                      CP2.Campaign_Start_Date,
                      CP2.Campaign_End_Date
               FROM Stg_Campaign_Performance CP1,
                    Stg_Campaign_Performance CP2
               WHERE CP1.Country = CP2.Country
                 AND CP1.Fiscal_Year = CP2.Fiscal_Year + 1
                 AND CP1.Campaign_name = CP2.Campaign_name) P
         WHERE AD.Country = P.Country
           AND P.Fiscal_Year > 2018
           and AD.Transaction_Date BETWEEN P.Campaign_Start_Date AND P.Campaign_End_Date
           AND AD.Campaign_Upd = P.Campaign_name
         GROUP BY AD.Country, P.Campaign_Start_Month, P.Campaign_End_Month, AD.Campaign_Upd) Q
    SET CP.Prev_Year_Website_Traffic = Q.Sum_Traffic,
        CP.Prev_Year_Sessions        = Q.Sum_Sessions
    WHERE CP.Campaign_name = Q.Campaign_Upd
      AND CP.Country = Q.Country
      AND CP.Campaign_Start_Month = Q.Campaign_Start_Month
      AND CP.Campaign_End_Month = Q.Campaign_End_Month;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 200, CURRENT_TIMESTAMP());

    DELETE
    FROM Stg_Campaign_Performance
    WHERE Campaign_name IN ('Right On (Shaping)', 'Non-Specific Campaigns');

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Fact_Campaign_Performance;
        INSERT INTO Fact_Campaign_Performance
        SELECT *
        FROM Stg_Campaign_Performance;


    ELSEIF i_Call_Type = 'SUBMIT' THEN
        DELETE
        FROM InPro_Fact_Campaign_Performance
        WHERE Country = i_Country
          AND Campaign_Start_Month = i_Year_Month_Num;

        INSERT INTO InPro_Fact_Campaign_Performance
        SELECT *
        FROM Stg_Campaign_Performance
        WHERE Country = i_Country
          AND Campaign_Start_Month = i_Year_Month_Num;


    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Fact_Campaign_Performance
        WHERE Country = i_Country
          AND Campaign_Start_Month = i_Year_Month_Num;

        INSERT INTO Fact_Campaign_Performance
        SELECT *
        FROM Stg_Campaign_Performance
        WHERE Country = i_Country
          AND Campaign_Start_Month = i_Year_Month_Num;


    END IF;
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Campaign_Performance', i_Call_Type, 210, CURRENT_TIMESTAMP());
END;


