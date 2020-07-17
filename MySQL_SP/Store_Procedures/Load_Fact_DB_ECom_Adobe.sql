create
    definer = gilbert@`%` procedure Load_Fact_DB_ECom_Adobe()
BEGIN

    INSERT INTO Stg_Fact_DB_ECom (Year_Month_Num, Fiscal_Quarter, Fiscal_Year, Fiscal_Month, Country, Region, GA_Source,
                                  GA_Medium, Campaign)
    SELECT DISTINCT Q.Year_Month_Num,
                    M.Fiscal_Quarter,
                    M.Fiscal_Year,
                    M.Fiscal_Month,
                    Q.Country,
                    C.Region,
                    Q.Adobe_Source,
                    Q.Adobe_Medium,
                    Q.Campaign
    from Dim_Calendar_Month M,
         Dim_Country C,
         (SELECT DISTINCT Country, Year_Month_Num, Adobe_Source, Adobe_Medium, Campaign FROM Adobe_Data) Q
    WHERE Q.Year_Month_Num <= DATE_FORMAT(NOW(), '%Y%m')
      AND Q.Country = C.Country
      AND Q.Year_Month_Num = M.Year_Month_Num
    order by Q.Year_Month_Num, Country, Q.Adobe_Source, Q.Adobe_Medium, Q.Campaign;

    UPDATE Stg_Fact_DB_ECom SF,
        (SELECT AD.Country,
                DC.Year_Month_Num,
                AD.Adobe_Source,
                AD.Adobe_Medium,
                AD.Campaign,
                SUM(Pageviews)        Pageviews,
                SUM(Unique_Pageviews) Unique_Pageviews,
                SUM(Sessions)         Sessions,
                SUM(Session_Duration) Session_Duration,
                SUM(Bounces)          Bounces,
                SUM(Revenue)          Revenue,
                SUM(Transactions)     Transactions,
                SUM(Users)            Users,
                SUM(New_Users)        New_Users
         FROM Adobe_Data AD,
              Dim_Calendar DC
         WHERE AD.Transaction_Date = DC.Fiscal_Date
         GROUP BY AD.Country, DC.Year_Month_Num, AD.Adobe_Source, AD.Adobe_Medium, AD.Campaign) Q
    SET SF.Pageviews        = Q.Pageviews,
        SF.Unique_Pageviews = Q.Unique_Pageviews,
        SF.Sessions         = Q.Sessions,
        SF.Session_Duration = Q.Session_Duration,
        SF.Bounces          = Q.Bounces,
        SF.Revenue          = Q.Revenue,
        SF.Transactions     = Q.Transactions,
        SF.Users            = Q.Users,
        SF.New_Users        = Q.New_Users
    WHERE SF.Country = Q.Country
      AND SF.Year_Month_Num = Q.Year_Month_Num
      AND SF.GA_Source = Q.Adobe_Source
      AND SF.GA_Medium = Q.Adobe_Medium
      AND SF.Campaign = Q.Campaign;

    UPDATE Stg_Fact_DB_ECom SF,
        (SELECT CASE
                    WHEN SUBSTR(Year_Month_Num, 5, 2) = '12' THEN Year_Month_Num + 89
                    ELSE Year_Month_Num + 1 END P_Year_Month_Num,
                Country,
                GA_Source,
                GA_Medium,
                Campaign,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom) Q
    SET SF.Prev_Pageviews        = Q.Pageviews,
        SF.Prev_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Sessions         = Q.Sessions,
        SF.Prev_Session_Duration = Q.Session_Duration,
        SF.Prev_Bounces          = Q.Bounces,
        SF.Prev_Revenue          = Q.Revenue,
        SF.Prev_Transactions     = Q.Transactions,
        SF.Prev_Users            = Q.Users,
        SF.Prev_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.GA_Source = Q.GA_Source
      AND SF.GA_Medium = Q.GA_Medium
      AND SF.Campaign = Q.Campaign;

    UPDATE Stg_Fact_DB_ECom SF,
        (SELECT Year_Month_Num + 100 P_Year_Month_Num,
                Country,
                GA_Source,
                GA_Medium,
                Campaign,
                Pageviews,
                Unique_Pageviews,
                Sessions,
                Session_Duration,
                Bounces,
                Revenue,
                Transactions,
                Users,
                New_Users
         FROM Stg_Fact_DB_ECom) Q
    SET SF.Prev_Year_Pageviews        = Q.Pageviews,
        SF.Prev_Year_Unique_Pageviews = Q.Unique_Pageviews,
        SF.Prev_Year_Sessions         = Q.Sessions,
        SF.Prev_Year_Session_Duration = Q.Session_Duration,
        SF.Prev_Year_Bounces          = Q.Bounces,
        SF.Prev_Year_Revenue          = Q.Revenue,
        SF.Prev_Year_Transactions     = Q.Transactions,
        SF.Prev_Year_Users            = Q.Users,
        SF.Prev_Year_New_Users        = Q.New_Users
    WHERE SF.Year_Month_Num = Q.P_Year_Month_Num
      AND SF.Country = Q.Country
      AND SF.GA_Source = Q.GA_Source
      AND SF.GA_Medium = Q.GA_Medium
      AND SF.Campaign = Q.Campaign;
END;


