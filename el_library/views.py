# -*- coding: utf-8
from django.shortcuts import render
from el_library.forms import UserForm, LoginForm, MaterialForm, CollectionForm
from el_library.models import Profile, Material, Tags, Rubrik, Collection
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
    if request.user.is_authenticated():
        collections = Collection.objects.filter(user=request.user)
        return render(request, 'material.html', {'material': material,
                                            'collections': collections})
    return render(request, 'material.html', {'material': material})


def my(request):
    if request.user.is_authenticated():
        materials = Material.objects.filter(user=request.user)
        return render(request, 'my.html', {'materials': materials})
    else:
        return redirect('/login/')


def add_to_collection(request, material_id, collection_id):
    if request.method == 'POST':
        response_data = {}
        material = Material.objects.get(id=material_id)
        collection = Collection.objects.get(id=collection_id)
        collection.materials.add(material)
        response_data['result'] = 'success'
        return JsonResponse(response_data)


def del_from_collection(request, material_id, collection_id):
    if request.method == 'POST':
        response_data = {}
        material = Material.objects.get(id=material_id)
        collection = Collection.objects.get(id=collection_id)
        if collection.user == request.user:
            collection.materials.remove(material)
            response_data['result'] = 'success'
            return JsonResponse(response_data)


def collections(request):
    if request.user.is_authenticated():
        if request.method == 'GET':
            collections = Collection.objects.filter(user=request.user)
            return render(request, 'collections.html', {'collections': collections})
    else:
        return redirect('/login/')


def collection(request, collection_id):
    try:
        collection = Collection.objects.get(id=collection_id)
    except Collection.DoesNotExist:
        return redirect('/collections/')
    if collection.user == request.user:
        return render(request, 'collection.html', {'collection': collection})
    else:
        return redirect('/collections/')


def create_collection(request):
    if request.user.is_authenticated():
        if request.method == 'POST':
            response_data = {}
            form = CollectionForm(request.POST)
            if form.is_valid():
                collection_title = form.cleaned_data.get('title')
                if Collection.objects.filter(title=collection_title).exists():
                    response_data['error'] = u'Коллекция с таким названием уже существует'
                    return JsonResponse(response_data)
                Collection.objects.create(title=collection_title, user=request.user)
                response_data['result'] = u'Коллекция успешно создана'
                response_data['button'] = u'Вернуться к списку коллекций?'
                return JsonResponse(response_data)
            else:
                response_data['error'] = u'Проверьте введенные данные'
                return JsonResponse(response_data)
        if request.method == 'GET':
            form = CollectionForm()
            return render(request, 'create_collection.html', {'form': form})
    else:
        return redirect('/login/')


def signup(request):
    if request.method == 'POST':
        response_data = {}
        form = UserForm(request.POST, request.FILES)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            fio = form.cleaned_data.get('fio')
            email = form.cleaned_data.get('email')
            password = form.cleaned_data.get('password')
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


def search(request, type_r, query):
    rubrik = Rubrik.objects.get(id=query)
    materials = Material.objects.filter(rubrik=rubrik.id)
    return render(request, 'search.html', {'materials': materials, 'query': query})


def tags(request):
    if request.method == 'GET':
        response_data = {}
        data = Tags.objects.only('tag').all()
        response_data = serializers.serialize('json', data)
        return HttpResponse(response_data, content_type='application/json')


def catalog(request):
    return render(request, 'catalog.html')


def rubrik(request):
    if request.method == 'GET':
        response_data = {}
        data = Rubrik.objects.filter(is_approved=1).order_by('pk')
        response_data = serializers.serialize('json', data)
        return HttpResponse(response_data, content_type='application/json')


def delete_material(request, action, material_id):
    material = Material.objects.get(id=material_id)
    if material.user == request.user or request.user.is_superuser:
        if request.method == 'POST':
            response_data = {}
            if action == 'delete':
                material.is_deleted = 1
                response_data['result'] = u'Материал успешно удален'
            elif action == 'restore':
                material.is_deleted = 0
                response_data['result'] = u'Материал успешно восстановлен'
            material.save()
            response_data['button'] = u'Вернуться в личный кабинет?'
            return JsonResponse(response_data)
    else:
        return redirect('/material/'+str(material.id))


