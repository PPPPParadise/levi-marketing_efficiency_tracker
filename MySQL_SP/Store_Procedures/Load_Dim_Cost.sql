create
    definer = gilbert@`%` procedure Load_Dim_Cost()
BEGIN
    /*
    Truncate table Stg_MET_Cost;
    load data local infile 'C:\\Raw_Data\\gopi-test-data\\Other_Country\\MET_Cost_All_Affiliates_Except_MYRM.txt'
    into table `Stg_MET_Cost`
    FIELDS TERMINATED BY '|'
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES
    
    (@Product_Code, @Sales_Org, @Standard_Cost, @Valid_From, @Valid_To)
    
    Set Product_Code= REPLACE(@Product_Code, '\0',''),
        Sales_Org= REPLACE(@Sales_Org, '\0',''),
        Standard_Cost= REPLACE(@Standard_Cost, '\0',''),
        Valid_From= REPLACE(@Valid_From, '\0',''),
        Valid_To= REPLACE(@Valid_To, '\0','')
       ;
       */
    Update Stg_MET_Cost S, Map_CompanyCode_Country M
    Set S.Sales_Org = M.Sales_Org
    where Replace(S.Sales_Org, '000', '0') = M.Company_Number;

    INSERT INTO Dim_Cost(Product_Code, Sales_Org, Standard_Cost, Valid_From, Valid_To)

    SELECT Product_Code, Sales_Org, Standard_Cost, Valid_From, Valid_To
    FROM Stg_MET_Cost

    ON DUPLICATE KEY UPDATE Dim_Cost.Sales_Org = S.Sales_Org;

END;


