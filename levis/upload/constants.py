# XLSX_TEMPLATE_TYPE_NAME_MAPPING = {"1":"Marketing_Template_ATL_Unified",
#                                    "2":"Marketing_Template_Digital_Unified",
#                                    "3":"Marketing_Template_PR",
#                                    "4":"Marketing_Template_CRM"
#                                   }

XLSX_TEMPLATE_TYPE_NAME_MAPPING = {"1":"ATL",
                                   "2":"Digital",
                                   "3":"PR",
                                   "4":"CRM"
                                  }

XLSX_TEMPLATE_TYPE_NAME_MAPPING_TO_ID = {"ATL":"1",
                                        "Digital":"2",
                                        "PR":"3",
                                        "CRM":"4"
                                        }
                                                                     
XLSX_COLUMN_MAPPING = {
    "1":["Month*", "Campaign name*", "Camapign Execution","Type of Campaign (Product or Brand or EOSS)*",
         "Product Line (if product campaign)", "Influencer","Name of Influencer", "Medium*","Format (Text/Video/Photo, Audio etc.)",
         "Type of ATL","Campaign Start Date*(DD-MM-YYYY)","Campaign End Date*(DD-MM-YYYY)", "Total Spend *",
         "GRP/ Impressions/ Reach*", "Channel/ Publication/ Area name","TV Spot duration (in secs)"],
    "2":["Month*", "Campaign name*", "Camapign Execution","Type of Campaign (Product or Brand or EOSS)*",
         "Product Line (if product campaign)", "Influencer","Name of Influencer", "Medium*","Format (Text/Video/Photo, Audio etc.)", 
         "Communication Type*","Campaign Start Date*(DD-MM-YYYY)","Campaign End Date*(DD-MM-YYYY)", "Total Spend*",
         "Total Reach","Total Impressions", "Total Clicks", "Linked Clicks","Total Views","Total Engagement (Likes/Reactions/Fav+ Comment+Shares/retweets)","Acquisition"],
    "3":['Month*', 'Campaign name*', 'Campaign Execution','Type of Campaign (Product or Brand or EOSS)*',
         'Product Line (if product campaign)', 'Influencer','Name of Influencer', 'Medium*','Format (Text/Video/Photo, Audio etc.)', 
         'PR Media*','Start Date(DD-MM-YYYY)*', 'End Date(DD-MM-YYYY)*', 'PR Spend*','Circulation/ Viewership/ Hit Rates (Impressions)', 
         'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)',
         'Equivalent Advertising Value', 'Validation Flag', 'Remarks'],
    "4":['Month*', 'Campaign name*', 'Campaign Execution','Type of Campaign (Product or Brand or EOSS)*',
         'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*','Format (Text/Video/Photo, Audio etc.)',
         'CRM Campaign Start Date*(DD-MM-YYYY)', 'CRM Campaign End Date*(DD-MM-YYYY)', 'CRM Spend*','No of SMS/  Email Sent*', 
         'Delivered', 'Opened', 'Clicked','Responders (no of purchasers amongst recipients of communication)',
         'Revenue from Campaign', 'Validation Flag', 'Remarks'] 
}

XLSX_ACTUAL_COLUMN_MAPPING = {
    "1": ['Month*', 'Campaign name*', 'Campaign Execution', 'Type of Campaign (Product or Brand or EOSS)*',
          'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*', 'Format (Text/Video/Photo, Audio etc.)',
          'Type of ATL','Campaign Start Date*\n(DD-MM-YYYY)', 'Campaign End Date*\n(DD-MM-YYYY)', 'Total Spend *',
          'GRP/ Impressions/ Reach*', 'Channel/ Publication/ Area name', 'TV Spot duration (in secs)'],
    
    "2": ['Month*', 'Campaign name*', 'Campaign Execution', 'Type of Campaign (Product or Brand or EOSS)*',
          'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*', 'Format (Text/Video/Photo, Audio etc.)', 
          'Communication Type*', 'Campaign Start Date*\n(DD-MM-YYYY)', 'Campaign End Date*\n(DD-MM-YYYY)', 'Total Spend*', 'Total Reach',
          'Total \nImpressions', 'Total \nClicks', 'Linked Clicks', 'Total \nViews',   
          'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)','Acquisition',],

#     "2": ['Month*', 'Campaign name*', 'Campaign Execution', 'Type of Campaign (Product or Brand or EOSS)*',
#           'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*', 'Format (Text/Video/Photo, Audio etc.)', 
#           'Communication Type*', 'Campaign Start Date*\n(DD-MM-YYYY)', 'Campaign End Date*\n(DD-MM-YYYY)', 'Total Spend*', 'Total \nImpressions', 
#           'Total Reach','Total \nViews','Total \nClicks', 'Linked Clicks', 'Acquisition',
#           'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)'],
    
    "3": ['Month*', 'Campaign name*', 'Campaign Execution', 'Type of Campaign (Product or Brand or EOSS)*',
          'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*', 'Format (Text/Video/Photo, Audio etc.)', 
          'PR Media*', 'Start Date\n(DD-MM-YYYY)*', 'End Date\n(DD-MM-YYYY)*', 'PR Spend*', 
          'Circulation/ Viewership/ Hit Rates (Impressions)', 'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)', 
          'Equivalent Advertising Value'],

    "4": ['Month*', 'Campaign name*', 'Campaign Execution', 'Type of Campaign (Product or Brand or EOSS)*',
          'Product Line (if product campaign)', 'Influencer', 'Name of Influencer', 'Medium*', 'Format (Text/Video/Photo, Audio etc.)',
          'CRM Campaign Start Date*\n(DD-MM-YYYY)', 'CRM Campaign End Date*\n(DD-MM-YYYY)', 'CRM Spend*',
          'No of SMS/  Email Sent*', 'Delivered', 'Opened', 'Clicked', 'Responders (no of purchasers amongst recipients of communication)',
          'Revenue from Campaign']
}

