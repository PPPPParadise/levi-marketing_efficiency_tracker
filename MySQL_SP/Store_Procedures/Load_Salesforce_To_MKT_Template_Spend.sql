create
    definer = kchaudhary@`%` procedure Load_Salesforce_To_MKT_Template_Spend()
BEGIN


    insert into MKT_Template_Spend(Country, `Month`, Month_Num, Fiscal_Year, Campaign_Name, Execution_Name,
                                   CRM_Campaign_Start_Date, Amount_Sent, CRM_Delivered, CRM_Open, CRM_Click, CRM_Spend,
                                   CRM_Type, `Medium`, `Format`, Category, CRM_Campaign_End_Date, Responders,
                                   CRM_Revenue, Actual_Spend)
    select A.a,
           A.b,
           A.c,
           A.d,
           A.e,
           A.f,
           A.g,
           A.h,
           A.i,
           A.j,
           A.k,
           A.l,
           'Online',
           'CRM-EDM',
           'Photo',
           'CRM',
           F.`Date`,
           F.`Orders`,
           F.`Revenue`,
           A.l
    from (select S.`Name of the Business Unit`                               as a,
                 CONCAT(substring(D.Fiscal_Year, 3, 2), '-', D.Fiscal_Month) as b,
                 S.Year_Month_Num                                            as c,
                 D.Fiscal_Year                                               as d,
                 S.`Campaign Name`                                           as e,
                 S.`Email Name`                                              as f,
                 S.`Send Date`                                               as g,
                 S.`Sends`                                                   as h,
                 S.`Deliveries`                                              as i,
                 S.`Unique Opens`                                            as j,
                 S.`Unique Clicks`                                           as k,
                 S.`Deliveries` * 0.0007 * E.USD_Planned_Rate                as l
          from Salesforce_Online S
                   inner join Dim_Calendar D on S.`Send Date` = D.`Fiscal_Date`
                   inner join Dim_Exchange_Rate E on E.From_Currency = 'SGD'
          where E.Exch_Rate_Effect_Date =
                (SELECT MAX(Exch_Rate_Effect_Date) from Dim_Exchange_Rate where E.From_Currency = 'SGD')) as A
             left join Adobe_Salesforce F
                       on A.`f` = F.`Tracking Code` and A.c = F.Year_Month_Num
    where A.c = '202004';


END;


