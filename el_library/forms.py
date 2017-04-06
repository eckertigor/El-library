# -*- coding: utf-8 -*-
from django.contrib.auth.models import User
from django import forms
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
	avatar = forms.FileField(
		required=True, label=u'Загрузите изображение'
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
