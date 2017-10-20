#Inspired from https://github.com/erlio/docker-vernemq/blob/master/Dockerfile
FROM jbonachera/alpine
MAINTAINER Julien BONACHERA <julien+docker-vernemq@bonachera.fr>
# MQTT
EXPOSE 1883
# MQTT/SSL
EXPOSE 8883
# MQTT WebSockets
EXPOSE 8080
# Prometheus Metrics
EXPOSE 8888
VOLUME ["/var/log/vernemq", "/var/lib/vernemq"]

COPY release/vernemq /usr/share/vernemq
RUN apk -U add libstdc++ bind-tools libressl2.5-libcrypto && \
    rm -rf /var/cache/apk/*
RUN mkdir /etc/vernemq
COPY vernemq.conf.j2 /etc/vernemq/vernemq.conf.j2
COPY vmq.acl /etc/vernemq/vmq.acl
COPY rand_cluster_node.escript /var/lib/vernemq/rand_cluster_node.escript
COPY vm.args.j2 /etc/vernemq/vm.args.j2
COPY entrypoint /sbin/entrypoint
RUN rm -rf /usr/share/vernemq/etc/ && ln -sf /etc/vernemq/ /usr/share/vernemq/etc
RUN ln -sf /usr/share/vernemq/lib /usr/lib/vernemq
RUN rm -rf /usr/share/vernemq/data && ln -sf  /var/lib/vernemq /usr/share/vernemq/data
ENV PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/share/vernemq/bin/
HEALTHCHECK --interval=10s --timeout=3s CMD [[ $(/usr/share/vernemq/bin/vernemq ping) == "pong" ]]
ENTRYPOINT ["/sbin/entrypoint"]
STOPSIGNAL SIGTERM
