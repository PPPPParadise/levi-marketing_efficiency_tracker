create definer = gilbert@`%` view DB_Competitor_Mentions_Sentiments as
select `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Region`             AS `Region`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Country`            AS `Country`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Quarter`     AS `Fiscal_Quarter`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Year_Num`    AS `Fiscal_Year_Num`,
       concat(`LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Month`, '-',
              substr(`LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Month_Num`, 3,
                     2))                                                           AS `Year_Month_Char`,
       case
           when `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Quarter` in ('Q1', 'Q2') then 'H1'
           else 'H2' end                                                           AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                        AS `Curr_Fiscal_Year`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Month_Num`   AS `Fiscal_Month_Num`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Month`       AS `Fiscal_Month`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Fiscal_Date`        AS `Fiscal_Date`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Competitor`         AS `Competitor`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Total_Mentions`     AS `Total_Mentions`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Weibo_Sentiment`    AS `Weibo_Sentiment`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Sentiment_Positive` AS `Sentiment_Positive`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Sentiment_Negative` AS `Sentiment_Negative`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Sentiment_Neutral`  AS `Sentiment_Neutral`,
       `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`.`Sentiment_Unknown`  AS `Sentiment_Unknown`,
       floor(rand() * 1000)                                                        AS `Organic_Search`
from `LEVIS_MET2`.`Fact_Dim_Competitor_Mentions_Sentiments`;


