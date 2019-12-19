from django.views import generic
from django.http.response import HttpResponse


class SpotifyBotView(generic.View):

    def get(self, request, *args, **kwargs):
        return HttpResponse("It's Rock!")

def get(self, request, *args, **kwargs):
        if self.request.GET.get(u'hub.verify_token') == '123456789':
            return HttpResponse(self.request.GET['hub.challenge'])
        else:
            return HttpResponse('Error, invalid token')