START_DATE_END_DATE_COLUMN_MAPPING = {
    '1': {
          'start_date_column':'Campaign Start Date*\n(DD-MM-YYYY)',
          'end_date_column':'Campaign End Date*\n(DD-MM-YYYY)'
        },
    '2': {
          'start_date_column':'Campaign Start Date*\n(DD-MM-YYYY)',
          'end_date_column':'Campaign End Date*\n(DD-MM-YYYY)'},
    '3': {
          'start_date_column':'Start Date\n(DD-MM-YYYY)*',
          'end_date_column':'End Date\n(DD-MM-YYYY)*'
        },
    '4': {
          'start_date_column':'CRM Campaign Start Date*\n(DD-MM-YYYY)',
          'end_date_column':'CRM Campaign End Date*\n(DD-MM-YYYY)'
        }
}

DGTL_TMPLT_SOCIAL_NET = ["Facebook", "Instagram", "Twitter", "Spotify", "Line", "DU", "Weibo", "WeChat", "Programmatic Banner", 
                         "Programmatic Video", "FreakOut - Native Out", "SMS LBA","Rich Media Banner","Publisher - Banner",
                         "Publisher - Content", "Digital - APP", "Other - Digital"]
DGTL_TMPLT_BROWSER_NET = ["Google", "Yahoo", "Baidu", "Naver", "Other Search engines"]
DGTL_TMPLT_APPS = ["YouTube", "YOU KU", "Other Video Sharing sites", "Tencent", "Tik Tok", "Red", "IQIYI", "Netease"]
DGTL_TMPLT_ECOMMERCE = ["Flipkart", "Amazon", "Zalora", "Zozotown", "Lazada", "JD.com","Tmall","Other Marketplaces"]

