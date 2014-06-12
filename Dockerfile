FROM registry

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install supervisor redis-server nginx

# Supervisor
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD run-nginx /usr/local/bin/run-nginx
RUN chmod 755 /usr/local/bin/run-nginx

# Redis
ADD redis-simple.conf /etc/redis/redis-simple.conf

ENV WORKER_SECRET_KEY fsekfhefsefefe
ENV CACHE_LRU_REDIS_HOST 127.0.0.1
ENV CACHE_LRU_REDIS_PORT 6379
ENV CACHE_LRU_REDIS_PASSWORD fisk
ENV CACHE_REDIS_HOST 127.0.0.1
ENV CACHE_REDIS_PORT 6379
ENV CACHE_REDIS_PASSWORD fisk

EXPOSE 80

CMD ["/usr/bin/supervisord"]