from django.conf.urls import url, include
from django.contrib import admin
import apps

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^o/', include('oauth2_provider.urls', namespace='oauth2_provider')),
    url(r'^api/',include('apps.urls',namespace='apps'))
]
