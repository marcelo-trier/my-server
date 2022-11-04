
from flask import Flask, request, render_template # Importa a biblioteca
import datetime

app = Flask(__name__) # Inicializa a aplicação

@app.route('/') # Cria uma rota
def main():
  mytime = datetime.datetime.utcnow()
  return render_template('index.html', mytime=mytime)

if __name__ == '__main__':
  import os
  myport = 4000 + os.getuid()
  app.run(port=myport, host='0.0.0.0', debug=True, threaded=True) 
