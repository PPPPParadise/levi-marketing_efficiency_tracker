create definer = gilbert@`%` view DB_Organic_Search_View as
select `LEVIS_MET2`.`Organic_Search_Competitors`.`Country`        AS `Country`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Region`         AS `Region`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Year_Month_Num` AS `Year_Month_Num`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Month`          AS `Month`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Biannual`       AS `Biannual`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Quarter`        AS `Quarter`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Year`           AS `Year`,
       `LEVIS_MET2`.`Organic_Search_Competitors`.`Comp_Name`      AS `Comp_Name`,
       avg(`LEVIS_MET2`.`Organic_Search_Competitors`.`Searches`)  AS `Searches`
from `LEVIS_MET2`.`Organic_Search_Competitors`
group by `LEVIS_MET2`.`Organic_Search_Competitors`.`Year_Month_Num`,
         `LEVIS_MET2`.`Organic_Search_Competitors`.`Comp_Name`, `LEVIS_MET2`.`Organic_Search_Competitors`.`Country`;


