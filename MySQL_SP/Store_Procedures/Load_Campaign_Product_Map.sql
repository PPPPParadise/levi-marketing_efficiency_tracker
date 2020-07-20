create
    definer = gilbert@`%` procedure Load_Campaign_Produt_Map()
BEGIN
    INSERT INTO Campaign_Produt_Map (Campaign_name, Campaign_Start_Date, Campaign_End_Date, Product_ID)
    SELECT Stg_Campaign_Produt_Map.Campaign_name,
           Campaign_Start_Date,
           Campaign_End_Date,
           SUBSTRING_INDEX(SUBSTRING_INDEX(Stg_Campaign_Produt_Map.Product_ID_List, ';', Number_Record.Record_No), ';',
                           -1) P_ID
    FROM Number_Record
             INNER JOIN Stg_Campaign_Produt_Map
                        ON CHAR_LENGTH(Stg_Campaign_Produt_Map.Product_ID_List) -
                           CHAR_LENGTH(REPLACE(Stg_Campaign_Produt_Map.Product_ID_List, ';', '')) >=
                           Number_Record.Record_No - 1
    ORDER BY Stg_Campaign_Produt_Map.Campaign_name, Number_Record.Record_No;
END;