INSERT_QUERY_MAPPING_DICT = {'1':{
                              #     'TV' : 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                              #             Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                              #             TV_Campaig_Start_Date,TV_Campaign_End_Date,TV_Spend,TV_Spend_LC,TV_Channel_name,\
                              #             TV_Area_Coverage,TV_Area_Name,TV_spot_Duration,No_of_Spots,TV_GRP)values{0};',
                                  'TV' : 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                          Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                          TV_ATL_Type,TV_Campaig_Start_Date,TV_Campaign_End_Date,TV_Spend_LC,TV_GRP,\
                                          TV_Channel_name,TV_spot_Duration,Cur_Type,Process_Flag,Template_Name,Template_Id,Created_By,Updated_By)values{0};',
                                  
                                  'Print': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                          Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                          Publication_Type,Print_Campaign_Start_Date,Print_Campaign_End_Date,Print_Spend_LC,Print_Impressions,\
                                          Publication_Name,Print_spot_Duration,Cur_Type,Process_Flag,Template_Name,Template_Id,Created_By,Updated_By)values{0}',
                                #   'Print': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                #           Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                #           Print_Campaign_Start_Date,Print_Campaign_End_Date,Print_Spend_LC,Print_Impressions,\
                                #           Publication_Name,Publication_Type,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0}',
                                'Radio': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Radio_ATL_Type,Radio_Campaign_Start_Date,\
                                          Radio_Campaign_End_Date,Radio_Spend_LC,Radio_Impressions_or_Reach,Channel_Frequency,Radio_spot_Duration,\
                                          Cur_Type,Process_Flag,Template_Name,Template_Id,Created_By,Updated_By)values{0};',
                                #   'Radio': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                #           Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Radio_Campaign_Start_Date,\
                                #           Radio_Campaign_End_Date,Radio_Spend_LC,Radio_Impressions_or_Reach,Channel_Frequency,Radio_Duration,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};',
                                'OOH': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Type_of_OOH,OOH_Campaign_Start_Date,\
                                          OOH_Campaign_End_Date,OOH_spend_LC,OTS_or_Reach,Location,OOH_spot_Duration,Cur_Type,Process_Flag,Template_Name,\
                                          Template_Id,Created_By,Updated_By)values{0};',  
                                #   'OOH': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                #           Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,OOH_Campaign_Start_Date,\
                                #           OOH_Campaign_End_Date,OOH_spend_LC,OTS_or_Reach,Location,Type_of_OOH,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};',
                                'Cinema': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Cinema_ATL_Type,Cinema_Campaign_Start_Date,\
                                          Cinema_Campaign_End_Date,Cinema_Spend_LC,Cinema_Impressions,Cinema_Channel_Name,Cinema_spot_Duration,\
                                          Cur_Type,Process_Flag,Template_Name,Template_Id,Created_By,Updated_By)values{0}',
                                #   'Cinema': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                #           Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Cinema_Campaign_Start_Date,\
                                #           Cinema_Campaign_End_Date,Cinema_Spend_LC,Cinema_Impressions,Cinema_Channel_Name,Cinema_spot_Duration,\
                                #           Cur_Type,Process_Flag,Template_Name,Template_Id)values{0}',
                                'Others': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Others_ATL_Type,\
                                          Others_campaign_Start_Date,Others_campaign_End_Date,Others_campaign_Spend_LC,\
                                          Other_Impressions,Others_Name_of_the_Medium,Others_campaign_Duration,Cur_Type,Process_Flag,\
                                          Template_Name,Template_Id,Created_By,Updated_By)values{0};',
                                # 'Others': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                #           Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                #           Others_campaign_Start_Date,Others_campaign_End_Date,Others_campaign_Spend_LC,\
                                #           Other_Impressions,Others_Name_of_the_Medium,Others_campaign_Duration,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};'
                                
                                'BE Spend': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Others_ATL_Type,\
                                          Others_campaign_Start_Date,Others_campaign_End_Date,Others_campaign_Spend_LC,\
                                          Other_Impressions,Others_Name_of_the_Medium,Others_campaign_Duration,Cur_Type,Process_Flag,\
                                          Template_Name,Template_Id,Created_By,Updated_By)values{0};',
                                
                                'Broadcast SMS': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,Others_ATL_Type,\
                                          Others_campaign_Start_Date,Others_campaign_End_Date,Others_campaign_Spend_LC,\
                                          Other_Impressions,Others_Name_of_the_Medium,Others_campaign_Duration,Cur_Type,Process_Flag,\
                                          Template_Name,Template_Id,Created_By,Updated_By)values{0};'
                                  },
                              '2':{'digital_social_platform': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                                            Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                                            Format,Digital_Media_Type,Digital_Campaign_Start_Date,Digital_Campaign_End_Date,\
                                                            Digital_Spend_LC,Total_Reach,Total_Impressions,Total_Clicks,Linked_Clicks,\
                                                            Total_Views,Total_Engagement,Digital_Acquisition,Cur_Type,Process_Flag,\
                                                            Template_Name,Template_Id,Created_By,Updated_By)values{0};',

                                # 'digital_social_platform': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                #                             Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                #                             Format,Digital_Media_Type,Digital_Campaign_Start_Date,Digital_Campaign_End_Date,\
                                #                             Digital_Spend_LC,Total_Reach,Total_Impressions,Total_Clicks,Linked_Clicks,\
                                #                             Total_Views,Total_Engagement,Digital_Acquisition,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};'
                                'digital_browser': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                                            Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                                            Format,SE_Communication_Type,SE_Campaign_Start_Date,SE_Campaign_End_Date,\
                                                            SE_Spend_LC,SE_Reach,SE_Impressions,SE_Total_Clicks,SE_Linked_Clicks,SE_Total_Views,\
                                                            SE_Engagement,SE_Acquisition,Cur_Type,Process_Flag,Template_Name,Template_Id,\
                                                            Created_By,Updated_By)values{0};',


                                #    'digital_browser': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                #                             Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                #                             Format,SE_Communication_Type,SE_Campaign_Start_Date,SE_Campaign_End_Date,\
                                #                             SE_Spend_LC,SE_Impressions,SE_Reach,SE_Total_Clicks,SE_Linked_Clicks,SE_Total_Views,\
                                #                             SE_Engagement,SE_Acquisition,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};',
                                
                                
                                   'digital_video_apps': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                                            Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                                            Format,VSS_Communication_Type,VSS_Campaign_Start_Date,VSS_Campaign_End_Date,\
                                                            VSS_Spend_LC,VSS_Impressions_Reach,VSS_Impressions,VSS_Total_Clicks,VSS_Linked_Clicks,VSS_Total_Views,\
                                                            VSS_Engagement,VSS_Acquisition,Cur_Type,Process_Flag,Template_Name,\
                                                            Template_Id,Created_By,Updated_By)values{0};',
                                
                                #    'digital_video_apps': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                #                             Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,\
                                #                             Format,VSS_Communication_Type,VSS_Campaign_Start_Date,VSS_Campaign_End_Date,\
                                #                             VSS_Spend_LC,VSS_Impressions_Reach,VSS_Impressions,VSS_Linked_Clicks,VSS_Total_Views,\
                                #                             VSS_Total_Clicks,VSS_Acquisition,VSS_Engagement,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};',
                                   
                                   'digital_ecommerce': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                                            Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                                            Marketplace_Communication_Type,Marketplace_Campaign_Start_Date,\
                                                            Marketplace_Campaign_End_Date,Marketplace_Spend_LC,Ad_Reach,Ad_Impressions,\
                                                            Ad_Clicks,Ad_Linked_Clicks,Ad_Views,Ad_Engagement,Ad_Acquisition,Cur_Type,\
                                                            Process_Flag,Template_Name,Template_Id,Created_By,Updated_By)values{0};'
                                
                                #    'digital_ecommerce': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,\
                                #                             Execution_Name,Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                #                             Marketplace_Communication_Type,Marketplace_Campaign_Start_Date,\
                                #                             Marketplace_Campaign_End_Date,Marketplace_Spend_LC,Ad_Impressions,\
                                #                             Ad_Reach,Ad_Clicks,Ad_Linked_Clicks,Ad_Views,Ad_Engagement,Ad_Acquisition,Cur_Type,Process_Flag,Template_Name,Template_Id)values{0};'
                                   },
                              '3':{'PR': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                          Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,PR_Media,PR_Start_Date,\
                                          PR_End_Date,PR_Spend_LC,Circulation_Viewership_Hit_impressions,PR_Total_Engagement,\
                                          Equivalent_Advertising_Value_LC,Cur_Type,Process_Flag,Template_Name,\
                                          Template_Id,Created_By,Updated_By)values{0};'},
                              
                              '4':{'CRM-EDM': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                                Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                                CRM_Campaign_Start_Date,CRM_Campaign_End_Date,CRM_Spend_LC,Amount_Sent, \
                                                CRM_Delivered,CRM_Open,CRM_Click,Responders,CRM_Revenue,Cur_Type,Process_Flag, \
                                                Template_Name,Template_Id,Created_By,Updated_By)values{0};', 
                                    
                                   'CRM-SMS': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                                Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                                CRM_Campaign_Start_Date,CRM_Campaign_End_Date,CRM_Spend_LC,Amount_Sent, \
                                                CRM_Delivered,CRM_Open,CRM_Click,Responders,CRM_Revenue,Cur_Type,Process_Flag, \
                                                Template_Name,Template_Id,Created_By,Updated_By)values{0};', 
                                   'CRM-WeChat': 'insert into MKT_Template_Spend(Month,Month_Num,Fiscal_Year,Country,Campaign_name,Execution_Name,\
                                                Type_of_Campaign,Product_Line,Influencer,Name_of_Influencer,Medium,Format,\
                                                CRM_Campaign_Start_Date,CRM_Campaign_End_Date,CRM_Spend_LC,Amount_Sent, \
                                                CRM_Delivered,CRM_Open,CRM_Click,Responders,CRM_Revenue,Cur_Type,Process_Flag, \
                                                Template_Name,Template_Id,Created_By,Updated_By)values{0};'
                                   }
                              }

