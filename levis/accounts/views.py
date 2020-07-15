import copy
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
# Create your views here.

class Login(APIView):
	"""
	This is a Login class
	"""
	def post(self,request):
		"""
		This API logs the user in.with username and password.
        ---
        parameters:
            - name: username
            - name: password
		"""
		login_params = accounts_serializers.UserLoginSerializer(data = request.data)
		if not login_params.is_valid():
			raise GenericException(status_type=STATUS_TYPE["APP"],
				exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
				detail=login_params.errors, request=request)
		params = login_params.data
		response = accounts_utils.login(params, request)
		return apps_utils.response(response,status.HTTP_200_OK)


class Logout(APIView):
	"""
	"""
	def post(self, request):
		"""
		"""
		if not request.user:
			raise GenericException(status_type=STATUS_TYPE["APP"],
					exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
					detail="Access token expired.",
					request=request, http_code=403)
		if request.user and not request.user.is_authenticated():
			raise GenericException(status_type=STATUS_TYPE["APP"],
					exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
					detail="User is not authorize",
					request=request, http_code=403)
		message = '[ User: {0} logged out successfully ]'.format(request.user.email)
		log_action(message,request)
		if accounts_utils.logout(request):
			return apps_utils.response({"message": "User logged out successfully"},status.HTTP_200_OK)
		else:
			raise GenericException(status_type=status_type["APP"], 
					exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
					detail="Some \ error occurred. Please try again in sometime.",
					request=request, http_code=403)
				