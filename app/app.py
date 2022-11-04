# from: https://github.com/do-community/k8s-intro-meetup-kit/blob/master/app/app.py

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'



if __name__ == "__main__":
  import os
  myport = 4000 + os.getuid()
  print('Seu site esta rodando na porta:', myport)
  app.run(port=myport, host='0.0.0.0', debug=True, threaded=True)
