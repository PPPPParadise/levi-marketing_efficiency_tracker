import json
import requests

from django.conf import settings
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

from rest_framework import status
#import oauth2_provider.models as oauth_models

from apps.exceptions import GenericException, error
from apps.exception_constants import *
from accounts import serializers as accounts_serializers
from apps import utils as apps_utils

def login(params, request):
    """
    username can be a valid email or a valid phone with 10 digits.
    :parameter
        - request: request parameter
        - params: parameters
    :return: access token
    """
    auth = (settings.OAUTH_CLIENT_ID, settings.OAUTH_CLIENT_SECRET)
    username = params['username']
    password = params['password']
    upload_country_list = []
    approval_country_list = []
    download_country_list = []
    is_eligible = False
    is_eligible_for_approved = False
    last_uploads = False
    user_obj = User.objects.filter(username=username).first()
    last_update = {"ATL":{"date":'','status':''},
                  "CRM": {"date":'','status':''},
                  "PR": {"date":'','status':''},
                  "Digital":{"date":'','status':''}}
    last_upload = {"ATL":{"date":'','status':''},
                "CRM": {"date":'','status':''},
                "PR": {"date":'','status':''},
                "Digital":{"date":'','status':''}}
    if not user_obj:
        raise GenericException(status_type=STATUS_TYPE["APP"], exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
                                detail=repr("Invalid Username"), request=request)
    if user_obj and not user_obj.is_active:
        raise GenericException(status_type=STATUS_TYPE["APP"], exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
                                   detail=repr("This User is not active"), request=request)
    is_authenticate_user = authenticate(username=username, password=password)
    if not is_authenticate_user:
        raise GenericException(status_type=STATUS_TYPE["APP"], exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
                                detail=repr("Invalid Password"), request=request)
    response = requests.post(settings.BASE_URL + 'o/token/', data={'username': username, 'password': password, 'grant_type': 'password'}, auth=auth,
                             verify=False)
    user_details = accounts_serializers.GetUserDetailsSerializer(user_obj).data
    if response.status_code == status.HTTP_200_OK:
        result = json.loads(response.text)
        query = "SELECT Access_Type, Country FROM User_Access where Access_Type = 'MKT_SPEND_UPLOAD' and Okta_Id = '{0}';"
        eligibility = apps_utils.run_query(query.format(username))
        query_approved = "SELECT Access_Type, Country FROM User_Access where Access_Type = 'MKT_SPEND_APPROVE' and Okta_Id = '{0}';"
        # last_update_query = "SELECT Updated_Date,Template_Name FROM MKT_Template_Spend where Approved_By = '{0}' GROUP BY Template_Name;"
        last_update_query = "select * from (SELECT distinct Template_Type,Created_Date,Status,row_number() over (partition by Template_Type order by Created_Date desc) as rank \
                                FROM Mail_Info where Approved_By = '{0}') a where rank = 1;"
        last_upload_query = "select * from (SELECT distinct Template_Type,Created_Date,Status,row_number() over (partition by Template_Type order by Created_Date desc) as rank \
                                FROM Mail_Info where Country = '{0}' and Status = 'upload') a where rank = 1;"
        eligibility_for_download_country = "SELECT Country from User_Access where Okta_Id = '{0}' group by Country;"
        eligibility_for_download_country = apps_utils.run_query(eligibility_for_download_country.format(username))
        if eligibility_for_download_country:
            is_eligible_for_download = True
            for obj in eligibility_for_download_country:
                download_country_list.append(obj.get('Country'))
        if eligibility:
            is_eligible = True
            for obj in eligibility:
                upload_country_list.append(obj.get('Country'))
        
        approved_eligibility = apps_utils.run_query(query_approved.format(username))
        if approved_eligibility:
            is_eligible_for_approved = True
            for obj in approved_eligibility:
                approval_country_list.append(obj.get('Country'))
        last_updates = apps_utils.run_query(last_update_query.format(username))
        if last_updates:
            for obj in last_updates:
                last_update.setdefault(obj.get('Template_Type'),{}).update({'date':obj.get('Created_Date'),'status':obj.get('Status')})
        if is_eligible:
            last_uploads = apps_utils.run_query(last_upload_query.format(upload_country_list[0]))
        if approved_eligibility:
            last_uploads = apps_utils.run_query(last_upload_query.format(approval_country_list[0]))
        if last_uploads:
            for obj in last_uploads:
                last_upload.setdefault(obj.get('Template_Type'),{}).update({'date':obj.get('Created_Date'),'status':obj.get('Status')})
        return {"status": True, "access_token": result['access_token'],"user_details":user_details,
                "is_eligible_for_upload":is_eligible,"uploader_for_country":upload_country_list,"last_updates":last_update,
                "last_uploads":last_upload,"is_eligible_for_approved":is_eligible_for_approved,
                "approval_for_country":approval_country_list,"is_eligible_for_download":is_eligible_for_download,
                "download_for_country":download_country_list}
    else:
        raise GenericException(status_type=STATUS_TYPE["APP"], exception_code=NONRETRYABLE_CODE["BAD_REQUEST"],
                               detail=str(response.json().get('error_description')),
                               request=request)

def logout(request):
    """
        Logs out the user
        Params: access_token to be rendered invalid
    """
    try:
        data = {}
        data['client_id'] = settings.OAUTH_CLIENT_ID
        data['client_secret'] = settings.OAUTH_CLIENT_SECRET
        data['token'] = request.META["HTTP_AUTHORIZATION"].split(" ")[1]
        resp = requests.post(settings.BASE_URL + 'o/revoke_token/', data=data, verify=False)
        return resp.status_code == status.HTTP_200_OK
    except Exception as e:
        raise GenericException(status_type=STATUS_TYPE["APP"], exception_code=NONRETRYABLE_CODE["BAD_REQUEST"], detail=error(e), request=request,
                               http_code=403)