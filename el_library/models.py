# -*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.decorators import login_required
import tagulous.models


class Profile(models.Model):
    avatar = models.FileField()
    nickname = models.CharField(max_length=20)
    fio = models.CharField(max_length=50)


class Tags(models.Model):
    tag = models.CharField(max_length=25)


class Rubrik(models.Model):
    name = models.CharField(max_length=100)
    parent_id = models.IntegerField(null=True)


class Material(models.Model):
    title = models.CharField(max_length=100)
    author = models.CharField(max_length=100)
    description = models.CharField(max_length=2000)
    rating = models.FloatField(default=0)
    TYPES_MATERIAL = (
        ('Book', 'Книга'),
        ('Method', 'Методические указания'),
        ('Ucheb', 'Учебное пособие'),
        ('Article', 'Статья'),
        ('Ref', 'Реферта'),
        ('Esse', 'Эссе'),
        ('Other', 'Другое'),
    )
    type_material = models.CharField(max_length=20, choices=TYPES_MATERIAL)
    rubrik = models.ForeignKey(Rubrik, null=True, on_delete=models.SET_NULL)
    isbn = models.IntegerField(null=True)
    tags = models.ManyToManyField(Tags)
    document = models.FileField(default=0)
