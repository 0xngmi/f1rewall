from gevent.pywsgi import WSGIServer
from app import app
import os

print(f"Serving on port {os.environ.get('PORT')}")

http_server = WSGIServer(('', os.environ.get('PORT')), app)
http_server.serve_forever()