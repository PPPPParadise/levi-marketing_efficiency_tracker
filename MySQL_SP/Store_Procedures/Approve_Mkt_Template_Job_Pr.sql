create
    definer = gilbert@`%` procedure Approve_Mkt_Template_Job_Pr(IN i_Job_ID int, IN i_Country varchar(30),
                                                                IN i_Year_Month_Num int, IN i_User varchar(70),
                                                                IN i_Template_Name varchar(300))
BEGIN
    DECLARE v_Template_Name VARCHAR(300);

    SET SQL_SAFE_UPDATES = 0;

    SET v_Template_Name = REPLACE(i_Template_Name, ',', ''',''');

    SET @v_Query_Stmt = CONCAT('UPDATE MKT_Template_Spend
			SET Process_Flag = ''Y'' ,
            Approved_By = ''', i_User, '''
			WHERE Country = ''', i_Country, ''' AND
				Month_Num = ', i_Year_Month_Num, ' AND
				Template_Name IN (''', v_Template_Name, ''')');

    PREPARE Query_Stmt FROM @v_Query_Stmt;
    EXECUTE Query_Stmt;


    CALL Pop_Fact_Campaign(i_Job_ID, i_Country, i_Year_Month_Num, 'APPROVE');

    CALL Pop_Fact_DB_CRM(i_Job_ID, i_Country, i_Year_Month_Num, 'APPROVE');

    /*CALL Pop_Fact_DB_ECom();

    CALL Pop_Fact_DB_Social();

    CALL Pop_Fact_DB_Social_China(); */

    /* CALL Pop_Fact_DB_Global(i_Country, i_Year_Month_Num, 'APPROVE');*/

    CALL Pop_Fact_Sellthru_Traffic(i_Job_ID, i_Country, i_Year_Month_Num, 'APPROVE');

    /*CALL Pop_Fact_Competitor_Mentions_Sentiments(); */

    CALL Pop_Fact_DB_Campaign_Product(i_Job_ID, i_Country, i_Year_Month_Num, 'APPROVE');

    CALL Pop_Campaign_Performance(i_Job_ID, i_Country, i_Year_Month_Num, 'APPROVE');

END;


