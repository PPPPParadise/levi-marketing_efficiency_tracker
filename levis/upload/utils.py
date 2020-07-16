import pandas
import os
import base64
import pymysql
import datetime
import smtplib
from shutil import copyfile
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from . import constants as upload_constants
from django.db import transaction

from celery.utils.log import get_task_logger

logger = get_task_logger(__name__)



DBNAME = 'LEVIS_MET2' #'LEVIS_MET2'
USER = 'rahul'
PASSWORD = 'Cart@123'
HOST = '10.0.0.71'
PORT = 3306
conn = pymysql.connect(host=HOST,port=PORT,database=DBNAME,user=USER,password=PASSWORD)
cursor = conn.cursor()


def run_query(query,query_type,procedure_params=None):
    """
    This function to execute the query
    """ 
    try:
        DBNAME = 'LEVIS_MET2'
        USER = 'rahul'
        PASSWORD = 'Cart@123'
        HOST = '10.0.0.71'
        PORT = 3306
        conn1 = pymysql.connect(host=HOST,port=PORT,database=DBNAME,user=USER,password=PASSWORD)
        cursor1 = conn1.cursor()
        if query_type == 'query':
            cursor1.execute(query)
            conn1.commit()
            data = dictfetchall(cursor1)
            return data
        if query_type == 'procedure':
            cursor1.callproc(query,procedure_params)
    except Exception as e:
        return {'status':False,"error": repr(e)}


def run_procedure(procedure_name,procedure_params,mail_info,log_info):
    """
    This function to execute the procedure
    """ 
    try:
        DBNAME = 'LEVIS_MET2'
        USER = 'rahul'
        PASSWORD = 'Cart@123'
        HOST = '10.0.0.71'
        PORT = 3306
        conn1 = pymysql.connect(host=HOST,port=PORT,database=DBNAME,user=USER,password=PASSWORD)
        cursor1 = conn1.cursor()
        cursor1.callproc(procedure_name,procedure_params)
        return {"status":True,"message":"Approved procedure called successfully"}
        # send_mail(mail_info['msg'],'',mail_info.get('to_Cc'),mail_info.get('to_To'), log_info)
    except Exception as e:
        return {'status':False,"error": repr(e)}


def send_mail(message,receivers,to_Cc, to_To, log_info=None):
    """
    This function for sending the mail
    """
    if log_info:
        log_query_res = run_query(log_info.get('query').format(log_info.get('insert_values')),'query')
    sender = 'levis.met@artefact.com'
    gmail_password = 'Levi@MET2020'
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = to_To
    msg['Cc'] = to_Cc
    msg['Subject'] = 'Marketing Data Uploaded! ACTION NEEDED:APPROVED/REJECT'
    msg.attach(MIMEText(message,'html'))
    try:
        smtpobj = smtplib.SMTP('smtp.gmail.com',587)
        smtpobj.ehlo()
        smtpobj.starttls()
        smtpobj.ehlo()
        smtpobj.login(sender, gmail_password)
        mail_res = smtpobj.send_message(msg)
        return True
    except Exception as e:
        print(e)


def dictfetchall(cursor):
    """
    Return all rows from a cursor as a dict
    """
    if isinstance(cursor.description,(list,dict,tuple)):
        columns = [col[0] for col in cursor.description]
        return [
            dict(zip(columns, row))
            for row in cursor.fetchall()
        ]
    else:
        return True


def get_size_of_base64_encoded_string(b64string):
    """
    """
    return (len(b64string)*3)/4 - b64string.count('=',-2)

def get_decoded_data(data, max_document_size):
    try:
        size_in_byte = get_size_of_base64_encoded_string(data)
        if size_in_byte/(1024*1024)>max_document_size:
            return {'status':False,'error': 'document size is big'}
        data_type = data.split(';')[0]
        content_type = data_type.split(':')[1]
        base64_string = data.split('base64,')[1]
        data = base64.b64decode(base64_string)
        return {'status':True,'data':data,'content_type':content_type}
    except Exception as e:
        return {'status':False,'error':repr(e)}

