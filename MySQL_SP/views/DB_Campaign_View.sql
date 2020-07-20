create definer = gilbert@`%` view DB_Campaign_View as
select `FDC`.`Region`                                                            AS `Region`,
       `FDC`.`Country`                                                           AS `Country`,
       `FDC`.`Fiscal_Quarter`                                                    AS `Fiscal_Quarter`,
       `FDC`.`Fiscal_Year_Num`                                                   AS `Fiscal_Year_Num`,
       concat(`FDC`.`Fiscal_Month`, '-', substr(`FDC`.`Fiscal_Month_Num`, 3, 2)) AS `Year_Month_Char`,
       `FDC`.`Fiscal_Biannual`                                                   AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                      AS `Curr_Fiscal_Year`,
       `FDC`.`Fiscal_Month_Num`                                                  AS `Fiscal_Month_Num`,
       `FDC`.`Fiscal_Month`                                                      AS `Fiscal_Month`,
       `FDC`.`Fiscal_Date`                                                       AS `Fiscal_Date`,
       `FDC`.`Budget_Amount`                                                     AS `Budget_Amount`,
       `FDC`.`Campaign_name`                                                     AS `Campaign_name`,
       `FDC`.`Campaign_Start_Date`                                               AS `Campaign_Start_Date`,
       `FDC`.`Campaign_End_Date`                                                 AS `Campaign_End_Date`,
       `FDC`.`Type_of_Campaign`                                                  AS `Type_of_Campaign`,
       `FDC`.`Product_Line`                                                      AS `Product_Line`,
       `FDC`.`Influencer`                                                        AS `Influencer`,
       `FDC`.`Name_of_Influencer`                                                AS `Name_of_Influencer`,
       `FDC`.`Medium`                                                            AS `Medium`,
       `FDC`.`Format`                                                            AS `Format`,
       `FDC`.`TV_Campaig_Start_Date`                                             AS `TV_Campaig_Start_Date`,
       `FDC`.`TV_Campaign_End_Date`                                              AS `TV_Campaign_End_Date`,
       `FDC`.`TV_Spend`                                                          AS `TV_Spend`,
       `FDC`.`TV_Channel_name`                                                   AS `TV_Channel_name`,
       `FDC`.`TV_Area_Coverage`                                                  AS `TV_Area_Coverage`,
       `FDC`.`TV_Area_Name`                                                      AS `TV_Area_Name`,
       `FDC`.`TV_spot_Duration`                                                  AS `TV_spot_Duration`,
       `FDC`.`No_of_Spots`                                                       AS `No_of_Spots`,
       `FDC`.`TV_GRP`                                                            AS `TV_GRP`,
       `FDC`.`Print_Campaign_Start_Date`                                         AS `Print_Campaign_Start_Date`,
       `FDC`.`Print_Campaign_End_Date`                                           AS `Print_Campaign_End_Date`,
       `FDC`.`Print_Spend`                                                       AS `Print_Spend`,
       `FDC`.`Publication_Type`                                                  AS `Publication_Type`,
       `FDC`.`Publication_Name`                                                  AS `Publication_Name`,
       `FDC`.`Page_Number`                                                       AS `Page_Number`,
       `FDC`.`Size_of_ad_dimensions`                                             AS `Size_of_ad_dimensions`,
       `FDC`.`Circulation`                                                       AS `Circulation`,
       `FDC`.`Print_Impressions`                                                 AS `Print_Impressions`,
       `FDC`.`Radio_Campaign_Start_Date`                                         AS `Radio_Campaign_Start_Date`,
       `FDC`.`Radio_Campaign_End_Date`                                           AS `Radio_Campaign_End_Date`,
       `FDC`.`Radio_Spend`                                                       AS `Radio_Spend`,
       `FDC`.`Channel_Frequency`                                                 AS `Channel_Frequency`,
       `FDC`.`Radio_Impressions_or_Reach`                                        AS `Radio_Impressions_or_Reach`,
       `FDC`.`OOH_Campaign_Start_Date`                                           AS `OOH_Campaign_Start_Date`,
       `FDC`.`OOH_Campaign_End_Date`                                             AS `OOH_Campaign_End_Date`,
       `FDC`.`OOH_spend`                                                         AS `OOH_spend`,
       `FDC`.`Type_of_OOH`                                                       AS `Type_of_OOH`,
       `FDC`.`City_National`                                                     AS `City_National`,
       `FDC`.`Location`                                                          AS `Location`,
       `FDC`.`Size_of_ad`                                                        AS `Size_of_ad`,
       `FDC`.`Frequency`                                                         AS `Frequency`,
       `FDC`.`OTS_or_Reach`                                                      AS `OTS_or_Reach`,
       `FDC`.`Digital_Media_Type`                                                AS `Digital_Media_Type`,
       `FDC`.`Digital_Campaign_Start_Date`                                       AS `Digital_Campaign_Start_Date`,
       `FDC`.`Digital_Campaign_End_Date`                                         AS `Digital_Campaign_End_Date`,
       `FDC`.`Digital_Spend`                                                     AS `Digital_Spend`,
       `FDC`.`Total_Impressions`                                                 AS `Total_Impressions`,
       `FDC`.`Total_Clicks`                                                      AS `Total_Clicks`,
       `FDC`.`Total_Views`                                                       AS `Total_Views`,
       `FDC`.`Avg_Frequency`                                                     AS `Avg_Frequency`,
       `FDC`.`Total_Reach`                                                       AS `Total_Reach`,
       `FDC`.`Total_Engagement`                                                  AS `Total_Engagement`,
       `FDC`.`CRM_Type`                                                          AS `CRM_Type`,
       `FDC`.`CRM_Campaign_Start_Date`                                           AS `CRM_Campaign_Start_Date`,
       `FDC`.`CRM_Campaign_End_Date`                                             AS `CRM_Campaign_End_Date`,
       `FDC`.`CRM_Spend`                                                         AS `CRM_Spend`,
       `FDC`.`CRM_Revenue`                                                       AS `CRM_Revenue`,
       `FDC`.`Amount_Sent`                                                       AS `Amount_Sent`,
       `FDC`.`Responders`                                                        AS `Responders`,
       `FDC`.`CRM_Delivered`                                                     AS `CRM_Delivered`,
       `FDC`.`CRM_Open`                                                          AS `CRM_Open`,
       `FDC`.`CRM_Click`                                                         AS `CRM_Click`,
       `FDC`.`PR_Media`                                                          AS `PR_Media`,
       `FDC`.`PR_Start_Date`                                                     AS `PR_Start_Date`,
       `FDC`.`PR_End_Date`                                                       AS `PR_End_Date`,
       `FDC`.`Date_Month_of_Issue`                                               AS `Date_Month_of_Issue`,
       `FDC`.`Media_Title`                                                       AS `Media_Title`,
       `FDC`.`Headline_Programe`                                                 AS `Headline_Programe`,
       `FDC`.`PR_Spend`                                                          AS `PR_Spend`,
       `FDC`.`Circulation_Viewership_Hit_impressions`                            AS `Circulation_Viewership_Hit_impressions`,
       `FDC`.`Page_Area_Length`                                                  AS `Page_Area_Length`,
       `FDC`.`Equivalent_Advertising_Value`                                      AS `Equivalent_Advertising_Value`,
       `FDC`.`Mentioning_Levis_Headline_content`                                 AS `Mentioning_Levis_Headline_content`,
       `FDC`.`Nature_of_Coverage`                                                AS `Nature_of_Coverage`,
       `FDC`.`Type_of_Coverage`                                                  AS `Type_of_Coverage`,
       `FDC`.`Tonality`                                                          AS `Tonality`,
       `FDC`.`Topics_of_Coverage`                                                AS `Topics_of_Coverage`,
       `FDC`.`Cinema_Campaign_Start_Date`                                        AS `Cinema_Campaign_Start_Date`,
       `FDC`.`Cinema_Campaign_End_Date`                                          AS `Cinema_Campaign_End_Date`,
       `FDC`.`Cinema_Spend`                                                      AS `Cinema_Spend`,
       `FDC`.`Cinema_spot_Duration`                                              AS `Cinema_spot_Duration`,
       `FDC`.`Cinema_Impressions`                                                AS `Cinema_Impressions`,
       `FDC`.`TPRCO_Impressions`                                                 AS `TPRCO_Impressions`,
       `FDC`.`Others_Name_of_the_Medium`                                         AS `Others_Name_of_the_Medium`,
       `FDC`.`Others_campaign_Start_Date`                                        AS `Others_campaign_Start_Date`,
       `FDC`.`Others_campaign_End_Date`                                          AS `Others_campaign_End_Date`,
       `FDC`.`Others_campaign_Spend`                                             AS `Others_campaign_Spend`,
       `FDC`.`Other_Impressions`                                                 AS `Other_Impressions`,
       `FDC`.`SE_Communication_Type`                                             AS `SE_Communication_Type`,
       `FDC`.`SE_Campaign_Start_Date`                                            AS `SE_Campaign_Start_Date`,
       `FDC`.`SE_Campaign_End_Date`                                              AS `SE_Campaign_End_Date`,
       `FDC`.`SE_Spend`                                                          AS `SE_Spend`,
       `FDC`.`SE_Impressions`                                                    AS `SE_Impressions`,
       `FDC`.`SE_Total_Clicks`                                                   AS `SE_Total_Clicks`,
       `FDC`.`SE_Total_Views`                                                    AS `SE_Total_Views`,
       `FDC`.`VSS_Communication_Type`                                            AS `VSS_Communication_Type`,
       `FDC`.`VSS_Campaign_Start_Date`                                           AS `VSS_Campaign_Start_Date`,
       `FDC`.`VSS_Campaign_End_Date`                                             AS `VSS_Campaign_End_Date`,
       `FDC`.`VSS_Spend`                                                         AS `VSS_Spend`,
       `FDC`.`VSS_Impressions_Reach`                                             AS `VSS_Impressions_Reach`,
       `FDC`.`VSS_Impressions`                                                   AS `VSS_Impressions`,
       `FDC`.`VSS_Total_Views`                                                   AS `VSS_Total_Views`,
       `FDC`.`VSS_Total_Clicks`                                                  AS `VSS_Total_Clicks`,
       `FDC`.`Marketplace_Communication_Type`                                    AS `Marketplace_Communication_Type`,
       `FDC`.`Marketplace_Campaign_Start_Date`                                   AS `Marketplace_Campaign_Start_Date`,
       `FDC`.`Marketplace_Campaign_End_Date`                                     AS `Marketplace_Campaign_End_Date`,
       `FDC`.`Marketplace_Spend`                                                 AS `Marketplace_Spend`,
       `FDC`.`Ad_Impressions`                                                    AS `Ad_Impressions`,
       `FDC`.`Ad_Views`                                                          AS `Ad_Views`,
       `FDC`.`Ad_Clicks`                                                         AS `Ad_Clicks`,
       `FDC`.`Validation_Flag`                                                   AS `Validation_Flag`,
       `FDC`.`TV_Spend` + `FDC`.`Print_Spend` + `FDC`.`Radio_Spend` + `FDC`.`OOH_spend` + `FDC`.`Digital_Spend` +
       `FDC`.`CRM_Spend` + `FDC`.`PR_Spend` + `FDC`.`Cinema_Spend` + `FDC`.`Others_campaign_Spend` + `FDC`.`SE_Spend` +
       `FDC`.`VSS_Spend` + `FDC`.`Marketplace_Spend`                             AS `Actual_Spend`,
       `FDG`.`Sellout`                                                           AS `Sellout`,
       `FDG`.`Prev_Sellout`                                                      AS `Prev_Sellout`,
       `FDC`.`Category`                                                          AS `Category`,
       `FDG`.`Traffic`                                                           AS `Traffic`,
       `FDG`.`Prev_Traffic`                                                      AS `Prev_Traffic`
from (`LEVIS_MET2`.`Fact_DB_Campaign` `FDC`
         join (select `LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Year_Month_Num`    AS `Year_Month_Num`,
                      `LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Country`           AS `Country`,
                      sum(`LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Sellout`)      AS `Sellout`,
                      sum(`LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Prev_Sellout`) AS `Prev_Sellout`,
                      sum(`LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Traffic`)      AS `Traffic`,
                      sum(`LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Prev_Traffic`) AS `Prev_Traffic`
               from `LEVIS_MET2`.`Fact_Sellthru_Traffic`
               group by `LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Year_Month_Num`,
                        `LEVIS_MET2`.`Fact_Sellthru_Traffic`.`Country`) `FDG`)
where `FDC`.`Fiscal_Month_Num` = `FDG`.`Year_Month_Num`
  and `FDC`.`Country` = `FDG`.`Country`
  and `FDC`.`Campaign_name` <> 'Right On (Shaping)';


