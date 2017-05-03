"""el_library_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from el_library import views
import tagulous.views
from el_library.models import Material


urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^signup/?', views.signup, name='signup'),
    url(r'^login/?', views.login, name='login'),
    url(r'^admin/', admin.site.urls),
    url(r'^tags/', views.tags, name='tags'),
    url(r'^lk/$', views.lk, name='lk'),
    url(r'^rubrik/', views.rubrik, name='rubrik'),
    url(r'^lk/my/$', views.my, name='my'),
    url(r'^catalog/', views.catalog, name='catalog'),
    url(r'^logout/?', views.logout, name='logout'),
    url(r'^search/(?P<type_r>\d+)?/?(?P<query>\d+)?/?', views.search, name = 'search'),
    url(r'^control/add/$', views.add_material, name='add_material'),
    url(
        r'^api/tags/$',
        tagulous.views.autocomplete,
        {'tag_model': Material},
        name='material_tag_autocomplete',
    ),
    url(r'^material/(?P<material_id>\d+)?/?', views.material, name='mterial'),

]
