create
    definer = pkishlay@`%` procedure Load_CRM_Member_Data_New()
BEGIN
    /*
    Truncate table Stg_CRM_Member_Data_MY;
    
    load data local infile 'D:\\Prashant\\Consolidated_MET2_CRM.csv'
    into table `Stg_CRM_Member_Data_MY`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '"'
    LINES TERMINATED BY  '\r\n'   
    IGNORE 1 LINES
    (@ReportMonth, @Country, @Revenue, @NewMember_Revenue, @ExistingMember_Revenue, @NonMember_Revenue, @NoOfTransaction, @NewMember_Transaction, 
    @ExistingMember_Transaction, @NoOfNonMbrTransaction, @Units, @NewMember_Units, @ExistingMember_Units, @NonMbrUnits, @NewJoins, @TotalMbr,
    @Active_Members,@Attrition,@Unsubscribed,@High_Engaged_Customers,@Medium_Engaged_Customers,@Low_Engaged_Customers)
    Set
    ReportMonth = @ReportMonth, 
    Country = @Country,
    Revenue = @Revenue,
    MemberRevenue = @NewMember_Revenue + @ExistingMember_Revenue,
    NewMember_Revenue = @NewMember_Revenue,
    ExistingMember_Revenue = @ExistingMember_Revenue,
    NonMember_Revenue = @NonMember_Revenue,
    NoOfTransaction = @NoOfTransaction,
    NoOfMbrTransaction = @NewMember_Transaction +  @ExistingMember_Transaction,
    NewMember_Transaction = @NewMember_Transaction,
    ExistingMember_Transaction = @ExistingMember_Transaction,
    NoOfNonMbrTransaction = @NoOfNonMbrTransaction,
    Units = @Units,
    MbrUnits =  @NewMember_Units + @ExistingMember_Units,
    NewMember_Units = @NewMember_Units,
    ExistingMember_Units = @ExistingMember_Units,
    NonMbrUnits = @NonMbrUnits,
    NewJoins = @NewJoins,
    TotalMbr = @TotalMbr,
    Active_Members=@Active_Members,
    Attrition_pct=@Attrition,
    Unsubscribed_pct=@Unsubscribed,
    High_Engaged_Customers=@High_Engaged_Customers,
    Medium_Engaged_Customers=@Medium_Engaged_Customers,
    Low_Engaged_Customers=@Low_Engaged_Customers;
    */
    UPDATE Stg_CRM_Member_Data_MY SET Country = TRIM(Country);

    UPDATE Stg_CRM_Member_Data_MY SET ReportMonth = TRIM(ReportMonth);

    DELETE FROM Stg_CRM_Member_Data_MY WHERE ReportMonth = '';

    UPDATE Stg_CRM_Member_Data_MY
    SET Year_Month_Num = CONCAT(20, SUBSTR(ReportMonth, 1, 2),
                                CASE
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Jan' THEN '01'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Feb' THEN '02'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Mar' THEN '03'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Apr' THEN '04'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'May' THEN '05'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Jun' THEN '06'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Jul' THEN '07'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Aug' THEN '08'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Sep' THEN '09'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Oct' THEN '10'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Nov' THEN '11'
                                    WHEN SUBSTR(ReportMonth, 4, 3) = 'Dec' THEN '12'
                                    ELSE '00'
                                    END);
    --   ?????? ---------  ----------------------------------------                                     

