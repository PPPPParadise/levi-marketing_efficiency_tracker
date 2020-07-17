create
    definer = pkishlay@`%` procedure Load_Campaign_PC9()
BEGIN
    /*
    
    truncate table Stg_Campaign_PC9
    
    LOAD DATA LOCAL INFILE 'D:\\Data\\2019_February\\Big Bets Live View.csv'
        INTO TABLE Stg_Campaign_PC9
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY  '\n'    
        IGNORE 1 LINES;
        
    insert into Campaign_PC9(Campaign_Name,Product_Code) 
    select Seasonal_Story, Product_Code from Stg_Campaign_PC9
    ON DUPLICATE KEY update Campaign_PC9.Product_Name =  Stg_Campaign_PC9.Product_Description;
        */

/*
insert into Campaign_PC9(Campaign_Name,Product_Code)
Select Concat(Seasonal_Story,' ','H1'),Product_Code from Stg_Campaign_PC9
union 
Select Concat(Seasonal_Story,' ','H2'),Product_Code from Stg_Campaign_PC9;
*/

END;