TEMPLATE_MEDIUM_COLUMN_MAPPING = {
        'CRM': {'CRM-EDM':["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                           "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium",
                           "Format","CRM_Campaign_Start_Date","CRM_Campaign_End_Date","CRM_Spend_LC","Amount_Sent",
                           "CRM_Delivered","CRM_Open","CRM_Click","Responders","CRM_Revenue"],
                'CRM-SMS':["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                           "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium",
                           "Format","CRM_Campaign_Start_Date","CRM_Campaign_End_Date","CRM_Spend_LC","Amount_Sent",
                           "CRM_Delivered","CRM_Open","CRM_Click","Responders","CRM_Revenue"],
                'CRM-WeChat':["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                           "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium",
                           "Format","CRM_Campaign_Start_Date","CRM_Campaign_End_Date","CRM_Spend_LC","Amount_Sent",
                           "CRM_Delivered","CRM_Open","CRM_Click","Responders","CRM_Revenue"]
                },
        'PR': {'PR':["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                     "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium","Format",
                     "PR_Media","PR_Start_Date","PR_End_Date","PR_Spend_LC","Circulation_Viewership_Hit_impressions",
                     "PR_Total_Engagement","Equivalent_Advertising_Value_LC"]
                },
        'ATL':{'TV' : ["Month","Month_Num","Fiscal_Year","Country","Campaign_name",
                        "Execution_Name","Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer",
                        "Medium","Format","TV_ATL_Type","TV_Campaig_Start_Date","TV_Campaign_End_Date",
                        "TV_Spend_LC","TV_GRP","TV_Channel_name","TV_spot_Duration"
                        ],
                'Print': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name",
                          "Execution_Name","Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer",
                          "Medium","Format","Publication_Type","Print_Campaign_Start_Date","Print_Campaign_End_Date",
                          "Print_Spend_LC","Print_Impressions","Publication_Name","Print_spot_Duration"
                          ],
                'Radio': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                          "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium","Format",
                          "Radio_ATL_Type","Radio_Campaign_Start_Date","Radio_Campaign_End_Date","Radio_Spend_LC",
                          "Radio_Impressions_or_Reach","Channel_Frequency","Radio_spot_Duration"
                          ],
                'OOH': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                        "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium",
                        "Format","Type_of_OOH","OOH_Campaign_Start_Date","OOH_Campaign_End_Date","OOH_spend_LC",
                        "OTS_or_Reach","Location","OOH_spot_Duration"
                        ],
                'Cinema': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name","Type_of_Campaign",
                           "Product_Line","Influencer","Name_of_Influencer","Medium","Format","Cinema_ATL_Type",
                           "Cinema_Campaign_Start_Date","Cinema_Campaign_End_Date","Cinema_Spend_LC","Cinema_Impressions",
                           "Cinema_Channel_Name","Cinema_spot_Duration"
                           ],
                'Others': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                           "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium","Format",
                           "Others_ATL_Type","Others_campaign_Start_Date","Others_campaign_End_Date",
                           "Others_campaign_Spend_LC","Other_Impressions","Others_Name_of_the_Medium",
                           "Others_campaign_Duration"
                           ],
                'BE Spend': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                           "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium","Format",
                           "Others_ATL_Type","Others_campaign_Start_Date","Others_campaign_End_Date",
                           "Others_campaign_Spend_LC","Other_Impressions","Others_Name_of_the_Medium",
                           "Others_campaign_Duration"
                           ],
                'Broadcast SMS': ["Month","Month_Num","Fiscal_Year","Country","Campaign_name","Execution_Name",
                                "Type_of_Campaign","Product_Line","Influencer","Name_of_Influencer","Medium","Format",
                                "Others_ATL_Type","Others_campaign_Start_Date","Others_campaign_End_Date",
                                "Others_campaign_Spend_LC","Other_Impressions","Others_Name_of_the_Medium",
                                "Others_campaign_Duration"
                                ]
                },
        'DIGITAL':{    
                'digital_social_platform':["Month","Country","Campaign_name","Execution_Name","Type_of_Campaign","Product_Line",
                                           "Influencer","Name_of_Influencer","Medium","Format","Digital_Media_Type",
                                           "Digital_Campaign_Start_Date","Digital_Campaign_End_Date","Digital_Spend_LC","Total_Reach",
                                           "Total_Impressions","Total_Clicks","Linked_Clicks","Total_Views","Total_Engagement","Digital_Acquisition"
                                           ],
                'digital_browser': ["Month","Country","Campaign_name","Execution_Name","Type_of_Campaign","Product_Line","Influencer",
                                    "Name_of_Influencer","Medium","Format","SE_Communication_Type","SE_Campaign_Start_Date",
                                    "SE_Campaign_End_Date","SE_Spend_LC","SE_Impressions","SE_Reach","SE_Total_Clicks","SE_Linked_Clicks",
                                    "SE_Total_Views","SE_Engagement","SE_Acquisition"],
                'digital_video_apps': ["Month","Country","Campaign_name","Execution_Name","Type_of_Campaign","Product_Line","Influencer",
                                      "Name_of_Influencer","Medium","Format","VSS_Communication_Type","VSS_Campaign_Start_Date",
                                      "VSS_Campaign_End_Date","VSS_Spend_LC","VSS_Impressions_Reach","VSS_Impressions","VSS_Linked_Clicks",
                                      "VSS_Total_Views","VSS_Total_Clicks","VSS_Acquisition","VSS_Engagement"
                                      ],
                'digital_ecommerce': ["Month","Country","Campaign_name","Execution_Name","Type_of_Campaign","Product_Line",
                                      "Influencer","Name_of_Influencer","Medium","Format","Marketplace_Communication_Type",
                                      "Marketplace_Campaign_Start_Date","Marketplace_Campaign_End_Date","Marketplace_Spend_LC",
                                      "Ad_Impressions","Ad_Reach","Ad_Clicks","Ad_Linked_Clicks","Ad_Views","Ad_Engagement",
                                      "Ad_Acquisition"
                                      ]
                }
}

