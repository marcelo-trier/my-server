import os
import getpass

myoffset = int(os.getenv('MYPORT_OFFSET', '4000'))
myuser = getpass.getuser()
myport = myoffset + os.getuid()


from flask import Flask, request, render_template # Importa a biblioteca
import datetime

app = Flask(__name__) # Inicializa a aplicação

@app.route('/') # Cria uma rota
def main():
  mytime = datetime.datetime.utcnow()
  return render_template('index.html', mytime=mytime)

if __name__ == '__main__':
  app.run(port=myport, host='0.0.0.0', debug=True, threaded=True) 