-- ??? --------------------------------------------------------------------
-- Before Insertion, check if CRM_Type is online or offline

    INSERT INTO CRM_Member_Data(Year_Month_Num, ReportMonth, Country,
                                CRM_Type, Revenue, PreviousYr_Revenue,
                                MemberRevenue, PreviousYr_MemberRevenue, NewMember_Revenue,
                                PreviousYr_NewMember_Revenue, ExistingMember_Revenue, PreviousYr_ExistingMember_Revenue,
                                NonMember_Revenue, PreviousYr_NonMember_Revenue, NoOfTransaction,
                                PreviousYr_NoOfTransaction, NoOfMbrTransaction, PreviousYr_NoOfMbrTransaction,
                                NewMember_Transaction, PreviousYr_NewMember_Transaction, ExistingMember_Transaction,
                                PreviousYr_ExistingMember_Transaction, NoOfNonMbrTransaction,
                                PreviousYr_NoOfnonMbrTransaction,
                                Units, PreviousYr_Units, MbrUnits,
                                PreviousYr_MbrUnits, NewMember_Units, PreviousYr_NewMember_Units,
                                ExistingMember_Units, PreviousYr_ExistingMember_Units, NonMbrUnits,
                                PreviousYr_NonMbrUnits, NewJoins, PreviousYr_NewJoin,
                                TotalMbr, PreviousYr_TotalMbr, ExistingMbr,
                                Active_Members, Engaged_Members, Attrition_pct,
                                Unsubscribed_pct, High_Engaged_Customers, Medium_Engaged_Customers,
                                Low_Engaged_Customers)
    SELECT Year_Month_Num,
           STR_TO_DATE(ReportMonth, '%b-%y'),
           Country,
           'Offline',
           Revenue,
           PreviousYr_Revenue,
           MemberRevenue,
           PreviousYr_MemberRevenue,
           NewMember_Revenue,
           PreviousYr_NewMember_Revenue,
           ExistingMember_Revenue,
           PreviousYr_ExistingMember_Revenue,
           NonMember_Revenue,
           PreviousYr_NonMember_Revenue,
           NoOfTransaction,
           PreviousYr_NoOfTransaction,
           NoOfMbrTransaction,
           PreviousYr_NoOfMbrTransaction,
           NewMember_Transaction,
           PreviousYr_NewMember_Transaction,
           ExistingMember_Transaction,
           PreviousYr_ExistingMember_Transaction,
           NoOfNonMbrTransaction,
           PreviousYr_NoOfnonMbrTransaction,
           Units,
           PreviousYr_Units,
           MbrUnits,
           PreviousYr_MbrUnits,
           NewMember_Units,
           PreviousYr_NewMember_Units,
           ExistingMember_Units,
           PreviousYr_ExistingMember_Units,
           NonMbrUnits,
           PreviousYr_NonMbrUnits,
           NewJoins,
           PreviousYr_NewJoin,
           TotalMbr,
           PreviousYr_TotalMbr,
           ExistingMbr,
           Active_Members,
           Engaged_Members,
           Attrition_pct,
           Unsubscribed_pct,
           High_Engaged_Customers,
           Medium_Engaged_Customers,
           Low_Engaged_Customers
    FROM Stg_CRM_Member_Data_MY;

-- Copy same value to both columns

    UPDATE CRM_Member_Data
    SET Revenue_LC                           = Revenue,
        PreviousYr_Revenue_LC                = PreviousYr_Revenue,
        MemberRevenue_LC                     = MemberRevenue,
        PreviousYr_MemberRevenue_LC          = PreviousYr_MemberRevenue,
        NewMember_Revenue_LC                 = NewMember_Revenue,
        PreviousYr_NewMember_Revenue_LC      = PreviousYr_NewMember_Revenue,
        ExistingMember_Revenue_LC            = ExistingMember_Revenue,
        PreviousYr_ExistingMember_Revenue_LC = PreviousYr_ExistingMember_Revenue,
        NonMember_Revenue_LC                 = NonMember_Revenue,
        PreviousYr_NonMember_Revenue_LC      = PreviousYr_NonMember_Revenue
    WHERE CRM_Type = 'Offline'
      and Year_Month_Num = 201902;

