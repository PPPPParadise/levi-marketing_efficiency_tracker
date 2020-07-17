create definer = gilbert@`%` view DB_ECom_View as
select `FDG`.`Region`                                                           AS `Region`,
       `FDG`.`Country`                                                          AS `Country`,
       `FDG`.`Fiscal_Quarter`                                                   AS `Fiscal_Quarter`,
       `FDG`.`Fiscal_Year`                                                      AS `Fiscal_Year_Num`,
       concat(`FDG`.`Fiscal_Month`, '-',
              substr(`FDG`.`Year_Month_Num`, 3, 2))                             AS `Year_Month_Char`,
       case when `FDG`.`Fiscal_Quarter` in ('Q1', 'Q2') then 'H1' else 'H2' end AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                     AS `Curr_Fiscal_Year`,
       `FDG`.`Year_Month_Num`                                                   AS `Fiscal_Month_Num`,
       `FDG`.`Fiscal_Month`                                                     AS `Fiscal_Month`,
       `FDG`.`Fiscal_Date`                                                      AS `Fiscal_Date`,
       `FDG`.`GA_Medium`                                                        AS `Medium`,
       `FDG`.`GA_Source`                                                        AS `Source`,
       `FDG`.`Channel`                                                          AS `Channel`,
       case
           when `FDG`.`Campaign` = '(not set)' then 'NA'
           else `FDG`.`Campaign` end                                            AS `Campaign`,
       case when `FDG`.`Pageviews` = 0 then NULL else `FDG`.`Pageviews` end     AS `Pageviews`,
       case
           when `FDG`.`Prev_Pageviews` = 0 then NULL
           else `FDG`.`Prev_Pageviews` end                                      AS `Prev_Pageviews`,
       case
           when `FDG`.`Prev_Year_Pageviews` = 0 then NULL
           else `FDG`.`Prev_Year_Pageviews` end                                 AS `Prev_Year_Pageviews`,
       case
           when `FDG`.`Unique_Pageviews` = 0 then NULL
           else `FDG`.`Unique_Pageviews` end                                    AS `Unique_Pageviews`,
       case
           when `FDG`.`Prev_Unique_Pageviews` = 0 then NULL
           else `FDG`.`Prev_Unique_Pageviews` end                               AS `Prev_Unique_Pageviews`,
       case
           when `FDG`.`Prev_Year_Unique_Pageviews` = 0 then NULL
           else `FDG`.`Prev_Year_Unique_Pageviews` end                          AS `Prev_Year_Unique_Pageviews`,
       case when `FDG`.`Sessions` = 0 then NULL else `FDG`.`Sessions` end       AS `Sessions`,
       case
           when `FDG`.`Prev_Sessions` = 0 then NULL
           else `FDG`.`Prev_Sessions` end                                       AS `Prev_Sessions`,
       case
           when `FDG`.`Prev_Year_Sessions` = 0 then NULL
           else `FDG`.`Prev_Year_Sessions` end                                  AS `Prev_Year_Sessions`,
       case
           when `FDG`.`Session_Duration` = 0 then NULL
           else `FDG`.`Session_Duration` end                                    AS `Session_Duration`,
       case
           when `FDG`.`Prev_Session_Duration` = 0 then NULL
           else `FDG`.`Prev_Session_Duration` end                               AS `Prev_Session_Duration`,
       case
           when `FDG`.`Prev_Year_Session_Duration` = 0 then NULL
           else `FDG`.`Prev_Year_Session_Duration` end                          AS `Prev_Year_Session_Duration`,
       case when `FDG`.`Bounces` = 0 then NULL else `FDG`.`Bounces` end         AS `Bounces`,
       case
           when `FDG`.`Prev_Bounces` = 0 then NULL
           else `FDG`.`Prev_Bounces` end                                        AS `Prev_Bounces`,
       case
           when `FDG`.`Prev_Year_Bounces` = 0 then NULL
           else `FDG`.`Prev_Year_Bounces` end                                   AS `Prev_Year_Bounces`,
       case when `FDG`.`Revenue` = 0 then NULL else `FDG`.`Revenue` end         AS `Revenue`,
       case
           when `FDG`.`Prev_Revenue` = 0 then NULL
           else `FDG`.`Prev_Revenue` end                                        AS `Prev_Revenue`,
       case
           when `FDG`.`Prev_Year_Revenue` = 0 then NULL
           else `FDG`.`Prev_Year_Revenue` end                                   AS `Prev_Year_Revenue`,
       case
           when `FDG`.`Transactions` = 0 then NULL
           else `FDG`.`Transactions` end                                        AS `Transactions`,
       case
           when `FDG`.`Prev_Transactions` = 0 then NULL
           else `FDG`.`Prev_Transactions` end                                   AS `Prev_Transactions`,
       case
           when `FDG`.`Prev_Year_Transactions` = 0 then NULL
           else `FDG`.`Prev_Year_Transactions` end                              AS `Prev_Year_Transactions`,
       case when `FDG`.`Users` = 0 then NULL else `FDG`.`Users` end             AS `Users`,
       case when `FDG`.`Prev_Users` = 0 then NULL else `FDG`.`Prev_Users` end   AS `Prev_Users`,
       case
           when `FDG`.`Prev_Year_Users` = 0 then NULL
           else `FDG`.`Prev_Year_Users` end                                     AS `Prev_Year_Users`,
       case when `FDG`.`New_Users` = 0 then NULL else `FDG`.`New_Users` end     AS `New_Users`,
       case
           when `FDG`.`Prev_New_Users` = 0 then NULL
           else `FDG`.`Prev_New_Users` end                                      AS `Prev_New_Users`,
       case
           when `FDG`.`Prev_Year_New_Users` = 0 then NULL
           else `FDG`.`Prev_Year_New_Users` end                                 AS `Prev_Year_New_Users`,
       'Search Term'                                                            AS `Search_Term`
from `LEVIS_MET2`.`Fact_DB_ECom` `FDG`
where `FDG`.`Year_Month_Num` < date_format(current_timestamp(), '%Y%m');


