FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY start-nginx.sh /usr/local/bin/start-nginx.sh
COPY src/index.html /usr/share/nginx/html
RUN chmod +x /usr/local/bin/start-nginx.sh
CMD ["/usr/local/bin/start-nginx.sh"]