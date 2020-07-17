create definer = gilbert@`%` view DB_Budget_View as
select `LEVIS_MET2`.`Budget`.`Region`                   AS `Region`,
       `LEVIS_MET2`.`Budget`.`Country`                  AS `Country`,
       `LEVIS_MET2`.`Budget`.`Fiscal_Year`              AS `Fiscal_Year`,
       `LEVIS_MET2`.`Budget`.`Half`                     AS `Half`,
       `LEVIS_MET2`.`Budget`.`Fiscal_Quarter`           AS `Fiscal_Quarter`,
       `LEVIS_MET2`.`Budget`.`Month_Char`               AS `Month_Char`,
       substr(`LEVIS_MET2`.`Budget`.`Month_Char`, 1, 3) AS `Month`,
       `LEVIS_MET2`.`Budget`.`Year_Month_Num`           AS `Year_Month_Num`,
       `LEVIS_MET2`.`Budget`.`Medium`                   AS `Medium`,
       `LEVIS_MET2`.`Budget`.`Budget`                   AS `Budget`,
       `LEVIS_MET2`.`Budget`.`Actual_Spend`             AS `Actual_Spend`,
       `LEVIS_MET2`.`Budget`.`Prev_Actual_Spend`        AS `Prev_Actual_Spend`
from `LEVIS_MET2`.`Budget`;


