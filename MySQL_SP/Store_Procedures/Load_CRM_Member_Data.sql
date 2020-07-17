create
    definer = gilbert@`%` procedure Load_CRM_Member_Data()
BEGIN
    /*
    SELECT ReportMonth,STR_TO_DATE(ReportMonth,'%Y-%b') FROM LEVIS.Stg_CRM_Member_Data_MY;
    
    Truncate table Stg_CRM_Member_Data_MY;
    
    load data local infile 'C:\\Naveeta\\CRM Member Data\\AMA+Request_CRM+Data_20180816.csv'
    into table `Stg_CRM_Member_Data_MY`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    IGNORE 1 LINES
    (@ReportMonth, @Country, @Revenue, @PreviousYr_Revenue, @MemberRevenue, @PreviousYr_MemberRevenue, @NewMember_Revenue, @PreviousYr_NewMember_Revenue, 
    @ExistingMember_Revenue, @PreviousYr_ExistingMember_Revenue, @NonMember_Revenue, @PreviousYr_NonMember_Revenue,@NoOfTransaction, @PreviousYr_NoOfTransaction, 
    @NoOfMbrTransaction, @PreviousYr_NoOfMbrTransaction, @NewMember_Transaction, @ExistingMember_Transaction, @NoOfNonMbrTransaction, @PreviousYr_NoOfnonMbrTransaction,
    @Units, @PreviousYr_Units, @MbrUnits, @PreviousYr_MbrUnits, @NewMember_Units, @ExistingMember_Units, @NonMbrUnits, @PreviousYr_NonMbrUnits,@NewJoins, @PreviousYr_NewJoin,
    @TotalMbr, @PreviousYr_TotalMbr, @ExistingMbr)
    Set
    ReportMonth = @ReportMonth, 
    Country = @Country, 
    -- CRM_Type = @CRM_Type, 
    Revenue = @Revenue, 
    PreviousYr_Revenue = @PreviousYr_Revenue,
    MemberRevenue = @MemberRevenue,
    PreviousYr_MemberRevenue = @PreviousYr_MemberRevenue,
    NewMember_Revenue = @NewMember_Revenue, 
    PreviousYr_NewMember_Revenue = @PreviousYr_NewMember_Revenue,
    ExistingMember_Revenue = @ExistingMember_Revenue, 
    PreviousYr_ExistingMember_Revenue = @PreviousYr_ExistingMember_Revenue,
    NonMember_Revenue = @NonMember_Revenue, 
    PreviousYr_NonMember_Revenue = @PreviousYr_NonMember_Revenue,
    NoOfTransaction = @NoOfTransaction, 
    PreviousYr_NoOfTransaction = @PreviousYr_NoOfTransaction,
    NoOfMbrTransaction = @NoOfMbrTransaction,
    PreviousYr_NoOfMbrTransaction = @PreviousYr_NoOfMbrTransaction,
    -- NewMember_Transaction = @NewMember_Transaction, 
    -- ExistingMember_Transaction = @ExistingMember_Transaction, 
    NoOfNonMbrTransaction = @NoOfNonMbrTransaction, 
    PreviousYr_NoOfnonMbrTransaction = @PreviousYr_NoOfnonMbrTransaction,
    Units = @Units, 
    PreviousYr_Units = @PreviousYr_Units,
    MbrUnits = @MbrUnits,
    PreviousYr_MbrUnits = @PreviousYr_MbrUnits,
    -- NewMember_Units = @NewMember_Units, 
    -- ExistingMember_Units = @ExistingMember_Units, 
    NonMbrUnits = @NonMbrUnits, 
    PreviousYr_NonMbrUnits = @PreviousYr_NonMbrUnits,
    NewJoins = @NewJoins, 
    PreviousYr_NewJoin = @PreviousYr_NewJoin,
    TotalMbr = @TotalMbr,
    PreviousYr_TotalMbr = @PreviousYr_TotalMbr,
    ExistingMbr = @ExistingMbr;
    */

    INSERT INTO CRM_Member_Data(Year_Month_Num, ReportMonth, Country, CRM_Type, Revenue, PreviousYr_Revenue,
                                MemberRevenue,
                                PreviousYr_MemberRevenue, NewMember_Revenue, PreviousYr_NewMember_Revenue,
                                ExistingMember_Revenue, PreviousYr_ExistingMember_Revenue,
                                NonMember_Revenue, PreviousYr_NonMember_Revenue, NoOfTransaction,
                                PreviousYr_NoOfTransaction, NoOfMbrTransaction,
                                PreviousYr_NoOfMbrTransaction, NewMember_Transaction, PreviousYr_NewMember_Transaction,
                                ExistingMember_Transaction,
                                PreviousYr_ExistingMember_Transaction, NoOfNonMbrTransaction,
                                PreviousYr_NoOfnonMbrTransaction, Units, PreviousYr_Units,
                                MbrUnits, PreviousYr_MbrUnits, NewMember_Units, PreviousYr_NewMember_Units,
                                ExistingMember_Units, PreviousYr_ExistingMember_Units,
                                NonMbrUnits, PreviousYr_NonMbrUnits, NewJoins, PreviousYr_NewJoin, TotalMbr,
                                PreviousYr_TotalMbr, ExistingMbr)

    SELECT -- DATE_FORMAT(STR_TO_DATE(ReportMonth,'%m/%d/%Y'),'%Y%m'),
           CONCAT(20, SUBSTR(ReportMonth, 5, 6),
                  CASE
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Jan' THEN '01'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Feb' THEN '02'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Mar' THEN '03'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Apr' THEN '04'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'May' THEN '05'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Jun' THEN '06'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Jul' THEN '07'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Aug' THEN '08'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Sep' THEN '09'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Oct' THEN '10'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Nov' THEN '11'
                      WHEN SUBSTR(ReportMonth, 1, 3) = 'Dec' THEN '12'
                      ELSE '00'
                      END) AS Year_Month_Num,
           STR_TO_DATE(ReportMonth, '%b-%Y'),
           Country,
           'Offline'       AS CRM_Type,
           CASE WHEN Revenue > 0 THEN CONVERT(ExtractNumber(Revenue), DECIMAL(18, 2)) ELSE 0.00 END,
           CASE
               WHEN PreviousYr_Revenue > 0 THEN CONVERT(ExtractNumber(PreviousYr_Revenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE WHEN MemberRevenue > 0 THEN CONVERT(ExtractNumber(MemberRevenue), DECIMAL(18, 2)) ELSE 0.00 END,
           CASE
               WHEN PreviousYr_MemberRevenue > 0 THEN CONVERT(ExtractNumber(PreviousYr_MemberRevenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE WHEN NewMember_Revenue > 0 THEN CONVERT(ExtractNumber(NewMember_Revenue), DECIMAL(18, 2)) ELSE 0.00 END,
           CASE
               WHEN PreviousYr_NewMember_Revenue > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_NewMember_Revenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN ExistingMember_Revenue > 0 THEN CONVERT(ExtractNumber(ExistingMember_Revenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN PreviousYr_ExistingMember_Revenue > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_ExistingMember_Revenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE WHEN NonMember_Revenue > 0 THEN CONVERT(ExtractNumber(NonMember_Revenue), DECIMAL(18, 2)) ELSE 0.00 END,
           CASE
               WHEN PreviousYr_NonMember_Revenue > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_NonMember_Revenue), DECIMAL(18, 2))
               ELSE 0.00 END,
           NoOfTransaction,
           CASE
               WHEN PreviousYr_NoOfTransaction > 0
                   THEN CONVERT(ExtractNumber(PreviousYr_NoOfTransaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           NoOfMbrTransaction,
           CASE
               WHEN PreviousYr_NoOfMbrTransaction > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_NoOfMbrTransaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN NewMember_Transaction > 0 THEN CONVERT(ExtractNumber(NewMember_Transaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN PreviousYr_NewMember_Transaction > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_NewMember_Transaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           ExistingMember_Transaction,
           CASE
               WHEN PreviousYr_ExistingMember_Transaction > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_ExistingMember_Transaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN NoOfNonMbrTransaction > 0 THEN CONVERT(ExtractNumber(NoOfNonMbrTransaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE
               WHEN PreviousYr_NoOfnonMbrTransaction > 0 THEN CONVERT(
                       ExtractNumber(PreviousYr_NoOfnonMbrTransaction), DECIMAL(18, 2))
               ELSE 0.00 END,
           Units,
           CASE WHEN PreviousYr_Units > 0 THEN CONVERT(ExtractNumber(PreviousYr_Units), DECIMAL(18, 2)) ELSE 0.00 END,
           MbrUnits,
           CASE
               WHEN PreviousYr_MbrUnits > 0 THEN CONVERT(ExtractNumber(PreviousYr_MbrUnits), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE WHEN NewMember_Units > 0 THEN CONVERT(ExtractNumber(NewMember_Units), DECIMAL(18, 2)) ELSE 0.00 END,
           PreviousYr_NewMember_Units,
           ExistingMember_Units,
           PreviousYr_ExistingMember_Units,
           CASE WHEN NonMbrUnits > 0 THEN CONVERT(ExtractNumber(NonMbrUnits), DECIMAL(18, 2)) ELSE 0.00 END,
           CASE
               WHEN PreviousYr_NonMbrUnits > 0 THEN CONVERT(ExtractNumber(PreviousYr_NonMbrUnits), DECIMAL(18, 2))
               ELSE 0.00 END,
           NewJoins,
           CASE
               WHEN PreviousYr_NewJoin > 0 THEN CONVERT(ExtractNumber(PreviousYr_NewJoin), DECIMAL(18, 2))
               ELSE 0.00 END,
           TotalMbr,
           CASE
               WHEN PreviousYr_TotalMbr > 0 THEN CONVERT(ExtractNumber(PreviousYr_TotalMbr), DECIMAL(18, 2))
               ELSE 0.00 END,
           CASE WHEN ExistingMbr > 0 THEN CONVERT(ExtractNumber(ExistingMbr), DECIMAL(18, 2)) ELSE 0.00 END
    FROM Stg_CRM_Member_Data_MY;

    UPDATE CRM_Member_Data
    SET MemberRevenue      = NewMember_Revenue + ExistingMember_Revenue,
        NoOfMbrTransaction = NewMember_Transaction + ExistingMember_Transaction,
        MbrUnits           = NewMember_Units + ExistingMember_Units
    WHERE Country = 'India';

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
    WHERE Country = 'India';

    UPDATE CRM_Member_Data CRM, Dim_Country D,
        (SELECT Exch_Rate_Effect_Date, Country, USD_Planned_Rate
         FROM LEVIS.Dim_Exchange_Rate D1
         WHERE D1.Exch_Rate_Effect_Date = (SELECT MAX(D2.Exch_Rate_Effect_Date)
                                           FROM Dim_Exchange_Rate D2
                                           WHERE D1.Country = D2.Country)) Q
    SET CRM.Revenue                           = CASE
                                                    WHEN D.CRM_Curr = 'LC' THEN Q.USD_Planned_Rate * CRM.Revenue_LC
                                                    ELSE CRM.Revenue END,
        CRM.PreviousYr_Revenue                = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.PreviousYr_Revenue_LC
                                                    ELSE CRM.PreviousYr_Revenue END,
        CRM.MemberRevenue                     = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.MemberRevenue_LC
                                                    ELSE CRM.MemberRevenue END,
        CRM.PreviousYr_MemberRevenue          = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.PreviousYr_MemberRevenue_LC
                                                    ELSE CRM.PreviousYr_MemberRevenue END,
        CRM.NewMember_Revenue                 = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.NewMember_Revenue_LC
                                                    ELSE CRM.NewMember_Revenue END,
        CRM.PreviousYr_NewMember_Revenue      = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.PreviousYr_NewMember_Revenue_LC
                                                    ELSE CRM.PreviousYr_NewMember_Revenue END,
        CRM.ExistingMember_Revenue            = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.ExistingMember_Revenue_LC
                                                    ELSE CRM.ExistingMember_Revenue END,
        CRM.PreviousYr_ExistingMember_Revenue = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.PreviousYr_ExistingMember_Revenue_LC
                                                    ELSE CRM.PreviousYr_ExistingMember_Revenue END,
        CRM.NonMember_Revenue                 = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.NonMember_Revenue_LC
                                                    ELSE CRM.NonMember_Revenue END,
        CRM.PreviousYr_NonMember_Revenue      = CASE
                                                    WHEN D.CRM_Curr = 'LC'
                                                        THEN Q.USD_Planned_Rate * CRM.PreviousYr_NonMember_Revenue_LC
                                                    ELSE CRM.PreviousYr_NonMember_Revenue END
    WHERE CRM.Country = Q.Country
      AND CRM.Country = D.Country;


END;


