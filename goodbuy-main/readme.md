Notes on how to set up this project, what each file does and develope it further.

Requierments: 
Docker, dockercompose.

Clone the project:

git clone https://github.com/Darjusch/docker-test.git

In the root folder of the project run docker-compose to start the server:

docker-compose up --build

If you add a new dependency which can be installed by pip add it to the requirements.txt.

In django you can add "apps" to keep everything modular.

Right now there exist two apps:

Goodbuy and the Api.

Here is how to create a new "app":

python manage.py startapp appname

To let Django recognize this new app we have to add it to our setting.py file in our "main" app(goodbuy) in this format:

INSTALLED_APPS = [
    'appname.apps.AppnameConfig',
    ... # Leave all the other INSTALLED_APPS
]

In models.py you can create models for the Database.
When you create a model you have to execute two commands to make the changes happen:

python3 manage.py makemigrations

python3 manage.py migrate

To see your database models in the Django admin view you have to register them in the admin.py of the associate app:

from django.contrib import admin
from .models import Modelname
admin.site.register(Modelname)

In order to server our models as JSON's and receive JSON's as input of our API we have to use a serializer.
Djangos rest_framework has one build in.
In the api app is a file called serializers.py there you add the new models you created:

class ModelnameSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Modelname
        fields = ('fieldname1', 'fieldname2', '...')


To view the Model we have to create a view and assign a url to that view.
In our views.py:

from rest_framework import viewsets

from .serializers import ModulenameSerializer
from .models import Modulename


class ModulenameViewSet(viewsets.ModelViewSet):
    queryset = Modulename.objects.all().order_by('fieldname')
    serializer_class = ModulenameSerializer


To assign urls to a view we have to edit the urls.py file in our api.

router.register(r'endpointname', views.ViewSetName)

The REST Framework router will make sure our requests end up at the right resource dynamically. If we add or delete items from the database, the URLs will update to match.



