# -*- coding: utf-8
from django.shortcuts import render
from el_library.forms import UserForm, LoginForm, MaterialForm
from el_library.models import Profile, Material, Tags, Rubrik
from django.contrib import auth
from django.core import serializers
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect, Http404, JsonResponse, HttpResponse
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required


def index(request):
    materials = Material.objects.all()
    return render(request, 'index.html', {'materials': materials})


def material(request, material_id):
    try:
        material = Material.objects.get(id=material_id)
    except Material.DoesNotExist:
        raise Http404
    return render(request, 'material.html', {'material': material})


def signup(request):
    if request.method == 'POST':
        response_data = {}
        form = UserForm(request.POST, request.FILES)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            fio = form.cleaned_data.get('fio')
            email = form.cleaned_data.get('email')
            password = form.cleaned_data.get('password')
            avatar = form.cleaned_data.get('avatar')
            if User.objects.filter(username=username).exists():
                response_data['error'] = u'Пользователь с таким username уже существует'
                return JsonResponse(response_data)
            if User.objects.filter(email=email).exists():
                response_data['error'] = u'Пользователь с таким email уже существует'
                return JsonResponse(response_data)
            u = User.objects.create_user(username, email, password)
            p = Profile.objects.create(nickname=username, fio=fio)
            p.save()
            response_data['result'] = u'Вы успешно зарегестрировались'
            response_data['button'] = u'Войти?'
            return JsonResponse(response_data)
        else:
            response_data['error'] = u'Проверьте введенные данные'
            return JsonResponse(response_data)
    else:
        form = UserForm()
        return render(request, 'signup.html', {'form': form})


def tags(request):
    if request.method == 'GET':
        response_data = {}
        data = Tags.objects.only('tag').all()
        response_data = serializers.serialize('json', data)
        return HttpResponse(response_data, content_type='application/json')


def rubrik(request):
    if request.method == 'GET':
        response_data = {}
        data = Rubrik.objects.all()
        response_data = serializers.serialize('json', data)
        return HttpResponse(response_data, content_type='application/json')


def login(request):
    if request.user.is_authenticated():
        return redirect('/')
    if request.method == 'POST':
        response_data = {}
        email = request.POST.get('email')
        password = request.POST.get('password')
        try:
            userByEmail = User.objects.get(email=email)
        except User.DoesNotExist:
            response_data['error'] = u'Пользователь с таким email не найден'
            return JsonResponse(response_data)
        user = auth.authenticate(username=userByEmail.username, password=password)
        if user is not None:
            auth.login(request, user)
            # profile = Profile.objects.get(nickname=userByEmail.username)
            # response_data['avatar'] = profile.avatar.name[2:]
            response_data['result'] = u'Вы успешно авторизировались'
            response_data['user'] = userByEmail.username
            return JsonResponse(response_data)
        else:
            response_data['error'] = u'Проверьте правильность введенных данных'
            return JsonResponse(response_data)
    else:
        form = LoginForm()
        return render(request, 'login.html', {'form': form})


@login_required
def add_material(request):
    if request.method == 'POST':
        response_data = {}
        materialForm = MaterialForm(request.POST, request.FILES)
        if materialForm.is_valid():
            materialForm.save_material(request)
            response_data['result'] = u'Материал успешно добавлен!'
            response_data['button'] = u'Вернуться в панель управления?'
            return JsonResponse(response_data)
        else:

            # response_data['error'] = u'Проверьте правильность введенных данных'
            response_data['error'] = materialForm.errors
            return JsonResponse(response_data)
    else:
        form = MaterialForm()
        return render(request, 'add.html', {'form': form})


def logout(request):
    auth.logout(request)
    return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
