create
    definer = pkishlay@`%` procedure Pop_Fact_DB_Campaign_Product(IN i_Job_ID int, IN i_Country varchar(30),
                                                                  IN i_Year_Month_Num int, IN i_Call_Type varchar(30))
BEGIN

    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 0, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Stg_Campaign_Product_Map;

        INSERT INTO Stg_Campaign_Product_Map (Country, Month_Num, Campaign_name, Product_Code)
        SELECT Distinct Country, Month_Num, B.Campaign_name, Replace(B.Product_Code, '-', '') Product_Code
        FROM MKT_Template_Spend A
                 RIGHT JOIN Campaign_PC9 B ON A.Campaign_name = B.Campaign_name
        WHERE Process_Flag = 'Y';

    ELSEIF i_Call_Type = 'SUBMIT' THEN

        TRUNCATE TABLE Stg_Campaign_Product_Map;

        INSERT INTO Stg_Campaign_Product_Map (Country, Month_Num, Campaign_name, Product_Code)
        SELECT Distinct Country, Month_Num, B.Campaign_name, Replace(B.Product_Code, '-', '') Product_Code
        FROM MKT_Template_Spend A
                 RIGHT JOIN Campaign_PC9 B ON A.Campaign_name = B.Campaign_name
        WHERE Country = i_Country;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        TRUNCATE TABLE Stg_Campaign_Product_Map;

        INSERT INTO Stg_Campaign_Product_Map (Country, Month_Num, Campaign_name, Product_Code)
        SELECT Distinct Country, Month_Num, B.Campaign_name, Replace(B.Product_Code, '-', '') Product_Code
        FROM MKT_Template_Spend A
                 RIGHT JOIN Campaign_PC9 B ON A.Campaign_name = B.Campaign_name
        WHERE Process_Flag = 'Y'
          AND Country = i_Country;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 10, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Stg_Fact_DB_Campaign_Product;

        INSERT INTO Stg_Fact_DB_Campaign_Product (Year_Month_Num, Year_Month_Char, Fiscal_Biannual, Fiscal_Quarter,
                                                  Fiscal_Year, Fiscal_Month, Country, Region, Campaign_name)
        SELECT DISTINCT Year_Month_Num,
                        CONCAT(Fiscal_Month, '-', SUBSTR(Year_Month_Num, 3, 2)),
                        CASE WHEN Fiscal_Quarter IN ('Q1', 'Q2') THEN 'H1' ELSE 'H2' END,
                        Fiscal_Quarter,
                        Fiscal_Year,
                        Fiscal_Month,
                        Co.Country,
                        Region,
                        Campaign_name
        FROM Dim_Calendar_Month C,
             Dim_Country Co,
             (SELECT DISTINCT Campaign_name, Country, Month_Num
              FROM MKT_Template_Spend
              WHERE Process_Flag = 'Y') P
        WHERE Year_Month_Num BETWEEN '201612' AND DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y%m')
          AND Co.Country = P.Country;

    ELSEIF i_Call_Type = 'SUBMIT' THEN

        DELETE
        FROM Stg_Fact_DB_Campaign_Product
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

        INSERT INTO Stg_Fact_DB_Campaign_Product (Year_Month_Num, Year_Month_Char, Fiscal_Biannual, Fiscal_Quarter,
                                                  Fiscal_Year, Fiscal_Month, Country, Region, Campaign_name)
        SELECT DISTINCT Year_Month_Num,
                        CONCAT(Fiscal_Month, '-', SUBSTR(Year_Month_Num, 3, 2)),
                        CASE WHEN Fiscal_Quarter IN ('Q1', 'Q2') THEN 'H1' ELSE 'H2' END,
                        Fiscal_Quarter,
                        Fiscal_Year,
                        Fiscal_Month,
                        Co.Country,
                        Region,
                        Campaign_name
        FROM Dim_Calendar_Month C,
             Dim_Country Co,
             (SELECT DISTINCT Campaign_name, Country, Month_Num
              FROM MKT_Template_Spend) P
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Co.Country = i_Country
          AND Co.Country = P.Country;

    ELSEIF i_Call_Type = 'APPROVE' THEN

        DELETE
        FROM Stg_Fact_DB_Campaign_Product
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

        INSERT INTO Stg_Fact_DB_Campaign_Product (Year_Month_Num, Year_Month_Char, Fiscal_Biannual, Fiscal_Quarter,
                                                  Fiscal_Year, Fiscal_Month, Country, Region, Campaign_name)
        SELECT DISTINCT Year_Month_Num,
                        CONCAT(Fiscal_Month, '-', SUBSTR(Year_Month_Num, 3, 2)),
                        CASE WHEN Fiscal_Quarter IN ('Q1', 'Q2') THEN 'H1' ELSE 'H2' END,
                        Fiscal_Quarter,
                        Fiscal_Year,
                        Fiscal_Month,
                        Co.Country,
                        Region,
                        Campaign_name
        FROM Dim_Calendar_Month C,
             Dim_Country Co,
             (SELECT DISTINCT Campaign_name, Country, Month_Num
              FROM MKT_Template_Spend
              WHERE Process_Flag = 'Y') P
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Co.Country = i_Country
          AND Co.Country = P.Country;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 20, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Campaign_Product
    SET Fiscal_Date = CONCAT(SUBSTRING(STR_TO_DATE(Year_Month_Num, '%Y%m'), 1, 7), '-01');

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Country,
                    Fiscal_Month,
                    SUM(Gross_Value_without_Tax) Sellout
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
             GROUP BY Country, Fiscal_Month) Q
        SET FDG.Sellout = Q.Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT P.Campaign_name, S.Country, S.Fiscal_Month, SUM(S.Gross_Value_without_Tax) Product_Sellout
             FROM Sellthru S,
                  Campaign_PC9 P
             WHERE S.Product_Code = P.Product_Code
             GROUP BY Country, Fiscal_Month, Campaign_name) Q
        SET FDG.Product_Sellout = Q.Product_Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Campaign_name = Q.Campaign_name;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT T.Country, T.Year_Month_Num, SUM(Traffic_Count) Traffic_Count
             FROM Traffic T,
                  Dim_Calendar DC
             WHERE T.Traffic_Date = DC.Fiscal_Date
             GROUP BY T.Country, T.Year_Month_Num) Q
        SET Traffic = Q.Traffic_Count
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Country,
                    Fiscal_Month + 100           Prev_Fiscal_Month,
                    SUM(Gross_Value_without_Tax) Sellout
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
             GROUP BY Country, Fiscal_Month) Q
        SET FDG.Prev_Sellout = Q.Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month;


        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT P.Campaign_name,
                    S.Country,
                    S.Fiscal_Month + 100           Prev_Fiscal_Month,
                    SUM(S.Gross_Value_without_Tax) Product_Sellout
             FROM Sellthru S,
                  Stg_Campaign_Product_Map P
             WHERE S.Product_Code = P.Product_Code
               AND S.Country = P.Country
             GROUP BY P.Campaign_name, Country, Prev_Fiscal_Month) Q
        SET FDG.Prev_Product_Sellout = Q.Product_Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month
          AND FDG.Campaign_name = Q.Campaign_name;

    ELSEIF i_Call_Type IN ('SUBMIT', 'APPROVE') THEN

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Country,
                    Fiscal_Month,
                    SUM(Gross_Value_without_Tax) Sellout
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
               AND S.Country = i_Country
               AND S.Fiscal_Month = i_Year_Month_Num
             GROUP BY Country, Fiscal_Month) Q
        SET FDG.Sellout = Q.Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT P.Campaign_name, S.Country, S.Fiscal_Month, SUM(S.Gross_Value_without_Tax) Product_Sellout
             FROM Sellthru S,
                  Campaign_PC9 P
             WHERE S.Product_Code = P.Product_Code
               AND S.Country = i_Country
               AND S.Fiscal_Month = i_Year_Month_Num
             GROUP BY Country, Fiscal_Month, Campaign_name) Q
        SET FDG.Product_Sellout = Q.Product_Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Fiscal_Month
          AND FDG.Campaign_name = Q.Campaign_name;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT T.Country, T.Year_Month_Num, SUM(Traffic_Count) Traffic_Count
             FROM Traffic T,
                  Dim_Calendar DC
             WHERE T.Traffic_Date = DC.Fiscal_Date
               AND T.Country = i_Country
               AND T.Year_Month_Num = i_Year_Month_Num
             GROUP BY T.Country, T.Year_Month_Num) Q
        SET Traffic = Q.Traffic_Count
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Year_Month_Num;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Country,
                    Fiscal_Month + 100           Prev_Fiscal_Month,
                    SUM(Gross_Value_without_Tax) Sellout
             FROM Sellthru S,
                  Dim_Customer D
             WHERE S.Customer_Code = D.Ship_to_Code
               AND S.Sales_Org = D.Sales_Org
               AND S.Country = i_Country
               AND S.Fiscal_Month = i_Year_Month_Num - 100
             GROUP BY Country, Fiscal_Month) Q
        SET FDG.Prev_Sellout = Q.Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month;

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT P.Campaign_name,
                    S.Country,
                    S.Fiscal_Month + 100           Prev_Fiscal_Month,
                    SUM(S.Gross_Value_without_Tax) Product_Sellout
             FROM Sellthru S,
                  Stg_Campaign_Product_Map P
             WHERE S.Product_Code = P.Product_Code
               AND S.Country = P.Country
               AND S.Country = i_Country
               AND S.Fiscal_Month = i_Year_Month_Num - 100
             GROUP BY P.Campaign_name, Country, Prev_Fiscal_Month) Q
        SET FDG.Prev_Product_Sellout = Q.Product_Sellout
        WHERE FDG.Country = Q.Country
          AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month
          AND FDG.Campaign_name = Q.Campaign_name;
    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Campaign_Product FDG,
        (SELECT T.Country, T.Year_Month_Num + 100 Prev_Fiscal_Month, SUM(Traffic_Count) Traffic_Count
         FROM Traffic T,
              Dim_Calendar DC
         WHERE T.Traffic_Date = DC.Fiscal_Date
         GROUP BY T.Country, T.Year_Month_Num) Q
    SET Prev_Traffic = Q.Traffic_Count
    WHERE FDG.Country = Q.Country
      AND FDG.Year_Month_Num = Q.Prev_Fiscal_Month;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 40, CURRENT_TIMESTAMP());

    IF i_Call_Type = 'SUBMIT' THEN

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Month_Num, Country, Campaign_name, SUM(Total_Engagement) Engagement
             FROM MKT_Template_Spend
             GROUP BY Month_Num, Country, Campaign_name) MTS
        SET FDG.Brand_Engagement = MTS.Engagement
        WHERE FDG.Year_Month_Num = MTS.Month_Num
          AND FDG.Country = MTS.Country
          AND FDG.Campaign_name = MTS.Campaign_name;

    ELSE

        UPDATE Stg_Fact_DB_Campaign_Product FDG,
            (SELECT Month_Num, Country, Campaign_name, SUM(Total_Engagement) Engagement
             FROM MKT_Template_Spend
             WHERE Process_Flag = 'Y'
             GROUP BY Month_Num, Country, Campaign_name) MTS
        SET FDG.Brand_Engagement = MTS.Engagement
        WHERE FDG.Year_Month_Num = MTS.Month_Num
          AND FDG.Country = MTS.Country
          AND FDG.Campaign_name = MTS.Campaign_name;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 50, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Campaign_Product FDG,
        (SELECT Country, Year_Month_Num + 100 Prev_Year_Month_Num, Campaign_name, Brand_Engagement
         FROM Stg_Fact_DB_Campaign_Product) Q
    SET FDG.Prev_Brand_Engagement = Q.Brand_Engagement
    WHERE FDG.Year_Month_Num = Q.Prev_Year_Month_Num
      AND FDG.Country = Q.Country
      AND FDG.Campaign_name = Q.Campaign_name;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 60, CURRENT_TIMESTAMP());

    IF i_Country IS NULL AND i_Year_Month_Num = 0 AND i_Call_Type IS NULL THEN

        TRUNCATE TABLE Fact_DB_Campaign_Product;
        INSERT INTO Fact_DB_Campaign_Product select * from Stg_Fact_DB_Campaign_Product;


    ELSEIF i_Call_Type IN ('SUBMIT', 'APPROVE') THEN

        DELETE
        FROM Fact_DB_Campaign_Product
        WHERE Fiscal_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

        INSERT INTO Fact_DB_Campaign_Product
        SELECT *
        FROM Stg_Fact_DB_Campaign_Product
        WHERE Year_Month_Num = i_Year_Month_Num
          AND Country = i_Country;

    END IF;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Campaign_Product', i_Call_Type, 70, CURRENT_TIMESTAMP());
    /* TRUNCATE TABLE Fact_DB_Campaign_Product;
    INSERT INTO  Fact_DB_Campaign_Product select * from Stg_Fact_DB_Campaign_Product;
    */
END;


