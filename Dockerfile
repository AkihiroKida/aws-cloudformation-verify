FROM alpine:3.12

ENV TZ=Asia/Tokyo

RUN apk update && apk add squid && apk add sudo && apk add curl && apk add tzdata && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && rm -rf /var/cache/apk/*

RUN echo "squid ALL=(ALL) NOPASSWD: /bin/chown -R squid\:squid /var/log/squid, /bin/chown -R squid\:squid /var/cache/squid" >> /etc/sudoers.d/squid && \
    echo "Defaults:squid !requiretty" >> /etc/sudoers.d/squid && \
    chmod 440 /etc/sudoers.d/squid

COPY squid.conf /etc/squid/squid.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

EXPOSE 8880
USER squid

CMD ["squid", "-NCY"]