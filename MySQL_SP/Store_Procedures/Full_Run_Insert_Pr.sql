create
    definer = gilbert@`%` procedure Full_Run_Insert_Pr()
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    INSERT INTO `LEVIS_MET2`.`Job_Info`
    (`Job_Type`,
     `Year_Month_Num`,
     `Country`,
     `Template_Type`,
     `Job_Status`,
     `Uploaded_By`,
     `Approved_By`,
     `Created_By`,
     `Updated_By`)
    VALUES ('Full_Run',
            DATE_FORMAT(CURRENT_DATE(), '%Y%m'),
            'ALL',
            'ALL',
            'N',
            SUBSTR(USER(), 1, 65),
            SUBSTR(USER(), 1, 65),
            SUBSTR(USER(), 1, 65),
            SUBSTR(USER(), 1, 65));
    COMMIT;
END;


