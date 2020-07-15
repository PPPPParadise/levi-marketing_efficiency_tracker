from django.conf import settings
from django.contrib.auth.models import User
from django.db import transaction
from django.utils import six

from rest_framework import serializers
from rest_framework.fields import CharField


class UserLoginSerializer(serializers.Serializer):
	"""
	This Serializer for validating login params
	"""
	username = serializers.CharField(required=True)
	password = serializers.CharField(required=True)

class GetUserDetailsSerializer(serializers.ModelSerializer):
	"""
	This Serializer for parsing user object
	"""
	class Meta:
		model = User
		fields = ("email","first_name","last_name")