-- Run below one only if its in local currency

    UPDATE CRM_Member_Data CRM, Dim_Country D,
        (SELECT Exch_Rate_Effect_Date, Country, USD_Planned_Rate
         FROM LEVIS.Dim_Exchange_Rate D1
         WHERE D1.Exch_Rate_Effect_Date = (SELECT MAX(D2.Exch_Rate_Effect_Date)
                                           FROM Dim_Exchange_Rate D2
                                           WHERE D1.Country = D2.Country)) Q
    SET CRM.Revenue                           = Q.USD_Planned_Rate * CRM.Revenue_LC,
        CRM.PreviousYr_Revenue                = Q.USD_Planned_Rate * CRM.PreviousYr_Revenue_LC,
        CRM.MemberRevenue                     = Q.USD_Planned_Rate * CRM.MemberRevenue_LC,
        CRM.PreviousYr_MemberRevenue          = Q.USD_Planned_Rate * CRM.PreviousYr_MemberRevenue_LC,
        CRM.NewMember_Revenue                 = Q.USD_Planned_Rate * CRM.NewMember_Revenue_LC,
        CRM.PreviousYr_NewMember_Revenue      =Q.USD_Planned_Rate * CRM.PreviousYr_NewMember_Revenue_LC,
        CRM.ExistingMember_Revenue            = Q.USD_Planned_Rate * CRM.ExistingMember_Revenue_LC,
        CRM.PreviousYr_ExistingMember_Revenue = Q.USD_Planned_Rate * CRM.PreviousYr_ExistingMember_Revenue_LC,
        CRM.NonMember_Revenue                 = Q.USD_Planned_Rate * CRM.NonMember_Revenue_LC,
        CRM.PreviousYr_NonMember_Revenue      = Q.USD_Planned_Rate * CRM.PreviousYr_NonMember_Revenue_LC
    WHERE CRM_Type = 'Offline'
      and Year_Month_Num = 201902
      AND CRM.Country = Q.Country
      AND CRM.Country = D.Country;


    UPDATE CRM_Member_Data S,
        (SELECT Country,
                Year_Month_Num + 100 P_Year_Month_Num,
                Revenue,
                MemberRevenue,
                NewMember_Revenue,
                ExistingMember_Revenue,
                NonMember_Revenue,
                NoOfTransaction,
                NoOfMbrTransaction,
                NewMember_Transaction,
                ExistingMember_Transaction,
                NoOfNonMbrTransaction,
                Units,
                MbrUnits,
                NewMember_Units,
                ExistingMember_Units,
                NonMbrUnits,
                NewJoins,
                TotalMbr
         FROM CRM_Member_Data
         WHERE CRM_Type = 'Online') Q
    SET S.PreviousYr_Revenue                    = Q.Revenue,
        S.PreviousYr_MemberRevenue              = Q.MemberRevenue,
        S.PreviousYr_NewMember_Revenue          = Q.NewMember_Revenue,
        S.PreviousYr_ExistingMember_Revenue     = Q.ExistingMember_Revenue,
        S.PreviousYr_NonMember_Revenue          = Q.NonMember_Revenue,
        S.PreviousYr_NoOfTransaction            = Q.NoOfTransaction,
        S.PreviousYr_NoOfMbrTransaction         = Q.NoOfMbrTransaction,
        S.PreviousYr_NewMember_Transaction      = Q.NewMember_Transaction,
        S.PreviousYr_ExistingMember_Transaction = Q.ExistingMember_Transaction,
        S.PreviousYr_NoOfnonMbrTransaction      = Q.NoOfnonMbrTransaction,
        S.PreviousYr_Units                      = Q.Units,
        S.PreviousYr_MbrUnits                   = Q.MbrUnits,
        S.PreviousYr_NewMember_Units            = Q.NewMember_Units,
        S.PreviousYr_ExistingMember_Units       = Q.ExistingMember_Units,
        S.PreviousYr_NonMbrUnits                = Q.NonMbrUnits,
        S.PreviousYr_NewJoin                    = Q.NewJoins,
        S.PreviousYr_TotalMbr                   = Q.TotalMbr
    WHERE S.Country = Q.Country
      AND S.Year_Month_Num = Q.P_Year_Month_Num
      AND CRM_Type = 'Online';

    UPDATE CRM_Member_Data S,
        (SELECT Country,
                Year_Month_Num + 100 P_Year_Month_Num,
                Revenue,
                MemberRevenue,
                NewMember_Revenue,
                ExistingMember_Revenue,
                NonMember_Revenue,
                NoOfTransaction,
                NoOfMbrTransaction,
                NewMember_Transaction,
                ExistingMember_Transaction,
                NoOfNonMbrTransaction,
                Units,
                MbrUnits,
                NewMember_Units,
                ExistingMember_Units,
                NonMbrUnits,
                NewJoins,
                TotalMbr
         FROM CRM_Member_Data
         WHERE CRM_Type = 'Offline') Q
    SET S.PreviousYr_Revenue                    = Q.Revenue,
        S.PreviousYr_MemberRevenue              = Q.MemberRevenue,
        S.PreviousYr_NewMember_Revenue          = Q.NewMember_Revenue,
        S.PreviousYr_ExistingMember_Revenue     = Q.ExistingMember_Revenue,
        S.PreviousYr_NonMember_Revenue          = Q.NonMember_Revenue,
        S.PreviousYr_NoOfTransaction            = Q.NoOfTransaction,
        S.PreviousYr_NoOfMbrTransaction         = Q.NoOfMbrTransaction,
        S.PreviousYr_NewMember_Transaction      = Q.NewMember_Transaction,
        S.PreviousYr_ExistingMember_Transaction = Q.ExistingMember_Transaction,
        S.PreviousYr_NoOfnonMbrTransaction      = Q.NoOfnonMbrTransaction,
        S.PreviousYr_Units                      = Q.Units,
        S.PreviousYr_MbrUnits                   = Q.MbrUnits,
        S.PreviousYr_NewMember_Units            = Q.NewMember_Units,
        S.PreviousYr_ExistingMember_Units       = Q.ExistingMember_Units,
        S.PreviousYr_NonMbrUnits                = Q.NonMbrUnits,
        S.PreviousYr_NewJoin                    = Q.NewJoins,
        S.PreviousYr_TotalMbr                   = Q.TotalMbr
    WHERE S.Country = Q.Country
      AND S.Year_Month_Num = Q.P_Year_Month_Num
      AND CRM_Type = 'Offline';

END;


