create
    definer = gilbert@`%` procedure Full_Run_Pr(IN i_Job_ID int)
BEGIN

    CALL Pop_Fact_Campaign(i_Job_ID, NULL, 0, NULL);

    CALL Pop_Fact_DB_CRM(i_Job_ID, NULL, 0, NULL);

    CALL Pop_Fact_DB_ECom(i_Job_ID);

    CALL Pop_Fact_DB_Social(i_Job_ID);

    CALL Pop_Fact_DB_Social_China(i_Job_ID);


    CALL Pop_Fact_Sellthru_Traffic(i_Job_ID, 'ALL', 0, 'ALL');

    CALL Pop_Fact_Competitor_Mentions_Sentiments(i_Job_ID);

    CALL Pop_Fact_DB_Campaign_Product(i_Job_ID, NULL, 0, NULL);

    CALL Pop_Campaign_Performance(i_Job_ID, NULL, 0, NULL);

END;


