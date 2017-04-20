# -*- coding: utf-8 -*-
from django.contrib.auth.models import User
from django import forms
from el_library import models
from el_library.models import Material, Tags
import tagulous.forms

# from el_library_projeect.models import Film


class UserForm(forms.Form):
	username = forms.CharField(
		required=True,
		widget=forms.TextInput(attrs={'class': 'form-control', 'maxlength': 20})
	)
	fio = forms.CharField(
		required=True, label=u'ФИО',
		widget=forms.TextInput(attrs={'class': 'form-control', 'maxlength': 50})
	)
	email = forms.EmailField(
		required=True,
		widget=forms.EmailInput(attrs={'class': 'form-control'})
	)
	password = forms.CharField(
		required=True,
		widget=forms.PasswordInput(attrs={'class': 'form-control'})
	)


class ProfileForm(forms.Form):
	username = forms.CharField(
		widget=forms.TextInput(attrs={'class': 'form-control'})
	)
	email = forms.EmailField(
		widget=forms.TextInput(attrs={'class': 'form-control'})
	)
	avatar = forms.FileField(
		label='Select a profile Image'
	)


class LoginForm(forms.Form):
	email = forms.EmailField(
		required=True,
		widget=forms.EmailInput(attrs={'class': 'form-control', 'required': 'true'})
	)
	password = forms.CharField(
		widget=forms.PasswordInput(attrs={'class': 'form-control', 'required': 'true'})
	)


class MaterialForm(forms.Form):
	title = forms.CharField(
		required=True, label=u'Заголовок материала',
		widget=forms.TextInput(attrs={'class': 'form-control', 'required': 'true', 'maxlength': 100})
	)
	author = forms.CharField(
		required=True, label=u'Автор',
		widget=forms.TextInput(attrs={'class': 'form-control', 'required': 'true', 'maxlength': 100})
	)
	TYPES_MATERIAL = (
        ('Book', 'Книга'),
        ('Method', 'Методические указания'),
        ('Ucheb', 'Учебное пособие'),
        ('Article', 'Статья'),
        ('Ref', 'Реферат'),
        ('Esse', 'Эссе'),
        ('Other', 'Другое'),
    )
	types = forms.ChoiceField(choices = TYPES_MATERIAL, required=True, label=u'Тип материала ')
	rubrik = forms.CharField(
		required=True, label=u'Рубрика',
		widget=forms.TextInput(attrs={'class': 'form-control', 'required': 'true', 'maxlength': 100})
	)
	tags = forms.CharField(
		required=True, label=u'Теги (введите теги через пробел)',
		widget=forms.TextInput(attrs={'class': 'form-control', 'required': 'true', 'maxlength': 100})
	)

	description = forms.CharField(
		required=True, label=u'Описание материала',
		widget=forms.Textarea(attrs={'class':'form-control',
										'maxlength':2000, 'rows':5})
	)
	document = forms.FileField(
		required=True, label=u'Выберите файл'
	)

	def save_material(self, request):
		existing_tag = []
		tags_list = self.cleaned_data.get('tags').split(',')
		material = Material.objects.create(
			title = self.cleaned_data.get('title'),
			author = self.cleaned_data.get('author'),
			type_material = self.cleaned_data.get('types'),
			description = self.cleaned_data.get('description'),
			document = self.cleaned_data.get('document'),
			)
		for tag in tags_list:
			try:
				Tags.objects.get(tag=tag)
				existing_tag.append(Tags.objects.get(tag=tag))
			except Tags.DoesNotExist:
				existing_tag.append(Tags.objects.create(tag=tag))
		material.tags.add(*existing_tag)
		material.save()
		return material
