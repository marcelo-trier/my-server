
# https://stackoverflow.com/a/61513351

# map ???

server {
    listen 5020;

    root /var/www/http;
    # index /;

    location / {
        try_files $uri $uri/ @app;
    }

    # https://stackoverflow.com/q/71775280
    location ~ ^/(?<estudante>.+)$ {
        rewrite ^/(.*)$  http://localhost:5004 redirect;
        #rewrite ^/(.*)$ / pass;
        #return 403;
        #proxy_pass http://localhost:5000;
    }

    location @app {
        proxy_pass http://localhost:5000;
    }
}


server {
    listen 8080;
    #server_name   ~ ^marcelo\-trier(.*)/(?<estudante>.+)$;
    error_log /var/logs/nginx/error.log debug;

    location / {
        try_files $uri $uri/ @app;
        root /data/www;
    }

    location ~ ^/(?<estudante>.+)$ {
        proxy_pass http://localhost:8080;
    }

        # location / {
        #     content_by_lua_block{
        #     os.execute("sh /tmp/s3.sh")
        #     }

    location @app {
        proxy_pass http://localhost:8080;
    }
}
