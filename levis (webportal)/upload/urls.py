from django.conf.urls import url, include
from . import views

app_name = 'upload'

urlpatterns = [
    url(r'^$', views.CheckExcel.as_view(), name='check_excel'),
    url(r'^upload_excel/$', views.SubmitExcel.as_view(), name='submit_excel'),
    url(r'^download_excel/$', views.DownloadExcel.as_view(), name='download_excel'),
    url(r'^approved_data/$',views.ApproveData.as_view(), name='approved_data'),
    ]