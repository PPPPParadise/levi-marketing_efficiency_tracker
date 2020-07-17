create
    definer = gilbert@`%` procedure Pop_Fact_Campaign(IN i_Job_ID int, IN i_Country varchar(30),
                                                      IN i_Year_Month_Num int, IN i_Call_Type varchar(30))
BEGIN

    SET SQL_SAFE_UPDATES = 0;
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Campaign', i_Call_Type, 0, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Stg_Fact_Campaign;

        INSERT INTO Stg_Fact_Campaign
        (Region, Country, Fiscal_Quarter, Fiscal_Year_Num, Curr_Fiscal_Year, Fiscal_Month_Num, Fiscal_Month,
         Campaign_name, Type_of_Campaign,
         Product_Line, Influencer, Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date,
         TV_Spend,
         TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP,
         Print_Campaign_Start_Date,
         Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions,
         Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend,
         Channel_Frequency,
         Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH,
         City_National, Location,
         Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date,
         Digital_Campaign_End_Date, Digital_Spend,
         Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, Total_Reach, Total_Engagement, CRM_Type,
         CRM_Campaign_Start_Date,
         CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent, Responders, CRM_Delivered, CRM_Open, CRM_Click,
         PR_Media, PR_Start_Date, PR_End_Date,
         Date_Month_of_Issue, Media_Title, Headline_Programe,
         PR_Spend, Circulation_Viewership_Hit_impressions, Page_Area_Length, Equivalent_Advertising_Value,
         Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage,
         Cinema_Campaign_Start_Date,
         Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, TPRCO_Impressions,
         Others_Name_of_the_Medium,
         Others_campaign_Start_Date, Others_campaign_End_Date, Others_campaign_Spend, Other_Impressions,
         SE_Communication_Type,
         SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views,
         VSS_Communication_Type,
         VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions,
         VSS_Total_Views, VSS_Total_Clicks,
         Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date,
         Marketplace_Spend, Ad_Impressions,
         Ad_Views, Ad_Clicks, Validation_Flag, Actual_Spend, Category, Fiscal_Biannual)
        SELECT `DC`.`Region`                                                                            AS `Region`,
               `DC`.`Country`                                                                           AS `Country`,
               `DCM`.`Fiscal_Quarter`                                                                   AS `Fiscal_Quarter`,
               `DCM`.`Fiscal_Year`                                                                      AS `Fiscal_Year_Num`,
               CURR_FISCAL_YEAR()                                                                       AS `Curr_Fiscal_Year`,
               `DCM`.`Year_Month_Num`                                                                   AS `Fiscal_Month_Num`,
               `DCM`.`Fiscal_Month`                                                                     AS `Fiscal_Month`,
               `MTS`.`Campaign_name_Upd`                                                                AS `Campaign_name`,
               `MTS`.`Type_of_Campaign_Upd`                                                             AS `Type_of_Campaign`,
               CASE
                   WHEN `MTS`.`Product_Line` IS NULL THEN ''
                   ELSE `MTS`.`Product_Line` END                                                        AS `Product_Line`,
               `MTS`.`Influencer`                                                                       AS `Influencer`,
               CASE
                   WHEN `MTS`.`Name_of_Influencer` IS NULL THEN ''
                   ELSE `MTS`.`Name_of_Influencer` END                                                  AS `Name_of_Influencer`,
               `MTS`.`Medium`                                                                           AS `Medium`,
               `MTS`.`Format`                                                                           AS `Format`,
               `MTS`.`TV_Campaig_Start_Date`                                                            AS `TV_Campaig_Start_Date`,
               `MTS`.`TV_Campaign_End_Date`                                                             AS `TV_Campaign_End_Date`,
               `MTS`.`TV_Spend`                                                                         AS `TV_Spend`,
               `MTS`.`TV_Channel_name`                                                                  AS `TV_Channel_name`,
               `MTS`.`TV_Area_Coverage`                                                                 AS `TV_Area_Coverage`,
               `MTS`.`TV_Area_Name`                                                                     AS `TV_Area_Name`,
               `MTS`.`TV_spot_Duration`                                                                 AS `TV_spot_Duration`,
               `MTS`.`No_of_Spots`                                                                      AS `No_of_Spots`,
               `MTS`.`TV_GRP`                                                                           AS `TV_GRP`,
               `MTS`.`Print_Campaign_Start_Date`                                                        AS `Print_Campaign_Start_Date`,
               `MTS`.`Print_Campaign_End_Date`                                                          AS `Print_Campaign_End_Date`,
               `MTS`.`Print_Spend`                                                                      AS `Print_Spend`,
               `MTS`.`Publication_Type`                                                                 AS `Publication_Type`,
               `MTS`.`Publication_Name`                                                                 AS `Publication_Name`,
               `MTS`.`Page_Number`                                                                      AS `Page_Number`,
               `MTS`.`Size_of_ad_dimensions`                                                            AS `Size_of_ad_dimensions`,
               `MTS`.`Circulation`                                                                      AS `Circulation`,
               `MTS`.`Print_Impressions`                                                                AS `Print_Impressions`,
               `MTS`.`Radio_Campaign_Start_Date`                                                        AS `Radio_Campaign_Start_Date`,
               `MTS`.`Radio_Campaign_End_Date`                                                          AS `Radio_Campaign_End_Date`,
               `MTS`.`Radio_Spend`                                                                      AS `Radio_Spend`,
               `MTS`.`Channel_Frequency`                                                                AS `Channel_Frequency`,
               `MTS`.`Radio_Impressions_or_Reach`                                                       AS `Radio_Impressions_or_Reach`,
               `MTS`.`OOH_Campaign_Start_Date`                                                          AS `OOH_Campaign_Start_Date`,
               `MTS`.`OOH_Campaign_End_Date`                                                            AS `OOH_Campaign_End_Date`,
               `MTS`.`OOH_spend`                                                                        AS `OOH_spend`,
               `MTS`.`Type_of_OOH`                                                                      AS `Type_of_OOH`,
               `MTS`.`City_National`                                                                    AS `City_National`,
               `MTS`.`Location`                                                                         AS `Location`,
               `MTS`.`Size_of_ad`                                                                       AS `Size_of_ad`,
               `MTS`.`Frequency`                                                                        AS `Frequency`,
               `MTS`.`OTS_or_Reach`                                                                     AS `OTS_or_Reach`,
               `MTS`.`Digital_Media_Type`                                                               AS `Digital_Media_Type`,
               `MTS`.`Digital_Campaign_Start_Date`                                                      AS `Digital_Campaign_Start_Date`,
               `MTS`.`Digital_Campaign_End_Date`                                                        AS `Digital_Campaign_End_Date`,
               `MTS`.`Digital_Spend`                                                                    AS `Digital_Spend`,
               `MTS`.`Total_Impressions`                                                                AS `Total_Impressions`,
               `MTS`.`Total_Clicks`                                                                     AS `Total_Clicks`,
               `MTS`.`Total_Views`                                                                      AS `Total_Views`,
               `MTS`.`Avg_Frequency`                                                                    AS `Avg_Frequency`,
               `MTS`.`Total_Reach`                                                                      AS `Total_Reach`,
               `MTS`.`Total_Engagement`                                                                 AS `Total_Engagement`,
               `MTS`.`CRM_Type`                                                                         AS `CRM_Type`,
               `MTS`.`CRM_Campaign_Start_Date`                                                          AS `CRM_Campaign_Start_Date`,
               `MTS`.`CRM_Campaign_End_Date`                                                            AS `CRM_Campaign_End_Date`,
               `MTS`.`CRM_Spend`                                                                        AS `CRM_Spend`,
               CRM_Revenue,
               `MTS`.`Amount_Sent`                                                                      AS `Amount_Sent`,
               `MTS`.`Responders`                                                                       AS `Responders`,
               `MTS`.`CRM_Delivered`                                                                    AS `CRM_Delivered`,
               `MTS`.`CRM_Open`                                                                         AS `CRM_Open`,
               `MTS`.`CRM_Click`                                                                        AS `CRM_Click`,
               `MTS`.`PR_Media`                                                                         AS `PR_Media`,
               PR_Start_Date,
               PR_End_Date,
               `MTS`.`Date_Month_of_Issue`                                                              AS `Date_Month_of_Issue`,
               `MTS`.`Media_Title`                                                                      AS `Media_Title`,
               `MTS`.`Headline_Programe`                                                                AS `Headline_Programe`,
               CASE WHEN PR_Spend IS NULL THEN 0 ELSE PR_Spend END,
               `MTS`.`Circulation_Viewership_Hit_impressions`                                           AS `Circulation_Viewership_Hit_impressions`,
               CASE
                   WHEN `MTS`.`Page_Area_Length` IS NULL THEN ''
                   ELSE `MTS`.`Page_Area_Length` END                                                    AS `Page_Area_Length`,
               `MTS`.`Equivalent_Advertising_Value`                                                     AS `Equivalent_Advertising_Value`,
               `MTS`.`Mentioning_Levis_Headline_content`                                                AS `Mentioning_Levis_Headline_content`,
               `MTS`.`Nature_of_Coverage`                                                               AS `Nature_of_Coverage`,
               `MTS`.`Type_of_Coverage`                                                                 AS `Type_of_Coverage`,
               `MTS`.`Tonality`                                                                         AS `Tonality`,
               `MTS`.`Topics_of_Coverage`                                                               AS `Topics_of_Coverage`,
               `MTS`.`Cinema_Campaign_Start_Date`                                                       AS `Cinema_Campaign_Start_Date`,
               `MTS`.`Cinema_Campaign_End_Date`                                                         AS `Cinema_Campaign_End_Date`,
               CASE WHEN Cinema_Spend IS NULL THEN 0 ELSE Cinema_Spend END,
               `MTS`.`Cinema_spot_Duration`                                                             AS `Cinema_spot_Duration`,
               CASE WHEN `Cinema_Impressions` IS NULL THEN 0 ELSE `Cinema_Impressions` END,
               `MTS`.`Print_Impressions` + `MTS`.`Radio_Impressions_or_Reach` + `MTS`.`Cinema_Impressions` +
               `MTS`.`OTS_or_Reach` +
               `MTS`.`Other_Impressions`                                                                AS `TPRCO_Impressions`,
               `MTS`.`Others_Name_of_the_Medium`                                                        AS `Others_Name_of_the_Medium`,
               `MTS`.`Others_campaign_Start_Date`                                                       AS `Others_campaign_Start_Date`,
               `MTS`.`Others_campaign_End_Date`                                                         AS `Others_campaign_End_Date`,
               CASE WHEN Others_campaign_Spend IS NULL THEN 0 ELSE Others_campaign_Spend END,
               CASE
                   WHEN `MTS`.`Other_Impressions` IS NULL THEN 0
                   ELSE `Other_Impressions` END                                                         AS `Other_Impressions`,
               `MTS`.`SE_Communication_Type`                                                            AS `SE_Communication_Type`,
               `MTS`.`SE_Campaign_Start_Date`                                                           AS `SE_Campaign_Start_Date`,
               `MTS`.`SE_Campaign_End_Date`                                                             AS `SE_Campaign_End_Date`,
               CASE WHEN SE_Spend IS NULL THEN 0 ELSE SE_Spend END,
               `MTS`.`SE_Impressions`                                                                   AS `SE_Impressions`,
               `MTS`.`SE_Total_Clicks`                                                                  AS `SE_Total_Clicks`,
               `MTS`.`SE_Total_Views`                                                                   AS `SE_Total_Views`,
               `MTS`.`VSS_Communication_Type`                                                           AS `VSS_Communication_Type`,
               `MTS`.`VSS_Campaign_Start_Date`                                                          AS `VSS_Campaign_Start_Date`,
               `MTS`.`VSS_Campaign_End_Date`                                                            AS `VSS_Campaign_End_Date`,
               CASE WHEN VSS_Spend IS NULL THEN 0 ELSE VSS_Spend END,
               `MTS`.`VSS_Impressions_Reach`                                                            AS `VSS_Impressions_Reach`,
               `MTS`.`VSS_Impressions`                                                                  AS `VSS_Impressions`,
               `MTS`.`VSS_Total_Views`                                                                  AS `VSS_Total_Views`,
               `MTS`.`VSS_Total_Clicks`                                                                 AS `VSS_Total_Clicks`,
               `MTS`.`Marketplace_Communication_Type`                                                   AS `Marketplace_Communication_Type`,
               `MTS`.`Marketplace_Campaign_Start_Date`                                                  AS `Marketplace_Campaign_Start_Date`,
               `MTS`.`Marketplace_Campaign_End_Date`                                                    AS `Marketplace_Campaign_End_Date`,
               CASE WHEN Marketplace_Spend IS NULL THEN 0 ELSE Marketplace_Spend END,
               `MTS`.`Ad_Impressions`                                                                   AS `Ad_Impressions`,
               `MTS`.`Ad_Views`                                                                         AS `Ad_Views`,
               `MTS`.`Ad_Clicks`                                                                        AS `Ad_Clicks`,
               `MTS`.`Validation_Flag`                                                                  AS `Validation_Flag`,
               `Actual_Spend`,
               `MTS`.`Category`                                                                         AS `Category`,
               CASE
                   WHEN `DCM`.`Fiscal_Quarter` IN ('Q1', 'Q2') THEN 'H1'
                   ELSE 'H2'
                   END                                                                                  AS `Fiscal_Biannual`
        FROM `Dim_Calendar_Month` `DCM`,
             `Dim_Country` `DC`,
             `MKT_Template_Spend` `MTS`
        WHERE `DCM`.`Year_Month_Num` = `MTS`.`Month_Num`
          AND `DC`.`Country` = `MTS`.`Country`
          AND MTS.Process_Flag = 'Y'
          AND `DCM`.`Year_Month_Num` < DATE_FORMAT(CURRENT_TIMESTAMP(), '%Y%m');

    ELSEIF i_Call_Type = 'SUBMIT' THEN

        TRUNCATE TABLE Stg_Fact_Campaign;

        INSERT INTO Stg_Fact_Campaign
        (Region, Country, Fiscal_Quarter, Fiscal_Year_Num, Curr_Fiscal_Year, Fiscal_Month_Num, Fiscal_Month,
         Campaign_name, Type_of_Campaign,
         Product_Line, Influencer, Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date,
         TV_Spend,
         TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP,
         Print_Campaign_Start_Date,
         Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions,
         Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend,
         Channel_Frequency,
         Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH,
         City_National, Location,
         Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date,
         Digital_Campaign_End_Date, Digital_Spend,
         Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, Total_Reach, Total_Engagement, CRM_Type,
         CRM_Campaign_Start_Date,
         CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent, Responders, CRM_Delivered, CRM_Open, CRM_Click,
         PR_Media, PR_Start_Date, PR_End_Date,
         Date_Month_of_Issue, Media_Title, Headline_Programe,
         PR_Spend, Circulation_Viewership_Hit_impressions, Page_Area_Length, Equivalent_Advertising_Value,
         Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage,
         Cinema_Campaign_Start_Date,
         Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, TPRCO_Impressions,
         Others_Name_of_the_Medium,
         Others_campaign_Start_Date, Others_campaign_End_Date, Others_campaign_Spend, Other_Impressions,
         SE_Communication_Type,
         SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views,
         VSS_Communication_Type,
         VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions,
         VSS_Total_Views, VSS_Total_Clicks,
         Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date,
         Marketplace_Spend, Ad_Impressions,
         Ad_Views, Ad_Clicks, Validation_Flag, Actual_Spend, Category, Fiscal_Biannual)
        SELECT `DC`.`Region`                                                                            AS `Region`,
               `DC`.`Country`                                                                           AS `Country`,
               `DCM`.`Fiscal_Quarter`                                                                   AS `Fiscal_Quarter`,
               `DCM`.`Fiscal_Year`                                                                      AS `Fiscal_Year_Num`,
               CURR_FISCAL_YEAR()                                                                       AS `Curr_Fiscal_Year`,
               `DCM`.`Year_Month_Num`                                                                   AS `Fiscal_Month_Num`,
               `DCM`.`Fiscal_Month`                                                                     AS `Fiscal_Month`,
               `MTS`.`Campaign_name_Upd`                                                                AS `Campaign_name`,
               `MTS`.`Type_of_Campaign_Upd`                                                             AS `Type_of_Campaign`,
               CASE
                   WHEN `MTS`.`Product_Line` IS NULL THEN ''
                   ELSE `MTS`.`Product_Line` END                                                        AS `Product_Line`,
               `MTS`.`Influencer`                                                                       AS `Influencer`,
               CASE
                   WHEN `MTS`.`Name_of_Influencer` IS NULL THEN ''
                   ELSE `MTS`.`Name_of_Influencer` END                                                  AS `Name_of_Influencer`,
               `MTS`.`Medium`                                                                           AS `Medium`,
               `MTS`.`Format`                                                                           AS `Format`,
               `MTS`.`TV_Campaig_Start_Date`                                                            AS `TV_Campaig_Start_Date`,
               `MTS`.`TV_Campaign_End_Date`                                                             AS `TV_Campaign_End_Date`,
               `MTS`.`TV_Spend`                                                                         AS `TV_Spend`,
               `MTS`.`TV_Channel_name`                                                                  AS `TV_Channel_name`,
               `MTS`.`TV_Area_Coverage`                                                                 AS `TV_Area_Coverage`,
               `MTS`.`TV_Area_Name`                                                                     AS `TV_Area_Name`,
               `MTS`.`TV_spot_Duration`                                                                 AS `TV_spot_Duration`,
               `MTS`.`No_of_Spots`                                                                      AS `No_of_Spots`,
               `MTS`.`TV_GRP`                                                                           AS `TV_GRP`,
               `MTS`.`Print_Campaign_Start_Date`                                                        AS `Print_Campaign_Start_Date`,
               `MTS`.`Print_Campaign_End_Date`                                                          AS `Print_Campaign_End_Date`,
               `MTS`.`Print_Spend`                                                                      AS `Print_Spend`,
               `MTS`.`Publication_Type`                                                                 AS `Publication_Type`,
               `MTS`.`Publication_Name`                                                                 AS `Publication_Name`,
               `MTS`.`Page_Number`                                                                      AS `Page_Number`,
               `MTS`.`Size_of_ad_dimensions`                                                            AS `Size_of_ad_dimensions`,
               `MTS`.`Circulation`                                                                      AS `Circulation`,
               `MTS`.`Print_Impressions`                                                                AS `Print_Impressions`,
               `MTS`.`Radio_Campaign_Start_Date`                                                        AS `Radio_Campaign_Start_Date`,
               `MTS`.`Radio_Campaign_End_Date`                                                          AS `Radio_Campaign_End_Date`,
               `MTS`.`Radio_Spend`                                                                      AS `Radio_Spend`,
               `MTS`.`Channel_Frequency`                                                                AS `Channel_Frequency`,
               `MTS`.`Radio_Impressions_or_Reach`                                                       AS `Radio_Impressions_or_Reach`,
               `MTS`.`OOH_Campaign_Start_Date`                                                          AS `OOH_Campaign_Start_Date`,
               `MTS`.`OOH_Campaign_End_Date`                                                            AS `OOH_Campaign_End_Date`,
               `MTS`.`OOH_spend`                                                                        AS `OOH_spend`,
               `MTS`.`Type_of_OOH`                                                                      AS `Type_of_OOH`,
               `MTS`.`City_National`                                                                    AS `City_National`,
               `MTS`.`Location`                                                                         AS `Location`,
               `MTS`.`Size_of_ad`                                                                       AS `Size_of_ad`,
               `MTS`.`Frequency`                                                                        AS `Frequency`,
               `MTS`.`OTS_or_Reach`                                                                     AS `OTS_or_Reach`,
               `MTS`.`Digital_Media_Type`                                                               AS `Digital_Media_Type`,
               `MTS`.`Digital_Campaign_Start_Date`                                                      AS `Digital_Campaign_Start_Date`,
               `MTS`.`Digital_Campaign_End_Date`                                                        AS `Digital_Campaign_End_Date`,
               `MTS`.`Digital_Spend`                                                                    AS `Digital_Spend`,
               `MTS`.`Total_Impressions`                                                                AS `Total_Impressions`,
               `MTS`.`Total_Clicks`                                                                     AS `Total_Clicks`,
               `MTS`.`Total_Views`                                                                      AS `Total_Views`,
               `MTS`.`Avg_Frequency`                                                                    AS `Avg_Frequency`,
               `MTS`.`Total_Reach`                                                                      AS `Total_Reach`,
               `MTS`.`Total_Engagement`                                                                 AS `Total_Engagement`,
               `MTS`.`CRM_Type`                                                                         AS `CRM_Type`,
               `MTS`.`CRM_Campaign_Start_Date`                                                          AS `CRM_Campaign_Start_Date`,
               `MTS`.`CRM_Campaign_End_Date`                                                            AS `CRM_Campaign_End_Date`,
               `MTS`.`CRM_Spend`                                                                        AS `CRM_Spend`,
               CRM_Revenue,
               `MTS`.`Amount_Sent`                                                                      AS `Amount_Sent`,
               `MTS`.`Responders`                                                                       AS `Responders`,
               `MTS`.`CRM_Delivered`                                                                    AS `CRM_Delivered`,
               `MTS`.`CRM_Open`                                                                         AS `CRM_Open`,
               `MTS`.`CRM_Click`                                                                        AS `CRM_Click`,
               `MTS`.`PR_Media`                                                                         AS `PR_Media`,
               PR_Start_Date,
               PR_End_Date,
               `MTS`.`Date_Month_of_Issue`                                                              AS `Date_Month_of_Issue`,
               `MTS`.`Media_Title`                                                                      AS `Media_Title`,
               `MTS`.`Headline_Programe`                                                                AS `Headline_Programe`,
               CASE WHEN PR_Spend IS NULL THEN 0 ELSE PR_Spend END,
               `MTS`.`Circulation_Viewership_Hit_impressions`                                           AS `Circulation_Viewership_Hit_impressions`,
               CASE
                   WHEN `MTS`.`Page_Area_Length` IS NULL THEN ''
                   ELSE `MTS`.`Page_Area_Length` END                                                    AS `Page_Area_Length`,
               `MTS`.`Equivalent_Advertising_Value`                                                     AS `Equivalent_Advertising_Value`,
               `MTS`.`Mentioning_Levis_Headline_content`                                                AS `Mentioning_Levis_Headline_content`,
               `MTS`.`Nature_of_Coverage`                                                               AS `Nature_of_Coverage`,
               `MTS`.`Type_of_Coverage`                                                                 AS `Type_of_Coverage`,
               `MTS`.`Tonality`                                                                         AS `Tonality`,
               `MTS`.`Topics_of_Coverage`                                                               AS `Topics_of_Coverage`,
               `MTS`.`Cinema_Campaign_Start_Date`                                                       AS `Cinema_Campaign_Start_Date`,
               `MTS`.`Cinema_Campaign_End_Date`                                                         AS `Cinema_Campaign_End_Date`,
               CASE WHEN Cinema_Spend IS NULL THEN 0 ELSE Cinema_Spend END,
               `MTS`.`Cinema_spot_Duration`                                                             AS `Cinema_spot_Duration`,
               CASE WHEN `Cinema_Impressions` IS NULL THEN 0 ELSE `Cinema_Impressions` END,
               `MTS`.`Print_Impressions` + `MTS`.`Radio_Impressions_or_Reach` + `MTS`.`Cinema_Impressions` +
               `MTS`.`OTS_or_Reach` +
               `MTS`.`Other_Impressions`                                                                AS `TPRCO_Impressions`,
               `MTS`.`Others_Name_of_the_Medium`                                                        AS `Others_Name_of_the_Medium`,
               `MTS`.`Others_campaign_Start_Date`                                                       AS `Others_campaign_Start_Date`,
               `MTS`.`Others_campaign_End_Date`                                                         AS `Others_campaign_End_Date`,
               CASE WHEN Others_campaign_Spend IS NULL THEN 0 ELSE Others_campaign_Spend END,
               CASE
                   WHEN `MTS`.`Other_Impressions` IS NULL THEN 0
                   ELSE `Other_Impressions` END                                                         AS `Other_Impressions`,
               `MTS`.`SE_Communication_Type`                                                            AS `SE_Communication_Type`,
               `MTS`.`SE_Campaign_Start_Date`                                                           AS `SE_Campaign_Start_Date`,
               `MTS`.`SE_Campaign_End_Date`                                                             AS `SE_Campaign_End_Date`,
               CASE WHEN SE_Spend IS NULL THEN 0 ELSE SE_Spend END,
               `MTS`.`SE_Impressions`                                                                   AS `SE_Impressions`,
               `MTS`.`SE_Total_Clicks`                                                                  AS `SE_Total_Clicks`,
               `MTS`.`SE_Total_Views`                                                                   AS `SE_Total_Views`,
               `MTS`.`VSS_Communication_Type`                                                           AS `VSS_Communication_Type`,
               `MTS`.`VSS_Campaign_Start_Date`                                                          AS `VSS_Campaign_Start_Date`,
               `MTS`.`VSS_Campaign_End_Date`                                                            AS `VSS_Campaign_End_Date`,
               CASE WHEN VSS_Spend IS NULL THEN 0 ELSE VSS_Spend END,
               `MTS`.`VSS_Impressions_Reach`                                                            AS `VSS_Impressions_Reach`,
               `MTS`.`VSS_Impressions`                                                                  AS `VSS_Impressions`,
               `MTS`.`VSS_Total_Views`                                                                  AS `VSS_Total_Views`,
               `MTS`.`VSS_Total_Clicks`                                                                 AS `VSS_Total_Clicks`,
               `MTS`.`Marketplace_Communication_Type`                                                   AS `Marketplace_Communication_Type`,
               `MTS`.`Marketplace_Campaign_Start_Date`                                                  AS `Marketplace_Campaign_Start_Date`,
               `MTS`.`Marketplace_Campaign_End_Date`                                                    AS `Marketplace_Campaign_End_Date`,
               CASE WHEN Marketplace_Spend IS NULL THEN 0 ELSE Marketplace_Spend END,
               `MTS`.`Ad_Impressions`                                                                   AS `Ad_Impressions`,
               `MTS`.`Ad_Views`                                                                         AS `Ad_Views`,
               `MTS`.`Ad_Clicks`                                                                        AS `Ad_Clicks`,
               `MTS`.`Validation_Flag`                                                                  AS `Validation_Flag`,
               `Actual_Spend`,
               `MTS`.`Category`                                                                         AS `Category`,
               CASE
                   WHEN `DCM`.`Fiscal_Quarter` IN ('Q1', 'Q2') THEN 'H1'
                   ELSE 'H2'
                   END                                                                                  AS `Fiscal_Biannual`
        FROM `Dim_Calendar_Month` `DCM`,
             `Dim_Country` `DC`,
             `MKT_Template_Spend` `MTS`
        WHERE `DCM`.`Year_Month_Num` = `MTS`.`Month_Num`
          AND `DC`.`Country` = `MTS`.`Country`
          AND `DCM`.`Year_Month_Num` = i_Year_Month_Num
          AND `MTS`.`Country` = i_Country;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Stg_Fact_Campaign
        WHERE Country = i_Country
          AND Fiscal_Month_Num = i_Year_Month_Num;

        INSERT INTO Stg_Fact_Campaign
        (Region, Country, Fiscal_Quarter, Fiscal_Year_Num, Curr_Fiscal_Year, Fiscal_Month_Num, Fiscal_Month,
         Campaign_name, Type_of_Campaign,
         Product_Line, Influencer, Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date,
         TV_Spend,
         TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP,
         Print_Campaign_Start_Date,
         Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions,
         Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend,
         Channel_Frequency,
         Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH,
         City_National, Location,
         Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date,
         Digital_Campaign_End_Date, Digital_Spend,
         Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, Total_Reach, Total_Engagement, CRM_Type,
         CRM_Campaign_Start_Date,
         CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent, Responders, CRM_Delivered, CRM_Open, CRM_Click,
         PR_Media, PR_Start_Date, PR_End_Date,
         Date_Month_of_Issue, Media_Title, Headline_Programe,
         PR_Spend, Circulation_Viewership_Hit_impressions, Page_Area_Length, Equivalent_Advertising_Value,
         Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage,
         Cinema_Campaign_Start_Date,
         Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, TPRCO_Impressions,
         Others_Name_of_the_Medium,
         Others_campaign_Start_Date, Others_campaign_End_Date, Others_campaign_Spend, Other_Impressions,
         SE_Communication_Type,
         SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views,
         VSS_Communication_Type,
         VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions,
         VSS_Total_Views, VSS_Total_Clicks,
         Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date,
         Marketplace_Spend, Ad_Impressions,
         Ad_Views, Ad_Clicks, Validation_Flag, Actual_Spend, Category, Fiscal_Biannual)
        SELECT `DC`.`Region`                                                                            AS `Region`,
               `DC`.`Country`                                                                           AS `Country`,
               `DCM`.`Fiscal_Quarter`                                                                   AS `Fiscal_Quarter`,
               `DCM`.`Fiscal_Year`                                                                      AS `Fiscal_Year_Num`,
               CURR_FISCAL_YEAR()                                                                       AS `Curr_Fiscal_Year`,
               `DCM`.`Year_Month_Num`                                                                   AS `Fiscal_Month_Num`,
               `DCM`.`Fiscal_Month`                                                                     AS `Fiscal_Month`,
               `MTS`.`Campaign_name_Upd`                                                                AS `Campaign_name`,
               `MTS`.`Type_of_Campaign_Upd`                                                             AS `Type_of_Campaign`,
               CASE
                   WHEN `MTS`.`Product_Line` IS NULL THEN ''
                   ELSE `MTS`.`Product_Line` END                                                        AS `Product_Line`,
               `MTS`.`Influencer`                                                                       AS `Influencer`,
               CASE
                   WHEN `MTS`.`Name_of_Influencer` IS NULL THEN ''
                   ELSE `MTS`.`Name_of_Influencer` END                                                  AS `Name_of_Influencer`,
               `MTS`.`Medium`                                                                           AS `Medium`,
               `MTS`.`Format`                                                                           AS `Format`,
               `MTS`.`TV_Campaig_Start_Date`                                                            AS `TV_Campaig_Start_Date`,
               `MTS`.`TV_Campaign_End_Date`                                                             AS `TV_Campaign_End_Date`,
               `MTS`.`TV_Spend`                                                                         AS `TV_Spend`,
               `MTS`.`TV_Channel_name`                                                                  AS `TV_Channel_name`,
               `MTS`.`TV_Area_Coverage`                                                                 AS `TV_Area_Coverage`,
               `MTS`.`TV_Area_Name`                                                                     AS `TV_Area_Name`,
               `MTS`.`TV_spot_Duration`                                                                 AS `TV_spot_Duration`,
               `MTS`.`No_of_Spots`                                                                      AS `No_of_Spots`,
               `MTS`.`TV_GRP`                                                                           AS `TV_GRP`,
               `MTS`.`Print_Campaign_Start_Date`                                                        AS `Print_Campaign_Start_Date`,
               `MTS`.`Print_Campaign_End_Date`                                                          AS `Print_Campaign_End_Date`,
               `MTS`.`Print_Spend`                                                                      AS `Print_Spend`,
               `MTS`.`Publication_Type`                                                                 AS `Publication_Type`,
               `MTS`.`Publication_Name`                                                                 AS `Publication_Name`,
               `MTS`.`Page_Number`                                                                      AS `Page_Number`,
               `MTS`.`Size_of_ad_dimensions`                                                            AS `Size_of_ad_dimensions`,
               `MTS`.`Circulation`                                                                      AS `Circulation`,
               `MTS`.`Print_Impressions`                                                                AS `Print_Impressions`,
               `MTS`.`Radio_Campaign_Start_Date`                                                        AS `Radio_Campaign_Start_Date`,
               `MTS`.`Radio_Campaign_End_Date`                                                          AS `Radio_Campaign_End_Date`,
               `MTS`.`Radio_Spend`                                                                      AS `Radio_Spend`,
               `MTS`.`Channel_Frequency`                                                                AS `Channel_Frequency`,
               `MTS`.`Radio_Impressions_or_Reach`                                                       AS `Radio_Impressions_or_Reach`,
               `MTS`.`OOH_Campaign_Start_Date`                                                          AS `OOH_Campaign_Start_Date`,
               `MTS`.`OOH_Campaign_End_Date`                                                            AS `OOH_Campaign_End_Date`,
               `MTS`.`OOH_spend`                                                                        AS `OOH_spend`,
               `MTS`.`Type_of_OOH`                                                                      AS `Type_of_OOH`,
               `MTS`.`City_National`                                                                    AS `City_National`,
               `MTS`.`Location`                                                                         AS `Location`,
               `MTS`.`Size_of_ad`                                                                       AS `Size_of_ad`,
               `MTS`.`Frequency`                                                                        AS `Frequency`,
               `MTS`.`OTS_or_Reach`                                                                     AS `OTS_or_Reach`,
               `MTS`.`Digital_Media_Type`                                                               AS `Digital_Media_Type`,
               `MTS`.`Digital_Campaign_Start_Date`                                                      AS `Digital_Campaign_Start_Date`,
               `MTS`.`Digital_Campaign_End_Date`                                                        AS `Digital_Campaign_End_Date`,
               `MTS`.`Digital_Spend`                                                                    AS `Digital_Spend`,
               `MTS`.`Total_Impressions`                                                                AS `Total_Impressions`,
               `MTS`.`Total_Clicks`                                                                     AS `Total_Clicks`,
               `MTS`.`Total_Views`                                                                      AS `Total_Views`,
               `MTS`.`Avg_Frequency`                                                                    AS `Avg_Frequency`,
               `MTS`.`Total_Reach`                                                                      AS `Total_Reach`,
               `MTS`.`Total_Engagement`                                                                 AS `Total_Engagement`,
               `MTS`.`CRM_Type`                                                                         AS `CRM_Type`,
               `MTS`.`CRM_Campaign_Start_Date`                                                          AS `CRM_Campaign_Start_Date`,
               `MTS`.`CRM_Campaign_End_Date`                                                            AS `CRM_Campaign_End_Date`,
               `MTS`.`CRM_Spend`                                                                        AS `CRM_Spend`,
               CRM_Revenue,
               `MTS`.`Amount_Sent`                                                                      AS `Amount_Sent`,
               `MTS`.`Responders`                                                                       AS `Responders`,
               `MTS`.`CRM_Delivered`                                                                    AS `CRM_Delivered`,
               `MTS`.`CRM_Open`                                                                         AS `CRM_Open`,
               `MTS`.`CRM_Click`                                                                        AS `CRM_Click`,
               `MTS`.`PR_Media`                                                                         AS `PR_Media`,
               PR_Start_Date,
               PR_End_Date,
               `MTS`.`Date_Month_of_Issue`                                                              AS `Date_Month_of_Issue`,
               `MTS`.`Media_Title`                                                                      AS `Media_Title`,
               `MTS`.`Headline_Programe`                                                                AS `Headline_Programe`,
               CASE WHEN PR_Spend IS NULL THEN 0 ELSE PR_Spend END,
               `MTS`.`Circulation_Viewership_Hit_impressions`                                           AS `Circulation_Viewership_Hit_impressions`,
               CASE
                   WHEN `MTS`.`Page_Area_Length` IS NULL THEN ''
                   ELSE `MTS`.`Page_Area_Length` END                                                    AS `Page_Area_Length`,
               `MTS`.`Equivalent_Advertising_Value`                                                     AS `Equivalent_Advertising_Value`,
               `MTS`.`Mentioning_Levis_Headline_content`                                                AS `Mentioning_Levis_Headline_content`,
               `MTS`.`Nature_of_Coverage`                                                               AS `Nature_of_Coverage`,
               `MTS`.`Type_of_Coverage`                                                                 AS `Type_of_Coverage`,
               `MTS`.`Tonality`                                                                         AS `Tonality`,
               `MTS`.`Topics_of_Coverage`                                                               AS `Topics_of_Coverage`,
               `MTS`.`Cinema_Campaign_Start_Date`                                                       AS `Cinema_Campaign_Start_Date`,
               `MTS`.`Cinema_Campaign_End_Date`                                                         AS `Cinema_Campaign_End_Date`,
               CASE WHEN Cinema_Spend IS NULL THEN 0 ELSE Cinema_Spend END,
               `MTS`.`Cinema_spot_Duration`                                                             AS `Cinema_spot_Duration`,
               CASE WHEN `Cinema_Impressions` IS NULL THEN 0 ELSE `Cinema_Impressions` END,
               `MTS`.`Print_Impressions` + `MTS`.`Radio_Impressions_or_Reach` + `MTS`.`Cinema_Impressions` +
               `MTS`.`OTS_or_Reach` +
               `MTS`.`Other_Impressions`                                                                AS `TPRCO_Impressions`,
               `MTS`.`Others_Name_of_the_Medium`                                                        AS `Others_Name_of_the_Medium`,
               `MTS`.`Others_campaign_Start_Date`                                                       AS `Others_campaign_Start_Date`,
               `MTS`.`Others_campaign_End_Date`                                                         AS `Others_campaign_End_Date`,
               CASE WHEN Others_campaign_Spend IS NULL THEN 0 ELSE Others_campaign_Spend END,
               CASE
                   WHEN `MTS`.`Other_Impressions` IS NULL THEN 0
                   ELSE `Other_Impressions` END                                                         AS `Other_Impressions`,
               `MTS`.`SE_Communication_Type`                                                            AS `SE_Communication_Type`,
               `MTS`.`SE_Campaign_Start_Date`                                                           AS `SE_Campaign_Start_Date`,
               `MTS`.`SE_Campaign_End_Date`                                                             AS `SE_Campaign_End_Date`,
               CASE WHEN SE_Spend IS NULL THEN 0 ELSE SE_Spend END,
               `MTS`.`SE_Impressions`                                                                   AS `SE_Impressions`,
               `MTS`.`SE_Total_Clicks`                                                                  AS `SE_Total_Clicks`,
               `MTS`.`SE_Total_Views`                                                                   AS `SE_Total_Views`,
               `MTS`.`VSS_Communication_Type`                                                           AS `VSS_Communication_Type`,
               `MTS`.`VSS_Campaign_Start_Date`                                                          AS `VSS_Campaign_Start_Date`,
               `MTS`.`VSS_Campaign_End_Date`                                                            AS `VSS_Campaign_End_Date`,
               CASE WHEN VSS_Spend IS NULL THEN 0 ELSE VSS_Spend END,
               `MTS`.`VSS_Impressions_Reach`                                                            AS `VSS_Impressions_Reach`,
               `MTS`.`VSS_Impressions`                                                                  AS `VSS_Impressions`,
               `MTS`.`VSS_Total_Views`                                                                  AS `VSS_Total_Views`,
               `MTS`.`VSS_Total_Clicks`                                                                 AS `VSS_Total_Clicks`,
               `MTS`.`Marketplace_Communication_Type`                                                   AS `Marketplace_Communication_Type`,
               `MTS`.`Marketplace_Campaign_Start_Date`                                                  AS `Marketplace_Campaign_Start_Date`,
               `MTS`.`Marketplace_Campaign_End_Date`                                                    AS `Marketplace_Campaign_End_Date`,
               CASE WHEN Marketplace_Spend IS NULL THEN 0 ELSE Marketplace_Spend END,
               `MTS`.`Ad_Impressions`                                                                   AS `Ad_Impressions`,
               `MTS`.`Ad_Views`                                                                         AS `Ad_Views`,
               `MTS`.`Ad_Clicks`                                                                        AS `Ad_Clicks`,
               `MTS`.`Validation_Flag`                                                                  AS `Validation_Flag`,
               `Actual_Spend`,
               `MTS`.`Category`                                                                         AS `Category`,
               CASE
                   WHEN `DCM`.`Fiscal_Quarter` IN ('Q1', 'Q2') THEN 'H1'
                   ELSE 'H2'
                   END                                                                                  AS `Fiscal_Biannual`
        FROM `Dim_Calendar_Month` `DCM`,
             `Dim_Country` `DC`,
             `MKT_Template_Spend` `MTS`
        WHERE `DCM`.`Year_Month_Num` = `MTS`.`Month_Num`
          AND `DC`.`Country` = `MTS`.`Country`
          AND MTS.Process_Flag = 'Y'
          AND `DCM`.`Year_Month_Num` = i_Year_Month_Num
          AND `MTS`.`Country` = i_Country;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Campaign', i_Call_Type, 10, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_Campaign SET Fiscal_Date = CONCAT(SUBSTRING(STR_TO_DATE(Fiscal_Month_Num, '%Y%m'), 1, 7), '-01');

    IF i_Call_Type = 'SUBMIT' THEN /* Irrespective of approved or not  */
        UPDATE Stg_Fact_Campaign SFC,
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
        SET SFC.Campaign_Start_Date = Q.Campaign_Start_Date,
            SFC.Campaign_End_Date   = Q.Campaign_End_Date
        WHERE SFC.Country = Q.Country
          AND SFC.Campaign_name = Q.Campaign_Name_Upd
          AND SFC.Fiscal_Year_Num = Q.Fiscal_Year;

    ELSE
        UPDATE Stg_Fact_Campaign SFC,
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
        SET SFC.Campaign_Start_Date = Q.Campaign_Start_Date,
            SFC.Campaign_End_Date   = Q.Campaign_End_Date
        WHERE SFC.Country = Q.Country
          AND SFC.Campaign_name = Q.Campaign_Name_Upd
          AND SFC.Fiscal_Year_Num = Q.Fiscal_Year;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (1, 'Pop_Fact_Campaign', i_Call_Type, 20, CURRENT_TIMESTAMP());


    IF i_Country IS NULL AND i_Year_Month_Num = 0 THEN

        TRUNCATE TABLE Fact_DB_Campaign;
        INSERT INTO Fact_DB_Campaign
        SELECT *
        FROM Stg_Fact_Campaign;


    ELSEIF i_Call_Type = 'SUBMIT' THEN
        DELETE
        FROM InPro_Fact_DB_Campaign
        WHERE Country = i_Country
          AND Fiscal_Month_Num = i_Year_Month_Num;

        INSERT INTO InPro_Fact_DB_Campaign
        SELECT *
        FROM Stg_Fact_Campaign
        WHERE Country = i_Country
          AND Fiscal_Month_Num = i_Year_Month_Num;


    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Fact_DB_Campaign
        WHERE Country = i_Country
          AND Fiscal_Month_Num = i_Year_Month_Num;

        INSERT INTO Fact_DB_Campaign
        SELECT *
        FROM Stg_Fact_Campaign
        WHERE Country = i_Country
          AND Fiscal_Month_Num = i_Year_Month_Num;

    END IF;
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Campaign', i_Call_Type, 30, CURRENT_TIMESTAMP());
    /* TRUNCATE TABLE Fact_DB_Campaign;
INSERT INTO Fact_DB_Campaign SELECT * FROM Stg_Fact_Campaign; */

END;


