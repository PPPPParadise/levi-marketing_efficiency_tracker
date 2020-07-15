from django.conf.urls import url, include
import accounts,upload

app_name = 'apps'

urlpatterns = [
    url(r'^accounts/', include('accounts.urls',namespace='accounts')),
    url(r'^upload/',include('upload.urls',namespace='upload'))
]