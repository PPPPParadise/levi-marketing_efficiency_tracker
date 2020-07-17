create
    definer = gilbert@`%` procedure Load_Dim_Exchange_Rate()
BEGIN
    /*
    LOAD DATA LOCAL INFILE 'D:\\Data\\2018_December\\MET_ExchangeRate_09012019.txt'
        INTO TABLE Dim_Exchange_Rate
        FIELDS TERMINATED BY '|'
        OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY  '\n'
        IGNORE 1 lines
        (@Exchange_Rate_Type, @From_Currency, @To_Currency, @USD_Planned_Rate, @Exch_Rate_Effect_Date)
        
        SET Exchange_Rate_Type = Replace(@Exchange_Rate_Type,'\0',''),
        From_Currency = Replace(@From_Currency,'\0',''),
        To_Currency = Replace(@To_Currency,'\0',''),
        USD_Planned_Rate = Replace(@USD_Planned_Rate,'\0',''),
        Exch_Rate_Effect_Date = Replace(@Exch_Rate_Effect_Date,'\0','');
    */
    UPDATE Dim_Exchange_Rate D, Map_CompanyCode_Country M
    SET D.Country = M.Country
    WHERE M.Currency_Code = D.From_Currency;

END;


