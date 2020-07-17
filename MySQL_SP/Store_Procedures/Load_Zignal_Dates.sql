create
    definer = gilbert@`%` procedure Load_Zignal_Dates(IN i_Year_Month_Num int)
BEGIN
    DECLARE v_Start_Date DATE;
    DECLARE v_End_Date DATE;
    DECLARE v_End_Date_Rec DATE;

    SET SQL_SAFE_UPDATES = 0;

    SELECT MIN(Fiscal_Date), MAX(Fiscal_Date)
    INTO v_Start_Date, v_End_Date
    FROM Dim_Calendar
    WHERE Year_Month_Num = i_Year_Month_Num;
    WHILE v_Start_Date <= v_End_Date
        DO

            SET v_End_Date_Rec = DATE_ADD(v_Start_Date, INTERVAL 4 DAY);

            IF v_End_Date_Rec >= v_End_Date THEN
                SET v_End_Date_Rec = DATE_ADD(v_End_Date, INTERVAL 1 DAY);
            END IF;

            IF v_Start_Date < v_End_Date_Rec THEN
                /*INSERT INTO Temp1 (Start_Date, End_Date)
                    VALUES (v_Start_Date, v_End_Date_Rec);*/
                INSERT INTO Zignal_Data_Sentiment_Breakdown (Profile_ID, Brand_Name, Country_ID, Country_Filter,
                                                             Country, Start_Date, End_Date, Sentiment_Breakdown_URL,
                                                             Run_Flag)
                SELECT P.Profile_ID,
                       P.Brand_Name,
                       C.Country_ID,
                       C.Country_Filter,
                       C.Country,
                       v_Start_Date,
                       v_End_Date_Rec,
                       'https://api.zignallabs.com/analytics/v1/profiles/<PROFILE_ID>/mentions/count/sentiment?gte=<START_DATE>T00%3A00%3A01Z&lt=<END_DATE>T00%3A00%3A01Z&smartFilterId=<COUNTRY_FILTER>&apikey=GGgfQu67wDVpDgf5jJYhuuJh9yxSOpCQ' URL,
                       'N'
                FROM Zignal_Profile P,
                     Zignal_Country_Filter C
                WHERE Active_Flag = 'Y';

                UPDATE Zignal_Data_Sentiment_Breakdown
                SET Sentiment_Breakdown_URL = REPLACE(
                        REPLACE(REPLACE(REPLACE(Sentiment_Breakdown_URL, '<PROFILE_ID>', Profile_ID),
                                        '<COUNTRY_FILTER>', Country_ID), '<START_DATE>', Start_Date), '<END_DATE>',
                        End_Date);

            ELSE
                SET v_End_Date_Rec = DATE_ADD(v_End_Date, INTERVAL 1 DAY);

                /*INSERT INTO Temp1 (Start_Date, End_Date)
                    VALUES (v_Start_Date, v_End_Date_Rec);*/
                INSERT INTO Zignal_Data_Sentiment_Breakdown (Profile_ID, Brand_Name, Country_ID, Country_Filter,
                                                             Country, Start_Date, End_Date, Sentiment_Breakdown_URL,
                                                             Run_Flag)
                SELECT Profile_ID,
                       Brand_Name,
                       Country_ID,
                       Country_Filter,
                       Country,
                       v_Start_Date,
                       v_End_Date_Rec,
                       'https://api.zignallabs.com/analytics/v1/profiles/<PROFILE_ID>/mentions/count/sentiment?gte=<START_DATE>T00%3A00%3A01Z&lt=<END_DATE>T00%3A00%3A01Z&smartFilterId=<COUNTRY_FILTER>&apikey=GGgfQu67wDVpDgf5jJYhuuJh9yxSOpCQ' URL,
                       'N'
                FROM Zignal_Profile P,
                     Zignal_Country_Filter C
                WHERE Active_Flag = 'Y';

                UPDATE Zignal_Data_Sentiment_Breakdown
                SET Sentiment_Breakdown_URL = REPLACE(REPLACE(REPLACE(
                                                                      REPLACE(Sentiment_Breakdown_URL, '<PROFILE_ID>', Profile_ID),
                                                                      '<COUNTRY_FILTER>', Country_ID), '<START_DATE>',
                                                              Start_Date), '<END_DATE>', End_Date);

            END IF;

            SET v_Start_Date = v_End_Date_Rec;

        END WHILE;


    COMMIT;

END;


