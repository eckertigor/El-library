# -*- coding: utf-8
from django.shortcuts import render
from el_library.forms import UserForm, LoginForm
from django.contrib import auth
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect, Http404, JsonResponse


def index(request):
    # films = Film.objects.filter(is_deleted=0).order_by('-rating')
    # if request.user.is_authenticated():
    #     profile = Profile.objects.get(nickname=request.user.username)
    #     avatar = profile.avatar.name[2:]
    #     return render(request, 'index.html', { 'avatar' : avatar,
    #                                                 'films' : films})
    return render(request, 'index.html')


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
            p = Profile.objects.create(nickname=username,
                                avatar=request.FILES['avatar'], fio=fio)
            p.save()
            response_data['result'] = u'Вы успешно зарегестрировались'
            response_data['button'] = u'Войти?'
            return JsonResponse(response_data)
        else:
            response_data['error'] = u'Проверьте введенные данные'
            return JsonResponse(response_data)
    else:
        form = UserForm()
        return render(request, 'signup.html', { 'form' : form })

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
        return render(request, 'login.html', { 'form' : form })