def read_excel_file(file_decoded_data,type):
    """
    """
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    file_name = 'temp_excel.xlsx'
    temp_excel = open(BASE_DIR+'/upload/'+file_name,'wb')
    temp_excel.write(file_decoded_data)
    temp_excel.close()
    try:
        file_data = pandas.read_excel(BASE_DIR+'/upload/'+file_name,index_col=None,skiprows=2,skip_blank_lines=False)
    except Exception as e:
        os.remove(BASE_DIR+'/upload/'+file_name)
        return {'status':False,'error':repr(e)}
    if isinstance(upload_constants.XLSX_COLUMN_MAPPING.get(type),list):
        file_headers = list(map(lambda x: x.replace('\n',''),list(file_data.columns)))
        for req_header in upload_constants.XLSX_COLUMN_MAPPING.get(type):
            if "*" in req_header and req_header not in file_headers:
                os.remove(BASE_DIR+'/upload/'+file_name)
                return {'status':False,'error':req_header+' column is required for excel "{0}" OR template type and file are different'.format(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING.get(type).replace("_"," "))}
    os.remove(BASE_DIR+'/upload/'+file_name)
    return {'status':True,'data':file_data}


def check_excel_data(file_data,excel_type,sel_date,sel_currency,sel_country,actual_date):
    """
    This function for validating the each cell data
    """
    query = "select * from Dim_Calendar where Fiscal_Date = '{0}';" #and Year_Month_Num = '{1}' and Fiscal_Month = '{2}';"
    error_list = []
    error_dict = {}
    xls_data = []
    compaign_start_date = ''
    compaign_end_date = ''
    compaign_start_date_column_name = upload_constants.START_DATE_END_DATE_COLUMN_MAPPING.get(excel_type).get('start_date_column')
    compaign_end_date_column_name = upload_constants.START_DATE_END_DATE_COLUMN_MAPPING.get(excel_type).get('end_date_column')
    mandatory_col = upload_constants.XLSX_ACTUAL_COLUMN_MAPPING.get(str(excel_type))[0]
    # actual_date = datetime.datetime.strptime(actual_date,"%Y-%m-%dT%H:%M:%S.%fZ")
    # if actual_date.month < 12:
    #     actual_date = actual_date.replace(month=actual_date.month+1,day=1)
    # else:
    #     actual_date = actual_date.replace(actual_date.year+1,month=1,day=1)
    if len(file_data.values) < 1:
        return {"status":False,"errordict":["Excel is Empty"]}
    for index_number in file_data.index:
        xls_data_dict = {}
        if str(file_data[mandatory_col][index_number]) == "nan":
            continue
        for col_name in upload_constants.XLSX_ACTUAL_COLUMN_MAPPING.get(str(excel_type)):
            cell_value = str(file_data[col_name][index_number])
            if "*" in col_name and cell_value == "nan" or cell_value == 'NaT':
                error_dict.setdefault(col_name,{}).setdefault("Row #{0} Mandatory column "+col_name+" is missing ",[]).append(index_number+4)
                error_list.append("value for column "+col_name+" is missing in row number "+str(index_number+4))
            else:
                xls_data_dict.setdefault(col_name,cell_value)
        try:
            year_month = datetime.datetime.strftime(datetime.datetime.strptime(str(file_data[mandatory_col][index_number]),"%b-%y"),"%Y%m")
            # year_month = datetime.datetime.strftime(datetime.datetime.strptime(str(file_data[mandatory_col][index_number]),"%Y-%m-%d %H:%M:%S"),"%Y%m")
            fiscal_month = file_data[mandatory_col][index_number].split('-')[0]
            fix_start_date = datetime.datetime.today().replace(year=2016,month=12)
            current_month_year =  datetime.datetime.strptime(datetime.datetime.strftime(datetime.datetime.today(),"%Y-%m"),"%Y-%m")
            # actual_date = datetime.datetime.strptime(actual_date,"%Y-%m-%dT%H:%M:%S.%fZ")
            if not fix_start_date <= actual_date : #and actual_date <= current_month_year):
            # error_dict.setdefault('invalid_month',{}).setdefault("Row #{0}. Month should be greater than Dec-16 and less than current month and year",[]).append(index_number+4)
                error_dict.setdefault('invalid_month',{}).setdefault("Month field in the template should be greater than Dec-16 and less than current month at Row #{0}.",[]).append(index_number+4)
            if year_month != sel_date:
                # error_dict.setdefault('*Month_Mismatch',{}).setdefault("Row #{0}. *Month Column is mismatch with selected month in the above dropdown calender",[]).append(index_number+4)
                error_dict.setdefault('*Month_Mismatch',{}).setdefault("*Month field in the template at Row #{0}. doesn’t match with the Month selected in the above drop calendar",[]).append(index_number+4)
                error_list.append("Selected Month and *Month Column in xlsx file are mismatch")
        except Exception as e:
            error_dict.setdefault("error",[]).append(e)
            continue
        compaign_start_date = str(file_data[compaign_start_date_column_name][index_number])
        compaign_end_date = str(file_data[compaign_end_date_column_name][index_number])
        if not (compaign_start_date == 'NaT' or compaign_end_date == 'NaT'):
            is_date_format_correct = True
            try:
                if compaign_start_date:
                    datetime.datetime.strptime(compaign_start_date,"%d-%m-%Y")
            except:
                # error_dict.setdefault('DateFormat',{}).setdefault("Row #{0}. Start Date is not in the correct format (DD-MM-YYYY) ! ",[]).append(index_number+4)
                # error_dict.setdefault('DateFormat',{}).setdefault("start_date",[]).append(index_number+4)
                error_dict.setdefault("start_date",[]).append(index_number+4)
                is_date_format_correct = False
            try:
                if compaign_end_date:
                    datetime.datetime.strptime(compaign_end_date,"%d-%m-%Y")
            except:
                # error_dict.setdefault('DateFormat',{}).setdefault("Row #{0}. End Date is not in the correct format (DD-MM-YYYY) ! ",[]).append(index_number+4)
                error_dict.setdefault("end_date",[]).append(index_number+4)

                is_date_format_correct = False
            if not is_date_format_correct:
                continue
            compaign_start_date_new_format = datetime.datetime.strptime(compaign_start_date,"%d-%m-%Y")
            compaign_end_date_new_format = datetime.datetime.strptime(compaign_end_date,"%d-%m-%Y")
            
            is_start_date_correct = run_query(query.format(compaign_start_date_new_format),'query')
            is_end_date_correct = run_query(query.format(compaign_end_date_new_format),'query')
            if isinstance(is_start_date_correct,dict):
                return {"status":False,"errordict":"Data Base Server is down"}
            if len(is_start_date_correct) == 0:
                # error_dict.setdefault("*StartDate",{}).setdefault("Row #{0}. StartDate does not fall within Levi's calendar ! ",[]).append(index_number+4)
                error_dict.setdefault("*StartDate",{}).setdefault("Start Date at Row #{0}. does not fall within the Levi's calendar month entered in the 'Month' Field",[]).append(index_number+4)

                error_list.append("for column Campaign Start Date* date is incorrect at row number "+str(index_number+4))
            if len(is_end_date_correct) == 0:
                # error_dict.setdefault("*EndDate",{}).setdefault("Row #{0}. EndDate does not fall within Levi's calendar ! ",[]).append(index_number+4)
                error_dict.setdefault("*EndDate",{}).setdefault("End Date at Row #{0}. does not fall within the Levi's calendar month entered in the 'Month' Field",[]).append(index_number+4)

                error_list.append("for column Campaign End Date*  date is incorrect at row number "+str(index_number+4))
            if not compaign_start_date_new_format <= compaign_end_date_new_format:
                # error_dict.setdefault("*Start_End_Date_Error",{}).setdefault("Row #{}.StartDate should be less then EndDate ! ",[]).append(index_number+4)
                error_dict.setdefault("*Start_End_Date_Error",{}).setdefault("Start Date should  be less than End Date at Row Row #{}.",[]).append(index_number+4)
                error_list.append("start date should less then end date at row number "+str(index_number+4))
            if len(is_end_date_correct) > 0 and len(is_start_date_correct) > 0:
                if not (datetime.datetime.strptime(str(file_data[mandatory_col][index_number]),"%b-%y").strftime("%Y%m") == str(is_start_date_correct[0].get('Year_Month_Num')) and \
                        str(is_start_date_correct[0].get('Year_Month_Num')) == str(is_end_date_correct[0].get('Year_Month_Num'))):
                    # error_dict.setdefault('invalid_month',{}).setdefault("Row #{0}. Month should be same for *Month, Start Date, End Date, calendar ! ",[]).append(index_number+4)
                    error_dict.setdefault('invalid_month',{}).setdefault("Row #{0}.Selected month in above drop calendar must match with ‘Month’, ‘Campaign Start Date’ and ‘Campaign End Date’ on Marketing Template",[]).append(index_number+4)

            if len(is_start_date_correct) > 0:
                temp = is_start_date_correct[0]
                xls_data_dict["Fiscal_Year"] = temp.get('Fiscal_Year') #is_start_date_correct[0].get('Fiscal_Year')
        xls_data_dict['Month*'] = datetime.datetime.strftime(datetime.datetime.strptime(str(file_data[mandatory_col][index_number]),"%b-%y"),"%y-%b")
        xls_data_dict['Month_Num'] = year_month
        xls_data.append(xls_data_dict)
    if len(error_dict.keys()) > 0:
        err_list = []
        for key,value in error_dict.items():
            temp_err_split = str(value)[2:-1].split(':')
            if key in upload_constants.ERROR_MAPPING_KEYS.keys():
                err_list.append(upload_constants.ERROR_MAPPING_KEYS.get(key).format(value))
            else:
                err_list.append(temp_err_split[0].format(temp_err_split[1]))
        return {"status":False,'error':error_list,'errordict':err_list}
    return {"status":True,"data":file_data,"xls_data":xls_data}


