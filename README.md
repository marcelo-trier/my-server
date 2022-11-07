# my-server


# NGINX
--> este cusom location é um 'alias' para algum outro lugar, caso não encontre a página ou diretório dentro do 'location' especificado, veja exemplo:

```conf
location / {
    try_files $uri $uri/ @my-alias;
}

location @my-alias {
    # rewrite ^/(.+)$ /index.php?_route_=$1 last;
    ... fazer alguma coisa ...
}
```
   
- no caso acima, primeiro irah tentar entrar um arquivo na URI, depois na URI/ e depois em uma outra localização: @my-alias
<!-- 
    proxy_pass http://site/socket.io; 

location ~ ^/~(.+?)(/.*)?$ {
    alias /home/$1/www$2;
    autoindex on;
}

-->
   <br />

- https://serverfault.com/a/811721

```conf
location ~ ^/myradio-([^/]+)
alias /usr/local/www/myradio-$1/src/Public;
alias /usr/local/$request_uri/src/Public
```


<br />
<br />

```conf
location ~ ^/~(.+?)(/.*)?$ {
    alias /home/$1/www$2;
    autoindex on;
}
```

> if you mkdir /etc/skel/www all userdirs created by adduser (or your distributions adduser-script) will have this directory by default.
- https://newbedev.com/hosting-folder-in-the-home-directory-using-nginx
- https://serverfault.com/a/319662
   <br />
   <br />


# Alguns servidores de SCRIPTS:

## Info GUNICORN: 
- https://faun.pub/deploy-flask-app-with-nginx-using-gunicorn-7fda4f50066a

- criar wgsi.py no mesmo diretorio de app.py:
```py
from app import app
 
if __name__ == '__main__':
   app.run()
```


## Info WSGI:
- https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uswgi-and-nginx-on-ubuntu-18-04

- Exemplo: wsgi.py


```py
from myproject import app

if __name__ == "__main__":
    app.run()
```

- Exemplo: nginx-mysite.config
```conf
server {
    listen 80;
    server_name your_domain www.your_domain;

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/home/sammy/myproject/myproject.sock;
    }
}
```
