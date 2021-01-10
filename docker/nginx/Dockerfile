FROM nginx:1.15.8

ENV APP_ROOT /app
WORKDIR ${APP_ROOT}

# Copy Nginx config
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/server.key /etc/ssl/certs/server.key
COPY docker/nginx/server.crt /etc/ssl/certs/server.crt
RUN rm -f /etc/nginx/conf.d/*
COPY docker/nginx/my_app.conf /etc/nginx/conf.d/app.conf

EXPOSE 80

CMD nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