def map_data(obj,template_type,medium_group,excel_data_dict):
    """
    """
    for key in upload_constants.TEMPLATE_MEDIUM_COLUMN_MAPPING[template_type][medium_group]:
        if key in upload_constants.COMBINE_DIFFERENT_COLUMN[template_type]:
            for dict_key, dict_val in upload_constants.DIFFERENT_COLUMN_NAME_MAPPING[template_type].items():
                if key in dict_val:
                    new_key = dict_key
                    excel_data_dict.setdefault(new_key,[]).append(obj.get(key))
        else:
            excel_data_dict.setdefault(key,[]).append(obj.get(key))
    return excel_data_dict


def write_excel(excel_data_dict,file_name,template_type):
    """
    """
    temp_obj = []
    for obj in excel_data_dict.get('Month'):
        temp_obj.append(obj.split('-')[1]+'-'+obj.split('-')[0])
    excel_data_dict['Month'] = temp_obj
    temp_obj = []
    for obj in excel_data_dict.get('START_DATE'):
        temp_obj.append(datetime.datetime.strftime(obj,"%d-%m-%Y"))
    excel_data_dict['START_DATE'] = temp_obj
    temp_obj = []
    for obj in excel_data_dict.get('END_DATE'):
        temp_obj.append(datetime.datetime.strftime(obj,"%d-%m-%Y"))
    excel_data_dict['END_DATE'] = temp_obj
    template_id = upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING_TO_ID[template_type]
    columns = upload_constants.XLSX_ACTUAL_COLUMN_MAPPING[template_id]
    writer_obj = pandas.ExcelWriter(file_name,engine='xlsxwriter')
    temp_dict = {}
    for key in excel_data_dict.keys():
        mapped_key = upload_constants.DOWNLOAD_EXCEL_DB_COL_EX_HEARDER_MAPPING[template_type].get(key)
        if mapped_key:
            temp_dict[mapped_key] = excel_data_dict[key]
    data_frame = pandas.DataFrame(temp_dict)
    data_frame.to_excel(writer_obj,sheet_name="data",columns=columns,index=False, startrow=2)
    workbook = writer_obj.book
    worksheet = writer_obj.sheets['data']
    merge_format = workbook.add_format({
    'bold': 1,
    'border': 1,
    'align': 'center',
    'valign': 'vcenter',
    })
    merge_format2 = workbook.add_format({
    'bold': 1,
    'border': 1,
    'align': 'center',
    'valign': 'vcenter',
    'color': 'red'
    })
    merge_format3 = workbook.add_format({
    'bold': 1,
    'border': 1,
    'align': 'center',
    'valign': 'vcenter',
    'bg_color':'#a4d08e'
    })
    first_merge = upload_constants.DOWNLOAD_TEMPLATE_COLUMN_MERGE_RANGE.get(template_type).get('first_merge')
    second_merge = upload_constants.DOWNLOAD_TEMPLATE_COLUMN_MERGE_RANGE.get(template_type).get('second_merge')
    third_merge = upload_constants.DOWNLOAD_TEMPLATE_COLUMN_MERGE_RANGE.get(template_type).get('third_merge')
    worksheet.merge_range(first_merge, 'Marketing Campaign Performance Template', merge_format)
    worksheet.merge_range(second_merge, '* asterisk are mandatory fields', merge_format2)
    worksheet.merge_range(third_merge, template_type, merge_format3)
    worksheet.set_row(2, 20, merge_format3)
    worksheet.write_row(2,0,data=columns)
    writer_obj.save()
    return base64.b64encode(open(file_name,'rb').read())

