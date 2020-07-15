import json

from rest_framework.exceptions import APIException

from apps.exception_constants import *



def parse_request_body(body):
    try:
        return json.dumps(body)
    except Exception:
        return json.dumps("")

class GenericException(APIException):
    detail = None
    exception_code = None
    status_code = 400
    exception_type = EXCEPTION_TYPE_NON_RETRYABLE

    def __init__(self, status_type, exception_code, detail, response=None, request=None, http_code=400):
        self.status_code = http_code
        self.exception_code = exception_code
        self.detail = detail
        if exception_code in RETRYABLE_CODE.values():
            self.exception_type = EXCEPTION_TYPE_RETRYABLE
        if response:
            headers = response.request.headers
            body = response.request.body
            url = response.url
            code = response.status_code
            body = parse_request_body(body)
        if request:
            url = request.path
            code = http_code
            headers = request.META
            if type(request.data) is not dict:
                body = request.data.dict()
            else:
                body = request.data
            body = parse_request_body(body)

def error(e):
    if 'detail' in dir(e):
        return e.detail
    else:
        return repr(e)
