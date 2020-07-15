from django.conf.urls import url, include
from . import views

app_name = 'accounts'

urlpatterns = [
    url(r'^login/', views.Login.as_view(), name='account-login'),
    ]