def download_excel(data):
    """
    """
    query = 'select * from MKT_Template_Spend where Month_Num = {0} and Country = "{1}" and Template_Name = "{2}";'
    query = query.format(data.get("Month"), data.get("Country"), data.get("Template_Type"))
    data_from_db = run_query(query,"query")
    if not data_from_db:
        return {'status':False}
    excel_data_dict = {}
    if data.get('Template_Type') == 'Digital':
        for obj in data_from_db:
            if isinstance(obj,dict):
                medium = obj.get('Medium')
                if medium in upload_constants.DGTL_TMPLT_SOCIAL_NET:
                    excel_data_dict = map_data(obj,'DIGITAL','digital_social_platform',excel_data_dict)    
                elif medium in upload_constants.DGTL_TMPLT_BROWSER_NET:
                    excel_data_dict = map_data(obj,'DIGITAL','digital_browser',excel_data_dict)
                elif medium in upload_constants.DGTL_TMPLT_APPS:
                    excel_data_dict = map_data(obj,'DIGITAL','digital_video_apps',excel_data_dict)
                else:
                    excel_data_dict = map_data(obj,'DIGITAL','digital_ecommerce',excel_data_dict)
    if data.get('Template_Type') == 'ATL':
        for obj in data_from_db:
            if isinstance(obj,dict):
                medium = obj.get('Medium')
                if medium == 'TV':
                    excel_data_dict = map_data(obj,'ATL','TV',excel_data_dict)
                elif medium == 'Print':
                    excel_data_dict = map_data(obj,'ATL','Print',excel_data_dict)
                elif medium == 'Radio':
                    excel_data_dict = map_data(obj,'ATL','Radio',excel_data_dict)
                elif medium == 'OOH':
                    excel_data_dict = map_data(obj,'ATL','OOH',excel_data_dict)
                elif medium == 'Cinema':
                    excel_data_dict = map_data(obj,'ATL','Cinema',excel_data_dict)
                else:
                    excel_data_dict = map_data(obj,'ATL','Others',excel_data_dict)
    if data.get('Template_Type') == 'PR':
        for obj in data_from_db:
            if isinstance(obj,dict):
                medium = obj.get('Medium')
                if medium == 'PR':
                    excel_data_dict = map_data(obj,'PR','PR',excel_data_dict)
    if data.get('Template_Type') == 'CRM':
        for obj in data_from_db:
            if isinstance(obj,dict):
                medium = obj.get('Medium')
                if medium == 'CRM-EDM':
                    excel_data_dict = map_data(obj,'CRM','CRM-EDM',excel_data_dict)
                elif medium == 'CRM-SMS':
                    excel_data_dict = map_data(obj,'CRM','CRM-SMS',excel_data_dict)
                else:
                    excel_data_dict = map_data(obj,'CRM','WeChat',excel_data_dict)
    template_name = data.get('Template_Type')+"_"+data.get('Country')+"_"+str(data.get('Month'))+'.xlsx'
    encoded_excel = write_excel(excel_data_dict,template_name,data.get('Template_Type'))
    os.remove(template_name)
    return {'status':True,'data':encoded_excel,'template_name':template_name}


