create
    definer = kchaudhary@`%` procedure Load_Adobe_Salesforce()
BEGIN

    /* For Japan, the -1 in () under Substring syntax to get Tracking Code has to change to 1 */


/*select * from Stg_Adobe_Salesforce;
truncate table Stg_Adobe_Salesforce;
Load Data local infile "D:\\Data\\2019_November\\CRM Online Adobe\\Final_Japan_Report.csv"
into table `Stg_Adobe_Salesforce`
fields terminated by ','
Optionally ENCLOSED BY '"'
LINES TERMINATED BY  '\n'   
ignore 1 lines 
(@`Date`,
@`Tracking Code`,
@`Orders`,
@`Revenue`,
@`Visits`)

SET
Date= str_to_date(@`Date`,"%M %d,%Y"),
`Tracking Code`= substring_index(@`Tracking Code`,'|',-1),
Orders=@`Orders`,
Revenue=@Revenue ,
Visits= @`Visits`;
*/


    insert into Adobe_Salesforce(`Country`, `Date`, `Month`, `Tracking Code`, `Orders`, `Revenue`, `Visits`)
    select 'Japan',
           `Date`,
           concat(substr(`Date`, 3, 2), '-', D.`Fiscal_Month`),
           `Tracking Code`,
           `Orders`,
           `Revenue`,
           `Visits`
    from Stg_Adobe_Salesforce S
             inner join Dim_Calendar D on S.`Date` = D.`Fiscal_Date`

    on duplicate key update Adobe_Salesforce.`Date`= S.`Date`,
                            Adobe_Salesforce.`Orders`= Adobe_Salesforce.`Orders` + S.`Orders`,
                            Adobe_Salesforce.`Revenue`= Adobe_Salesforce.`Revenue` + S.`Revenue`,
                            Adobe_Salesforce.`Visits`= Adobe_Salesforce.`Visits` + S.`Visits`;

    update Adobe_Salesforce S, Dim_Calendar D
    SET S.Year_Month_Num=D.Year_Month_Num
    where S.`Date` = D.Fiscal_Date;

END;