DIFFERENT_COLUMN_NAME_MAPPING = {
        'CRM': {
                "START_DATE":["CRM_Campaign_Start_Date"],
                "END_DATE":["CRM_Campaign_End_Date"],
                "TOTAL_SPEND":["CRM_Spend_LC"],
                "No_Of_SMS_EMAIL_SENT":["Amount_Sent"],
                "TOTAL_DELIVERED":["CRM_Delivered"],
                "TOTAL_OPEN":["CRM_Open"],
                "TOTAL_CLICK":["CRM_Click"],
                "TOTAL_RESPONDERS":["Responders"],
                "TOTAL_REVENUE":["CRM_Revenue"]
                },
        'PR': {
                "PR_Media":["PR_Media"],
                "START_DATE": ["PR_Start_Date"],
                "END_DATE": ["PR_End_Date"],
                "TOTAL_SPEND": ["PR_Spend_LC"],
                "CIRCULATION_VIEWERSHIP_HIT_IMPRESSIONS": ["Circulation_Viewership_Hit_impressions"],
                "PR_Total_Engagement":["PR_Total_Engagement"],
                "Equivalent_Advertising_Value_LC": ["Equivalent_Advertising_Value_LC"]
        },
        'ATL': {
               "ATL_TYPE": ["TV_ATL_Type","Publication_Type","Radio_ATL_Type","Type_of_OOH","Cinema_ATL_Type","Others_ATL_Type"], 
               "START_DATE":["TV_Campaig_Start_Date","Print_Campaign_Start_Date","Radio_Campaign_Start_Date","OOH_Campaign_Start_Date","Cinema_Campaign_Start_Date","Others_campaign_Start_Date"],
               "END_DATE":["TV_Campaign_End_Date","Print_Campaign_End_Date","Radio_Campaign_End_Date","OOH_Campaign_End_Date","Cinema_Campaign_End_Date","Others_campaign_End_Date"],
               "TOTAL_SPEND":["TV_Spend_LC","Print_Spend_LC","Radio_Spend_LC","OOH_spend_LC","Cinema_Spend_LC","Others_campaign_Spend_LC"],
               "TOTAL_IMPRESSIONS_REACH":["TV_GRP","Print_Impressions","Radio_Impressions_or_Reach","OTS_or_Reach","Cinema_Impressions","Other_Impressions"],
               "TOTAL_CHANNEL_NAME":["TV_Channel_name","Publication_Name","Channel_Frequency","Location","Cinema_Channel_Name","Others_Name_of_the_Medium"],
               "TOTAL_DURATION":["TV_spot_Duration","Print_spot_Duration","Radio_spot_Duration","OOH_spot_Duration","Cinema_spot_Duration","Others_campaign_Duration"]
        },
        'DIGITAL':{
                "COMMUNICATION_TYPE": ["Digital_Media_Type","SE_Communication_Type","VSS_Communication_Type","Marketplace_Communication_Type"],
                "START_DATE": ["Digital_Campaign_Start_Date","SE_Campaign_Start_Date","VSS_Campaign_Start_Date","Marketplace_Campaign_Start_Date"],
                "END_DATE": ["Digital_Campaign_End_Date","SE_Campaign_End_Date","VSS_Campaign_End_Date","Marketplace_Campaign_End_Date"],
                "TOTAL_SPEND": ["Digital_Spend_LC","SE_Spend_LC","VSS_Spend_LC","Marketplace_Spend_LC"],
                "TOTAL_REACH": ["Total_Reach","SE_Reach","VSS_Impressions_Reach","Ad_Reach"],
                "TOTAL_IMPRESSIONS": ["Total_Impressions","SE_Impressions","VSS_Impressions","Ad_Impressions"],
                "TOTAL_CLICK": ["Total_Clicks","SE_Total_Clicks","VSS_Total_Clicks","Ad_Clicks"],
                "TOTAL_LINKED_CLICK": ["Linked_Clicks","SE_Linked_Clicks","VSS_Linked_Clicks","Ad_Linked_Clicks"],
                "TOTAL_VIEWS": ["Total_Views","SE_Total_Views","VSS_Total_Views","Ad_Views"],
                "TOTAL_ENGAGEMENT": ["Total_Engagement","SE_Engagement","VSS_Engagement","Ad_Engagement"],
                "TOTAL_ACQUISITION": ["Digital_Acquisition","SE_Acquisition","VSS_Acquisition","Ad_Acquisition"]       
        }
}