def approve_data(country,month,user,template_types_list,action_dict):
    """
    """
    get_uploader_query = "SELECT Created_By FROM MKT_Template_Spend where Template_Name='{0}' and Country='{1}' and Month_Num={2};"
    get_approver_query = "SELECT User_Name, User_Email_Id FROM User_Access where Country ='{0}' and Access_Type = '{1}' group by User_Email_Id;"
    
    current_time = datetime.datetime.now()
    approver_data = run_query(get_approver_query.format(country,'MKT_SPEND_APPROVE'),'query')
    ignore_actions = []
    if isinstance(approver_data,dict):
        return {"status":False,"error":repr(approver_data.get("error"))}
    for key, value in action_dict.items():
        to_To = ''
        to_Cc = ''
        log_info = {}
        is_data_available = False
        if value.get('status'):
            uploader_data = run_query(get_uploader_query.format(key,country,month),'query')
            if len(uploader_data) > 0:
                is_data_available = True
            else:
                ignore_actions.append({"type":key,"status":False,"message":"Don't have data for month '{0}'!".format(month)})
                continue
            if is_data_available:
                if len(approver_data) > 0:
                    for email_obj in approver_data:
                        to_Cc = to_Cc + email_obj.get('User_Email_Id')+";"
                email_info = {}
                logger.info(to_Cc)
                uploader_details_query = "SELECT User_Name, User_Email_Id FROM User_Access where User_Id='{0}';"
                uploader_details_data = run_query(uploader_details_query.format(uploader_data[0].get('Created_By')),'query')
                email_info['msg'] = upload_constants.msg_string_approved.format(uploader_details_data[0].get('User_Name'),key,country,month,current_time,value.get('remark'))
                email_info['to_Cc'] = to_Cc
                email_info['to_To'] =  uploader_details_data[0].get('User_Email_Id')
                ignore_actions.append({"to_Cc":to_Cc,"type":key,"status":True,"message":"Successfully update the data for month '{0}'!".format(month)})
                procedure = 'Approve_Mkt_Template_Pr'
                procedure_params = [country,int(month),user,key]

                if not value.get('remark'):
                    value['remark'] = ''
                log_query = "insert into Mail_Info(Year_Month_Num,Country,Template_Type,Status,Mail_Counter,Note,Created_By,Approved_By)values{0};"
                log_data = (month,country,key,'approved',0,value.get('remark'),user,user)
                log_info['query'] = log_query
                log_info['insert_values'] = log_data
                logger.info(procedure)
                logger.info(procedure_params)
                procedure_response = run_procedure(procedure,procedure_params,email_info,log_info)
                logger.info(procedure_response)
                log_query_res = run_query(log_info.get('query').format(log_info.get('insert_values')),'query')
                send_mail(email_info['msg'],'',email_info.get('to_Cc'),email_info.get('to_To'), log_info)
        else:
            uploader_data = run_query(get_uploader_query.format(key,country,month),'query')
            if len(uploader_data) > 0:
                is_data_available = True
            else:
                ignore_actions.append({"type":key,"status":False,"message":"Don't have data for month '{0}'!".format(month)})
                continue
            if len(approver_data) > 0:
                for email_obj in approver_data:
                    to_Cc = to_Cc + email_obj.get('User_Email_Id')+";"
            logger.info(to_Cc)
            ignore_actions.append({"to_Cc":to_Cc,"type":key,"status":True,"message":"Successfully update the data for month '{0}'!".format(month)})
            uploader_details_query = "SELECT User_Name, User_Email_Id FROM User_Access where User_Id='{0}';"
            uploader_details_data = run_query(uploader_details_query.format(uploader_data[0].get('Created_By')),'query')
            msg = upload_constants.msg_string_reject.format(uploader_details_data[0].get('User_Name'),key,country,month,current_time,value.get('remark'))
            to_To =  uploader_details_data[0].get('User_Email_Id')
            log_query = 'insert into Mail_Info(Year_Month_Num,Country,Template_Type,Status,Mail_Counter,Note,Created_By,Approved_By)values{0};'
            log_info['query'] = log_query
            if not value.get('remark'):
                value['remark'] = ''
            log_data = (month,country,key,'rejected',0,value.get('remark'),user,user)
            log_info['insert_values'] = log_data
            send_mail(msg,'',to_Cc, to_To, log_info)
    return {"status": True, "ignore_actions":ignore_actions}


