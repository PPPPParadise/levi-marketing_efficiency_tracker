create definer = gilbert@`%` view DB_Search_Keyword_View as
select `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Year_Month_Num` AS `Year_Month_Num`,
       `D`.`Fiscal_Year`                                      AS `Fiscal_Year`,
       `D`.`Fiscal_Quarter`                                   AS `Quarter`,
       `D`.`Fiscal_Month`                                     AS `Month`,
       case
           when substr(`LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Year_Month_Num`, 5, 2) in (12, 1, 2, 3, 4, 5) then 'H1'
           when substr(`LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Year_Month_Num`, 5, 2) in (6, 7, 8, 9, 10, 11) then 'H2'
           else 0 end                                         AS `Biannual`,
       `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Country`        AS `Country`,
       `C`.`Region`                                           AS `Region`,
       `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Keyword`        AS `Keyword`,
       `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Count_Keyword`  AS `Count_Keyword`
from ((`LEVIS_MET2`.`Fact_DB_Search_Keyword` join `LEVIS_MET2`.`Dim_Calendar` `D` on (
        `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Year_Month_Num` = `D`.`Year_Month_Num`))
         join `LEVIS_MET2`.`Dim_Country` `C` on (`LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Country` = `C`.`Country`))
group by `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Year_Month_Num`, `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Country`,
         `LEVIS_MET2`.`Fact_DB_Search_Keyword`.`Keyword`;


