create definer = gilbert@`%` view DB_CRM_View as
select `FDG`.`Region`                                                           AS `Region`,
       `FDG`.`Country`                                                          AS `Country`,
       `FDG`.`Fiscal_Quarter`                                                   AS `Fiscal_Quarter`,
       `FDG`.`Fiscal_Year`                                                      AS `Fiscal_Year_Num`,
       concat(`FDG`.`Fiscal_Month`, '-',
              substr(`FDG`.`Year_Month_Num`, 3, 2))                             AS `Year_Month_Char`,
       case when `FDG`.`Fiscal_Quarter` in ('Q1', 'Q2') then 'H1' else 'H2' end AS `Fiscal_Biannual`,
       `CURR_FISCAL_YEAR`()                                                     AS `Curr_Fiscal_Year`,
       `FDG`.`Year_Month_Num`                                                   AS `Fiscal_Month_Num`,
       `FDG`.`Fiscal_Month`                                                     AS `Fiscal_Month`,
       `FDG`.`Fiscal_Date`                                                      AS `Fiscal_Date`,
       `FDG`.`CRM_Type`                                                         AS `CRM_Type`,
       case
           when `FDG`.`Sellthru_Amt` = 0 then NULL
           else `FDG`.`Sellthru_Amt` end                                        AS `Sellthru_Amt`,
       case
           when `FDG`.`Prev_Sellthru_Amt` = 0 then NULL
           else `FDG`.`Prev_Sellthru_Amt` end                                   AS `Prev_Sellthru_Amt`,
       case
           when `FDG`.`Mem_Sellthru` = 0 then NULL
           else `FDG`.`Mem_Sellthru` end                                        AS `Mem_Sellthru`,
       case
           when `FDG`.`Prev_Mem_Sellthru` = 0 then NULL
           else `FDG`.`Prev_Mem_Sellthru` end                                   AS `Prev_Mem_Sellthru`,
       case
           when `FDG`.`NewMem_Sellthru` = 0 then NULL
           else `FDG`.`NewMem_Sellthru` end                                     AS `NewMem_Sellthru`,
       case
           when `FDG`.`Prev_NewMem_Sellthru` = 0 then NULL
           else `FDG`.`Prev_NewMem_Sellthru` end                                AS `Prev_NewMem_Sellthru`,
       case
           when `FDG`.`ExistingMem_Sellthru` = 0 then NULL
           else `FDG`.`ExistingMem_Sellthru` end                                AS `ExistingMem_Sellthru`,
       case
           when `FDG`.`Prev_ExistingMem_Sellthru` = 0 then NULL
           else `FDG`.`Prev_ExistingMem_Sellthru` end                           AS `Prev_ExistingMem_Sellthru`,
       case
           when `FDG`.`Non_Mem_Sellthru` = 0 then NULL
           else `FDG`.`Non_Mem_Sellthru` end                                    AS `Non_Mem_Sellthru`,
       case
           when `FDG`.`Prev_Non_Mem_Sellthru` = 0 then NULL
           else `FDG`.`Prev_Non_Mem_Sellthru` end                               AS `Prev_Non_Mem_Sellthru`,
       case when `FDG`.`No_Of_Trans` = 0 then NULL else `FDG`.`No_Of_Trans` end AS `No_Of_Trans`,
       case
           when `FDG`.`Prev_No_Of_Trans` = 0 then NULL
           else `FDG`.`Prev_No_Of_Trans` end                                    AS `Prev_No_Of_Trans`,
       case when `FDG`.`Mem_Trans` = 0 then NULL else `FDG`.`Mem_Trans` end     AS `Mem_Trans`,
       case
           when `FDG`.`Prev_Mem_Trans` = 0 then NULL
           else `FDG`.`Prev_Mem_Trans` end                                      AS `Prev_Mem_Trans`,
       case
           when `FDG`.`NewMem_Trans` = 0 then NULL
           else `FDG`.`NewMem_Trans` end                                        AS `NewMem_Trans`,
       case
           when `FDG`.`Prev_NewMem_Trans` = 0 then NULL
           else `FDG`.`Prev_NewMem_Trans` end                                   AS `Prev_NewMem_Trans`,
       case
           when `FDG`.`ExistingMem_Trans` = 0 then NULL
           else `FDG`.`ExistingMem_Trans` end                                   AS `ExistingMem_Trans`,
       case
           when `FDG`.`Prev_ExistingMem_Trans` = 0 then NULL
           else `FDG`.`Prev_ExistingMem_Trans` end                              AS `Prev_ExistingMem_Trans`,
       case
           when `FDG`.`Non_Mem_Trans` = 0 then NULL
           else `FDG`.`Non_Mem_Trans` end                                       AS `Non_Mem_Trans`,
       case
           when `FDG`.`Prev_Non_Mem_Trans` = 0 then NULL
           else `FDG`.`Prev_Non_Mem_Trans` end                                  AS `Prev_Non_Mem_Trans`,
       case when `FDG`.`No_Of_Units` = 0 then NULL else `FDG`.`No_Of_Units` end AS `No_Of_Units`,
       case
           when `FDG`.`Prev_No_Of_Units` = 0 then NULL
           else `FDG`.`Prev_No_Of_Units` end                                    AS `Prev_No_Of_Units`,
       case when `FDG`.`Mem_Units` = 0 then NULL else `FDG`.`Mem_Units` end     AS `Mem_Units`,
       case
           when `FDG`.`Prev_Mem_Units` = 0 then NULL
           else `FDG`.`Prev_Mem_Units` end                                      AS `Prev_Mem_Units`,
       case
           when `FDG`.`NewMem_Units` = 0 then NULL
           else `FDG`.`NewMem_Units` end                                        AS `NewMem_Units`,
       case
           when `FDG`.`Prev_NewMem_Units` = 0 then NULL
           else `FDG`.`Prev_NewMem_Units` end                                   AS `Prev_NewMem_Units`,
       case
           when `FDG`.`ExistingMem_Units` = 0 then NULL
           else `FDG`.`ExistingMem_Units` end                                   AS `ExistingMem_Units`,
       case
           when `FDG`.`Prev_ExistingMem_Units` = 0 then NULL
           else `FDG`.`Prev_ExistingMem_Units` end                              AS `Prev_ExistingMem_Units`,
       case
           when `FDG`.`Non_Mem_Units` = 0 then NULL
           else `FDG`.`Non_Mem_Units` end                                       AS `Non_Mem_Units`,
       case
           when `FDG`.`Prev_Non_Mem_Units` = 0 then NULL
           else `FDG`.`Prev_Non_Mem_Units` end                                  AS `Prev_Non_Mem_Units`,
       case
           when `FDG`.`New_Customer` = 0 then NULL
           else `FDG`.`New_Customer` end                                        AS `New_Customer`,
       case
           when `FDG`.`Prev_New_Customer` = 0 then NULL
           else `FDG`.`Prev_New_Customer` end                                   AS `Prev_New_Customer`,
       case
           when `FDG`.`Total_Customer` = 0 then NULL
           else `FDG`.`Total_Customer` end                                      AS `Total_Customer`,
       case
           when `FDG`.`Prev_Total_Customer` = 0 then NULL
           else `FDG`.`Prev_Total_Customer` end                                 AS `Prev_Total_Customer`,
       case when `FDG`.`CRM_Spend` = 0 then NULL else `FDG`.`CRM_Spend` end     AS `CRM_Spend`,
       case
           when `FDG`.`Prev_CRM_Spend` = 0 then NULL
           else `FDG`.`Prev_CRM_Spend` end                                      AS `Prev_CRM_Spend`,
       case when `FDG`.`Sellout` = 0 then NULL else `FDG`.`Sellout` end         AS `Sellout`,
       case
           when `FDG`.`Prev_Sellout` = 0 then NULL
           else `FDG`.`Prev_Sellout` end                                        AS `Prev_Sellout`,
       case
           when `FDG`.`New_Customer` = 0 then NULL
           else `FDG`.`New_Customer` end                                        AS `Acquisition`,
       case
           when `FDG`.`Prev_New_Customer` = 0 then NULL
           else `FDG`.`Prev_New_Customer` end                                   AS `Prev_Acquisition`,
       case when `FDG`.`Listening` = 0 then NULL else `FDG`.`Listening` end     AS `Listening`,
       case
           when `FDG`.`Prev_Listening` = 0 then NULL
           else `FDG`.`Prev_Listening` end                                      AS `Prev_Listening`,
       case when `FDG`.`Engagement` = 0 then NULL else `FDG`.`Engagement` end   AS `Engagement`,
       case
           when `FDG`.`Prev_Engagement` = 0 then NULL
           else `FDG`.`Prev_Engagement` end                                     AS `Prev_Engagement`,
       case
           when `FDG`.`Active_Members` = 0 then NULL
           else `FDG`.`Active_Members` end                                      AS `Active_Members`,
       case
           when `FDG`.`Prev_Active_Members` = 0 then NULL
           else `FDG`.`Prev_Active_Members` end                                 AS `Prev_Active_Members`,
       case
           when `FDG`.`Attrition_pct` = 0 then NULL
           else `FDG`.`Attrition_pct` end                                       AS `Attrition_Pct`,
       case
           when `FDG`.`Prev_Attrition_pct` = 0 then NULL
           else `FDG`.`Prev_Attrition_pct` end                                  AS `Prev_Attrition_Pct`,
       case
           when `FDG`.`Unsubscribed_pct` = 0 then NULL
           else `FDG`.`Unsubscribed_pct` end                                    AS `Unsubscribed_Pct`,
       case
           when `FDG`.`Prev_Unsubscribed_pct` = 0 then NULL
           else `FDG`.`Prev_Unsubscribed_pct` end                               AS `Prev_Unsubscribed_Pct`,
       case
           when `FDG`.`Engaged_Members` = 0 then NULL
           else `FDG`.`Engaged_Members` end                                     AS `Engaged_Members`,
       case
           when `FDG`.`Prev_Engaged_Members` = 0 then NULL
           else `FDG`.`Prev_Engaged_Members` end                                AS `Prev_Engaged_Members`,
       case
           when `FDG`.`High_Engaged_Customers` = 0 then NULL
           else `FDG`.`High_Engaged_Customers` end                              AS `High_Engaged_Customers`,
       case
           when `FDG`.`Medium_Engaged_Customers` = 0 then NULL
           else `FDG`.`Medium_Engaged_Customers` end                            AS `Medium_Engaged_Customers`,
       case
           when `FDG`.`Low_Engaged_Customers` = 0 then NULL
           else `FDG`.`Low_Engaged_Customers` end                               AS `Low_Engaged_Customers`,
       11000                                                                    AS `Prev_New_CRM_Members`,
       case
           when `FDG`.`Traffic_Count` = 0 then NULL
           else `FDG`.`Traffic_Count` end                                       AS `Traffic_Count`
from `LEVIS_MET2`.`Fact_DB_CRM` `FDG`;