def upload_excel_data(file_data,template_type,selected_country,selected_currency,selected_date,user):
    """
    """
    last_upload = {"ATL":{"date":'','status':''},
                "CRM": {"date":'','status':''},
                "PR": {"date":'','status':''},
                "Digital":{"date":'','status':''}}
    mail_info = {}
    log_info = {}
    with transaction.atomic():
        template_name = upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[str(template_type)]
        delete_query = 'delete from MKT_Template_Spend where Template_Id={0} and Month_Num = {1} and Country = "{2}";'
        delete_res = run_query(delete_query.format(int(template_type),int(selected_date),selected_country),'query')
        for obj in file_data:
            temp_list = [obj.get('Month*'),obj.get('Month_Num'),obj.get('Fiscal_Year'),selected_country]
            for col in upload_constants.XLSX_ACTUAL_COLUMN_MAPPING[str(template_type)][1:]:
                if col in [upload_constants.START_DATE_END_DATE_COLUMN_MAPPING[str(template_type)].get("start_date_column"),
                           upload_constants.START_DATE_END_DATE_COLUMN_MAPPING[str(template_type)].get("end_date_column")]:
                    temp_list.append(datetime.datetime.strftime(datetime.datetime.strptime(obj.get(col),"%d-%m-%Y"),"%Y-%m-%d"))
                else:
                    if obj.get(col) == 'nan':
                        temp_list.append("")
                    else:
                        temp_list.append(obj.get(col))
            if selected_currency == 'Local Currency':
                temp_list.append("LC")
            else:
                temp_list.append(selected_currency)
            temp_list.append("N")
            if template_type == '1':
                medium = obj.get('Medium*')
                query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type][medium]
            if template_type == '2':
                medium = obj.get('Medium*')
                if medium in upload_constants.DGTL_TMPLT_SOCIAL_NET:
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['digital_social_platform']
                elif medium in upload_constants.DGTL_TMPLT_BROWSER_NET:
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['digital_browser']
                elif medium in upload_constants.DGTL_TMPLT_APPS:
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['digital_video_apps']
                else:
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['digital_ecommerce']
            if template_type == '3':
                medium = obj.get('Medium*')
                query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['PR']
            if template_type == '4':
                medium = obj.get('Medium*')
                if medium == 'CRM-EDM':
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['CRM-EDM']
                if medium == 'CRM-SMS':
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['CRM-SMS']
                if medium == 'CRM-WeChat':
                    query = upload_constants.INSERT_QUERY_MAPPING_DICT[template_type]['CRM-SMS']
            temp_list.append(template_name)
            temp_list.append(int(template_type))
            temp_list.append(user)
            temp_list.append(user)
            insert_res = run_query(query.format(tuple(temp_list)),'query')
            run_query("SET sql_save_updates = 0;",'query')
        current_time = datetime.datetime.now()
        get_approver_query = "SELECT User_Email_Id FROM User_Access where Access_Type='MKT_SPEND_APPROVE' and Country='{0}';"
        approver_data = run_query(get_approver_query.format(selected_country),'query')
        get_uploader_query = "SELECT User_Name, User_Email_Id FROM User_Access where User_Id ='{0}';"
        uploader_data = run_query(get_uploader_query.format(user),'query')    
        if len(uploader_data) > 0 and len(approver_data) > 0:
            to_To = ''
            for email_obj in approver_data:
                to_To = to_To+email_obj.get('User_Email_Id')+";"
    
            mail_info['msg'] = upload_constants.msg_string.format('Approvers',template_name,selected_country,selected_date,current_time)
            mail_info['to_To'] = to_To
            mail_info['to_Cc'] = uploader_data[0].get('User_Email_Id')
            log_info['query'] = 'insert into Mail_Info(Year_Month_Num,Country,Template_Type,Status,Mail_Counter,Note,Loaded_By,Created_By) \
                                values{0};'
            log_data = (selected_date,selected_country,template_name,'upload',0,'',user,user)
            log_info['insert_values'] = log_data
        procedure = "Submit_Mkt_Template_Pr"
        procedure_params = [selected_country,int(selected_date),upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[template_type],user]
        run_procedure(procedure,procedure_params,mail_info,log_info)
        log_query_res = run_query(log_info.get('query').format(log_info.get('insert_values')),'query')
    

