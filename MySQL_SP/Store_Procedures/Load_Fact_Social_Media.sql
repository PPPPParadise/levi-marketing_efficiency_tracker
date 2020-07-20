create
    definer = gilbert@`%` procedure Load_Fact_Social_Media()
BEGIN

    INSERT INTO Fact_Social_Media(Year_Month_Num, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Country, Region,
                                  Fiscal_Date,
                                  Medium, Fans, Prev_Fans, Prev_Year_Fans, Posts, Prev_Posts, Prev_Year_Posts,
                                  Reactions, Prev_Reactions, Prev_Year_Reactions,
                                  Shares, Prev_Shares, Prec_Year_Shares, Comments, Prev_Comments, Prev_Year_Comments)

    SELECT Year_Month_Num,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           Country,
           Region,
           Fiscal_Date,
           'Facebook',
           Facebook_Fans,
           Prev_Facebook_Fans,
           Prev_Year_Facebook_Fans,
           Facebook_Posts,
           Prev_Facebook_Posts,
           Prev_Year_Facebook_Posts,
           Facebook_Reactions,
           Prev_Facebook_Reactions,
           Prev_Year_Facebook_Reactions,
           Facebook_Shares,
           Prev_Facebook_Shares,
           Prev_Year_Facebook_Shares,
           Facebook_Comments,
           Prev_Facebook_Comments,
           Prev_Year_Facebook_Comments
    FROM Fact_DB_Social;


    INSERT INTO Fact_Social_Media(Year_Month_Num, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Country, Region,
                                  Fiscal_Date,
                                  Medium, Fans, Prev_Fans, Prev_Year_Fans, Posts, Prev_Posts, Prev_Year_Posts,
                                  Reactions, Prev_Reactions, Prev_Year_Reactions,
                                  Shares, Prev_Shares, Prec_Year_Shares)

    SELECT Year_Month_Num,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           Country,
           Region,
           Fiscal_Date,
           'Twitter',
           Twitter_Fans,
           Prev_Twitter_Fans,
           Prev_Year_Twitter_Fans,
           Twitter_Posts,
           Prev_Twitter_Posts,
           Prev_Year_Twitter_Posts,
           Twitter_Favorites,
           Prev_Twitter_Favorites,
           Prev_Year_Twitter_Favorites,
           Twitter_Retweets,
           Prev_Twitter_Retweets,
           Prev_Year_Twitter_Retweets
    FROM Fact_DB_Social;


    INSERT INTO Fact_Social_Media(Year_Month_Num, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Country, Region,
                                  Fiscal_Date,
                                  Medium, Fans, Prev_Fans, Prev_Year_Fans, Posts, Prev_Posts, Prev_Year_Posts,
                                  Reactions, Prev_Reactions, Prev_Year_Reactions,
                                  Comments, Prev_Comments, Prev_Year_Comments)

    SELECT Year_Month_Num,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           Country,
           Region,
           Fiscal_Date,
           'Instagram',
           Instagram_Fans,
           Prev_Instagram_Fans,
           Prev_Year_Instagram_Fans,
           Instagram_Posts,
           Prev_Instagram_Posts,
           Prev_Year_Instagram_Posts,
           Instagram_Likes,
           Prev_Instagram_Likes,
           Prev_Year_Instagram_Likes,
           Instagram_Comments,
           Prev_Instagram_Comments,
           Prev_Year_Instagram_Comments
    FROM Fact_DB_Social;


    INSERT INTO Fact_Social_Media(Year_Month_Num, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Country, Region,
                                  Fiscal_Date,
                                  Medium, Fans, Prev_Fans, Prev_Year_Fans, Posts, Prev_Posts, Prev_Year_Posts,
                                  Reactions, Prev_Reactions, Prev_Year_Reactions,
                                  Shares, Prev_Shares, Prec_Year_Shares, Comments, Prev_Comments, Prev_Year_Comments,
                                  Followers_Growth, Prev_Followers_Growth, Prev_Year_Followers_Growth)

    SELECT Year_Month_Num,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           Country,
           Region,
           Fiscal_Date,
           'Weibo',
           Weibo_Followers,
           Prev_Weibo_Followers,
           Prev_Year_Weibo_Followers,
           Weibo_Tweet,
           Prev_Weibo_Tweet,
           Prev_Year_Weibo_Tweet,
           Weibo_Likes,
           Prev_Weibo_Likes,
           Prev_Year_Weibo_Likes,
           Weibo_Retweet,
           Prev_Weibo_Retweet,
           Prev_Year_Weibo_Retweet,
           Weibo_Comment,
           Prev_Weibo_Comment,
           Prev_Year_Weibo_Comment,
           Weibo_Followers_Growth,
           Prev_Weibo_Followers_Growth,
           Prev_Year_Weibo_Followers_Growth
    FROM Fact_DB_Social_China1;


    INSERT INTO Fact_Social_Media(Year_Month_Num, Fiscal_Month, Fiscal_Quarter, Fiscal_Year, Country, Region,
                                  Fiscal_Date,
                                  Medium)

    SELECT Year_Month_Num,
           Fiscal_Month,
           Fiscal_Quarter,
           Fiscal_Year,
           Country,
           Region,
           Fiscal_Date,
           'WeChat'
    FROM Fact_DB_Social_China1;

END;


