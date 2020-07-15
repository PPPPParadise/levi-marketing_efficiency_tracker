import copy
import json
import datetime
from django.http import HttpResponse

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from apps import utils as apps_utils
from apps.exception_constants import *
from apps.exceptions import GenericException
from accounts import serializers as accounts_serializers
from accounts import utils as accounts_utils
from upload import utils as upload_utils
from upload import constants as upload_constants
from upload import tasks as upload_tasks
# Create your views here.

class CheckExcel(APIView):
	"""
	This is a Check Excel class
	"""
	def post(self,request):
		"""
		This API for checking the checking the excel data.
		"""
		if request.user and not request.user.is_authenticated:
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail="You're not logged in", request=request)

		is_file_valid = upload_utils.get_decoded_data(request.data.get('params').get('file'),10)
		if not is_file_valid.get('status'):
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail=is_file_valid.get('error'), request=request)
		file_data = upload_utils.read_excel_file(is_file_valid.get('data'),
					str(request.data.get('params').get('type')))
		if not file_data.get('status'):
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail=[file_data.get('error')], request=request)
		# actual_date =  datetime.datetime.strptime(request.data.get('params').get('date')[0:-22],"%a %b %d %Y %H:%M:%S %Z+%f")
		# actual_date =  datetime.datetime.strptime(request.data.get('params').get('date')[0:33],"%a %b %d %Y %H:%M:%S %Z+%f")
		actual_date = request.data.get('params').get('date')
		actual_date = actual_date[0]+" "+actual_date[1]+" "+actual_date[2]+" "+actual_date[3] 
		actual_date =  datetime.datetime.strptime(actual_date,"%a %b %d %Y")
		date = datetime.datetime.strftime(actual_date,"%Y-%m-%d")
		date = date.split("-")[0]+date.split("-")[1]
		country = request.data.get('params').get('country')
		currency = request.data.get('params').get('currency')
		is_data_missing = upload_utils.check_excel_data(file_data['data'],
														str(request.data.get('params').get('type')),
														date,currency,country,actual_date)
		if not is_data_missing.get('status'):
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail=is_data_missing.get('errordict'), request=request)

		upload_utils.save_excel(is_file_valid.get('data'),
								str(request.data.get('params').get('type')),
								request.user.username,
								request.user.id,
								request.data.get('params').get('file_name'),
								request.data.get('params').get('country'),
								request.data.get('params').get('type'))
		# upload_utils.send_mail("testing","","","rshakyawar@cartesianconsulting.com")
		return Response({"status":True,"message":"The template uploaded is error-free. Please proceed to “Submit”.",'data':is_data_missing.get('xls_data')})

class SubmitExcel(APIView):
	"""
	"""
	def post(self,request):
		"""
		"""
		if request.user and not request.user.is_authenticated:
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail="You're not logged in", request=request)
		temp = json.loads(request.data.get('params').get('data'))
		excel_type = request.data.get('params').get('type')
		actual_date = request.data.get('params').get('date')
		actual_date = actual_date[0]+" "+actual_date[1]+" "+actual_date[2]+" "+actual_date[3] 
		actual_date =  datetime.datetime.strptime(actual_date,"%a %b %d %Y")
		# actual_date = datetime.datetime.strptime(request.data.get('params').get('date')[0:-22],"%a %b %d %Y %H:%M:%S %Z+%f")
		date = datetime.datetime.strftime(actual_date,"%Y-%m-%d")
		date = date.split("-")[0]+date.split("-")[1]
		country = request.data.get('params').get('country')
		currency = request.data.get('params').get('currency')
		upload_tasks.my_schedule_task.delay(temp,str(excel_type),country,currency,date,request.user.username)
		# upload_utils.upload_excel_data(temp,str(excel_type),country,currency,date,request.user.username)
		return Response({"status":True,"message":"Thank you! Your file has been accepted. \n Notification e-mail will be sent to the approver once the data is processed (typically within 15 mins)."})

class DownloadExcel(APIView):
	"""
	"""
	def post(self, request):
		"""
		"""
		if request.user and not request.user.is_authenticated:
			raise GenericException(status_type=STATUS_TYPE["APP"],
					exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
					detail="You're not logged in", request=request)
		
		requested_data = {}
		actual_date = request.data.get('params').get('Month')
		actual_date = actual_date[0]+" "+actual_date[1]+" "+actual_date[2]+" "+actual_date[3] 
		actual_date =  datetime.datetime.strptime(actual_date,"%a %b %d %Y")
		# actual_date = datetime.datetime.strptime(request.data.get('params').get('Month')[0:-22],"%a %b %d %Y %H:%M:%S %Z+%f")
		date = datetime.datetime.strftime(actual_date,"%Y-%m-%d")
		requested_data["Month"] = date.split("-")[0]+date.split("-")[1]
		# requested_data["Month"] = datetime.datetime.strftime(datetime.datetime.strptime(request.data.get('params').get('Month'),"%Y-%m-%dT%H:%M:%S.%fZ"),"%Y%m")
		requested_data["Country"] = request.data.get('params').get('Country')
		requested_data["Template_Type"] = upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[str(request.data.get('params').get('Template_Type'))]
		response = upload_utils.download_excel(requested_data)
		if not response.get('status'):
			return Response({"status":False, "message": "Data is not available"})	
		return Response({"status":True, "data":response.get('data'), "template_name":response.get('template_name')})

class ApproveData(APIView):
	"""
	"""

	def post(self, request):
		"""
		"""
		if request.user and not request.user.is_authenticated:
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail="You're not logged in", request=request)
		user = request.user.username
		actual_date = request.data.get('params').get('month')
		actual_date = actual_date[0]+" "+actual_date[1]+" "+actual_date[2]+" "+actual_date[3] 
		actual_date =  datetime.datetime.strptime(actual_date,"%a %b %d %Y")
		# actual_date = datetime.datetime.strptime(request.data.get('params').get('month')[0:-22],"%a %b %d %Y %H:%M:%S %Z+%f")
		date = datetime.datetime.strftime(actual_date,"%Y-%m-%d")
		month = date.split("-")[0]+date.split("-")[1]
		# month = datetime.datetime.strftime(datetime.datetime.strptime(request.data.get('params').get('month'),"%Y-%m-%dT%H:%M:%S.%fZ"),"%Y%m")
		country = request.data.get('params').get('country')
		template_types = ''
		template_types_list = []
		action_dict = {}
		for obj in request.data.get('params').get('template_list'):
			if obj.get('status'):
				status = obj.get('status')
				if status == '1':
					template_types_list.append(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[obj.get('type')])
					action_dict.setdefault(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[obj.get('type')],{}).update({'status':True,'remark':obj.get('remark')})
				if status == '0':
					template_types_list.append(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[obj.get('type')])
					action_dict.setdefault(upload_constants.XLSX_TEMPLATE_TYPE_NAME_MAPPING[obj.get('type')],{}).update({'status':False,'remark':obj.get('remark')})
		upload_tasks.asyn_approve_task.delay(country,month,user,template_types_list,action_dict)
		return Response({"status":True,"message":"Thank you! Submitted action completed. Approved data (if any) shall only reflect upon the MET release schedule."})

