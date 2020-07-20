create
    definer = gilbert@`%` procedure Approve_Mkt_Template_Pr(IN i_Country varchar(30), IN i_Year_Month_Num int,
                                                            IN i_User varchar(70), IN i_Template_Name varchar(300))
BEGIN

    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info
    (Job_Type, Year_Month_Num, Country,
     Template_Type, Job_Status, Approved_By,
     Created_By, Updated_By)
    VALUES ('Approve', i_Year_Month_Num, i_Country,
            i_Template_Name, 'N', i_User,
            i_User, i_User);

    COMMIT;

END;


