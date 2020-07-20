create definer = gilbert@`%` view DB_Sellthru_Traffic_View as
select `FDG`.`Region`                                                                     AS `Region`,
       `FDG`.`Country`                                                                    AS `Country`,
       `FDG`.`Fiscal_Quarter`                                                             AS `Fiscal_Quarter`,
       `FDG`.`Fiscal_Year`                                                                AS `Fiscal_Year_Num`,
       concat(`FDG`.`Fiscal_Month`, '-',
              substr(`FDG`.`Year_Month_Num`, 3, 2))                                       AS `Year_Month_Char`,
       case when `FDG`.`Fiscal_Quarter` in ('Q1', 'Q2') then 'H1' else 'H2' end           AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                               AS `Curr_Fiscal_Year`,
       `FDG`.`Year_Month_Num`                                                             AS `Fiscal_Month_Num`,
       `FDG`.`Fiscal_Month`                                                               AS `Fiscal_Month`,
       `FDG`.`Channel`                                                                    AS `Channel`,
       case when `FDG`.`Traffic` = 0 then NULL else `FDG`.`Traffic` end                   AS `Overall_Traffic`,
       case
           when `FDG`.`Prev_Traffic` = 0 then NULL
           else `FDG`.`Prev_Traffic` end                                                  AS `Prev_Overall_Traffic`,
       case when `FDG`.`Sellout` = 0 then NULL else `FDG`.`Sellout` end                   AS `Sellout`,
       case
           when `FDG`.`Prev_Sellout` = 0 then NULL
           else `FDG`.`Prev_Sellout` end                                                  AS `Prev_Sellout`,
       case when `FDG`.`Comp` = 0 then NULL else `FDG`.`Comp` end                         AS `Comp`,
       case when `FDG`.`Prev_Comp` = 0 then NULL else `FDG`.`Prev_Comp` end               AS `Prev_Comp`,
       case when `FDG`.`Non_Comp` = 0 then NULL else `FDG`.`Non_Comp` end                 AS `Non_Comp`,
       case
           when `FDG`.`Prev_Non_Comp` = 0 then NULL
           else `FDG`.`Prev_Non_Comp` end                                                 AS `Prev_Non_Comp`,
       case when `FDG`.`Promo` = 0 then NULL else `FDG`.`Promo` end                       AS `Promo`,
       case when `FDG`.`Prev_Promo` = 0 then NULL else `FDG`.`Prev_Promo` end             AS `Prev_Promo`,
       case when `FDG`.`Non_Promo` = 0 then NULL else `FDG`.`Non_Promo` end               AS `Non_Promo`,
       case
           when `FDG`.`Prev_Non_Promo` = 0 then NULL
           else `FDG`.`Prev_Non_Promo` end                                                AS `Prev_Non_Promo`,
       case when `FDG`.`ECom_Promo` = 0 then NULL else `FDG`.`ECom_Promo` end             AS `ECom_Promo`,
       case
           when `FDG`.`Prev_ECom_Promo` = 0 then NULL
           else `FDG`.`Prev_ECom_Promo` end                                               AS `Prev_ECom_Promo`,
       case
           when `FDG`.`ECom_Non_Promo` = 0 then NULL
           else `FDG`.`ECom_Non_Promo` end                                                AS `ECom_Non_Promo`,
       case
           when `FDG`.`Prev_ECom_Non_Promo` = 0 then NULL
           else `FDG`.`Prev_ECom_Non_Promo` end                                           AS `Prev_ECom_Non_Promo`,
       case when `FDG`.`Comp_Promo` = 0 then NULL else `FDG`.`Comp_Promo` end             AS `Comp_Promo`,
       case
           when `FDG`.`Prev_Comp_Promo` = 0 then NULL
           else `FDG`.`Prev_Comp_Promo` end                                               AS `Prev_Comp_Promo`,
       case
           when `FDG`.`Non_Comp_Promo` = 0 then NULL
           else `FDG`.`Non_Comp_Promo` end                                                AS `Non_Comp_Promo`,
       case
           when `FDG`.`Prev_Non_Comp_Promo` = 0 then NULL
           else `FDG`.`Prev_Non_Comp_Promo` end                                           AS `Prev_Non_Comp_Promo`,
       case
           when `FDG`.`Comp_Non_Promo` = 0 then NULL
           else `FDG`.`Comp_Non_Promo` end                                                AS `Comp_Non_Promo`,
       case
           when `FDG`.`Prev_Comp_Non_Promo` = 0 then NULL
           else `FDG`.`Prev_Comp_Non_Promo` end                                           AS `Prev_Comp_Non_Promo`,
       case
           when `FDG`.`Non_Comp_Non_Promo` = 0 then NULL
           else `FDG`.`Non_Comp_Non_Promo` end                                            AS `Non_Comp_Non_Promo`,
       case
           when `FDG`.`Prev_Non_Comp_Non_Promo` = 0 then NULL
           else `FDG`.`Prev_Non_Comp_Non_Promo` end                                       AS `Prev_Non_Comp_Non_Promo`,
       case
           when `FDG`.`Traffic_Comp` = 0 then NULL
           else `FDG`.`Traffic_Comp` end                                                  AS `Traffic_Comp`,
       case
           when `FDG`.`Prev_Traffic_Comp` = 0 then NULL
           else `FDG`.`Prev_Traffic_Comp` end                                             AS `Prev_Traffic_Comp`,
       case
           when `FDG`.`Traffic_Comp_Non_Comp` = 0 then NULL
           else `FDG`.`Traffic_Comp_Non_Comp` end                                         AS `Traffic_Comp_Non_Comp`,
       case
           when `FDG`.`Prev_Traffic_Comp_Non_Comp` = 0 then NULL
           else `FDG`.`Prev_Traffic_Comp_Non_Comp` end                                    AS `Prev_Traffic_Comp_Non_Comp`,
       case when `FDG`.`No_Of_Trans` = 0 then NULL else `FDG`.`No_Of_Trans` end           AS `Trans_All_Stores`,
       case
           when `FDG`.`Prev_No_Of_Trans` = 0 then NULL
           else `FDG`.`Prev_No_Of_Trans` end                                              AS `Prev_Trans_All_Stores`,
       case
           when `FDG`.`Trans_Comp_Stores` = 0 then NULL
           else `FDG`.`Trans_Comp_Stores` end                                             AS `Trans_Comp_Stores`,
       case
           when `FDG`.`Prev_Trans_Comp_Stores` = 0 then NULL
           else `FDG`.`Prev_Trans_Comp_Stores` end                                        AS `Prev_Trans_Comp_Stores`,
       case
           when `FDG`.`Trans_Online_Stores` = 0 then NULL
           else `FDG`.`Trans_Online_Stores` end                                           AS `Trans_Online_Stores`,
       case
           when `FDG`.`Prev_Trans_Online_Stores` = 0 then NULL
           else `FDG`.`Prev_Trans_Online_Stores` end                                      AS `Prev_Trans_Online_Stores`,
       case when `FDG`.`Spend` = 0 then NULL else `FDG`.`Spend` end                       AS `Spend`,
       case when `FDG`.`Prev_Spend` = 0 then NULL else `FDG`.`Prev_Spend` end             AS `Prev_Spend`,
       case
           when `FDG`.`SM_Engagement` = 0 then NULL
           else `FDG`.`SM_Engagement` end                                                 AS `SM_Engagement`,
       case
           when `FDG`.`Prev_SM_Engagement` = 0 then NULL
           else `FDG`.`Prev_SM_Engagement` end                                            AS `Prev_SM_Engagement`,
       case when `FDG`.`Acquisition` = 0 then NULL else `FDG`.`Acquisition` end           AS `Acquisition`,
       case
           when `FDG`.`Prev_Acquisition` = 0 then NULL
           else `FDG`.`Prev_Acquisition` end                                              AS `Prev_Acquisition`,
       case
           when `FDG`.`Mem_Sellthru` = 0 then NULL
           else `FDG`.`Mem_Sellthru` end                                                  AS `Mem_Sellthru`,
       case
           when `FDG`.`Prev_Mem_Sellthru` = 0 then NULL
           else `FDG`.`Prev_Mem_Sellthru` end                                             AS `Prev_Mem_Sellthru`,
       case when `FDG`.`Listening` = 0 then NULL else `FDG`.`Listening` end               AS `Listening`,
       case
           when `FDG`.`Prev_Listening` = 0 then NULL
           else `FDG`.`Prev_Listening` end                                                AS `Prev_Listening`,
       case
           when `FDG`.`Levis_Organic_Search` = 0 then NULL
           else `FDG`.`Levis_Organic_Search` end                                          AS `Levis_Organic_Search`,
       case
           when `FDG`.`Prev_Levis_Organic_Search` = 0 then NULL
           else `FDG`.`Prev_Levis_Organic_Search` end                                     AS `Prev_Levis_Organic_Search`,
       case
           when `FDG`.`Total_Stores` = 0 then NULL
           else `FDG`.`Total_Stores` end                                                  AS `Total_Stores`,
       case
           when `FDG`.`Total_Traffic_Counter_Stores` = 0 then NULL
           else `FDG`.`Total_Traffic_Counter_Stores` end                                  AS `Total_Traffic_Counter_Stores`,
       case
           when ((`FDG`.`Trans_Online_Stores` is null or `FDG`.`Trans_Online_Stores` = 0) and
                 `FDG`.`Channel` = 'ONLINE') then NULL
           else (`FDG`.`No_Of_Trans` + `FDG`.`Trans_Online_Stores`) / `FDG`.`Traffic` end AS `Traffic_Conversion_Rate`,
       case
           when ((`FDG`.`Prev_Trans_Online_Stores` is null or `FDG`.`Prev_Trans_Online_Stores` = 0) and
                 `FDG`.`Channel` = 'ONLINE') then NULL
           else (`FDG`.`Prev_No_Of_Trans` + `FDG`.`Prev_Trans_Online_Stores`) /
                `FDG`.`Prev_Traffic` end                                                  AS `Prev_Traffic_Conversion_Rate`
from `LEVIS_MET2`.`Fact_Sellthru_Traffic` `FDG`;


