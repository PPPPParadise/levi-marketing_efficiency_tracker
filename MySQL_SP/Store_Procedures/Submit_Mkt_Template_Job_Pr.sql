create
    definer = gilbert@`%` procedure Submit_Mkt_Template_Job_Pr(IN i_Job_ID int, IN i_Country varchar(30),
                                                               IN i_Year_Month_Num int, IN i_Template_Type varchar(40),
                                                               IN i_User varchar(30))
BEGIN
    SET SQL_SAFE_UPDATES = 0;


    UPDATE MKT_Template_Spend T,
        (SELECT Exch_Rate_Effect_Date, Country, USD_Planned_Rate
         FROM LEVIS.Dim_Exchange_Rate D1
         WHERE D1.Country = i_Country
           AND D1.Exch_Rate_Effect_Date = (SELECT MAX(D2.Exch_Rate_Effect_Date)
                                           FROM Dim_Exchange_Rate D2
                                           WHERE D2.Country = i_Country)) Q
    SET TV_Spend                     = IFNULL(
            CASE WHEN (Cur_Type = 'LC') THEN TV_Spend_LC * USD_Planned_Rate ELSE TV_Spend_LC END, 0),
        Print_Spend                  = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN Print_Spend_LC * Q.USD_Planned_Rate ELSE Print_Spend_LC END, 0),
        Radio_Spend                  = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN Radio_Spend_LC * Q.USD_Planned_Rate ELSE Radio_Spend_LC END, 0),
        OOH_spend                    = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN OOH_Spend_LC * Q.USD_Planned_Rate ELSE OOH_Spend_LC END, 0),
        Digital_Spend                = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN Digital_Spend_LC * Q.USD_Planned_Rate ELSE Digital_Spend_LC END, 0),
        CRM_Spend                    = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN CRM_Spend_LC * Q.USD_Planned_Rate ELSE CRM_Spend_LC END, 0),
        PR_Spend                     = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN PR_Spend_LC * Q.USD_Planned_Rate ELSE PR_Spend_LC END, 0),
        Cinema_Spend                 = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN Cinema_Spend_LC * Q.USD_Planned_Rate ELSE Cinema_Spend_LC END, 0),
        Others_campaign_Spend        = IFNULL(CASE
                                                  WHEN (Cur_Type = 'LC')
                                                      THEN Others_campaign_Spend_LC * Q.USD_Planned_Rate
                                                  ELSE Others_campaign_Spend_LC END, 0),
        SE_Spend                     = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN SE_Spend_LC * Q.USD_Planned_Rate ELSE SE_Spend_LC END, 0),
        VSS_Spend                    = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN VSS_Spend_LC * Q.USD_Planned_Rate ELSE VSS_Spend_LC END, 0),
        Marketplace_Spend            = IFNULL(CASE
                                                  WHEN (Cur_Type = 'LC') THEN Marketplace_Spend_LC * Q.USD_Planned_Rate
                                                  ELSE Marketplace_Spend_LC END, 0),
        Equivalent_Advertising_Value = IFNULL(CASE
                                                  WHEN (Cur_Type = 'LC')
                                                      THEN Equivalent_Advertising_Value_LC * Q.USD_Planned_Rate
                                                  ELSE Equivalent_Advertising_Value_LC END, 0),
        Actual_Spend                 = IFNULL(
                CASE WHEN (Cur_Type = 'LC') THEN Actual_Spend_LC * Q.USD_Planned_Rate ELSE Actual_Spend_LC END, 0)
    WHERE T.Country = Q.Country
      AND T.Month_Num = i_Year_Month_Num;

    UPDATE MKT_Template_Spend T
    SET Actual_Spend    = TV_Spend + Print_Spend + Radio_Spend + OOH_spend + Digital_Spend
        + CRM_Spend + PR_Spend + Cinema_Spend + Others_campaign_Spend + SE_Spend
        + VSS_Spend + Marketplace_Spend,
        Actual_Spend_LC = TV_Spend_LC + Print_Spend_LC + Radio_Spend_LC + OOH_Spend_LC + Digital_Spend_LC
            + CRM_Spend_LC + PR_Spend_LC + Cinema_Spend_LC + Others_campaign_Spend_LC + SE_Spend_LC
            + VSS_Spend_LC + Marketplace_Spend_LC
    WHERE T.Country = i_Country
      AND T.Month_Num = i_Year_Month_Num;

    UPDATE MKT_Template_Spend MTS
    SET MTS.Campaign_name_Upd    = MTS.Campaign_name,
        MTS.Type_of_Campaign_Upd = MTS.Type_of_Campaign
    WHERE MTS.Country = i_Country
      AND MTS.Month_Num = i_Year_Month_Num
      AND MTS.Template_Name = i_Template_Type;

    UPDATE MKT_Template_Spend MTS , Campaign_Mapping CM
    SET MTS.Campaign_name_Upd    = CM.Campaign_name_Final,
        MTS.Type_of_Campaign_Upd = CM.Type_of_Campaign_New
    WHERE MTS.Campaign_name = CM.Campaign_name_New
      AND MTS.Country = CM.Country
      AND MTS.Country = i_Country
      AND MTS.Month_Num = i_Year_Month_Num
      AND MTS.Template_Name = i_Template_Type;


    UPDATE Map_Medium_Category D INNER JOIN MKT_Template_Spend M
        ON M.Medium = D.Com_Medium
    SET M.Category=D.Category
    WHERE M.Country = i_Country
      AND M.Month_Num = i_Year_Month_Num
      AND M.Template_Name = i_Template_Type;

    CALL Pop_Fact_Campaign(i_Job_ID, i_Country, i_Year_Month_Num, 'SUBMIT');

    CALL Pop_Fact_Sellthru_Traffic(i_Job_ID, i_Country, i_Year_Month_Num, 'SUBMIT');

    CALL Pop_Fact_DB_Campaign_Product(i_Job_ID, i_Country, i_Year_Month_Num, 'SUBMIT');

    CALL Pop_Campaign_Performance(i_Job_ID, i_Country, i_Year_Month_Num, 'SUBMIT');

    /*  UPDATE MKT_Template_Spend 
           SET Process_Flag = 'P',
               Updated_By = i_User,
               Created_By = i_User
           WHERE Country = i_Country AND 
               Month_Num = i_Year_Month_Num AND
               Template_Name = i_Template_Type;
       
       INSERT INTO Mail_Info (Year_Month_Num, Country, Template_Type,
                               Mail_Type, Mail_Status, Created_By,
                               Updated_By)
           VALUES(i_Year_Month_Num, i_Country, i_Template_Type,
                   'MKT_SPEND_UPLOAD', 'N', i_User,
                   i_User); */
    COMMIT;
END;


