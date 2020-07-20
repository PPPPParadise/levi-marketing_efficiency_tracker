create
    definer = kchaudhary@`%` procedure Load_WeChat_Followers()
BEGIN
    /*
    load data local infile 'D:\\Data\\China_wechat_fans.csv'
    into table `WeChat_Followers`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES ;
    */

    Update WeChat_Followers
    Set Year_Month_Num = CONCAT(20, SUBSTR(Month, 1, 2),
                                CASE
                                    WHEN SUBSTR(Month, 1, 3) = 'Jan' THEN '01'
                                    WHEN SUBSTR(Month, 4, 6) = 'Feb' THEN '02'
                                    WHEN SUBSTR(Month, 4, 6) = 'Mar' THEN '03'
                                    WHEN SUBSTR(Month, 4, 6) = 'Apr' THEN '04'
                                    WHEN SUBSTR(Month, 4, 6) = 'May' THEN '05'
                                    WHEN SUBSTR(Month, 4, 6) = 'Jun' THEN '06'
                                    WHEN SUBSTR(Month, 4, 6) = 'Jul' THEN '07'
                                    WHEN SUBSTR(Month, 4, 6) = 'Aug' THEN '08'
                                    WHEN SUBSTR(Month, 4, 6) = 'Sep' THEN '09'
                                    WHEN SUBSTR(Month, 4, 6) = 'Oct' THEN '10'
                                    WHEN SUBSTR(Month, 4, 6) = 'Nov' THEN '11'
                                    WHEN SUBSTR(Month, 4, 6) = 'Dec' THEN '12'
                                    ELSE '00'
                                    END);

END;


