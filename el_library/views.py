from django.shortcuts import render


def index(request):
    # films = Film.objects.filter(is_deleted=0).order_by('-rating')
    # if request.user.is_authenticated():
    #     profile = Profile.objects.get(nickname=request.user.username)
    #     avatar = profile.avatar.name[2:]
    #     return render(request, 'index.html', { 'avatar' : avatar,
    #                                                 'films' : films})
    return render(request, 'index.html')
