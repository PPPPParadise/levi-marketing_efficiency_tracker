create
    definer = kchaudhary@`%` procedure Load_Salesforce_Online()
BEGIN

    /*
    Truncate Table Stg_Salesforce_Online;
    Load Data local infile "D:\\Data\\2019_November\\CRM-Online Salesforce\\Levis_eDM_report_eeead3ef-2012-4320-8f99-dd65b5c0ac26.csv"
    into table `Stg_Salesforce_Online`
    fields terminated by ','
    ENCLOSED BY '"'
    LINES TERMINATED BY  '\n'   
    ignore 1 lines 
    (@`Name of the Business Unit`,
    @`Send Month`,
    @`Campaign Name`,
    @`Email Name`,
    @`Send Date`,
    @`Test Send Indicator`,
    @Sends,
    @Deliveries,
    @`Unique Opens`,
    @`Unique Clicks`,
    @`Unsubscribe Rate`)
    
    Set 
    `Name of the Business Unit`= @`Name of the Business Unit`,
    `Send Month`= @`Send Month`,
    `Campaign Name`= @`Campaign Name`,
    `Email Name`= @`Email Name`,
    `Send Date`=  STR_TO_DATE(@`Send Date`, "%Y-%m-%d"),
    `Test Send Indicator`= @`Test Send Indicator`,
    `Sends`= REPLACE(@`Sends`,',', ''),  
    `Deliveries`=  REPLACE(@`Deliveries`,',', ''), 
    `Unique Opens`= REPLACE(@`Unique Opens`,',', ''),  
    `Unique Clicks`= REPLACE(@`Unique Clicks`,',', ''),
    `Unsubscribe Rate`= Replace(@`Unsubscribe Rate`,"%",'');
    */

    UPDATE Stg_Salesforce_Online
    SET `Name of the Business Unit`='South Korea'
    where `Name of the Business Unit` = 'Korea';

    INSERT INTO Salesforce_Online(`Name of the Business Unit`, `Send Month`, `Campaign Name`, `Email Name`, `Send Date`,
                                  `Test Send Indicator`,
                                  `Sends`, `Deliveries`, `Unique Opens`, `Unique Clicks`, `Unsubscribe Rate`)
    SELECT `Name of the Business Unit`,
           `Send Month`,
           `Campaign Name`,
           `Email Name`,
           `Send Date`,
           `Test Send Indicator`,
           `Sends`,
           `Deliveries`,
           `Unique Opens`,
           `Unique Clicks`,
           `Unsubscribe Rate`
    FROM Stg_Salesforce_Online S

    ON DUPLICATE KEY UPDATE Salesforce_Online.`Sends`=S.`Sends`,
                            Salesforce_Online.`Deliveries`=S.`Deliveries`,
                            Salesforce_Online.`Unique Opens`=S.`Unique Opens`,
                            Salesforce_Online.`Unique Clicks`=S.`Unique Clicks`,
                            Salesforce_Online.`Unsubscribe Rate`=S.`Unsubscribe Rate`;


    UPDATE Salesforce_Online S, Dim_Calendar D
    SET S.Year_Month_Num=D.Year_Month_Num
    WHERE S.`Send Date` = D.Fiscal_Date;


END;


