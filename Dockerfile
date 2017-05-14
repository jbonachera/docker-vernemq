FROM jbonachera/arch
ENV VERSION=1.0.1
RUN pacman -S --noconfirm git make erlang gcc
RUN git clone --branch ${VERSION} https://github.com/erlio/vernemq.git /usr/local/src/vernemq
RUN cd /usr/local/src/vernemq && \
    make rel && \
    mv _build/default/rel/vernemq/ /usr/share/vernemq
RUN mkdir /etc/vernemq/
COPY vernemq.conf.j2 /etc/vernemq/vernemq.conf.j2
COPY entrypoint /sbin/entrypoint
RUN ln -sf /etc/vernemq/vernemq.conf /usr/share/vernemq/etc/vernemq.conf
ENTRYPOINT ["/sbin/entrypoint"]
