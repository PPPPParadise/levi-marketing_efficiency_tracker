create
    definer = gilbert@`%` procedure Load_MKT_Template_Budget()
BEGIN
    INSERT INTO MKT_Template_Budget
        (Year_Quater, Budget_Amount, Quater, Budget_Year, Country)

    SELECT CONCAT(20, SUBSTR(TRIM(Quater), 3, 2), SUBSTR(TRIM(Quater), 6, 2)),
           CAST(Budget AS DECIMAL(18, 2)),
           SUBSTR(TRIM(Quater), 6, 2),
           CONCAT(20, SUBSTR(TRIM(Quater), 3, 2)),
           Country
    FROM Stg_MKT_Template_Budget
    WHERE Budget = Budget * 1
      AND Budget * 1 > 0;

END;


