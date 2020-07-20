create
    definer = kchaudhary@`%` procedure Pop_Fact_DB_Social(IN i_Job_ID int)
BEGIN
    SET SQL_SAFE_UPDATES = 0;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 0, CURRENT_TIMESTAMP());

    TRUNCATE TABLE Stg_Fact_DB_Social;

    INSERT INTO Stg_Fact_DB_Social (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region)
    SELECT DISTINCT Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region
    FROM Dim_Calendar_Month,
         Dim_Country
    WHERE Year_Month_Num BETWEEN '201612' AND DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y%m')
    ORDER BY Year_Month_Num;
    COMMIT;

    UPDATE Stg_Fact_DB_Social
    SET Fiscal_Date =
            CONCAT(SUBSTRING(STR_TO_DATE(Year_Month_Num, '%Y%m'), 1, 7), '-01');

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 10, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF, MKT_Template_Social MTS
    SET SF.Social_Month            = MTS.Social_Month,
        SF.Facebook_Fans           = MTS.Facebook_Fans,
        SF.Facebook_Posts          = MTS.Facebook_Posts,
        SF.Facebook_Reactions      = MTS.Facebook_Reactions,
        SF.Facebook_Comments       = MTS.Facebook_Comments,
        SF.Facebook_Shares         = MTS.Facebook_Shares,
        SF.Twitter_Fans            = MTS.Twitter_Fans,
        SF.Twitter_Posts           = MTS.Twitter_Posts,
        SF.Twitter_Retweets        = MTS.Twitter_Retweets,
        SF.Twitter_Favorites       = MTS.Twitter_Favorites,
        SF.Instagram_Fans          = MTS.Instagram_Fans,
        SF.Instagram_Posts         = MTS.Instagram_Posts,
        SF.Instagram_Likes         = MTS.Instagram_Likes,
        SF.Instagram_Comments      = MTS.Instagram_Comments,
        SF.Hastag1                 = MTS.Hastag1,
        SF.Hastag2                 = MTS.Hastag2,
        SF.Hastag3                 = MTS.Hastag3,
        SF.Hastag4                 = MTS.Hastag4,
        SF.Hastag5                 = MTS.Hastag5,
        SF.Hastag6                 = MTS.Hastag6,
        SF.Hastag7                 = MTS.Hastag7,
        SF.Hastag8                 = MTS.Hastag8,
        SF.Hastag9                 = MTS.Hastag9,
        SF.Hastag10                = MTS.Hastag10,
        SF.Weibo_Followers         = MTS.Weibo_Followers,
        SF.Weibo_Tweet             = MTS.Weibo_Tweet,
        SF.Weibo_Retweet           = MTS.Weibo_Retweet,
        SF.Weibo_Comment           = MTS.Weibo_Comment,
        SF.Weibo_Likes             = MTS.Weibo_Likes,
        SF.Weibo_Buzz              = MTS.Weibo_Buzz,
        SF.Weibo_Sentiment         = MTS.Weibo_Sentiment,
        SF.Avg_view_top_3_articles = MTS.Avg_view_top_3_articles,
        SF.Avg_like_top_3_articles = MTS.Avg_like_top_3_articles
    WHERE SF.Year_Month_Num = MTS.Year_Month_Num
      AND SF.Country = MTS.Country;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 20, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT DC.Year_Month_Num,
                ZS.Country,
                SUM(Total_Mentions_Count) Total_Mentions_Count,
                SUM(Sentiment_Positive)   Sentiment_Positive,
                SUM(Sentiment_Negative)   Sentiment_Negative,
                SUM(Sentiment_Neutral)    Sentiment_Neutral,
                SUM(Sentiment_Unknown)    Sentiment_Unknown
         FROM Zignal_Data_Sentiment_Breakdown ZS,
              Dim_Calendar DC
         WHERE ZS.Start_Date = DC.Fiscal_Date
           AND ZS.Brand_Name = 'Levi''s'
           AND ZS.Start_Date >= '2017-12-01'
         GROUP BY DC.Year_Month_Num, ZS.Country) ZSB
    SET SF.Total_Mentions_Count = ZSB.Total_Mentions_Count,
        SF.Sentiment_Positive   = ZSB.Sentiment_Positive,
        SF.Sentiment_Negative   = ZSB.Sentiment_Negative,
        SF.Sentiment_Neutral    = ZSB.Sentiment_Neutral,
        SF.Sentiment_Unknown    = ZSB.Sentiment_Unknown
    WHERE SF.Year_Month_Num = ZSB.Year_Month_Num
      AND SF.Country = ZSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Year_Month_Num,
                Country,
                Total_Mentions Total_Mentions_Count,
                Total_Positive Sentiment_Positive,
                Total_Negative Sentiment_Negative,
                Total_Neutral  Sentiment_Neutral
         FROM Pulsar_Sentiment PS
         WHERE Brand_Name = 'Levi''s'
         GROUP BY Year_Month_Num, Country) PSB
    SET SF.Total_Mentions_Count = PSB.Total_Mentions_Count,
        SF.Sentiment_Positive   = PSB.Sentiment_Positive,
        SF.Sentiment_Negative   = PSB.Sentiment_Negative,
        SF.Sentiment_Neutral    = PSB.Sentiment_Neutral
    WHERE SF.Year_Month_Num = PSB.Year_Month_Num
      AND SF.Country = PSB.Country;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 30, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Country, Year_Month_Num, Weibo_Buzz, Weibo_Sentiment / 100 AS Sentiment
         FROM Stg_Fact_DB_Social_China1
         WHERE Competitor = 'Levi''s') Q
    SET SF.Total_Mentions_Count = Q.Weibo_Buzz,
        SF.Weibo_Buzz           = Q.Weibo_Buzz,
        SF.Weibo_Sentiment      = Q.Sentiment,
        SF.Sentiment_Positive   = Q.Weibo_Buzz * Q.Sentiment,
        SF.Sentiment_Negative   = Q.Weibo_Buzz - (Q.Weibo_Buzz * Q.Sentiment)
    WHERE SF.Country = Q.Country
      AND SF.Country = 'China'
      AND SF.Year_Month_Num = Q.Year_Month_Num;

    /*        										
	UPDATE Stg_Fact_DB_Social SF, 									
			(SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) Total_Mentions_Count,							
			 SUM(Sentiment_Positive) Sentiment_Positive ,  SUM(Sentiment_Negative) Sentiment_Negative ,  SUM(Sentiment_Neutral) Sentiment_Neutral, SUM(Sentiment_Unknown) Sentiment_Unknown 							
			FROM Zignal_Data_Sentiment_Breakdown ZS, Dim_Calendar DC							
			WHERE ZS.Start_Date = DC.Fiscal_Date							
				AND ZS.Brand_Name ='Dockers'						
			GROUP BY DC.Year_Month_Num, ZS.Country) ZSB							
			SET SF.Dockers_Total_Mentions_Count = ZSB.Total_Mentions_Count, 							
				SF.Dockers_Sentiment_Positive = ZSB.Sentiment_Positive, 						
				SF.Dockers_Sentiment_Negative = ZSB.Sentiment_Negative, 						
				SF.Dockers_Sentiment_Neutral = ZSB.Sentiment_Neutral, 						
				SF.Dockers_Sentiment_Unknown = ZSB.Sentiment_Unknown						
			WHERE  SF.Year_Month_Num = ZSB.Year_Month_Num AND							
				SF.Country = ZSB.Country;						
    	*/
    UPDATE Stg_Fact_DB_Social SF,
        (SELECT DC.Year_Month_Num,
                ZS.Country,
                SUM(Total_Mentions_Count) Total_Mentions_Count,
                SUM(Sentiment_Positive)   Sentiment_Positive,
                SUM(Sentiment_Negative)   Sentiment_Negative,
                SUM(Sentiment_Neutral)    Sentiment_Neutral,
                SUM(Sentiment_Unknown)    Sentiment_Unknown
         FROM Zignal_Data_Sentiment_Breakdown ZS,
              Dim_Calendar DC
         WHERE ZS.Start_Date = DC.Fiscal_Date
           AND ZS.Brand_Name = 'Zara'
         GROUP BY DC.Year_Month_Num, ZS.Country) ZSB
    SET SF.Zara_Total_Mentions_Count = ZSB.Total_Mentions_Count,
        SF.Zara_Sentiment_Positive   = ZSB.Sentiment_Positive,
        SF.Zara_Sentiment_Negative   = ZSB.Sentiment_Negative,
        SF.Zara_Sentiment_Neutral    = ZSB.Sentiment_Neutral,
        SF.Zara_Sentiment_Unknown    = ZSB.Sentiment_Unknown
    WHERE SF.Year_Month_Num = ZSB.Year_Month_Num
      AND SF.Country = ZSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Year_Month_Num,
                Country,
                Total_Mentions Total_Mentions_Count,
                Total_Positive Sentiment_Positive,
                Total_Negative Sentiment_Negative,
                Total_Neutral  Sentiment_Neutral
         FROM Pulsar_Sentiment PS
         WHERE Brand_Name = 'Zara'
         GROUP BY Year_Month_Num, Country) PSB
    SET SF.Total_Mentions_Count = PSB.Total_Mentions_Count,
        SF.Sentiment_Positive   = PSB.Sentiment_Positive,
        SF.Sentiment_Negative   = PSB.Sentiment_Negative,
        SF.Sentiment_Neutral    = PSB.Sentiment_Neutral
    WHERE SF.Year_Month_Num = PSB.Year_Month_Num
      AND SF.Country = PSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT DC.Year_Month_Num,
                ZS.Country,
                SUM(Total_Mentions_Count) Total_Mentions_Count,
                SUM(Sentiment_Positive)   Sentiment_Positive,
                SUM(Sentiment_Negative)   Sentiment_Negative,
                SUM(Sentiment_Neutral)    Sentiment_Neutral,
                SUM(Sentiment_Unknown)    Sentiment_Unknown
         FROM Zignal_Data_Sentiment_Breakdown ZS,
              Dim_Calendar DC
         WHERE ZS.Start_Date = DC.Fiscal_Date
           AND ZS.Brand_Name = 'Uniqlo'
         GROUP BY DC.Year_Month_Num, ZS.Country) ZSB
    SET SF.Uniqlo_Total_Mentions_Count = ZSB.Total_Mentions_Count,
        SF.Uniqlo_Sentiment_Positive   = ZSB.Sentiment_Positive,
        SF.Uniqlo_Sentiment_Negative   = ZSB.Sentiment_Negative,
        SF.Uniqlo_Sentiment_Neutral    = ZSB.Sentiment_Neutral,
        SF.Uniqlo_Sentiment_Unknown    = ZSB.Sentiment_Unknown
    WHERE SF.Year_Month_Num = ZSB.Year_Month_Num
      AND SF.Country = ZSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Year_Month_Num,
                Country,
                Total_Mentions Total_Mentions_Count,
                Total_Positive Sentiment_Positive,
                Total_Negative Sentiment_Negative,
                Total_Neutral  Sentiment_Neutral
         FROM Pulsar_Sentiment PS
         WHERE Brand_Name = 'Uniqlo'
         GROUP BY Year_Month_Num, Country) PSB
    SET SF.Total_Mentions_Count = PSB.Total_Mentions_Count,
        SF.Sentiment_Positive   = PSB.Sentiment_Positive,
        SF.Sentiment_Negative   = PSB.Sentiment_Negative,
        SF.Sentiment_Neutral    = PSB.Sentiment_Neutral
    WHERE SF.Year_Month_Num = PSB.Year_Month_Num
      AND SF.Country = PSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT DC.Year_Month_Num,
                ZS.Country,
                SUM(Total_Mentions_Count) Total_Mentions_Count,
                SUM(Sentiment_Positive)   Sentiment_Positive,
                SUM(Sentiment_Negative)   Sentiment_Negative,
                SUM(Sentiment_Neutral)    Sentiment_Neutral,
                SUM(Sentiment_Unknown)    Sentiment_Unknown
         FROM Zignal_Data_Sentiment_Breakdown ZS,
              Dim_Calendar DC
         WHERE ZS.Start_Date = DC.Fiscal_Date
           AND ZS.Brand_Name = 'H&M'
         GROUP BY DC.Year_Month_Num, ZS.Country) ZSB
    SET SF.HM_Total_Mentions_Count = ZSB.Total_Mentions_Count,
        SF.HM_Sentiment_Positive   = ZSB.Sentiment_Positive,
        SF.HM_Sentiment_Negative   = ZSB.Sentiment_Negative,
        SF.HM_Sentiment_Neutral    = ZSB.Sentiment_Neutral,
        SF.HM_Sentiment_Unknown    = ZSB.Sentiment_Unknown
    WHERE SF.Year_Month_Num = ZSB.Year_Month_Num
      AND SF.Country = ZSB.Country;

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Year_Month_Num,
                Country,
                Total_Mentions Total_Mentions_Count,
                Total_Positive Sentiment_Positive,
                Total_Negative Sentiment_Negative,
                Total_Neutral  Sentiment_Neutral
         FROM Pulsar_Sentiment PS
         WHERE Brand_Name = 'H&M'
         GROUP BY Year_Month_Num, Country) PSB
    SET SF.Total_Mentions_Count = PSB.Total_Mentions_Count,
        SF.Sentiment_Positive   = PSB.Sentiment_Positive,
        SF.Sentiment_Negative   = PSB.Sentiment_Negative,
        SF.Sentiment_Neutral    = PSB.Sentiment_Neutral
    WHERE SF.Year_Month_Num = PSB.Year_Month_Num
      AND SF.Country = PSB.Country;
    /*
  UPDATE Stg_Fact_DB_Social SF, 										
      (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) Total_Mentions_Count,								
       SUM(Sentiment_Positive) Sentiment_Positive ,  SUM(Sentiment_Negative) Sentiment_Negative ,  SUM(Sentiment_Neutral) Sentiment_Neutral, SUM(Sentiment_Unknown) Sentiment_Unknown 								
      FROM Zignal_Data_Sentiment_Breakdown ZS, Dim_Calendar DC								
      WHERE ZS.Start_Date = DC.Fiscal_Date								
          AND ZS.Brand_Name ='Guess Jeans'							
      GROUP BY DC.Year_Month_Num, ZS.Country) ZSB								
      SET SF.Guess_Total_Mentions_Count = ZSB.Total_Mentions_Count, 								
          SF.Guess_Sentiment_Positive = ZSB.Sentiment_Positive, 							
          SF.Guess_Sentiment_Negative = ZSB.Sentiment_Negative, 							
          SF.Guess_Sentiment_Neutral = ZSB.Sentiment_Neutral, 							
          SF.Guess_Sentiment_Unknown = ZSB.Sentiment_Unknown							
      WHERE  SF.Year_Month_Num = ZSB.Year_Month_Num AND								
          SF.Country = ZSB.Country;							
                                                  
  UPDATE Stg_Fact_DB_Social SF, 									
      (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) Total_Mentions_Count,								
       SUM(Sentiment_Positive) Sentiment_Positive ,  SUM(Sentiment_Negative) Sentiment_Negative ,  SUM(Sentiment_Neutral) Sentiment_Neutral, SUM(Sentiment_Unknown) Sentiment_Unknown 								
      FROM Zignal_Data_Sentiment_Breakdown ZS, Dim_Calendar DC								
      WHERE ZS.Start_Date = DC.Fiscal_Date								
          AND ZS.Brand_Name ='Diesel Jeans'							
      GROUP BY DC.Year_Month_Num, ZS.Country) ZSB								
      SET SF.Diesel_Total_Mentions_Count = ZSB.Total_Mentions_Count, 								
          SF.Diesel_Sentiment_Positive = ZSB.Sentiment_Positive, 							
          SF.Diesel_Sentiment_Negative = ZSB.Sentiment_Negative, 							
          SF.Diesel_Sentiment_Neutral = ZSB.Sentiment_Neutral, 							
          SF.Diesel_Sentiment_Unknown = ZSB.Sentiment_Unknown							
      WHERE  SF.Year_Month_Num = ZSB.Year_Month_Num AND								
          SF.Country = ZSB.Country;							
                                                  
  UPDATE Stg_Fact_DB_Social SF, 									
      (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) Total_Mentions_Count,								
       SUM(Sentiment_Positive) Sentiment_Positive ,  SUM(Sentiment_Negative) Sentiment_Negative ,  SUM(Sentiment_Neutral) Sentiment_Neutral, SUM(Sentiment_Unknown) Sentiment_Unknown 								
      FROM Zignal_Data_Sentiment_Breakdown ZS, Dim_Calendar DC								
      WHERE ZS.Start_Date = DC.Fiscal_Date								
          AND ZS.Brand_Name ='Calvin Klein Jeans'							
      GROUP BY DC.Year_Month_Num, ZS.Country) ZSB								
      SET SF.Calvin_Klein_Total_Mentions_Count = ZSB.Total_Mentions_Count, 								
          SF.Calvin_Klein_Sentiment_Positive = ZSB.Sentiment_Positive, 							
          SF.Calvin_Klein_Sentiment_Negative = ZSB.Sentiment_Negative, 							
          SF.Calvin_Klein_Sentiment_Neutral = ZSB.Sentiment_Neutral, 							
          SF.Calvin_Klein_Sentiment_Unknown = ZSB.Sentiment_Unknown							
      WHERE  SF.Year_Month_Num = ZSB.Year_Month_Num AND								
          SF.Country = ZSB.Country;							
                                                  
  UPDATE Stg_Fact_DB_Social SF, 									
      (SELECT DC.Year_Month_Num, ZS.Country, SUM(Total_Mentions_Count) Total_Mentions_Count,								
       SUM(Sentiment_Positive) Sentiment_Positive ,  SUM(Sentiment_Negative) Sentiment_Negative ,  SUM(Sentiment_Neutral) Sentiment_Neutral, SUM(Sentiment_Unknown) Sentiment_Unknown 								
      FROM Zignal_Data_Sentiment_Breakdown ZS, Dim_Calendar DC								
      WHERE ZS.Start_Date = DC.Fiscal_Date								
          AND ZS.Brand_Name ='Edwin Jeans'							
      GROUP BY DC.Year_Month_Num, ZS.Country) ZSB								
      SET SF.Edwin_Total_Mentions_Count = ZSB.Total_Mentions_Count, 								
          SF.Edwin_Sentiment_Positive = ZSB.Sentiment_Positive, 							
          SF.Edwin_Sentiment_Negative = ZSB.Sentiment_Negative, 							
          SF.Edwin_Sentiment_Neutral = ZSB.Sentiment_Neutral, 							
          SF.Edwin_Sentiment_Unknown = ZSB.Sentiment_Unknown							
      WHERE  SF.Year_Month_Num = ZSB.Year_Month_Num AND								
          SF.Country = ZSB.Country;							
 
UPDATE Stg_Fact_DB_Social SFDC,										
  (SELECT SUM(Levis) as Levis, SUM(Dockers) as Dockers, SUM(Zara) as Zara,									
      SUM(Uniqlo) as Uniqlo, SUM(H_M) as HM, SUM(Guess_Jeans) as Guess, SUM(Diesel_Jeans) as Diesel,								
      SUM(Calvin_Klein_Jeans) as Calvinklein, SUM(Edwin_Jeans)as Edwin,								
      Country,Year_Month_Num 								
      FROM  Organic_Search										
  GROUP BY  Country, Year_Month_Num) OS									
  SET SFDC.Levis_Organic_Search = OS.Levis,									
      SFDC.Dockers_Organic_Search = OS.Dockers,								
      SFDC.Zara_Organic_Search = OS.Zara,								
      SFDC.Uniqlo_Organic_Search = OS.Uniqlo,								
      SFDC.HM_Organic_Search = OS.HM,								
      SFDC.Guess_Organic_Search = OS.Guess,								
      SFDC.Diesel_Organic_Search = OS.Diesel,								
      SFDC.CalvinKlein_Organic_Search = OS.Calvinklein,								
      SFDC.Edwin_Organic_Search = OS.Edwin								
  WHERE SFDC.Country = OS.Country AND SFDC.Year_Month_Num = OS.Year_Month_Num ;		
  */
    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 40, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '12' THEN Year_Month_Num + 89
                    ELSE Year_Month_Num + 1 END P_Year_Month_Num,
                Country,
                Facebook_Fans,
                Facebook_Posts,
                Facebook_Reactions,
                Facebook_Comments,
                Facebook_Shares,
                Twitter_Fans,
                Twitter_Posts,
                Twitter_Retweets,
                Twitter_Favorites,
                Instagram_Fans,
                Instagram_Posts,
                Instagram_Likes,
                Instagram_Comments,
                Hastag1,
                Hastag2,
                Hastag3,
                Hastag4,
                Hastag5,
                Hastag6,
                Hastag7,
                Hastag8,
                Hastag9,
                Hastag10,
                Weibo_Followers,
                Weibo_Tweet,
                Weibo_Retweet,
                Weibo_Comment,
                Weibo_Likes,
                Weibo_Buzz,
                Weibo_Sentiment,
                Avg_view_top_3_articles,
                Avg_like_top_3_articles,
                Total_Mentions_Count,
                Sentiment_Positive,
                Sentiment_Negative,
                Sentiment_Neutral,
                Sentiment_Unknown,
                Dockers_Sentiment_Positive,
                Dockers_Sentiment_Negative,
                Dockers_Sentiment_Neutral,
                Dockers_Sentiment_Unknown,
                Dockers_Total_Mentions_Count,
                Zara_Sentiment_Positive,
                Zara_Sentiment_Negative,
                Zara_Sentiment_Neutral,
                Zara_Sentiment_Unknown,
                Zara_Total_Mentions_Count,
                Uniqlo_Sentiment_Positive,
                Uniqlo_Sentiment_Negative,
                Uniqlo_Sentiment_Neutral,
                Uniqlo_Sentiment_Unknown,
                Uniqlo_Total_Mentions_Count,
                HM_Sentiment_Positive,
                HM_Sentiment_Negative,
                HM_Sentiment_Neutral,
                HM_Sentiment_Unknown,
                HM_Total_Mentions_Count,
                Guess_Sentiment_Positive,
                Guess_Sentiment_Negative,
                Guess_Sentiment_Neutral,
                Guess_Sentiment_Unknown,
                Guess_Total_Mentions_Count,
                Diesel_Sentiment_Positive,
                Diesel_Sentiment_Negative,
                Diesel_Sentiment_Neutral,
                Diesel_Sentiment_Unknown,
                Diesel_Total_Mentions_Count,
                Calvin_Klein_Sentiment_Positive,
                Calvin_Klein_Sentiment_Negative,
                Calvin_Klein_Sentiment_Neutral,
                Calvin_Klein_Sentiment_Unknown,
                Calvin_Klein_Total_Mentions_Count,
                Edwin_Sentiment_Positive,
                Edwin_Sentiment_Negative,
                Edwin_Sentiment_Neutral,
                Edwin_Sentiment_Unknown,
                Edwin_Total_Mentions_Count
         FROM Stg_Fact_DB_Social) Q
    SET SF.Prev_Facebook_Fans                     = Q.Facebook_Fans,
        SF.Prev_Facebook_Posts                    = Q.Facebook_Posts,
        SF.Prev_Facebook_Reactions                = Q.Facebook_Reactions,
        SF.Prev_Facebook_Comments                 = Q.Facebook_Comments,
        SF.Prev_Facebook_Shares                   = Q.Facebook_Shares,
        SF.Prev_Twitter_Fans                      = Q.Twitter_Fans,
        SF.Prev_Twitter_Posts                     = Q.Twitter_Posts,
        SF.Prev_Twitter_Retweets                  = Q.Twitter_Retweets,
        SF.Prev_Twitter_Favorites                 = Q.Twitter_Favorites,
        SF.Prev_Instagram_Fans                    = Q.Instagram_Fans,
        SF.Prev_Instagram_Posts                   = Q.Instagram_Posts,
        SF.Prev_Instagram_Likes                   = Q.Instagram_Likes,
        SF.Prev_Instagram_Comments                = Q.Instagram_Comments,
        SF.Prev_Weibo_Followers                   = Q.Weibo_Followers,
        SF.Prev_Weibo_Tweet                       = Q.Weibo_Tweet,
        SF.Prev_Weibo_Retweet                     = Q.Weibo_Retweet,
        SF.Prev_Weibo_Comment                     = Q.Weibo_Comment,
        SF.Prev_Weibo_Likes                       = Q.Weibo_Likes,
        SF.Prev_Weibo_Buzz                        = Q.Weibo_Buzz,
        SF.Prev_Weibo_Sentiment                   = Q.Weibo_Sentiment,
        SF.Prev_Avg_view_top_3_articles           = Q.Avg_view_top_3_articles,
        SF.Prev_Avg_like_top_3_articles           = Q.Avg_like_top_3_articles,
        SF.Prev_Total_Mentions_Count              = Q.Total_Mentions_Count,
        SF.Prev_Sentiment_Positive                = Q.Sentiment_Positive,
        SF.Prev_Sentiment_Negative                = Q.Sentiment_Negative,
        SF.Prev_Sentiment_Neutral                 = Q.Sentiment_Neutral,
        SF.Prev_Sentiment_Unknown                 = Q.Sentiment_Unknown,
        SF.Prev_Dockers_Total_Mentions_Count      = Q.Dockers_Total_Mentions_Count,
        SF.Prev_Dockers_Sentiment_Positive        = Q.Dockers_Sentiment_Positive,
        SF.Prev_Dockers_Sentiment_Negative        = Q.Dockers_Sentiment_Negative,
        SF.Prev_Dockers_Sentiment_Neutral         = Q.Dockers_Sentiment_Neutral,
        SF.Prev_Dockers_Sentiment_Unknown         = Q.Dockers_Sentiment_Unknown,
        SF.Prev_Zara_Total_Mentions_Count         = Q.Zara_Total_Mentions_Count,
        SF.Prev_Zara_Sentiment_Positive           = Q.Zara_Sentiment_Positive,
        SF.Prev_Zara_Sentiment_Negative           = Q.Zara_Sentiment_Negative,
        SF.Prev_Zara_Sentiment_Neutral            = Q.Zara_Sentiment_Neutral,
        SF.Prev_Zara_Sentiment_Unknown            = Q.Zara_Sentiment_Unknown,
        SF.Prev_Uniqlo_Total_Mentions_Count       = Q.Uniqlo_Total_Mentions_Count,
        SF.Prev_Uniqlo_Sentiment_Positive         = Q.Uniqlo_Sentiment_Positive,
        SF.Prev_Uniqlo_Sentiment_Negative         = Q.Uniqlo_Sentiment_Negative,
        SF.Prev_Uniqlo_Sentiment_Neutral          = Q.Uniqlo_Sentiment_Neutral,
        SF.Prev_Uniqlo_Sentiment_Unknown          = Q.Uniqlo_Sentiment_Unknown,
        SF.Prev_HM_Total_Mentions_Count           = Q.HM_Total_Mentions_Count,
        SF.Prev_HM_Sentiment_Positive             = Q.HM_Sentiment_Positive,
        SF.Prev_HM_Sentiment_Negative             = Q.HM_Sentiment_Negative,
        SF.Prev_HM_Sentiment_Neutral              = Q.HM_Sentiment_Neutral,
        SF.Prev_HM_Sentiment_Unknown              = Q.HM_Sentiment_Unknown,
        SF.Prev_Guess_Total_Mentions_Count        = Q.Guess_Total_Mentions_Count,
        SF.Prev_Guess_Sentiment_Positive          = Q.Guess_Sentiment_Positive,
        SF.Prev_Guess_Sentiment_Negative          = Q.Guess_Sentiment_Negative,
        SF.Prev_Guess_Sentiment_Neutral           = Q.Guess_Sentiment_Neutral,
        SF.Prev_Guess_Sentiment_Unknown           = Q.Guess_Sentiment_Unknown,
        SF.Prev_Diesel_Total_Mentions_Count       = Q.Diesel_Total_Mentions_Count,
        SF.Prev_Diesel_Sentiment_Positive         = Q.Diesel_Sentiment_Positive,
        SF.Prev_Diesel_Sentiment_Negative         = Q.Diesel_Sentiment_Negative,
        SF.Prev_Diesel_Sentiment_Neutral          = Q.Diesel_Sentiment_Neutral,
        SF.Prev_Diesel_Sentiment_Unknown          = Q.Diesel_Sentiment_Unknown,
        SF.Prev_Calvin_Klein_Total_Mentions_Count = Q.Calvin_Klein_Total_Mentions_Count,
        SF.Prev_Calvin_Klein_Sentiment_Positive   = Q.Calvin_Klein_Sentiment_Positive,
        SF.Prev_Calvin_Klein_Sentiment_Negative   = Q.Calvin_Klein_Sentiment_Negative,
        SF.Prev_Calvin_Klein_Sentiment_Neutral    = Q.Calvin_Klein_Sentiment_Neutral,
        SF.Prev_Calvin_Klein_Sentiment_Unknown    = Q.Calvin_Klein_Sentiment_Unknown,
        SF.Prev_Edwin_Total_Mentions_Count        = Q.Edwin_Total_Mentions_Count,
        SF.Prev_Edwin_Sentiment_Positive          = Q.Edwin_Sentiment_Positive,
        SF.Prev_Edwin_Sentiment_Negative          = Q.Edwin_Sentiment_Negative,
        SF.Prev_Edwin_Sentiment_Neutral           = Q.Edwin_Sentiment_Neutral,
        SF.Prev_Edwin_Sentiment_Unknown           = Q.Edwin_Sentiment_Unknown
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 50, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT Year_Month_Num + 100 P_Year_Month_Num,
                Country,
                Total_Mentions_Count,
                Sentiment_Positive,
                Sentiment_Negative,
                Sentiment_Neutral,
                Sentiment_Unknown,
                Facebook_Fans,
                Facebook_Posts,
                Facebook_Reactions,
                Facebook_Comments,
                Facebook_Shares,
                Twitter_Fans,
                Twitter_Posts,
                Twitter_Retweets,
                Twitter_Favorites,
                Instagram_Fans,
                Instagram_Posts,
                Instagram_Likes,
                Instagram_Comments,
                Levis_Organic_Search,
                Dockers_Organic_Search,
                Zara_Organic_Search,
                Uniqlo_Organic_Search,
                HM_Organic_Search,
                Guess_Organic_Search,
                Diesel_Organic_Search,
                CalvinKlein_Organic_Search,
                Edwin_Organic_Search
         FROM Stg_Fact_DB_Social) Q
    SET SF.Prev_Year_Total_Mentions_Count  = Q.Total_Mentions_Count,
        SF.Prev_Year_Sentiment_Positive    = Q.Sentiment_Positive,
        SF.Prev_Year_Sentiment_Negative    = Q.Sentiment_Negative,
        SF.Prev_Year_Sentiment_Neutral     = Q.Sentiment_Neutral,
        SF.Prev_Year_Sentiment_Unknown     = Q.Sentiment_Unknown,
        SF.Prev_Year_Facebook_Fans         = Q.Facebook_Fans,
        SF.Prev_Year_Facebook_Posts        = Q.Facebook_Posts,
        SF.Prev_Year_Facebook_Reactions    = Q.Facebook_Reactions,
        SF.Prev_Year_Facebook_Comments     = Q.Facebook_Comments,
        SF.Prev_Year_Facebook_Shares       = Q.Facebook_Shares,
        SF.Prev_Year_Twitter_Fans          = Q.Twitter_Fans,
        SF.Prev_Year_Twitter_Posts         = Q.Twitter_Posts,
        SF.Prev_Year_Twitter_Retweets      = Q.Twitter_Retweets,
        SF.Prev_Year_Twitter_Favorites     = Q.Twitter_Favorites,
        SF.Prev_Year_Instagram_Fans        = Q.Instagram_Fans,
        SF.Prev_Year_Instagram_Posts       = Q.Instagram_Posts,
        SF.Prev_Year_Instagram_Likes       = Q.Instagram_Likes,
        SF.Prev_Year_Instagram_Comments    = Q.Instagram_Comments,
        SF.Prev_Levis_Organic_Search       = Q.Levis_Organic_Search,
        SF.Prev_Dockers_Organic_Search     = Q.Dockers_Organic_Search,
        SF.Prev_Zara_Organic_Search= Q.Zara_Organic_Search,
        SF.Prev_Uniqlo_Organic_Search      = Q.Uniqlo_Organic_Search,
        SF.Prev_HM_Organic_Search          = Q.HM_Organic_Search,
        SF.Prev_Guess_Organic_Search       = Q.Guess_Organic_Search,
        SF.Prev_Diesel_Organic_Search      = Q.Diesel_Organic_Search,
        SF.Prev_CalvinKlein_Organic_Search = Q.CalvinKlein_Organic_Search,
        SF.Prev_Edwin_Organic_Search       = Q.Edwin_Organic_Search
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 60, CURRENT_TIMESTAMP());

    UPDATE Stg_Fact_DB_Social SF,
        (SELECT DATE_FORMAT(Start_Date, '%Y%m')                                            Year_Month_Num,
                Country,
                SUM(CASE WHEN Source = 'blogs' THEN Total_Mentions_Count ELSE 0 END)       blogs,
                SUM(CASE WHEN Source = 'Broadcast' THEN Total_Mentions_Count ELSE 0 END)   Broadcast,
                SUM(CASE WHEN Source = 'Facebook' THEN Total_Mentions_Count ELSE 0 END)    Facebook,
                SUM(CASE WHEN Source = 'Instagram' THEN Total_Mentions_Count ELSE 0 END)   Instagram,
                SUM(CASE WHEN Source = 'Lexis_nexis' THEN Total_Mentions_Count ELSE 0 END) Lexis_nexis,
                SUM(CASE WHEN Source = 'News' THEN Total_Mentions_Count ELSE 0 END)        News,
                SUM(CASE WHEN Source = 'Twitter' THEN Total_Mentions_Count ELSE 0 END)     Twitter,
                SUM(CASE WHEN Source = 'Videos' THEN Total_Mentions_Count ELSE 0 END)      Videos
         FROM Zignal_Data_Total_Mentions
         GROUP BY DATE_FORMAT(Start_Date, '%Y-%M'), Country) Q
    SET SF.Blogs       = Q.Blogs,
        SF.Broadcast   = Q.Broadcast,
        SF.Facebook    = Q.Facebook,
        SF.Instagram   = Q.Instagram,
        SF.Lexis_nexis = Q.Lexis_nexis,
        SF.News        = Q.News,
        SF.Twitter     = Q.Twitter,
        SF.Videos      = Q.Videos
    WHERE SF.Year_Month_Num = Q.Year_Month_Num
      AND SF.Country = Q.Country;
    COMMIT;

    TRUNCATE TABLE Fact_DB_Social;
    INSERT INTO Fact_DB_Social SELECT * FROM Stg_Fact_DB_Social;
    COMMIT;

    INSERT INTO Job_Info_Dtls
    VALUES (i_Job_ID, 'Pop_Fact_DB_Social', NULL, 70, CURRENT_TIMESTAMP());
END;