COMBINE_DIFFERENT_COLUMN = {
        'CRM':["CRM_Campaign_Start_Date","CRM_Campaign_End_Date","CRM_Spend_LC","Amount_Sent",
                "CRM_Delivered","CRM_Open","CRM_Click","Responders","CRM_Revenue"
                ],
        'PR': ["PR_Media","PR_Start_Date","PR_End_Date","PR_Spend_LC","Circulation_Viewership_Hit_impressions",
               "PR_Total_Engagement","Equivalent_Advertising_Value_LC"
                ],
        'ATL': ["TV_ATL_Type","Publication_Type","Radio_ATL_Type","Type_of_OOH","Cinema_ATL_Type","Others_ATL_Type", 
                "TV_Campaig_Start_Date","Print_Campaign_Start_Date","Radio_Campaign_Start_Date","OOH_Campaign_Start_Date","Cinema_Campaign_Start_Date","Others_campaign_Start_Date",
                "TV_Campaign_End_Date","Print_Campaign_End_Date","Radio_Campaign_End_Date","OOH_Campaign_End_Date","Cinema_Campaign_End_Date","Others_campaign_End_Date",
                "TV_Spend_LC","Print_Spend_LC","Radio_Spend_LC","OOH_spend_LC","Cinema_Spend_LC","Others_campaign_Spend_LC",
                "TV_GRP","Print_Impressions","Radio_Impressions_or_Reach","OTS_or_Reach","Cinema_Impressions","Other_Impressions",
                "TV_Channel_name","Publication_Name","Channel_Frequency","Location","Cinema_Channel_Name","Others_Name_of_the_Medium",
                "TV_spot_Duration","Print_spot_Duration","Radio_spot_Duration","OOH_spot_Duration","Cinema_spot_Duration","Others_campaign_Duration"
                ],
        'DIGITAL': ["Digital_Media_Type","SE_Communication_Type","VSS_Communication_Type",
                    "Marketplace_Communication_Type","Digital_Campaign_Start_Date","SE_Campaign_End_Date",
                    "VSS_Campaign_Start_Date","Marketplace_Campaign_Start_Date","Digital_Campaign_End_Date",
                    "SE_Campaign_Start_Date","SE_Campaign_End_Date","VSS_Campaign_End_Date","Marketplace_Campaign_End_Date",
                    "Digital_Spend_LC","SE_Spend_LC","VSS_Spend_LC","Marketplace_Spend_LC", "Total_Reach",
                    "SE_Reach","VSS_Impressions_Reach","Ad_Reach","Total_Impressions","SE_Impressions",
                    "VSS_Impressions","Ad_Impressions","Total_Clicks","SE_Total_Clicks","VSS_Total_Clicks",
                    "Ad_Clicks","Linked_Clicks","SE_Linked_Clicks","VSS_Linked_Clicks","Ad_Linked_Clicks",
                    "Total_Views","SE_Total_Views","VSS_Total_Views","Ad_Views","Total_Engagement","SE_Engagement",
                    "VSS_Engagement","Ad_Engagement","Digital_Acquisition","SE_Acquisition","VSS_Acquisition","Ad_Acquisition"
                    ]
}


