# -*- coding: utf-8 -*-
from django.contrib.auth.models import User
from django import forms
from el_library import models
from el_library.models import Material, Tags, Rubrik
import tagulous.forms


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
		required=True, label=u'Название материала',
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
	rubrik_parent = forms.CharField(widget=forms.HiddenInput())
	isbn_choise = (
		('yes', 'Есть'),
		('no', 'Нет'),
	)
	isbn = forms.ChoiceField(widget=forms.RadioSelect, choices=isbn_choise, required=False)
	isbn_hidden = forms.CharField(widget=forms.HiddenInput(), required=False)
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
		rubrik_name = self.cleaned_data.get('rubrik')
		rubrik_parent = self.cleaned_data.get('rubrik_parent')
		try:
			rubrik = Rubrik.objects.get(name=rubrik_name)
		except Rubrik.DoesNotExist:
			parent = Rubrik.objects.get(name=rubrik_parent)
			rubrik = Rubrik.objects.create(name=rubrik_name, parent_id=parent.id, is_approved=0)
		if (self.cleaned_data.get('isbn_hidden') == ''):
			isbn = 0
		else:
			isbn = self.cleaned_data.get('isbn_hidden')
		material = Material.objects.create(
			title = self.cleaned_data.get('title'),
			author = self.cleaned_data.get('author'),
			type_material = self.cleaned_data.get('types'),
			description = self.cleaned_data.get('description'),
			document = self.cleaned_data.get('document'),
			isbn = isbn,
			rubrik_id = rubrik.id,
			user=request.user,
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
