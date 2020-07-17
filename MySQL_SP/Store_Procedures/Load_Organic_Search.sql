create
    definer = kchaudhary@`%` procedure Load_Organic_Search()
BEGIN
    /*
    Truncate table Stg_Organic_Search;
    load data local infile 'C:\\Naveeta\\OrganicSearch\\SouthKorea.csv'
    into table `Stg_Organic_Search`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES
    (@Search_Date, @Levis)
    SET Search_Date = @Search_Date,
         Levis = @Levis,
         Country = 'abc';         ----add country name inplace of abc
         */

-- DELETE FROM Organic_Search WHERE Country != 'China';

    INSERT INTO Organic_Search(Search_Date, Levis, Country, Month, Year_Month_Num)

    SELECT Get_Std_Date(Search_Date),
           Levis,
           Country,
           DATE_FORMAT(Get_Std_Date(Search_Date), '%b-%y'),
           DATE_FORMAT(Get_Std_Date(Search_Date), '%Y%m')
    FROM Stg_Organic_Search;

    -- For China :

/*Truncate table Stg_Organic_Search;
load data local infile 'D:\\Data\\2019_April\\Organic_Search\\Organic_Search_Apr2019_1.csv'
into table `Stg_Organic_Search`
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY  '\n'   
IGNORE 3 LINES
(@Country, @Month_C,@Org_Baidu, @Org_Alibaba)
SET Search_Date = @Month_C,
     Levis = @Org_Baidu,
     Country = 'China'; */

    DELETE FROM Stg_Organic_Search where Search_Date is NULL OR Search_Date = '';


    INSERT INTO Organic_Search(Search_Date, Levis, Country, Month, Year_Month_Num)
    SELECT STR_TO_DATE(Search_Date, '%b-%y'),
           Levis,
           Country,
           Search_Date,
           CONCAT(20, SUBSTR(Search_Date, 5, 2),
                  CASE
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Jan' THEN '01'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Feb' THEN '02'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Mar' THEN '03'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Apr' THEN '04'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'May' THEN '05'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Jun' THEN '06'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Jul' THEN '07'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Aug' THEN '08'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Sep' THEN '09'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Oct' THEN '10'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Nov' THEN '11'
                      WHEN SUBSTR(Search_Date, 1, 3) = 'Dec' THEN '12'
                      ELSE '00'
                      END) AS Year_Month_Num
    FROM Stg_Organic_Search;
END;


