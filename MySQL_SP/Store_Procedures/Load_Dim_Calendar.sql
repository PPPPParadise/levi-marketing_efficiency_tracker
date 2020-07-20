create
    definer = gilbert@`%` procedure Load_Dim_Calendar()
BEGIN
    /*
    Truncate table Stg_MET_Calendar;
    
    load data local infile 'D:\\Data\\2018_November\\MET_Calendar_04122018.txt'
    into table `Stg_MET_Calendar`
    fields terminated by '|' 
    lines terminated by '\n'
    ignore 1 lines
    (@Fiscal_Date, @Fiscal_Week, @Fiscal_Month, @Fiscal_Quarter, @Fiscal_Year)
    
    SET Fiscal_Date = Replace(@Fiscal_Date,'\0',''),
        Fiscal_Week = Replace(@Fiscal_Week,'\0',''),
        Fiscal_Month = Replace(@Fiscal_Month,'\0',''),
        Fiscal_Quarter = Replace(@Fiscal_Quarter,'\0',''), 
        Fiscal_Year = Replace(@Fiscal_Year,'\0',''); 
        */

    INSERT INTO Dim_Calendar(Fiscal_Date, Fiscal_Week, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Year_Month_Num)
    SELECT Fiscal_Date,
           Fiscal_Week,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           DATE_FORMAT(Fiscal_Date, '%Y%m')
    FROM Stg_MET_Calendar;

-- 2019 Calendar File Format

    INSERT INTO Dim_Calendar(Fiscal_Date, Fiscal_Week, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Year_Month_Num)


    SELECT Fiscal_Date,
           REPLACE(Fiscal_Week, SUBSTRING(Fiscal_Week, 1, 4), 'Wk'),
           CASE
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '01' THEN 'Jan'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Feb'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Mar'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Apr'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'May'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Jun'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Jul'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Aug'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Sep'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Oct'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Nov'
               WHEN SUBSTRING(Fiscal_Month, 6, 2) = '02' THEN 'Dec'
               ELSE '' END,
           REPLACE(Fiscal_Quarter, SUBSTRING(Fiscal_Quarter, 1, 4), 'Q'),
           Fiscal_Year,
           CASE
               WHEN CONCAT(SUBSTRING(Fiscal_Month, 1, 4), SUBSTRING(Fiscal_Month, 6, 2)) = 201901 THEN 201812
               ELSE CONCAT(SUBSTRING(Fiscal_Month, 1, 4), SUBSTRING(Fiscal_Month, 6, 2)) - 1 END
           -- DATE_FORMAT(Fiscal_Date,'%Y%m')
    FROM Stg_MET_Calendar
    where Fiscal_Date > '2018-11-30'
    ORDER BY Fiscal_Date;

    UPDATE Dim_Calendar
    SET Monrh_Char = SUBSTRING(Monthname(Fiscal_Date), 1, 3)
    WHERE Created_Date = '2019-01-08 06:08:13';

END;


