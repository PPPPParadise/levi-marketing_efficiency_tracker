create
    definer = gilbert@`%` procedure Reject_Mkt_Template_Pr(IN i_Country varchar(30), IN i_Year_Month_Num int,
                                                           IN i_User varchar(30))
BEGIN
    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Mail_Info (Year_Month_Num, Country, Template_Type,
                           Mail_Type, Mail_Status, Created_By,
                           Updated_By)
    VALUES (i_Year_Month_Num, i_Country, NULL,
            'MKT_SPEND_REJECTED', 'N', i_User,
            i_User);
END;


