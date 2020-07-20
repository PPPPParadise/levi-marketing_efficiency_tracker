create
    definer = pkishlay@`%` procedure Load_Organic_Search_with_Competitors()
BEGIN

    /*
    
    truncate table Stg_Organic_Search_Competitors;
    
    load data local infile 'C:\\Users\\kishlay\\Downloads\\multiTimeline (1).csv' 
    into table Stg_Organic_Search_Competitors
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 lines
    (@Search_Date,@Levis,@Comp_1,@Comp_2,@Comp_3,@Comp_4)
    Set 
    Country='***abc***',
    Search_Date=@Search_Date,
    Searches_Comp_0=@Levis,
    Searches_Comp_1=@Comp_1,
    Searches_Comp_2=@Comp_2,
    Searches_Comp_3=@Comp_3,
    Searches_Comp_4=@Comp_4;
    
    */

    insert into Organic_Search_Competitors(Country, Search_Date, `Month`, Year_Month_Num, Comp_Name, Searches)
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'India'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'India'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'H&M'                                                       as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'India'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Zara'                                                      as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'India'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Adidas'                                                    as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'India'


    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Indonesia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Uniqlo'                                                    as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Indonesia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Zara'                                                      as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Indonesia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'H&M'                                                       as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Indonesia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lois'                                                      as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Indonesia'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Malaysia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Uniqlo'                                                    as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Malaysia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Zara'                                                      as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Malaysia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'H&M'                                                       as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Malaysia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Calvin Klein'                                              as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Malaysia'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Africa'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Guess'                                                     as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Africa'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Relay'                                                     as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Africa'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Diesel'                                                    as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Africa '
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'G Star'                                                    as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Africa'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Taiwan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Edwin'                                                     as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Taiwan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Blue Way'                                                  as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Taiwan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Bobson'                                                    as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Taiwan '
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Taiwan'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Philippines'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Uniqlo'                                                    as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Philippines'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'H&M'                                                       as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Philippines'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Wrangler'                                                  as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Philippines'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Philippines'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Australia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Nudie'                                                     as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Australia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Rollas'                                                    as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Australia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Australia'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Wrangler'                                                  as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Australia'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Japan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Edwin'                                                     as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Japan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Uniqlo'                                                    as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Japan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'GAP'                                                       as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Japan'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Japan'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Korea'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'GUESS'                                                     as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Korea'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Calvin Klein'                                              as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Korea'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Buckaroo'                                                  as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Korea'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'PLAC'                                                      as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'South Korea'

    UNION

    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Levis'                                                     as Comp_Name,
           Searches_Comp_0                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Hong Kong'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Uniqlo'                                                    as Comp_Name,
           Searches_Comp_1                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Hong Kong'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'EVISU'                                                     as Comp_Name,
           Searches_Comp_2                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Hong Kong'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Lee'                                                       as Comp_Name,
           Searches_Comp_3                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Hong Kong'
    union
    select Country,
           Get_Std_Date(Search_Date)                                   as Search_Date,
           CONCAT(D.Fiscal_Month, '-', Substring(D.Fiscal_Year, 3, 2)) as Month_Char,
           D.Year_Month_Num                                            as Year_Month_Num,
           'Calvin Klein'                                              as Comp_Name,
           Searches_Comp_4                                             as Searches
    from Stg_Organic_Search_Competitors as S
             inner join Dim_Calendar as D on Get_Std_Date(Search_Date) = D.Fiscal_Date
    where Country = 'Hong Kong';

    UPDATE Organic_Search_Competitors,
        (Select Fiscal_Date, Fiscal_Quarter, Fiscal_Year, Fiscal_Month
         from Dim_Calendar
                  inner join Organic_Search_Competitors
                             on Organic_Search_Competitors.Search_Date = Dim_Calendar.Fiscal_Date) as D
    SET Quarter= D.Fiscal_Quarter,
        `Month`= D.Fiscal_Month,
        `Year`= D.Fiscal_Year,
        Biannual=(CASE
                      when (D.Fiscal_Month in ('Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May')) then 'H1'
                      when (D.Fiscal_Month in ('Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov')) then 'H2'
                      else 00
            end)
    where Search_Date = D.Fiscal_Date;


    UPDATE Organic_Search_Competitors as O,
        (Select Dim_Country.Country, Dim_Country.Region
         from Dim_Country
                  inner join Organic_Search_Competitors
                             on Organic_Search_Competitors.Country = Dim_Country.Country) as C
    SET O.Region = C.Region
    where O.Country = C.Country;


END;


