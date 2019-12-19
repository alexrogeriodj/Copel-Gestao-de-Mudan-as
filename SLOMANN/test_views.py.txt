from django.test import TestCase, Client
from django.core.urlresolvers import reverse

 class TestSpotifyBotView(TestCase):

    def setUp(self):
        self.url = reverse('chatbot:spotify')

        self.client = Client()
def test_get(self):
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content, "It's Rock!")

def test_get_token_is_invalid(self):
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content, b'Error, invalid token')