def helloWorld(request):
    if request.path != "/helloWorld":
        return ("Not Found", 404)
    return ("Hello, World from Cloud Functions!", 200)
