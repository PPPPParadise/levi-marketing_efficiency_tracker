from django.db import connection

from rest_framework import status
from rest_framework.response import Response


def response(data, code=status.HTTP_200_OK, error=""):
    """
    Overrides rest_framework response
    :param data: data to be send in response
    :param code: response status code(default has been set to 200)
    :param error: error message(if any, not compulsory)
    """
    res = {"error": error, "response": data}
    return Response(data=res, status=code)

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

def run_query(query):
    """
    This function to execute the query
    """
    with connection.cursor() as cursor:
        cursor.execute(query)
        data = dictfetchall(cursor)
        return data