def send_reminder():
    """
    """
    get_upload_details_query = "select * from Mail_Info where Mail_Counter < 3 and status = 'upload';"
    get_upload_details_records = run_query(get_upload_details_query,'query')
    if len(get_upload_details_records) > 0:
        for obj in get_upload_details_records:
            get_approver_query = "SELECT User_Name,User_Email_Id,User_Id,Access_Type FROM User_Access where Access_Type='MKT_SPEND_APPROVE' and Country='{0}';"
            approver_data = run_query(get_approver_query.format(obj.get('Country')),'query')
            if len(approver_data) > 0:
                to_To = ''
                approver_userid_list = []
                for approver_obj in approver_data:
                    to_To = to_To+approver_obj.get('User_Email_Id')+";"
                    approver_userid_list.append(approver_obj.get("User_Id"))
                if len(approver_userid_list) == 1:
                    approver_userid_list = "('"+str(approver_userid_list[0])+"')"
                else:
                    approver_userid_list = tuple(approver_userid_list)
                is_data_already_approved_query = "select * from Mail_Info where Status in ('rejected','approved') and Year_Month_Num = {0} and Country = '{1}' and Template_Type = '{2}' and Approved_By in {3};"
                is_action_taken = run_query(is_data_already_approved_query.format(obj.get('Year_Month_Num'),
                                            obj.get('Country'),obj.get('Template_Type'),
                                            approver_userid_list
                                            ),'query')
                if len(is_action_taken) > 0:
                    continue
                get_uploader_query = "SELECT User_Name, User_Email_Id FROM User_Access where User_Id ='{0}';"
                uploader_data = run_query(get_uploader_query.format(obj.get('Loaded_By')),'query')
                if len(uploader_data) > 0:
                    msg = upload_constants.msg_string.format('Approvers',
                                            obj.get('Template_Type'),
                                            obj.get('Country'),
                                            obj.get('Year_Month_Num'),
                                            obj.get('Created_Date'))
                    to_Cc = uploader_data[0].get('User_Email_Id')
                    res = send_mail(msg,'',to_Cc, to_To)
                    if res:
                        update_count_query = "update Mail_Info set Mail_Counter=Mail_Counter+1 where \
                            Status='upload' and \
                            Year_Month_Num={0} and \
                            Country='{1}' and \
                            Template_Type='{2}' and \
                            Loaded_By='{3}';"
                        run_query(update_count_query.format(obj.get('Year_Month_Num'),obj.get('Country'),
                                                  obj.get('Template_Type'),obj.get('Loaded_By')),'query')


