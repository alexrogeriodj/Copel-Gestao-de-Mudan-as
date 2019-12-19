from django.conf.urls import url, include
from django.contrib import admin
from django.conf.urls import include, url
rom .views import SpotifyBotView


urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^chatbot/', include('chatbot.urls', namespace='chatbot')),
url('^spotify/?$', SpotifyBotView.as_view(), name='spotify')
]