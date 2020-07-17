create
    definer = gilbert@`%` procedure Pop_All_Fact_Tables()
BEGIN

    CALL Pop_Fact_Campaign();

    CALL Pop_Fact_DB_CRM();

    CALL Pop_Fact_DB_ECom();

    CALL Pop_Fact_DB_Social();

    CALL Pop_Fact_DB_Social_China();

    CALL Pop_Fact_DB_Global();

    CALL Pop_Fact_Competitor_Mentions_Sentiments();

    CALL Pop_Fact_DB_Campaign_Product();

    CALL Pop_Campaign_Performance();

-- LEVIS.DEV Fact tables----------------------

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Campaign;
    INSERT INTO LEVIS_DEV.Fact_DB_Campaign SELECT * FROM LEVIS.Stg_Fact_Campaign;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_CRM;
    INSERT INTO LEVIS_DEV.Fact_DB_CRM SELECT * FROM LEVIS.Stg_Fact_DB_CRM;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_ECom;
    INSERT INTO LEVIS_DEV.Fact_DB_ECom SELECT * FROM LEVIS.Stg_Fact_DB_ECom;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Social;
    INSERT INTO LEVIS_DEV.Fact_DB_Social SELECT * FROM LEVIS.Stg_Fact_DB_Social;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Social_China1;
    INSERT INTO LEVIS_DEV.Fact_DB_Social_China1 SELECT * FROM LEVIS.Stg_Fact_DB_Social_China1;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Global;
    INSERT INTO LEVIS_DEV.Fact_DB_Global SELECT * FROM LEVIS.Stg_Fact_DB_Global;

    TRUNCATE TABLE LEVIS_DEV.Fact_Dim_Competitor_Mentions_Sentiments;
    INSERT INTO LEVIS_DEV.Fact_Dim_Competitor_Mentions_Sentiments
    SELECT *
    FROM LEVIS.Stg_Dim_Competitor_Mentions_Sentiments;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Campaign_Product;
    INSERT INTO LEVIS_DEV.Fact_DB_Campaign_Product SELECT * FROM LEVIS.Stg_Fact_DB_Campaign_Product;

    TRUNCATE TABLE LEVIS_DEV.Fact_Campaign_Performance;
    INSERT INTO LEVIS_DEV.Fact_Campaign_Performance SELECT * FROM LEVIS.Stg_Campaign_Performance;

    TRUNCATE TABLE LEVIS_DEV.Fact_Social_Media;
    INSERT INTO LEVIS_DEV.Fact_Social_Media SELECT * from LEVIS.Fact_Social_Media;

    TRUNCATE TABLE LEVIS_DEV.Fact_DB_Social_China1;
    INSERT INTO LEVIS_DEV.Fact_DB_Social_China1 select * from LEVIS.Stg_Fact_DB_Social_China1;

-- LEVIS Fact Tables --------------------------------

    TRUNCATE TABLE LEVIS.Fact_DB_Campaign;
    INSERT INTO LEVIS.Fact_DB_Campaign SELECT * FROM LEVIS.Stg_Fact_Campaign;

    TRUNCATE TABLE LEVIS.Fact_DB_CRM;
    INSERT INTO LEVIS.Fact_DB_CRM SELECT * FROM LEVIS.Stg_Fact_DB_CRM;

    TRUNCATE TABLE LEVIS.Fact_DB_ECom;
    INSERT INTO LEVIS.Fact_DB_ECom SELECT * FROM LEVIS.Stg_Fact_DB_ECom;

    TRUNCATE TABLE LEVIS.Fact_DB_Social;
    INSERT INTO LEVIS.Fact_DB_Social SELECT * FROM LEVIS.Stg_Fact_DB_Social;

    TRUNCATE TABLE LEVIS.Fact_DB_Social_China1;
    INSERT INTO LEVIS.Fact_DB_Social_China1 SELECT * FROM LEVIS.Stg_Fact_DB_Social_China1;

    TRUNCATE TABLE LEVIS.Fact_DB_Global;
    INSERT INTO LEVIS.Fact_DB_Global SELECT * FROM LEVIS.Stg_Fact_DB_Global;

    TRUNCATE TABLE LEVIS.Fact_Dim_Competitor_Mentions_Sentiments;
    INSERT INTO LEVIS.Fact_Dim_Competitor_Mentions_Sentiments
    SELECT *
    FROM LEVIS.Stg_Dim_Competitor_Mentions_Sentiments;

    TRUNCATE TABLE LEVIS.Fact_DB_Campaign_Product;
    INSERT INTO LEVIS.Fact_DB_Campaign_Product SELECT * FROM LEVIS.Stg_Fact_DB_Campaign_Product;

    TRUNCATE TABLE LEVIS.Fact_Campaign_Performance;
    INSERT INTO LEVIS.Fact_Campaign_Performance SELECT * FROM LEVIS.Stg_Campaign_Performance;

    TRUNCATE TABLE LEVIS.Fact_DB_Social_China1;
    INSERT INTO LEVIS.Fact_DB_Social_China1 select * from LEVIS.Stg_Fact_DB_Social_China1;

END;


