create
    definer = pkishlay@`%` procedure Submit_Mkt_Template_Pr(IN i_Country varchar(30), IN i_Year_Month_Num int,
                                                            IN i_Template_Type varchar(40), IN i_User varchar(30))
BEGIN
    SET SQL_SAFE_UPDATES = 0;


    INSERT INTO Job_Info
    (Job_Type, Year_Month_Num, Country,
     Template_Type, Job_Status, Uploaded_By,
     Created_By, Updated_By)
    VALUES ('Upload', i_Year_Month_Num, i_Country,
            i_Template_Type, 'N', i_User,
            i_User, i_User);


    COMMIT;
END;


