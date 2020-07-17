create definer = gilbert@`%` view DB_Campaign_Product_View as
select `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Month_Num`      AS `Fiscal_Month_Num`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Year_Num`       AS `Fiscal_Year_Num`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Year_Month_Char`       AS `Year_Month_Char`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Biannual`       AS `Fiscal_Biannual`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Quarter`        AS `Fiscal_Quarter`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Month`          AS `Fiscal_Month`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Fiscal_Date`           AS `Fiscal_Date`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Country`               AS `Country`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Region`                AS `Region`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Campaign_name`         AS `Campaign_name`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Sellout`               AS `Sellout`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Prev_Sellout`          AS `Prev_Sellout`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Product_Sellout`       AS `Product_Sellout`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Prev_Product_Sellout`  AS `Prev_Product_Sellout`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Traffic`               AS `Traffic`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Prev_Traffic`          AS `Prev_Traffic`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Brand_Engagement`      AS `Brand_Engagement`,
       `LEVIS_MET2`.`Fact_DB_Campaign_Product`.`Prev_Brand_Engagement` AS `Prev_Brand_Engagement`
from `LEVIS_MET2`.`Fact_DB_Campaign_Product`;


