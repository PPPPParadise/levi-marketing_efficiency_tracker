create
    definer = kchaudhary@`%` procedure Load_Map_Medium_Category()
BEGIN

    /*LOAD DATA LOCAL INFILE 'D:\\Data\\2020_March\\Map_medium_Category.csv'
        INTO TABLE Stg_Map_Medium_Category
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY  '\n'    
        IGNORE 1 LINES;
        
        INSERT INTO  Map_Medium_Category(Com_Medium,Category)
        SELECT * FROM Stg_Map_Medium_Category  ; 
        
        
        
    DELETE from Map_Medium_Category where Com_Medium ='';
        */

END;


