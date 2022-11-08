# from: https://github.com/do-community/k8s-intro-meetup-kit/blob/master/app/app.py

import os
import getpass

myoffset = int(os.getenv('MYPORT_OFFSET', '4000'))
myuser = getpass.getuser()
myport = myoffset + os.getuid()


from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return f"Pagina principal. Usuário: {myuser}"

@app.route('/teste')
def outro_teste():
    return f"este é só mais um teste do usuário: {myuser}.... "


if __name__ == "__main__":
  print('Seu site esta rodando na porta:', myport)
  app.run(port=myport, host='0.0.0.0', debug=True, threaded=True)
