# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-05-03 17:35
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('el_library', '0015_auto_20170503_1734'),
    ]

    operations = [
        migrations.AddField(
            model_name='profile',
            name='avatar',
            field=models.FileField(default=0, upload_to=''),
            preserve_default=False,
        ),
    ]
