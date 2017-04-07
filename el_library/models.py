from django.db import models


class Profile(models.Model):
    avatar = models.FileField()
    nickname = models.CharField(max_length=20)
    fio = models.CharField(max_length=50)
