# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-05-15 15:51
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('el_library', '0021_auto_20170511_2328'),
    ]

    operations = [
        migrations.AddField(
            model_name='material',
            name='is_app_changed',
            field=models.IntegerField(default=0),
        ),
    ]
