create
    definer = kchaudhary@`%` procedure Load_MKT_Template_Spend()
BEGIN


    /*
    SET SQL_SAFE_UPDATES =0;
     delete from Stg_MKT_Template_Spend;
     
     load data local infile 'D:\\Data\\2019_June\\Marketing_Template\\CSV\\CRM_Online_Australia.csv'
            into table `Stg_MKT_Template_Spend`
            fields terminated by ',' 
            OPTIONALLY ENCLOSED BY '"'
            ESCAPED BY '"'
            LINES TERMINATED BY '\r\n'
            IGNORE 3 LINES
     
     (@Country, @Month,@Campaign_name,@Execution_Name,@Type_of_Campaign,@Product_Line,@Influencer,@Name_of_Influencer,@Medium,@Format,@TV_Campaig_Start_Date,@TV_Campaign_End_Date,@TV_Spend_LC,@TV_Channel_name,@TV_Area_Coverage,@TV_Area_Name,
     @TV_spot_Duration,@No_of_Spots,@TV_GRP,@Validation1,@Print_Campaign_Start_Date,@Print_Campaign_End_Date,@Print_Spend_LC,@Publication_Type,@Publication_Name,@Page_Number,@Size_of_ad_dimensions,@Circulation,@Print_Impressions,@Validation2, @Radio_Campaign_Start_Date,
     @Radio_Campaign_End_Date,@Radio_Spend_LC,@Channel_Frequency,@Radio_Impressions_or_Reach,@Validation3,@OOH_Campaign_Start_Date,@OOH_Campaign_End_Date,@OOH_Spend_LC,@Type_of_OOH,@City_National,@Location,@Size_of_ad,@OTS_or_Reach,@Validation4,@Digital_Media_Type,
     @Digital_Campaign_Start_Date,@Digital_Campaign_End_Date,@Digital_Spend_LC,@Total_Impressions,@Total_Clicks,@Total_Views,@Total_Reach,@Total_Engagement,@Validation5, @CRM_Campaign_Start_Date,@CRM_Campaign_End_Date,@CRM_Spend_LC,@Amount_Sent,
     @CRM_Delivered, @CRM_Open, @CRM_Click, @Responders,@CRM_Revenue, @Validation6, 
     @PR_Media,@PR_Start_Date,@PR_End_Date,@PR_Spend_LC,@Circulation_Viewership_Hit_impressions,@Equivalent_Advertising_Value,@Validation7, @Cinema_Campaign_Start_Date,@Cinema_Campaign_End_Date,@Cinema_Spend_LC,@Cinema_spot_Duration,@Cinema_Impressions,@Validation8,
     @Others_Name_of_the_Medium,@Others_campaign_Start_Date,@Others_campaign_End_Date,@Others_campaign_Spend_LC,@Other_Impressions,@Validation9,@SE_Communication_Type,@SE_Campaign_Start_Date,@SE_Campaign_End_Date,@SE_Spend_LC,@SE_Impressions,@SE_Total_Clicks,
     @SE_Total_Views,@Validation10,@VSS_Communication_Type,@VSS_Campaign_Start_Date,@VSS_Campaign_End_Date,@VSS_Spend_LC,@VSS_Impressions_Reach,@VSS_Impressions,@VSS_Total_Views,@VSS_Total_Clicks,@Validation11,@Marketplace_Communication_Type,@Marketplace_Campaign_Start_Date,
     @Marketplace_Campaign_End_Date,@Marketplace_Spend_LC,@Ad_Impressions,@Ad_Views,@Ad_Clicks,@Validation_Flag,@Actual_Spend)
    
    Set Country = @Country,
    Month= 	@Month, 
    Campaign_name =	Replace(@Campaign_name,'\r',''),
    Execution_Name = Replace(@Execution_Name,'\r',''),
    Type_of_Campaign=	TRIM(Replace(@Type_of_Campaign,'\r','')),
    Product_Line= 	Replace(@Product_Line,'\r',''),
    Influencer= 	Replace(@Influencer,'\r',''),
    Name_of_Influencer=	Replace(@Name_of_Influencer,'\r',''),
    Medium=	Replace(@Medium,'\r',''),
    Format=	Replace(@Format,'\r',''),
    TV_Campaig_Start_Date=	Replace(@TV_Campaig_Start_Date,'/','-'),
    TV_Campaign_End_Date=	Replace(@TV_Campaign_End_Date,'/','-'),
    TV_Spend_LC=	@TV_Spend_LC,
    TV_Channel_name=	@TV_Channel_name,
    TV_Area_Coverage=	@TV_Area_Coverage,
    TV_Area_Name=	@TV_Area_Name,
    TV_spot_Duration=	@TV_spot_Duration,
    No_of_Spots=	@No_of_Spots,
    TV_GRP=	@TV_GRP,
    Print_Campaign_Start_Date=	Replace(@Print_Campaign_Start_Date,'/','-'),
    Print_Campaign_End_Date=	Replace(@Print_Campaign_End_Date,'/','-'),
    Print_Spend_LC=	@Print_Spend_LC,
    Publication_Type=	@Publication_Type,
    Publication_Name=	@Publication_Name,
    Page_Number=	@Page_Number,
    Size_of_ad_dimensions=	@Size_of_ad_dimensions,
    Circulation=	@Circulation,
    Print_Impressions=	@Print_Impressions,
    Radio_Campaign_Start_Date=	Replace(@Radio_Campaign_Start_Date,'/','-'),
    Radio_Campaign_End_Date=	Replace(@Radio_Campaign_End_Date,'/','-'),
    Radio_Spend_LC=	@Radio_Spend_LC,
    Channel_Frequency=	@Channel_Frequency,
    Radio_Impressions_or_Reach=	@Radio_Impressions_or_Reach,
    OOH_Campaign_Start_Date=	Replace(@OOH_Campaign_Start_Date,'/','-'),
    OOH_Campaign_End_Date=	Replace(@OOH_Campaign_End_Date,'/','-'),
    OOH_Spend_LC= @OOH_Spend_LC,
    Type_of_OOH=	@Type_of_OOH,
    City_National=	@City_National,
    Location=	@Location,
    Size_of_ad=	@Size_of_ad,
    OTS_or_Reach=	@OTS_or_Reach,
    Digital_Media_Type= @Digital_Media_Type,
    Digital_Campaign_Start_Date=	Replace(@Digital_Campaign_Start_Date,'/','-'),
    Digital_Campaign_End_Date=	Replace(@Digital_Campaign_End_Date,'/','-'),
    Digital_Spend_LC=	@Digital_Spend_LC,
    Total_Impressions=	@Total_Impressions,
    Total_Clicks=	@Total_Clicks,
    Total_Views=	@Total_Views,
    Total_Reach=	@Total_Reach,
    Total_Engagement=	@Total_Engagement,
    CRM_Campaign_Start_Date=	Replace(@CRM_Campaign_Start_Date,'/','-'),
    CRM_Campaign_End_Date=	Replace(@CRM_Campaign_End_Date,'/','-'),
    CRM_Spend_LC= @CRM_Spend_LC,
    Amount_Sent=	@Amount_Sent,
    CRM_Delivered = @CRM_Delivered,
    CRM_Open = @CRM_Open,
    CRM_Click = @CRM_Click,
    Responders= @Responders,
    CRM_Revenue = @CRM_Revenue,
    PR_Media=	 @PR_Media,
    PR_Start_Date = Replace(@PR_Start_Date,'/','-'),
    PR_End_Date = Replace(@PR_End_Date,'/','-'),
    PR_Spend_LC=	@PR_Spend_LC,
    Circulation_Viewership_Hit_impressions=	@Circulation_Viewership_Hit_impressions,
    Equivalent_Advertising_Value=	@Equivalent_Advertising_Value,
    Cinema_Campaign_Start_Date=	Replace(@Cinema_Campaign_Start_Date,'/','-'),
    Cinema_Campaign_End_Date=	Replace(@Cinema_Campaign_End_Date,'/','-'),
    Cinema_Spend_LC=	@Cinema_Spend_LC,
    Cinema_spot_Duration=	@Cinema_spot_Duration,
    Cinema_Impressions=	@Cinema_Impressions,
    Others_Name_of_the_Medium=	@Others_Name_of_the_Medium,
    Others_campaign_Start_Date=	Replace(@Others_campaign_Start_Date,'/','-'),
    Others_campaign_End_Date=	Replace(@Others_campaign_End_Date,'/','-'),
    Others_campaign_Spend_LC=	@Others_campaign_Spend_LC,
    Other_Impressions=	@Other_Impressions,
    SE_Communication_Type=	@SE_Communication_Type,
    SE_Campaign_Start_Date=	Replace(@SE_Campaign_Start_Date,'/','-'),
    SE_Campaign_End_Date=	Replace(@SE_Campaign_End_Date,'/','-'),
    SE_Spend_LC= @SE_Spend_LC,
    SE_Impressions=	@SE_Impressions,
    SE_Total_Clicks=	@SE_Total_Clicks,
    SE_Total_Views=	@SE_Total_Views,
    VSS_Communication_Type=	@VSS_Communication_Type,
    VSS_Campaign_Start_Date=	Replace(@VSS_Campaign_Start_Date,'/','-'),
    VSS_Campaign_End_Date=	Replace(@VSS_Campaign_End_Date,'/','-'),
    VSS_Spend_LC=	@VSS_Spend_LC,
    VSS_Impressions_Reach=	@VSS_Impressions_Reach,
    VSS_Impressions = @VSS_Impressions,
    VSS_Total_Views=	@VSS_Total_Views,
    VSS_Total_Clicks=	@VSS_Total_Clicks,
    Marketplace_Communication_Type=	@Marketplace_Communication_Type,
    Marketplace_Campaign_Start_Date=	Replace(@Marketplace_Campaign_Start_Date,'/','-'),
    Marketplace_Campaign_End_Date=	Replace(@Marketplace_Campaign_End_Date,'/','-'),
    Marketplace_Spend_LC=	@Marketplace_Spend_LC,
    Ad_Impressions=	@Ad_Impressions,
    Ad_Views=	@Ad_Views,
    Ad_Clicks=	@Ad_Clicks,
    Validation_Flag=	@Validation_Flag,
    Actual_Spend=	@Actual_Spend;
    
    DELETE from Stg_MKT_Template_Spend where Month IN ( '' ,'Month*');
    UPDATE Stg_MKT_Template_Spend set CRM_Revenue = REPLACE(CRM_Revenue,'$', '');
    
    update Stg_MKT_Template_Spend
    SET TV_Spend_LC = Replace(Replace(TV_Spend_LC,',',''),'$',''),
            Print_Spend_LC = Replace(Replace(Print_Spend_LC,',',''),'$',''),
            Radio_Spend_LC = Replace(Replace(Radio_Spend_LC,',',''),'$',''),
            OOH_Spend_LC = Replace(Replace(OOH_Spend_LC,',',''),'$',''),
            Digital_Spend_LC = Replace(Replace(Digital_Spend_LC,',',''),'$',''),
            CRM_Spend_LC = Replace(Replace(CRM_Spend_LC,',',''),'$',''),
            CRM_Revenue = Replace(Replace(CRM_Revenue,',',''),'$',''),
            Amount_Sent = Replace(Replace(Amount_Sent,',',''),'$',''),
            Responders = Replace(Replace(Responders,',',''),'$',''),
            CRM_Delivered = Replace(Replace(CRM_Delivered,',',''),'$',''),
            CRM_Click = Replace(Replace(CRM_Click,',',''),'$',''),
            CRM_Open = Replace(Replace(CRM_Open,',',''),'$',''),
            PR_Spend_LC = Replace(Replace(PR_Spend_LC,',',''),'$',''),
            Cinema_Spend_LC = Replace(Replace(Cinema_Spend_LC,',',''),'$',''),
            Others_campaign_Spend_LC = Replace(Replace(Others_campaign_Spend_LC,',',''),'$',''),
            SE_Spend_LC = Replace(Replace(SE_Spend_LC,',',''),'$',''),
            VSS_Spend_LC = Replace(Replace(VSS_Spend_LC,',',''),'$',''),
            Marketplace_Spend_LC = Replace(Replace(Marketplace_Spend_LC,',',''),'$',''),
            Equivalent_Advertising_Value_LC = Replace(Replace(Equivalent_Advertising_Value_LC,',',''),'$',''),
            Actual_Spend = Replace(Replace(Actual_Spend,',',''),'$','');
    
      IF the File is in Local Curency then following script 
    update Stg_MKT_Template_Spend T,
        (SELECT Exch_Rate_Effect_Date, Country, USD_Planned_Rate FROM LEVIS.Dim_Exchange_Rate D1
                           WHERE D1.Exch_Rate_Effect_Date = (SELECT MAX(D2.Exch_Rate_Effect_Date) FROM Dim_Exchange_Rate D2 
                                                     WHERE D1.Country = D2.Country)) Q
    SET TV_Spend = TV_Spend_LC * USD_Planned_Rate,
            Print_Spend = Print_Spend_LC * Q.USD_Planned_Rate,
            Radio_Spend = Radio_Spend_LC * Q.USD_Planned_Rate,
            OOH_spend = OOH_Spend_LC * Q.USD_Planned_Rate,
            Digital_Spend = Digital_Spend_LC *Q.USD_Planned_Rate,
            CRM_Spend = CRM_Spend_LC * Q.USD_Planned_Rate,
            PR_Spend = PR_Spend_LC * Q.USD_Planned_Rate,
            Cinema_Spend = Cinema_Spend_LC * Q.USD_Planned_Rate,
            Others_campaign_Spend = Others_campaign_Spend_LC * Q.USD_Planned_Rate,
            SE_Spend = SE_Spend_LC * Q.USD_Planned_Rate,
            VSS_Spend = VSS_Spend_LC * Q.USD_Planned_Rate,
            Marketplace_Spend = Marketplace_Spend_LC * Q.USD_Planned_Rate,
            Equivalent_Advertising_Value = Equivalent_Advertising_Value_LC * Q.USD_Planned_Rate,
            Actual_Spend = Actual_Spend * Q.USD_Planned_Rate
            WHERE T.Country = Q.Country;
            
            
      IF the File is in USD then following script      
    update Stg_MKT_Template_Spend
    SET TV_Spend = TV_Spend_LC ,
            Print_Spend = Print_Spend_LC ,
            Radio_Spend = Radio_Spend_LC,
            OOH_spend = OOH_Spend_LC ,
            Digital_Spend = Digital_Spend_LC,
            CRM_Spend = CRM_Spend_LC,
            PR_Spend = PR_Spend_LC,
            Cinema_Spend = Cinema_Spend_LC ,
            Others_campaign_Spend = Others_campaign_Spend_LC,
            SE_Spend = SE_Spend_LC ,
            VSS_Spend = VSS_Spend_LC ,
            Marketplace_Spend = Marketplace_Spend_LC,
            Equivalent_Advertising_Value = Equivalent_Advertising_Value_LC,
            Actual_Spend = Actual_Spend ;
            
    -- delete MKT_Template_Spend_Test only once for a month
    
    delete from MKT_Template_Spend_Test
    
    INSERT INTO MKT_Template_Spend_Test(
    Month, Month_Num, Country, Campaign_name, Execution_Name, Type_of_Campaign, Product_Line, Influencer,Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date, TV_Spend, 
     TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP, Print_Campaign_Start_Date, Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions, Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend,
     Channel_Frequency, Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH, City_National, Location, Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date, Digital_Campaign_End_Date, Digital_Spend, Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, 
     Total_Reach, Total_Engagement, CRM_Campaign_Start_Date, CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent , Responders, CRM_Delivered, CRM_Open, CRM_Click, PR_Media, PR_Start_Date, PR_End_Date, Date_Month_of_Issue, Media_Title, Headline_Programe, PR_Spend , Circulation_Viewership_Hit_impressions, Page_Area_Length, 
     Equivalent_Advertising_Value, Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage, Cinema_Campaign_Start_Date, Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, Others_Name_of_the_Medium, Others_campaign_Start_Date, Others_campaign_End_Date, 
     Others_campaign_Spend, Other_Impressions, SE_Communication_Type, SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views, VSS_Communication_Type, VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions, VSS_Total_Views, VSS_Total_Clicks, 
     Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date, Marketplace_Spend, Ad_Impressions, Ad_Views, Ad_Clicks,Validation_Flag, Actual_Spend,File_Name
    )  
    -- TV_Area_Coverage, TV_Area_Name,
    SELECT 
    Month,
    CONCAT(20,SUBSTR(Month,1,2),
                                    CASE WHEN SUBSTR(Month,4,3) = 'Jan' THEN '01'
                                                    WHEN SUBSTR(Month,4,3) = 'Feb' THEN '02'
                                                    WHEN SUBSTR(Month,4,3) = 'Mar' THEN '03'
                                                    WHEN SUBSTR(Month,4,3) = 'Apr' THEN '04'
                                                    WHEN SUBSTR(Month,4,3) = 'May' THEN '05'
                                                    WHEN SUBSTR(Month,4,3) = 'Jun' THEN '06'
                                                    WHEN SUBSTR(Month,4,3) = 'Jul' THEN '07'
                                                    WHEN SUBSTR(Month,4,3) = 'Aug' THEN '08'
                                                    WHEN SUBSTR(Month,4,3) = 'Sep' THEN '09'
                                                    WHEN SUBSTR(Month,4,3) = 'Oct' THEN '10'
                                                    WHEN SUBSTR(Month,4,3) = 'Nov' THEN '11'
                                                    WHEN SUBSTR(Month,4,3) = 'Dec' THEN '12'    
                                                    ELSE '00' 
    END) AS month_num,
    Country,
    TRIM(Campaign_name),
    Execution_Name,
    UPPER(Type_of_Campaign),
    Product_Line,
    CASE WHEN Influencer IS NULL THEN '' ELSE Influencer END ,
    Name_of_Influencer,
    TRIM(Medium),
    Format,
    STR_TO_DATE(REPLACE(TV_Campaig_Start_Date,'/','-'),'%d-%m-%Y') TV_Campaig_Start_Date,
    STR_TO_DATE(REPLACE(TV_Campaign_End_Date,'/','-'),'%d-%m-%Y') TV_Campaign_End_Date,
    CASE WHEN ExtractNumber(TV_Spend) > 0 THEN CONVERT(ExtractNumber(TV_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN TV_Channel_name IS NULL THEN '' ELSE TV_Channel_name END,
    TV_Area_Coverage, TV_Area_Name,
    CASE WHEN ExtractNumber(TV_spot_Duration) > 0 THEN CONVERT(ExtractNumber(TV_spot_Duration), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(No_of_Spots) > 0 THEN CONVERT(ExtractNumber(No_of_Spots), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(TV_GRP) > 0 THEN CONVERT(ExtractNumber(TV_GRP), DECIMAL(18,2)) ELSE 0.0000 END,
    STR_TO_DATE(REPLACE(Print_Campaign_Start_Date,'/','-'),'%d-%m-%Y') Print_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(Print_Campaign_End_Date,'/','-'),'%d-%m-%Y') Print_Campaign_End_Date,
    CASE WHEN ExtractNumber(Print_Spend) > 0 THEN CONVERT(ExtractNumber(Print_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Publication_Type IS NULL THEN '' ELSE TRIM(Publication_Type) END,
    CASE WHEN Publication_Name IS NULL THEN '' ELSE Publication_Name END,
    CASE WHEN Page_Number IS NULL THEN '' ELSE Page_Number END,
    CASE WHEN Size_of_ad_dimensions IS NULL THEN '' ELSE Size_of_ad_dimensions END,
    CASE WHEN ExtractNumber(Circulation) > 0 THEN CONVERT(ExtractNumber(Circulation), DECIMAL(18,2)) ELSE 0.0000 END, 
    CASE WHEN ExtractNumber(Print_Impressions) > 0 THEN CONVERT(ExtractNumber(Print_Impressions), DECIMAL(18,2)) ELSE 0.0000 END,
    STR_TO_DATE(REPLACE(Radio_Campaign_Start_Date,'/','-'),'%d-%m-%Y') Radio_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(Radio_Campaign_End_Date,'/','-'),'%d-%m-%Y') Radio_Campaign_End_Date,
    CASE WHEN ExtractNumber(Radio_Spend) > 0 THEN CONVERT(ExtractNumber(Radio_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Channel_Frequency) > 0 THEN CONVERT(ExtractNumber(Channel_Frequency), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Radio_Impressions_or_Reach) > 0 THEN CONVERT(ExtractNumber(Radio_Impressions_or_Reach), DECIMAL(18,2)) ELSE 0.0000 END,
    STR_TO_DATE(REPLACE(OOH_Campaign_Start_Date,'/','-'),'%d-%m-%Y') OOH_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(OOH_Campaign_End_Date,'/','-'),'%d-%m-%Y') OOH_Campaign_End_Date,
    CASE WHEN ExtractNumber(OOH_spend) > 0 THEN CONVERT(ExtractNumber(OOH_spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Type_of_OOH IS NULL THEN '' ELSE Type_of_OOH END,
    CASE WHEN City_National IS NULL THEN '' ELSE City_National END,
    CASE WHEN Location IS NULL THEN '' ELSE Location END,
    CASE WHEN Size_of_ad IS NULL THEN '' ELSE Size_of_ad END,
    Frequency,
    CASE WHEN ExtractNumber(OTS_or_Reach) > 0 THEN CONVERT(ExtractNumber(OTS_or_Reach), DECIMAL(18,2)) ELSE 0.0000 END,
    TRIM(Digital_Media_Type),
    STR_TO_DATE(REPLACE(Digital_Campaign_Start_Date,'/','-'),'%d-%m-%Y') Digital_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(Digital_Campaign_End_Date,'/','-'),'%d-%m-%Y') Digital_Campaign_End_Date,
    CASE WHEN ExtractNumber(Digital_Spend) > 0 THEN CONVERT(ExtractNumber(Digital_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Total_Impressions) > 0 THEN CONVERT(ExtractNumber(Total_Impressions), DECIMAL(18,2)) ELSE 0.0000 END, 
    CASE WHEN ExtractNumber(Total_Clicks) > 0 THEN CONVERT(ExtractNumber(Total_Clicks), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Total_Views) > 0 THEN CONVERT(ExtractNumber(Total_Views), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Avg_Frequency <> '' THEN CONVERT(ExtractNumber(Avg_Frequency), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Total_Reach) > 0 THEN CONVERT(ExtractNumber(Total_Reach), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Total_Engagement) > 0 THEN CONVERT(ExtractNumber(Total_Engagement), DECIMAL(18,2)) ELSE 0.0000 END,
    STR_TO_DATE(REPLACE(CRM_Campaign_Start_Date,'/','-'),'%d-%m-%Y'),
    STR_TO_DATE(REPLACE(CRM_Campaign_End_Date,'/','-'),'%d-%m-%Y'),
    CASE WHEN ExtractNumber(CRM_Spend) > 0 THEN CONVERT(ExtractNumber(CRM_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(CRM_Revenue) > 0 THEN CONVERT(ExtractNumber(CRM_Revenue), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Amount_Sent) > 0 THEN CONVERT(ExtractNumber(Amount_Sent), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Responders) > 0 THEN CONVERT(ExtractNumber(Responders), DECIMAL(18,2)) ELSE 0.0000 END,
    ExtractNumber(CRM_Delivered), 
    ExtractNumber(CRM_Open), 
    ExtractNumber(CRM_Click),
    CASE WHEN PR_Media IS NULL THEN '' ELSE TRIM(PR_Media) END,
    STR_TO_DATE(REPLACE(PR_Start_Date,'/','-'),'%d-%m-%Y') PR_Start_Date,
    STR_TO_DATE(REPLACE(PR_End_Date,'/','-'),'%d-%m-%Y') PR_End_Date,
    STR_TO_DATE(REPLACE(Date_Month_of_Issue,'/','-'),'%d-%m-%Y') Date_Month_of_Issue,
    CASE WHEN Media_Title IS NULL THEN '' ELSE Media_Title END,
    CASE WHEN Headline_Programe IS NULL THEN '' ELSE Headline_Programe END, 
    CASE WHEN ExtractNumber(PR_Spend) > 0 THEN CONVERT(ExtractNumber(PR_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Circulation_Viewership_Hit_impressions) > 0 THEN CONVERT(ExtractNumber(Circulation_Viewership_Hit_impressions),DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Page_Area_Length IS NULL THEN '' ELSE Page_Area_Length END,
    CASE WHEN ExtractNumber(Equivalent_Advertising_Value) > 0 THEN CONVERT(ExtractNumber(Equivalent_Advertising_Value), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Mentioning_Levis_Headline_content IS NULL THEN '' ELSE Mentioning_Levis_Headline_content END,
    CASE WHEN Nature_of_Coverage IS NULL THEN '' ELSE Nature_of_Coverage END,
    CASE WHEN Type_of_Coverage IS NULL THEN '' ELSE Type_of_Coverage END,
    CASE WHEN Tonality IS NULL THEN '' ELSE Tonality END,
    CASE WHEN Topics_of_Coverage IS NULL THEN '' ELSE Topics_of_Coverage END,
    STR_TO_DATE(REPLACE(Cinema_Campaign_Start_Date,'/','-'),'%d-%m-%Y') Cinema_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(Cinema_Campaign_End_Date,'/','-'),'%d-%m-%Y') Cinema_Campaign_End_Date,
    CASE WHEN ExtractNumber(Cinema_Spend) > 0 THEN CONVERT(ExtractNumber(Cinema_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Cinema_spot_Duration IS NULL THEN '' ELSE Cinema_spot_Duration END,
    CASE WHEN ExtractNumber(Cinema_Impressions) > 0 THEN CONVERT(ExtractNumber(Cinema_Impressions), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Others_Name_of_the_Medium IS NULL THEN '' ELSE TRIM(Others_Name_of_the_Medium) END,
    STR_TO_DATE(REPLACE(Others_campaign_Start_Date,'/','-'),'%d-%m-%Y') Others_campaign_Start_Date,
    STR_TO_DATE(REPLACE(Others_campaign_End_Date,'/','-'),'%d-%m-%Y') Others_campaign_End_Date,
    CASE WHEN ExtractNumber(Others_campaign_Spend) > 0 THEN CONVERT(ExtractNumber(Others_campaign_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Other_Impressions) > 0 THEN CONVERT(ExtractNumber(Other_Impressions), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN SE_Communication_Type IS NULL THEN '' ELSE TRIM(SE_Communication_Type) END,
    STR_TO_DATE(REPLACE(SE_Campaign_Start_Date,'/','-'),'%d-%m-%Y') SE_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(SE_Campaign_End_Date,'/','-'),'%d-%m-%Y') SE_Campaign_End_Date,
    CASE WHEN ExtractNumber(SE_Spend) > 0 THEN CONVERT(ExtractNumber(SE_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(SE_Impressions) > 0 THEN CONVERT(ExtractNumber(SE_Impressions), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(SE_Total_Clicks) > 0 THEN CONVERT(ExtractNumber(SE_Total_Clicks), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(SE_Total_Views) > 0 THEN CONVERT(ExtractNumber(SE_Total_Views), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN VSS_Communication_Type IS NULL THEN '' ELSE TRIM(VSS_Communication_Type) END,
    STR_TO_DATE(REPLACE(VSS_Campaign_Start_Date,'/','-'),'%d-%m-%Y') VSS_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(VSS_Campaign_End_Date,'/','-'),'%d-%m-%Y') VSS_Campaign_End_Date,
    CASE WHEN ExtractNumber(VSS_Spend) > 0 THEN CONVERT(ExtractNumber(VSS_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(VSS_Impressions_Reach) > 0 THEN CONVERT(ExtractNumber(VSS_Impressions_Reach), DECIMAL(18,2)) ELSE 0.0000 END, 
    CASE WHEN ExtractNumber(VSS_Impressions) > 0 THEN CONVERT(ExtractNumber(VSS_Impressions), DECIMAL(18,2)) ELSE 0.0000 END, 
    CASE WHEN ExtractNumber(VSS_Total_Views) > 0 THEN CONVERT(ExtractNumber(VSS_Total_Views), DECIMAL(18,2)) ELSE 0.0000 END, 
    CASE WHEN ExtractNumber(VSS_Total_Clicks) > 0 THEN CONVERT(ExtractNumber(VSS_Total_Clicks), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN Marketplace_Communication_Type IS NULL THEN '' ELSE TRIM(Marketplace_Communication_Type) END,
    STR_TO_DATE(REPLACE(Marketplace_Campaign_Start_Date,'/','-'),'%d-%m-%Y') Marketplace_Campaign_Start_Date,
    STR_TO_DATE(REPLACE(Marketplace_Campaign_End_Date,'/','-'),'%d-%m-%Y') Marketplace_Campaign_End_Date, 
    CASE WHEN ExtractNumber(Marketplace_Spend) > 0 THEN CONVERT(ExtractNumber(Marketplace_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Ad_Impressions) > 0 THEN CONVERT(ExtractNumber(Ad_Impressions), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Ad_Views) > 0 THEN CONVERT(ExtractNumber(Ad_Views), DECIMAL(18,2)) ELSE 0.0000 END,
    CASE WHEN ExtractNumber(Ad_Clicks) > 0 THEN CONVERT(ExtractNumber(Ad_Clicks), DECIMAL(18,2)) ELSE 0.0000 END,
    ExtractNumber(Validation_Flag),
    CASE WHEN ExtractNumber(Actual_Spend) > 0 THEN CONVERT(ExtractNumber(Actual_Spend), DECIMAL(18,2)) ELSE 0.0000 END,
    'CRM_Online_Australia'
    FROM Stg_MKT_Template_Spend; 
    
    
    UPDATE Map_Medium_Category D INNER JOIN MKT_Template_Spend M ON M.Medium=D.Com_Medium 
       SET M.Category=D.Category;
    
    UPDATE MKT_Template_Spend_Test MTS INNER JOIN Campaign_Mapping CM ON TRIM(MTS.Campaign_name) = TRIM(CM.Campaign_name_New)
         AND MTS.Country = CM.Country
            SET MTS.Campaign_name = CM.Campaign_name_Final,
             MTS.Type_of_Campaign = CM.Type_of_Campaign_New;     
    
    
    Update MKT_Template_Spend_Test MTS, Dim_Calendar DC
     Set MTS.Fiscal_Year = DC.Fiscal_Year
           WHERE MTS.Month_Num = DC.Year_Month_Num;
           
     -- Depends on Req (put sms data with online CRM_Type) 
     
    UPDATE  MKT_Template_Spend_Test  set CRM_Type = 'Online' where File_Name = 'CRM_Online_Australia'
     and Medium in ('Email', 'CRM-EDM', 'SMS', 'CRM-SMS', 'WeChat', 'CRM - EDM', 'CRM - SMS');  
     
     
    INSERT into MKT_Template_Spend (Month, Month_Num, Fiscal_Year, Country, Campaign_name, Execution_Name, Type_of_Campaign, Product_Line, Influencer, Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date, TV_Spend, TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP, Print_Campaign_Start_Date, Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions, Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend, Channel_Frequency, Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH, City_National, Location, Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date, Digital_Campaign_End_Date, Digital_Spend, Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, Total_Reach, Total_Engagement, CRM_Type, CRM_Campaign_Start_Date, CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent, Responders, CRM_Delivered, CRM_Open, CRM_Click, PR_Media, PR_Start_Date, PR_End_Date, Date_Month_of_Issue, Media_Title, Headline_Programe, PR_Spend, Circulation_Viewership_Hit_impressions, Page_Area_Length, Equivalent_Advertising_Value, Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage, Cinema_Campaign_Start_Date, Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, TPRC_Impressions, Others_Name_of_the_Medium, Others_campaign_Start_Date, Others_campaign_End_Date, Others_campaign_Spend, Other_Impressions, SE_Communication_Type, SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views, VSS_Communication_Type, VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions, VSS_Total_Views, VSS_Total_Clicks, Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date, Marketplace_Spend, Ad_Impressions, Ad_Views, Ad_Clicks, Validation_Flag, Actual_Spend, Created_Date, Updated_Date, Category)
    select Month, Month_Num, Fiscal_Year, Country, Campaign_name, Execution_Name, Type_of_Campaign, Product_Line, Influencer, Name_of_Influencer, Medium, Format, TV_Campaig_Start_Date, TV_Campaign_End_Date, TV_Spend, TV_Channel_name, TV_Area_Coverage, TV_Area_Name, TV_spot_Duration, No_of_Spots, TV_GRP, Print_Campaign_Start_Date, Print_Campaign_End_Date, Print_Spend, Publication_Type, Publication_Name, Page_Number, Size_of_ad_dimensions, Circulation, Print_Impressions, Radio_Campaign_Start_Date, Radio_Campaign_End_Date, Radio_Spend, Channel_Frequency, Radio_Impressions_or_Reach, OOH_Campaign_Start_Date, OOH_Campaign_End_Date, OOH_spend, Type_of_OOH, City_National, Location, Size_of_ad, Frequency, OTS_or_Reach, Digital_Media_Type, Digital_Campaign_Start_Date, Digital_Campaign_End_Date, Digital_Spend, Total_Impressions, Total_Clicks, Total_Views, Avg_Frequency, Total_Reach, Total_Engagement, CRM_Type, CRM_Campaign_Start_Date, CRM_Campaign_End_Date, CRM_Spend, CRM_Revenue, Amount_Sent, Responders, CRM_Delivered, CRM_Open, CRM_Click, PR_Media, PR_Start_Date, PR_End_Date, Date_Month_of_Issue, Media_Title, Headline_Programe, PR_Spend, Circulation_Viewership_Hit_impressions, Page_Area_Length, Equivalent_Advertising_Value, Mentioning_Levis_Headline_content, Nature_of_Coverage, Type_of_Coverage, Tonality, Topics_of_Coverage, Cinema_Campaign_Start_Date, Cinema_Campaign_End_Date, Cinema_Spend, Cinema_spot_Duration, Cinema_Impressions, TPRC_Impressions, Others_Name_of_the_Medium, Others_campaign_Start_Date, Others_campaign_End_Date, Others_campaign_Spend, Other_Impressions, SE_Communication_Type, SE_Campaign_Start_Date, SE_Campaign_End_Date, SE_Spend, SE_Impressions, SE_Total_Clicks, SE_Total_Views, VSS_Communication_Type, VSS_Campaign_Start_Date, VSS_Campaign_End_Date, VSS_Spend, VSS_Impressions_Reach, VSS_Impressions, VSS_Total_Views, VSS_Total_Clicks, Marketplace_Communication_Type, Marketplace_Campaign_Start_Date, Marketplace_Campaign_End_Date, Marketplace_Spend, Ad_Impressions, Ad_Views, Ad_Clicks, Validation_Flag, Actual_Spend, Created_Date, Updated_Date, Category
    from MKT_Template_Spend_Test;
    
    update  MKT_Template_Spend 
    set Type_of_Campaign = 'BRAND'
    where SUBSTR(Type_of_Campaign, 1,5) ='BRAND';
    
    update  MKT_Template_Spend 
    set Type_of_Campaign = 'PRODUCT'
    where SUBSTR(Type_of_Campaign, 1,7) ='PRODUCT';
    
    update  MKT_Template_Spend 
    set Type_of_Campaign = 'EOSS'
    where SUBSTR(Type_of_Campaign, 1,4) ='EOSS';
    
    update  MKT_Template_Spend 
    set Type_of_Campaign = 'OTHERS'
    where SUBSTR(Type_of_Campaign, 1,6) IN ('Others', 'OTHERS');
    
    update  MKT_Template_Spend 
    set Type_of_Campaign = 'BRAND'
    where Type_of_Campaign = '';
    
    update  MKT_Template_Spend 
    set Medium = 'Other - Digital'
    where Medium ='Digital';
    
    \*run after adding data into campaign_mapping table*\
    
    UPDATE MKT_Template_Spend MTS , Campaign_Mapping CM 
            SET MTS.Campaign_name = CM.Campaign_name_Final,
             MTS.Type_of_Campaign = CM.Type_of_Campaign_New
             where  MTS.Campaign_name = CM.Campaign_name_New
         AND MTS.Country = CM.Country;
         
    Update MKT_Template_Spend Set 
     TV_Spend = CASE WHEN TV_Spend IS NULL THEN 0 ELSE TV_Spend END ,
     Print_Spend = CASE WHEN Print_Spend IS NULL THEN 0 ELSE Print_Spend END,
     Radio_Spend = CASE WHEN Radio_Spend IS NULL THEN 0 ELSE Radio_Spend END,
     OOH_spend = CASE WHEN OOH_spend IS NULL THEN 0 ELSE OOH_spend END,
     Digital_Spend = CASE WHEN Digital_Spend IS NULL THEN 0 ELSE Digital_Spend END,
     CRM_Spend = CASE WHEN CRM_Spend IS NULL THEN 0 ELSE CRM_Spend END,
     PR_Spend = CASE WHEN PR_Spend IS NULL THEN 0 ELSE PR_Spend END,
     Cinema_Spend = CASE WHEN Cinema_Spend IS NULL THEN 0 ELSE Cinema_Spend END,
     Others_campaign_Spend = CASE WHEN Others_campaign_Spend IS NULL THEN 0 ELSE Others_campaign_Spend END,
     SE_Spend = CASE WHEN SE_Spend IS NULL THEN 0 ELSE SE_Spend END,
     VSS_Spend = CASE WHEN VSS_Spend IS NULL THEN 0 ELSE VSS_Spend END,
     Marketplace_Spend = CASE WHEN Marketplace_Spend IS NULL THEN 0 ELSE Marketplace_Spend END;
    */


END;