DOWNLOAD_EXCEL_DB_COL_EX_HEARDER_MAPPING = {
        'ATL': {'Month':"Month*", 'Campaign_name':"Campaign name*", 'Execution_Name':"Campaign Execution", 
                'Type_of_Campaign':"Type of Campaign (Product or Brand or EOSS)*", 'Product_Line':"Product Line (if product campaign)", 
                'Influencer':"Influencer", 'Name_of_Influencer':"Name of Influencer", 'Medium':"Medium*", 
                'Format':"Format (Text/Video/Photo, Audio etc.)", 'ATL_TYPE':"Type of ATL", 'START_DATE':"Campaign Start Date*\n(DD-MM-YYYY)", 
                'END_DATE':"Campaign End Date*\n(DD-MM-YYYY)", 'TOTAL_SPEND':"Total Spend *", 'TOTAL_IMPRESSIONS_REACH':"GRP/ Impressions/ Reach*", 
                'TOTAL_CHANNEL_NAME':"Channel/ Publication/ Area name", 'TOTAL_DURATION':"TV Spot duration (in secs)"
                },
        
        'CRM': {'Month':'Month*', 'Campaign_name':'Campaign name*', 'Execution_Name':'Campaign Execution', 
                'Type_of_Campaign':'Type of Campaign (Product or Brand or EOSS)*', 'Product_Line':'Product Line (if product campaign)', 
                'Influencer':'Influencer', 'Name_of_Influencer':'Name of Influencer', 'Medium':'Medium*', 'Format':'Format (Text/Video/Photo, Audio etc.)', 
                'START_DATE':'CRM Campaign Start Date*\n(DD-MM-YYYY)', 'END_DATE':'CRM Campaign End Date*\n(DD-MM-YYYY)', 'TOTAL_SPEND':'CRM Spend*', 
                'No_Of_SMS_EMAIL_SENT':'No of SMS/  Email Sent*', 'TOTAL_DELIVERED': 'Delivered', 'TOTAL_OPEN':'Opened', 
                'TOTAL_CLICK':'Clicked', 'TOTAL_RESPONDERS':'Responders (no of purchasers amongst recipients of communication)', 
                'TOTAL_REVENUE':'Revenue from Campaign'
                },
        'PR': {'Month':'Month*', 'Campaign_name':'Campaign name*', 'Execution_Name':'Campaign Execution', 'Type_of_Campaign':'Type of Campaign (Product or Brand or EOSS)*', 
               'Product_Line':'Product Line (if product campaign)', 'Influencer':'Influencer', 'Name_of_Influencer':'Name of Influencer', 
               'Medium':'Medium*', 'Format':'Format (Text/Video/Photo, Audio etc.)', 'PR_Media':'PR Media*', 'START_DATE':'Start Date\n(DD-MM-YYYY)*', 
               'END_DATE':'End Date\n(DD-MM-YYYY)*', 'TOTAL_SPEND':'PR Spend*', 'CIRCULATION_VIEWERSHIP_HIT_IMPRESSIONS':'Circulation/ Viewership/ Hit Rates (Impressions)', 
               'PR_Total_Engagement':'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)', 
               'Equivalent_Advertising_Value_LC':'Equivalent Advertising Value'
        },
        'Digital':{'Month':'Month*', 'Campaign_name':'Campaign name*', 'Execution_Name':'Campaign Execution', 
                   'Type_of_Campaign':'Type of Campaign (Product or Brand or EOSS)*', 'Product_Line':'Product Line (if product campaign)', 
                   'Influencer':'Influencer', 'Name_of_Influencer':'Name of Influencer', 'Medium':'Medium*', 
                   'Format':'Format (Text/Video/Photo, Audio etc.)', 'COMMUNICATION_TYPE':'Communication Type*', 'START_DATE':'Campaign Start Date*\n(DD-MM-YYYY)', 
                   'END_DATE':'Campaign End Date*\n(DD-MM-YYYY)', 'TOTAL_SPEND':'Total Spend*', 'TOTAL_IMPRESSIONS':'Total \nImpressions', 
                   'TOTAL_REACH':'Total Reach', 'TOTAL_CLICK':'Total \nClicks', 'TOTAL_LINKED_CLICK':'Linked Clicks', 
                   'TOTAL_VIEWS':'Total \nViews', 'TOTAL_ENGAGEMENT':'Total Engagement (Likes/ Reactions/ Fav +  Comment + Shares/ retweets + Readmore)', 
                   'TOTAL_ACQUISITION':'Acquisition'
        }
}

