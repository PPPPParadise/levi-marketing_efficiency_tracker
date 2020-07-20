create
    definer = gchand@`%` procedure Load_ECom_Campaign_Mapping()
BEGIN

    -- select distinct Campaign,NULL Campaign_new, Country from Stg_Fact_DB_ECom where Year_Month_Num = 201904;
-- Truncate Stg_ECom_Campaign_Mapping
/*
LOAD DATA LOCAL INFILE 'D:\\Data\\2019_March\\Ecomm_Mapping.csv'
	INTO TABLE Stg_ECom_Campaign_Mapping
	FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'    
	IGNORE 1 LINES;
    
    insert into ECom_Campaign_Mapping(Campaign_Old,Campaign_New,Country)
	select * from Stg_ECom_Campaign_Mapping

    */


END;


