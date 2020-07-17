create definer = gilbert@`%` view DB_Social_Media_View as
select `FDG`.`Region`                                                           AS `Region`,
       `FDG`.`Country`                                                          AS `Country`,
       `FDG`.`Fiscal_Quarter`                                                   AS `Fiscal_Quarter`,
       `FDG`.`Fiscal_Year`                                                      AS `Fiscal_Year_Num`,
       concat(`FDG`.`Fiscal_Month`, '-',
              substr(`FDG`.`Year_Month_Num`, 3, 2))                             AS `Year_Month_Char`,
       case when `FDG`.`Fiscal_Quarter` in ('Q1', 'Q2') then 'H1' else 'H2' end AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                     AS `Curr_Fiscal_Year`,
       `FDG`.`Year_Month_Num`                                                   AS `Fiscal_Month_Num`,
       `FDG`.`Fiscal_Month`                                                     AS `Fiscal_Month`,
       `FDG`.`Social_Month`                                                     AS `Social_Month`,
       `FDG`.`Fiscal_Date`                                                      AS `Fiscal_Date`,
       case
           when `FDG`.`Facebook_Fans` = 0 then NULL
           else `FDG`.`Facebook_Fans` end                                       AS `Facebook_Fans`,
       case
           when `FDG`.`Prev_Facebook_Fans` = 0 then NULL
           else `FDG`.`Prev_Facebook_Fans` end                                  AS `Prev_Facebook_Fans`,
       case
           when `FDG`.`Prev_Year_Facebook_Fans` = 0 then NULL
           else `FDG`.`Prev_Year_Facebook_Fans` end                             AS `Prev_Year_Facebook_Fans`,
       case
           when `FDG`.`Facebook_Posts` = 0 then NULL
           else `FDG`.`Facebook_Posts` end                                      AS `Facebook_Posts`,
       case
           when `FDG`.`Prev_Facebook_Posts` = 0 then NULL
           else `FDG`.`Prev_Facebook_Posts` end                                 AS `Prev_Facebook_Posts`,
       case
           when `FDG`.`Prev_Year_Facebook_Posts` = 0 then NULL
           else `FDG`.`Prev_Year_Facebook_Posts` end                            AS `Prev_Year_Facebook_Posts`,
       case
           when `FDG`.`Facebook_Reactions` = 0 then NULL
           else `FDG`.`Facebook_Reactions` end                                  AS `Facebook_Reactions`,
       case
           when `FDG`.`Prev_Facebook_Reactions` = 0 then NULL
           else `FDG`.`Prev_Facebook_Reactions` end                             AS `Prev_Facebook_Reactions`,
       case
           when `FDG`.`Prev_Year_Facebook_Reactions` = 0 then NULL
           else `FDG`.`Prev_Year_Facebook_Reactions` end                        AS `Prev_Year_Facebook_Reactions`,
       case
           when `FDG`.`Facebook_Comments` = 0 then NULL
           else `FDG`.`Facebook_Comments` end                                   AS `Facebook_Comments`,
       case
           when `FDG`.`Prev_Facebook_Comments` = 0 then NULL
           else `FDG`.`Prev_Facebook_Comments` end                              AS `Prev_Facebook_Comments`,
       case
           when `FDG`.`Prev_Year_Facebook_Comments` = 0 then NULL
           else `FDG`.`Prev_Year_Facebook_Comments` end                         AS `Prev_Year_Facebook_Comments`,
       case
           when `FDG`.`Facebook_Shares` = 0 then NULL
           else `FDG`.`Facebook_Shares` end                                     AS `Facebook_Shares`,
       case
           when `FDG`.`Prev_Facebook_Shares` = 0 then NULL
           else `FDG`.`Prev_Facebook_Shares` end                                AS `Prev_Facebook_Shares`,
       case
           when `FDG`.`Prev_Year_Facebook_Shares` = 0 then NULL
           else `FDG`.`Prev_Year_Facebook_Shares` end                           AS `Prev_Year_Facebook_Shares`,
       case
           when `FDG`.`Twitter_Fans` = 0 then NULL
           else `FDG`.`Twitter_Fans` end                                        AS `Twitter_Fans`,
       case
           when `FDG`.`Prev_Twitter_Fans` = 0 then NULL
           else `FDG`.`Prev_Twitter_Fans` end                                   AS `Prev_Twitter_Fans`,
       case
           when `FDG`.`Prev_Year_Twitter_Fans` = 0 then NULL
           else `FDG`.`Prev_Year_Twitter_Fans` end                              AS `Prev_Year_Twitter_Fans`,
       case
           when `FDG`.`Twitter_Posts` = 0 then NULL
           else `FDG`.`Twitter_Posts` end                                       AS `Twitter_Posts`,
       case
           when `FDG`.`Prev_Twitter_Posts` = 0 then NULL
           else `FDG`.`Prev_Twitter_Posts` end                                  AS `Prev_Twitter_Posts`,
       case
           when `FDG`.`Prev_Year_Twitter_Posts` = 0 then NULL
           else `FDG`.`Prev_Year_Twitter_Posts` end                             AS `Prev_Year_Twitter_Posts`,
       case
           when `FDG`.`Twitter_Retweets` = 0 then NULL
           else `FDG`.`Twitter_Retweets` end                                    AS `Twitter_Retweets`,
       case
           when `FDG`.`Prev_Twitter_Retweets` = 0 then NULL
           else `FDG`.`Prev_Twitter_Retweets` end                               AS `Prev_Twitter_Retweets`,
       case
           when `FDG`.`Prev_Year_Twitter_Retweets` = 0 then NULL
           else `FDG`.`Prev_Year_Twitter_Retweets` end                          AS `Prev_Year_Twitter_Retweets`,
       case
           when `FDG`.`Twitter_Favorites` = 0 then NULL
           else `FDG`.`Twitter_Favorites` end                                   AS `Twitter_Favorites`,
       case
           when `FDG`.`Prev_Twitter_Favorites` = 0 then NULL
           else `FDG`.`Prev_Twitter_Favorites` end                              AS `Prev_Twitter_Favorites`,
       case
           when `FDG`.`Prev_Year_Twitter_Favorites` = 0 then NULL
           else `FDG`.`Prev_Year_Twitter_Favorites` end                         AS `Prev_Year_Twitter_Favorites`,
       case
           when `FDG`.`Instagram_Fans` = 0 then NULL
           else `FDG`.`Instagram_Fans` end                                      AS `Instagram_Fans`,
       case
           when `FDG`.`Prev_Instagram_Fans` = 0 then NULL
           else `FDG`.`Prev_Instagram_Fans` end                                 AS `Prev_Instagram_Fans`,
       case
           when `FDG`.`Prev_Year_Instagram_Fans` = 0 then NULL
           else `FDG`.`Prev_Year_Instagram_Fans` end                            AS `Prev_Year_Instagram_Fans`,
       case
           when `FDG`.`Instagram_Posts` = 0 then NULL
           else `FDG`.`Instagram_Posts` end                                     AS `Instagram_Posts`,
       case
           when `FDG`.`Prev_Instagram_Posts` = 0 then NULL
           else `FDG`.`Prev_Instagram_Posts` end                                AS `Prev_Instagram_Posts`,
       case
           when `FDG`.`Prev_Year_Instagram_Posts` = 0 then NULL
           else `FDG`.`Prev_Year_Instagram_Posts` end                           AS `Prev_Year_Instagram_Posts`,
       case
           when `FDG`.`Instagram_Likes` = 0 then NULL
           else `FDG`.`Instagram_Likes` end                                     AS `Instagram_Likes`,
       case
           when `FDG`.`Prev_Instagram_Likes` = 0 then NULL
           else `FDG`.`Prev_Instagram_Likes` end                                AS `Prev_Instagram_Likes`,
       case
           when `FDG`.`Prev_Year_Instagram_Likes` = 0 then NULL
           else `FDG`.`Prev_Year_Instagram_Likes` end                           AS `Prev_Year_Instagram_Likes`,
       case
           when `FDG`.`Instagram_Comments` = 0 then NULL
           else `FDG`.`Instagram_Comments` end                                  AS `Instagram_Comments`,
       case
           when `FDG`.`Prev_Instagram_Comments` = 0 then NULL
           else `FDG`.`Prev_Instagram_Comments` end                             AS `Prev_Instagram_Comments`,
       case
           when `FDG`.`Prev_Year_Instagram_Comments` = 0 then NULL
           else `FDG`.`Prev_Year_Instagram_Comments` end                        AS `Prev_Year_Instagram_Comments`,
       `FDG`.`Hastag1`                                                          AS `Hastag1`,
       `FDG`.`Hastag2`                                                          AS `Hastag2`,
       `FDG`.`Hastag3`                                                          AS `Hastag3`,
       `FDG`.`Hastag4`                                                          AS `Hastag4`,
       `FDG`.`Hastag5`                                                          AS `Hastag5`,
       `FDG`.`Hastag6`                                                          AS `Hastag6`,
       `FDG`.`Hastag7`                                                          AS `Hastag7`,
       `FDG`.`Hastag8`                                                          AS `Hastag8`,
       `FDG`.`Hastag9`                                                          AS `Hastag9`,
       `FDG`.`Hastag10`                                                         AS `Hastag10`,
       `FDG`.`Weibo_Followers`                                                  AS `Weibo_Followers`,
       `FDG`.`Prev_Weibo_Followers`                                             AS `Prev_Weibo_Followers`,
       `FDG`.`Weibo_Tweet`                                                      AS `Weibo_Tweet`,
       `FDG`.`Prev_Weibo_Tweet`                                                 AS `Prev_Weibo_Tweet`,
       `FDG`.`Weibo_Retweet`                                                    AS `Weibo_Retweet`,
       `FDG`.`Prev_Weibo_Retweet`                                               AS `Prev_Weibo_Retweet`,
       `FDG`.`Weibo_Comment`                                                    AS `Weibo_Comment`,
       `FDG`.`Prev_Weibo_Comment`                                               AS `Prev_Weibo_Comment`,
       `FDG`.`Weibo_Likes`                                                      AS `Weibo_Likes`,
       `FDG`.`Prev_Weibo_Likes`                                                 AS `Prev_Weibo_Likes`,
       `FDG`.`Weibo_Buzz`                                                       AS `Weibo_Buzz`,
       `FDG`.`Prev_Weibo_Buzz`                                                  AS `Prev_Weibo_Buzz`,
       `FDG`.`Weibo_Sentiment`                                                  AS `Weibo_Sentiment`,
       `FDG`.`Prev_Weibo_Sentiment`                                             AS `Prev_Weibo_Sentiment`,
       `FDG`.`Avg_view_top_3_articles`                                          AS `Avg_view_top_3_articles`,
       `FDG`.`Prev_Avg_view_top_3_articles`                                     AS `Prev_Avg_view_top_3_articles`,
       `FDG`.`Avg_like_top_3_articles`                                          AS `Avg_like_top_3_articles`,
       `FDG`.`Prev_Avg_like_top_3_articles`                                     AS `Prev_Avg_like_top_3_articles`,
       `FDG`.`Sentiment_Positive`                                               AS `Sentiment_Positive`,
       `FDG`.`Prev_Sentiment_Positive`                                          AS `Prev_Sentiment_Positive`,
       `FDG`.`Prev_Year_Sentiment_Positive`                                     AS `Prev_Year_Sentiment_Positive`,
       `FDG`.`Sentiment_Negative`                                               AS `Sentiment_Negative`,
       `FDG`.`Prev_Sentiment_Negative`                                          AS `Prev_Sentiment_Negative`,
       `FDG`.`Prev_Year_Sentiment_Negative`                                     AS `Prev_Year_Sentiment_Negative`,
       `FDG`.`Sentiment_Neutral`                                                AS `Sentiment_Neutral`,
       `FDG`.`Prev_Sentiment_Neutral`                                           AS `Prev_Sentiment_Neutral`,
       `FDG`.`Prev_Year_Sentiment_Neutral`                                      AS `Prev_Year_Sentiment_Neutral`,
       `FDG`.`Sentiment_Unknown`                                                AS `Sentiment_Unknown`,
       `FDG`.`Prev_Sentiment_Unknown`                                           AS `Prev_Sentiment_Unknown`,
       `FDG`.`Prev_Year_Sentiment_Unknown`                                      AS `Prev_Year_Sentiment_Unknown`,
       `FDG`.`Total_Mentions_Count`                                             AS `Total_Mentions_Count`,
       `FDG`.`Prev_Year_Total_Mentions_Count`                                   AS `Prev_Year_Total_Mentions_Count`,
       `FDG`.`Dockers_Sentiment_Positive`                                       AS `Dockers_Sentiment_Positive`,
       `FDG`.`Prev_Dockers_Sentiment_Positive`                                  AS `Prev_Dockers_Sentiment_Positive`,
       `FDG`.`Dockers_Sentiment_Negative`                                       AS `Dockers_Sentiment_Negative`,
       `FDG`.`Prev_Dockers_Sentiment_Negative`                                  AS `Prev_Dockers_Sentiment_Negative`,
       `FDG`.`Dockers_Sentiment_Neutral`                                        AS `Dockers_Sentiment_Neutral`,
       `FDG`.`Prev_Dockers_Sentiment_Neutral`                                   AS `Prev_Dockers_Sentiment_Neutral`,
       `FDG`.`Dockers_Sentiment_Unknown`                                        AS `Dockers_Sentiment_Unknown`,
       `FDG`.`Prev_Dockers_Sentiment_Unknown`                                   AS `Prev_Dockers_Sentiment_Unknown`,
       `FDG`.`Dockers_Total_Mentions_Count`                                     AS `Dockers_Total_Mentions_Count`,
       `FDG`.`Prev_Dockers_Total_Mentions_Count`                                AS `Prev_Dockers_Total_Mentions_Count`,
       `FDG`.`Zara_Sentiment_Positive`                                          AS `Zara_Sentiment_Positive`,
       `FDG`.`Prev_Zara_Sentiment_Positive`                                     AS `Prev_Zara_Sentiment_Positive`,
       `FDG`.`Zara_Sentiment_Negative`                                          AS `Zara_Sentiment_Negative`,
       `FDG`.`Prev_Zara_Sentiment_Negative`                                     AS `Prev_Zara_Sentiment_Negative`,
       `FDG`.`Zara_Sentiment_Neutral`                                           AS `Zara_Sentiment_Neutral`,
       `FDG`.`Prev_Zara_Sentiment_Neutral`                                      AS `Prev_Zara_Sentiment_Neutral`,
       `FDG`.`Zara_Sentiment_Unknown`                                           AS `Zara_Sentiment_Unknown`,
       `FDG`.`Prev_Zara_Sentiment_Unknown`                                      AS `Prev_Zara_Sentiment_Unknown`,
       `FDG`.`Zara_Total_Mentions_Count`                                        AS `Zara_Total_Mentions_Count`,
       `FDG`.`Prev_Zara_Total_Mentions_Count`                                   AS `Prev_Zara_Total_Mentions_Count`,
       `FDG`.`Uniqlo_Sentiment_Positive`                                        AS `Uniqlo_Sentiment_Positive`,
       `FDG`.`Prev_Uniqlo_Sentiment_Positive`                                   AS `Prev_Uniqlo_Sentiment_Positive`,
       `FDG`.`Uniqlo_Sentiment_Negative`                                        AS `Uniqlo_Sentiment_Negative`,
       `FDG`.`Prev_Uniqlo_Sentiment_Negative`                                   AS `Prev_Uniqlo_Sentiment_Negative`,
       `FDG`.`Uniqlo_Sentiment_Neutral`                                         AS `Uniqlo_Sentiment_Neutral`,
       `FDG`.`Prev_Uniqlo_Sentiment_Neutral`                                    AS `Prev_Uniqlo_Sentiment_Neutral`,
       `FDG`.`Uniqlo_Sentiment_Unknown`                                         AS `Uniqlo_Sentiment_Unknown`,
       `FDG`.`Prev_Uniqlo_Sentiment_Unknown`                                    AS `Prev_Uniqlo_Sentiment_Unknown`,
       `FDG`.`Uniqlo_Total_Mentions_Count`                                      AS `Uniqlo_Total_Mentions_Count`,
       `FDG`.`Prev_Uniqlo_Total_Mentions_Count`                                 AS `Prev_Uniqlo_Total_Mentions_Count`,
       `FDG`.`HM_Sentiment_Positive`                                            AS `HM_Sentiment_Positive`,
       `FDG`.`Prev_HM_Sentiment_Positive`                                       AS `Prev_HM_Sentiment_Positive`,
       `FDG`.`HM_Sentiment_Negative`                                            AS `HM_Sentiment_Negative`,
       `FDG`.`Prev_HM_Sentiment_Negative`                                       AS `Prev_HM_Sentiment_Negative`,
       `FDG`.`HM_Sentiment_Neutral`                                             AS `HM_Sentiment_Neutral`,
       `FDG`.`Prev_HM_Sentiment_Neutral`                                        AS `Prev_HM_Sentiment_Neutral`,
       `FDG`.`HM_Sentiment_Unknown`                                             AS `HM_Sentiment_Unknown`,
       `FDG`.`Prev_HM_Sentiment_Unknown`                                        AS `Prev_HM_Sentiment_Unknown`,
       `FDG`.`HM_Total_Mentions_Count`                                          AS `HM_Total_Mentions_Count`,
       `FDG`.`Prev_HM_Total_Mentions_Count`                                     AS `Prev_HM_Total_Mentions_Count`,
       `FDG`.`Guess_Sentiment_Positive`                                         AS `Guess_Sentiment_Positive`,
       `FDG`.`Prev_Guess_Sentiment_Positive`                                    AS `Prev_Guess_Sentiment_Positive`,
       `FDG`.`Guess_Sentiment_Negative`                                         AS `Guess_Sentiment_Negative`,
       `FDG`.`Prev_Guess_Sentiment_Negative`                                    AS `Prev_Guess_Sentiment_Negative`,
       `FDG`.`Guess_Sentiment_Neutral`                                          AS `Guess_Sentiment_Neutral`,
       `FDG`.`Prev_Guess_Sentiment_Neutral`                                     AS `Prev_Guess_Sentiment_Neutral`,
       `FDG`.`Guess_Sentiment_Unknown`                                          AS `Guess_Sentiment_Unknown`,
       `FDG`.`Prev_Guess_Sentiment_Unknown`                                     AS `Prev_Guess_Sentiment_Unknown`,
       `FDG`.`Guess_Total_Mentions_Count`                                       AS `Guess_Total_Mentions_Count`,
       `FDG`.`Prev_Guess_Total_Mentions_Count`                                  AS `Prev_Guess_Total_Mentions_Count`,
       `FDG`.`Diesel_Sentiment_Positive`                                        AS `Diesel_Sentiment_Positive`,
       `FDG`.`Prev_Diesel_Sentiment_Positive`                                   AS `Prev_Diesel_Sentiment_Positive`,
       `FDG`.`Diesel_Sentiment_Negative`                                        AS `Diesel_Sentiment_Negative`,
       `FDG`.`Prev_Diesel_Sentiment_Negative`                                   AS `Prev_Diesel_Sentiment_Negative`,
       `FDG`.`Diesel_Sentiment_Neutral`                                         AS `Diesel_Sentiment_Neutral`,
       `FDG`.`Prev_Diesel_Sentiment_Neutral`                                    AS `Prev_Diesel_Sentiment_Neutral`,
       `FDG`.`Diesel_Sentiment_Unknown`                                         AS `Diesel_Sentiment_Unknown`,
       `FDG`.`Prev_Diesel_Sentiment_Unknown`                                    AS `Prev_Diesel_Sentiment_Unknown`,
       `FDG`.`Diesel_Total_Mentions_Count`                                      AS `Diesel_Total_Mentions_Count`,
       `FDG`.`Prev_Diesel_Total_Mentions_Count`                                 AS `Prev_Diesel_Total_Mentions_Count`,
       `FDG`.`Calvin_Klein_Sentiment_Positive`                                  AS `Calvin_Klein_Sentiment_Positive`,
       `FDG`.`Prev_Calvin_Klein_Sentiment_Positive`                             AS `Prev_Calvin_Klein_Sentiment_Positive`,
       `FDG`.`Calvin_Klein_Sentiment_Negative`                                  AS `Calvin_Klein_Sentiment_Negative`,
       `FDG`.`Prev_Calvin_Klein_Sentiment_Negative`                             AS `Prev_Calvin_Klein_Sentiment_Negative`,
       `FDG`.`Calvin_Klein_Sentiment_Neutral`                                   AS `Calvin_Klein_Sentiment_Neutral`,
       `FDG`.`Prev_Calvin_Klein_Sentiment_Neutral`                              AS `Prev_Calvin_Klein_Sentiment_Neutral`,
       `FDG`.`Calvin_Klein_Sentiment_Unknown`                                   AS `Calvin_Klein_Sentiment_Unknown`,
       `FDG`.`Prev_Calvin_Klein_Sentiment_Unknown`                              AS `Prev_Calvin_Klein_Sentiment_Unknown`,
       `FDG`.`Calvin_Klein_Total_Mentions_Count`                                AS `Calvin_Klein_Total_Mentions_Count`,
       `FDG`.`Prev_Calvin_Klein_Total_Mentions_Count`                           AS `Prev_Calvin_Klein_Total_Mentions_Count`,
       `FDG`.`Edwin_Sentiment_Positive`                                         AS `Edwin_Sentiment_Positive`,
       `FDG`.`Prev_Edwin_Sentiment_Positive`                                    AS `Prev_Edwin_Sentiment_Positive`,
       `FDG`.`Edwin_Sentiment_Negative`                                         AS `Edwin_Sentiment_Negative`,
       `FDG`.`Prev_Edwin_Sentiment_Negative`                                    AS `Prev_Edwin_Sentiment_Negative`,
       `FDG`.`Edwin_Sentiment_Neutral`                                          AS `Edwin_Sentiment_Neutral`,
       `FDG`.`Prev_Edwin_Sentiment_Neutral`                                     AS `Prev_Edwin_Sentiment_Neutral`,
       `FDG`.`Edwin_Sentiment_Unknown`                                          AS `Edwin_Sentiment_Unknown`,
       `FDG`.`Prev_Edwin_Sentiment_Unknown`                                     AS `Prev_Edwin_Sentiment_Unknown`,
       `FDG`.`Edwin_Total_Mentions_Count`                                       AS `Edwin_Total_Mentions_Count`,
       `FDG`.`Prev_Edwin_Total_Mentions_Count`                                  AS `Prev_Edwin_Total_Mentions_Count`,
       `FDG`.`Blogs`                                                            AS `Blogs`,
       `FDG`.`Broadcast`                                                        AS `Broadcast`,
       `FDG`.`Facebook`                                                         AS `Facebook`,
       `FDG`.`Instagram`                                                        AS `Instagram`,
       `FDG`.`Lexis_nexis`                                                      AS `Lexis_nexis`,
       `FDG`.`News`                                                             AS `News`,
       `FDG`.`Twitter`                                                          AS `Twitter`,
       `FDG`.`Levis_Organic_Search`                                             AS `Levis_Organic_Search`,
       `FDG`.`Prev_Levis_Organic_Search`                                        AS `Prev_Levis_Organic_Search`,
       `FDG`.`Dockers_Organic_Search`                                           AS `Dockers_Organic_Search`,
       `FDG`.`Prev_Dockers_Organic_Search`                                      AS `Prev_Dockers_Organic_Search`,
       `FDG`.`Zara_Organic_Search`                                              AS `Zara_Organic_Search`,
       `FDG`.`Prev_Zara_Organic_Search`                                         AS `Prev_Zara_Organic_Search`,
       `FDG`.`Uniqlo_Organic_Search`                                            AS `Uniqlo_Organic_Search`,
       `FDG`.`Prev_Uniqlo_Organic_Search`                                       AS `Prev_Uniqlo_Organic_Search`,
       `FDG`.`HM_Organic_Search`                                                AS `HM_Organic_Search`,
       `FDG`.`Prev_HM_Organic_Search`                                           AS `Prev_HM_Organic_Search`,
       `FDG`.`Guess_Organic_Search`                                             AS `Guess_Organic_Search`,
       `FDG`.`Prev_Guess_Organic_Search`                                        AS `Prev_Guess_Organic_Search`,
       `FDG`.`Diesel_Organic_Search`                                            AS `Diesel_Organic_Search`,
       `FDG`.`Prev_Diesel_Organic_Search`                                       AS `Prev_Diesel_Organic_Search`,
       `FDG`.`CalvinKlein_Organic_Search`                                       AS `CalvinKlein_Organic_Search`,
       `FDG`.`Prev_CalvinKlein_Organic_Search`                                  AS `Prev_CalvinKlein_Organic_Search`,
       `FDG`.`Edwin_Organic_Search`                                             AS `Edwin_Organic_Search`,
       `FDG`.`Prev_Edwin_Organic_Search`                                        AS `Prev_Edwin_Organic_Search`
from `LEVIS_MET2`.`Fact_DB_Social` `FDG`;