DOWNLOAD_TEMPLATE_COLUMN_MERGE_RANGE = {"ATL":{"first_merge":"A1:E1",
                                               "second_merge":"K1:P1",
                                               "third_merge":"K2:P2"
                                               },
                                        "Digital":{"first_merge":"A1:E1",
                                                   "second_merge":"J1:T1",
                                                   "third_merge":"J2:T2"
                                                   },
                                        "PR":{"first_merge":"A1:E1",
                                              "second_merge":"J1:P1",
                                              "third_merge":"J2:P2"
                                              },
                                        "CRM":{"first_merge":"A1:E1",
                                               "second_merge":"J1:R1",
                                               "third_merge":"J2:R2"
                                               }
                                        }

msg_string = """
                <html>
                <head></head>
                <body>
                    <p>Dear {0},<br>
                    <p>Gentle Reminder</p>
                    <div>Following marketing data awaits your approval.</div><br>
                    <div>Data Type: <b>{1}.</b> </div><br>
                    <div>Market: <b>{2}.</b> </div><br>
                    <div>Period: <b>{3}.</b> </div><br>
                    <div>Data Uploaded: <b>{4}.</b> </div><br>
                    <div>Please Log in to Okta application to Approve/Reject within 2 business days.<br>
                    <p><a href="https://met-data-approval.cartesianconsulting.com/">Click Here for login.</a>
                    <div>
                    <p>Regards,<br>
                       Team MET</p></div>
                </body>
                </html>
                """

msg_string_approved = """
                <html>
                <head></head>
                <body>
                    <p>Dear {0},<br>
                    <p>Gentle Reminder</p>
                    <div>Following marketing data has been approved.</div><br>
                    <div>Data Type: <b>{1}.</b> </div><br>
                    <div>Market: <b>{2}.</b> </div><br>
                    <div>Period: <b>{3}.</b> </div><br>
                    <div>Data Approved At: <b>{4}.</b> </div><br>
                    <p><a href="https://met-data-approval.cartesianconsulting.com/">Click Here for login.</a>
                    <div>
                    <p>Regards,<br>
                       Team MET</p></div>
                </body>
                </html>
                """

msg_string_reject = """
                    <html>
                    <head></head>
                    <body>
                        <p>Dear {0},<br>
                        <div>Following marketing data rejected.</div><br>
                        <div>Data Type: <b>{1}.</b> </div><br>
                        <div>Market: <b>{2}.</b> </div><br>
                        <div>Period: <b>{3}.</b> </div><br>
                        <div>Data Rejected On: <b>{4}.</b> </div><br>
                        <div>Remark:<b>{5}.</b></div><br>
                        <p><a href="https://met-data-approval.cartesianconsulting.com/">Click Here for login.</a>
                        <div>
                        <p>Regards,<br>
                           Team MET</p></div>
                    </body>
                    </html>
                    """


ERROR_MAPPING_KEYS = {
        'end_date':"End Date is not in the correct format (DD-MM-YYYY) at Row # {0}.",
        'start_date':"Start Date is not in the correct format (DD-MM-YYYY) at Row # {0}."
}


















