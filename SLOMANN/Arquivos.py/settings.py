from django.views import generic
from django.http.response import HttpResponse
from django.conf import settings

class SpotifyBotView(generic.View):

    def get(self, request, *args, **kwargs):
        if self.request.GET.get(u'hub.verify_token') == settings.TOKEN_VERIFY:
            return HttpResponse(self.request.GET['hub.challenge'])
        else:
            return HttpResponse('Error, invalid token')




Application definition

DEFAULT_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

THIRD_PARTY_APPS = []

LOCAL_APPS = [
    'chatbot',
]

INSTALLED_APPS = LOCAL_APPS + THIRD_PARTY_APPS + DEFAULT_APPS

ALLOWED_HOSTS = [
    '*',
]