def edit_material(request, material_id):
    material = Material.objects.get(id=material_id)
    if material.user == request.user or request.user.is_superuser:
        if request.method == 'POST':
            response_data = {}
            if 'document' not in request.FILES:
                request.FILES['document'] = material.document
            materialForm = MaterialForm(request.POST, request.FILES)
            existing_tag = []
            if materialForm.is_valid():
                tags_list = materialForm.cleaned_data.get('tags').split(',')
                rubrik_name = materialForm.cleaned_data.get('rubrik')
                rubrik_parent = materialForm.cleaned_data.get('rubrik_parent')
                try:
                    rubrik = Rubrik.objects.get(name=rubrik_name)
                except Rubrik.DoesNotExist:
                    parent = Rubrik.objects.get(name=rubrik_parent)
                    rubrik = Rubrik.objects.create(name=rubrik_name, parent_id=parent.id, is_approved=0)
                if (materialForm.cleaned_data.get('isbn_hidden') == ''):
                    isbn = 0
                else:
                    isbn = materialForm.cleaned_data.get('isbn_hidden')
                material.title = materialForm.cleaned_data.get('title')
                material.author = materialForm.cleaned_data.get('author')
                material.type_material = materialForm.cleaned_data.get('types')
                material.description = materialForm.cleaned_data.get('description')
                material.document = materialForm.cleaned_data.get('document')
                material.isbn = isbn
                material.rubrik_id = rubrik.id
                material.user = request.user
                for tag in tags_list:
                    try:
                        Tags.objects.get(tag=tag)
                        existing_tag.append(Tags.objects.get(tag=tag))
                    except Tags.DoesNotExist:
                        existing_tag.append(Tags.objects.create(tag=tag))
                material.tags.clear()
                material.tags.add(*existing_tag)
                material.save()
                response_data['result'] = u'Материал успешно изменен'
                if request.user.is_superuser:
                    response_data['button'] = u'Вернуться в панель управления?'
                else:
                    response_data['button'] = u'Вернуться в личный кабинет?'
                return JsonResponse(response_data)
            else:
                response_data['error'] = u'Проверьте правильность введеных данных'
                return JsonResponse(response_data)
        else:
            tags = material.tags.all().values_list('tag', flat=True)
            tags = list(tags)
            tags = repr(tags).decode("unicode_escape")
            tags = tags.replace("u'", '')
            tags = tags.replace("'", '')
            tags = tags.replace("[", '')
            tags = tags.replace("]", '')
            if material.isbn != 0:
                isbn_state = 'yes'
            else:
                isbn_state = 'no'
            form = MaterialForm(initial=
                {'title': material.title, 'author': material.author,
                 'description': material.description, 'types': material.type_material,
                 'rubrik': material.rubrik.name, 'isbn': isbn_state,  'document': material.document,
                 'tags': tags, 'isbn_hidden': material.isbn, 'rubrik_parent': material.rubrik.parent_id,
                 })
            return render(request, 'edit.html',
                            { 'form': form, 'material': material })
    else:
        return redirect('/material/'+str(material.id))


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
            # response_data['error'] = materialForm.errors
            response_data['error'] = u'Проверьте правильность введенных данных'
            return JsonResponse(response_data)
    else:
        form = MaterialForm()
        return render(request, 'add.html', {'form': form})


def lk(request):
    if request.user.is_authenticated():
        return render(request, 'lk.html')
    else:
        return redirect('/login/')


def control(request):
    if request.user.is_superuser:
        return render(request, 'control.html')
    else:
        return redirect('/login/')


def control_materials(request):
    if request.user.is_superuser:
        try:
            materials = Material.objects.filter(is_approved=0)
        except Materil.DoesNotExist:
            materials = {}
        return render(request, 'control_materials.html', {'materials': materials})
    else:
        return redirect('/')


def control_approve_material(request, material_id):
    if request.user.is_superuser:
        material = Material.objects.get(id=material_id)
        material.is_approved = 1
        material.save()
        response_data = {}
        response_data['result'] = 'success'
        return JsonResponse(response_data)


def control_users(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            user = User.objects.get(id=user_id)
            user.is_activate = False
            user.save()
            response_data['result'] = 'success'
            return JsonResponse(response_data)
        elif request.method == 'GET':
            users = User.objects.all()
            return render(request, 'control_users.html', {'users':users})


def control_rubrik(request):
    if request.user.is_superuser:
        if request.method == 'GET':
            rubriks = Rubrik.objects.all()
            return render(request, 'control_rubrik.html', {'rubriks': rubriks})


def control_block_user(request, user_id):
    if request.user.is_superuser:
        if request.method == 'POST':
            response_data = {}
            user = User.objects.get(id=user_id)
            user.is_active = False
            user.save()
            response_data['result'] = 'success'
            return JsonResponse(response_data)


def logout(request):
    auth.logout(request)
    return redirect('login/')
