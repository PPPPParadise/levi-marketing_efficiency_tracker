create
    definer = gilbert@`%` procedure Run_Pending_Job_Pr()
BEGIN

    DECLARE v_InPro_Count, v_Job_ID, v_Year_Month_Num INT;
    DECLARE v_Job_Type char(15);
    DECLARE v_Country, v_Template_Type char(40);
    DECLARE v_Uploaded_By, v_Approved_By char(30);

    SELECT COUNT(1)
    INTO v_InPro_Count
    FROM Job_Info
    WHERE Job_Status = 'P';

    IF v_InPro_Count = 0 THEN

        SELECT Job_ID, Job_Type, C.Year_Month_Num, Country, Template_Type, Uploaded_By, Approved_By
        INTO v_Job_ID, v_Job_Type, v_Year_Month_Num, v_Country, v_Template_Type, v_Uploaded_By, v_Approved_By
        FROM Job_Info J,
             (SELECT Year_Month_Num, MAX(Fiscal_Date) Max_Fiscal_Date
              FROM Dim_Calendar
              GROUP BY Year_Month_Num) C
        WHERE J.Year_Month_Num = C.Year_Month_Num
          AND CASE
                  WHEN Job_Status = 'Y' THEN 0
                  WHEN Job_Type = 'Approve' AND Job_Status = 'N' AND DATEDIFF(CURRENT_DATE(), Max_Fiscal_Date) < 5
                      THEN 0
                  ELSE 1
                  END = 1
        ORDER BY Job_ID ASC
        LIMIT 1;

        UPDATE Job_Info
        SET Job_Status    = 'P',
            Process_Start = current_timestamp()
        WHERE Job_ID = v_Job_ID;
        COMMIT;

        IF v_Job_Type = 'Upload' THEN
            CALL Submit_Mkt_Template_Job_Pr(v_Job_ID, v_Country, v_Year_Month_Num, v_Template_Type, v_Uploaded_By);
        ELSEIF v_Job_Type = 'Approve' THEN
            CALL Approve_Mkt_Template_Job_Pr(v_Job_ID, v_Country, v_Year_Month_Num, v_Approved_By, v_Template_Type);
        ELSEIF v_Job_Type = 'Full_Run' THEN
            CALL Full_Run_Pr(v_Job_ID);
        END IF;

        UPDATE Job_Info
        SET Job_Status      = 'Y',
            Process_End     = current_timestamp(),
            Email_Sent_Flag = 'Y'
        WHERE Job_ID = v_Job_ID;
        COMMIT;

    END IF;
END;


