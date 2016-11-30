FROM nginx
RUN mv /usr/share/nginx/html /www
ADD ./site.conf /etc/nginx/conf.d/default.conf
ADD dist/ /app
ADD 50x.html /app/
CMD /bin/bash -c "sed -i 's/MAXSCALE_MAXINFO_JSON_LISTENER_TCP_ADDR/$MAXSCALE_MAXINFO_JSON_LISTENER_TCP_ADDR/' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
