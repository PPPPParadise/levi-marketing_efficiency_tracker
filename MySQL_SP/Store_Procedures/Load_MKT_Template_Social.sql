create
    definer = georgebian@`%` procedure Load_MKT_Template_Social()
BEGIN
    /*
     truncate table Stg_MKT_Template_Social;
     load data local infile '/Users/keiraxiu/Desktop/social_mkt.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
    delete from Stg_MKT_Template_Social where Social_Month ='20-May' ;
    select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Indonesia_Social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
    delete from Stg_MKT_Template_Social where Social_Month ='' ;
    select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Japan_social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
    delete from Stg_MKT_Template_Social where Social_Month ='' ;
    select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Malaysia_Social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
    delete from Stg_MKT_Template_Social where Social_Month ='' ;
    select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Philippines_social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
     delete from Stg_MKT_Template_Social where Social_Month ='' ;
     select * from Stg_MKT_Template_Social;
     
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\SouthAfrica_social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
     delete from Stg_MKT_Template_Social where Social_Month ='' ;
     select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\SouthKorea_Social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES; 
     delete from Stg_MKT_Template_Social where Social_Month ='' ;
     select * from Stg_MKT_Template_Social;
    
    truncate table Stg_MKT_Template_Social; 
     load data local infile 'D:\\Data\\2018_October\\MKT_Temp\\CSV\\Taiwan_social.csv'
     into table `Stg_MKT_Template_Social`
     fields terminated by ',' 
     OPTIONALLY ENCLOSED BY '"'
     ESCAPED BY '"'
     LINES TERMINATED BY '\n'
     IGNORE 3 LINES;
     delete from Stg_MKT_Template_Social where Social_Month ='' ;
     select * from Stg_MKT_Template_Social;
     
     
     
     Another way
     ---------------
     
    INSERT INTO MKT_Template_Social
     (Year_Month_Num, 
     Country, Social_Month, 
     Facebook_Fans, Facebook_Posts, Facebook_Reactions, 
     Facebook_Comments, Facebook_Shares, Twitter_Fans, 
     Twitter_Posts, Twitter_Retweets, Twitter_Favorites, 
     Instagram_Fans, Instagram_Posts, Instagram_Likes, 
     Instagram_Comments, Hastag1, Hastag2, 
     Hastag3, Hastag4, Hastag5, 
     Hastag6, Hastag7, Hastag8, 
     Hastag9, Hastag10, Weibo_Followers, 
     Weibo_Tweet, Weibo_Retweet, Weibo_Comment, 
     Weibo_Likes, Weibo_Buzz, Weibo_Sentiment, 
     Avg_view_top_3_articles, Avg_like_top_3_articles)
     
    select 
     CONCAT(20 , SUBSTR(TRIM(Social_Month), 1,2),
     CASE WHEN SUBSTR(Social_Month,4,3) = 'Jan' THEN '01'
     WHEN SUBSTR(Social_Month,4,3) = 'Feb' THEN '02'
     WHEN SUBSTR(Social_Month,4,3) = 'Mar' THEN '03'
     WHEN SUBSTR(Social_Month,4,3) = 'Apr' THEN '04'
     WHEN SUBSTR(Social_Month,4,3) = 'May' THEN '05'
     WHEN SUBSTR(Social_Month,4,3) = 'Jun' THEN '06'
     WHEN SUBSTR(Social_Month,4,3) = 'Jul' THEN '07'
     WHEN SUBSTR(Social_Month,4,3) = 'Aug' THEN '08'
     WHEN SUBSTR(Social_Month,4,3) = 'Sep' THEN '09'
     WHEN SUBSTR(Social_Month,4,3) = 'Oct' THEN '10'
     WHEN SUBSTR(Social_Month,4,3) = 'Nov' THEN '11'
     WHEN SUBSTR(Social_Month,4,3) = 'Dec' THEN '12' 
     ELSE '00' 
     END) as Year_Month_Num, 
     Country,
    
     CONCAT(SUBSTR(Social_Month,4,3), '-', SUBSTR(TRIM(Social_Month), 1,2)),
     ExtractNumber(Facebook_Fans), ExtractNumber(Facebook_Posts), ExtractNumber(Facebook_Reactions), 
     ExtractNumber(Facebook_Comments), ExtractNumber(Facebook_Shares), ExtractNumber(Twitter_Fans), 
     ExtractNumber(Twitter_Posts), ExtractNumber(Twitter_Retweets), ExtractNumber(Twitter_Favorites), 
     ExtractNumber(Instagram_Fans), ExtractNumber(Instagram_Posts), ExtractNumber(Instagram_Likes), 
     ExtractNumber(Instagram_Comments), Hastag1, Hastag2, 
     Hastag3, Hastag4, Hastag5, 
     Hastag6,Hastag7, Hastag8, 
     Hastag9,Hastag10, ExtractNumber(Weibo_Followers), 
     ExtractNumber(Weibo_Tweet), ExtractNumber(Weibo_Retweet), ExtractNumber(Weibo_Comment), 
     ExtractNumber(Weibo_Likes), ExtractNumber(Weibo_Buzz), ExtractNumber(Weibo_Sentiment), 
     ExtractNumber(Avg_view_top_3_articles), CASE WHEN ExtractNumber(Avg_like_top_3_articles) > 0 THEN ExtractNumber(Avg_like_top_3_articles) ELSE 0 END 
    FROM Stg_MKT_Template_Social 
    WHERE Social_Month <> '';
     
    
    */
    INSERT INTO MKT_Template_Social
    (Year_Month_Num,
     Country, Social_Month,
     Facebook_Fans, Facebook_Posts, Facebook_Reactions,
     Facebook_Comments, Facebook_Shares, Twitter_Fans,
     Twitter_Posts, Twitter_Retweets, Twitter_Favorites,
     Instagram_Fans, Instagram_Posts, Instagram_Likes,
     Instagram_Comments, Hastag1, Hastag2,
     Hastag3, Hastag4, Hastag5,
     Hastag6, Hastag7, Hastag8,
     Hastag9, Hastag10, Weibo_Followers,
     Weibo_Tweet, Weibo_Retweet, Weibo_Comment,
     Weibo_Likes, Weibo_Buzz, Weibo_Sentiment,
     Avg_view_top_3_articles, Avg_like_top_3_articles)

        /* CONCAT(20 , SUBSTR(TRIM(Social_Month), 5,2),
        CASE WHEN SUBSTR(Social_Month,1,3) = 'Jan' THEN '01'
        WHEN SUBSTR(Social_Month,1,3) = 'Feb' THEN '02'
        WHEN SUBSTR(Social_Month,1,3) = 'Mar' THEN '03'
        WHEN SUBSTR(Social_Month,1,3) = 'Apr' THEN '04'
        WHEN SUBSTR(Social_Month,1,3) = 'May' THEN '05'
        WHEN SUBSTR(Social_Month,1,3) = 'Jun' THEN '06'
        WHEN SUBSTR(Social_Month,1,3) = 'Jul' THEN '07'
        WHEN SUBSTR(Social_Month,1,3) = 'Aug' THEN '08'
        WHEN SUBSTR(Social_Month,1,3) = 'Sep' THEN '09'
        WHEN SUBSTR(Social_Month,1,3) = 'Oct' THEN '10'
        WHEN SUBSTR(Social_Month,1,3) = 'Nov' THEN '11'
        WHEN SUBSTR(Social_Month,1,3) = 'Dec' THEN '12' 
        ELSE '00' 
        END) as Year_Month_Num, */

    select DATE_FORMAT(str_to_date(Social_Month, '%y-%b'), '%Y%m'),
           Country,
           Social_Month,
           ExtractNumber(Facebook_Fans),
           ExtractNumber(Facebook_Posts),
           ExtractNumber(Facebook_Reactions),
           ExtractNumber(Facebook_Comments),
           ExtractNumber(Facebook_Shares),
           ExtractNumber(Twitter_Fans),
           ExtractNumber(Twitter_Posts),
           ExtractNumber(Twitter_Retweets),
           ExtractNumber(Twitter_Favorites),
           ExtractNumber(Instagram_Fans),
           ExtractNumber(Instagram_Posts),
           ExtractNumber(Instagram_Likes),
           ExtractNumber(Instagram_Comments),
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
           ExtractNumber(Weibo_Followers),
           ExtractNumber(Weibo_Tweet),
           ExtractNumber(Weibo_Retweet),
           ExtractNumber(Weibo_Comment),
           ExtractNumber(Weibo_Likes),
           ExtractNumber(Weibo_Buzz),
           ExtractNumber(Weibo_Sentiment),
           ExtractNumber(Avg_view_top_3_articles),
           CASE WHEN ExtractNumber(Avg_like_top_3_articles) > 0 THEN ExtractNumber(Avg_like_top_3_articles) ELSE 0 END
    FROM Stg_MKT_Template_Social
    WHERE Social_Month <> '';

END;


