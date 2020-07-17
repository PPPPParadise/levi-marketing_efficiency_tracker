create
    definer = kchaudhary@`%` procedure Pop_Fact_Competitor_Mentions_Sentiments(IN i_Job_ID int)
BEGIN

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Competitor_Mentions_Sentiments', NULL, 0, CURRENT_TIMESTAMP());

    TRUNCATE TABLE Stg_Dim_Competitor_Mentions_Sentiments;

    INSERT INTO Stg_Dim_Competitor_Mentions_Sentiments(Region, Country, Fiscal_Quarter, Fiscal_Year_Num,
                                                       Curr_Fiscal_Year, Fiscal_Month_Num, Fiscal_Month,
                                                       Competitor, Total_Mentions, Sentiment_Positive,
                                                       Sentiment_Negative, Sentiment_Neutral, Sentiment_Unknown)
    SELECT C.Region,
           DSB.Country,
           DC.Fiscal_Quarter,
           DC.Fiscal_Year,
           CURR_FISCAL_YEAR(),
           DC.Year_Month_Num,
           DC.Fiscal_Month,
           Brand_Name,
           SUM(Total_Mentions_Count),
           SUM(Sentiment_Positive),
           SUM(Sentiment_Negative),
           SUM(Sentiment_Neutral),
           SUM(Sentiment_Unknown)
    FROM Zignal_Data_Sentiment_Breakdown DSB
             INNER JOIN Dim_Country C ON DSB.Country = C.Country
             INNER JOIN Dim_Calendar DC ON DSB.Start_Date = DC.Fiscal_Date
    WHERE DSB.Country != 'China'
      AND DSB.Start_Date >= '2017-12-01'
    GROUP BY C.Country, DC.Year_Month_Num, Brand_Name;


    INSERT INTO Stg_Dim_Competitor_Mentions_Sentiments(Region, Country, Fiscal_Quarter, Fiscal_Year_Num,
                                                       Curr_Fiscal_Year, Fiscal_Month_Num, Fiscal_Month,
                                                       Competitor, Total_Mentions, Sentiment_Positive,
                                                       Sentiment_Negative, Sentiment_Neutral)
    SELECT C.Region,
           PSB.Country,
           DC.Fiscal_Quarter,
           DC.Fiscal_Year,
           CURR_FISCAL_YEAR(),
           DC.Year_Month_Num,
           DC.Fiscal_Month,
           Brand_Name,
           Total_Mentions,
           Total_Positive,
           Total_Negative,
           Total_Neutral
    FROM Pulsar_Sentiment PSB
             INNER JOIN Dim_Country C ON PSB.Country = C.Country
             INNER JOIN Dim_Calendar DC ON PSB.Year_Month_Num = DC.Year_Month_Num
    WHERE PSB.Country != 'China'
    GROUP BY C.Country, DC.Year_Month_Num, Brand_Name;


    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Competitor_Mentions_Sentiments', NULL, 10, CURRENT_TIMESTAMP());

    INSERT INTO Stg_Dim_Competitor_Mentions_Sentiments(Region, Country, Fiscal_Quarter, Fiscal_Year_Num,
                                                       Curr_Fiscal_Year, Fiscal_Month_Num,
                                                       Fiscal_Month, Competitor, Total_Mentions, Weibo_Sentiment)
    SELECT Region,
           Country,
           Fiscal_Quarter,
           Fiscal_Year,
           CURR_FISCAL_YEAR()    AS Curr_Fiscal_Year,
           Year_Month_Num,
           Fiscal_Month,
           Competitor,
           Weibo_Buzz            AS Mentions,
           Weibo_Sentiment / 100 AS Sentiment
    FROM Stg_Fact_DB_Social_China1;

    UPDATE Stg_Dim_Competitor_Mentions_Sentiments
    SET Fiscal_Date =
            CONCAT(SUBSTRING(STR_TO_DATE(Fiscal_Month_Num, '%Y%m'), 1, 7), '-01');

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Competitor_Mentions_Sentiments', NULL, 20, CURRENT_TIMESTAMP());

    TRUNCATE TABLE Fact_Dim_Competitor_Mentions_Sentiments;
    INSERT INTO Fact_Dim_Competitor_Mentions_Sentiments SELECT * FROM Stg_Dim_Competitor_Mentions_Sentiments;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_Competitor_Mentions_Sentiments', NULL, 30, CURRENT_TIMESTAMP());

END;


