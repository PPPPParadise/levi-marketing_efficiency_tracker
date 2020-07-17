create
    definer = gchand@`%` procedure Load_SocialMedia_China()
BEGIN

    -- 
/*
TRUNCATE table Stg_SocialMedia_China;
load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Final\\USD_Taiwan_Oct-18_USD_1.csv'
		into table `Stg_SocialMedia_China`
		fields terminated by ',' 
		OPTIONALLY ENCLOSED BY '"'
        ESCAPED BY '"'
        LINES TERMINATED BY '\r\n'
        IGNORE 2 LINES


INSERT INTO SocialMedia_China(
 Social_Month, Year_Month_Num, Country, Weibo_Followers_Uniqlo, Weibo_Followers_HM, Weibo_Followers_Zara, Weibo_Followers_Levis, Weibo_Followers_Lee, Weibo_Followers_Gap, Weibo_Tweet_Uniqlo, Weibo_Tweet_HM, Weibo_Tweet_Zara, Weibo_Tweet_Levis, Weibo_Tweet_Lee, 
 Weibo_Tweet_Gap, Weibo_Retweet_Uniqlo, Weibo_Retweet_HM, Weibo_Retweet_Zara, Weibo_Retweet_Levis, Weibo_Retweet_Lee, Weibo_Retweet_Gap, Weibo_Comment_Uniqlo, Weibo_Comment_HM, Weibo_Comment_Zara, Weibo_Comment_Levis, Weibo_Comment_Lee, Weibo_Comment_Gap, Weibo_Likes_Uniqlo,
 Weibo_Likes_HM, Weibo_Likes_Zara, Weibo_Likes_Levis, Weibo_Likes_Lee, Weibo_Likes_Gap, Weibo_Buzz_Uniqlo, Weibo_Buzz_HM, Weibo_Buzz_Zara, Weibo_Buzz_Levis, Weibo_Buzz_Lee, Weibo_Buzz_Gap, Weibo_Sentiment_Uniqlo, Weibo_Sentiment_HM, Weibo_Sentiment_Zara, Weibo_Sentiment_Levis,
 Weibo_Sentiment_Lee, Weibo_Sentiment_Gap, Wechat_Avg_view_top_3_articles_Uniqlo, Wechat_Avg_view_top_3_articles_HM, Wechat_Avg_view_top_3_articles_Zara, Wechat_Avg_view_top_3_articles_Levis, Wechat_Avg_view_top_3_articles_Lee, 
 Wechat_Avg_view_top_3_articles_Gap, Wechat_Avg_like_top_3_articles_Uniqlo, Wechat_Avg_like_top_3_articles_HM, Wechat_Avg_like_top_3_articles_Zara, Wechat_Avg_like_top_3_articles_Levis, Wechat_Avg_like_top_3_articles_Lee, Wechat_Avg_like_top_3_articles_Gap,
 Weibo_Followers_Growth_Uniqlo, Weibo_Followers_Growth_HM, Weibo_Followers_Growth_Zara, Weibo_Followers_Growth_Levis, Weibo_Followers_Growth_Lee, Weibo_Followers_Growth_Gap, Weibo_Engagement_Rate_Uniqlo, Weibo_Engagement_Rate_HM, Weibo_Engagement_Rate_Zara, Weibo_Engagement_Rate_Levis, Weibo_Engagement_Rate_Lee, Weibo_Engagement_Rate_Gap)

SELECT Social_Month,
CONCAT(20 , SUBSTR(TRIM(Social_Month), 1,2),
                                CASE WHEN SUBSTR(Social_Month,4,6) = 'Jan' THEN '01'
									WHEN SUBSTR(Social_Month,4,6)= 'Feb' THEN '02'
									WHEN SUBSTR(Social_Month,4,6) = 'Mar' THEN '03'
									WHEN SUBSTR(Social_Month,4,6) = 'Apr' THEN '04'
									WHEN SUBSTR(Social_Month,4,6) = 'May' THEN '05'
									WHEN SUBSTR(Social_Month,4,6) = 'Jun' THEN '06'
									WHEN SUBSTR(Social_Month,4,6) = 'Jul' THEN '07'
									WHEN SUBSTR(Social_Month,4,6) = 'Aug' THEN '08'
									WHEN SUBSTR(Social_Month,4,6) = 'Sep' THEN '09'
									WHEN SUBSTR(Social_Month,4,6) = 'Oct' THEN '10'
									WHEN SUBSTR(Social_Month,4,6) = 'Nov' THEN '11'
									WHEN SUBSTR(Social_Month,4,6) = 'Dec' THEN '12'    
									ELSE '00' 
									END) as Year_Month_Num, 
'China',							
ExtractNumber(Weibo_Followers_Uniqlo),
ExtractNumber(Weibo_Followers_HM),
ExtractNumber(Weibo_Followers_Zara),
ExtractNumber(Weibo_Followers_Levis),
ExtractNumber(Weibo_Followers_Lee),
ExtractNumber(Weibo_Followers_Gap),
ExtractNumber(Weibo_Tweet_Uniqlo),
ExtractNumber(Weibo_Tweet_HM),
ExtractNumber(Weibo_Tweet_Zara),
ExtractNumber(Weibo_Tweet_Levis),
ExtractNumber(Weibo_Tweet_Lee),
ExtractNumber(Weibo_Tweet_Gap),
ExtractNumber(Weibo_Retweet_Uniqlo),
ExtractNumber(Weibo_Retweet_HM),
ExtractNumber(Weibo_Retweet_Zara),
ExtractNumber(Weibo_Retweet_Levis),
ExtractNumber(Weibo_Retweet_Lee),
ExtractNumber(Weibo_Retweet_Gap),
ExtractNumber(Weibo_Comment_Uniqlo),
ExtractNumber(Weibo_Comment_HM),
ExtractNumber(Weibo_Comment_Zara),
ExtractNumber(Weibo_Comment_Levis),
ExtractNumber(Weibo_Comment_Lee),
ExtractNumber(Weibo_Comment_Gap),
ExtractNumber(Weibo_Likes_Uniqlo),
ExtractNumber(Weibo_Likes_HM),
ExtractNumber(Weibo_Likes_Zara),
ExtractNumber(Weibo_Likes_Levis),
ExtractNumber(Weibo_Likes_Lee),
ExtractNumber(Weibo_Likes_Gap),
ExtractNumber(Weibo_Buzz_Uniqlo),
ExtractNumber(Weibo_Buzz_HM),
ExtractNumber(Weibo_Buzz_Zara),
ExtractNumber(Weibo_Buzz_Levis),
ExtractNumber(Weibo_Buzz_Lee),
ExtractNumber(Weibo_Buzz_Gap),
ExtractNumber(Weibo_Sentiment_Uniqlo),
ExtractNumber(Weibo_Sentiment_HM),
ExtractNumber(Weibo_Sentiment_Zara),
ExtractNumber(Weibo_Sentiment_Levis),
ExtractNumber(Weibo_Sentiment_Lee),
ExtractNumber(Weibo_Sentiment_Gap),
ExtractNumber(Wechat_Avg_view_top_3_articles_Uniqlo),
ExtractNumber(Wechat_Avg_view_top_3_articles_HM),
ExtractNumber(Wechat_Avg_view_top_3_articles_Zara),
ExtractNumber(Wechat_Avg_view_top_3_articles_Levis),
ExtractNumber(Wechat_Avg_view_top_3_articles_Lee),
ExtractNumber(Wechat_Avg_view_top_3_articles_Gap),
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_Uniqlo) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_Uniqlo) ELSE 0 END,
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_HM) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_HM) ELSE 0 END,
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_Zara) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_Zara) ELSE 0 END,
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_Levis) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_Levis) ELSE 0 END,
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_Lee) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_Lee) ELSE 0 END,
CASE WHEN ExtractNumber(Wechat_Avg_like_top_3_articles_Gap) > 0 THEN ExtractNumber(Wechat_Avg_like_top_3_articles_Gap) ELSE 0 END,
ExtractNumber(Weibo_Followers_Growth_Uniqlo),
ExtractNumber(Weibo_Followers_Growth_HM),
ExtractNumber(Weibo_Followers_Growth_Zara),
ExtractNumber(Weibo_Followers_Growth_Levis),
ExtractNumber(Weibo_Followers_Growth_Lee),
ExtractNumber(Weibo_Followers_Growth_Gap),
ExtractNumber(Weibo_Engagement_Rate_Uniqlo),
ExtractNumber(Weibo_Engagement_Rate_HM),
ExtractNumber(Weibo_Engagement_Rate_Zara),
ExtractNumber(Weibo_Engagement_Rate_Levis),
ExtractNumber(Weibo_Engagement_Rate_Lee),
ExtractNumber(Weibo_Engagement_Rate_Gap)
FROM Stg_SocialMedia_China;

/*
UPDATE SocialMedia_China SET
Weibo_Engagement_Rate_Uniqlo = (Weibo_Likes_Uniqlo + Weibo_Retweet_Uniqlo + Weibo_Comment_Uniqlo)/Weibo_Followers_Uniqlo *100  ,
Weibo_Engagement_Rate_HM = (Weibo_Likes_HM + Weibo_Retweet_HM + Weibo_Comment_HM)/Weibo_Followers_HM *100 ,
Weibo_Engagement_Rate_Zara = (Weibo_Likes_Zara + Weibo_Retweet_Zara + Weibo_Comment_Zara)/Weibo_Followers_Zara *100 ,
Weibo_Engagement_Rate_Levis = (Weibo_Likes_Levis + Weibo_Retweet_Levis + Weibo_Comment_Levis)/Weibo_Followers_Levis *100,
Weibo_Engagement_Rate_Lee = (Weibo_Likes_Lee + Weibo_Retweet_Lee + Weibo_Comment_Lee)/Weibo_Followers_Lee *100 ,
Weibo_Engagement_Rate_Gap = (Weibo_Likes_Gap + Weibo_Retweet_Gap + Weibo_Comment_Gap)/Weibo_Followers_Gap *100 
where length(Social_Month)=6; */
END;


