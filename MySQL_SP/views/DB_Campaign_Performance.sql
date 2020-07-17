create definer = gilbert@`%` view DB_Campaign_Performance as
select `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_name`                                 AS `Campaign_name`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Type_of_Campaign`                              AS `Campaign_Type`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Region`                                        AS `Region`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Country`                                       AS `Country`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Fiscal_Year`                                   AS `Fiscal_Year`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`                          AS `Campaign_Start_Month`,
       case
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in ('12', '01', '02')
               then 'Q1'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in ('03', '04', '05')
               then 'Q2'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in ('06', '07', '08')
               then 'Q3'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in ('09', '10', '11')
               then 'Q4' end                                                                    AS `Campaign_Start_Quater`,
       case
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in
                ('12', '01', '02', '03', '04', '05') then 'H1'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Month`, 5, 2) in
                ('06', '07', '08', '09', '10', '11')
               then 'H2' end                                                                    AS `Campaign_Start_Half`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`                            AS `Campaign_End_Month`,
       case
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in ('12', '01', '02')
               then 'Q1'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in ('03', '04', '05')
               then 'Q2'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in ('06', '07', '08')
               then 'Q3'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in ('09', '10', '11')
               then 'Q4' end                                                                    AS `Campaign_End_Quater`,
       case
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in
                ('12', '01', '02', '03', '04', '05') then 'H1'
           when substr(`LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Month`, 5, 2) in
                ('06', '07', '08', '09', '10', '11') then 'H2' end                              AS `Campaign_End_Half`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Start_Date`                           AS `Campaign_Start_Date`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_End_Date`                             AS `Campaign_End_Date`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Sellout`                              AS `Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Campaign_Sellout`                    AS `Prev_Year_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Sellout`                            AS `Prev_Month_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Sellout`                  AS `Prev_Year_Prev_Month_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Sellout`                            AS `Next_Month_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Sellout`                  AS `Prev_Year_Next_Month_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Product_Campaign_Sellout`                      AS `Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Product_Campaign_Sellout`            AS `Prev_Year_Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Product_Campaign_Sellout`           AS `Prev_Month_Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Product_Campaign_Sellout` AS `Prev_Year_Prev_Month_Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Product_Campaign_Sellout`           AS `Next_Month_Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Product_Campaign_Sellout` AS `Prev_Year_Next_Month_Product_Campaign_Sellout`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Traffic_Comp`                         AS `Campaign_Traffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Campaign_Traffic_Comp`               AS `Prev_Year_Campaign_Traffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Traffic_Comp`                       AS `Prev_Month_Traffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Traffic_Comp`             AS `Prev_Year_Prev_Month_Traffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_STraffic_Comp`                      AS `Next_Month_STraffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Traffic_Comp`             AS `Prev_Year_Next_Month_Traffic_Comp`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Brand_Engagement`                              AS `Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Brand_Engagement`                    AS `Prev_Year_Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Brand_Engagement`                   AS `Prev_Month_Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Brand_Engagement`         AS `Prev_Year_Prev_Month_Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Brand_Engagement`                   AS `Next_Month_Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Brand_Engagement`         AS `Prev_Year_Next_Month_Brand_Engagement`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Clicks`                                        AS `Clicks`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Clicks`                                   AS `Prev_Clicks`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Clicks`                             AS `Prev_Month_Clicks`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Clicks`                             AS `Next_Month_Clicks`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Website_Traffic`                               AS `Website_Traffic`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Website_Traffic`                     AS `Prev_Year_Website_Traffic`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Sessions`                                      AS `Sessions`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Sessions`                            AS `Prev_Year_Sessions`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Qty_Sold`                                      AS `Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Qty_Sold`                            AS `Prev_Year_Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Qty_Sold`                           AS `Prev_Month_Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Qty_Sold`                 AS `Prev_Year_Prev_Month_Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Qty_Sold`                           AS `Next_Month_Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Qty_Sold`                 AS `Prev_Year_Next_Month_Qty_Sold`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Qty_On_Hand`                                   AS `Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Qty_On_Hand`                         AS `Prev_Year_Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Month_Qty_On_Hand`                        AS `Prev_Month_Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Prev_Month_Qty_On_Hand`              AS `Prev_Year_Prev_Month_Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Next_Month_Qty_On_Hand`                        AS `Next_Month_Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Year_Next_Month_Qty_On_Hand`              AS `Prev_Year_Next_Month_Qty_On_Hand`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Campaign_Spend`                                AS `Campaign_Spend`,
       `LEVIS_MET2`.`Fact_Campaign_Performance`.`Prev_Campaign_Spend`                           AS `Prev_Year_Campaign_Spend`
from `LEVIS_MET2`.`Fact_Campaign_Performance`;