def check_procedure_status():
    """
    This function to check procedure status. If Procedure Execution is done.
    send mail. 
    """
    get_status_query = "select * from Job_Info where Email_Sent_Flag='N' and Job_Status = 'Y' and Job_Type = 'Upload';"
    new_records = run_query(get_status_query,'query')
    logger.info("new records for mails")
    logger.info(new_records)
    if len(new_records) > 0:
        for obj in new_records:
            get_uploader_details_query = "SELECT User_Name,User_Email_Id FROM User_Access where Access_Type = 'MKT_SPEND_UPLOAD' and User_Id = '{0}' and Country = '{1}';"
            uploader_info = run_query(get_uploader_details_query.format(obj.get('Uploaded_By'),obj.get('Country')),'query')
            if len(uploader_info) > 0:
                get_approver_query = "SELECT User_Email_Id FROM User_Access where Access_Type='MKT_SPEND_APPROVE' and Country='{0}';"
                approver_data = run_query(get_approver_query.format(obj.get('Country')),'query')
                if len(approver_data) > 0:
                    to_Cc = ''
                    for approver_obj in approver_data:
                        to_Cc = to_Cc+approver_obj.get('User_Email_Id')+";"
                    msg = upload_constants.msg_string.format('Approvers',obj.get('Template_Type'),obj.get('Country'),obj.get('Year_Month_Num'),obj.get('Created_Date'))
                    is_email_sent = send_mail(msg,'',to_Cc, uploader_info[0].get('User_Email_Id'))
                    if is_email_sent:
                        mail_sent_update_query = "update Job_Info set Email_Sent_Flag = 'Y', Email_Sent_Date = CURRENT_TIMESTAMP() where Job_ID = {0};"
                        update_mail_status = run_query(mail_sent_update_query.format(obj.get('Job_ID')),'query')
                    logger.info(is_email_sent)



def save_excel(file_decoded_data,type,user,user_id,actual_file_name,country,file_type):
    """
    """
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    file_name = 'temp_excel.xlsx'
    temp_excel = open(BASE_DIR+'/upload/'+file_name,'wb')
    temp_excel.write(file_decoded_data)
    temp_excel.close()
    try:
        file_data = pandas.read_excel(BASE_DIR+'/upload/'+file_name,index_col=None,skiprows=2,skip_blank_lines=False)
    except Exception as e:
        return {'status':False,'error':repr(e)}
    if isinstance(upload_constants.XLSX_COLUMN_MAPPING.get(type),list):
        file_headers = list(map(lambda x: x.replace('\n',''),list(file_data.columns)))
        for req_header in upload_constants.XLSX_COLUMN_MAPPING.get(type):
            if "*" in req_header and req_header not in file_headers:
                return {'status':False,'error':req_header+' column is required for excel "{0}" OR template type and file are different'.format(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING.get(type).replace("_"," "))}
    if not os.path.exists(BASE_DIR+'/uploaded_files/'+user):
        os.mkdir(BASE_DIR+'/uploaded_files/'+user)
        copyfile(BASE_DIR+'/upload/'+file_name, BASE_DIR+'/uploaded_files/'+user+'/'+actual_file_name)
    else:
        if os.path.exists(BASE_DIR+'/uploaded_files/'+user+'/'+actual_file_name):
            os.remove(BASE_DIR+'/uploaded_files/'+user+'/'+actual_file_name)
        copyfile(BASE_DIR+'/upload/'+file_name, BASE_DIR+'/uploaded_files/'+user+'/'+actual_file_name)
    os.remove(BASE_DIR+'/upload/'+file_name)
    query = "insert into user_uploaded_files_history(user_id,user_name,country,file_type,file_name,created_date) values{0};"
    data = (user_id,user,country,file_type,actual_file_name,datetime.datetime.strftime(datetime.datetime.now(),"%Y-%m-%d %H:%M:%S"))
    response = run_query(query.format(data),'query')
    return