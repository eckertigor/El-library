# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-04-14 00:47
from __future__ import unicode_literals

from django.db import migrations, models
import tagulous.models.models


class Migration(migrations.Migration):

    dependencies = [
        ('el_library', '0006_auto_20170414_0012'),
    ]

    operations = [
        migrations.CreateModel(
            name='Tags',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('slug', models.SlugField()),
                ('count', models.IntegerField(default=0, help_text='Internal counter of how many times this tag is in use')),
                ('protected', models.BooleanField(default=False, help_text='Will not be deleted when the count reaches 0')),
            ],
            options={
                'ordering': ('name',),
                'abstract': False,
            },
            bases=(tagulous.models.models.BaseTagModel, models.Model),
        ),
        migrations.DeleteModel(
            name='_Tagulous_Material_tags',
        ),
        migrations.RemoveField(
            model_name='material',
            name='tags',
        ),
        migrations.AddField(
            model_name='material',
            name='tags',
            field=models.CharField(choices=[('Book', 'Книга'), ('Method', 'Методические указания'), ('Ucheb', 'Учебное пособие'), ('Article', 'Статья'), ('Ref', 'Реферта'), ('Esse', 'Эссе'), ('Other', 'Другое')], default=0, max_length=20),
            preserve_default=False,
        ),
        migrations.AlterUniqueTogether(
            name='tags',
            unique_together=set([('slug',)]),
        ),
    ]
