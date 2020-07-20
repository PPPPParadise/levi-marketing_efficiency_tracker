create
    definer = gilbert@`%` procedure Load_Campaign_Mapping()
BEGIN
    /*
     Truncate table Stg_Campaign_Mapping;
     
     load data local infile 'D:\\Data\\2019_April\\Marketing Template\\To Load\\Campaign_Mapping_Updated.csv'
            into table `Stg_Campaign_Mapping`
            fields terminated by ',' 
            OPTIONALLY ENCLOSED BY '"'
            ESCAPED BY '"'
            LINES TERMINATED BY '\r\n'
            IGNORE 1 LINES
            (@Type_of_Campaign, @New_Type_of_Campaign, @Campaign_name, @New_Campaign_Name, @Campaign_name_final, @Country)
            SET Type_of_Campaign = @Type_of_Campaign, New_Type_of_Campaign = @New_Type_of_Campaign, 
            Campaign_name = @Campaign_name, New_Campaign_Name = @New_Campaign_Name, Country= @Country;
            
    select * from Stg_Campaign_Mapping ; 
    
    INSERT INTO  Campaign_Mapping (Type_of_Campaign_Old, Type_of_Campaign_New, Campaign_name_Old, Campaign_name_New, Campaign_name_Final , Country)
    SELECT Type_of_Campaign, New_Type_of_Campaign, NULL, Campaign_name, New_Campaign_Name, Country
    FROM Stg_Campaign_Mapping  ; 
    
    
    select * from Campaign_Mapping  where Created_Date >= '2019-05-16'
    
    */
END;


