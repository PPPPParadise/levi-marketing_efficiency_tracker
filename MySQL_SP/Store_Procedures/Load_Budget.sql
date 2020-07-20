create
    definer = kchaudhary@`%` procedure Load_Budget()
BEGIN


    /* truncate table Stg_Budget;

    load data local infile 'May.csv'
            into table Stg_Budget
            fields terminated by ','
            OPTIONALLY ENCLOSED BY '"'
            ESCAPED BY '"'
            LINES TERMINATED BY '\r\n'
            IGNORE 1 LINES
            (@Country,@Month,@Medium,@Budget,@Actuals)

            SET
            Country=@Country,
            Month_Char=@Month,
            `Medium`=@Medium,
            Budget=@Budget,
            Actual_Spend=@Actuals;
*/

    /* Select * from Stg_Budget; */

    /*  delete from Budget where Month_Num=202004
      and Medium in ('E-Commerce','In-Store','Non-Working Media');*/

    -- delete it every month before loading in main table
    insert into Budget(Region, Country, Fiscal_Year, Half, Fiscal_Quarter, Month_Char, Year_Month_Num, `Medium`, Budget,
                       Actual_Spend)
    select C.Region,
           S.Country,
           D.Fiscal_Year,
           (CASE
                when (substring(Month_Char, 1, 3) in ('Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May')) then 'H1'
                when (substring(Month_Char, 1, 3) in ('Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov')) then 'H2'
                else 00
               end)         Half,
           (CASE
                when (substring(Month_Char, 1, 3) in ('Dec', 'Jan', 'Feb')) then 'Q1'
                when (substring(Month_Char, 1, 3) in ('Mar', 'Apr', 'May')) then 'Q2'
                when (substring(Month_Char, 1, 3) in ('Jun', 'Jul', 'Aug')) then 'Q3'
                when (substring(Month_Char, 1, 3) in ('Sep', 'Oct', 'Nov')) then 'Q4'
                else 00
               end)         Fiscal_Quarter,
           S.Month_Char,
           CONCAT(20, SUBSTR(Month_Char, 5, 2),
                  (CASE
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Jan' THEN '01'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Feb' THEN '02'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Mar' THEN '03'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Apr' THEN '04'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'May' THEN '05'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Jun' THEN '06'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Jul' THEN '07'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Aug' THEN '08'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Sep' THEN '09'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Oct' THEN '10'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Nov' THEN '11'
                       WHEN SUBSTR(Month_Char, 1, 3) = 'Dec' THEN '12'
                       ELSE 00
                      END)) Year_Month_Num,
           S.Medium,
           S.Budget,
           S.Actual_Spend
    from Stg_Budget as S
             left join Dim_Country as C on S.Country = C.Country
             left join Dim_Calendar as D on CONCAT(20, SUBSTR(Month_Char, 5, 2),
                                                   (CASE
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Jan' THEN '01'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Feb' THEN '02'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Mar' THEN '03'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Apr' THEN '04'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'May' THEN '05'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Jun' THEN '06'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Jul' THEN '07'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Aug' THEN '08'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Sep' THEN '09'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Oct' THEN '10'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Nov' THEN '11'
                                                        WHEN SUBSTR(Month_Char, 1, 3) = 'Dec' THEN '12'
                                                        ELSE 00
                                                       END)) = D.Year_Month_Num

    on duplicate key update Budget.Budget=S.Budget,
                            Budget.Actual_Spend=S.Actual_Spend;
    /*run the update statements to add data
    in working media once only after MKT_Template_Spend is loaded in db */

    set Sql_Safe_Updates = 0;

    UPDATE Budget as B,
        (Select MTS.Country, Month_Num, Sum(MTS.Actual_Spend) as Sum_Actual_Spend
         from MKT_Template_Spend as MTS
         group by MTS.Country, Month_Num) as Q
    SET B.Actual_Spend = Q.Sum_Actual_Spend
    where B.`Medium` = 'Working Media'
      and B.Year_Month_Num = Q.Month_Num
      and B.Country = Q.Country;


    UPDATE Budget as B,
        (Select MTS.Country, Month_Num as M, Sum(MTS.Actual_Spend) as A
         from MKT_Template_Spend as MTS
         group by MTS.`Country`, MTS.Month_Num) as Q
    SET B.Prev_Actual_Spend= Q.A
    where B.`Medium` = 'Working Media'
      and B.Year_Month_Num - 100 = Q.M
      and B.Country = Q.Country;

    UPDATE Budget B,
        (Select Country, Year_Month_Num + 100 as P_Year_Month_Num, Medium, Actual_Spend
         from Budget
         where Medium <> 'Working Media') Q
    SET Prev_Actual_Spend= Q.Actual_Spend
    WHERE B.Country = Q.Country
      and B.Year_Month_Num = Q.P_Year_Month_Num
      and B.Medium = Q.Medium;

END;


